import requests
import sys
import os
import json

feature_file_count = sys.argv[1]
QA_ENV_JIRA_BASIC = os.environ.get('QA_ENV_JIRA_BASIC')

file_name_one = 'response-' + feature_file_count
jira_headers = { 'Authorization': QA_ENV_JIRA_BASIC, 'Content-Type': 'application/json'}
response_json = open('{}.json'.format(file_name_one))
data = json.load(response_json)

json_body = '''
  {
      "update": {
          "labels": [
              {
                  "add": "Automated"
              }
          ]
      }
  }
'''

for i in data['updatedOrCreatedTests']:
    url = 'https://pvhcorp.atlassian.net/rest/api/2/issue/' + i['key']
    try:
      response = requests.put(url, headers=jira_headers, data=json_body)
      if response.status_code == 204:
        print('Automated label successfully added to: ', i['key'])
      else:
        print('JIRA returned an error. Automated label has not been added. Status Code:', response.status_code)
        print('Error Message:', response.text)
    except:
      print('There was a problem adding the Automated label to the issue')