const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');

const execCommand = (cmd, filePath = '', auditLogging = false) => {
  exec(
    cmd,
    { windowsHide: true, encoding: 'buffer', maxBuffer: 1024 * 1024 * 512 },
    (error, stdout, stderr) => {
      let output = stdout.toString();

      if (auditLogging) {
        const out = output.match(/\d+ vulnerabilit.*/g);
        if (out && out.length > 0) {
          const startIndex = out.findIndex(o => o.indexOf('scanned packages') >= 0);
          for (let i = 0; i < startIndex; i+=1) {
            out.splice(0,1);
          }
          out.forEach(function(ele, index) {this[index] += ' \n'}, out);
          output = out.join('');
          console.log(output);
        }
      } else {
        console.log(output);
      }

      if (filePath !== '') {
        try {
          fs.writeFileSync(filePath, output, { flag: 'w' });
        } catch (e) {
          console.log(`Couldn't write ${filePath}`, e);
        }
      }
    },
  );
};

execCommand('npm outdated --long --json', './package-report-outdated.json');

execCommand('npm audit', './package-report-audit.txt', true);
