/* eslint-disable no-console */
import got from 'got/dist/source';
import fs from 'fs';
import { GetTestLogger } from '../logger/test.logger';

const browserstackUrl = 'https://api.browserstack.com';
const httpTimeout = 5000;
const httpRetry = 5;
export default class BrowserstackService {
  private authToken = `Basic ${Buffer.from(`${process.env.BROWSERSTACK_USERNAME}:${process.env.BROWSERSTACK_KEY}`).toString('base64')}`;

  public async getSessionLogs(sessionId: String): Promise<string> {
    const client = got.extend({
      prefixUrl: browserstackUrl,
      headers: {
        Authorization: this.authToken,
      },
      timeout: httpTimeout,
      retry: httpRetry,
    });
    GetTestLogger().info(`Getting Session Logs for SessionId: ${sessionId}`);
    const res = await client.get<any>(`automate/sessions/${sessionId}/logs`).catch(this.errHandler);
    return (res && res.body) ? res.body as string : undefined;
  }

  public async setTestStatus(sessionId: String, status: String,
    reason: String): Promise<string> {
    const client = got.extend({
      prefixUrl: browserstackUrl,
      headers: {
        Authorization: this.authToken,
      },
      timeout: httpTimeout,
      retry: httpRetry,
    });
    GetTestLogger().info(`Logging Test Status for SessionId: ${sessionId} Status: ${status}, Reason: ${reason}`);
    const res = await client.put<any>(`automate/sessions/${sessionId}.json`, { json: { status, reason }, responseType: 'json' }).catch(this.errHandler);
    return (res && res.body) ? res.body : undefined;
  }

  public async writeLogFile(logFilePath: string, _log: string) {
    let logFile = null;

    if (!logFile) {
      logFile = fs.createWriteStream(logFilePath);
    }
    logFile.write(_log);
  }

  private errHandler = (err) => {
    GetTestLogger().info('Unable to get session logs:', err);
    console.warn(err);
    console.warn(err.statusCode, err.statusMessage, err.url, err.body);
  };
}
