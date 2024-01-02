def generateCustomReport(List<String> baselineReports, List<String> tagsToInclude, Boolean enableMicroSoftTeamsReport, Boolean enableEmailReport, String microSoftTeamsWebhookUrl,String reportPrefix, msTeams, email) {
    stage('Custom reporter') {
        baselineReports.each { baselineReport -> 
            try {
                copyArtifacts(projectName: baselineReport, selector: lastCompleted(), filter: 'allure-results.zip')
                unzip zipFile: 'allure-results.zip', dir: 'allure-results'
                sh(script: '''
                set +e
                rm allure-results.zip >/dev/null
                ''', returnStatus: true)
                sh "echo Successfully extracted build artifacts from latest ${baselineReport}"
            } catch (err) {
                sh "echo There was a problem copying from ${baselineReport}. Skipping..."
                sh "echo ${err}"
            }
        }
        sleep 30
        def allureResults = findFiles(glob: "allure-results/*-result.json")
        def filesToDelete = []
        allureResults.each {result -> 
            def resultJson = readJSON file: "${WORKSPACE}/allure-results/${result.name}"
            def tagCounter = 0
            tagsToInclude.each { tag -> 
                def labels = resultJson['labels']
                def index =  labels.findIndexOf { it.value == tag }
                if (index >= 0) {
                    tagCounter += 1
                }
            }
            if (tagCounter != tagsToInclude.size()) {
                filesToDelete.push("allure-results/${result.name}")
            }
        }
        def filesToDeleteChunks = filesToDelete.collate(100)
        filesToDeleteChunks.each { chunk ->
            def chunkToDelete = chunk.join(' ')
            sh "rm ${chunkToDelete}"
        }
        sh "echo Successfully filtered allure results"
        script {
            	allure([
                    includeProperties: false,
                    jdk              : '',
                    properties       : [],
                    reportBuildPolicy: 'ALWAYS',
                    results          : [[path: 'allure-results']]
                ])
            }
            
        if(enableMicroSoftTeamsReport) {
            msTeams.sendMicroSoftTeamsReport(microSoftTeamsWebhookUrl, reportPrefix)
        }

        if(enableEmailReport) {
            email.sendEmail(reportPrefix)
		}
        manager.build.@result = hudson.model.Result.SUCCESS
    }
}

def generateCustomReportDatalayer(List<String> baselineReports, List<String> tagsToInclude, Boolean enableMicroSoftTeamsReport, Boolean enableEmailReport, String microSoftTeamsWebhookUrl, String reportPrefix, msTeams, email) {
    stage('Custom reporter') {
        baselineReports.each { baselineReport -> 
            copyArtifacts(projectName: baselineReport, selector: lastCompleted(), filter: 'allure-results.zip')
            unzip zipFile: 'allure-results.zip', dir: 'allure-results'
            sh(script: '''
            set +e
            rm allure-results.zip >/dev/null
            ''', returnStatus: true)
            sh "echo Successfully extracted build artifacts from latest ${baselineReport}"
        }
        sleep 30
        def allureResults = findFiles(glob: "allure-results/*-result.json")
        def filesToDelete = []
        allureResults.each {result -> 
            def resultJson = readJSON file: "${WORKSPACE}/allure-results/${result.name}"
            def tagCounter = 0
            tagsToInclude.each { tag -> 
                def labels = resultJson['labels']
                def index =  labels.findIndexOf { it.value == tag }
                if (index >= 0) {
                    tagCounter += 1
                }
            }
            if (tagCounter != tagsToInclude.size()) {
                filesToDelete.push("allure-results/${result.name}")
            }
        }
        def filesToDeleteChunks = filesToDelete.collate(100)
        filesToDeleteChunks.each { chunk ->
            def chunkToDelete = chunk.join(' ')
            sh "rm ${chunkToDelete}"
        }
        sh "echo Successfully filtered allure results"
        script {
            	allure([
                    includeProperties: false,
                    jdk              : '',
                    properties       : [],
                    reportBuildPolicy: 'ALWAYS',
                    results          : [[path: 'allure-results']]
                ])
            }
        if(enableMicroSoftTeamsReport) {
            // slack.sendSlackReportDatalayer(slackWebhookUrl, reportPrefix)
        }
        
        if(enableEmailReport) {
            email.sendEmail(reportPrefix)
		}
        manager.build.@result = hudson.model.Result.SUCCESS
    }
}

return this