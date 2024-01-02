/* eslint-disable max-len */
/* eslint-disable no-inner-declarations */
/* eslint-disable no-restricted-syntax */
/* eslint-disable no-await-in-loop */
/* eslint-disable import/no-unresolved */
import fs from 'fs';
import got from 'got/dist/source';
import { GraphQLClient, gql } from 'graphql-request';
import consoleLog from '../logger/console.logger';
import { testPlanMap, envMap } from './test-plan-map';
import services from '../services';

const tmsReport = require('../../../tms-report.json');

// extract information about current jenkins job
const jobInfo = {
  jobName: process.env.JOB_NAME,
  buildNumber: process.env.BUILD_NUMBER,
  brand: services.env.Brand.toLowerCase(),
  device: services.env.Platform.toLowerCase(),
  env: envMap[services.env.Site.toLowerCase()],
};

const endpoint = 'https://xray.cloud.getxray.app/api/v2/graphql';
const getIssueUrl = 'https://pvhcorp.atlassian.net/rest/api/3/issue/';
let graphQLClient: GraphQLClient;
let testsEexcutionKeyId = null;
let valueInSummaryDetails = null;
const resultList = [];

const auth = process.env.QA_ENV_JIRA_BASIC;
const client = got.extend({
  headers: {
    Authorization: auth,
  },
});
const jiraInfo = {
  ck: {
    UTR_UnifiedExperience: {},
    UTR_UnifiedCheckout: {},
    UTR_PPL: {},
  },
  th: {
    UTR_UnifiedExperience: {},
    UTR_UnifiedCheckout: {},
    UTR_PPL: {},
  },
};

async function getAuthToken() {
  let response = null;
  const payload = {
    client_id: process.env.QA_CLIENT_ID,
    client_secret: process.env.QA_CLIENT_SEC,
  };
  const myClient = got.extend({
    headers: {
      'Content-Type': 'application/json',
    },
  });
  try {
    response = await myClient.post<any>('https://xray.cloud.getxray.app/api/v2/authenticate', { json: payload, responseType: 'json' });
    return response.body;
  } catch (e) {
    consoleLog(`Get Authentication Token Failed. Failed with code ${e.response.statusCode}. Response body: ${JSON.stringify(e.response.body)}`);
  }
  return response;
}

async function updatingTestsResultByImportingExecutionResults(payloadResults : string) {
  const MY_TOKEN = await getAuthToken();
  let response = null;
  const payload = JSON.parse(payloadResults);
  const myClient = got.extend({
    headers: {
      Authorization: `Bearer ${MY_TOKEN}`,
      'Content-Type': 'application/json',
    },
  });
  try {
    response = await myClient.post<any>('https://xray.cloud.getxray.app/api/v2/import/execution', { json: payload, responseType: 'json' });
    consoleLog(`Importing Tests Results from Tests Execution Successful. Status code : ${response.statusCode}`);
    return response.body;
  } catch (e) {
    consoleLog(`Importing Tests Results from Tests Execution Failed. Failed with code ${e.response.statusCode}. Response body: ${JSON.stringify(e.response.body)}`);
  }
  return response;
}

async function createGraphQLClient() {
  const MY_TOKEN = await getAuthToken();
  graphQLClient = new GraphQLClient(endpoint);
  graphQLClient.setHeader('authorization', `Bearer ${MY_TOKEN}`);
}

async function getIssueId(issueKey: string): Promise<string> {
  let id;
  try {
    const response = await client.get<any>(`${getIssueUrl}${issueKey}`, { responseType: 'json' });
    id = response.body.id;
  } catch (e) {
    consoleLog(`Get Issue ID for ${issueKey} Failed. Failed with code ${e.response.statusCode}. Response body: ${JSON.stringify(e.response.body)}`);
  }
  return id;
}

// async function getIssueKey(issueId: string): Promise<string> {
//   let key;
//   try {
//     const response = await client.get<any>(`${getIssueUrl}${issueId}`, { responseType: 'json' });
//     key = response.body.key;
//   } catch (e) {
//     consoleLog(`Get Issue ID for ${issueId} Failed. Failed with code ${e.response.statusCode}. Response body: ${JSON.stringify(e.response.body)}`);
//   }
//   return key;
// }

