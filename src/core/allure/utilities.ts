import { Stage, Status } from 'allure-js-commons';
import { createHash } from 'crypto';
import { messages } from 'cucumber-messages';

export function statusTextToAllure(status?: messages.TestResult.Status): Status {
  if (status === messages.TestResult.Status.PASSED) return Status.PASSED;
  if (status === messages.TestResult.Status.SKIPPED) return Status.SKIPPED;
  if (status === messages.TestResult.Status.FAILED) return Status.FAILED;
  return Status.BROKEN;
}

export function statusTextToStage(status?: messages.TestResult.Status): Stage {
  if (status === messages.TestResult.Status.PASSED) return Stage.FINISHED;
  if (status === messages.TestResult.Status.SKIPPED) return Stage.PENDING;
  if (status === messages.TestResult.Status.FAILED) return Stage.INTERRUPTED;
  return Stage.INTERRUPTED;
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
