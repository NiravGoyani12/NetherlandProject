/* eslint-disable max-len */
/* eslint-disable import/prefer-default-export */
import { Given, Then } from '@pvhqa/cucumber';
import services from '../../core/services';
import {
  getBrandProductNumber, getEnvironmentProductNumber, navigateToDeepLink, navigateToDeepLinkWithOnlyFunctionalCookies,
} from '../helper/deep-link.helper';
import { GetTestLogger } from '../../core/logger/test.logger';
import { getStore } from '../helper/utils.helper';
import { maybeDisplayed$, p$ } from '../general';
import LoginPage from '../pages/csr/login-page';
import { waitForNetworkRequest } from '../helper/generic.helpers';
import { getPageInformation } from './transformers.steps';

const CsrLogin = p$(LoginPage);

// Deep link steps should be always the first steps IF there is no data/user preparation.

export const stepNavigateToUrlByDeepLink = async (
  locale: string, url: string, langCode: string, withAcceptedCookies: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  url = services.world.parse(url);
  if (!url.startsWith('/')) {
    url = `/${url}`;
  }
  url = url.replace('{storeId}', services.site.siteInfo.STORE_ID.toString()).replace('{catalogId}', services.site.siteInfo.MAIN_STORE_ID.toString());
  await navigateToDeepLink(`${services.site.baseUrl}${url}`, withAcceptedCookies);
  GetTestLogger().info(`Navigate to ${services.site.baseUrl}${url}`);
};
Given(/^I am on locale (default|[^\s]+) of url ([^\s]+)(?: of langCode (default|[^\s]+))?( with accepted cookies| with forced accepted cookies|)?$/, stepNavigateToUrlByDeepLink);

export const stepNavigateToUrlAcceptOnlyFunctionalDeepLink = async (
  locale: string, url: string, langCode: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  url = services.world.parse(url);
  if (!url.startsWith('/')) {
    url = `/${url}`;
  }
  url = url.replace('{storeId}', services.site.siteInfo.STORE_ID.toString()).replace('{catalogId}', services.site.siteInfo.MAIN_STORE_ID.toString());
  await navigateToDeepLinkWithOnlyFunctionalCookies(`${services.site.baseUrl}${url}`);
  GetTestLogger().info(`Navigate to ${services.site.baseUrl}${url}`);
};
Given(/^I am on locale (default|[^\s]+) of url ([^\s]+)(?: of langCode (default|[^\s]+))? and want only functional cookies accepted$/, stepNavigateToUrlAcceptOnlyFunctionalDeepLink);

export const stepNavigateToHomePageByDeepLink = async (
  locale: string, langCode: string, withAcceptedCookies: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  const url = services.site.baseUrl;
  await navigateToDeepLink(url, withAcceptedCookies);
};

Given(/^I am on locale (default|[^\s]+) home page(?: of langCode (default|[^\s]+))?( with accepted cookies| with forced accepted cookies|)?$/, stepNavigateToHomePageByDeepLink);

Given(/^I am on locale (default|[^\s]+) home page(?: of langCode (default|[^\s]+))? with mocked locale ([^\s]+) with forced accepted cookies$/, async (locale: string, langCode: string, mockedLocale: string) => {
  if ((browser.options.capabilities as any).browserName !== 'chrome') {
    throw new Error('FH Tracker listener only can be injected to Chrome');
  }

  await services.chromium.sendRequest(
    services.env.RemoteServerUrl,
    browser.sessionId,
    'Network.enable',
    {},
  );
  const anotherSiteInfo = await services.site.getSiteInfo(mockedLocale, undefined);
  await services.chromium.sendRequest(
    services.env.RemoteServerUrl,
    browser.sessionId,
    'Network.setExtraHTTPHeaders',
    {
      headers: {
        X_CC_CODE: mockedLocale.toUpperCase(),
        X_CC_STOREID: anotherSiteInfo.STORE_ID.toString(),
        X_CC_LANGID: anotherSiteInfo.LANGUAGE_ID.toString(),
      },
    },
  );
  await stepNavigateToHomePageByDeepLink(locale, langCode, ' with forced accepted cookies');
  await services.chromium.sendRequest(
    services.env.RemoteServerUrl,
    browser.sessionId,
    'Network.disable',
    {},
  );
});

