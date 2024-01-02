const brand = process.env.Brand;
const Excel = require('exceljs');
const features = require(`../output/${brand}-all-features.json`);

var workbook = new Excel.Workbook();
var workSheet = workbook.addWorksheet('Scenarios');
let featureCounter = 0;

tableSetup(workSheet);
fillData(workSheet);
setColumnWidth(workSheet);
setViewScale(workSheet);
addSummary(workSheet);
addConditionalFormatting(workSheet);
workbook.xlsx.writeFile(`scenario-reports/output/${brand.toUpperCase()}_${getDate()}_Scenario_Report.xlsx`);

function tableSetup(workSheet) {
    workSheet.addRow(["", "", "DESKTOP", "", "", "", "", "", "", "MOBILE"]);
    workSheet.addRow(["", "", "CHROME", "", "", "FIREFOX", "", "GENERAL", "", "CHROME", "", "", "", "", "", "SAFARI"]);
    workSheet.addRow(["Feature", "Total Count", "Full Regression", "Sprint", "RCtest", "Full Regression", "Sprint", "Desktop Only", "Max coverage", "Full Regression", "Sprint", "RCTest", "Mobile only", "Mobile Pending", "Max coverage", "Full Regression", "Sprint", "Safari Pending", "Max coverage", "Android real coverage", "Ios real coverage"]);
    workSheet.mergeCells("C1:I1");
    workSheet.mergeCells("J1:S1");
    workSheet.mergeCells("C2:E2");
    workSheet.mergeCells("F2:G2");
    workSheet.mergeCells("H2:I2");
    workSheet.mergeCells("J2:O2");
    workSheet.mergeCells("P2:S2");
    workSheet.getRow(1).alignment = {horizontal: 'center'}; 
    workSheet.getRow(1).font = {size: 8, bold: true};
    workSheet.getRow(2).alignment = {horizontal: 'center'}; 
    workSheet.getRow(2).font = {size: 8, bold: true};    
    workSheet.getRow(3).alignment = {horizontal: 'left'}; 
    workSheet.getRow(3).font = {size: 8, bold: true};            
}

function fillData(workSheet) {
    for (featureCounter = 0; featureCounter < features.length; featureCounter++) {
        let desktopChromeFullCounter = 0;
        let desktopChromeSprintCounter = 0;
        let desktopChromeRCCounter = 0;
        let desktopFirefoxFullCounter = 0;
        let desktopFirefoxSprintCounter = 0;
        let desktopOnlyCounter = 0;
        let mobileChromeFullCounter = 0;
        let mobileChromeSprintCounter = 0;
        let mobileChromeRCCounter = 0;
        let mobileOnlyCounter = 0;
        let mobilePendingCounter = 0;
        let mobileSafariFullCounter = 0;
        let mobileSafariSprintCounter = 0;
        let safariPendingCounter = 0;
        for (let scenarioCounter = 0; scenarioCounter < features[featureCounter].elements.length; scenarioCounter++) {
            tags = [];
            features[featureCounter].elements[scenarioCounter].tags.forEach(element => tags.push(element.name));
            if (tags.includes("@FullRegression") && tags.includes("@Desktop") && tags.includes("@Chrome")) { desktopChromeFullCounter++; }
            if (tags.includes("@Sprint") && tags.includes("@Desktop") && tags.includes("@Chrome")) { desktopChromeSprintCounter++; }
            if (tags.includes("@RCTest") && tags.includes("@Desktop") && tags.includes("@Chrome")) { desktopChromeRCCounter++; }
            if (tags.includes("@FullRegression") && tags.includes("@Desktop") && tags.includes("@FireFox")) { desktopFirefoxFullCounter++; }
            if (tags.includes("@Sprint") && tags.includes("@Desktop") && tags.includes("@FireFox")) { desktopFirefoxSprintCounter++; }
            if (tags.includes("@Desktop") && !tags.includes("@Mobile") && !tags.includes("@MobilePending")) { desktopOnlyCounter++; }
            if (tags.includes("@FullRegression") && tags.includes("@Mobile") && tags.includes("@Chrome")) { mobileChromeFullCounter++; }
            if (tags.includes("@Sprint") && tags.includes("@Mobile") && tags.includes("@Chrome")) { mobileChromeSprintCounter++; }
            if (tags.includes("@RCTest") && tags.includes("@Mobile") && tags.includes("@Chrome")) { mobileChromeRCCounter++; }
            if (tags.includes("@Mobile") && !tags.includes("@Desktop") ) { mobileOnlyCounter++; }
            if (tags.includes("@MobilePending")) { mobilePendingCounter++; }
            if (tags.includes("@FullRegression") && tags.includes("@Mobile") && tags.includes("@Safari")) { mobileSafariFullCounter++; }
            if (tags.includes("@Sprint") && tags.includes("@Mobile") && tags.includes("@Safari")) { mobileSafariSprintCounter++; }
            if (tags.includes("@SafariPending")) { safariPendingCounter++; }
        }
         
        workSheet.addRow([features[featureCounter].name, features[featureCounter].elements.length, desktopChromeFullCounter, desktopChromeSprintCounter, desktopChromeRCCounter, desktopFirefoxFullCounter, desktopFirefoxSprintCounter, desktopOnlyCounter, desktopChromeFullCounter + desktopChromeSprintCounter, mobileChromeFullCounter, mobileChromeSprintCounter, mobileChromeRCCounter, mobileOnlyCounter, mobilePendingCounter, mobileChromeFullCounter+mobileChromeSprintCounter+mobilePendingCounter, mobileSafariFullCounter, mobileSafariSprintCounter, safariPendingCounter, mobileSafariFullCounter+mobileSafariSprintCounter+safariPendingCounter]);
        workSheet.getCell(`T${featureCounter+4}`).value = {formula: `IF(O${featureCounter+4} = 0, "N/A", (J${featureCounter+4} + K${featureCounter+4})/O${featureCounter+4})`};
        workSheet.getCell(`U${featureCounter+4}`).value = {formula: `IF(S${featureCounter+4} = 0, "N/A", (P${featureCounter+4} + Q${featureCounter+4})/S${featureCounter+4})`};
        setRowFormat(workSheet, featureCounter+4);
        
    }
}

