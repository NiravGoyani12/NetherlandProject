/* eslint-disable max-len */
/* eslint-disable no-await-in-loop */
/* eslint-disable import/prefer-default-export */
import { Given, When } from '@pvhqa/cucumber';
import randomstring from 'randomstring';
import wcs from '../../../core/wcs';
import { sleep } from '../../helper/utils.helper';
import { GetTestLogger } from '../../../core/logger/test.logger';
import * as DeepLink from '../deep-link.steps';
import { stepIAmLoggedInOrGuest } from '../accounts.steps';
import services from '../../../core/services';
import { exist$, maybeDisplayed$ } from '../../general';
import { clickElement } from '../browser.steps';
import { waitForPageLoaded } from '../../commands/browser';
import Checkout from '../../pages/checkout';
import { XCOMREG } from '../../../core/constents';
import * as UnifiedActions from '../../helper/login-logout.helper';

export const registeredUserSignIn = async (
  email: string, password: string) => {
  const OnePageCheckout = await services.othersDB.GetXComReg(XCOMREG.ToggleEnabledOnePageCheckout);

  if (OnePageCheckout === 'true') {
    await Checkout.OPCSignIn.RegisteredUserSignIn(email, password);
  } else {
    await Checkout.SignIn.RegisteredUserSignIn(email, password);
  }
};

export const stepNavigateToShippingPage = async (
  userType: string, locale: string, langCode: string) => {
  await DeepLink.stepNavigateToHomePageByDeepLink(locale, langCode, 'with forced accepted cookies');
  const OnePageCheckout = await services.othersDB.GetXComReg(XCOMREG.ToggleEnabledOnePageCheckout);
  await stepIAmLoggedInOrGuest(userType);

  const quantity = Math.floor(Math.random() * 2) + 1;
  await DeepLink.stepNavigateToShoppingBagWithXDifferentProducts(locale, langCode, quantity, '', '');

  // navigating to login/shipping page
  await clickElement('Experience.ShoppingBag.StartCheckoutButton');


  if (userType === 'guest' && OnePageCheckout === 'false') {
    await clickElement('Checkout.SignInPage.ProceedAsGuestButton');
  }
  const personalDetailsForm = await (await exist$('Checkout.ShippingPage.NewAddressSection'));

  const isDisplayed = await personalDetailsForm.waitForDisplayed({
    timeout: 12000,
    interval: 500,
  }).catch(() => false);

  if (!isDisplayed) {
    throw new Error('Personal Details form has not loaded in 12 seconds.');
  }
};

Given(/^I am (guest|logged in) on locale (default|[^\s]+) of langCode (default|[^\s]+) on the payment page$/, async (userType: string, locale: string, langCode: string) => {
  await stepNavigateToShippingPage(userType, locale, langCode);
  const newAddressSection = await exist$('Checkout.ShippingPage.NewAddressSection', 10000);
  const addressAutocomplete = await services.othersDB.GetXComReg(XCOMREG.ToggleAddressAutocomplete);

  if (addressAutocomplete.toLowerCase() === 'true' && newAddressSection !== undefined) {
    const addAddressManually = await exist$('Checkout.ShippingPage.AddAddressManually', 10000);
    const isDisplayed = await addAddressManually.waitForDisplayed({
      timeout: 12000,
      interval: 500,
    }).catch(() => false);

    if (isDisplayed) {
      await addAddressManually.safeClick();
      // temporary workaroun because of issue: EESCK-12596
      await sleep(1000);
      await addAddressManually.safeClick();
    } else {
      throw new Error(`Add address manually is not displayed. ENABLE_ADDRESS_AUTOCOMPLETE toggle is ${addressAutocomplete}`);
    }
  }

  await Checkout.Shipping.FirstDeliveryAddress(userType);
  const shipping = await maybeDisplayed$('Checkout.ShippingPage.StandardRadioButton', 10000);

  if (shipping) {
    const proceedToPayment = await (await exist$('Checkout.ShippingPage.ProceedToPayment'));

    const isClickAble = await proceedToPayment.waitForClickable({
      timeout: 15000,
      interval: 500,
    }).catch(() => false);

    if (isClickAble && !(services.env.IsMobile)) {
      await proceedToPayment.safeClick();
    } else {
      await proceedToPayment.jsClick();
    }
  }

  const url = await browser.getUrl();

  if (url.indexOf('payment') < 0) {
    await waitForPageLoaded();
  }
});

