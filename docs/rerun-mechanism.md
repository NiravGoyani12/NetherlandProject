# Rerun mechanism
Our test automation framework has custom mechanism to rerun failed test casses before generating the report. Currently we have 3 types of rerun:
1. Immediate rerun inside test run
2. Immediate smart rerun inside test run
3. Custom rerun after test run

## How rerun works
Every test run generates list of failures and pushes it to rerun.txt file. Test cases which have @issue tag are not included in the rerun.txt file. When rerun is triggered, it picks up rerun.txt and runs all test cases from rerun.txt. After all test cases from rerun.txt are executed new rerun.txt file is generated with updated list of failures.
In case rerun.txt is empty, rerun won't be triggered and rerun will exit with success status.

### First and second rerun
Each type of rerun has 2 runs (first and second rerun). This is done to reduce the number of failed test cases due to network conditions, 3rd party dependancies etc. 
First rerun is triggered after main run in case rerun.txt is not empty. 
Second rerun is triggered after first rerun in case updated rerun.txt is not empty.

## Immediate rerun inside test run
This type of rerun will be executed directly after main run in case of not empty rerun.txt.
Allure report will be generated based on the results of the 2nd rerun.
The order is the following: Main run -> 1st rerun -> 2nd rerun
This type of rerun is enabled for most of nightly scheduled jobs.
For jenkins runner it's `disabled` by default, so allure report will be generated directly after main run.
If you want to enable immediate rerun from jenkins runner, set `immediateRerun` parameter to `enabled`

## Immediate smart rerun inside test run
This type of rerun is an extra validation for immediate rerun. It will check pass rate after main run. 
If the pass rate is more than threshold (currently set at 70%), then immediate rerun will be triggered. 
If pass rate is less than threshold, then immediate rerun will be skipped, allure generated directly after main run, and error slack message will be sent.
This type of rerun is enabled CK/TH desktop chrome and android night jobs.
For jenkins runner it's `disabled` by default, so pass rate after main run won't be validated, and immediate rerun will be triggered with any pass rate (in case immediate rerun is `enabled`)
If you want to enable smart rerun from jenkins runner, set `smartRerun` parameter to `enabled`
Please note: in order to enable smart rerun, `immediateRerun` should be also enabled.

## Custom rerun after test run
This type of rerun allows to rerun any finished test run. It's only possible to trigger this rerun from jenkins runner.
In parameters you need to select `rerunProjectName` that you want to rerun. In `rerunBuildNumber` you need to put build number of the job you want to rerun. 
This rerun will directly pick up rerun.txt from the build you have specified in parameters and execute only test cases from rerun.txt
Immediate rerun and smart rerun can be enabled for this rerun as well.