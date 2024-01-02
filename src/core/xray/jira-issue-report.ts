/* eslint-disable no-await-in-loop */
/* eslint-disable import/no-unresolved */
import got from 'got/dist/source';
import fs from 'fs';

const ckFeatures = require('../../../output/ck-all-features.json');
const thFeatures = require('../../../output/th-all-features.json');

function getKnownIssues(brand: string) {
  const features = brand === 'ck' ? ckFeatures : thFeatures;
  const knownIssues: string[] = [];
  for (let featureCounter = 0; featureCounter < features.length; featureCounter += 1) {
    for (let scenarioCounter = 0;
      scenarioCounter < features[featureCounter].elements.length;
      scenarioCounter += 1) {
      const tags: string[] = [];
      features[featureCounter].elements[scenarioCounter].tags.forEach(
        (element) => tags.push(element.name),
      );
      tags.forEach((tag) => {
        if (tag.indexOf('@issue:') >= 0) {
          knownIssues.push(tag.split(':')[1]);
        }
      });
    }
  }
  const uniqueTmsTags = [...new Set(knownIssues)];
  return uniqueTmsTags;
}

async function getStatus(issueId: string) {
  const auth = process.env.QA_ENV_JIRA_BASIC;
  const client = got.extend({
    headers: {
      Authorization: auth,
    },
  });
  return client.get<any>(`https://pvhcorp.atlassian.net/rest/api/2/issue/${issueId}?fields=status,versions,issuetype,created`, { responseType: 'json' });
}

async function parseIssues(issueArr: string[]) {
  let jsonStr = '';
  for (let i = 0; i < issueArr.length; i += 1) {
    let issueStatus: string;
    let issueType: string;
    let reportedDate: string;
    const issueVersions = [];
    try {
      const responseFields = (await getStatus(issueArr[i])).body.fields;
      issueStatus = responseFields.status.name;
      issueType = responseFields.issuetype.name;
      reportedDate = new Date(responseFields.created).toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' });
      if (responseFields.versions.length > 0) {
        responseFields.versions.forEach((version) => {
          issueVersions.push(version.name);
        });
      } else {
        issueVersions.push('No affected versions');
      }
    } catch (e) {
      issueStatus = `Failed to get status due to${e.toString().split(':')[1].split(')')[0]})`;
      issueType = 'N/A';
      reportedDate = 'N/A';
      issueVersions.push('N/A');
    }
    jsonStr += `{"id" : "${issueArr[i]}", "status" : "${issueStatus}", "type": "${issueType}", "createdDate": "${reportedDate}", "version": "${issueVersions.join(',')}"},`;
  }
  jsonStr = jsonStr.slice(0, -1);
  return jsonStr;
}

async function createJson() {
  const ckIssues = getKnownIssues('ck');
  const thIssues = getKnownIssues('th');
  let data = '{"ckIssues" : [';
  data += await parseIssues(ckIssues);
  data += '], "thIssues" : [';
  data += await parseIssues(thIssues);
  data += ']}';
  fs.writeFileSync('./output/known-issues.json', data);
}

createJson();
