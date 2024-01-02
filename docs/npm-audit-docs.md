# NPM Audit reports

Npm audit report is a part of the team's ongoing effort to produce high-quality code which follows best practices along with monitoring and removing deprecated and outdated dependencies from the code base.

### Npm audit report consists of 2 parts:
1. Npm audit summary with number of vulnerabilities caused by outdated packages.
2. Number and list of outpdated npm packages with current and latest versions. 

### 2 ways to get npm audit report:
1. Gitlab merge request comment
2. Weekly slack message

## Gitlab merge request comment

Automatic comment for each open merge request generated as part of gitlab ci pipeline. The comment contains the overview of vulnerabilities and number of outdated npm packages running.
To disable comment generation or changing the logic refer to [audit_summary stage](../.gitlab-ci.yml)

### Code
- [code](../scenario-reports/scripts/npm-audit/audit-summary-gitlab.js) to generate output with audit summary and outdated packages.
- [code](../scenario-reports/scripts/npm-audit/generate-audit-gitlab-comment.js) to generate formatted gitlab comment
- [gitlab ci stage](../.gitlab-ci.yml) responsible for attaching comments to merge requests

## Slack message and jenkins job

Weekly slack message with overview of vulnerabilities, number and list of outdated npm packages including current and latest versions for each outdated dependency.

### Code

- [code](../scenario-reports/scripts/npm-audit/audit-summary-slack.js) to generate output with audit summary and outdated packages.
- [code](../scenario-reports/scripts/npm-audit/generate-audit-slack.js) to generate formatted slack message
- [Groovy script](../pipeline-scripts/reports/npm-audit-report.groovy) executed to send a slack message with audit summary
- [Jenkins file](../jenkins-files/common/npm-audit-report.jenkinsfile)
- [Jenkins job](https://172.24.22.16/jenkins/view/pvh%20qa%20services/job/eCom_Npm_Audit_Report/)


## Run audit locally

 - For npm audit summary run `npm audit`
 - For list of outdated packages run `npm outdated`

## Actions and required updates

The goal of generating regular npm audit reports to keep track of:
- outdated npm packages
- vulnerabilities caused by outdated packages.

All `critical` and `high` vulnerablities should be fixed as soon as possible and always should be team's effort.
It's not mandatory to keep all dependencies updated as long as outdated package is not causing `critical` or `high` vulnerability to the code base.
