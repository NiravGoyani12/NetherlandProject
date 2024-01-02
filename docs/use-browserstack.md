# Use Browserstack

To run the pipelines for browserstack, we use gitlab scheduled pipelines.

For information on how to use Browserstack on Gitlab: https://confluence-eu.pvh.com/display/DHQC/Using+Browserstack+on+Gitlab

## Run tests locally
To run tests locally you need to start Browserstack Local. This is to allow all requests to be routed to your local connection. 
This means you need to be connected to the VPN, or at least on the PVH network (with access to the DBs, etc)

1. Add the following variables to your terminal's path. This information can be obtained after logging in to Browserstack. In the dashboard, it should be at the top, labelled "Access Key"
If you require a browserstack account, please reach out to: Joanne Javier
```
# Windows: Git Bash, Mac: Bash/Terminal
export BROWSERSTACK_KEY=<insert your access key from Browserstack>
export BROWSERSTACK_USERNAME=<insert your Browserstack user name>
```
2. Build the project
```
npm run build
```

3. Start Browserstack Local
```
npm run start-browserstack

# Alternatively, you can also use:
BROWSERSTACK_KEY=asodkfaseif2334 BROWSERSTACK_USERNAME=sampleusername_123123 node ./build/startBrowserstack.js
```
Note: if there are errors, a browserstack.err file will be created in your root folder

4. (Optional) To stop the process, use the following command:
```
npm run stop-browserstack
```

## Option #1: Build project and run same command as in jenkins (example below):
1. Build the project
```
npm run build
```
2. Run the tests
Note: Change the tags as needed
```
# For mac users:
Brand=ck DriverName=browserstack-safari Platform=desktop DatabaseName=uat-prod Site=b2ceuup DefaultLocale=de SpaDefaultLocale=be  SpaDefaultLangCode=default MultiLangDefaultLocale=ch MultiLangDefaultLangCode=FR MainRedirectPage=search-plp CUCUMBER_PARALLEL=true DriverPoolSize=12 SessionIdleTimeout=10 SessionMaxTest=50 node ./build/runner.js -p prod --parallel 1 --tags "@FullRegression and @Desktop and @Chrome and (@tms:EECK-5853 or @tms:EECK-6018)"

# For windows users:
SET Brand=ck & SET DriverName=browserstack-safari & SET Platform=desktop & SET DatabaseName=uat-prod & SET Site=b2ceuup & SET DefaultLocale=de & SET SpaDefaultLocale=be & SET SpaDefaultLangCode=default & SET MultiLangDefaultLocale=ch & SET MultiLangDefaultLangCode=FR & SET MainRedirectPage=search-plp & SET CUCUMBER_PARALLEL=true & SET DriverPoolSize=12 & SET SessionIdleTimeout=10 & SET SessionMaxTest=50 & node ./build/runner.js -p prod --parallel 1 --tags "@FullRegression and @Desktop and @Chrome and (@tms:EECK-5853 or @tms:EECK-6018)" 
```

After which, you can generate and open allure reports (with the pre-requisite that you have allure installed globally)

## Option #2: Add @torun to scenarios and run tests locally using any of the commands below:
1. Run the commands below
```
# For TH
npm run debug-bs-ios
npm run debug-bs-safari
npm run debug-bs-chrome

# For CK
npm run ck-debug-bs-ios
npm run ck-debug-bs-safari
npm run ck-debug-bs-chrome
```