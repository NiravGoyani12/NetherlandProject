import json
import logging
from urllib.request import Request, urlopen
from urllib.error import URLError, HTTPError
import os
import sys

PROJECT = sys.argv[1]
STATUS = sys.argv[2]
REPORT_URL = sys.argv[3]
HOOK_URL = os.environ['SLACK_WEBHOOK']
CI_JOB_URL = os.environ['ORIGINAL_PIPELINE_URL']
logger = logging.getLogger()
logger.setLevel(logging.INFO)


def main_handler():
    if STATUS == 'FAILED':
        COLOR = '#FF0000'
    else:
        COLOR = '#36a64f'

    slack_message = {
        "attachments":
        [
            {
                "pretext": "*Deployment Sanity Check* - "+PROJECT+" - Deployment Pipeline : <"+CI_JOB_URL+">",
                "fields":
                [
                    {
                        "title": "Status",
                        "short": "true"
                    },
                    {
                        "title": "",
                        "short": "true"
                    }
                ]
            },
            {
                "color": COLOR,
                "fields":
                [
                    {
                        "value": STATUS,
                        "short": "true"
                    },
                    {
                        "value": "",
                        "short": "true"
                    }
                ]
            },
            {
                "color": COLOR,
                "text": "Report can be found here: <"+ REPORT_URL +"|View Report>"
            }
        ]
    }
    logger.info(str(slack_message))

    req = Request(HOOK_URL, json.dumps(slack_message).encode('utf-8'))
    try:
        response = urlopen(req)
        response.read()
        logger.info('Message posted to %s')
    except HTTPError as e:
        logger.error('Request failed: %d %s', e.code, e.reason)
    except URLError as e:
        logger.error('Server connection failed: %s', e.reason)


main_handler()
