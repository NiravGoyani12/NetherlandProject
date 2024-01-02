import { BrowserObject } from 'webdriverio';
import { Mutex } from 'async-mutex';
import consoleLog from '../logger/console.logger';

export interface DriverData {
  isUsed: boolean
  driver: BrowserObject
  options: WebDriver.AttachSessionOptions
  startTimestamp: number
  lastUsageTimestamp: number
  executedTest: number
}

export default class DriverFactoryPool {
  private readonly pool: Map<string, DriverData>;

  private readonly mutex;

  constructor() {
    this.mutex = new Mutex();
    this.pool = new Map();
  }

  public async get(key: string) {
    const release = await this.mutex.acquire();
    let driverData: DriverData = null;
    try {
      driverData = this.pool.get(key);
    } finally {
      release();
    }
    return driverData;
  }

  public async set(key: string, driverData: DriverData) {
    const release = await this.mutex.acquire();
    try {
      this.pool.set(key, driverData);
    } finally {
      release();
    }
  }

  public async delete(key: string) {
    const release = await this.mutex.acquire();
    try {
      this.pool.delete(key);
    } finally {
      release();
    }
  }

  public async clearAllSession() {
    const release = await this.mutex.acquire();
    try {
      const commands = [...this.pool.values()].map(
        (driverData) => driverData.driver.deleteSession().catch((e) => {
          consoleLog(`Cleanup ${driverData.driver.sessionId} failed, ${e}`);
        }),
      );
      await Promise.all(commands);
      consoleLog(`${this.pool.size} sessions has been deleted and removed`);
    } finally {
      release();
    }
  }

  public async clearIdleDriver(sessionIdleTimeInSec: number) {
    const release = await this.mutex.acquire();
    const now = Date.now();
    const deleted = [];
    try {
      this.pool.forEach((driverData: DriverData, sessionId: string) => {
        if (!driverData.isUsed
          && now - driverData.lastUsageTimestamp > sessionIdleTimeInSec * 1000
        ) {
          driverData.driver.deleteSession().catch((e) => {
            consoleLog(`Clean up idle session ${driverData.driver.sessionId} with warn : ${e}`);
          });
          deleted.push(sessionId);
          consoleLog(`- Session ${sessionId} marked as idle (lastUsageTimestamp: ${driverData.lastUsageTimestamp},  now: ${now})`);
        }
      });
      deleted.forEach((sessionId) => {
        this.pool.delete(sessionId);
        consoleLog(`- idle session ${sessionId} has been deleted from pool`);
      });
    } finally {
      release();
    }
  }

  public async getUnusedDriver():Promise<DriverData> {
    const release = await this.mutex.acquire();
    let driver = null;
    try {
      driver = [...this.pool.values()].find((i) => !i.isUsed);
    } finally {
      release();
    }
    return driver;
  }

  public async getSize() {
    const release = await this.mutex.acquire();
    let size = 0;
    try {
      size = this.pool.size;
    } finally {
      release();
    }
    return size;
  }

  public async getSummary() {
    const release = await this.mutex.acquire();
    const status = [];
    try {
      this.pool.forEach((d) => {
        status.push({
          isUsed: d.isUsed,
          startTimestamp: d.startTimestamp,
          executedTest: d.executedTest,
          sessionId: d.driver.sessionId,
        });
      });
    } finally {
      release();
    }
    return status;
  }
}
