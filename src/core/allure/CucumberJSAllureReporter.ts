/* eslint-disable max-classes-per-file */
import {
  Formatter,
  TestCaseHookDefinition,
} from '@pvhqa/cucumber';
import { messages } from 'cucumber-messages';
import {
  LabelName, ContentType,
} from 'allure-js-commons';
import PQueue from 'p-queue';
import {
  hash,
  doesHaveValue,
  statusTextToAllure,
  statusTextToStage,
} from './utilities';
import AllureService from '../services/allure.service';

export class CucumberJSAllureFormatterConfig {
  labels?: {
    [key: string]: RegExp[];
  };

  exceptionFormatter?: (message: string) => string;
}

export class CucumberJSAllureFormatter extends Formatter {
  private queueMap: Map<string, PQueue>;

  private allureService = new AllureService();

  private readonly labels: { [key: string]: RegExp[]; };

  private readonly exceptionFormatter: (message: string) => string;

  private readonly beforeHooks: TestCaseHookDefinition[];

  private readonly afterHooks: TestCaseHookDefinition[];

  constructor(options: any,
    config: CucumberJSAllureFormatterConfig) {
    super(options);
    this.queueMap = new Map();

    options.eventBroadcaster
      .on('envelope', this.parseEnvelope.bind(this));

    this.labels = config.labels || {};
    this.exceptionFormatter = function (message) {
      if (config.exceptionFormatter !== undefined) {
        try {
          return config.exceptionFormatter(message);
        } catch (e) {
          // eslint-disable-next-line no-console
          console.warn(`Error in exceptionFormatter: ${e}`);
        }
      }
      return message;
    };

    this.beforeHooks = options.supportCodeLibrary.beforeTestCaseHookDefinitions;
    this.afterHooks = options.supportCodeLibrary.afterTestCaseHookDefinitions;
  }

  parseEnvelope(envelope: messages.IEnvelope) {
    if (doesHaveValue(envelope.testCaseStarted)) {
      this.queueMap.set(envelope.testCaseStarted.id, new PQueue({ concurrency: 1 }));
      this.queueMap.get(envelope.testCaseStarted.id).add(async () => {
        await this.onTestCaseStarted(envelope.testCaseStarted);
      });
    } else if (doesHaveValue(envelope.testStepStarted)) {
      this.queueMap.get(envelope.testStepStarted.testCaseStartedId).add(async () => {
        await this.onTestStepStarted(envelope.testStepStarted);
      });
    } else if (doesHaveValue(envelope.testStepFinished)) {
      this.queueMap.get(envelope.testStepFinished.testCaseStartedId).add(async () => {
        await this.onTestStepFinished(envelope.testStepFinished);
      });
    } else if (doesHaveValue(envelope.testCaseFinished)) {
      this.queueMap.get(envelope.testCaseFinished.testCaseStartedId).add(async () => {
        await this.onTestCaseFinished(envelope.testCaseFinished);
      });
    }
  }

  async onTestCaseStarted(data: messages.ITestCaseStarted) {
    const that: any = this;
    // Extract Test Data
    const testCaseAttempt = that.eventDataCollector.getTestCaseAttempt(data.id);
    const pickleAsdNodeIds = testCaseAttempt.pickle.astNodeIds;

    // Extract Basic test info
    const featureName = testCaseAttempt.gherkinDocument.feature.name;
    const featureTags = testCaseAttempt.gherkinDocument.feature.tags;
    const testName = testCaseAttempt.pickle.name;
    const testTags = testCaseAttempt.pickle.tags;
    let exampleRow: Array<{ key: string, value: string }> = null;
    const parameters = new Array<{ name: string, value: string }>();
    if (pickleAsdNodeIds.length === 2) {
      const scenarioAsdNodeId = pickleAsdNodeIds[0];
      const exampleRowAsNodeId = pickleAsdNodeIds[1];
      exampleRow = this.getExampleRowInfo(
        testCaseAttempt.gherkinDocument, scenarioAsdNodeId, exampleRowAsNodeId,
      );
      if (doesHaveValue(exampleRow)) {
        exampleRow.forEach((prop) => parameters.push({
          name: prop.key,
          value: prop.value,
        }));
      }
    }
    const historyId = hash(JSON.stringify({
      f: featureName,
      t: testName,
      a: exampleRow,
    }));

    // Init Allure Data
    await this.allureService.startGroup(data.id);
    await this.allureService.startTest(data.id, testName || 'Unnamed test', historyId, featureName);

    if (parameters && parameters.length > 0) {
      await this.allureService.testAddParameters(data.id, parameters);
    }


    // Update test info
    if (data.platform.cpu !== '-1') {
      await this.allureService.testAddLabel(data.id, LabelName.THREAD, data.platform.cpu);
    }
    await this.allureService.testAddLabel(data.id, LabelName.FEATURE, featureName);

    [...(testTags || []), ...featureTags].forEach(async (tag) => {
      await this.allureService.testAddLabel(data.id, LabelName.TAG, tag.name);
      const cmdList = [];
      // eslint-disable-next-line no-restricted-syntax
      for (const label in this.labels) {
        // eslint-disable-next-line no-prototype-builtins
        if (this.labels.hasOwnProperty(label)) {
          // eslint-disable-next-line no-restricted-syntax
          for (const reg of this.labels[label]) {
            const match = tag.name.match(reg);
            if (match != null && match.length > 1) {
              // Convert given tags to link
              cmdList.push(this.allureService.testAddLink(data.id, `https://pvhcorp.atlassian.net/browse/${match[1]}`, match[1], label));
            }
          }
        }
      }
      await Promise.all(cmdList);
    });
  }

