import 'mocha';
import { expect } from 'chai';
// eslint-disable-next-line import/no-extraneous-dependencies
import * as s from 'selenium-standalone';
import { promisify } from 'util';
import { options, timeout } from '../../utils/driver-data';
import DriverFactoryServer from '../../../src/core/server/driver-factory.server';
import DriverFactoryService, { PoolItem } from '../../../src/core/services/driver-factory.service';
import { SetUpSimpleTestLogger } from '../../../src/core/logger/test.logger';

process.env.DriverFactoryServerPort = (36060 + Math.floor(Math.random() * 100)).toString();

const seleniumPort = 4444 + Math.floor(Math.random() * 100);
const seleniumOptions = {
  seleniumArgs: ['-port', seleniumPort.toString()],
};

describe('Driver factory server', () => {
  before(() => {
    SetUpSimpleTestLogger();
  });

  const poolSize = 2;
  const maxTestCount = 1;
  const driverFactoryServer = new DriverFactoryServer(poolSize, maxTestCount);

  xit('should start server', async () => {
    const server = await driverFactoryServer.startServer();
    expect(server.port).to.be.at.least(36060);
  });

  xit('should close server', async () => {
    await driverFactoryServer.stopServer();
  });
});

describe('Driver Factory service when sesion dead', () => {
  const poolSize = 2;
  const maxTestCount = 50;
  const driverFactoryService = new DriverFactoryService();
  const driverFactoryServer = new DriverFactoryServer(poolSize, maxTestCount);

  before(async () => {
    await driverFactoryServer.startServer();
  });

  xit('should remove dead session when it is dead', async () => {
    const attchedDriverOptions = await driverFactoryService.takeDriver(options, timeout);
    expect(attchedDriverOptions).to.not.be.undefined;
    expect(attchedDriverOptions.sessionId).to.not.be.empty;
    let status: Array<PoolItem> = await driverFactoryService.status();
    expect(status).to.have.lengthOf(1);
    await new Promise((resolve) => setTimeout(resolve, 20 * 1000));
    await driverFactoryService.releaseDriver(attchedDriverOptions.sessionId);
    status = await driverFactoryService.status();
    expect(status).to.have.lengthOf(0);
  });

  after(async () => {
    await driverFactoryServer.stopServer();
  });
});

describe('Driver factory service Basic', () => {
  const poolSize = 2;
  const maxTestCount = 2;
  const driverFactoryService = new DriverFactoryService();
  const driverFactoryServer = new DriverFactoryServer(poolSize, maxTestCount);
  let process = null;
  let sessionOneId: string;

  before(async () => {
    await driverFactoryServer.startServer();
    await promisify(s.install)();
    const startSeleniumFunc = promisify(s.start) as any;
    process = await startSeleniumFunc(seleniumOptions);
    options.port = seleniumPort;
  });

  xit('should take driver session from empty pool', async () => {
    const attchedDriverOptions = await driverFactoryService.takeDriver(options, timeout);
    expect(attchedDriverOptions).to.not.be.undefined;
    expect(attchedDriverOptions.sessionId).to.not.be.empty;
    sessionOneId = attchedDriverOptions.sessionId;
    const status:Array<PoolItem> = await driverFactoryService.status();
    expect(status).to.have.lengthOf(1);
    expect(status[0].sessionId).to.equal(attchedDriverOptions.sessionId);
    expect(status[0].executedTest).to.equal(1);
    expect(status[0].isUsed).to.be.true;
  });

  xit('should release driver session but session not be deleted', async () => {
    await driverFactoryService.releaseDriver(sessionOneId);
    const status:Array<PoolItem> = await driverFactoryService.status();
    expect(status).to.have.lengthOf(1);
    expect(status[0].sessionId).to.equal(sessionOneId);
    expect(status[0].executedTest).to.equal(1);
    expect(status[0].isUsed).to.be.false;
  });

  xit('should take a unused session instead of creating new', async () => {
    const attchedDriverOptions = await driverFactoryService.takeDriver(options, timeout);
    expect(attchedDriverOptions).to.not.be.undefined;
    expect(attchedDriverOptions.sessionId).to.equal(sessionOneId);
    const status:Array<PoolItem> = await driverFactoryService.status();
    expect(status).to.have.lengthOf(1);
    expect(status[0].sessionId).to.equal(attchedDriverOptions.sessionId);
    expect(status[0].executedTest).to.equal(2);
    expect(status[0].isUsed).to.be.true;
  });

  xit('should delete session when executedTest = maxTestCount', async () => {
    await driverFactoryService.releaseDriver(sessionOneId);
    const status:Array<PoolItem> = await driverFactoryService.status();
    expect(status).to.have.lengthOf(0);
  });

  after(async () => {
    await driverFactoryServer.stopServer();
    if (process) {
      process.kill();
    }
  });
});

