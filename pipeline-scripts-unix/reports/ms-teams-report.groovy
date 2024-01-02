def sendEmergencyMessage(String reportPrefix, int passRate) {
    reportPrefix = reportPrefix.substring(0, reportPrefix.length() - 3)
    String text = ":bangbang:<!here> Houston we have a problem. Last ${reportPrefix} could not rerun the failures. After main run the pass rate was ${passRate}%:bangbang:"
    def msTeamsMsg = """{
                    |  "text": "${text}"
                    |}""".stripMargin()
    writeFile(file: 'emergencyMessage.json', text: msTeamsMsg)
    sh "curl -X POST -H 'Content-type: application/json' -d @emergencyMessage.json https://hooks.slack.com/services/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"
    sh(script: '''
    set +e
    rm emergencyMessage.json
    ''', returnStatus: true)
}

def sendRunnersTaken(String webhookUrl, String runnersTaken, String platform, String driverName, String buildUrl) {
    String text = "Hey I Took ${runnersTaken} runners for ${platform} (using ${driverName}) Build# ${BUILD_NUMBER}: Follow the build here: ${buildUrl}${BUILD_NUMBER}"
    def msTeamsMsg = """{
                    |  "text": "${text}"
                    |}""".stripMargin()
    writeFile(file: 'takenMessage.json', text: msTeamsMsg)
    sh "curl -X POST -H 'Content-type: application/json' -d @takenMessage.json ${webhookUrl}"
    sh(script: '''
    set +e
    rm takenMessage.json
    ''', returnStatus: true)
}

def sendAllureReportLink(String webhookUrl, String buildUrl) {
    String text = "Build# ${BUILD_NUMBER} finished. Link to Allure Report here: ${buildUrl}${BUILD_NUMBER}/allure"
    def msTeamsMsg = """{
                    |  "text": "${text}"
                    |}""".stripMargin()
    writeFile(file: 'reportMessage.json', text: msTeamsMsg)
    sh "curl -X POST -H 'Content-type: application/json' -d @reportMessage.json ${webhookUrl}"
    sh(script: '''
    set +e
    rm reportMessage.json
    ''', returnStatus: true)
}

def sendMessage(String webhookUrl, String text) {
    def msTeamsMsg = """{
                    |  "text": "${text}"
                    |}""".stripMargin()
    writeFile(file: 'message.json', text: msTeamsMsg)
    sh "curl -X POST -H 'Content-type: application/json' -d @message.json ${webhookUrl}"
    sh(script: '''
    set +e
    rm message.json
    ''', returnStatus: true)
}