export const stepNavigateToGlpByDeepLink = async (
  locale: string, gender: string, langCode: string, withAcceptedCookies: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  let glpUrl: string;
  const siteLanguage = services.site.siteInfo.LOCALENAME.toLowerCase();
  if (gender === ' men') {
    glpUrl = services.translation.get(siteLanguage, 'MenGLP');
  } else if (gender === ' kids') {
    glpUrl = services.translation.get(siteLanguage, 'KidsGLP');
  } else {
    glpUrl = services.translation.get(siteLanguage, 'WomenGLP');
  }
  await navigateToDeepLink(`${services.site.baseUrl}/${glpUrl}`, withAcceptedCookies);
  services.world.store('#GLP', 'true');
};
Given(/^I am on locale (default|[^\s]+)( men| women| kids|) glp page(?: of langCode (default|[^\s]+))?( with accepted cookies| with forced accepted cookies|)?$/, stepNavigateToGlpByDeepLink);

export const stepNavigateToPDPByDeepLink = async (
  locale: string, langCode: string, styleColourPartNumber: string, withAcceptedCookies: string,
) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  // Sequence is: UAT|DB0|SIT. If no data for the other environments, use for example: K60K6074510F4:K60K609492BAX:_
  if (styleColourPartNumber.includes(':')) {
    styleColourPartNumber = await getEnvironmentProductNumber(styleColourPartNumber);
  }
  // Sequence is: TH/CK. use for example: AM0AM10454XM6/000QF5149E001
  if (styleColourPartNumber.includes('/')) {
    styleColourPartNumber = await getBrandProductNumber(styleColourPartNumber);
  }
  styleColourPartNumber = services.world.parse(styleColourPartNumber);
  styleColourPartNumber = services.product.parse(styleColourPartNumber);
  const seoUrl = await services.product.productStyle.GetSEOUrl(
    styleColourPartNumber, services.site.siteInfo.LOCALENAME,
  );
  const url = `${services.site.baseUrl}/${seoUrl}`;
  services.world.store('#pdpUrl', url);
  await navigateToDeepLink(url, withAcceptedCookies);
};
Given(/^I am on locale (default|[^\s]+) pdp page(?: of langCode (default|[^\s]+))? for product style ([^\s]+)( with accepted cookies| with forced accepted cookies|)?$/, stepNavigateToPDPByDeepLink);

// Note: This only works with step that extracts identifier for plus-size
export const stepNavigateToPlusSizePdp = async (
  locale: string, langCode: string, identifier: string, withAcceptedCookies: string,
) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  const acceptStore: string = await getStore(services.site.locale);

  identifier = services.world.parse(identifier);

  const responseBody = JSON.parse(await services.transformers
    .getProducts(identifier, services.site.siteInfo.LOCALENAME, acceptStore));

  const seoUrl = responseBody.data.additionalSizeProductUrl;
  const pdpUrl = `${services.site.baseUrl}${seoUrl}`;
  let regularSizeUrl = responseBody.data.url.replace('/', '');
  regularSizeUrl = encodeURIComponent(regularSizeUrl);
  services.world.store('#regularSizeUrl', regularSizeUrl);

  await navigateToDeepLink(pdpUrl, withAcceptedCookies);
};
Then(/^I am on locale (default|[^\s]+) plus-sized PDP(?: of langCode (default|[^\s]+))? for identifier key ([^\s]+)( with accepted cookies| with forced accepted cookies|)?$/, stepNavigateToPlusSizePdp);

