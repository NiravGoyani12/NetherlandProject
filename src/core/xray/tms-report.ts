/* eslint-disable import/no-unresolved */
/* eslint-disable max-len */
import fs from 'fs';

/* extract unique tms tags from executed scenarios */
function getTmsTags() {
  const scenarios = require('../../../scenarios.json');
  const internalTmsTags: string[] = [];
  for (let featureCounter = 0; featureCounter < scenarios.length; featureCounter += 1) {
    for (let scenarioCounter = 0; scenarioCounter < scenarios[featureCounter].elements.length; scenarioCounter += 1) {
      const tags: string[] = [];
      scenarios[featureCounter].elements[scenarioCounter].tags
        .forEach((element) => tags.push(element.name));
      let utrId;

      /** Check if @tms:UTR is found within the tags array. If yes, store it and return true for the variable "utrMatch" */
      const utrMatch = tags.find((findTag) => {
        if (findTag.includes('@tms:UTR')) {
          utrId = findTag;
          return true;
        }
        return false;
      });

      /** Check if @Analytics is found within the tags array. */
      const analyticsMatch = tags.find((findTag) => {
        if (findTag.includes('@Analytics')) {
          return true;
        }
        return false;
      });

      /** If analyticsMatch and utrMatch are both true, store utrId and set analytics value to true */
      if (analyticsMatch && utrMatch) {
        internalTmsTags.push(`{"id": "${utrId.split(':')[1]}", "analytics": true, "project": "analytics"}`);
      }

      /** If the variable analyticsMatch is true and it is non-UTR project, then store TMS ID and set analytics value to true */
      if (analyticsMatch && !utrMatch) {
        tags.forEach((tag) => {
          if (tag.indexOf('@tms:') >= 0) {
            internalTmsTags.push(`{"id": "${tag.split(':')[1]}", "analytics": true}`);
          }
        });
      }

      /**
       * If analyticsMatch is false and utrMatch is true, store utrId based on which project tag is found.
       * Otherwise, find the tms tag and store it
       */
      if (!analyticsMatch && utrMatch) {
        tags.forEach((tag) => {
          switch (tag) {
            case '@UnifiedExperience':
              internalTmsTags.push(`{"id": "${utrId.split(':')[1]}", "analytics": false, "project": "eesk"}`);
              break;
            case '@UnifiedCheckout':
              internalTmsTags.push(`{"id": "${utrId.split(':')[1]}", "analytics": false, "project": "eesck"}`);
              break;
            case '@UnifiedMyAccount':
              internalTmsTags.push(`{"id": "${utrId.split(':')[1]}", "analytics": false, "project": "ppl"}`);
              break;
            default:
              break;
          }
        });
      }

      /**
       * If analyticsMatch and utrMatch are both false, store tms id.
       */
      if (!analyticsMatch && !utrMatch) {
        tags.forEach((tag) => {
          if (tag.indexOf('@tms:') >= 0) {
            internalTmsTags.push(`{"id": "${tag.split(':')[1]}", "analytics": false}`);
          }
        });
      }
    }
  }

  const uniqueTmsTags = [...new Set(internalTmsTags)];
  return JSON.parse(`[${uniqueTmsTags}]`);
}

/* get test execution status from every tms tag */
function getTmsResults() {
  const allureResults = fs.readdirSync('allure-results').filter((fn) => fn.endsWith('-result.json'));
  const history = {};
  /* find all execution statutes for unique history id (unique scenario) */
  allureResults.forEach((result) => {
    const resultJson = JSON.parse((fs.readFileSync(`allure-results/${result}`)).toString());
    const { status, historyId } = resultJson;
    let tmsTag = '';
    resultJson.labels.forEach((label) => {
      if (!tmsTag && label.value.indexOf('@tms') >= 0) {
        // eslint-disable-next-line prefer-destructuring
        tmsTag = label.value.split(':')[1];
      }
    });
    if (tmsTag) {
      if (!history[historyId]) {
        history[historyId] = [];
      }
      history[historyId].push({ id: tmsTag, status });
    }
  });
  /* save final execution status for every unique scenario  */
  const resultList = [];
  Object.entries(history).forEach((entry: [string, any[]]) => {
    const result = entry[1].find((r) => r.status === 'passed');
    if (result) {
      resultList.push(result);
    } else {
      resultList.push(entry[1][0]);
    }
  });
  return resultList;
}

