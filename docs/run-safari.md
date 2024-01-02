# Running Full Regression / RC on Safari Local

### Pre-requisites (Only if you want to run Allure Report locally):
1. Java 8 SDK
2. NodeJS installed (using same version)
3. allure-commandline installed globallly


### Run tests locally

1. First, you need to clean your workspace and build the project
```
npm run clean & npm run build
```

2. Run full regression
```
### CK
Brand=ck DriverName=local-safari Platform=desktop DefaultLocale=sk SpaDefaultLocale=sk SpaDefaultLangCode=default MultiLangDefaultLocale=lu MultiLangDefaultLangCode=DE node ./build/runner.js -p prod --parallel 1 --tags "(@FullRegression or @Sprint) and @Desktop and @Chrome and not @ExcludeUat"

### TH
Brand=th DriverName=local-safari Platform=desktop DefaultLocale=sk SpaDefaultLocale=sk SpaDefaultLangCode=default MultiLangDefaultLocale=lu MultiLangDefaultLangCode=DE node ./build/runner.js -p prod --parallel 1 --tags "(@FullRegression or @Sprint) and @Desktop and @Chrome and not @ExcludeUat"
```
- Note: Tags can be changed to whatever you prefer

2. Rename rerun.txt to @execute.txt
```
cp rerun.txt @execute.txt
```

3. Re-run failed tests that are in the rerun.txt
```
### CK
Brand=ck DriverName=local-safari Platform=desktop DefaultLocale=sk SpaDefaultLocale=sk SpaDefaultLangCode=default MultiLangDefaultLocale=lu MultiLangDefaultLangCode=DE node ./build/runner.js -p rerun --parallel 1 @execute.txt

### TH
Brand=th DriverName=local-safari Platform=desktop DefaultLocale=sk SpaDefaultLocale=sk SpaDefaultLangCode=default MultiLangDefaultLocale=lu MultiLangDefaultLangCode=DE node ./build/runner.js -p rerun --parallel 1 @execute.txt
```

<br/>

### Allure Command Line Installation and Report Generation
1. Install allure-commandline

```
npm install -g allure-commandline
```

2. Generate Allure Report (Make sure you already have the allure-results folder where you run this command)

```
allure generate
```

3. Open Allure Report

```
allure open
```

