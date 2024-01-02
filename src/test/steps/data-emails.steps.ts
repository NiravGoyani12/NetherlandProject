import { Then } from '@pvhqa/cucumber';
import { expect } from 'chai';
import services from '../../core/services';
import { GetTestLogger } from '../../core/logger/test.logger';

const jenkinsOffset = -120; // -60 for winter time and -120 for summer time

Then(/I see forgot password email for "(.*)" is triggered(?: in (\d+) seconds?)?/, async (email: string, timeoutInSec?: number) => {
  email = services.account.parse(email);
  const localeCode = services.site.locale.toUpperCase();
  const brand = services.env.Brand === 'ck' ? `CalvinKlein${localeCode}` : `Tommy${localeCode}`;

  const delayInMiliseconds = 5 * 1000;
  const dateNow = new Date(Date.now());
  let offset;
  if (process.env.CUCUMBER_PARALLEL === 'true') {
    // If it is running from Jenkins, use Jenkins time
    offset = jenkinsOffset;
  } else {
    offset = dateNow.getTimezoneOffset();
  }
  const dateTimeFiveSecondsAgo = new Date(Date.now() - delayInMiliseconds - offset * 1000 * 60);
  const dateToSearchFrom = dateTimeFiveSecondsAgo.toISOString().replace('T', ' ').replace('Z', '');

  const response = await browser.waitUntilResult(async () => {
    const r = await services.triggeredEmailsDB
      .getForgotPasswordTriggeredEmails(dateToSearchFrom, brand);
    if (r && r.length > 0) {
      GetTestLogger().info(`DB response is: ${r}`);
      return r;
    }
    await browser.refresh();
    return undefined;
  }, `Cannot get responce from DB in ${timeoutInSec} seconds. Search from time ${dateToSearchFrom}`, timeoutInSec * 1000, 5000);

  expect(response).not.to.equal(null);
  expect(response).not.to.equal(undefined);
  expect(response.length, `Expected to get 1 record, but got ${response.length} instead. Date to search from is ${dateToSearchFrom}`).to.be.equal(1);
  const isTriggered = response[0].S_FORCE_RESPONSE === 202;
  expect(isTriggered, `Expected to see DB record for forgot pasword email for user ${email}`).to.be.true;
});


Then(/I see order confirmation email for "(.*)" for order (.*) is triggered(?: in (\d+) seconds?)?/, async (email: string, orderNumber: string, timeoutInSec?: number) => {
  email = services.account.parse(email);
  orderNumber = services.world.parse(orderNumber);
  const localeCode = services.site.locale.toUpperCase();
  const brand = services.env.Brand === 'ck' ? `CalvinKlein${localeCode}` : `Tommy${localeCode}`;

  const delayTenSecondsInMs = 10 * 1000; // might be payment delay, we're checking request time
  const dateNow = new Date(Date.now());
  let offset;
  if (process.env.CUCUMBER_PARALLEL === 'true') {
    // If it is running from Jenkins, use Jenkins time, adjust when changing to summer/winter time
    offset = jenkinsOffset;
  } else {
    offset = dateNow.getTimezoneOffset();
  }
  const dateTimeFiveSecondsAgo = new Date(dateNow.valueOf()
    - delayTenSecondsInMs - offset * 1000 * 60);
  const dateToSearchFrom = dateTimeFiveSecondsAgo.toISOString().replace('T', ' ').replace('Z', '');

  const response = await browser.waitUntilResult(async () => {
    const r = await services.triggeredEmailsDB
      .getOrderConfirmationTriggeredEmails(dateToSearchFrom, orderNumber, brand);
    if (r && r.length > 0) {
      GetTestLogger().info(`DB response is: ${r}`);
      return r;
    }
    await browser.refresh();
    return undefined;
  }, `Cannot get responce from DB in ${timeoutInSec} seconds, order number is ${orderNumber}. Time: ${dateToSearchFrom}`, timeoutInSec * 1000, 5000);

  expect(response).not.to.equal(null);
  expect(response).not.to.equal(undefined);
  expect(response.length, `Expected to get 1 record for order number ${orderNumber}, but got ${response.length} instead. Date to search from is ${dateToSearchFrom}`).to.be.equal(1);
  const isTriggered = response[0].S_FORCE_RESPONSE === 202;
  const orderIdFromDB = response[0].ORDERS_ID;
  expect(isTriggered, `Expected to see DB record for order confirmation email for user ${email}, order number is ${orderNumber}`).to.be.true;
  expect(orderNumber).to.contain(orderIdFromDB,
    `Expected order number "${orderNumber}" from FE to contain "${orderIdFromDB}" order ID from DB for user ${email}`);
});

Then(/I see registration email for "(.*)" is triggered(?: in (\d+) seconds?)?/, async (email: string, timeoutInSec?: number) => {
  email = services.account.parse(email);
  const localeCode = services.site.locale.toUpperCase();
  const brand = services.env.Brand === 'ck' ? `CalvinKlein${localeCode}` : `Tommy${localeCode}`;

  const delayInMiliseconds = 3 * 1000;
  const dateNow = new Date(Date.now());
  const offset = dateNow.getTimezoneOffset();
  const dateTimeThreeSecondsAgo = new Date(Date.now() - delayInMiliseconds - offset * 1000 * 60);
  const dateToSearchFrom = dateTimeThreeSecondsAgo.toISOString().replace('T', ' ').replace('Z', '');

  const response = await browser.waitUntilResult(async () => {
    const r = await services.triggeredEmailsDB
      .getRegistrationTriggeredEmails(dateToSearchFrom, brand);
    if (r && r.length > 0) {
      GetTestLogger().info(`DB response is: ${r}`);
      return r;
    }
    await browser.refresh();
    return undefined;
  }, `Cannot get responce from DB in ${timeoutInSec} seconds.Search from time ${dateToSearchFrom}`, timeoutInSec * 1000, 5000);

  expect(response).not.to.equal(null);
  expect(response).not.to.equal(undefined);
  expect(response.length, `Expected to get 1 record, but got ${response.length} instead. Date to search from is ${dateToSearchFrom}`).to.be.equal(1);
  const isTriggered = response[0].S_FORCE_RESPONSE === 202;
  expect(isTriggered, `Expected to see DB record for registration email for user ${email}`).to.be.true;
});
