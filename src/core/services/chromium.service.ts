import got from 'got';

export interface ChromiumPayload {
  cmd: string
  params: {
    source: string
  }
}

export default class ChromiumService {
  /**
   * Send request directly to Chromium Dev Tools.
   * @param remoteServerUrl selenium/appium server url
   * @param sessionId webdriver session id
   * @param cmd cmd name
   * @param params params
   */
  public async sendRequest(
    remoteServerUrl: string, sessionId: string, cmd: string, params?: any,
  ):Promise<any> {
    const path = `wd/hub/session/${sessionId}/chromium/send_command_and_get_result`;
    const client = got.extend({
      prefixUrl: remoteServerUrl,
    });
    const resp = await client.post<any>(path, {
      json: {
        cmd,
        params,
      },
      responseType: 'json',
    });
    return resp;
  }
}
