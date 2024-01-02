import requests
import json
import os
import sys
    
QA_ENV_JIRA_BASIC = os.environ.get('QA_ENV_JIRA_BASIC')
feature_file_count = sys.argv[1]
file_name_one = 'response-' + feature_file_count
file_name_two = 'savethisfile-' + feature_file_count
jira_headers = { 'Authorization': QA_ENV_JIRA_BASIC, 'Content-Type': 'application/json'}
listObj = []
response_json = open('{}.json'.format(file_name_one))
data = json.load(response_json)

for i in data['updatedOrCreatedTests']:
    NEW_TMS_ID = i['key']
    print(i['key'])
    url = 'https://pvhcorp.atlassian.net/rest/api/2/issue/' + i['key']
    headers = { 'Authorization': QA_ENV_JIRA_BASIC }
    response = requests.get(url, headers=jira_headers)
    print(response.text)
    json_text = json.loads(response.text)
    fields = json_text['fields']
    labels = fields['labels']
    appended = False
    for i in labels:
      if 'tms' in i:
        OLD_TMS_ID = i.replace('tms:', '')
        if OLD_TMS_ID == "":
          SUMMARY_NAME = fields['summary']
          listObj.append({
            'old-tms-id': SUMMARY_NAME,
            'new-tms-id': NEW_TMS_ID,
            'update': False
          })
        else:
          listObj.append({
              'old-tms-id': OLD_TMS_ID,
              'new-tms-id': NEW_TMS_ID,
              'update': True
            })
        print(listObj)
        appended = True
        break
    if appended == False:
        SUMMARY_NAME = fields['summary']
        listObj.append({
          'old-tms-id': SUMMARY_NAME,
          'new-tms-id': NEW_TMS_ID,
          'update': False
        })
 
with open('{}.json'.format(file_name_two), 'w') as json_file:
    json.dump(listObj, json_file, indent=4,  separators=(',',': '))

response_json.close()
json_file.close()