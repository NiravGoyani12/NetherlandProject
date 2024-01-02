import ansiStrip from 'strip-ansi';
import log, { LogLevelDesc, Logger } from 'loglevel';
import fs from 'fs';
import util from 'util';

import chalk = require('chalk');

const testLoggerName = 'test';
const SERIALIZERS = [{
  /**
     * display error stack
     */
  matches: (err) => err instanceof Error,
  serialize: (err) => err.stack,
}, {
  /**
     * color commands blue
     */
  matches: (_log) => _log === 'COMMAND',
  serialize: (_log) => chalk.magenta(_log),
}, {
  /**
     * color data yellow
     */
  matches: (_log) => _log === 'DATA',
  serialize: (_log) => chalk.yellow(_log),
}, {
  /**
     * color result cyan
     */
  matches: (_log) => _log === 'RESULT',
  serialize: (_log) => chalk.cyan(_log),
}];

const matches = {
  COMMAND: 'COMMAND',
  DATA: 'DATA',
  RESULT: 'RESULT',
};

let logFile = null;
const logCache = new Set();
let testLogger:Logger = null;
export function SetUpTestlogger(logfilePath : string, level: LogLevelDesc) {
  testLogger = log.getLogger(testLoggerName);

  const originalFactory = testLogger.methodFactory;
  logFile = null;

  testLogger.methodFactory = function (methodName, logLevel, loggerName) {
    const rawMethod = originalFactory(methodName, logLevel, loggerName);
    return (...args) => {
      if (!logFile) {
        logFile = fs.createWriteStream(logfilePath);
      }

      const match = Object.values(matches).filter((x) => args[0].endsWith(`: ${x}`))[0];
      if (match) {
        const prefixStr = args.shift().slice(0, -match.length - 1);
        args.unshift(prefixStr, match);
      }

      args = args.map((arg) => {
        const serializer = SERIALIZERS.find((s) => s.matches(arg));
        if (serializer) {
          return serializer.serialize(arg);
        }
        return arg;
      });

      const loggerNameStr: string = loggerName as string;

      const logText = ansiStrip(`${new Date().toISOString()} ${methodName.toUpperCase()} ${loggerNameStr}: ${util.format.apply(this, args)}\n`);

      if (logFile && logFile.writable) {
        if (logCache.size) {
          logCache.forEach((_log) => logFile.write(_log));
          logCache.clear();
        }

        return logFile.write(logText);
      }
      logCache.add(logText);
      return rawMethod(...args);
    };
  };
  testLogger.setLevel(level || 'info');
}

export function SetUpSimpleTestLogger() {
  testLogger = log.getLogger(testLoggerName);
  testLogger.setLevel('info');
}

export function GetTestLogger() {
  if (!testLogger) {
    throw new Error('Test logger have not been initilised');
  }
  return testLogger;
}