describe('Driver factory service with concurrent request', () => {
  const poolSize = 5;
  const maxTestCount = 1;
  const driverFactoryService = new DriverFactoryService();
  const driverFactoryServer = new DriverFactoryServer(poolSize, maxTestCount);
  let process = null;
  let optionsList: Array<WebDriver.AttachSessionOptions>;

  before(async () => {
    await driverFactoryServer.startServer();
    await promisify(s.install)();
    const startSeleniumFunc = promisify(s.start) as any;
    process = await startSeleniumFunc(seleniumOptions);
    options.port = seleniumPort;
  });

  xit('should create concurrent driver', async () => {
    optionsList = await Promise.all([
      driverFactoryService.takeDriver(options, timeout),
      driverFactoryService.takeDriver(options, timeout),
      driverFactoryService.takeDriver(options, timeout),
      driverFactoryService.takeDriver(options, timeout),
      driverFactoryService.takeDriver(options, timeout),
    ]);
    expect(optionsList).to.have.lengthOf(5);
    const status:Array<PoolItem> = await driverFactoryService.status();
    expect(status).to.have.lengthOf(5);
    for (let i = 0; i < 5; i += 1) {
      expect(status[i].sessionId).to.not.be.undefined;
      expect(status[i].executedTest).to.equal(1);
      expect(status[i].isUsed).to.be.true;
    }
  });

  xit('should return null when pool is full of busy driver', async () => {
    const attchedDriverOptions = await driverFactoryService.takeDriver(options, timeout);
    expect(attchedDriverOptions).to.be.undefined;
  });

  xit('should release concurrent driver', async () => {
    await Promise.all([
      driverFactoryService.releaseDriver(optionsList[0].sessionId),
      driverFactoryService.releaseDriver(optionsList[1].sessionId),
      driverFactoryService.releaseDriver(optionsList[2].sessionId),
      driverFactoryService.releaseDriver(optionsList[3].sessionId),
      driverFactoryService.releaseDriver(optionsList[4].sessionId),
    ]);
    const status:Array<PoolItem> = await driverFactoryService.status();
    expect(status).to.have.lengthOf(0);
  });

  after(async () => {
    await driverFactoryServer.stopServer();
    if (process) {
      process.kill();
    }
  });
});

describe('Driver factory service with idle session', () => {
  const poolSize = 2;
  const maxTestCount = 2;
  const driverFactoryService = new DriverFactoryService();
  const driverFactoryServer = new DriverFactoryServer(poolSize, maxTestCount, 5);
  let process = null;

  before(async () => {
    await driverFactoryServer.startServer();
    await promisify(s.install)();
    const startSeleniumFunc = promisify(s.start) as any;
    process = await startSeleniumFunc(seleniumOptions);
    options.port = seleniumPort;
  });

  xit('should turn off idle session after 5 seconds', async () => {
    const op1 = await driverFactoryService.takeDriver(options, timeout);
    await driverFactoryService.takeDriver(options, timeout);
    let status: Array<PoolItem> = await driverFactoryService.status();
    expect(status).to.have.lengthOf(2);
    await driverFactoryService.releaseDriver(op1.sessionId);
    status = await driverFactoryService.status();
    expect(status).to.have.lengthOf(2);
    await new Promise((resolve) => setTimeout(resolve, 10 * 1000));
    status = await driverFactoryService.status();
    expect(status).to.have.lengthOf(1);
  });

  after(async () => {
    await driverFactoryServer.stopServer();
    if (process) {
      process.kill();
    }
  });
});
