# Slack integration for channel reports and alerts

In order to send notifications with each team report, we need a token. That is created by adding a slack channel to our automation bot [Clive](https://api.slack.com/apps/AJU8EFN31/general?).

## How to add a channel
1. Go to [Add channel](https://api.slack.com/apps/AJU8EFN31/install-on-team?)
2. Click on button `Reinstall to workspace` 
3. In the new window, at the bottom, search and select the channel you want to add
4. Press button `Allow`

**Note**
You can only add channels that are public or private channels in which you are a member.

## Update jenkins files
1. Channel `regression-every-day` use hook `https://hooks.slack.com/services/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`
  1. [CK Desktop](../jenkins-files/ck/ck-regression-desktop-chrome.jenkinsfile)
  2. [CK Android](../jenkins-files/ck/ck-regression-android-chrome.jenkinsfile)
  3. [CK Mobile](../jenkins-files/ck/ck-regression-mobile-chrome.jenkinsfile)
  4. [TH Desktop](../jenkins-files/th/th-regression-desktop-chrome.jenkinsfile)
  5. [TH Android](../jenkins-files/th/th-regression-android-chrome.jenkinsfile)
  6. [TH Mobile](../jenkins-files/th/th-regression-mobile-chrome.jenkinsfile)
  7. [CK Desktop](../jenkins-files-unix/ck-nightly-builds/ck-regression-desktop-chrome.jenkinsfile)
  8. [CK Android](../jenkins-files-unix/ck-nightly-builds/ck-regression-android-chrome.jenkinsfile)
  9. [CK Mobile](../jenkins-files-unix/ck-nightly-builds/ck-regression-mobile-chrome.jenkinsfile)
  10. [TH Desktop](../jenkins-files-unix/th-nightly-builds/th-regression-desktop-chrome.jenkinsfile)
  11. [TH Android](../jenkins-files-unix/th-nightly-builds/th-regression-android-chrome.jenkinsfile)
  12. [TH Mobile](../jenkins-files-unix/th-nightly-builds/th-regression-mobile-chrome.jenkinsfile)
2. Channel `ecom-runner-reporting` use hook `https://hooks.slack.com/services/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`
  1. [Gold build runner](../jenkins-files/common/gold-build-runner.jenkinsfile)
  2. [Runner](../jenkins-files/common/runner.jenkinsfile)
  3. [Ecom runner](../jenkins-files-unix/common/ecom-runner.jenkinsfile)
  4. [Gold build runner](../jenkins-files-unix/common/gold-build-runner.jenkinsfile)
3. Channel `ecom-automation-qa` use hook `https://hooks.slack.com/services/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`
  1. [Jira issue report](../jenkins-files/common/jira-issue-report.jenkinsfile)
  2. [Npm audit report](../jenkins-files/common/npm-audit-report.jenkinsfile)
  3. [Xray alignment](../jenkins-files/common/xray-alignment-report.jenkinsfile)
  4. [Jira issue report](../jenkins-files-unix/common/jira-issue-report.jenkinsfile)
  5. [Jira version report](../jenkins-files-unix/common/jira-versions-report.jenkinsfile)
  6. [Npm audit report](../jenkins-files-unix/common/npm-audit-report.jenkinsfile)
  7. [Xray alignment](../jenkins-files-unix/common/xray-alignment-report.jenkinsfile)
  8. [Test run](../pipeline-scripts/test-run.groovy)
  9. [Slack report](../pipeline-scripts/reports/slack-report.groovy)
  10. [Test run](../pipeline-scripts-unix/test-run.groovy)
  11. [Slack report](../pipeline-scripts-unix/reports/slack-report.groovy)
  12. [Slack service](../src/core/services/slack.service.ts)
4.  Channel `eer-daily-regression` use hook `https://hooks.slack.com/services/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`
  1. [CK Desktop](../jenkins-files/ck/reporter-ck-eer-desktop-chrome.jenkinsfile)
  2. [CK Mobile](../jenkins-files/ck/reporter-ck-eer-mobile-chrome.jenkinsfile)
  3. [TH Desktop](../jenkins-files/th/reporter-th-eer-desktop-chrome.jenkinsfile)
  4. [TH Mobile](../jenkins-files/th/reporter-th-eer-mobile-chrome.jenkinsfile)
  5. [CK Desktop](../jenkins-files-unix/ck-reporting/reporter-ck-eer-desktop-chrome.jenkinsfile)
  6. [CK Mobile](../jenkins-files-unix/ck-reporting/reporter-ck-eer-mobile-chrome.jenkinsfile)
  7. [TH Desktop](../jenkins-files-unix/th-reporting/reporter-th-eer-desktop-chrome.jenkinsfile)
  8. [TH Mobile](../jenkins-files-unix/th-reporting/reporter-th-eer-mobile-chrome.jenkinsfile)
5. Channel `ck-experience-regression` use hook `https://hooks.slack.com/services/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`
  1. [CET-1 Desktop](../jenkins-files/ck/reporter-ck-cet1-desktop-chrome.jenkinsfile)
  2. [CET-1 Mobile](../jenkins-files/ck/reporter-ck-cet1-mobile-chrome.jenkinsfile)
  3. [EESK Desktop](../jenkins-files/ck/reporter-eesk-desktop-chrome.jenkinsfile)
  4. [EESK Mobile](../jenkins-files/ck/reporter-eesk-mobile-chrome.jenkinsfile)
  5. [CET-1 Desktop](../jenkins-files-unix/ck-reporting/reporter-ck-cet1-desktop-chrome.jenkinsfile)
  6. [CET-1 Mobile](../jenkins-files-unix/ck-reporting/reporter-ck-cet1-mobile-chrome.jenkinsfile)
  7. [EESK Desktop](../jenkins-files-unix/ck-reporting/reporter-eesk-desktop-chrome.jenkinsfile)
  8. [EESK Mobile](../jenkins-files-unix/ck-reporting/reporter-eesk-mobile-chrome.jenkinsfile)
6. Channel `ck-eei-regression` use hook `https://hooks.slack.com/services/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`
  1. [Desktop](../jenkins-files/ck/reporter-eei-desktop-chrome.jenkinsfile)
  2. [Mobile](../jenkins-files/ck/reporter-eei-mobile-chrome.jenkinsfile)
  3. [Desktop](../jenkins-files-unix/ck-reporting/reporter-eei-desktop-chrome.jenkinsfile)
  4. [Mobile](../jenkins-files-unix/ck-reporting/reporter-eei-mobile-chrome.jenkinsfile)
7. Channel `th-tec-regression` use hook `https://hooks.slack.com/services/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`
  1. [Desktop](../jenkins-files/th/reporter-th-tec-desktop-chrome.jenkinsfile)
  2. [Mobile](../jenkins-files/th/reporter-th-tec-mobile-chrome.jenkinsfile)
  3. [Desktop](../jenkins-files-unix/th-reporting/reporter-th-tec-desktop-chrome.jenkinsfile)
  4. [Mobile](../jenkins-files-unix/th-reporting/reporter-th-tec-mobile-chrome.jenkinsfile)
8. Channel `tex-and-tee` use hook `https://hooks.slack.com/services/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`
  1. [TEE Desktop](../jenkins-files/th/reporter-tee-desktop-chrome.jenkinsfile)
  2. [TEE Mobile](../jenkins-files/th/reporter-tee-mobile-chrome.jenkinsfile)
  3. [TEX Desktop](../jenkins-files/th/reporter-tex-desktop-chrome.jenkinsfile)
  4. [TEX Mobile](../jenkins-files/th/reporter-tex-mobile-chrome.jenkinsfile)
  5. [TEE Desktop](../jenkins-files-unix/th-reporting/reporter-tee-desktop-chrome.jenkinsfile)
  6. [TEE Mobile](../jenkins-files-unix/th-reporting/reporter-th-tee-mobile-chrome.jenkinsfile)
  7. [TEX Desktop](../jenkins-files-unix/th-reporting/reporter-tex-desktop-chrome.jenkinsfile)
  8. [TEX Mobile](../jenkins-files-unix/th-reporting/reporter-th-tex-mobile-chrome.jenkinsfile)
9. Channel `mazeru` use hook `https://hooks.slack.com/services/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`
  1. [CK Desktop](../jenkins-files/ck/reporter-ck-swat-spa-desktop-chrome.jenkinsfile)
  2. [CK Mobile](../jenkins-files/ck/reporter-ck-swat-spa-mobile-chrome.jenkinsfile)
  3. [TH Desktop](../jenkins-files/th/reporter-th-swat-spa-desktop-chrome.jenkinsfile)
  4. [TH Mobile](../jenkins-files/th/reporter-th-swat-spa-mobile-chrome.jenkinsfile)
  5. [CK Desktop](../jenkins-files-unix/ck-reporting/reporter-ck-swat-spa-desktop-chrome.jenkinsfile)
  6. [CK Mobile](../jenkins-files-unix/ck-reporting/reporter-ck-swat-spa-mobile-chrome.jenkinsfile)
  7. [TH Desktop](../jenkins-files-unix/th-reporting/reporter-th-swat-spa-desktop-chrome.jenkinsfile)
  8. [TH Mobile](../jenkins-files-unix/th-reporting/reporter-th-swat-spa-mobile-chrome.jenkinsfile)
10. Channel `ecom-domains-leads` use hook `https://hooks.slack.com/services/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`
11. Channel `datalayer-reports` use hook `https://hooks.slack.com/services/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`
  1. [CK Desktop](../jenkins-files/ck/reporter-ck-dl-desktop-chrome.jenkinsfile)
  2. [CK Mobile](../jenkins-files/ck/reporter-ck-dl-mobile-chrome.jenkinsfile)
  3. [TH Desktop](../jenkins-files/th/reporter-th-dl-desktop-chrome.jenkinsfile)
  4. [TH Mobile](../jenkins-files/th/reporter-th-dl-mobile-chrome.jenkinsfile)
  5. [CK Desktop](../jenkins-files-unix/ck-reporting/reporter-ck-dl-desktop-chrome.jenkinsfile)
  6. [CK Mobile](../jenkins-files-unix/ck-reporting/reporter-ck-dl-mobile-chrome.jenkinsfile)
  7. [TH Desktop](../jenkins-files-unix/th-reporting/reporter-th-dl-desktop-chrome.jenkinsfile)
  8. [TH Mobile](../jenkins-files-unix/th-reporting/reporter-th-dl-mobile-chrome.jenkinsfile)
12. Channel `down-detector` use hook `https://hooks.slack.com/services/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`
13. Channel `db0-p1-regression-reports` use hook `https://hooks.slack.com/services/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`
  1. [CK Desktop](../jenkins-files-unix/db0-ck-nightly-builds/db0-ck-regression-desktop-chrome.jenkinsfile)
  2. [CK Mobile](../jenkins-files-unix/db0-ck-nightly-builds/db0-ck-regression-mobile-chrome.jenkinsfile)
  3. [TH Desktop](../jenkins-files-unix/db0-th-nightly-builds/db0-th-regression-desktop-chrome.jenkinsfile)
  4. [TH Mobile](../jenkins-files-unix/db0-th-nightly-builds/db0-th-regression-mobile-chrome.jenkinsfile)