const fs = require('fs');
const path = require('path');

let output = '';

// Npm outdated packages
const reportPath = path.resolve(process.cwd(), './package-report-outdated.json');
const reportData = require(`${reportPath}`);
const reportDataArray = Object.entries(reportData);

let dependencyCounter = 0;
let devDependencyCounter = 0;

reportDataArray.forEach(entry => {
  const [label, data] = entry;
  const dependencyType = data.type;
  if (dependencyType.indexOf('devDependencies') >= 0) {
    devDependencyCounter += 1;
  } else {
    dependencyCounter += 1;
  }
});
output = `**Outdated Package report**  <br />
   Dependencies: ${dependencyCounter} package${dependencyCounter > 1 ? 's' : ''} outdated.  <br />
   Dev dependencies: ${devDependencyCounter} package${devDependencyCounter > 1 ? 's' : ''} outdated.  <br />`;

// Npm audit summary
if (fs.existsSync(path.resolve(process.cwd(), './package-report-audit.txt'))) {
  const fileData = fs.readFileSync(path.resolve(process.cwd(), './package-report-audit.txt'));
  const data = fileData.toString();
  const icon = data.startsWith('0 v') ? ':white_check_mark:' : ':x:';
  output += '  <br />**Package Audit**  <br />';
  output += `${icon} ${data.replace('\n', '  <br />')}`;
}

try {
  fs.writeFileSync('./npm_audit_report.log', output, { flag: 'w' });
} catch (e) {
  console.log(`Couldn't write npm_audit_report.log file`, e);
}
