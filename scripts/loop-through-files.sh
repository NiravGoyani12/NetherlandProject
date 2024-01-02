#!/bin/bash
input="filelist.txt"
COUNTER=0
IFS="," read -a filearray <<< $FILES_DO_NOT_INCLUDE
while read -r line
do
  echo "line: $line"
  if [[ $line == *.feature ]];
  then
    let COUNTER=COUNTER+1
    if [[ ! " ${filearray[*]} " =~ " ${line} " ]]; then
      echo "Processing: $line"
      if [ -f "features.zip" ]; then
        rm features.zip 2>/dev/null
      fi
      if [ -f "savethisfile-$COUNTER.json" ]; then
        rm savethisfile-$COUNTER.json 2>/dev/null
      fi
      if [ -f "response-$COUNTER.json" ]; then
        rm response-$COUNTER.json 2>/dev/null
      fi
      zip features.zip $line
      python3 scripts/upload-feature-file.py $line $PROJECT_KEY $COUNTER
      python3 scripts/store-tms-ids.py $COUNTER
      python3 scripts/add-automated-label.py $COUNTER
      python3 scripts/update-feature-file-details-json.py $line $COUNTER
      python3 scripts/link-to-test-plan.py $DESKTOP_JIRA_ID $MOBILE_JIRA_ID $COUNTER
      python3 scripts/create-folder.py $PROJECT_KEY $FOLDER_PATH
      python3 scripts/move-to-folder.py $FOLDER_PATH $COUNTER
    else
      echo "Skipped excluded file: $line"
    fi
  fi
done < "$input"