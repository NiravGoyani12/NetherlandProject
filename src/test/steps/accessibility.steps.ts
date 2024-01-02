/* eslint-disable no-console */
import { Then } from '@pvhqa/cucumber';
import { expect } from 'chai';
import services from '../../core/services';

const AxeBuilder = require('@axe-core/webdriverio').default;

Then(/I scan the page|component ([^\s]+)(?: with (?:args|value|text|index|data-testid) (.*))? for accessibility violations$/, async (elementPath: string, args: string) => {
  let results: any;
  let selector: any;

  if (elementPath) {
    if (args) {
      args = services.world.parse(args);
      args = services.product.parse(args);
      selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
    } else {
      selector = await services.pageObject.getSelector(elementPath);
    }
    results = await new AxeBuilder({ client: browser })
      .include(selector) // Only CSS selectors are allowed
      .disableRules('color-contrast')
      .analyze();
  } else {
    results = await new AxeBuilder({ client: browser })
      .disableRules('color-contrast')
      .analyze();
  }

  const violationData = results.violations.map(({
    id, impact, description, nodes,
  }) => ({
    id,
    impact,
    description,
    nodes: nodes.length,
  }));

  if (violationData.length) {
    console.table(violationData);
  } else {
    console.log('No axe violations found');
  }

  expect(violationData.length, `Violations Details: \n ${results.violations.map((v) => `${v.id} - ${v.nodes.length} - ${v.impact} - ${v.description}`).join('\n')}`).to.equal(0);
});

Then(/^I verify ([^\s]+) accessibility rule for the (page|component)?(?: ([^\s]+) with (?:args|value|text|index) (.*))?/, async (ruleName: string, pageOrComponent: string, elementPath: string, args: string) => {
  let results: any;
  let selector: any;
  let rulesArray: string[];

  if (ruleName.includes(',')) {
    rulesArray = ruleName.split(',');
  }

  if (elementPath && pageOrComponent.indexOf('component') > 0) {
    if (args) {
      args = services.world.parse(args);
      args = services.product.parse(args);
      selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
    } else {
      selector = await services.pageObject.getSelector(elementPath);
    }
    results = await new AxeBuilder({ client: browser })
      .withRules(rulesArray || ruleName)
      .include(selector) // Only CSS selectors are allowed
      .analyze();
  } else {
    results = await new AxeBuilder({ client: browser })
      .withRules(rulesArray || ruleName)
      .analyze();
  }

  const violationData = results.violations.map(({
    id, impact, description, nodes,
  }) => ({
    id,
    impact,
    description,
    nodes: nodes.length,
  }));

  if (violationData.length) {
    console.table(violationData);
  } else {
    console.log('No axe violations found');
  }

  expect(violationData.length, `Violations Details: \n ${results.violations.map((v) => `${v.id} - ${v.nodes.length} - ${v.impact} - ${v.description}`).join('\n')}`).to.equal(0);
});