async function createTestExecution(board) {
  let valueInSummary = board;
  if (board.includes('UTR')) {
    valueInSummary = valueInSummary.replace('UTR_', '');
    valueInSummaryDetails = valueInSummary;
  }
  const query = gql`
    mutation {
      createTestExecution(
          testEnvironments: [\"${jobInfo.env}\"]
          jira: {
              fields: { summary: \"${valueInSummary} automated ${jobInfo.device} test execution on ${jobInfo.env}\", project: { key: \"${board.split('_')[0]}\" } }
          }
      ) {
          testExecution {
              jira(fields: ["key"])
          }
          warnings
          createdTestEnvironments
      }
    }
  `;
  try {
    await graphQLClient.request(query).then((response) => {
      consoleLog(JSON.stringify(response));
      jiraInfo[jobInfo.brand][board].execId = response.createTestExecution.testExecution.jira.key;
    });
    testsEexcutionKeyId = `${jiraInfo[jobInfo.brand][board].execId}`;
    consoleLog(`Test Execution created with key: ${jiraInfo[jobInfo.brand][board].execId}`);
  } catch (e) {
    consoleLog(`Creating test execution for board ${board}, brand ${jobInfo.brand}, device: ${jobInfo.device} failed with code ${e.response.statusCode}. Response body: ${JSON.stringify(e.response.body)}`);
    jiraInfo[jobInfo.brand][board].execId = undefined;
  }
}

async function mapExecToTestPlan(board) {
  const executionIssueId = await getIssueId(jiraInfo[jobInfo.brand][board].execId);
  const testPlanIssueId = await getIssueId(testPlanMap[jobInfo.brand][board][jobInfo.device]);
  const query = gql`
  mutation {
    addTestExecutionsToTestPlan(
        issueId: "${testPlanIssueId}",
        testExecIssueIds: ["${executionIssueId}"]
    ) {
        addedTestExecutions
        warning
    }
  }
  `;
  try {
    await graphQLClient.request(query).then((response) => {
      consoleLog(`Test Execution mapped to Test Plan with response: \n ${JSON.stringify(response)}`);
    });
  } catch (e) {
    consoleLog(`Mapping test execution to test plan ${testPlanMap[jobInfo.brand][board][jobInfo.device]} for board ${board}, brand ${jobInfo.brand}, device: ${jobInfo.device} failed with code ${e.response.statusCode}. Response body: ${JSON.stringify(e.response.body)}`);
  }
}

async function addTestsToExecution(board) {
  const testArray: String[] = [];
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  let internalStatus: string;
  for (const test of tmsReport[board]) {
    const realIssueId = await getIssueId(test.id);
    testArray.push(realIssueId);
    if (test.status === 'PASS') {
      internalStatus = 'PASSED';
    } else {
      internalStatus = 'FAILED';
    }
    const newObj = {
      testKey: test.id,
      comment: 'successful',
      status: internalStatus,
    };
    resultList.push(newObj);
  }
  const executionIssueId = await getIssueId(jiraInfo[jobInfo.brand][board].execId);
  const query = gql`
  mutation {
    addTestsToTestExecution(
        issueId: "${executionIssueId}",
        testIssueIds: ${JSON.stringify(testArray)}
    ) {
        addedTests
        warning
    }
  }
  `;
  try {
    await graphQLClient.request(query).then((response) => {
      consoleLog(`Tests Added to Test Execution with response: \n ${JSON.stringify(response)}`);
    });
  } catch (e) {
    consoleLog(`Adding test cases to test execution for board ${board}, brand ${jobInfo.brand}, device: ${jobInfo.device} failed with code ${e.response.statusCode}. Response body: ${JSON.stringify(e.response.body)}`);
  }
}

async function updateTestStatus() {
  if (resultList.length > 0) {
    const payLoad = {
      testExecutionKey: testsEexcutionKeyId,
      info: {
        project: 'UTR',
        summary: `${valueInSummaryDetails} automated ${jobInfo.device} test execution on ${jobInfo.env}`,
        description: 'Execution of automated tests using eCom-Automation',
      },
      tests: resultList,
    };
    updatingTestsResultByImportingExecutionResults(JSON.stringify(payLoad));
  }
}

async function execution(board) {
  if (tmsReport[board] && tmsReport[board].length > 0
    && testPlanMap[jobInfo.brand][board]
    && testPlanMap[jobInfo.brand][board][jobInfo.device]) {
    await createGraphQLClient();
    await createTestExecution(board);
    await mapExecToTestPlan(board);
    await addTestsToExecution(board);
    await updateTestStatus();
    // await updateExecutionStatus(board); To Future reference
    fs.writeFileSync('./xray-report.json', JSON.stringify(jiraInfo));
    consoleLog(`Successfully created execution for ${board}. https://pvhcorp.atlassian.net/browse/${jiraInfo[jobInfo.brand][board].execId}`);
  } else {
    consoleLog(`Skipped xray execution for ${board}. No test cases associated with it found`);
  }
}

execution('UTR_UnifiedExperience');
execution('UTR_UnifiedCheckout');
execution('UTR_PPL');

fs.writeFileSync('./xray-report.json', JSON.stringify(jiraInfo)); // create xray json in case all executions were skipped
