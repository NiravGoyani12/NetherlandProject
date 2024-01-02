/* eslint-disable no-console */
import {
  Status, Stage, ContentType,
} from 'allure-js-commons';
import { createHash } from 'crypto';
import got from 'got/dist/source';
import { defaultAppPort } from '../server/allure.server';

export interface CutsotomLables {
  [key: string]: RegExp[];
}

export function hash(data: string): string {
  return createHash('md5').update(data).digest('hex');
}

export function doesNotHaveValue(value: any): boolean {
  return value === null || value === undefined;
}

export function doesHaveValue(value: any): boolean {
  return !doesNotHaveValue(value);
}


const errHandler = (err) => {
  console.error(`!!!!! Allure Request failed => ${JSON.stringify(err)}`);
};

export default class AllureService {
  private appPort = process.env.AllureServerPort || defaultAppPort;

  private baseUrl = `http://localhost:${this.appPort}`;

  private client = got.extend({});

  public async writeGlobalInfo(info: Record<string, string>) {
    await this.client.post(`${this.baseUrl}/writeGlobalInfo`, { json: { info }, responseType: 'json' }).catch(errHandler);
  }

  public async startGroup(testCaseId: string): Promise<string | undefined> {
    const res = await this.client.post<{ uuid: string }>(`${this.baseUrl}/startGroup`, { json: { testCaseId }, responseType: 'json' }).catch(errHandler);
    return (res && res.body && res.body.uuid) ? res.body.uuid : undefined;
  }

  public async startTest(
    testCaseId: string, testCaseName: string, historyId: string, description: string,
  ): Promise<string | undefined> {
    const res = await this.client.post<{ uuid: string }>(`${this.baseUrl}/startTest`, {
      json: {
        testCaseId, testCaseName, historyId, description,
      },
      responseType: 'json',
    }).catch(errHandler);
    return (res && res.body && res.body.uuid) ? res.body.uuid : undefined;
  }

  public async testAddParameters(
    testCaseId: string, parameters: Array<{ name: string, value: string }>,
  ) {
    await this.client.post(`${this.baseUrl}/testAddParameters`, { json: { testCaseId, parameters }, responseType: 'json' }).catch(errHandler);
  }

  public async testAddLabel(testCaseId: string, labelName: string, labelValue: string) {
    await this.client.post(`${this.baseUrl}/testAddLabel`, { json: { testCaseId, labelName, labelValue }, responseType: 'json' }).catch(errHandler);
  }

  public async testAddLink(testCaseId: string, url: string, name: string, type?: string) {
    await this.client.post(`${this.baseUrl}/testAddLink`, {
      json: {
        testCaseId, url, name, type,
      },
      responseType: 'json',
    }).catch(errHandler);
  }

  public async groupStartBefore(testCaseId: string, testStepId: string, hookName: string) {
    await this.client.post(`${this.baseUrl}/groupStartBefore`, { json: { testCaseId, testStepId, hookName }, responseType: 'json' }).catch(errHandler);
  }

  public async groupStartAfter(testCaseId: string, testStepId: string, hookName: string) {
    await this.client.post(`${this.baseUrl}/groupStartAfter`, { json: { testCaseId, testStepId, hookName }, responseType: 'json' }).catch(errHandler);
  }

  public async startStep(testCaseId: string, testStepId: string, name: string) {
    await this.client.post(`${this.baseUrl}/startStep`, { json: { testCaseId, testStepId, name }, responseType: 'json' }).catch(errHandler);
  }

  public async stepAddAttchment(
    testStepId: string, name: string, content: string, contentType: ContentType,
  ) {
    await this.client.post(`${this.baseUrl}/stepAddAttchment`, {
      json: {
        testStepId, name, content, contentType,
      },
      responseType: 'json',
    }).catch(errHandler);
  }

  public async testAddAttchment(
    testCaseId: string, name: string, content: string, contentType: ContentType,
  ) {
    await this.client.post(`${this.baseUrl}/testAddAttchment`, {
      json: {
        testCaseId, name, content, contentType,
      },
      responseType: 'json',
    }).catch(errHandler);
  }

  public async testAddAttchmentBase64(
    testCaseId: string, name: string, base64: string, contentType: ContentType,
  ) {
    await this.client.post(`${this.baseUrl}/testAddAttchmentBase64`, {
      json: {
        testCaseId, name, base64, contentType,
      },
      responseType: 'json',
    }).catch(errHandler);
  }

  public async testAddAttchmentFilePath(testCaseId: string, name: string, filePath: string) {
    await this.client.post(`${this.baseUrl}/testAddAttchmentFilePath`, { json: { testCaseId, name, filePath }, responseType: 'json' }).catch(errHandler);
  }

  public async endStep(testStepId: string, stage: Stage, status: Status, message: string) {
    await this.client.post(`${this.baseUrl}/endStep`, {
      json: {
        testStepId, stage, status, message,
      },
      responseType: 'json',
    }).catch(errHandler);
  }

  public async endTest(
    testCaseId: string, stage: Stage, status: Status | undefined, message: string,
  ) {
    await this.client.post(`${this.baseUrl}/endTest`, {
      json: {
        testCaseId, stage, status, message,
      },
      responseType: 'json',
    }).catch(errHandler);
  }
}