// Note: This only works with step that extracts identifier for plus-size
export const stepNavigateToPdpWithPlusSizeLinking = async (
  locale: string, langCode: string, identifier: string, withAcceptedCookies: string,
) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  const acceptStore: string = await getStore(services.site.locale);

  identifier = services.world.parse(identifier);

  const responseBody = JSON.parse(await services.transformers
    .getProducts(identifier, services.site.siteInfo.LOCALENAME, acceptStore));

  const seoUrl = responseBody.data.url.replace(`/${langCode}`, '');
  const pdpUrl = `${services.site.baseUrl}${seoUrl}`;
  let additionalUrl = responseBody.data.additionalSizeProductUrl.replace('/', '');
  additionalUrl = encodeURIComponent(additionalUrl);
  services.world.store('#additionalSizeUrl', additionalUrl);

  await navigateToDeepLink(pdpUrl, withAcceptedCookies);
};
Then(/^I am on locale (default|[^\s]+) PDP with plus-size linking(?: of langCode (default|[^\s]+))? for identifier key ([^\s]+)( with accepted cookies| with forced accepted cookies|)?$/, stepNavigateToPdpWithPlusSizeLinking);

export const stepNavigateToShoppingBagWithXProducts = async (
  locale: string, langCode: string, skuPartNumbers: string, withAcceptedCookies: string,
) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  skuPartNumbers = services.world.parse(skuPartNumbers);
  skuPartNumbers = services.product.parse(skuPartNumbers);
  skuPartNumbers = skuPartNumbers.split(',').map((s) => `ean=${s}&qty=1`).join('&');
  const url = `${services.site.baseUrl}/BasketRePopulate?${skuPartNumbers}`;
  await navigateToDeepLink(url, withAcceptedCookies);
  const urlShoppingbag = `${services.site.baseUrl}/shopping-bag`;
  await browser.url(urlShoppingbag);
};
Given(/^I am on locale (default|[^\s]+) shopping bag page(?: of langCode (default|[^\s]+))? for product items? ([^\s]+)( with accepted cookies| with forced accepted cookies|)?$/, stepNavigateToShoppingBagWithXProducts);

export const stepNavigateToShoppingBagWithXUnitsOfProduct = async (
  locale: string, langCode: string, quantity: number,
  withAcceptedCookies: string, hasSAPFilter: string,
) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  if (!hasSAPFilter) {
    await services.product.productItem.getAnyProductItem(100, 9999, 1, false);
  } else {
    await services.product.productItem.getAnyProductItemFilteredBySap(100, 1, true);
  }
  const skuPartNumber = services.product.parse('product1#skuPartNumber');
  const url = `${services.site.baseUrl}/BasketRePopulate?ean=${skuPartNumber}&qty=${quantity}`;
  await navigateToDeepLink(url, withAcceptedCookies);
  const urlShoppingbag = `${services.site.baseUrl}/shopping-bag`;
  await browser.url(urlShoppingbag);
};
Given(/^I am on locale (default|[^\s]+) shopping bag page(?: of langCode (default|[^\s]+))? with (\d+) units? of any product( with accepted cookies| with forced accepted cookies|)?( filtered by SAP)?$/, stepNavigateToShoppingBagWithXUnitsOfProduct);

export const stepNavigateToShoppingBagWithXUnitsOfYProducts = async (
  locale: string, langCode: string, quantity: number,
  skuPartNumbers: string, withAcceptedCookies: string,
) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  skuPartNumbers = services.world.parse(skuPartNumbers);
  skuPartNumbers = services.product.parse(skuPartNumbers);
  skuPartNumbers = skuPartNumbers.split(',').map((s) => `ean=${s}&qty=${quantity}`).join('&');
  const url = `${services.site.baseUrl}/BasketRePopulate?${skuPartNumbers}`;
  await navigateToDeepLink(url, withAcceptedCookies);
  // TODO: Workaround
  const urlShoppingbag = `${services.site.baseUrl}/shopping-bag`;
  await browser.url(urlShoppingbag);
};
Given(/^I am on locale (default|[^\s]+) shopping bag page(?: of langCode (default|[^\s]+))? with ([\d]+|[^\s]+) units? for product items? ([^\s]+)( with accepted cookies| with forced accepted cookies|)?$/, stepNavigateToShoppingBagWithXUnitsOfYProducts);

