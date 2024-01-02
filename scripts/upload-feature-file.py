import requests
import sys
import os

FILE_PATH = sys.argv[1]
PROJECT_KEY = sys.argv[2]
feature_file_count = sys.argv[3]
QA_ENV_JIRA_BEARER_TOKEN = os.environ.get('QA_ENV_JIRA_BEARER_TOKEN')
file_name = 'response-' + feature_file_count

feature_file = open(FILE_PATH, 'rb')
url = 'https://xray.cloud.getxray.app/api/v2/import/feature?projectKey=' + PROJECT_KEY
headers = {'Authorization': QA_ENV_JIRA_BEARER_TOKEN}
if os.path.exists('features.zip'):
  fileobj = open('features.zip', 'rb')
  response = requests.post(url, headers=headers, files= { 'file': ("features.zip", fileobj) })
else:
  response = requests.post(url, headers=headers, files= { 'file': feature_file })

if response.ok:
    print("Upload completed successfully!")
    print(response.text)
    with open('{}.json'.format(file_name), 'w') as json_file:
      json_file.write(response.text)
    json_file.close()
else:
    print("Something went wrong!")
    print(response.text)
    