/* map tms-tags and tms-results */
function generateTmsReport(
  tmsTags: { id: string, analytics: boolean, project: string }[],
  tmsResults: { id: string, status: string, project: string }[],
) {
  /* map tms tags and tms results, and create temporary tms report
  output is the array of objects
  [{"id": "ABC-123", "analytics": true, "status": "FAIL"}] */
  const tmsReport = [];
  tmsTags.forEach((tag) => {
    const matches = tmsResults.filter((result) => result.id === tag.id);
    let status: 'FAIL' | 'PASS' | 'ABORTED';
    if (matches.length > 0) {
      status = (matches.findIndex((match) => match.status === 'failed') >= 0) ? 'FAIL' : 'PASS';
    } else {
      status = 'ABORTED'; // assign status to ABORTED if tms not found in allure results
    }
    const result: { id: string, analytics?: boolean, project?: string, status: string } = {
      id: tag.id,
      analytics: tag.analytics,
      project: tag.project,
      status,
    };
    tmsReport.push(result);
  });
  const finalReport = {
    UTR_UnifiedExperience: [],
    UTR_UnifiedCheckout: [],
    UTR_PPL: [],
  };
  /* place every result in correct board
  remove temporary analytics property */
  tmsReport.forEach((result) => {
    if (result.id.indexOf('EECK') >= 0) {
      if (result.analytics) {
        delete result.analytics;
        // finalReport.EECK_analytics.push(result);
      } else {
        delete result.analytics;
        // finalReport.EECK.push(result);
      }
    } else if (result.id.indexOf('EESCK') >= 0) {
      if (result.analytics) {
        delete result.analytics;
        // finalReport.EESCK_analytics.push(result);
      } else {
        delete result.analytics;
        // finalReport.EESCK.push(result);
      }
    } else if (result.id.indexOf('TEX') >= 0) {
      if (result.analytics) {
        delete result.analytics;
        // finalReport.TEX_analytics.push(result);
      } else {
        delete result.analytics;
        // finalReport.TEX.push(result);
      }
    } else if (result.id.indexOf('EED') >= 0) {
      if (result.analytics) {
        delete result.analytics;
        // finalReport.EED_analytics.push(result);
      } else {
        delete result.analytics;
        // finalReport.EED.push(result);
      }
    } else if (result.id.indexOf('EER') >= 0) {
      if (result.analytics) {
        delete result.analytics;
        // finalReport.EER_analytics.push(result);
      } else {
        delete result.analytics;
        // finalReport.EER.push(result);
      }
    } else if (result.id.indexOf('TED') >= 0) {
      if (result.analytics) {
        delete result.analytics;
        // finalReport.TED_analytics.push(result);
      }
    } else if (result.id.indexOf('TEE') >= 0) {
      delete result.analytics;
      // finalReport.TEE.push(result);
    } else if (result.id.indexOf('EEI') >= 0) {
      delete result.analytics;
      // finalReport.EEI.push(result);
    } else if (result.id.indexOf('UTR') >= 0) {
      delete result.analytics;
      if (result.project.indexOf('eesk') >= 0) {
        finalReport.UTR_UnifiedExperience.push(result);
      } else if (result.project.indexOf('eesck') >= 0) {
        finalReport.UTR_UnifiedCheckout.push(result);
      } else if (result.project.indexOf('ppl') >= 0) {
        finalReport.UTR_PPL.push(result);
      }
    }
  });
  fs.writeFileSync('./tms-report.json', JSON.stringify(finalReport));
}

const tmsTags = getTmsTags();
const tmsResults = getTmsResults();
generateTmsReport(tmsTags, tmsResults);
