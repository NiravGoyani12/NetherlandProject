# Statistics Reports
In our project we have excel reports for scenarios that are implemented across different browsers/divices/locales. In this way we can give quick and detailed overview to business what are we testing and what is the coverage.

## Scenario report
This report provides overview of all scenarios for specific brand (ck/th) on feature level. In this report you can find the following information:
1. Number of scenarios in full/sprint regression across specific browser/device
2. Number of scenarios that are not yet implemented for specific browser/device (e.g. iosPending, MobilePending, etc.)
3. Current coverage for real mobile devices

## Locale report
This report provides overview of all scenarios for full regression for specific brand (ck/th) on sceanrio level. In this report you can find the followinf information:
1. List of all scenarios included in full regression
2. Which locale is being used for any specific scenario
3. BDD's for all scenarios (comment in the column C)
4. Overview for all android pending and ios pending scenarios (columns D and E)
5. Number of scenarios being executed against each locale

## Gap Analysis report
This report provides overview of all scenarios implemted as part of gap analysis for each team. Report contains following information:
1. Number of scenarios implemented for Desktop, Mobile, Tablet as part of gap analysis for every team

## How to generate report
Every report can be generated separately
1. TH scenario report
   ```npm run th-generate-scenario-report```
2. TH locale report
   ```npm run th-generate-locale-report```   
3. CK scenario report
   ```npm run ck-generate-scenario-report```
4. CK locale report
   ```npm run ck-generate-locale-report```  
5. Gap analysis report   
   ```npm run generate-gap-analysis-report```  

If you want to generate all reports in one go, run following script:
```npm run generate-all-reports```

All reports that are generated are saved in the ```scenario-reports/output ``` directory and NOT tracked by git.
