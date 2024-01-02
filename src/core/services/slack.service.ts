/* eslint-disable no-console */
import got from 'got/dist/source';

const httpTimeout = 5000;
const httpRetry = 5;
export default class SlackService {
  // TODO: This is main channel
  // private mainChannelHook = 'https://hooks.slack.com/services/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';
  private mainChannelHook = 'https://hooks.slack.com/services/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';

  public async sendMessageToMainChannel(text: string): Promise<string> {
    const client = got.extend({
      timeout: httpTimeout,
      retry: httpRetry,
    });

    const res = await client.post<any>(this.mainChannelHook,
      { json: { text } }).catch(this.errHandler);

    return (res && res.body) ? res.body as string : undefined;
  }

  public async sendMessageToChannel(text: string, hookUrl: string): Promise<string> {
    const client = got.extend({
      timeout: httpTimeout,
      retry: httpRetry,
    });

    const res = await client.post<any>(hookUrl,
      { json: { text } }).catch(this.errHandler);

    return (res && res.body) ? res.body as string : undefined;
  }

  private errHandler = (err) => {
    console.warn(err);
  };
}