function addSummary(workSheet) {
    let summaryRowNumber = featureCounter + 5;
    let statsRowNumber = summaryRowNumber+1;
    workSheet.addRow([""]);
    workSheet.addRow(["Feature", "Total Count", "Full Regression", "Sprint", "RCtest", "Full Regression", "Sprint", "Desktop Only", "Max coverage", "Full Regression", "Sprint", "RCtest", "Mobile only", "Mobile Pending", "Max coverage", "Full Regression", "Sprint", "Safari Pending", "Max coverage", "Android real coverage", "Ios real coverage"]);
    workSheet.getRow(summaryRowNumber).alignment = {horizontal: 'left'}; 
    workSheet.getRow(summaryRowNumber).font = {size: 8, bold: true}; 
    const statsRow = workSheet.getRow(statsRowNumber);
    let char = 'B';
    for (let i=2; i<=19; i++) {
        statsRow.getCell(i).value = { formula: `SUM(${char}4:${char}${featureCounter+3})` };
        statsRow.getCell(i).font = {size: 8};
        char = String.fromCharCode(char.charCodeAt(0) + 1).toUpperCase();
    }
    workSheet.getCell(`T${statsRowNumber}`).value = {formula: `(J${statsRowNumber} + K${statsRowNumber})/O${statsRowNumber}`};
    workSheet.getCell(`T${statsRowNumber}`).font = {size: 8, bold: true};
    workSheet.getCell(`T${statsRowNumber}`).numFmt = '0.00%';
    workSheet.getCell(`U${statsRowNumber}`).value = {formula: `(P${statsRowNumber} + Q${statsRowNumber})/S${statsRowNumber}`};
    workSheet.getCell(`U${statsRowNumber}`).font = {size: 8, bold: true};
    workSheet.getCell(`U${statsRowNumber}`).numFmt = '0.00%';
    workSheet.addConditionalFormatting({
        ref: `T${statsRowNumber}:U$${statsRowNumber}`,
        rules: [
          {
            type: 'cellIs',
            formulae: ['=0.25'],
            operator: "lessThan",
            style: {fill: {type: 'pattern', pattern: 'solid', bgColor: {argb: 'FFFF0000'}}},
          }, 
          {
            type: 'cellIs',
            formulae: ['=0.9', '=1'],
            operator: "between",
            style: {fill: {type: 'pattern', pattern: 'solid', bgColor: {argb: 'FF00FF00'}}},
          }, 
          {
            type: 'cellIs',
            formulae: ['=0.25', '=0.9'],
            operator: "between",
            style: {fill: {type: 'pattern', pattern: 'solid', bgColor: {argb: 'FFFFA500'}}},
          }, 
        ]
      })
}

function setRowFormat(workSheet, rowNumber) {
    workSheet.getRow(rowNumber).font = {size: 8};
    workSheet.getRow(rowNumber).alignment = {horizontal: 'right'}; 
    workSheet.getCell(`T${rowNumber}`).numFmt = '0.00%';
    workSheet.getCell(`U${rowNumber}`).numFmt = '0.00%';
}

function setColumnWidth(workSheet){
    workSheet.getColumn(1).width = 30;
    for(let i=2; i<=19; i++) {
        workSheet.getColumn(i).width = 12;
    }
    workSheet.getColumn(20).width = 15;
    workSheet.getColumn(21).width = 15;
}

function setViewScale(workSheet){
    workSheet.views = [{zoomScale: 80}];
}

function addConditionalFormatting(workSheet) {
    workSheet.addConditionalFormatting({
        ref: `T4:U${featureCounter+3}`,
        rules: [
          {
            type: 'cellIs',
            formulae: ['=0.25'],
            operator: "lessThan",
            style: {fill: {type: 'pattern', pattern: 'solid', bgColor: {argb: 'FFFF0000'}}},
          }, 
          {
            type: 'cellIs',
            formulae: ['=0.9', '=1'],
            operator: "between",
            style: {fill: {type: 'pattern', pattern: 'solid', bgColor: {argb: 'FF00FF00'}}},
          }, 
          {
            type: 'cellIs',
            formulae: ['=0.25', '=0.9'],
            operator: "between",
            style: {fill: {type: 'pattern', pattern: 'solid', bgColor: {argb: 'FFFFA500'}}},
          }, 
        ]
      })
}

function getDate() {
  const today = new Date();
  const dd = String(today.getDate()).padStart(2, '0');
  const mm = String(today.getMonth() + 1).padStart(2, '0');
  const yy = today.getFullYear().toString().substr(-2);
  return dd + '_' + mm + '_' + yy;
}
