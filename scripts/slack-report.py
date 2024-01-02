import json
import requests
import os
import sys

REPORT_URL = sys.argv[1]
HOOK_URL = os.environ.get('SLACK_WEBHOOK')
ORIGINAL_PIPELINE_URL = os.environ.get('ORIGINAL_PIPELINE_URL')
CI_PIPELINE_URL = os.environ.get('CI_PIPELINE_URL')
TEST_NAME = os.environ.get('TEST_NAME')

def send_message(slack_message):
    data = json.loads(slack_message)
    headers = {'Content-type': 'application/json', 'Accept': 'text/plain'}
    try:
        r = requests.post(HOOK_URL, data=json.dumps(data), headers=headers)
        r.raise_for_status()
    except requests.exceptions.HTTPError as err:
        raise SystemExit(err)

def main_handler():
    behavioursFile = open('allure-report/data/behaviors.json')
    result = json.load(behavioursFile)
    features = 0
    failedFeatures = 0
    scenarios = 0
    failedScenarios = 0
    featureMap = {}
    featureNames = []
    attachments = []
    tolerance = 0.2
    for behaviour in result['children']:
        features += 1
        featureName = behaviour['name']
        if featureName not in featureNames:
            featureNames.append(featureName)
        featureMap[featureName] = {}
        featureMap[featureName]['total'] = 0
        featureMap[featureName]['failed'] = 0
        featureMap[featureName]['issues'] = []
        for test in behaviour['children']:
            scenarios += 1
            if test['status'] == 'failed' or test['status'] == 'broken':
                featureMap[featureName]['failed'] = int(featureMap[featureName]['failed']) + 1
                failedScenarios += 1
                # fetch defect number
                TEST_UID = test['uid']
                testCasesJson = open("allure-report/data/test-cases/" + TEST_UID + ".json")
                testcase = json.load(testCasesJson)
                for issue in testcase['links']:
                    if 'issue' in issue['type']:
                        issueInformation = "<" + issue['url'] + "|" + issue['name'] + ">"
                        if issueInformation not in featureMap[featureName]['issues']:
                            featureMap[featureName]['issues'].append(issueInformation)
            featureMap[featureName]['total'] = int(featureMap[featureName]['total']) + 1

    passedScenarios = scenarios - failedScenarios
    passedRate = int((passedScenarios/scenarios)*100)
    failedRate = 100 - passedRate
    if os.getenv('TEST_NAME'):
        summary = TEST_NAME 
    else:
        summary = 'No Test Name Provided'

    summary = summary + " - Features: " + str(features) + ", Scenarios: " + str(scenarios) + ", Passed Scenarios: " + str(
            passedScenarios) + " (" + str(passedRate) + "%), Failed Scenarios: " + str(failedScenarios) + " (" + str(failedRate) + "), <" + REPORT_URL + "|Report Link>"

    if os.getenv('ORIGINAL_PIPELINE_URL'):
        summary = summary + ", <" + ORIGINAL_PIPELINE_URL + "|Pipeline Link>"
    elif os.getenv('CI_PIPELINE_URL'):
        summary = summary + ", <" + CI_PIPELINE_URL + "|Pipeline Link>"
    else:
        summary = summary + ", (No pipeline URL provided)"

    header = '{{"pretext": "{summary}","fields": [ {{"title": "Feature with failures","short": true}}, {{"title": "Percentage %", "short": true}}]}},'
    header = header.format(summary=summary)

    attachments.append(header)

    for name in featureNames:
        if int(featureMap[name]['total']) - int(featureMap[name]['failed']) == 0:
            passPercentage = 0
        else:
            passPercentage = int((int(featureMap[name]['total']) - int(featureMap[name]['failed']))/int(featureMap[name]['total'])*100)

        if featureMap[name]['failed'] != 0:
            res = str(passPercentage) + "% (" + str(featureMap[name]['failed']) + " failed/" + str(featureMap[name]['total']) + ")"

            if len(featureMap[name]['issues']) != 0:
                for issue in featureMap[name]['issues']:
                    res = res + " "  + issue

            featureNameField = '{{ "value" : "{name}", "short" : true }}'
            featureNameField = featureNameField.format(name=name)

            resultField = '{{ "value" : "{res}", "short" : true }}'
            resultField = resultField.format(res=res)

            if int(featureMap[name]['failed']) == 0:
                reportColor = "#36a64f"
            elif int(featureMap[name]['failed']) == 0 & int(featureMap[name]['total']) == 0:
                reportColor = "#FF0000"
            elif int(featureMap[name]['failed']) / int(featureMap[name]['total']) > tolerance:
                reportColor = "#FF0000"
            else:
                reportColor = "#f4b942"

            table = '{{"color": "{reportColor}","fields": [{featureNameField},{resultField}]}},'
            table = table.format(reportColor=reportColor, featureNameField=featureNameField, resultField=resultField)
            
            attachments.append(table)
            failedFeatures += 1
    
    if failedFeatures == 0:
        successMessage = '{"color": "#36a64f","fields": [{"value": "All features passed", "short": true},{"value": "100%", "short": true}]}'
        attachments.append(successMessage)

    attachmentsStr = ""
    for text in attachments:
        if text != attachments[-1]:
            attachmentsStr = attachmentsStr + text
        else:
            if text[-1] == ",":
                attachmentsStr = attachmentsStr + text[:-1]
            else:
                attachmentsStr = attachmentsStr + text
    slack_message = '{{"attachments": [{attachmentsStr}]}}'
    slack_message = slack_message.format(attachmentsStr=attachmentsStr)

    send_message(slack_message)

main_handler()