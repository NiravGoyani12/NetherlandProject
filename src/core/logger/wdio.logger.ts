import ansiStrip from 'strip-ansi';
import util from 'util';
import chalk from 'chalk';
import fs from 'fs';
import log, { LogLevelDesc } from 'loglevel';

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

export default function SetUpWdiologger(logfilePath : string, level: LogLevelDesc) {
  const webdriverIOLogger = log.getLoggers().webdriver;

  const originalFactory = webdriverIOLogger.methodFactory;
  logFile = null;

  webdriverIOLogger.setLevel(level || 'info');
  webdriverIOLogger.methodFactory = function (methodName, logLevel, loggerName) {
    const rawMethod = originalFactory(methodName, logLevel, loggerName);
    return (...args) => {
      if (!logFile) {
        logFile = fs.createWriteStream(logfilePath);
      }

      if (args && args[0]) {
        const match = Object.values(matches).filter((x) => String(args[0]).endsWith(`: ${x}`))[0];
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

        const logText = ansiStrip(`${new Date().toISOString()} ${methodName.toUpperCase()} ${loggerName}: ${util.format.apply(this, args)}\n`);

        if (logFile && logFile.writable) {
          if (logCache.size) {
            logCache.forEach((_log) => logFile.write(_log));
            logCache.clear();
          }

          return logFile.write(logText);
        }
        logCache.add(logText);
      }
      return rawMethod(...args);
    };
  };
}