Given(/^I am on locale (default|[^\s]+) wish list page(?: of langCode (default|[^\s]+))?( with accepted cookies| with forced accepted cookies|)?$/, async (locale: string, langCode: string, withAcceptedCookies: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  const url = `${services.site.baseUrl}/wishlist`;
  await navigateToDeepLink(url, withAcceptedCookies);
});

Given(/^I am on locale (default|[^\s]+) wish list page(?: of langCode (default|[^\s]+))? with (\d+)(?: different)? products?( with accepted cookies| with forced accepted cookies|)?$/, async (locale: string, langCode: string, resultCount: number, withAcceptedCookies: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productStyle.getProductSytleOfNormalSize(
    10, 500, resultCount, true,
  );
  const styleColourPartNumberList = [];
  for (let i = 1; i <= resultCount; i += 1) {
    styleColourPartNumberList.push(services.product.parse(`product${i}#styleColourPartNumber`));
  }
  const url = `${services.site.baseUrl}/populatewishlist?partnumbers=${styleColourPartNumberList.join(',')}`;
  await navigateToDeepLink(url, withAcceptedCookies);
});

Given(/^I am on locale (default|[^\s]+) wishlist page(?: of langCode (default|[^\s]+))? with identifiers? ([^\s]+)( with accepted cookies| with forced accepted cookies|)?$/, async (locale: string, langCode: string, styleColourPartNumbers: string, withAcceptedCookies: string) => {
  let productIdentifiers: string = '';
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  styleColourPartNumbers.split(',').forEach((text) => {
    productIdentifiers = productIdentifiers.concat(`${services.world.parse(text)},`);
  });
  productIdentifiers = productIdentifiers.substr(0, productIdentifiers.length - 1);
  const url = `${services.site.baseUrl}/populatewishlist?partnumbers=${productIdentifiers}`;
  await navigateToDeepLink(url, withAcceptedCookies);
});

export const stepNavigateToShoppingBagWithXDifferentProducts = async (
  locale: string, langCode: string,
  resultCount: number, withAcceptedCookies: string, hasSAPFilter: string,
) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  const skuPartNumbersList = [];
  if (!hasSAPFilter) {
    await services.product.productItem.getAnyProductItem(
      100, 9999, resultCount, false,
    );
  } else {
    await services.product.productItem.getAnyProductItemFilteredBySap(
      100, resultCount, false,
    );
  }
  for (let i = 1; i <= resultCount; i += 1) {
    skuPartNumbersList.push(services.product.parse(`product${i}#skuPartNumber`));
  }
  const newskuPartNumbersList = skuPartNumbersList.map((s) => `ean=${s}&qty=1`).join('&');
  const url = `${services.site.baseUrl}/BasketRePopulate?${newskuPartNumbersList}`;
  await navigateToDeepLink(url, withAcceptedCookies);
  const urlShoppingbag = `${services.site.baseUrl}/shopping-bag`;
  await browser.url(urlShoppingbag);
};
Given(/^I am on locale (default|[^\s]+) shopping bag page(?: of langCode (default|[^\s]+))? with (\d+)(?: different)? products?( with accepted cookies| with forced accepted cookies|)?( filtered by SAP)?$/, stepNavigateToShoppingBagWithXDifferentProducts);

Given(/^I am on locale (default|[^\s]+) wish list page(?: of langCode (default|[^\s]+))? for product styles? ([^\s]+)( with accepted cookies| with forced accepted cookies|)?$/, async (locale: string, langCode: string, styleColourPartNumber: string, withAcceptedCookies: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  styleColourPartNumber = services.product.parse(styleColourPartNumber);
  const url = `${services.site.baseUrl}/populatewishlist?partnumbers=${styleColourPartNumber}`;
  await navigateToDeepLink(url, withAcceptedCookies);
});

