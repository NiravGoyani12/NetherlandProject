#!/bin/bash
generate_json()
{
cat <<EOF
{ 
  "client_id": "$QA_CLIENT_ID", 
  "client_secret": "$QA_CLIENT_SEC"
}
EOF
}

curl --request POST 'https://xray.cloud.getxray.app/api/v2/authenticate' \
--header 'Content-Type: application/json' \
--data-raw "$(generate_json)" | sed 's/"//g'
