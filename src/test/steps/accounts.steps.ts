/* eslint-disable import/prefer-default-export */
import { Given, When, TableDefinition } from '@pvhqa/cucumber';
import randomstring from 'randomstring';
import services from '../../core/services';
import { sleep } from '../helper/utils.helper';
import wcs from '../../core/wcs';

Given(/There (?:is|are) (\d+) accounts?/, async (countOfAccounts: number) => {
  services.account.provideFakeAccount(countOfAccounts);
});

/**
 * This step can be used only after deep-link steps
 * Using 'with forced accepted cookies' is neccesary for preceeding deep-link step
 * All the steps after logging in should not touch cookies unless you want to clear login state
 */
// TODO: this step show error, cannot set cookies, should fix it
export const stepIAmLoggedInOrGuest = async (userType: string) => {
  if (userType === 'logged in') {
    services.account.provideFakeAccount(1);
    await (browser as any).setAuthCookies('user1#email', 'user1#password', true);
    await browser.refresh();
  }
};

When(/^I am a (logged in|guest) user$/, stepIAmLoggedInOrGuest);


/**
 * This step adds new address ONLY for registered user
 * It can be used ONLY after deep link step and after logging in
 * To use this step please follow the order of parameters:
 * | addressParameter | value      |
 * | zipCode          | 12345      |
 * | phoneNumber      | 0987654321 |
 * | province         | blabla     |
 * province and phoneNumber can have empty value
 */
When(/^I add new address for a logged in user with following parameters$/, async (table: TableDefinition) => {
  const cookies = await browser.getCookies();
  const baseUrl = `${services.site.baseUrl.split('/', 3).join('/')}/`;
  const storeId = services.site.siteInfo.STORE_ID.toString();
  const catalogId = services.site.siteInfo.CATALOG_ID.toString();
  const langId = services.site.siteInfo.LANGUAGE_ID.toString();
  const authToken = cookies.filter((c) => c.name.startsWith('WC_AUTHENTICATION'))[0].value;
  const memberId = authToken.split('%')[0];
  let zipCode = table.rows()[0][1] || '';
  const phoneNumber = table.rows()[1][1] || '';
  let province = table.rows()[2][1] || '';
  const country = (services.site.locale && services.site.locale !== 'uk') ? services.site.locale.toUpperCase() : 'GB';
  const nickName = `SHIPBILL_${memberId}_${storeId}_${langId}_${randomstring.generate(8)}`;
  const countryInfo = services.checkoutaddress.getCountryDetails(services.site.locale);

  if (zipCode === '#POSTCODE') {
    zipCode = countryInfo.postcode;
  }
  if (province === '#STATE') {
    province = countryInfo.province;
  }

  const formattedCookies = cookies.map((c) => `${c.name}=${c.value}`);
  try {
    await wcs.addAddress(
      baseUrl, storeId, catalogId, langId, authToken, memberId,
      zipCode, phoneNumber, province, country, nickName, formattedCookies,
    );
    await sleep(1000);
  } catch (e) {
    throw new Error(`New address was not created because of the error: 
    ${e}
    Original error message: ${e.response.body.errors ? e.response.body.errors[0].errorMsg : 'error message not avalable'}`);
  }
});

/**
 * This step adds new address ONLY for registered user
 * It can be used ONLY after deep link step and after logging in
 * To use this step please follow the order of parameters:
 * | infoParameter    | value            |
 * | firstName        | 0987654321       |
 * | lastName         | blabla           |
 */
When(/^I update user info for a logged in user with following parameters$/, async (table: TableDefinition) => {
  const cookies = await browser.getCookies();
  const formattedCookies = cookies.map((c) => `${c.name}=${c.value}`);
  const baseUrl = `${services.site.baseUrl.split('/', 3).join('/')}/`;
  const storeId = services.site.siteInfo.STORE_ID.toString();
  const firstName = table.rows()[0][1] || '';
  const lastName = table.rows()[1][1] || '';
  try {
    await wcs.updateUserInfo(
      baseUrl, storeId, formattedCookies, 'male', firstName, lastName,
    );
    await sleep(1000);
  } catch (e) {
    throw new Error(`New address was not created because of the error: 
    ${e}
    Original error message: ${e.response.body.errors ? e.response.body.errors[0].errorMsg : 'error message not avalable'}`);
  }
});
