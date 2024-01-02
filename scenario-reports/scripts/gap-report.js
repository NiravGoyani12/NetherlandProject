const Excel = require('exceljs');
const features = require('../output/all-features.json');

const workbook = new Excel.Workbook();
const workSheet = workbook.addWorksheet('Gap scenarios');
const gapTags = ['@TEX-GAP', '@EECK-GAP', '@EESK-GAP', '@EED/SWAT-GAP', '@EER-GAP'];

tableSetup(workSheet);
fillData(workSheet);
setColumnWidth(workSheet);
workbook.xlsx.writeFile(`scenario-reports/output/${getDate()}_Gap_Analysis_Report.xlsx`);

function tableSetup(workSheet) {
  workSheet.addRow(["", "Desktop Chrome", "Mobile Chrome", "Mobile Safari", "Tablet Chrome", "Total"]);
  workSheet.getRow(1).alignment = { horizontal: 'center' };
  workSheet.getRow(1).font = { size: 10, bold: true };
}

function fillData(workSheet) {
  for (let rowCounter = 0; rowCounter < gapTags.length; rowCounter++) {
    let gapTotalCounter = 0;
    let gapDesktopCounter = 0;
    let gapMobileCounter = 0;
    let gapIosCounter = 0;
    let gapTabletCounter = 0;
    for (let featureCounter = 0; featureCounter < features.length; featureCounter++) {
      for (let scenarioCounter = 0; scenarioCounter < features[featureCounter].elements.length; scenarioCounter++) {
        tags = [];
        features[featureCounter].elements[scenarioCounter].tags.forEach(element => tags.push(element.name));
        if (tags.includes(gapTags[rowCounter]) && tags.includes("@Desktop") && tags.includes("@Chrome")) { gapDesktopCounter++; gapTotalCounter++;}
        if (tags.includes(gapTags[rowCounter]) && tags.includes("@Mobile") && tags.includes("@Chrome")) { gapMobileCounter++; gapTotalCounter++;}
        if (tags.includes(gapTags[rowCounter]) && tags.includes("@Mobile") && tags.includes("@Safari")) { gapIosCounter++; gapTotalCounter++;}
        if (tags.includes(gapTags[rowCounter]) && tags.includes("@Tablet") && tags.includes("@Chrome")) { gapTabletCounter++; gapTotalCounter++;}
      }
    }
    workSheet.addRow([gapTags[rowCounter], gapDesktopCounter, gapMobileCounter, gapIosCounter, gapTabletCounter, gapTotalCounter]);
    workSheet.getRow(rowCounter + 2).font = {size: 10};
  }
}

function setColumnWidth(workSheet){
  for(let i=1; i<=6; i++) {
      workSheet.getColumn(i).width = 15;
  }
}

function getDate() {
  const today = new Date();
  const dd = String(today.getDate()).padStart(2, '0');
  const mm = String(today.getMonth() + 1).padStart(2, '0');
  const yy = today.getFullYear().toString().substr(-2);
  return dd + '_' + mm + '_' + yy;
}