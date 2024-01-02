def generateXrayReport(String runTags, String envStr, String rerunProject, String rerunBuildNumber) {
	stage('X-ray Report') {
    withCredentials([string(credentialsId: 'CLIENT_ID', variable: 'QA_CLIENT_ID'), string(credentialsId: 'CLIENT_SECRET', variable: 'QA_CLIENT_SEC')]) {
      /* Generate json with executed scenarios */
      if (rerunProject && rerunBuildNumber) {
        try {
          sh "echo Generating json from rerun.txt"
          copyArtifacts(projectName: rerunProject, selector: specific(rerunBuildNumber), filter: 'rerun.txt')
          sh(script: '''
          set +e
          rm @execute.txt 2>/dev/null
          cp rerun.txt @execute.txt 2>/dev/null
          ''', returnStatus:true)
          sh "echo Successfully extracted build artifacts from job ${rerunProject}, build number ${rerunBuildNumber}"
          sh "${envStr} npx cucumber-js -p rerunxray @execute.txt"
        } catch (e) {
          sh "echo Failed to get build artifacts from job ${rerunProject}, build number ${rerunBuildNumber}"
        }
      } else {
          sh "${envStr} npx cucumber-js -p dryrunxray ${runTags}"
      }
      
      /* create json file with execution status for each tms tag */
      sh 'node build/core/xray/tms-report.js'

      /* Create test execution with results */
      sh "${envStr} node build/core/xray/xray-execution.js"
      
      archiveArtifacts 'xray-report.json'

      //temporary step
      archiveArtifacts 'tms-report.json'
      archiveArtifacts 'scenarios.json'

      // clean up workspace
      sh(script: '''
      set +e
      rm tms-report.json 2>/dev/null
      rm xray-report.json 2>/dev/null
      rm scenarios.json 2>/dev/null
      ''', returnStatus:true)
    }
  }
}

def generateXrayAlignmentReport(String webhookUrl) {
  stage('X-ray Alignment') {
     /* Generate json with differences between plan and executions */
    sh 'node build/core/xray/xray-alignment.js'

    // send slack
    sh "curl -X POST -H 'Content-type: application/json' -d @xray-slack.json ${webhookUrl}"

    archiveArtifacts 'xray-alignment.json'
    // clean up workspace
    sh 'rm xray-alignment.json 2>nul'
    sh 'rm xray-slack.json 2>nul'
  }
}

return this