Given(/^I am (guest|logged in) on locale (default|[^\s]+) of langCode (default|[^\s]+) with (standard|express) delivery method on the payment page$/, async (userType: string, locale: string, langCode: string, deliveryMethod?: string) => {
  await stepNavigateToShippingPage(userType, locale, langCode);
  const expressButton = await maybeDisplayed$('Checkout.ShippingPage.ExpressRadioButton', 10000);
  const standardButton = await exist$('Checkout.ShippingPage.StandardRadioButton', 10000);
  const personalDetailsForm = await (await exist$('Checkout.ShippingPage.NewAddressSection'));
  const proceedToPaymentButton = await (await exist$('Checkout.ShippingPage.ProceedToPayment'));
  const addressAutocomplete = await services.othersDB.GetXComReg(XCOMREG.ToggleAddressAutocomplete);

  if (deliveryMethod === 'express') {
    const expressIsClickable = await expressButton.waitForClickable({
      timeout: 12000,
      interval: 500,
    }).catch(() => false);

    if (expressIsClickable) {
      await expressButton.click();
    } else {
      throw new Error('Express button is not clickable after 12s!');
    }
  } else {
    standardButton.isClickable();
  }

  if (addressAutocomplete.toLowerCase() === 'true') {
    const addAddressManually = await exist$('Checkout.ShippingPage.AddAddressManually', 10000);
    const isDisplayed = await addAddressManually.waitForDisplayed({
      timeout: 12000,
      interval: 500,
    }).catch(() => false);

    if (isDisplayed) {
      await addAddressManually.safeClick();
      // temporary workaroun because of issue: EESCK-12596
      await sleep(1000);
      await addAddressManually.safeClick();
    } else {
      throw new Error(`Add address manually is not displayed. ENABLE_ADDRESS_AUTOCOMPLETE toggle is ${addressAutocomplete}`);
    }
  }

  const AddrFormisEnabled = await personalDetailsForm.waitForEnabled({
    timeout: 12000,
    interval: 500,
  }).catch(() => false);

  if (AddrFormisEnabled) {
    await sleep(1000);
    await Checkout.Shipping.FirstDeliveryAddress(userType);
  } else {
    throw new Error('Personal Details form has not loaded in 12 seconds.');
  }
  if (services.env.IsMobile) {
    await proceedToPaymentButton.jsClick();
  } else {
    await clickElement('Checkout.ShippingPage.ProceedToPayment');
  }
});

Given(/^I am (guest|logged in) on locale (default|[^\s]+) of langCode (default|[^\s]+) with (\d+) units? of any product on details page$/, async (
  userType: string, locale: string, langCode: string, quantity: number,
) => {
  await DeepLink.stepNavigateToHomePageByDeepLink(locale, langCode, 'with forced accepted cookies');
  const OnePageCheckout = await services.othersDB.GetXComReg(XCOMREG.ToggleEnabledOnePageCheckout);
  await stepIAmLoggedInOrGuest(userType);
  await DeepLink.stepNavigateToShoppingBagWithXUnitsOfProduct(locale, langCode, quantity, '', '');

  if (services.site.langCode) {
    await DeepLink.stepNavigateToUrlByDeepLink(locale, 'shopping-bag', langCode, '');
  }

  const startCheckout = await services.pageObject.getSelector('Experience.ShoppingBag.StartCheckoutButton');
  let element = await exist$(startCheckout);
  await element.safeClick();

  if (services.env.Brand === 'ck' && userType === 'guest') {
    await sleep(2000);
    const cartId = await browser.waitUntilResult(async () => {
      const result = await browser.execute('return digitalData.cart.cartId');
      return result;
    }, 'The digitalData card cart Id does not exist', 10000, 1000);
    GetTestLogger().info(`The cart id is: ${cartId}`);
  }

  if (userType === 'guest' && services.env.Brand === 'ck' && OnePageCheckout === 'false') {
    const guest = await services.pageObject.getSelector('Checkout.SignInPage.ProceedAsGuestButton');
    await sleep(2000);
    element = await exist$(guest);
    await element.safeClick();
  }
});

