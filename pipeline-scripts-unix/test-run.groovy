def runIntegrationTest(String workers, String profile, String whereFilter, String envStr, Boolean enableMicroSoftTeamsReport, String microSoftTeamsWebhookUrl, Boolean enableEmailReport, Boolean enableRerun, Boolean enableSmartRerun, String reportPrefix, msTeams, email, Integer minutesToTimeout = 300, String emailRecipients = "QACommunity@pvh.com") {
    stage('E2E Test') {
        if (minutesToTimeout == 0) {
            minutesToTimeout = 300
        }
        timeout(time: minutesToTimeout, unit: 'MINUTES') {
            def jobName = "${JOB_NAME}"
            try {
                def mainChannelHook = 'https://pvhcorp.webhook.office.com/webhookb2/6e99a471-65a8-4b4e-b1f7-5e444e46b0cd@50ccd526-f6e9-4d12-8d35-391b59f63cd6/IncomingWebhook/da76bbd111b84a62acda2d7f85c97821/96bb192c-3d67-4d80-b882-92210a27dd48'
                def sessionCreationFailMsg = "Oops we stopped a test run because we could not create a session. *Build:*  https://10.34.14.54/job/${JOB_NAME}/${BUILD_NUMBER}"
                def testRunOne = sh(script: "${envStr} node ./build/runner.js -p ${profile} --parallel ${workers} ${whereFilter}", returnStatus: true)
              
                if (testRunOne != 3 && testRunOne != 0) {
                    if (enableRerun) {
                        def passThreshold = enableSmartRerun ? this.getThresholdRate(reportPrefix) : 0
                        def passRate = enableSmartRerun ? this.getPassRate() : 100
                        if (passRate >= passThreshold) {
                            String rerunContent = readFile 'rerun.txt'
                            if (rerunContent?.trim()) {
                                if (envStr.contains('remote-android')) {
                                    sh 'echo Waiting for 60 sec before 1st rerun'
                                    sleep 60
                                }
                                sh(script: '''
                                set +e
                                echo Starting 1st rerun inside the job
                                rm @execute.txt 2>/dev/null
                                cp rerun.txt @execute.txt 2>/dev/null
                                ''', returnStatus: true)
                                def testRunTwo = sh(script: "${envStr} node ./build/runner.js -p rerun --parallel ${workers} @execute.txt", returnStatus: true)
                                if (testRunTwo == 3) {
                                    msTeams.sendMessage(mainChannelHook, sessionCreationFailMsg)
                                    manager.build.@result = hudson.model.Result.FAILURE
                                } else if (testRunTwo == 0) {
                                    sh 'echo Exiting 2nd rerun - rerun.txt is empty'
                                    manager.build.@result = hudson.model.Result.SUCCESS
                                } else {
                                    if (envStr.contains('remote-android')) {
                                        sh 'echo Waiting for 60 sec before 2nd rerun'
                                        sleep 60
                                    }
                                    sh(script: '''
                                    set +e 
                                    echo Starting 2nd rerun inside the job
                                    rm @execute.txt 2>/dev/null
                                    cp rerun.txt @execute.txt 2>/dev/null
                                    ''', returnStatus: true)
                                    def testRunThree = sh(script: "${envStr} node ./build/runner.js -p rerun --parallel ${workers} @execute.txt", returnStatus: true)
                                    if (testRunThree == 3) {
                                        msTeams.sendMessage(mainChannelHook, sessionCreationFailMsg)
                                        manager.build.@result = hudson.model.Result.FAILURE
                                    } else if (testRunThree == 0) {
                                        manager.build.@result = hudson.model.Result.SUCCESS
                                    } else {
                                        manager.build.@result = hudson.model.Result.FAILURE
                                    }
                                }
                            } else {
                                sh 'echo Exiting 1st and 2nd rerun - rerun.txt is empty'
                                manager.build.@result = hudson.model.Result.SUCCESS
                            }
                        } else {
                            sh 'echo Exiting 1st and 2nd rerun - main run was unstable'
                            msTeams.sendEmergencyMessage(reportPrefix, passRate)
                            manager.build.@result = hudson.model.Result.FAILURE
                        }
                    } else {
                        manager.build.@result = hudson.model.Result.FAILURE
                    }
                } else if (testRunOne == 0) {
                    manager.build.@result = hudson.model.Result.SUCCESS
                } else {
                    msTeams.sendMessage(mainChannelHook, sessionCreationFailMsg)
                    manager.build.@result = hudson.model.Result.FAILURE
                }

                if (manager.build.@result == hudson.model.Result.UNSTABLE) {
                    manager.build.@result = hudson.model.Result.SUCCESS
                }
            } catch (org.jenkinsci.plugins.workflow.steps.FlowInterruptedException e) {
                def failureMessage = "Oops! warning: Warning! Build for *${JOB_NAME}* aborted because it exceeded ${minutesToTimeout} minutes build timeout. *For Details:*  <https://10.34.14.54/job/${JOB_NAME}/${BUILD_NUMBER}> :warning:"
                if(!jobName.contains('ecom-runner') || !jobName.contains('Test_Pipeline')) {
                    msTeams.sendMessage(microSoftTeamsWebhookUrl, failureMessage)
                }
            } catch (err) {
                echo 'Error occurred: ' + err
            }
            script {
                allure([
                includeProperties: false,
                jdk              : '',
                properties       : [],
                reportBuildPolicy: 'ALWAYS',
                results          : [[path: 'allure-results']]
            ])
                    }
            /* Delete build artifacts that might have left in the workspace */
            sh(script: '''
            set +e
            rm allure-results.zip 2>/dev/null
            ''', returnStatus: true)
            /* Create build artifacts for the current build */
            zip zipFile: 'allure-results.zip', archive: true, dir: 'allure-results'
            /* Archive build artifacts and attach to current build */
            archiveArtifacts 'allure-results.zip'
            archiveArtifacts 'rerun.txt'

            if(enableMicroSoftTeamsReport) {
                msTeams.sendMicroSoftTeamsReport(microSoftTeamsWebhookUrl, reportPrefix)
            }

            if (enableEmailReport && jobName.contains('ecom-runner')) {
                email.sendEmailWithRecipients(reportPrefix, emailRecipients)
            } else if (enableEmailReport && !jobName.contains('ecom-runner')) {
                email.sendEmail(reportPrefix)
            }
        }
    }
}

def getPassRate() {
    sh 'echo Calculating pass rate after main run ...'
    def allureResults = findFiles(glob: 'allure-results/*-result.json')
    def scenarios = 0
    def passScenarios = 0
    allureResults.each { result ->
        def resultJson = readJSON file: "${WORKSPACE}/allure-results/${result.name}"
        def status = resultJson['status']
        if (status == 'passed') {
            passScenarios += 1
        }
        scenarios += 1
    }
    def passRate = (passScenarios / scenarios * 100).intValue()
    sh "echo Pass rate after main run is ${passRate}%%"
    return passRate
}

def getThresholdRate(String reportPrefix) {
    sh 'echo getting Threshold rate based on job ...'
  // DB0 smartRerun threshold to be 50% and for other jobs still it's 70% 
                if (reportPrefix.contains("DB0")){
                     sh 'echo smartRerun with 50% threshold'
                    thresholdRate = 50
                 } else {
                    thresholdRate = 60
                     sh 'echo smartRerun with 60% threshold'
                }
    sh "echo Pass rate after main run is ${thresholdRate}%"
    return thresholdRate
}

return this
