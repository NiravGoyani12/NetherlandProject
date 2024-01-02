import requests
import sys
import os
import json

PROJECT_KEY = sys.argv[1]
FOLDER_PATH = sys.argv[2]

QA_ENV_JIRA_BEARER_TOKEN = os.environ.get('QA_ENV_JIRA_BEARER_TOKEN')
QA_ENV_JIRA_BASIC = os.environ.get('QA_ENV_JIRA_BASIC')

jira_headers = {'Authorization': QA_ENV_JIRA_BASIC,
'Content-Type': 'application/json'}
xray_headers = {'Authorization': QA_ENV_JIRA_BEARER_TOKEN}
graphql_url = 'https://xray.cloud.getxray.app/api/v2/graphql'
project_url = 'https://pvhcorp.atlassian.net/rest/api/2/project/'

# Get project details to get project ID
get_project_url = project_url + PROJECT_KEY
project_details_response = requests.get(get_project_url, headers=jira_headers)
project_details_text = json.loads(project_details_response.text)
PROJECT_ID = project_details_text['id']

# Create json body query for graphql
try:
  query_body = '''
    mutation {{
      createFolder(
          projectId: "{project_id}",
          path: "{folder_path}"
      ) {{
          folder {{
              name
              path
              testsCount
          }}
          warnings
      }}
    }}
  '''.format(project_id=PROJECT_ID, folder_path=FOLDER_PATH)
except NameError:
  print('One of the required variables (PROJECT_ID or FOLDER_PATH) is not defined!')

# Create Folder
try:
    move_to_folder_response = requests.post(url=graphql_url, headers=xray_headers, json={"query": query_body})
    response_text = json.loads(move_to_folder_response.text)
    if 'errors' in response_text:
      print('Error when trying to create folder :'.format(folder_path=FOLDER_PATH), response_text['errors'][0]['message'])
    else:
      print('Successfully created folder {folder_path} in project {project_key}'.format(folder_path=FOLDER_PATH, project_key=PROJECT_KEY))
except:
    print('There was an error when creating folder. Sorry, I cannot give you more information.')
