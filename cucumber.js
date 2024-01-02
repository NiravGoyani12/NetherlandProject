var BRAND = '';

if (process.env.Brand) {
  BRAND = process.env.Brand.trim();
} else if (process.env.brand) {
  BRAND = process.env.brand.trim();
} else {
  BRAND = 'th';
}

console.log(`Running against ${BRAND}`);
if (BRAND !== 'th' && BRAND !== 'ck') {
  throw new Error(`We do NOT support to run against ${BRAND}`);
}

let dryrun = [
  `features/**/*.feature`,
  '--require-module ts-node/register',
  '--require ./src/test/**/*.steps.ts',
  '--require ./src/test/**/*.supports.ts',
  '--format summary',
  '--dry-run'
].join(' ');

let dryrunprod = [
  `features/**/*.feature`,
  '--require ./build/test/**/*.steps.js',
  '--require ./build/test/**/*.supports.js',
  '--format summary',
  '--dry-run'
].join(' ');

let debug = [
  `features/**/*.feature`,
  '--require-module ts-node/register',
  '--require ./src/test/**/*.steps.ts',
  '--require ./src/test/**/*.supports.ts',
  '--format progress-bar',
  '--tags @torun'
].join(' ');

let debugprod = [
  `features/**/*.feature`,
  '--require ./build/test/**/*.steps.js',
  '--require ./build/test/**/*.supports.js',,
  '--format ./build/test/supports/reporter.js',
  '--format rerun:rerun.txt',
  '--tags "@Search"',
  '--parallel 2'
].join(' ');

let debugrerun = [
  '--require ./build/test/**/*.steps.js',
  '--require ./build/test/**/*.supports.js',
  '--format ./build/test/supports/reporter.js',
  '--format ./build/test/supports/smart-rerun-formatter.js:rerun.txt',
  '--tags "@torun"',
  '--parallel 2'
].join(' ');

let rerun = [
  '--require ./build/test/**/*.steps.js',
  '--require ./build/test/**/*.supports.js',
  '--format ./build/test/supports/reporter.js',
  '--format ./build/test/supports/smart-rerun-formatter.js:rerun.txt',
  '--parallel 6'
].join(' ');

let prod = [
  `features/**/*.feature`,
  '--require ./build/test/**/*.steps.js',
  '--require ./build/test/**/*.supports.js',
  '--format ./build/test/supports/reporter.js',
  '--format ./build/test/supports/smart-rerun-formatter.js:rerun.txt',
  //'--retry 1',
  '--parallel 6'
].join(' ');

let prodci = [
  `features/**/*.feature`,
  '--require ./build/test/**/*.steps.js',
  '--require ./build/test/**/*.supports.js',
  '--format summary',
  '--format ./build/test/supports/smart-rerun-formatter.js:rerun.txt',
  '--parallel 1',
].join(' ');

let rerunxray = [
  '--require ./build/test/**/*.steps.js',
  '--require ./build/test/**/*.supports.js',
  '--format summary',
  '--format json:scenarios.json',
  '--dry-run'
].join(' ');

let dryrunxray = [
  `features/**/*.feature`,
  '--require ./build/test/**/*.steps.js',
  '--require ./build/test/**/*.supports.js',
  '--format summary',
  '--format json:scenarios.json',
  '--dry-run'
].join(' ');

let usage = [
  `features/**/*.feature`,
  '--require ./build/test/**/*.steps.js',
  '--require ./build/test/**/*.supports.js',
  '--format summary',
  `--format json:./scenario-reports/output/${BRAND}-scenarios.json`,
  `--format usage-json:./scenario-reports/output/${BRAND}-usage.json`,
  '--dry-run'
].join(' ');

let getscenarios = [
  `features/**/*.feature`,
  '--require ./build/test/**/*.steps.js',
  '--require ./build/test/**/*.supports.js',
  '--format summary',
  `--format json:./scenario-reports/output/${BRAND}-scenarios.json`,
  '--dry-run'
].join(' ');

module.exports = {
  debug: debug,
  debugprod: debugprod,
  debugrerun: debugrerun,
  prod: prod,
  rerun: rerun,
  dryrun: dryrun,
  dryrunprod: dryrunprod,
  rerunxray: rerunxray,
  dryrunxray: dryrunxray,
  usage: usage,
  prodci: prodci,
  getscenarios: getscenarios
};