def sendMicroSoftTeamsReport(String webhookUrl, String reportPrefix) {
     def result = readJSON file: "${WORKSPACE}/allure-report/data/behaviors.json"
    def features = 0
    def failedFeatures = 0
    def scenarios = 0
    def failedScenarios = 0
    def featureMap = [:]
    def attachments = []
    def tolerance = 0.2
    result['children'].each { behavior ->
        features += 1
        def featureName = behavior['name']
        featureMap[featureName] = [:]
        featureMap[featureName]['total'] = 0
        featureMap[featureName]['failed'] = 0
        featureMap[featureName]['issues'] = []
        behavior['children'].each { test ->
            scenarios += 1
            if(test['status'] == 'failed' || test['status'] == 'broken') {
                featureMap[featureName]['failed'] += 1
                failedScenarios += 1
                // fetch defect number
                def testcase = readJSON file: "${WORKSPACE}/allure-report/data/test-cases/${test['uid']}.json"
                testcase['links'].each { issue ->
                    if ((issue['type']).contains('issue')) {
                        if (!(featureMap[featureName]['issues']).contains(String.format("[%s](%s)",issue['name'], issue['url']))) {
                            (featureMap[featureName]['issues']).push(String.format("[%s](%s)",issue['name'], issue['url']))
                        }
                    }
                }
            }
            featureMap[featureName]['total'] += 1
        }
    }

    def passedScenarios = scenarios - failedScenarios
    def passedRate = ((passedScenarios/scenarios)*100).intValue()
    def failedRate = 100 - passedRate
    def pvhReport = "https://10.34.14.54/job/${JOB_NAME}/${BUILD_NUMBER}/allure/#behaviors"
    def nonPvhReport = "https://3.68.253.40/job/${JOB_NAME}/${BUILD_NUMBER}/allure/#behaviors"
    def summary = "${reportPrefix}Features: ${features}, Scenarios: ${scenarios}, Passed Scenarios: ${passedScenarios} (${passedRate}%), Failed Scenarios: ${failedScenarios} (${failedRate}%), Build: ${BUILD_NUMBER}"
    def sections = """{
                    "type": "TextBlock",
                    "size": "Medium",
                    "text": "${summary}",
                    "weight": "Bolder",
                    "style": "heading",
                    "horizontalAlignment": "left",
                    "wrap": true,
                    "color": "Default",
                    "fontType": "Default"
                }""".stripMargin()
                featureMap = featureMap.sort()
    featureMap.each{ featureName, testResult ->
        if(testResult['total'] - testResult['failed'] == 0) {
            passPercentage = 0
        } else {
            passPercentage = ((testResult['total'] - testResult['failed'])/testResult['total']*100).intValue()
        }
        if (testResult['failed'] != 0) {
            def res =  String.format("%d%% (%d failed/%d)", passPercentage, testResult['failed'], testResult['total'])
            if (testResult['issues'])
                res = String.format("%s\n%s",res, (testResult['issues']).join(''))
            def featureNameField = "{\"value\": \"${featureName}\", \"short\": true}"
            def resultField = "{\"value\": \"${res}\", \"short\": true}"
            if(testResult['failed'] == 0) {
                reportColor = "#36a64f"
            } else if(testResult['failed'] == 0 && testResult['total'] == 0) {
                reportColor = "#FF0000"
            } else if(testResult['failed'] / testResult['total'] > tolerance) {
                reportColor = "#FF0000"
            } else {
                reportColor = "#f4b942"
            }
           def featuresList = """{
                                    "title": "${featureName}:",
                                     "value": "${res}"
                                 }"""
            attachments.add(featuresList)
            failedFeatures += 1
        }
    }
    if (failedFeatures == 0 ) {
        def successMessage = """{
                        |    "color": "#36a64f",
                        |    "fields": [
                        |        {\"value\": \"All features passed\", \"short\": true},
                        |        {\"value\": \"100%\", \"short\": true}
                        |    ]
                        |}""".stripMargin()
        attachments.add(successMessage)                
    }
     def actions = """{
                            "type": "Action.OpenUrl",
                            "title": "Pvh-Report",
                            "url": "${pvhReport}"
                            },
                            {
                            "type": "Action.OpenUrl",
                            "title": "Non-Pvh-Report",
                            "url": "${nonPvhReport}"
                            }""".stripMargin()
    def factsStr = attachments.join(',')
    def msTeamsMsg = """{
                       "type": "message",
                       "attachments": [
                        {
                        "contentType": "application/vnd.microsoft.card.adaptive",
                        "content": {
                    |  "body": [${sections},
                       {
                        "type": "ColumnSet",
                        "columns": [
                            {
                                "type": "Column",
                                "items": [
                                    {
                                        "type": "TextBlock",
                                        "weight": "Bolder",
                                        "text": "Features with Failures",
                                        "wrap": true,
                                        "spacing": "Medium",
                                        "horizontalAlignment": "Left",
                                        "isSubtle": true
                                    }
                                ],
                                "width": "auto"
                            },
                            {
                                "type": "Column",
                                "items": [
                                    {
                                        "type": "TextBlock",
                                        "weight": "Bolder",
                                        "text": "Percentage %",
                                        "wrap": true,
                                        "horizontalAlignment": "Left",
                                        "isSubtle": true
                                    }
                                ],
                                "width": "stretch"
                            }
                        ]
                        },
                        {
                                "type": "FactSet",
                                "facts": [${factsStr}
                                    ]
                                    }
                        ],
                
                    |  "actions": [${actions}],
                     "msteams": {
                                "width": "Full"
                         }
                    }
                    }
                    ]
                    |}""".stripMargin()
    sh(script: '''
    set +e
    rm report.json
    ''', returnStatus: true)
    def textMessage = "'{\"text\": \"${reportPrefix}\"}'"
    def textMessageFormat = "${textMessage}"
    writeFile(file: 'report.json', text: msTeamsMsg)
    sh "curl -X POST -H 'Content-type: application/json' -d @report.json ${webhookUrl}"
    sh(script: '''
    set +e
    rm report.json
    ''', returnStatus: true)
}

return this