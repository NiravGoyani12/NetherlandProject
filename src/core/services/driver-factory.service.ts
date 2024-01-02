/* eslint-disable no-console */
import got from 'got/dist/source';
import { defaultAppPort } from '../server/driver-factory.server';

export interface PoolItem {
  isUsed: boolean
  sessionId: string
  startTimestamp: number
  executedTest: number
}

export default class DriverFactoryService {
  private appPort = process.env.DriverFactoryServerPort || defaultAppPort;

  private baseUrl = `http://localhost:${this.appPort}`;

  private client = got.extend({});

  public async takeDriver(
    options: WebdriverIO.RemoteOptions, timeout: WebdriverIO.Timeouts,
  ): Promise<WebDriver.AttachSessionOptions | undefined> {
    const res = await this.client.post(`${this.baseUrl}/take`, { json: { options, timeout }, responseType: 'json' }).catch(this.errHandler);
    return (res && res.body) ? res.body as WebDriver.AttachSessionOptions : undefined;
  }

  public async releaseDriver(sessionId: string) {
    const res = await this.client.post(`${this.baseUrl}/release`, { json: { sessionId }, responseType: 'json' }).catch(this.errHandler);
    return (res && res.body) ? res.body : undefined;
  }

  public async status(): Promise<Array<PoolItem>> {
    const res = await this.client.get(`${this.baseUrl}/status`, { responseType: 'json' }).catch(this.errHandler);
    return (res && res.body) ? res.body as Array<PoolItem> : undefined;
  }

  private errHandler = (err) => {
    console.warn(err.statusCode, err.statusMessage, err.url, err.body);
  };
}
