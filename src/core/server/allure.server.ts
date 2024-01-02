/* eslint-disable no-console */

import express from 'express';
import bodyParser from 'body-parser';
import * as http from 'http';
import {
  AllureRuntime, AllureGroup, AllureTest, AllureStep, Status, Stage, ContentType,
} from 'allure-js-commons';
import fs from 'fs';

export const defaultAppPort = 38080;

export default class AllureServer {
  private app: express.Application;

  private server: http.Server = null;

  private allureRuntime: AllureRuntime;

  // TestCaseId => AllureGroup
  public testGroups: Map<string, AllureGroup>;

  // Allure Group Id => AllureTest
  public tests: Map<string, AllureTest>;

  // Allure test id => test name
  public testNames: Map<string, string>;

  // TestStepId => AllureStep
  public steps: Map<string, AllureStep>;

  private appPort: number;

  constructor() {
    this.appPort = Number(process.env.AllureServerPort) || defaultAppPort;
    this.allureRuntime = new AllureRuntime({ resultsDir: './allure-results' });
    this.testGroups = new Map();
    this.tests = new Map();
    this.testNames = new Map();
    this.steps = new Map();

    this.app = express()
      .use(bodyParser.json({ limit: '50MB' }))
      .post('/writeGlobalInfo', (req, res) => {
        this.writeGlobalInfo(req.body.info);
        return res.end();
      })
      .post('/startGroup', (req, res) => {
        const uuid = this.startGroup(req.body.testCaseId);
        res.end(JSON.stringify({ uuid }));
      })
      .post('/startTest', (req, res) => {
        const uuid = this.startTest(
          req.body.testCaseId, req.body.testCaseName, req.body.historyId, req.body.description,
        );
        res.end(JSON.stringify({ uuid }));
      })
      .post('/testAddParameters', (req, res) => {
        this.testAddParameters(req.body.testCaseId, req.body.parameters);
        return res.end();
      })
      .post('/testAddLabel', (req, res) => {
        this.testAddLabel(req.body.testCaseId, req.body.labelName, req.body.labelValue);
        return res.end();
      })
      .post('/testAddLink', (req, res) => {
        this.testAddLink(req.body.testCaseId, req.body.url, req.body.name, req.body.type);
        return res.end();
      })
      .post('/testAddAttchment', (req, res) => {
        this.testAddAttchment(
          req.body.testCaseId, req.body.name, req.body.content, req.body.contentType,
        );
        return res.end();
      })
      .post('/testAddAttchmentBase64', (req, res) => {
        this.testAddAttchmentBase64(
          req.body.testCaseId, req.body.name, req.body.base64, req.body.contentType,
        );
        return res.end();
      })
      .post('/testAddAttchmentFilePath', (req, res) => {
        this.testAddAttchmentFilePath(req.body.testCaseId, req.body.name, req.body.filePath);
        return res.end();
      })
      .post('/groupStartBefore', (req, res) => {
        this.groupStartBefore(req.body.testCaseId, req.body.testStepId, req.body.hookName);
        return res.end();
      })
      .post('/groupStartAfter', (req, res) => {
        this.groupStartAfter(req.body.testCaseId, req.body.testStepId, req.body.hookName);
        return res.end();
      })
      .post('/startStep', (req, res) => {
        this.startStep(req.body.testCaseId, req.body.testStepId, req.body.name);
        return res.end();
      })
      .post('/stepAddAttchment', (req, res) => {
        this.stepAddAttchment(
          req.body.testStepId, req.body.name, req.body.content, req.body.contentType,
        );
        return res.end();
      })
      .post('/endStep', (req, res) => {
        this.endStep(req.body.testStepId, req.body.stage, req.body.status, req.body.message);
        return res.end();
      })
      .post('/endTest', (req, res) => {
        this.endTest(req.body.testCaseId, req.body.stage, req.body.status, req.body.message);
        return res.end();
      });
  }

  private startGroup(testCaseId: string): string {
    const allureGroup = this.allureRuntime.startGroup();
    this.testGroups.set(testCaseId, allureGroup);
    // console.log(`Allure - start group ${allureGroup.uuid} by test ${testCaseId}`);
    return allureGroup.uuid;
  }

  private startTest(
    testCaseId: string, testCaseName: string, historyId: string, description: string,
  ) {
    const allureGroup = this.testGroups.get(testCaseId);
    const allureTest = allureGroup.startTest(testCaseName);
    allureTest.historyId = historyId;
    allureTest.description = description;
    this.tests.set(allureGroup.uuid, allureTest);
    this.testNames.set(allureGroup.uuid, testCaseName);
    return allureTest.uuid;
  }

  private groupStartBefore(testCaseId: string, testStepId: string, hookName: string) {
    const allureGroup = this.testGroups.get(testCaseId);
    const allureStep = allureGroup.addBefore().startStep(hookName);
    this.steps.set(testStepId, allureStep);
  }

