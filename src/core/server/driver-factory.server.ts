/* eslint-disable no-console */
import express from 'express';
import bodyParser from 'body-parser';
import { remote } from 'webdriverio';
import { Mutex } from 'async-mutex';
import * as http from 'http';
import * as scheduler from 'node-schedule';
import DriverFactoryPool, { DriverData } from './driver-factory-pool';
import consoleLog from '../logger/console.logger';

export const defaultAppPort = 36060;

export default class DriverFactoryServer {
  private readonly mutex;

  private readonly pool: DriverFactoryPool;

  private poolSize: number;

  private maxTestCount: number;

  private server: http.Server = null;

  private sessionIdleTimeInSec: number;

  private app: express.Application;

  private schduledJob: scheduler.Job;

  private appPort: number;

  constructor(poolSize: number, maxTestCount: number, sessionIdleTimeInSec: number = 5) {
    this.mutex = new Mutex();
    this.pool = new DriverFactoryPool();
    this.poolSize = poolSize;
    this.maxTestCount = maxTestCount;
    this.sessionIdleTimeInSec = sessionIdleTimeInSec;
    this.appPort = Number(process.env.DriverFactoryServerPort) || defaultAppPort;

    this.app = express()
      .use(bodyParser.json({ limit: '50MB' }))
      .post('/take', async (req, res) => {
        const driverData = await this.takeDriverFromPool(req.body.options, req.body.timeout);
        if (driverData) {
          return res.end(JSON.stringify(driverData));
        }
        return res.end();
      })
      .post('/release', async (req, res) => {
        await this.releaseDriverFromPool(req.body.sessionId);
        return res.end();
      })
      .get('/status', async (req, res) => {
        const status = await this.pool.getSummary();
        res.end(JSON.stringify(status));
      });
  }

  private async takeDriverFromPool(
    options: WebdriverIO.RemoteOptions, timeout: WebdriverIO.Timeouts,
  ): Promise<WebDriver.AttachSessionOptions | null> {
    const unusedDriver = await this.pool.getUnusedDriver();
    if (unusedDriver) {
      unusedDriver.isUsed = true;
      unusedDriver.executedTest += 1;
      unusedDriver.lastUsageTimestamp = Date.now();
      consoleLog(`= Take exist session : ${unusedDriver.driver.sessionId}`);
      return unusedDriver.options;
    } if ((await this.pool.getSize()) < this.poolSize) {
      consoleLog('+ Creating new session...');
      try {
        const { logLevel } = options;
        options.logLevel = 'silent';
        options.connectionRetryCount = 1;
        const driver = await remote(options);
        await driver.setTimeout(timeout);
        const attachedOptions = { ...driver.options } as WebDriver.AttachSessionOptions;
        attachedOptions.isW3C = driver.isW3C;
        attachedOptions.sessionId = driver.sessionId;
        attachedOptions.logLevel = logLevel;
        attachedOptions.connectionRetryCount = options.connectionRetryCount;
        const now = Date.now();
        await this.pool.set(attachedOptions.sessionId, {
          isUsed: true,
          driver,
          options: attachedOptions,
          startTimestamp: now,
          lastUsageTimestamp: now,
          executedTest: 1,
        });
        consoleLog(`+ Created new session : ${driver.sessionId}`);
        return attachedOptions;
      } catch (e) {
        consoleLog(`!!! [Driver Factory] create session failed: ${e}. Exiting test run...`);
        if (e.message.includes('Failed to create session') && !process.env.DriverName.includes('android')) {
          process.exit(3);
        } else {
          throw new Error(`[Driver Factory Error]: ${e}`);
        }
      }
    }
    return null;
  }

  private async releaseDriverFromPool(sessionId: string): Promise<void> {
    const driverData: DriverData = await this.pool.get(sessionId);
    if (driverData) {
      if (driverData.executedTest >= this.maxTestCount) {
        // If it reaches to maxTest count, then delete session and remove it from pool
        await driverData.driver.deleteSession().catch((e) => {
          consoleLog(`- Release session ${driverData.driver.sessionId} with warn : ${e}`);
        });
        await this.pool.delete(sessionId);
        consoleLog(`- Released dead session ${driverData.driver.sessionId}`);
      } else {
        driverData.lastUsageTimestamp = Date.now();
        consoleLog(`- Released session ${driverData.driver.sessionId}, lastUsageTimestamp=${driverData.lastUsageTimestamp}`);
        driverData.isUsed = false;
        await driverData.driver.getUrl().catch(async (e) => {
          consoleLog(`- The release session ${driverData.driver.sessionId} is already dead, will be removed and deleted from remote: ${e}`);
          await this.pool.delete(sessionId);
          await driverData.driver.deleteSession().catch((e2) => {
            consoleLog(`- Release an already dead session failed: ${driverData.driver.sessionId} with error : ${e2}`);
          });
        });
      }
    }
  }

  private async cleanUpDriverPool() {
    const poolSize = await this.pool.getSize();
    if (poolSize !== 0) {
      await this.pool.clearAllSession();
    }
  }

  private async cleanUpIdleDriver() {
    await this.pool.clearIdleDriver(this.sessionIdleTimeInSec);
  }

  public startServer(): Promise<{ port: number }> {
    return new Promise((resolve) => {
      this.appPort = Number(process.env.DriverFactoryServerPort) || defaultAppPort;
      this.server = this.app.listen(this.appPort, () => {
        consoleLog(`Driver factory server started at localhost:${this.appPort}`);
        consoleLog('Driver factory configuration:');
        consoleLog(`* Pool size: ${this.poolSize}`);
        consoleLog(`* Max test per session: ${this.maxTestCount}`);
        consoleLog(`* Session Idle timeout: ${this.sessionIdleTimeInSec} secs`);
        this.schduledJob = scheduler.scheduleJob('*/5 * * * * *', this.cleanUpIdleDriver.bind(this));
        resolve({
          port: this.appPort,
        });
      });
    });
  }

  public stopServer() {
    return new Promise<void>((resolve) => {
      if (this.schduledJob) {
        this.schduledJob.cancel();
      }
      if (this.server) {
        this.server.close(async () => {
          await this.cleanUpDriverPool();
          console.info(`Ended at localhost:${this.appPort}`);
          resolve();
        });
      }
    });
  }
}
