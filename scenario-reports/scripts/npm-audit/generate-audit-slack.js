const path = require('path');
const fs = require('fs');

const slackMessageBody = [];

// Slack message title
const slackMessageTitle = {
  pretext: `E2E Test NPM AUDIT Report. ${new Date().toLocaleDateString()}`
};
slackMessageBody.push(slackMessageTitle);

// Npm audit summary
if (fs.existsSync(path.resolve(process.cwd(), './package-report-audit.txt'))) {
  const fileData = fs.readFileSync(path.resolve(process.cwd(), './package-report-audit.txt'));
  const data = fileData.toString();
  const icon = data.startsWith('0 v') ? ':white_check_mark:' : ':x:';
  let packageAudit = '*Package Audit* \n';
  packageAudit += `${icon} ${data}`;
  packageAudit += '\n For more detailed report run `npm audit` locally';
  const packageAuditSlack = {
    text: packageAudit
  };
  slackMessageBody.push(packageAuditSlack);
};

// Attach all outdated packages and versions
const reportPath = path.resolve(process.cwd(), './package-report-outdated.json');
const reportData = require(`${reportPath}`);
const reportDataArray = Object.entries(reportData);

let dependencyCounter = 0;
let devDependencyCounter = 0;
const reportTitle = {
  fields: [
    {
      value: 'Dependency name',
      short: true,
    },
    {
      value: `Current version >> Latest version`,
      short: true,
    }
  ]
};
slackMessageBody.push(reportTitle);

reportDataArray.forEach(entry => {
  const [label, data] = entry;
  const dependencyType = data.type;
  if (dependencyType.indexOf('devDependencies') >= 0) {
    devDependencyCounter += 1;
  } else {
    dependencyCounter += 1;
  }
  const outdatedPackage = {
    fields: [
      {
        value: label,
        short: true,
      },
      {
        value: `${data.current} >> ${data.latest}`,
        short: true,
      }
    ]
  }
  slackMessageBody.push(outdatedPackage);
});

// Attach summary of outdated packages
const reportText = {
  text: `*Outdated Package report*
   Dependencies: ${dependencyCounter} package${dependencyCounter > 1 ? 's' : ''} outdated.
   Dev dependencies: ${devDependencyCounter} package${devDependencyCounter > 1 ? 's' : ''} outdated.  \n`
};
slackMessageBody.splice(2, 0, reportText);

const slackMessage = { attachments: slackMessageBody };

try {
  fs.writeFileSync('./npm-audit-slack.json', JSON.stringify(slackMessage), { flag: 'w' });
} catch (e) {
  console.log(`Couldn't write outdated package report file`, e);
}