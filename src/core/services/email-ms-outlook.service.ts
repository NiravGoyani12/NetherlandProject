/* eslint-disable consistent-return */
import got from 'got';
import { Singleton } from 'typescript-ioc';
import fs from 'fs-extra';
import { GetTestLogger } from '../logger/test.logger';

@Singleton
export default class EmailMsOutLookService {
  private accessToken;

  private async getRefreshToken(valueToSearch: string) {
    let response = null;
    let payload = null;
    let fileName = null;
    if (valueToSearch.includes('GiftCard')) {
      fileName = '';
    } else {
      fileName = 'nl-email-ms-payload';
    }
    await this.fetchJsonData(`src/core/json/${fileName}.json`).then((jsonData) => {
      payload = jsonData;
    });
    try {
      response = await got.post<any>('https://login.microsoftonline.com/common/oauth2/v2.0/token', { form: payload, responseType: 'json' });
      if (response.body.errorMessage) {
        GetTestLogger().info(`login microsoft token post request had problems. Error message: ${response.body.errorMessage}. Status: ${response.statusCode}`);
      }
      this.accessToken = response.body.access_token;
      return this.accessToken;
    } catch (e) {
      throw new Error(`Error encountered for microsoft outlook get access_token key: ${e}`);
    }
  }

  public async getSubjectOutlook(valueToSearch: string) {
    await this.getRefreshToken(valueToSearch);
    const endpointUrl = 'https://graph.microsoft.com/v1.0/me/messages?';
    const query = `"subject: ${valueToSearch}"`;
    try {
      const client = got.extend({
        headers: {
          Authorization: `Bearer ${this.accessToken}`,
        },
      });
      const resp = await client.get<any>(`${endpointUrl}?$search=${query}`, { responseType: 'json' });
      if (resp.statusCode < 200 || resp.statusCode >= 300) {
        throw new Error(`Get microsoft outlook response request failed with status code ${resp.body}`);
      }
      if (resp.body === null || !resp.body) {
        throw new Error('Get microsoft outlook request failed due to null response body received');
      }
      return resp;
    } catch (e) {
      throw new Error(`Error encountered for get microsoft outlook email response: ${e}`);
    }
  }

  public async fetchJsonData(filePath: string) {
    const response = await fs.readJson(filePath);
    if (!response.refresh_token) {
      throw new Error(`Failed to fetch JSON data from ${filePath}`);
    }
    return response;
  }
}
