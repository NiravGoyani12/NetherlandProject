# Build Timeout Mechanism

On Jenkins, it is possible to set a timeout for specific parts of the pipeline.

In this case, we have set the build timeout in the `pipeline-scripts/test-run.groovy` file.
This build timeout will only start counting down the duration for the actual test proper (including re-runs)

The groovy code looks like this (*see below*). By default, this is set and fixed to **minutes**, and we are unable to send parameters in other units of measurement for time.
Later development can be done to improve and add flexibility to unit of measurement.

```groovy
timeout(time: minutesToTimeout, unit: 'MINUTES') {
}
```

In the main jenkinsfile for each build, the minutes should be passed as a parameter. 

```groovy
Integer buildTimeoutMinutes = 2
testRunStates.runIntegrationTest(runner, 'prod', runTags, envStr, true, slackWebhookUrl, false, false, false, "CK Android Chrome Regression - ", slack, email, buildTimeoutMinutes)
```

If no build timeout is provided, the build timeout will default to **300 minutes or 5 hours**.

```groovy
// This will default to 300 minutes build timeout
testRunStates.runIntegrationTest(runner, 'prod', runTags, envStr, true, slackWebhookUrl, false, false, false, "CK Android Chrome Regression - ", msTeams, email)
```

If the build timeout is reached, the pipeline will still report results for the tests that have progressed during the test run. 
Naturally, this will mean that a portion of the tests will not be reported.

The slack notification (when build has exceeded timeout) will be sent to whichever slack channel is provided in the test run, just before the allure results are sent.

To know the timeout set for each build, please refer to: [CI Regression Schedule Plan](./docs/nightly-regression.md)