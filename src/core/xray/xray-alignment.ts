/* eslint-disable no-restricted-syntax */
/* eslint-disable no-await-in-loop */
/* eslint-disable max-len */
import fs from 'fs';
import got from 'got/dist/source';
import consoleLog from '../logger/console.logger';
import { testPlanMap } from './test-plan-map';

// #region Global variables
const auth = process.env.QA_ENV_JIRA_TOKEN;
const client = got.extend({
  headers: {
    Authorization: auth,
  },
});
const executionInfo = {};
const slackMessage: { attachments: any[] } = {
  attachments: [{
    pretext: `Not executed tests in test plans. ${new Date().toLocaleDateString()}`,
    fields: [{ title: 'Test plans', short: true }, { title: 'Not executed test cases', short: true }],
  }],
};
const devices = ['desktop', 'mobile'];
// #endregion

// #region Helpers
// get brands for current board
function getBrandInfo(board: string) {
  const brands = ['ck', 'th'];
  return brands.filter((brand) => testPlanMap[brand][board]
    && testPlanMap[brand][board].desktop
    && testPlanMap[brand][board].mobile);
}

// add required fields to executionInfo object
function prepareData(board: string, brands: string[]) {
  brands.forEach(async (brand) => {
    devices.forEach(async (device) => {
      if (!executionInfo[brand]) { executionInfo[brand] = {}; }
      if (!executionInfo[brand][board]) { executionInfo[brand][board] = {}; }
      if (!executionInfo[brand][board][device]) { executionInfo[brand][board][device] = {}; }
      if (!executionInfo[brand][board][device].id) { executionInfo[brand][board][device].id = testPlanMap[brand][board][device]; }
      if (!executionInfo[brand][board][device].execution) { executionInfo[brand][board][device].execution = []; }
      if (!executionInfo[brand][board][device].plan) { executionInfo[brand][board][device].plan = []; }
      if (!executionInfo[brand][board][device].notExecuted) { executionInfo[brand][board][device].notExecuted = []; }
      if (!executionInfo[brand][board][device].notPlanned) { executionInfo[brand][board][device].notPlanned = []; }
    });
  });
}

// fetch latest executed tests for a specific board
async function fetchLatestExecutedTests(board: string, brands: string[]) {
  for (const brand of brands) {
    for (const device of devices) {
      const jql = `type = "Test Execution" AND labels = ${device} AND labels = ${brand.toUpperCase()} AND labels = ${board} AND createdDate > -24h ORDER BY createdDate`;
      const query = `https://jira-eu.pvh.com/rest/api/2/search?jql=${jql}`;
      try {
        // get list of executions for specific device, brand, board
        const response = await client.get<any>(query, { responseType: 'json' });
        const executedTests: string[] = [];
        const { issues } = response.body;
        // featch all executed tests for every board
        issues.forEach((issue) => {
          issue.fields.customfield_10413.forEach((test) => {
            executedTests.push(test.b);
          });
        });
        // save unique jira test cases
        executionInfo[brand][board][device].execution = [...new Set(executedTests)];
      } catch (e) {
        consoleLog(`Fetching latest executed tests for board ${board}, brand ${brand}, device ${device} failed with code: ${e.response.statusCode}. Response body: ${JSON.stringify(e.response.body)}`);
      }
    }
  }
}

// fetch test cases attached to test plans on a specific board
async function fetchTestsFromTestPlans(board: string, brands: string[]) {
  for (const brand of brands) {
    for (const device of devices) {
      const query = `https://jira-eu.pvh.com/rest/api/2/issue/${testPlanMap[brand][board][device]}?fields=customfield_11208`;
      try {
        const response = await client.get<any>(query, { responseType: 'json' });
        const plannedTests: string[] = response.body.fields.customfield_11208;
        // save unique jira test cases
        executionInfo[brand][board][device].plan = [...new Set(plannedTests)];
      } catch (e) {
        consoleLog(`Fetching tests from test plan ${executionInfo[brand][board][device].id} for board ${board}, brand ${brand}, device ${device} failed with code: ${e.response.statusCode}. Response body: ${JSON.stringify(e.response.body)}`);
      }
    }
  }
}

