import sys
import json

FILE_PATH = sys.argv[1]
feature_file_count = sys.argv[2]
file_name = 'savethisfile-' + feature_file_count

try:
  countInternal = 0
  response_json = open('{}.json'.format(file_name))
  json_text = json.load(response_json)

  # loop through each item in the json file
  for jira_item in json_text:
    print('Current Item To Be Updated:', jira_item)
    oldTmsId = json_text[countInternal]['old-tms-id']
    newTmsId = json_text[countInternal]['new-tms-id']

    if json_text[countInternal]['update'] == True:
      featurefile_open = open(FILE_PATH, mode='rt', encoding='utf-8')
      data = featurefile_open.read()
      data = data.replace(oldTmsId, newTmsId)
      print('replacing {oldtms} with {newtms}'.format(oldtms = oldTmsId, newtms = newTmsId))
      print(data)
      print('----------------------------------')
      try:
        featurefile_write = open(FILE_PATH, mode='wt', encoding='utf-8')
        featurefile_write.write(data)
      finally:
        featurefile_write.close()
      featurefile_open.close()
    else:
      try: 
        with open(FILE_PATH) as myFile:
          for num, line in enumerate(myFile, 1):
            if oldTmsId in line:
              line_number = num - 1
          myFile.close()
        print('----------------------------------')  
        print(line_number)
        with open(FILE_PATH, "r") as myFeatureFile:
          contents = myFeatureFile.readlines()
          contents.insert(int(line_number), '\n')
          contents.insert(int(line_number), '  @tms:' + newTmsId)
          myFeatureFile.close()
        with open(FILE_PATH, "w") as myWriteFile:
          contents = "".join(contents)
          myWriteFile.write(contents)
          myWriteFile.close()
        print(contents)
        print('----------------------------------')
      except:
        print('error')
    countInternal += 1
finally:
  response_json.close()


