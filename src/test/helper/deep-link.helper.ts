/* eslint-disable prefer-destructuring */
/* eslint-disable import/prefer-default-export */
import services from '../../core/services';

/**
 * Pls refer to the doc/img/force-cookies-cleanup.png
 * @param url the expected url
 * @param isForced forced cookies clean up
 */
export const navigateToDeepLinkWithAccepdtedCookies = async (
  url: string, isForced: boolean,
) => {
  const currentUrl = await browser.getUrl();
  if (currentUrl === 'about:blank' || currentUrl === '' || currentUrl === 'data:,') {
    await browser.url(url);
  } else if (!isForced) {
    await browser.url(url);
    await browser.waitForPageLoaded();
    await browser.safeDeleteAllCookies();
  } else {
    if (currentUrl !== url && currentUrl !== `${url}/`) {
      await browser.url(url);
      await browser.waitForPageLoaded();
    }
    const cookies = await browser.getAllCookies() as Array<WebDriver.Cookie>;
    const genderCookie = cookies.find((c) => c.name === 'PVH_GLP_GENDER_URL' && c.value);
    const authCookie = cookies.find((c) => c.name.indexOf('WC_AUTHENTICATION_') >= 0 && c.name.indexOf('-1002') < 0);
    const gdprCookie = cookies.find((c) => c.name.indexOf('PVH_COOKIES_GDPR') >= 0 && c.value === 'Accept');
    await browser.deleteAllCookies();
    await browser.deleteAllStorage();
    if (genderCookie || authCookie || gdprCookie) {
      await browser.url(url);
      await browser.waitForPageLoaded();
    }
  }
  await browser.setInitStorage();
  await browser.setInitCookiesAndNavigate(url);
};

export const navigateToDeepLink = async (
  url: string, withAcceptedCookies: string,
) => {
  if (!withAcceptedCookies) {
    await browser.url(url);
    await browser.waitForPageLoaded();
  } else {
    await navigateToDeepLinkWithAccepdtedCookies(url, withAcceptedCookies.indexOf('forced') >= 0);
  }
};

export const getEnvironmentProductNumber = async (
  styleProductNumbers: string,
) => {
  let finalPartNumber;
  const splitItems = styleProductNumbers.split(':');
  const currentEnvironment = services.env.Site;
  switch (currentEnvironment) {
    case 'b2ceuup':
      finalPartNumber = splitItems[0];
      break;
    case 'devtestp':
    case 'devtests':
      finalPartNumber = splitItems[1];
      break;
    case 'b2ceusp':
    case 'b2ceuss':
      finalPartNumber = splitItems[2];
      break;
    default:
      throw Error(`Error: ${currentEnvironment} is currently not on the list of environments`);
  }
  return finalPartNumber;
};

export const getBrandProductNumber = async (
  styleProductNumbers: string,
) => {
  let finalPartNumber;
  const splitItems = styleProductNumbers.split('/');
  const brand = process.env.Brand;
  if (brand === 'ck') {
    finalPartNumber = splitItems[1];
  } else {
    finalPartNumber = splitItems[0];
  }
  return finalPartNumber;
};

export const navigateToDeepLinkWithOnlyFunctionalCookies = async (
  url: string,
) => {
  const currentUrl = await browser.getUrl();
  if (currentUrl === 'about:blank' || currentUrl === '' || currentUrl === 'data:,') {
    await browser.url(url);
  } else {
    if (currentUrl !== url && currentUrl !== `${url}/`) {
      await browser.url(url);
      await browser.waitForPageLoaded();
    }
    const cookies = await browser.getAllCookies() as Array<WebDriver.Cookie>;
    const genderCookie = cookies.find((c) => c.name === 'PVH_GLP_GENDER_URL' && c.value);
    const authCookie = cookies.find((c) => c.name.indexOf('WC_AUTHENTICATION_') >= 0 && c.name.indexOf('-1002') < 0);
    const gdprCookie = cookies.find((c) => c.name.indexOf('PVH_COOKIES_GDPR') >= 0 && c.value === 'Accept');
    await browser.deleteAllCookies();
    await browser.deleteAllStorage();
    if (genderCookie || authCookie || gdprCookie) {
      await browser.url(url);
      await browser.waitForPageLoaded();
    }
  }
  await browser.setInitStorage();
  await browser.setOnlyFunctionalCookiesAndNavigate(url);
};
