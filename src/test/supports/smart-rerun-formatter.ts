/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable no-restricted-syntax */
import _, { Dictionary } from 'lodash';
import path from 'path';
import { messages } from 'cucumber-messages';
import { Formatter } from '@pvhqa/cucumber';

enum Status {
  UNKNOWN = 0,
  PASSED = 1,
  SKIPPED = 2,
  PENDING = 3,
  UNDEFINED = 4,
  AMBIGUOUS = 5,
  FAILED = 6
}

function doesNotHaveValue(value: any): boolean {
  return value === null || value === undefined;
}

function doesHaveValue(value: any): boolean {
  return !doesNotHaveValue(value);
}

function valueOrDefault<T>(value: T, defaultValue: T): T {
  if (doesHaveValue(value)) {
    return value;
  }
  return defaultValue;
}

const DEFAULT_SEPARATOR = '\n';

interface UriToLinesMap {
  [uri: string]: number[]
}

export default class SmartRerunFormatter extends Formatter {
  private readonly separator: string;

  constructor(options: any) {
    super(options);
    options.eventBroadcaster.on('envelope', (envelope: messages.IEnvelope) => {
      if (doesHaveValue(envelope.testRunFinished)) {
        this.logFailedTestCases();
      }
    });
    const rerunOptions = valueOrDefault(options.parsedArgvOptions.rerun, {});
    this.separator = valueOrDefault(rerunOptions.separator, DEFAULT_SEPARATOR);
  }

  logFailedTestCases(): void {
    const that: any = this;
    const mapping: UriToLinesMap = {};
    _.each(
      that.eventDataCollector.getTestCaseAttempts(),
      ({ gherkinDocument, pickle, result }) => {
        if (!pickle.tags || (pickle.tags && pickle.tags.length > 0 && !pickle.tags.find((tag) => tag.name.indexOf('issue:') >= 0))) {
          if (result.status !== Status.PASSED) {
            const relativeUri = path.relative(that.cwd, pickle.uri);
            const { line } = this.getGherkinScenarioLocationMap(gherkinDocument)[
              _.last(pickle.astNodeIds)
            ];
            if (doesNotHaveValue(mapping[relativeUri])) {
              mapping[relativeUri] = [];
            }
            mapping[relativeUri].push(line);
          }
        }
      },
    );
    const text = _.chain(mapping)
      .map((lines, uri) => `${uri}:${lines.join(':')}`)
      .join(this.separator)
      .value();
    this.log(text);
  }

  private getGherkinScenarioLocationMap(
    gherkinDocument: messages.IGherkinDocument,
  ): Dictionary<messages.ILocation> {
    const map: Dictionary<messages.ILocation> = {};
    for (const child of gherkinDocument.feature.children) {
      if (doesHaveValue(child.scenario)) {
        map[child.scenario.id] = child.scenario.location;
        if (doesHaveValue(child.scenario.examples)) {
          for (const examples of child.scenario.examples) {
            for (const tableRow of examples.tableBody) {
              map[tableRow.id] = tableRow.location;
            }
          }
        }
      }
    }
    return map;
  }
}
