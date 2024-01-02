import requests
import sys
import os
import json

FOLDER_PATH = sys.argv[1]
feature_file_count = sys.argv[2]

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

# Iterate through updated/created tests and move each one
for i in data['updatedOrCreatedTests']:
    ISSUE_KEY = i['key']
    print('Moving test {issue_key} to {folder_path}'.format(issue_key=ISSUE_KEY, folder_path=FOLDER_PATH))
    get_issue_url = issue_url + ISSUE_KEY
    issue_details_response = requests.get(get_issue_url, headers=jira_headers)
    issue_details_text = json.loads(issue_details_response.text)
    ISSUE_ID = issue_details_text['id']
    
    # Create json body query for graphql
    try:
      query_body = '''
        mutation {{
            updateTestFolder(
                issueId: "{issue_id}",
                folderPath: "{folder_path}"
            )
        }}
      '''.format(issue_id=ISSUE_ID, folder_path=FOLDER_PATH)
    except NameError:
      print('One of the required variables (ISSUE_ID or FOLDER_PATH) is not defined!')

    # Move to folder
    try:
        move_to_folder_response = requests.post(url=graphql_url, headers=xray_headers, json={"query": query_body})
        response_text = json.loads(move_to_folder_response.text)
        if 'errors' in response_text:
          print('Error when moving to folder :'.format(folder_path=FOLDER_PATH), response_text['errors'][0]['message'])
        else:
          print('Successfully moved {issue_key} to folder {folder_path}'.format(issue_key=ISSUE_KEY, folder_path=FOLDER_PATH))
    except:
        print('There was an error when moving tests to folder. Sorry, I cannot give you more information.')