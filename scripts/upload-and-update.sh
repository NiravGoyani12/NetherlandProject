#!/bin/bash
chmod +x ./scripts/generate-token.sh
QA_ENV_JIRA_BEARER_TOKEN="Bearer "$(./scripts/generate-token.sh)

git fetch origin master
git fetch origin $CI_MERGE_REQUEST_SOURCE_BRANCH_NAME
BEHINDCOUNT=$(git rev-list --left-right --count origin/master...origin/$CI_MERGE_REQUEST_SOURCE_BRANCH_NAME | awk '{print $1}')

if [[ $BEHINDCOUNT -eq 0 ]];
then
  rm merge_request_discussion_thread 2> /dev/null || true
  SHA_NUM=$(git rev-parse HEAD)
  git diff --name-only $SHA_NUM origin/master > filelist.txt
  cat filelist.txt
  chmod +x ./scripts/loop-through-files.sh
  ./scripts/loop-through-files.sh
  git status | grep .feature | awk '{print $2}' > filestobeadded.txt
  fileinput="filestobeadded.txt"
  while read -r line
  do
    echo "line: $line"
    git add $line
  done < "$fileinput"
  git status
  git commit -m "Updated files via ${PVH_GITLAB_FULL_URL}/api/v4/projects/${CI_PROJECT_ID}/merge_requests/${CI_MERGE_REQUEST_IID}"
  git remote set-url origin "https://oauth2:${INTERNAL_TOKEN}@${PVH_GITLAB_URL}/eumobile/ecom-e2e-test.git"
  git push origin HEAD:$CI_MERGE_REQUEST_SOURCE_BRANCH_NAME
else
  echo "YOU NEED TO MERGE CHANGES IN FROM MASTER BEFORE YOU CAN RUN THIS JOB!"
fi