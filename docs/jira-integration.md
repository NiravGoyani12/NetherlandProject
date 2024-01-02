# Jira + Xray integration

# Xray reporter

Xray integration is used as an additional layer of test result reporting.
It's being used as a separate stage in the CI process executed at the end of the pipeline. Currently it is only enabled for e2e runner.

## Summary

Xray report will create jira execution ticket(s), link it to relevant test plan, and attach all executed test cases with the latest status. The latest status of these test cases will be then updated in all places where the test case is used (stories, test plans, test sets, dashboards etc.) Xray test results can be used in testing and reporting on various levels:
1. Story level: status of all test cases attached to a story will be always kept up to date with the latest test run.
2. Test execution level: test execution ticket will contain all executed test cases for a specific product board. A test run might contain test cases from multiple products boards (e.g. @tms:EECK and @tms:EED). In this case multiple test execution tickets for a single test run will be created, and each individual execution ticket will contain an extract with relevant results for a specigic product board. Test execution ticket is a very similar concept to [custom slack reporters](../pipeline-scripts/reports/custom-reporter.groovy) but in different format
3. Test plan level: latest execution ticket will update the status in the test plan ticket of a specific board. This can be used for Gold build/Prod-stag sign-offs.
   
## Tech Flow

   **Framework part ([jenkins](../pipeline-scripts/reports/x-ray-report.groovy) and [tms-report](../src/core/xray/tms-report.ts))**

   1. Complete test run
   2. Dry run all executed scenarios and save to `scenarios.json` file
  * In case test run is using tags: initial tags will be used for the dry run.
  * In case test run is using rerun.txt from another job: rerun.txt from that job is used. 
   3. Extract unique tms tags from `scenarios.json` file with executed scenarios (`getTmsTags() in tms-report.ts`)
   4. Extract execution result for every executed scenario with tms tag from allure results (`getTmsResults() in tms-report.ts`)
   5. Create final report for every unique tms tag and split tms tags into different jira boards and save results to `tms-report.json` (`generateTmsReport() in tms-report.ts`)
   
   **[Jira part](../src/core/xray/xray-execution.ts)** 

   6. For every board with executed test cases from `tms-report.json` create new test execution ticket with allure link (`createTestExecution()`)
   7. Link created test execution ticket with [corresponding test plan](../src/core/xray/test-plan-map.ts) (`mapExecToTestPlan()`)
   8. Link all test cases for a specific board from `tms-report.json` to created test execution(`addTestsToExecution()`)
   9. Update status of all linked test cases using data from `tms-report.json` (`updateTestStatus()`)
   10. Move test execution ticket to done (`updateExecutionStatus`)
   11. Repeat steps 6-10 for every board which had test cases in a particular test run
   12. Save `xray-report.json` with test execution ticket for every board

## Extend the coverage

