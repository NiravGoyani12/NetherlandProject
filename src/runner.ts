/* eslint-disable no-console */
import portscanner from 'portscanner';
import AllureServer from './core/server/allure.server';
import DriverFactoryServer from './core/server/driver-factory.server';

/**
 * Setup server ports
 */
process.env.AllureServerPort = (38080 + Math.floor(Math.random() * 500)).toString();
process.env.DriverFactoryServerPort = (36060 + Math.floor(Math.random() * 500)).toString();

const driverPoolSize: number = Number(process.env.DriverPoolSize) || 16;
const sessionMaxTest: number = Number(process.env.SessionMaxTest) || 50;
const sessionIdleTimeInSec: number = Number(process.env.SessionIdleTimeout) || 5;

async function getServicePort(service: string = 'undefined', start: number = 38080, end = 38580): Promise<number> {
  const newPort = await portscanner.findAPortNotInUse(start, end, 'localhost');
  console.log(`Service Port for ${service} is now ${newPort}`);
  return newPort;
}

async function parallelRunner() {
  const cucumber = require('@pvhqa/cucumber');

  await getServicePort('Allure', Number(process.env.AllureServerPort), 38580).then((portNumber) => {
    process.env.AllureServerPort = portNumber.toString();
  });

  await getServicePort('DriverFactoryServerPort', Number(process.env.DriverFactoryServerPort), 36560).then((portNumber) => {
    process.env.DriverFactoryServerPort = portNumber.toString();
  });

  const poolServer = new DriverFactoryServer(driverPoolSize, sessionMaxTest, sessionIdleTimeInSec);
  const allureServer = process.env.NO_ALLURE === 'true' ? undefined : new AllureServer();

  const cwd = process.cwd();
  const cli = new cucumber.Cli({
    argv: process.argv,
    cwd,
    stdout: process.stdout,
  });

  let result;
  try {
    await poolServer.startServer();
    if (allureServer) {
      await allureServer.startServer();
    }
    result = await cli.run();
  } catch (error) {
    console.log('Parallel Runner encountered issue:');
    console.log(error);
  }

  if (poolServer) {
    if (allureServer) {
      await allureServer.stopServer();
    }
    await poolServer.stopServer();
  }

  const exitCode = result.success ? 0 : 1;
  if (result.shouldExitImmediately) {
    process.exit(exitCode);
  } else {
    process.exitCode = exitCode;
  }
}

parallelRunner();
