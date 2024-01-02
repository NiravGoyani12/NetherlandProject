# How to: Generate an excel report for scenario reporting

1. Clean project *(optional)*, clean all json files previously created *(optional)*, and build the project *(required)*
```
npm run clean && npm run clean-json-files && npm run build
```

2. Create an empty JSON file and new folder under `scenarios-reports` named output
```
# Windows
mkdir scenario-reports\\output && touch scenario-reports\\output\\ck-scenarios.json

# Mac
mkdir scenario-reports/output && touch scenario-reports/output/ck-scenarios.json
```
- Where:
  - `ck-scenarios.json` should be `th-scenarios.json` for TH runs

3. Create a JSON file for all scenarios you'd like to include
```
Brand=ck node ./build/runner.js -p getscenarios --tags "@FullRegression"
```
- Where:
  - `Brand=ck` denotes the brand needed for the run
  - `--tags "@FullRegression"` denotes the tags you would like to count. Update the tag/s as needed.

4. Generate an excel file
```
Brand=ck node scenario-reports/scripts/create-scenario-report.js
```
- Where:
  - `Brand=ck` denotes the brand needed for the run (this is also the basis for the file to be picked up by the code) <br/>

Excel file should have been created in the `/scenario-reports/output` folder