### Current supported on unified app boards like browse & search , Checkout and My Account:
 {``` 
 ck:{UTR_UnifiedExperience:{desktop:'UTR-17422',mobile:'UTR-17424',},
     UTR_UnifiedCheckout:{desktop:'UTR-17427',mobile:'UTR-17428',},
     UTR_PPL:{desktop:'UTR-14048',mobile:'UTR-14050',},
     },
 th:{UTR_UnifiedExperience:{desktop:'UTR-17400',mobile:'UTR-17423',},
     UTR_UnifiedCheckout:{desktop:'UTR-17425',mobile:'UTR-17426',},
     UTR_PPL:{desktop:'UTR-13621',mobile:'UTR-13622',},
   },
} 
```

### How to add new board
If there is a need to support xray reports for a new board, the new board should be added in a the code in a few places:
1. [Map with test plans for evey board](../src/core/xray/test-plan-map.ts) together with jira test-plans for desktop and mobile
2. `finalReport` in [tms-report.ts](../src/core/xray/tms-report.ts) should be extended with `newBoard` and `newBoard_analytics`
3. `tmsReport forEach loop` in [tms-report.ts](../src/core/xray/tms-report.ts) should be extended with the new board in the same way it's done for other boards
4. `jiraInfo` object in [xray-execution.ts](../src/core/xray/xray-execution.ts) should be extended with a new board
5. enable execution for the new board in [xray-execution.ts](../src/core/xray/xray-execution.ts) in the same way it's done for other boards
6. enable comparisson of the test execution and test plan in [xray-alignment.ts](../src/core/xray/xray-alignment.ts) in the same way it's done for other boards

### How to debug localy
If you need to add new functionality and test it, this is how to run localy:
1. You need to create your `sceanrios.json` file. FOr that you need command `Brand=ck DriverName=local-chrome Platform=desktop DefaultLocale=uk SpaDefaultLocale=fr SpaDefaultLangCode=default MultiLangDefaultLocale=ch MultiLangDefaultLangCode=FR npx cucumber-js -p dryrunxray --tags "@FullRegression and @Desktop and @Chrome"`. Brand can be TH or CK, and tags can also change, so that you can reduce the number of scenarios, and default locale and the rest can be anything it doesn't affect the report.
2. You will need a copy of `allure-results`. This has to be in the same folder as the framework.
3. Generate `tms-report.json` with command `node build/core/xray/tms-report.js`.
4. Generate `xray-execution.js` with command `node build/core/xray/xray-execution.js`.
5. Update jira bords by doing all the API calls with command `JOB_NAME=localrun BUILD_NUMBER=0000 QA_ENV_JIRA_TOKEN=<insert token here> Brand=ck DriverName=local-chrome Platform=desktop DefaultLocale=uk SpaDefaultLocale=fr SpaDefaultLangCode=default MultiLangDefaultLocale=ch MultiLangDefaultLangCode=FR node build/core/xray-execution/js`.

### Code

* [Jenkins pipeline script](../pipeline-scripts/reports/x-ray-report.groovy)

* [Map with test plans for evey board](../src/core/xray/test-plan-map.ts)

* [Prepare tms tags with test status for every jira board](../src/core/xray/tms-report.ts)

* [Script to create jira test execution with executed test cases](../src/core/xray/xray-execution.ts)

### Issues and further developement

1. Add affects/fix versions to test executions

## Automated monitoring of executed test cases : this is NA any more 

Due to the large number of test plans, jira boards and test cases, there is a weekly cronjob to align test executions and test plans. The cronjob is doing the following comparissons:
   1. Find executed test cases which are not mapped to the test plans -> the script will automatically add missing tests to the test plans
   2. Find not executed test cases mapped to the test plan -> the script will send a slack message, and the team should manually walk though those test cases and fix the issue.

### Code

* [Compare test plans and test executions](../src/core/xray/xray-alignment.ts)

### Jenkins

* [Jenkins file](../jenkins-files/common/xray-alignment-report.jenkinsfile)
* [Jenkins pipeline script](../pipeline-scripts/reports/x-ray-report.groovy)
* [Jenkins job](https://172.24.22.16/jenkins/view/pvh%20qa%20services/job/eCom_Xray_Alignment_Report/)

# Jira integration jobs

## Summary

Currently we have 2 CI cron jobs which are relying on connection with PVH jira. The purpose of these jobs is to extract known issues from the feature files (`@issue` tags), get up-to-date informarion (status, versions, issue type, created data) about corresponding jira tickets, and send a slack message.

### 1. Issue tags job [Jenkins link](https://172.24.22.16/jenkins/view/pvh%20qa%20services/job/eCom_Jira_Issue_Report/)

The job is sending a slack message to `ecom-automation-qa` channel with a list of all issues found in feature files for ck and th with the ticket status.
The purpose of the job is to keep issue tags updated in the framework and remore closed issues from the feature files.

* [Jenkins file](../jenkins-files/common/jira-issue-report.jenkinsfile)

### 2. Issue version job [Jenkins link](https://172.24.22.16/jenkins/view/pvh%20qa%20services/job/eCom_Jira_Versions_Report/)

The job is sending a slack message to `gold-build-and-prod-stag` channel with a list of all issues found in feature files for ck and th with without affects versions.
The purpose of the job is to keep all related jira tickets with a correct `affects version` so release dashboards contain detailed information.

* [Jenkins file](../jenkins-files/common/jira-versions-report.jenkinsfile)

## Tech flow

1. Dry run all features for ck and th and save output to json file (`generate-issue-report` in [package.json](../package.json))
2. Extract unique @issue tags from created json files (`getKnownIssues()` in [jira-issue-report.ts](../src/core/xray/jira-issue-report.ts)
3. Get data for every extracted issue for th and ck: status, versions, issue type, created data (`parseIssues()` in [jira-issue-report.ts](../src/core/xray/jira-issue-report.ts)
4. Create `known-issues.json` with the information about extracted ck and th issues (`createJson()` in [jira-issue-report.ts](../src/core/xray/jira-issue-report.ts)
5. Remove temporary output json files (`generate-issue-report` in [package.json](../package.json))
6. Create and send slack message
   * `generateIssueReport()` in [pipeline script](../pipeline-scripts/reports/jira-report.groovy) for issue tags job
   * `generateVersionIssueReport()` in [pipeline script](../pipeline-scripts/reports/jira-report.groovy) for issue version job

### Code

* [Jenkins pipeline script](../pipeline-scripts/reports/jira-report.groovy)

* [Code to get jira tickets info](../src/core/xray/jira-issue-report.ts)

### Schedule

Both cronjobs are scheduled daily from Monday to Friday. Documentation can be found [here](./reporter-schedule.md)

# Jira credentials

Jira credentials used for Xray reporter and jira jobs are set in Rackspace Windows Slave as environemnt variable `QA_ENV_JIRA_TOKEN`