Given(/^I am (guest|logged in) on locale (default|[^\s]+) of langCode (default|[^\s]+) with (\d+) units? of any product on shopping bag page$/, async (
  userType: string, locale: string, langCode: string, quantity: number,
) => {
  await DeepLink.stepNavigateToHomePageByDeepLink(locale, langCode, 'with forced accepted cookies');
  await stepIAmLoggedInOrGuest(userType);
  await DeepLink.stepNavigateToShoppingBagWithXUnitsOfProduct(locale, langCode, quantity, '', '');

  if (services.site.langCode) {
    await DeepLink.stepNavigateToUrlByDeepLink(locale, 'shopping-bag', langCode, '');
  }

  if (services.env.Brand === 'ck' && userType === 'guest') {
    await sleep(2000);
    const cartId = await browser.waitUntilResult(async () => {
      const result = await browser.execute('return digitalData.cart.cartId');
      return result;
    }, 'The digitalData card cart Id does not exist', 10000, 1000);
    GetTestLogger().info(`The cart id is: ${cartId}`);
  }
});

Given(/^I am (guest|logged in) on locale (default|[^\s]+) of langCode (default|[^\s]+) for product items? ([^\s]+) on delivery page$/, async (
  userType: string, locale: string, langCode: string, skuPartNumbers: string,
) => {
  await DeepLink.stepNavigateToHomePageByDeepLink(locale, langCode, 'with forced accepted cookies');
  const OnePageCheckout = await services.othersDB.GetXComReg(XCOMREG.ToggleEnabledOnePageCheckout);
  await stepIAmLoggedInOrGuest(userType);
  await DeepLink.stepNavigateToShoppingBagWithXProducts(locale, langCode, skuPartNumbers, '');

  if (services.site.langCode) {
    await DeepLink.stepNavigateToUrlByDeepLink(locale, 'shopping-bag', langCode, '');
  }

  const startCheckout = await services.pageObject.getSelector('Experience.ShoppingBag.StartCheckoutButton');
  let element = await exist$(startCheckout);
  await element.safeClick();

  if (userType === 'guest' && services.env.Brand === 'ck' && OnePageCheckout === 'false') {
    const guest = await services.pageObject.getSelector('Checkout.SignInPage.ProceedAsGuestButton');
    await sleep(2000);
    element = await exist$(guest);
    await element.safeClick();
  }
});

/**
 * This step adds new address ONLY for registered user
 * Checkout page means for TH - details page and for CK - delivery page
 */
Given(/^I am logged in on locale (default|[^\s]+) of langCode (default|[^\s]+) with newly added address and with (\d+) different any products on checkout page$/, async (
  locale: string, langCode: string, quantity: number,
) => {
  await DeepLink.stepNavigateToHomePageByDeepLink(locale, langCode, 'with forced accepted cookies');
  await stepIAmLoggedInOrGuest('logged in');

  const cookies = await browser.getCookies();
  const baseUrl = `${services.site.baseUrl.split('/', 3).join('/')}/`;
  const storeId = services.site.siteInfo.STORE_ID.toString();
  const catalogId = services.site.siteInfo.CATALOG_ID.toString();
  const langId = services.site.siteInfo.LANGUAGE_ID.toString();
  const authToken = cookies.filter((c) => c.name.startsWith('WC_AUTHENTICATION'))[0].value;
  const memberId = authToken.split('%')[0];
  const country = (services.site.locale && services.site.locale !== 'uk') ? services.site.locale.toUpperCase() : 'GB';
  const nickName = `SHIPBILL_${memberId}_${storeId}_${langId}_${randomstring.generate(8)}`;
  const countryInfo = services.checkoutaddress.getCountryDetails(services.site.locale);

  const formattedCookies = cookies.map((c) => `${c.name}=${c.value}`);
  try {
    await wcs.addAddress(
      baseUrl, storeId, catalogId, langId, authToken, memberId,
      countryInfo.postcode, countryInfo.phone, countryInfo.province,
      country, nickName, formattedCookies,
    );
    await sleep(1000);
  } catch (e) {
    throw new Error(`New address was not created because of the error: 
    ${e}
    Original error message: ${e.response.body.errors ? e.response.body.errors[0].errorMsg : 'error message not avalable'}`);
  }

  await DeepLink.stepNavigateToShoppingBagWithXDifferentProducts(locale, langCode, quantity, '', '');

  if (services.site.langCode) {
    await DeepLink.stepNavigateToUrlByDeepLink(locale, 'shopping-bag', langCode, '');
  }

  const startCheckout = await services.pageObject.getSelector('Experience.ShoppingBag.StartCheckoutButton');
  const element = await exist$(startCheckout);
  await element.safeClick();
});

