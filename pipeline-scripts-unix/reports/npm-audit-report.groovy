def generateNpmAuditReport(String webhookUrl) {
	stage('NPM Audit Report') {
    
    /* generate output with audit summary and list of outdated packages */
    sh 'npm run audit-summary-slack'

    /* Create slack message with audit report */
    sh "npm run creare-audit-slack-message"

    /* send slack */
    sh "curl -X POST -H 'Content-type: application/json' -d @npm-audit-slack.json ${webhookUrl}"
    
    archiveArtifacts 'npm-audit-slack.json'

    /* clean up workspace */
    sh 'rm package-report-audit.txt 2>/dev/null'
    sh 'rm package-report-outdated.json 2>/dev/null'
  }
}

return this