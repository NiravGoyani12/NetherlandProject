def sendEmail(String reportPrefix) {
    String recipient = ''
    if (reportPrefix.contains('CK Desktop Chrome Regression')) {
        recipient = 'SophieAoudjan@ck.com, KatieNeary@pvh.com, begumborakbaltas@pvh.com, JacynthaSteltman@pvh.com, YaronLourens@pvh.com, TimmyHaryono@pvh.com, EComSupport@pvh.com, kbhandari@wundermancommerce.com, StephenEvans@pvh.com, CostinSecareanu@pvh.com, MeghaGupta@pvh.com, rakeshmahadevaswamy@pvh.com'
    } else if (reportPrefix.contains('TH Desktop Chrome Regression')) {
        recipient = 'KatieNeary@pvh.com, begumborakbaltas@pvh.com, YaronLourens@pvh.com, TimmyHaryono@pvh.com, EComSupport@pvh.com, kbhandari@wundermancommerce.com, StephenEvans@pvh.com, CostinSecareanu@pvh.com, MeghaGupta@pvh.com, rakeshmahadevaswamy@pvh.com'
    } else if (reportPrefix.contains('DL')) {
        recipient = 'EcomAnalytics@pvh.com, judithram@pvh.com, guy@cloudninedigital.nl, arina@cloudninedigital.nl, damiaocastro@pvh.com, tamasszilagyi@pvh.com'
    } else {
        recipient = 'QACommunity@pvh.com'
    }   
	def date = new Date().format( 'dd MMM YYYY' )
	String message = generateEmailBody(reportPrefix)
    mail subject: "${reportPrefix.substring(0, reportPrefix.length() - 3)} UAT-p Report #${BUILD_NUMBER} ${date}",
            body: message,
              to: recipient,
         replyTo: 'qa@pvh.com',
            from: 'qa@pvh.com' 
}

def sendEmailWithRecipients(String reportPrefix, String recipient = "QACommunity@pvh.com") {  
	def date = new Date().format( 'dd MMM YYYY' )
	String message = generateEmailBody(reportPrefix)
    mail subject: "${reportPrefix.substring(0, reportPrefix.length() - 3)} UAT-p Report #${BUILD_NUMBER} ${date}",
            body: message,
              to: recipient,
         replyTo: 'qa@pvh.com',
            from: 'qa@pvh.com' 
}
	
def generateEmailBody(String reportPrefix) {
    def date = new Date().format( 'dd MMM YYYY')
    def result = readJSON file: "${WORKSPACE}/allure-report/data/behaviors.json"
    def features = 0
	def failedFeatures = 0
    def scenarios = 0
	def failedScenarios = 0
    def featureMap = [:]
    def emailText = ""
	def featureOverview = ""
	def issueList = []
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
                        if (!(featureMap[featureName]['issues']).contains(issue['name'])) {
                            (featureMap[featureName]['issues']).push(issue['name'])
                        }
                        if (!issueList.contains(issue['name'])) {
                            issueList.push(issue['name']) 
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
    emailText = emailText + "${reportPrefix.substring(0, reportPrefix.length() - 3)} UAT-prod report #${BUILD_NUMBER} executed on ${date}. \n"
	emailText = emailText + "Environment health ${passedRate}%. \n"
	emailText = emailText + "Features: ${features}, Scenarios: ${scenarios}, Passed Scenarios: ${passedScenarios} (${passedRate}%), Failed Scenarios: ${failedScenarios} (${failedRate}%). \n"
	String knownIssues = issueList.join(', ')
	if (knownIssues == '') {
		knownIssues = "Nothing was found"
	}
	emailText = emailText + "Known issues: ${knownIssues}. \n\n"
	emailText = emailText + "For more details please refer to full report available at https://10.34.14.54/job/${JOB_NAME}/${BUILD_NUMBER}/allure/#behaviors \n\n"
    featureMap = featureMap.sort()
    featureMap.each{ featureName, testResult ->
        if(testResult['total'] - testResult['failed'] == 0) {
            passPercentage = 0
        } else {
            passPercentage = ((testResult['total'] - testResult['failed'])/testResult['total']*100).intValue()
        }
        def res =  String.format("%d%% (%d failed/%d)", passPercentage, testResult['failed'], testResult['total'])
        def featureNameField = featureName
        def resultField = res
        if(testResult['failed'] == 0) {
            //passed features should be excluded
        } 
		else {
            String featureIssues = (testResult['issues']).join(', ')
			if(featureIssues != '') {
				reportComment = " - Feature failed due to ${featureIssues}"
			}
			else {
				reportComment = "" 
			}
			featureOverview = featureOverview + "${featureNameField} - ${resultField}${reportComment}.\n"
			failedFeatures +=1
        }
    }
	emailText = emailText + "${failedFeatures} features have failures: \n"
	emailText = emailText + featureOverview
	emailText = emailText + "\nBest Regards, \nTest automation team"
	return emailText
}

return this