Given(/^I am on locale (default|[^\s]+) search page(?: of langCode (default|[^\s]+))? with search term "([^\s]+)"( with accepted cookies| with forced accepted cookies|)?$/, async (locale: string, langCode: string, searchTerm: string, withAcceptedCookies: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  searchTerm = services.product.parse(searchTerm);
  const url = `${services.site.baseUrl}/search?searchTerm=${searchTerm}`;
  await navigateToDeepLink(url, withAcceptedCookies);
});

Given(/^I am on locale (default|[^\s]+) checkout debug page(?: of langCode (default|[^\s]+))?$/, async (locale: string, langCode: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  const url = `${services.site.baseUrl}/checkout/debug`;
  await navigateToDeepLink(url, 'forced');
});

Given(/^I am in url (.*) of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with (new|existing) account email (.*) and password (.*) with forced accepted cookies$/, async (url: string, locale: string, langCode: string, accountType: string, email: string, password: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  url = url.replace('{storeId}', services.site.siteInfo.STORE_ID.toString()).replace('{catalogId}', services.site.siteInfo.MAIN_STORE_ID.toString());
  const currentUrl = await browser.getUrl();
  if (currentUrl.indexOf(services.site.baseUrl) < 0) {
    await browser.url(`${services.site.baseUrl}`);
  }

  await browser.deleteAllCookies();
  await browser.deleteAllStorage();
  await browser.setInitStorage();
  await browser.setInitCookiesAndRefresh();
  await browser.waitForPageLoaded();
  await browser.setAuthCookies(email, password, accountType === 'new');
  await browser.setInitStorage();
  await browser.url(`${services.site.baseUrl}/${url}`);
  await browser.waitForPageLoaded();
  await browser.setPaginationCookiesAndRefresh();
});

Then(/^I set pagination cookie$/, async () => {
  await browser.setPaginationCookiesAndRefresh();
});

Then(/^I set cookie with name (.*) and value (.*)$/, async (cookieName: string, cookieValue: string) => {
  await browser.setCookiesAndRefresh([{ name: cookieName, value: cookieValue }]);
});

Given(/^I am in (csr landing page|csr account search|csr main|csr orders|csr account creation|csr partner orders|csr customer search)( with order id (.*))? of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with (L1|L2|L3|L4) csr account with forced accepted cookies$/,
  async (csrPageType: string, orderId: string, locale: string, langCode: string, accountType: string,
  ) => {
    let url;
    let internalOrderId = '';
    const accountNumber = Math.floor(Math.random() * 6) + 1;
    services.world.store('#acountNumber', accountNumber);

    switch (csrPageType) {
      case 'csr landing page':
        url = 'csr';
        break;
      case 'csr account search':
        url = 'csr/account/search';
        break;
      case 'csr main':
        url = 'csr';
        break;
      case 'csr orders':
        internalOrderId = services.world.parse(orderId);
        url = `csr/orders/${internalOrderId}`;
        break;
      case 'csr account creation':
        url = 'csr/account/create';
        break;
      case 'csr partner orders':
        url = 'csr/partner-orders';
        break;
      case 'csr customer search':
        url = 'csr/customers';
        break;
      default:
        throw new Error(`Incorrect csrPageType provided: ${csrPageType} Please check your test step.`);
    }

    switch (accountType) {
      case 'L1':
        accountType = `L1_${accountNumber}`;
        break;
      case 'L2':
        accountType = `L2_${accountNumber}`;
        break;
      case 'L3':
        accountType = `L3_${accountNumber}`;
        break;
      case 'L4':
        accountType = `L4_${accountNumber}`;
        break;
      default:
        throw new Error(`There are no account types ${accountType} in CSR`);
    }

    services.site.initilizeSize(locale, langCode);
    const email = services.csraccount.getCsrUser(accountType, services.env.Brand, services.env.DatabaseName);
    const password = services.csraccount.getCsrPassword(accountType, services.env.Brand, services.env.DatabaseName);

    await browser.url(`${services.site.baseUrl}/${url}`);
    await waitForNetworkRequest('fetch', 'userinfo');
    await maybeDisplayed$('Csr.LoginPage.EmailField', 10000);
    await CsrLogin.FillEmailPassword(email, password);
    await waitForNetworkRequest('fetch', 'userinfo');
    await maybeDisplayed$('Csr.SearchPage.OrderIdInput', 10000);
    await browser.waitForPageLoaded();
  });

