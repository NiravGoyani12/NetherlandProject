# E2E Test Framework for E-COM

## Before everything
Before you start use this project or contribute this project, **PLEASE READ OUR STANDARDS**: [STANDARD](./docs/standards.md)

> This project is based on W3C protocl and Appium, notice that Appium protocol only works with real device, but not Chrome-Simulator!

## Our Coverage
![alt text](/docs/img/coverage.png)

Our automation service has covered as above work flow by different dedicated business team automation mates. The order processing is broken in our current automation framework.  We cannot handle the order processing. In other words, EER test will be very unstable, since its dependency is broken in our project. It's already wrote down in our technical road map. 

## Docs
### Processes 
* [Daily Work Process](./docs/daily-work.md)
* [Standards](./docs/standards.md)
* [Npm audit](./docs/npm-audit-docs.md)

### Framework
* [Page Object](./docs/page-object.md)
* [Page Object Strategy](./docs/page-object-strategy.md)
* [Tech - Find Element](./docs/find-element.md)
* [Jira+Xray integration](./docs/jira-integration.md)
* [Statistics Report](./docs/excel-reports.md)

### Data
* [Data Driven Test](./docs/data-driven.md)
* [DB Integration](./docs/product.md)
* [Data Source of Pages](./docs/data-for-page.md)

### Tags
* [Funtional tags](./docs/functional-tags.md)
* [Tag Format](./docs/tags-format.md)

### CI/CD
* [CI Configuration](./docs/ci.md)
* [CI Regression and Reporting Schedule](./docs/nightly-regression.md)
* [Rerun mechanism](./docs/rerun-mechanism.md)
* [Build Timeout Mechanism](./docs/build-timeout.md)
* [Send Reports Pipeline](./docs/send-reports-pipeline.md)

### Additional Set-up / Troubleshooting
* [Windows](./docs/windows-setup.md)
* [Safari](./docs/safari-local.md)

### How To
* [Run Full Regression/RC Tests on Safari Local](./docs/run-safari.md)
* [Generate excel file for scenario reporting](./docs/how-to-generate-report.md)
* [Use Browserstack](./docs/use-browserstack.md)
* [Get Category ID for PLP](./docs/get-category-id.md)
* [Add slack messages](./docs/slack-integration.md)

### Contribution
* Java Runtime is required (Recommended Version: JDK 8 or higher)
* Install [Visual Studio Code](https://code.visualstudio.com/download)
* Install [nodist (Windows)](https://github.com/nullivex/nodist) or [nvm (Macbook)](https://github.com/nvm-sh/nvm)

### Config GIT in Windows
```bash
# Disable CRLF (if you are in windows)
git config --global core.autocrlf false
```

### How to setup
```bash
# Install proper version of node (Macbook using nvm)
nvm install

# Set proper version of node (Windows using nodist)
# Important Note: Check .nvmrc for correct version! nodist does not currently support use of .nvmrc (https://github.com/nullivex/nodist/issues/194)
nodist 14.16.0

# Use your PVH username and password
npm login --registry=https://nexus.tools.eu.pvh.cloud/repository/eu-mobileqa-npm/

# download dependencies
npm ci
```

### Run test locally with debug mode
```bash
# Prepare/Install Selenium Drivers and Selenium Server JAR and get latest chromedriver from chromeDriver folder based on os
npm run selenium-install-mac
npm run selenium-install-windows
# or alternatively you can use
NODE_TLS_REJECT_UNAUTHORIZED=0 ./node_modules/.bin/selenium-standalone install --config=./selenium.json

# Start Selenium
npm run selenium-start

#Run test which has @torun locally
For TH: 
npm run debug 
npm run debug-mobile
For CK: 
npm run ck-debug 
npm run ck-debug-mobile
```


### Run test in prod mode with scenario parallel
```
#Run test in jenkins in parallel
npm run build
npm run prod
```

### Environment Variable
* Brand: th, ck (default=th)
* DriverName: local-chrome, remote-chrome, remote-firefox (default=local-chrome)
* DatabaseName: uat-prod, prod-stag (default=uat-prod)
* Site: b2ceuup, prod-stag (default=b2ceuup)
* DefaultLocale: uk
* SpaDefaultLocale: be
* SpaDefaultLangCode: FR
* NO_ALLURE: ture or false, if it's ture, then allure server will not start
* CUCUMBER_PARALLEL: you can specify true to this value to enable DriverFactory (Shared session)

### Driver Pool Environment Variable
* DriverPoolSize: the pool size for active sessions (default is 16)
* SessionMaxTest: the test can be executed in one session (default is 50)
* SessionIdleTimeout: the session will be terminated after given seconds when it is not busy (default is 5 seconds)

### CI Environment Variable
* QA_ENV_PROD_STAG_PASSWORD: only used when running against PROD-STAG
* QA_ENV_JIRA_TOKEN: jira access token needed for xray/jira integration in the format: 'Basic ' + Buffer.from('<userName>:<password>').toString('base64');
* IBM_DB_INSTALLER_URL : C:\DB2 (https://github.com/ibmdb/node-ibm_db)
* NPM_TOKEN: the token created from user nxs-eu-mobileqa-npm


### Run in headless
```
CUCUMBER_PARALLEL=true NO_ALLURE=true Brand=th DriverName=local-chrome-headless DriverPoolSize=1  node ./build/runner.js -p prodci --tags "@torun"
```