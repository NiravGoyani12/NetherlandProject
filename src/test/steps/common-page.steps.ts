/* eslint-disable @typescript-eslint/indent */
import { Given, Then } from '@pvhqa/cucumber';
import services from '../../core/services';
import { whenPageLoaded } from '../general';

Given(/^I (?:see|wait until) (?:page|component) ([^\s]+) is loaded$/, async (page: string) => {
  const timeout = services.env.DriverConfig.timeout.pageLoad;
  await browser.waitUntil(async () => {
    const isLoaded = await services.pageObject.doFunction<boolean>(`${page}.isLoaded`);
    return isLoaded === true;
  },
    {
      timeout,
      timeoutMsg: `${page} is not loaded within ${timeout} ms`,
      interval: 2000,
    });
});

Then(/I (?:see|wait until) the current page is (Homepage|PDP|GLP|PLP|Wishlistpage|Content|CheckoutSignIn|MyAccount page|home-page|pdp|glp|wlp|cart|shopping-bag|shipping page|payment page|FAQs|store-locator|search-plp|customer service|giftcard pdp)/, async (page: string) => {
  const timeout = services.env.DriverConfig.timeout.elementDisplayed;
  let loadedPageType: string;
  const expectedPageType = page;

  return whenPageLoaded(async () => {
    const r = await browser.waitUntil(
      async () => {
        loadedPageType = (await browser.execute(
          'return utag.data.page_type || digitalData.page.category.pageType',
        )).toString();

        if (expectedPageType.toLocaleLowerCase() === 'myaccount page') {
          return ['myaccountpage', 'my-account', 'my account', 'myaccount'].findIndex((v) => v === loadedPageType.toLowerCase()) >= 0;
        }
        if (expectedPageType.toLocaleLowerCase() === 'home-page') {
          return ['home-page', 'homepage'].findIndex((v) => v === loadedPageType.toLowerCase()) >= 0;
        }
        if (expectedPageType.toLocaleLowerCase() === 'wlp') {
          return ['wishlist', 'wishlistpage'].findIndex((v) => v === loadedPageType.toLowerCase()) >= 0;
        }
        if (expectedPageType.toLocaleLowerCase() === 'content') {
          return ['content', 'contentpage'].findIndex((v) => v === loadedPageType.toLowerCase()) >= 0;
        }
        if ((expectedPageType.toLocaleLowerCase() === 'cart') || (expectedPageType.toLocaleLowerCase() === 'shopping-bag')) {
          // TODO: CET1-3627 is not given priority, refresh is needed to let tests continue.
          await browser.refresh();
          return ['cart'].findIndex((v) => v === loadedPageType.toLowerCase()) >= 0;
        }
        if (expectedPageType.toLocaleLowerCase() === 'checkoutsignin') {
          return ['checkout - sign in'].findIndex((v) => v === loadedPageType.toLowerCase()) >= 0;
        }
        if (expectedPageType.toLocaleLowerCase() === 'faq') {
          return ['customerservice'].findIndex((v) => v === loadedPageType.toLowerCase()) >= 0;
        }
        if (expectedPageType.toLocaleLowerCase() === 'glp') {
          return ['glp'].findIndex((v) => v === loadedPageType.toLowerCase()) >= 0;
        }
        if (expectedPageType.toLocaleLowerCase() === 'plp') {
          return ['plp', 'elevatedplp'].findIndex((v) => v === loadedPageType.toLowerCase()) >= 0;
        }
        if (expectedPageType.toLocaleLowerCase() === 'store-locator') {
          return ['store-locator', 'store locator'].findIndex((v) => v === loadedPageType.toLowerCase()) >= 0;
        }
        if (expectedPageType.toLocaleLowerCase() === 'search-plp') {
          return ['search results page'].findIndex((v) => v === loadedPageType.toLowerCase()) >= 0;
        }
        if (expectedPageType.toLocaleLowerCase() === 'shipping page') {
          return ['checkout - address shipment'].findIndex((v) => v === loadedPageType.toLowerCase()) >= 0;
        }
        if (expectedPageType.toLocaleLowerCase() === 'payment page') {
          return ['checkout - payment'].findIndex((v) => v === loadedPageType.toLowerCase()) >= 0;
        }
        if (expectedPageType.toLocaleLowerCase() === 'customerservice') {
          return ['customer service'].findIndex((v) => v === loadedPageType.toLowerCase()) >= 0;
        }
        if (expectedPageType.toLocaleLowerCase() === 'giftcard pdp') {
          return ['giftcard page'].findIndex((v) => v === loadedPageType.toLowerCase()) >= 0;
        }
        return loadedPageType.toLowerCase() === expectedPageType.toLowerCase();
      },
      {
        timeout,
        timeoutMsg: `Page type is not correct. Expected: ${expectedPageType}, actual: ${loadedPageType}`,
      },
    );
    return r;
  });
});
