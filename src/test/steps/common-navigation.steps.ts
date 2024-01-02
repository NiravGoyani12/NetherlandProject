import { Given, When, Then } from '@pvhqa/cucumber';
import randomstring from 'randomstring';
import {
  stepNavigateToGlpByDeepLink,
  stepNavigateToHomePageByDeepLink,
  stepNavigateToUrlByDeepLink,
  stepNavigateToPDPByDeepLink,
} from './deep-link.steps';
import services from '../../core/services';
import { clickElement } from './browser.steps';
import { sleep } from '../helper/utils.helper';

Given(/^I navigate to page ([^\s]+)( with accepted cookies| with forced accepted cookies|)?$/, async (page: string, withAcceptedCookies: string) => {
  const currentLocale = services.site.locale;
  const currentLangCode = services.site.langCode;
  if (page.toLowerCase() === 'mainredirectpage') {
    page = services.env.MainRedirectPage;
  }

  switch (page) {
    case 'plp':
    case 'Plp':
    case 'PLP':
      // eslint-disable-next-line no-case-declarations
      const url = services.translation.get(services.site.siteInfo.LOCALENAME.toLowerCase(), 'WomenUnderware');
      await stepNavigateToUrlByDeepLink(
        currentLocale, url, currentLangCode, withAcceptedCookies,
      );
      break;
    case 'giftcard-pdp':
      // eslint-disable-next-line no-case-declarations
      const gcURL = services.translation.get(services.site.siteInfo.LOCALENAME.toLowerCase(), 'GiftcardURL');
      await stepNavigateToUrlByDeepLink(
        currentLocale, gcURL, currentLangCode, withAcceptedCookies,
      );
      break;
    case 'home-page':
      await stepNavigateToHomePageByDeepLink(
        currentLocale, currentLangCode, withAcceptedCookies,
      );
      // eslint-disable-next-line no-case-declarations
      const actualUrl = await browser.getUrl();
      if (actualUrl !== services.site.baseUrl && actualUrl !== `${services.site.baseUrl}/`) {
        await browser.deleteGDPRCookies();
        await browser.url(services.site.baseUrl);
      }
      break;
    case 'glp':
      await stepNavigateToGlpByDeepLink(
        currentLocale, undefined, currentLangCode, withAcceptedCookies,
      );
      break;
    case 'wlp':
    case 'wishlist':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'wishlist', currentLangCode, withAcceptedCookies,
      );
      break;
    case 'pdp':
      await services.product.productStyle.getProductSytleOfNormalSize(10, 500, 1, true);
      await stepNavigateToPDPByDeepLink(
        currentLocale,
        currentLangCode,
        services.product.lastAddedProduct.STYLECOLOUR_PARTNUMBER,
        withAcceptedCookies,
      );
      break;
    case 'search-plp':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'search?searchTerm=shirts', currentLangCode, withAcceptedCookies,
      );
      await sleep(3000);
      break;
    case 'no-search-result-page':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'search?searchTerm=blablaqwerty', currentLangCode, withAcceptedCookies,
      );
      break;
    case 'content-page':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'customer-service', currentLangCode, withAcceptedCookies,
      );
      break;
    case 'performance-page':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'performance', currentLangCode, withAcceptedCookies,
      );
      break;
    case 'address-book-page':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'AddressBookForm', currentLangCode, withAcceptedCookies,
      );
      break;
    case 'shopping-bag':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'shopping-bag', currentLangCode, withAcceptedCookies,
      );
      break;
    case 'store-locator':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'store-locator', currentLangCode, withAcceptedCookies,
      );
      break;
    case 'error-page':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'error-page', currentLangCode, withAcceptedCookies,
      );
      break;
    case 'size-guide':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'size-guide', currentLangCode, withAcceptedCookies,
      );
      break;
    case 'content-test-2':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'content-test-2', currentLangCode, withAcceptedCookies,
      );
      break;
    case 'content-test-4':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'content-test-4', currentLangCode, withAcceptedCookies,
      );
      break;
    case 'myaccount':
    case 'myaccount/details':
      await stepNavigateToUrlByDeepLink(
        currentLocale, page, currentLangCode, withAcceptedCookies,
      );
      break;
    case 'myaccount/preferences':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'myaccount/preferences', currentLangCode, withAcceptedCookies,
      );
      break;
    case 'services/view-order':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'services/view-order', currentLangCode, withAcceptedCookies,
      );
      break;
    case 'checkout-shipping':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'checkout/shipping', currentLangCode, withAcceptedCookies,
      );
      break;
    case 'checkout-payment':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'checkout/payment', currentLangCode, withAcceptedCookies,
      );
      break;
    case 'faqs':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'faqs', currentLangCode, withAcceptedCookies,
      );
      break;
    case 'contactus':
      await stepNavigateToUrlByDeepLink(
        currentLocale, 'contactus', currentLangCode, withAcceptedCookies,
      );
      break;
    default:
      throw new Error(`No deeplink step found for page ${page}`);
  }

  await browser.waitForPageLoaded();
});

When(/I navigate to current url with suffix ([^\s]+)(?: with args? ([^\s]+))?/, async (suffix: string, args: string) => {
  const currentUrl = await browser.getUrl();
  let newUrl = `${currentUrl}${suffix}`;
  if (args) {
    const argList = services.product.parse(args).split(',');
    argList.forEach((arg, index) => {
      if (arg.startsWith('#')) {
        arg = (services.world.parse(args)).toString();
      }
      newUrl = newUrl.replace(`{${index}}`, arg);
    });
  }
  await browser.navigateTo(newUrl);
});

Then(/I (?:wait until|see) the current page is loaded/, async () => {
  await browser.waitForPageLoaded();
});

When(/I am on home page with accepted cookies/, async () => {
  await browser.url(services.site.baseUrl);
  await browser.waitForPageLoaded();
  await clickElement('Experience.CookieNotice.IAgreeButton');
});

When(/I navigate to current url appended with some random text/, async () => {
  const currentUrl = await browser.getUrl();
  const randomText = randomstring.generate(8);
  const newUrl = `${currentUrl}${randomText}`;
  await browser.navigateTo(newUrl);
});