export const stepNavigateToSpecificPLPPageByDeepLink = async (
  plpType: string, searchOrCategoryName: string, unified: string, pageNumber: string, locale: string, langCode: string, withAcceptedCookies: string) => {
  await services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  const acceptStore: string = await getStore(services.site.locale);

  let url;
  if (plpType === 'category') {
    const responseBody = JSON.parse(await services.transformers
      .getCategoryInformation(
        searchOrCategoryName,
        services.site.siteInfo.LOCALENAME,
        acceptStore,
        services.site.locale,
      ));
    url = responseBody.data.metadata.keywords;

    if (!url.startsWith('/')) {
      url = `/${url}`;
    }
    url = url.replace('{storeId}', services.site.siteInfo.STORE_ID.toString()).replace('{catalogId}', services.site.siteInfo.MAIN_STORE_ID.toString());
  } else {
    url = `/search?searchTerm=${searchOrCategoryName}`;
  }

  const pageParam = unified === 'unified page' ? 'page' : 'scrollPage';

  if (pageNumber && pageNumber === 'last') {
    const lastPageNumber = await getPageInformation('lastPageNumber', plpType, searchOrCategoryName);
    url = plpType === 'category' ? url.concat(`?${pageParam}=${lastPageNumber}`) : url.concat(`&${pageParam}=${lastPageNumber}`);
  } else if (pageNumber) {
    url = plpType === 'category' ? url.concat(`?${pageParam}=${pageNumber}`) : url.concat(`&${pageParam}=${pageNumber}`);
  }

  await navigateToDeepLink(`${services.site.baseUrl}${url}`, withAcceptedCookies);
  GetTestLogger().info(`Navigate to ${services.site.baseUrl}${url}`);
};
Given(/^I am on (search|category) ([^\s]+) ?(unified page|page) (?:(.*) )?of locale (default|[^\s]+)(?: of langCode (default|[^\s]+))?( with accepted cookies| with forced accepted cookies|)?$/, stepNavigateToSpecificPLPPageByDeepLink);

Given(/^I am in (csr landing page|csr account search|csr main|csr orders|csr account creation|csr partner orders|csr customer search)( with order id (.*))? of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with (.*) (.*) csr account with forced accepted cookies$/,
  async (csrPageType: string, orderId: string, locale: string, langCode: string, email: string, password: string,
  ) => {
    let url;
    let internalOrderId = '';
    const accountNumber = Math.floor(Math.random() * 6) + 1;
    services.world.store('#acountNumber', accountNumber);

    switch (csrPageType) {
      case 'csr landing page':
        url = 'csr';
        break;
      case 'csr account search':
        url = 'csr/account/search';
        break;
      case 'csr main':
        url = 'csr';
        break;
      case 'csr orders':
        internalOrderId = services.world.parse(orderId);
        url = `csr/orders/${internalOrderId}`;
        break;
      case 'csr account creation':
        url = 'csr/account/create';
        break;
      case 'csr partner orders':
        url = 'csr/partner-orders';
        break;
      case 'csr customer search':
        url = 'csr/customers';
        break;
      default:
        throw new Error(`Incorrect csrPageType provided: ${csrPageType} Please check your test step.`);
    }

    services.site.initilizeSize(locale, langCode);
    await browser.url(`${services.site.baseUrl}/${url}`);
    await waitForNetworkRequest('fetch', 'userinfo');
    await maybeDisplayed$('Csr.LoginPage.EmailField', 10000);
    await CsrLogin.FillEmailPassword(email, password);
    await waitForNetworkRequest('fetch', 'userinfo');
    await maybeDisplayed$('Csr.SearchPage.OrderIdInput', 10000);
    await browser.waitForPageLoaded();
  });
