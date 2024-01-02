def generateIssueJson() {
    stage('Generate Json') {
        sh(script: '''
        set +e
        [ ! -d "${WORKSPACE}/output" ] && mkdir -p ${WORKSPACE}/output
        npx cucumber-js features/ck --dry-run --format json:output/ck-all-features.json >/dev/null 
        npx cucumber-js features/th --dry-run --format json:output/th-all-features.json >/dev/null
        node build/core/xray/jira-issue-report.js
        rimraf ./output/*all-features.json
        ''', returnStatus: true)
    }
}

def generateIssueReport(String brand, String msTeamsWebhookUrl) {
    stage('Send Report') {
        def data = readJSON file: "${WORKSPACE}/output/known-issues.json"
        def issuesList = brand == 'CK' ? data['ckIssues'] : data['thIssues']
        def attachments = []
        def issuesInToDo = []
        def summary = "${brand} issues in the feature files. Total number of unique issues: ${issuesList.size()}"
        def header = """{
                        "pretext": "${summary}",
                        "fields": [
                            {"title": "Jira ticket","short": true},
                            {"title": "Status", "short": true}
                        ]
                    }""".stripMargin()
        attachments.add(header)
        issuesList.each {issue ->
            def formatedIssueName = String.format("<%s|%s>", "https://pvhcorp.atlassian.net/browse/${issue['id']}" , issue['id'])
            def issueName = "{\"value\": \"${formatedIssueName}\", \"short\": true}"
            def issueStatus = "{\"value\": \"${issue['status']}\", \"short\": true}"
            if((issue['status']).contains('To Do') || (issue['status']).contains('To refine') || (issue['status']).contains('Reopen') || (issue['status']).contains('Impeded')) {
                reportColor = "#36a64f"
            } else if((issue['status']).contains('Done') || (issue['status']).contains('Deploy Ready') || (issue['status']).contains('Closed')) {
                reportColor = "#FF0000"
            } else {
                reportColor = "#f4b942"
            }
            if (reportColor != "#36a64f") {
                def table = """{
                                |    "color": "${reportColor}",
                                |    "fields": [
                                |        ${issueName},
                                |        ${issueStatus}
                                |    ]
                                |}""".stripMargin()
                attachments.add(table)
            } else {
                issuesInToDo.add(formatedIssueName)
            }
        }
        def issuesInTodoChunks = issuesInToDo.collate(30)
        issuesInTodoChunks.each {chunk -> 
            def issuesInToDoStr = chunk.join(', ')
            issuesInToDoStr = """{
                |    "color": "#36a64f",
                |    "fields": [
                |        {\"value\": \"${issuesInToDoStr}\", \"short\": true},
                |        {\"value\": \"Tickets in To Do, To Refine, Reopen, Impeded\", \"short\": true}
                |    ]
                |}""".stripMargin()
            attachments.add(issuesInToDoStr)    
        }
        def attachmentsStr = attachments.join(',')
        def msTeamsMsg = """{
                        |  "attachments": [${attachmentsStr}]
                        |}""".stripMargin()
        writeFile(file: 'issueReport.json', text: msTeamsMsg)
        sh "curl -X POST -H 'Content-type: application/json' -d @issueReport.json ${msTeamsWebhookUrl}"
    }    
}

def generateVersionIssueReport(String brand, String slackWebhookUrl) {
    stage('Send Report') {
        def data = readJSON file: "${WORKSPACE}/output/known-issues.json"
        def issuesList = brand == 'CK' ? data['ckIssues'] : data['thIssues']
        def attachments = []
        def issueCount = 0
        def summary = "${brand} bugs in the feature files without affects version."
        def header = """{
                        "pretext": "${summary}",
                        "fields": [
                            {"title": "Jira ticket","short": true},
                            {"title": "Reported date", "short": true}
                        ]
                    }""".stripMargin()
        attachments.add(header)
        issuesList.each {issue ->
            if (issue['type'] == 'Bug' && (issue['version'] == 'No affected versions' || issue['version'] == 'N/A')) {
                def formatedIssueName = String.format("<%s|%s>", "https://pvhcorp.atlassian.net/browse/${issue['id']}" , issue['id'])
                def issueName = "{\"value\": \"${formatedIssueName}\", \"short\": true}"
                def issueDate = "{\"value\": \"${issue['createdDate']}\", \"short\": true}"
                def table = """{
                                |    "fields": [
                                |        ${issueName},
                                |        ${issueDate}
                                |    ]
                                |}""".stripMargin()
                attachments.add(table)
                issueCount += 1
            }
        }
        if (issueCount > 0) {
            def attachmentsStr = attachments.join(',')
            def msTeamsMsg = """{
                            |  "attachments": [${attachmentsStr}]
                            |}""".stripMargin()
            writeFile(file: 'issueVersionReport.json', text: msTeamsMsg)
            sh "curl -X POST -H 'Content-type: application/json' -d @issueVersionReport.json ${slackWebhookUrl}"
        } else {
            sh "echo No bugs without affects version found. Sending slack message was skipped."
        }
    }    
}

return this