  private groupStartAfter(testCaseId: string, testStepId: string, hookName: string) {
    const allureGroup = this.testGroups.get(testCaseId);
    const allureStep = allureGroup.addAfter().startStep(hookName);
    this.steps.set(testStepId, allureStep);
  }

  private testAddParameters(
    testCaseId: string, parameters: Array<{ name: string, value: string }>,
  ) {
    const allureGroup = this.testGroups.get(testCaseId);
    const allureTest = this.tests.get(allureGroup.uuid);
    parameters.forEach((parameter) => {
      allureTest.addParameter(parameter.name, parameter.value);
    });
  }

  private testAddLink(testCaseId: string, url: string, name: string, type?: string) {
    const allureGroup = this.testGroups.get(testCaseId);
    const allureTest = this.tests.get(allureGroup.uuid);
    allureTest.addLink(url, name, type);
  }

  private testAddLabel(testCaseId: string, labelName: string, labelValue: string) {
    const allureGroup = this.testGroups.get(testCaseId);
    const allureTest = this.tests.get(allureGroup.uuid);
    if (labelName === 'highlight') {
      const currentName = this.testNames.get(allureGroup.uuid);
      allureTest.name = `${labelValue} - ${currentName}`;
    } else {
      allureTest.addLabel(labelName, labelValue);
    }
  }

  private testAddAttchment(
    testCaseId: string, name: string, content: string, contentType: ContentType,
  ) {
    const allureGroup = this.testGroups.get(testCaseId);
    const allureTest = this.tests.get(allureGroup.uuid);
    const fileName = this.allureRuntime.writeAttachment(content, contentType);
    allureTest.addAttachment(name, contentType, fileName);
  }

  private testAddAttchmentBase64(
    testCaseId: string, name: string, base64: string, contentType: ContentType,
  ) {
    const allureGroup = this.testGroups.get(testCaseId);
    const allureTest = this.tests.get(allureGroup.uuid);
    const fileName = this.allureRuntime.writeAttachment(Buffer.from(base64, 'base64'), contentType);
    allureTest.addAttachment(name, contentType, fileName);
  }

  private testAddAttchmentFilePath(testCaseId: string, name: string, filePath: string) {
    if (fs.existsSync(filePath)) {
      const allureGroup = this.testGroups.get(testCaseId);
      if (!allureGroup) {
        console.error(`Allure - Failed to get group by testCaseId : ${testCaseId}`);
      }
      const allureTest = this.tests.get(allureGroup.uuid);
      const fileName = this.allureRuntime.writeAttachment(fs.readFileSync(filePath, 'utf-8'), ContentType.TEXT);
      allureTest.addAttachment(name, ContentType.TEXT, fileName);
    } else {
      console.error(`Allure Attachment failed because the file path is not exist ${filePath}`);
    }
  }

  private writeGlobalInfo(info: Record<string, string>) {
    this.allureRuntime.writeEnvironmentInfo(info);
  }

  public startStep(testCaseId: string, testStepId: string, name: string) {
    const allureGroup = this.testGroups.get(testCaseId);
    const allureTest = this.tests.get(allureGroup.uuid);
    const allureStep = allureTest.startStep(name);
    this.steps.set(testStepId, allureStep);
  }

  public stepAddAttchment(
    testStepId: string, name: string, content: string, contentType: ContentType,
  ) {
    const allureStep = this.steps.get(testStepId);
    const filetName = this.allureRuntime.writeAttachment(content, contentType);
    allureStep.addAttachment(name, contentType, filetName);
  }

  public endStep(testStepId: string, stage: Stage, status: Status | undefined, message: string) {
    const allureStep = this.steps.get(testStepId);
    allureStep.stage = stage;
    allureStep.status = status;
    allureStep.detailsMessage = message;
    allureStep.endStep();
    this.steps.delete(testStepId);
  }

  public endTest(testCaseId: string, stage: Stage, status: Status | undefined, message: string) {
    const allureGroup = this.testGroups.get(testCaseId);
    const allureTest = this.tests.get(allureGroup.uuid);
    allureTest.stage = stage;
    allureTest.status = status;
    allureTest.detailsMessage = message;
    allureTest.endTest();
    this.tests.delete(allureGroup.uuid);
    allureGroup.endGroup();
    // console.log(`Allure - END group ${allureGroup.uuid} by test ${testCaseId}`);
    this.testGroups.delete(testCaseId);
  }

  public startServer(): Promise<{ port: number }> {
    return new Promise((resolve) => {
      this.server = this.app.listen(this.appPort, () => {
        this.appPort = Number(process.env.AllureServerPort) || defaultAppPort;
        console.log(`Allure service started at localhost:${this.appPort}`);
        resolve({
          port: this.appPort,
        });
      });
    });
  }

  public stopServer() {
    return new Promise((resolve) => {
      if (this.server) {
        this.server.close(async () => {
          console.log(`Allure service ended at localhost:${this.appPort}`);
          resolve();
        });
      }
    });
  }
}