Given(/^I am (guest|logged in) on locale (default|[^\s]+) of langCode (default|[^\s]+) on the payment page to subscribe newsletter while checking out$/, async (userType: string, locale: string, langCode: string) => {
  await stepNavigateToShippingPage(userType, locale, langCode);
  const addressAutocomplete = await services.othersDB.GetXComReg(XCOMREG.ToggleAddressAutocomplete);

  if (addressAutocomplete.toLowerCase() === 'true') {
    const addAddressManually = await exist$('Checkout.ShippingPage.AddAddressManually', 10000);
    const isDisplayed = await addAddressManually.waitForDisplayed({
      timeout: 12000,
      interval: 500,
    }).catch(() => false);

    if (isDisplayed) {
      await addAddressManually.safeClick();
      // temporary workaroun because of issue: EESCK-12596
      await sleep(1000);
      await addAddressManually.safeClick();
    } else {
      throw new Error(`Add address manually is not displayed. ENABLE_ADDRESS_AUTOCOMPLETE toggle is ${addressAutocomplete}`);
    }
  }
  await Checkout.Shipping.FirstDeliveryAddress(userType);
  await clickElement('MyAccount.NewsletterSubscription.CheckoutNewsletterSignupCheckbox');
  await clickElement('Checkout.ShippingPage.ProceedToPayment');
});

Given(/^I am cross site user on locale (default|[^\s]+) of langCode (default|[^\s]+) on the (shopping bag|shipping|payment) page$/, async (locale: string, langCode: string, pageType: string) => {
  const quantity = Math.floor(Math.random() * 2) + 1;
  await DeepLink.stepNavigateToShoppingBagWithXDifferentProducts(locale, langCode, quantity, 'with forced accepted cookies', '');
  await waitForPageLoaded();
  const email = `pvh.${services.site.locale.toLowerCase()}.automation@outlook.com`;
  await services.maniPulateCartItemsDB.clearItemsFromSB(email);
  await UnifiedActions.SignInWithUserAndPassword(email, 'AutoNation2023');
  await sleep(2000);
  const myAccuntHeader = await (await exist$('Experience.Header.MyAccountButton'));
  const startCheckout = await (await exist$('Experience.ShoppingBag.StartCheckoutButton'));
  // await registeredUserSignIn(`pvh.${locale.toLowerCase()}.automation@outlook.com`, 'AutoNation2023');

  const isMyAccDisplayed = await myAccuntHeader.waitForDisplayed({
    timeout: 10000,
    interval: 500,
  }).catch(() => false);

  if (!isMyAccDisplayed) {
    throw new Error('Login did not perform as expected!');
  }

  if (pageType !== 'shopping bag') {
    const isClickAble = await startCheckout.waitForClickable({
      timeout: 10000,
      interval: 500,
    }).catch(() => false);

    if (isClickAble && !(services.env.IsMobile)) {
      await startCheckout.safeClick();
    } else {
      await startCheckout.jsClick();
    }
  }

  if (pageType !== 'shipping') {
    const proceedToPayment = await (await exist$('Checkout.ShippingPage.ProceedToPayment'));
    await sleep(2000);
    const isClickAble = await proceedToPayment.waitForClickable({
      timeout: 10000,
      interval: 500,
    }).catch(() => false);

    if (isClickAble && !(services.env.IsMobile)) {
      await proceedToPayment.safeClick();
    } else {
      await proceedToPayment.jsClick();
    }
  }
});
// eslint-disable-next-line import/prefer-default-export

Given(/^I am (guest|logged in) on locale (default|[^\s]+) of langCode (default|[^\s]+) on the shipping page$/, stepNavigateToShippingPage);

