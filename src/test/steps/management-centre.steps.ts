import { Given, When } from '@pvhqa/cucumber';
import services from '../../core/services';
import { maybeDisplayed$ } from '../general';
import { sleep } from '../helper/utils.helper';

Given(/I login in to management centre with username "(.*)" and password "(.*)"/, async (username: String, password: String) => {
  await browser.navigateTo('https://uat-live-cmc.stg.b2cecom.eu.pvh.cloud/lobtools/cmc/ManagementCenter');
  const userNameSelector = await services.pageObject.getSelector('ManagementCentre.Username');
  const passwordSelector = await services.pageObject.getSelector('ManagementCentre.Password');
  const loginButtonSelector = await services.pageObject.getSelector('ManagementCentre.LoginButton');
  const usernameElement = await maybeDisplayed$(userNameSelector);
  const passowrdElement = await maybeDisplayed$(passwordSelector);
  const LoginButtonElement = await maybeDisplayed$(loginButtonSelector);
  if (usernameElement && passowrdElement) {
    await usernameElement.safeType(username, true);
    await passowrdElement.safeType(password, true);
    await LoginButtonElement.safeClick();
  }
});

When(/I open "(.*)" in the management centre/, async (task: String) => {
  const hamburgSelector = await services.pageObject.getSelector('ManagementCentre.Hamburg');
  const systemAdministrationSelector = await services.pageObject.getSelector('ManagementCentre.SystemAdministration');
  const jobSelector = await services.pageObject.getSelector(`ManagementCentre.${task}`);
  const hamburgElement = await maybeDisplayed$(hamburgSelector);
  if (hamburgElement) {
    hamburgElement.safeClick();
    const SystemAdministrationElement = await maybeDisplayed$(systemAdministrationSelector);
    if (SystemAdministrationElement) {
      SystemAdministrationElement.safeClick();
      const jobElement = await maybeDisplayed$(jobSelector);
      if (jobElement) { jobElement.safeClick(); }
    }
  }
});

When(/I search for "(.*)" in the management centre/, async (jobName: String) => {
  const searchbarSelector = await services.pageObject.getSelector('ManagementCentre.Searchbar');
  const searchbarElement = await maybeDisplayed$(searchbarSelector);
  if (searchbarElement) {
    await searchbarElement.safeType(jobName, false);
  }
});

Given(/I login in to management centre with username "(.*)", password "(.*)" and run job "(.*)" in system admin task "(.*)"/, async (username: String, password: String, jobName: String, task: String) => {
  await sleep(1000);
  await browser.navigateTo('https://uat-live-cmc.stg.b2cecom.eu.pvh.cloud/lobtools/cmc/ManagementCenter');
  const userNameSelector = await services.pageObject.getSelector('ManagementCentre.Username');
  const passwordSelector = await services.pageObject.getSelector('ManagementCentre.Password');
  const loginButtonSelector = await services.pageObject.getSelector('ManagementCentre.LoginButton');
  const Iframeelector = await services.pageObject.getSelector('ManagementCentre.ManagementCentreIframeMain');
  const toolSelector = await services.pageObject.getSelector('ManagementCentre.tool', [jobName]);
  const saveButtonSelector = await services.pageObject.getSelector('ManagementCentre.button', ['Save']);
  const usernameElement = await maybeDisplayed$(userNameSelector);
  const passowrdElement = await maybeDisplayed$(passwordSelector);
  const LoginButtonElement = await maybeDisplayed$(loginButtonSelector);
  if (usernameElement && passowrdElement) {
    await usernameElement.safeType(username, true);
    await passowrdElement.safeType(password, true);
    await LoginButtonElement.safeClick();
  }
  const hamburgSelector = await services.pageObject.getSelector('ManagementCentre.Hamburg');
  const systemAdministrationSelector = await services.pageObject.getSelector('ManagementCentre.SystemAdministration');
  const jobSelector = await services.pageObject.getSelector(`ManagementCentre.${task}`);
  const hamburgElement = await maybeDisplayed$(hamburgSelector);
  if (hamburgElement) {
    hamburgElement.safeClick();
    const SystemAdministrationElement = await maybeDisplayed$(systemAdministrationSelector);
    if (SystemAdministrationElement) {
      SystemAdministrationElement.safeClick();
      const jobElement = await maybeDisplayed$(jobSelector);
      if (jobElement) { jobElement.safeClick(); }
    }
  }
  await sleep(2000);
  const IframeElement = await maybeDisplayed$(Iframeelector);
  await browser.switchToFrame(IframeElement);

  const searchbarSelector = await services.pageObject.getSelector('ManagementCentre.Searchbar');
  const searchbarElement = await maybeDisplayed$(searchbarSelector);
  if (searchbarElement) {
    await searchbarElement.safeType(jobName, false);
  }
  await sleep(2000);
  const toolSelectorElement = await maybeDisplayed$(toolSelector);
  if (toolSelectorElement) {
    toolSelectorElement.safeClick();
  }
  await sleep(2000);
  const saveButtonElement = await maybeDisplayed$(saveButtonSelector);
  if (saveButtonElement) {
    saveButtonElement.safeClick();
  }
  await sleep(2000);
});
