import requests
import sys
import os
import json

DESKTOP_TEST_PLAN_KEY = sys.argv[1]
MOBILE_TEST_PLAN_KEY = sys.argv[2]
feature_file_count = sys.argv[3]

QA_ENV_JIRA_BEARER_TOKEN = os.environ.get('QA_ENV_JIRA_BEARER_TOKEN')
QA_ENV_JIRA_BASIC = os.environ.get('QA_ENV_JIRA_BASIC')

file_name = 'response-' + feature_file_count
jira_headers = {'Authorization': QA_ENV_JIRA_BASIC,
    'Content-Type': 'application/json'}
xray_headers = {'Authorization': QA_ENV_JIRA_BEARER_TOKEN}
graphql_url = 'https://xray.cloud.getxray.app/api/v2/graphql'
issue_url = 'https://pvhcorp.atlassian.net/rest/api/2/issue/'

response_json = open('{}.json'.format(file_name))
data = json.load(response_json)

# Get Test Plan Information for Desktop
try:
    dt_test_plan_details_url = issue_url + DESKTOP_TEST_PLAN_KEY
    dt_test_plan_details = requests.get(dt_test_plan_details_url, headers=jira_headers)
    dt_test_plan_text = json.loads(dt_test_plan_details.text)
    DESKTOP_TEST_PLAN_ID = dt_test_plan_text['id']
except:
    print('An error occurred when trying to get Desktop Test Plan details. Response code:', dt_test_plan_details.status_code)

# Get Test Plan Information for Mobile
try:
    mob_test_plan_details_url = issue_url + MOBILE_TEST_PLAN_KEY
    mob_test_plan_details = requests.get(mob_test_plan_details_url, headers=jira_headers)
    mob_test_plan_text = json.loads(mob_test_plan_details.text)
    MOBILE_TEST_PLAN_ID = mob_test_plan_text['id']
except:
    print('An error occurred when trying to get Mobile Test Plan details. Response code:', mob_test_plan_details.status_code)

# Iterate through updated/created tests and link each one
for i in data['updatedOrCreatedTests']:
    desktop = False
    mobile = False
    ISSUE_KEY = i['key']
    get_issue_url = issue_url + ISSUE_KEY
    issue_details_response = requests.get(get_issue_url, headers=jira_headers)
    print(issue_details_response.text)
    issue_details_text = json.loads(issue_details_response.text)
    ISSUE_ID = issue_details_text['id']
    issue_fields = issue_details_text['fields']
    issue_labels = issue_fields['labels']
    
    # Create json body query for graphql
    try:
        desktop_body = '''
        mutation {{
            addTestsToTestPlan(
                issueId: "{test_plan_id}",
                testIssueIds: ["{issue_id}"]
            ) {{
                addedTests
                warning
            }}
        }}
        '''.format(test_plan_id=DESKTOP_TEST_PLAN_ID, issue_id=ISSUE_ID)
    except NameError:
        print('Desktop Test Plan Key is not defined!')
    
    # Create json body query for graphql
    try:
        mobile_body = '''
        mutation {{
            addTestsToTestPlan(
                issueId: "{test_plan_id}",
                testIssueIds: ["{issue_id}"]
            ) {{
                addedTests
                warning
            }}
        }}
        '''.format(test_plan_id=MOBILE_TEST_PLAN_ID, issue_id=ISSUE_ID)
    except NameError:
        print('Mobile Test Plan Key is not defined! Skipping creation of JSON body...')

    # iterate through the labels to see if it is for desktop or mobile
    for i in issue_labels:
        if 'desktop' in i.lower():
            desktop = True
        if 'mobile' in i.lower():
            mobile = True
    if desktop == True:
        try:
            dt_add_to_plan_response = requests.post(url=graphql_url, headers=xray_headers, json={"query": desktop_body})
            if dt_add_to_plan_response.status_code == 200:
                print('Added {issue_key} to test plan {test_plan_key}'.format(issue_key=ISSUE_KEY, test_plan_key=DESKTOP_TEST_PLAN_KEY))
            else:
                print('Error adding {issue_key} to test plan. Details: '.format(issue_key=ISSUE_KEY), + dt_add_to_plan_response.text)
        except NameError:
            print('Desktop Test Plan Key is not defined! Unable to add test to Desktop Test Plan.')

    if mobile == True:
        try:
            mob_add_to_plan_response = requests.post(url=graphql_url, headers=xray_headers, json={"query": mobile_body})
            if mob_add_to_plan_response.status_code == 200:
                print('Added {issue_key} to test plan {test_plan_key}'.format(issue_key=ISSUE_KEY, test_plan_key=MOBILE_TEST_PLAN_KEY))
            else:
                print('Error adding {issue_key} to test plan. Details: '.format(issue_key=ISSUE_KEY), + dt_add_to_plan_response.text)
        except NameError:
            print('Mobile Test Plan Key is not defined! Unable to add test to Mobile Test Plan.')