Given(/^I am (guest|logged in) on locale (default|[^\s]+) of langCode (default|[^\s]+) with ([\d]+) products with value (below|above) shipping threshold on (shipping|shopping bag) page$/, async (
  userType: string, locale: string, langCode: string, productNumber: number, value: string, page: string,
) => {
  let priceMin = 1;
  let priceMax = 9999;
  const products = [];

  await DeepLink.stepNavigateToHomePageByDeepLink(locale, langCode, 'with forced accepted cookies');
  const threshold = await services.othersDB.GetShippingPromoThreshold();
  await stepIAmLoggedInOrGuest(userType);

  if (value === 'below') {
    priceMax = threshold;
  } else if (value === 'above') {
    priceMin = threshold;
  }

  await services.product.productItem.getProductWithSpecificWasPrice(1, priceMin, priceMax, 10, 9999, productNumber);
  // eslint-disable-next-line no-plusplus
  for (let i = 1; i <= productNumber; i++) {
    products[i] = `product${i}#skuPartNumber`;
  }
  const productList = products.join(',');
  await DeepLink.stepNavigateToShoppingBagWithXProducts(locale, langCode, productList, '');

  if (page === 'shipping') {
    await clickElement('Experience.ShoppingBag.StartCheckoutButton');
  }
});

Given(/^I am on locale (default|[^\s]+) of langCode (default|[^\s]+) with (\d+) products on shipping page$/, async (
  locale: string, langCode: string, products: number,
) => {
  await DeepLink.stepNavigateToHomePageByDeepLink(locale, langCode, 'with forced accepted cookies');
  await DeepLink.stepNavigateToShoppingBagWithXDifferentProducts(locale, langCode, products, '', '');
  if (services.site.langCode) {
    await DeepLink.stepNavigateToUrlByDeepLink(locale, 'shopping-bag', langCode, '');
  }
  await clickElement('Experience.ShoppingBag.StartCheckoutButton');
});

When(/^I log in with user (.*) and password (.*) on sign in page$/, async (user: string, password: string) => {
  await registeredUserSignIn(user, password);
});

When(/^I continue as (guest|sap_guest|logged in|sap_user logged in|default logged in|invalid user) to shipping page$/, async (userType: string) => {
  // eslint-disable-next-line default-case
  const locale = services.site.locale.toLocaleLowerCase();
  const OnePageCheckout = await services.othersDB.GetXComReg(XCOMREG.ToggleEnabledOnePageCheckout);

  switch (userType) {
    case 'guest': (OnePageCheckout === 'false')
      ? (await clickElement('Checkout.SignInPage.ProceedAsGuestButton'))
      : await sleep(2000);
      break;
    case 'sap_guest': (OnePageCheckout === 'false')
      ? (await clickElement('Checkout.SignInPage.ProceedAsGuestButton'))
      : await sleep(2000);
      break;
    case 'logged in':
      await registeredUserSignIn(`pvh.${locale.toLowerCase()}.automation@outlook.com`, 'AutoNation2023');
      break;
    default:
    case 'default logged in':
      await registeredUserSignIn('pvh.qa.datalayer.automation@gmail.com', 'avion');
      break;
    case 'sap_user logged in':
      // eslint-disable-next-line no-case-declarations
      const email = 'pvh.sap_user@outlook.com';
      await services.maniPulateCartItemsDB.clearItemsFromSB(email);
      await registeredUserSignIn(email, 'AutoNation2023');
      await sleep(2000);
      break;
    case 'invalid user':
      await registeredUserSignIn('pvh.qa.datalayer.automation@gmail.com', 'avion123!2');
      break;
  }
});

When(/^I reset my account's password$/, async () => {
  const locale = services.site.locale.toLocaleLowerCase();
  const OnePageCheckout = await services.othersDB.GetXComReg(XCOMREG.ToggleEnabledOnePageCheckout);

  if (OnePageCheckout === 'true') {
    await Checkout.OPCSignIn.ResetPassword(locale);
  } else {
    await Checkout.SignIn.ResetPassword(locale);
  }
});

When(/^I continue as (valid user|invalid user) with remember checkbox as (default|true|false) to shipping page$/, async (userType: string, checkbox: string) => {
  switch (userType) {
    case 'valid user':
      await Checkout.SignIn.signInFromShippingPage('automation.test.user@gmail.com', 'qwerty1234', checkbox);
      break;
    case 'invalid user':
      await Checkout.SignIn.signInFromShippingPage('automation.test.user@gmail.com', 'avion123!2', checkbox);
      break;
    default:
  }
});

When(/^I log in with user (.*) and password (.*) with remember checkbox as (default|true|false) on shipping page$/, async (user: string, password: string, checkbox: string) => {
  await Checkout.SignIn.signInFromShippingPage(user, password, checkbox);
});