  async onTestStepStarted(data: messages.ITestStepStarted) {
    const that: any = this;

    // Extract Test Data
    const testCaseAttempt = that.eventDataCollector.getTestCaseAttempt(data.testCaseStartedId);
    const testStep = testCaseAttempt.testCase.testSteps.find((s) => s.id === data.testStepId);

    const beforeHook = testStep.hookId
      && testStep.pickleStepId === ''
      ? this.beforeHooks.find((h) => h.id === testStep.hookId) : undefined;

    const afterHOOK = testStep.hookId
      && testStep.pickleStepId === ''
      ? this.afterHooks.find((h) => h.id === testStep.hookId) : undefined;

    const step = testCaseAttempt.pickle.steps.find((s) => s.id === testStep.pickleStepId);

    if (beforeHook) {
      await this.allureService.groupStartBefore(data.testCaseStartedId, data.testStepId, beforeHook.code.name || 'Before');
    } else if (afterHOOK) {
      await this.allureService.groupStartAfter(data.testCaseStartedId, data.testStepId, afterHOOK.code.name || 'After');
    } else {
      await this.allureService.startStep(data.testCaseStartedId, data.testStepId, step.text);
      if (doesHaveValue(step.argument)) {
        if (doesHaveValue(step.argument.docString)) {
          await this.allureService.stepAddAttchment(data.testStepId, 'Text', step.argument.docString.content, ContentType.TEXT);
        }
        if (doesHaveValue(step.argument.dataTable)) {
          const tableContent = step.argument.dataTable.rows.map(
            (row) => row.cells.map(
              (cell) => cell.value.replace(/\t/g, '    '),
            ).join('\t'),
          ).join('\n');
          await this.allureService.stepAddAttchment(data.testStepId, 'Table', tableContent, ContentType.TSV);
        }
      }
    }
  }

  async onTestStepFinished(data: messages.ITestStepFinished) {
    await this.allureService.endStep(
      data.testStepId,
      statusTextToStage(data.testResult.status),
      statusTextToAllure(data.testResult.status),
      data.testResult.message,
    );
  }

  async onTestCaseFinished(data: messages.ITestCaseFinished) {
    await this.allureService.endTest(
      data.testCaseStartedId,
      statusTextToStage(data.testResult.status),
      statusTextToAllure(data.testResult.status),
      data.testResult.message,
    );
  }

  private getExampleRowInfo(
    gherkinDocument: messages.IGherkinDocument,
    scenarioAsdNodeId: string,
    exampleRowTableBodyAsdNodeId: string,
  ) : (Array<{ key: string, value: string }> | null) {
    const child = gherkinDocument.feature.children.find(
      (c) => c.scenario && c.scenario.id === scenarioAsdNodeId,
    );
    if (child) {
      for (let exampleIndex = 0; exampleIndex < child.scenario.examples.length; exampleIndex += 1) {
        const example = child.scenario.examples[exampleIndex];
        const row = example.tableBody.find((tr) => tr.id === exampleRowTableBodyAsdNodeId);
        if (row) {
          const info = [];
          const header = example.tableHeader;
          for (let i = 0; i < header.cells.length; i += 1) {
            info.push({ key: header.cells[i].value, value: row.cells[i].value });
          }
          return info;
        }
      }
    }
    return null;
  }
}
