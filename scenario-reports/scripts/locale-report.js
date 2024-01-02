const brand = process.env.Brand;
const Excel = require('exceljs');
const features = require(`../output/${brand}-full-regression-features.json`);

var workbook = new Excel.Workbook();
var workSheet = workbook.addWorksheet('Locales');
let localeList;
if (brand === 'ck') {
  localeList = ["de", "uk", "nl", "ru", "es", "at", "be", "bg", "hr", "cz", "dk", "ee", "fi", "fr", "hu", "ie", "it", "lv", "lt", "lu", "pl", "pt", "ro", "sk", "si", "se", "ch", "default", "spadefault", "multilangdefault"];
} else {
  localeList = ["de", "uk", "nl", "ru", "es", "at", "be", "hr", "cz", "dk", "ee", "fi", "fr", "hu", "ie", "it", "lv", "lt", "lu", "pl", "pt", "sk", "si", "se", "ch", "default", "spadefault", "multilangdefault"];
}
let totalCounter = 0;
tableSetup();
fillData();
setColumnWidth();
addSummary();
workbook.xlsx.writeFile(`scenario-reports/output/${process.env.Brand.toUpperCase()}_${getDate()}_Locale_Report.xlsx`);

function tableSetup() {
    workSheet.addRow(["Feature name", "Scenario name", "Locale", "Android pending", "IOS pending", "", "Locale", "Number of scenarios", "%"]);
    workSheet.getRow(1).font = {size: 8, bold: true};
}

function fillData() {
    for (let featureCounter = 0; featureCounter < features.length; featureCounter++) {
        for (let scenarioCounter = 0; scenarioCounter < features[featureCounter].elements.length; scenarioCounter++) {
            let locale = "default";
            let stepList = "";
            for (let stepCounter = 0; stepCounter < features[featureCounter].elements[scenarioCounter].steps.length; stepCounter++) {
                const stepType = features[featureCounter].elements[scenarioCounter].steps[stepCounter].keyword;
                const stepName = features[featureCounter].elements[scenarioCounter].steps[stepCounter].name.toLowerCase();
                let isLocaleSpecific = [];
                localeList.forEach(element => isLocaleSpecific.push(stepName.includes(` ${element} `)));
                let localeIndex = 0;
                while (localeIndex < isLocaleSpecific.length && locale === "default") {
                    if (isLocaleSpecific[localeIndex] === true) {
                        locale = localeList[localeIndex];
                    }
                    localeIndex++;
                }
                if (locale === "be") {
                    const extraCheck = ["to", "will", "should", "not", "only", "still", "can"];
                    let failedExtraCheck = [];
                    extraCheck.forEach(element => failedExtraCheck.push(stepName.includes(`${element} be`)));
                    let keywordIndex = 0;
                    while (keywordIndex < failedExtraCheck.length) {
                        if (failedExtraCheck[keywordIndex] === true) {
                            locale = "default";
                        }
                        keywordIndex++;
                    }
                }
                if (locale === "it") {
                    const extraCheck = ["is", "will", "should"];
                    let failedExtraCheck = [];
                    extraCheck.forEach(element => failedExtraCheck.push(stepName.includes(`it ${element}`)));
                    let keywordIndex = 0;
                    while (keywordIndex < failedExtraCheck.length) {
                        if (failedExtraCheck[keywordIndex] === true) {
                            locale = "default";
                        }
                        keywordIndex++;
                    }
                }
                stepList = `${stepList} ${stepType}${stepName} \n\r`;
            }
            tags = [];
            let androidPending = "";
            let iosPending = "";
            features[featureCounter].elements[scenarioCounter].tags.forEach(element => tags.push(element.name));
            if (tags.includes("@MobilePending")) { androidPending = "No android support yet"; }
            if (tags.includes("@SafariPending")) { iosPending = "No IOS support yet"; }
            workSheet.addRow([features[featureCounter].name, features[featureCounter].elements[scenarioCounter].name, locale, androidPending, iosPending]);
            workSheet.getRow(totalCounter+2).font = {size: 8};
            const cellNumber = `C${totalCounter + 2}`;
            workSheet.getCell(cellNumber).note = stepList;
            totalCounter++;
        }
    }
}

function setColumnWidth(){
    workSheet.getColumn(1).width = 26;
    workSheet.getColumn(2).width = 72;
    workSheet.getColumn(3).width = 10;
    workSheet.getColumn(4).width = 15;
    workSheet.getColumn(5).width = 15;
    workSheet.getColumn(8).width = 15;
}

function addSummary() {
    let localeCounter = 0;
    localeList.forEach(element => {
        workSheet.getCell(`G${localeCounter+2}`).value = element;
        workSheet.getCell(`H${localeCounter+2}`).value = {formula: `=COUNTIF(C:C, "${element}")`};
        workSheet.getCell(`I${localeCounter+2}`).value = {formula: `=H${localeCounter+2}/${totalCounter}`};
        workSheet.getCell(`I${localeCounter+2}`).numFmt = '0.00%';
        localeCounter++;})
}

function getDate() {
    const today = new Date();
    const dd = String(today.getDate()).padStart(2, '0');
    const mm = String(today.getMonth() + 1).padStart(2, '0');
    const yy = today.getFullYear().toString().substr(-2);
    return dd + '_' + mm + '_' + yy;
  }