// find not executed and not planned tests for every board, device, brand
function findDifference(board: string, brands: string[]) {
  for (const brand of brands) {
    for (const device of devices) {
      const { execution, plan } = executionInfo[brand][board][device];
      delete executionInfo[brand][board][device].execution; // cleanup data
      delete executionInfo[brand][board][device].plan; // cleanup data
      if (plan.length > 0 && execution.length > 0) {
        executionInfo[brand][board][device].notExecuted = plan.filter((x) => !execution.includes(x));
        executionInfo[brand][board][device].notPlanned = execution.filter((x) => !plan.includes(x));
      } else {
        consoleLog(`Exited comparing test plan ${executionInfo[brand][board][device].id} and executions for ${board}, brand: ${brand}, device: ${device}. No executed tests found`);
      }
    }
  }
}

// update test plans with executed but missing tests
async function updateTestPlans(board: string, brands: string[]) {
  for (const brand of brands) {
    for (const device of devices) {
      if (executionInfo[brand][board][device].notPlanned.length > 0) {
        const payload = {
          add: executionInfo[brand][board][device].notPlanned,
        };
        try {
          await client.post<any>(`https://jira-eu.pvh.com/rest/raven/1.0/api/testplan/${executionInfo[brand][board][device].id}/test`, { json: payload, responseType: 'json' });
          consoleLog(`${executionInfo[brand][board][device].id} - Successfully updated test plan. Added tests: ${executionInfo[brand][board][device].notPlanned}`);
        } catch (e) {
          consoleLog(`Updating test plan ${executionInfo[brand][board][device].id} for board ${board}, brand ${brand}, device ${device} failed with code: ${e.response.statusCode}. Response body: ${JSON.stringify(e.response.body)}`);
        }
      } else {
        consoleLog(`${executionInfo[brand][board][device].id} - Test plan does not have missing test cases`);
      }
    }
  }
}

// prepare slack message with not executed tests per test plan
function prepareSlackMessage(board: string, brands: string[]) {
  for (const brand of brands) {
    for (const device of devices) {
      if (executionInfo[brand][board][device].notExecuted.length > 0) {
        const formattedTestPlan = `<https://jira-eu.pvh.com/browse/${executionInfo[brand][board][device].id}|${brand.toUpperCase()} ${board} ${device} ${executionInfo[brand][board][device].id}>`;
        // TODO: currently slack message can not be parsed with >= 30 test cases because of string char limit
        const formattedTests = (executionInfo[brand][board][device].notExecuted.length <= 30)
          ? executionInfo[brand][board][device].notExecuted.map((test: string) => `<https://jira-eu.pvh.com/browse/${test}|${test}>`).join(', ')
          : `Parsing error, number of not executed test is too big. Max is 30, current is ${executionInfo[brand][board][device].notExecuted.length}`;
        slackMessage.attachments.push({
          color: executionInfo[brand][board][device].notExecuted.length > 4 ? '#FF0000' : 'f4b942',
          fields: [
            { value: formattedTestPlan, short: true },
            { value: formattedTests, short: true }],
        });
      } else {
        consoleLog(`${executionInfo[brand][board][device].id} - Test plan does not have not executed test cases`);
      }
    }
  }
}
// #endregion

async function compareExecutionWithPlans(board: string) {
  const brandInfo = getBrandInfo(board);
  if (brandInfo.length > 0) {
    prepareData(board, brandInfo);
    await fetchLatestExecutedTests(board, brandInfo);
    await fetchTestsFromTestPlans(board, brandInfo);
    findDifference(board, brandInfo);
    await updateTestPlans(board, brandInfo);
    prepareSlackMessage(board, brandInfo);
    fs.writeFileSync('./xray-slack.json', JSON.stringify(slackMessage));
    fs.writeFileSync('./xray-alignment.json', JSON.stringify(executionInfo));
  } else {
    consoleLog(`Skipped comparing test plans and executions for ${board}. No test plans associated with it found`);
  }
}

compareExecutionWithPlans('UnifiedExperience');
compareExecutionWithPlans('UnifiedCheckout');
compareExecutionWithPlans('UnifiedMyAccount');
