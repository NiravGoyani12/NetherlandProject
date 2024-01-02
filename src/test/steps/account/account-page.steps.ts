import { Given, When } from '@pvhqa/cucumber';
import services from '../../../core/services';
import { exist$ } from '../../general';
import * as DeepLink from '../deep-link.steps';
import MyAccount from '../../pages/my-account';
import { OpenUnifiedMegaMenuOnMobile } from '../../helper/mega-menu.helper';
import { stepIAmLoggedInOrGuest } from '../accounts.steps';
import { sleep } from '../../helper/utils.helper';
import { clickElement } from '../browser.steps';


// eslint-disable-next-line import/prefer-default-export
export const hoverElement = async (element: string) => {
  const selector = await services.pageObject.getSelector(element);
  const ele = await exist$(selector);
  await ele.hover();
};

export const OpenMyAccountMenuOnMobile = async () => {
  await OpenUnifiedMegaMenuOnMobile();
  const signInButton = await exist$('Experience.Header.MyAccountButton');
  await signInButton.scrollIntoView({ behavior: 'auto', block: 'center' });
  await clickElement('Experience.Header.MyAccountButton');
};

When(/^I open my account menu$/, async () => {
  if (services.env.IsMobile) {
    await OpenMyAccountMenuOnMobile();
  } else {
    await hoverElement('Experience.Header.MyAccountButton');
  }
});

export const stepNavigateToMyAccountPages = async (page: string) => {
  await DeepLink.stepNavigateToUrlByDeepLink(services.site.locale, 'shopping-bag', services.site.langCode, '');
  if (services.env.IsMobile) {
    await OpenMyAccountMenuOnMobile();
  } else {
    await sleep(3000);
    await hoverElement('Experience.Header.MyAccountButton');
  }

  switch (page) {
    case 'details':
      await clickElement('MyAccount.AccountFlyout.AccountDetailsLink');
      break;
    case 'orders':
      await clickElement('MyAccount.AccountFlyout.AccountOrdersLink');
      break;
    case 'addresses':
      await clickElement('MyAccount.AccountFlyout.AccountAddressesLink');
      break;
    case 'preferences':
      await clickElement('MyAccount.AccountFlyout.AccountEmailPreferencesLink');
      await sleep(4000);
      break;
    case 'notifications':
      await clickElement('MyAccount.AccountFlyout.AccountNotificationsLink');
      break;
    case 'tommy club':
      await clickElement('MyAccount.AccountFlyout.TommyMembershipLink');
      break;
    default:
      throw new Error('This page does not exist for my account');
  }
};
When(/^I navigate to (details|addresses|orders|preferences|notifications|tommy club) page$/, stepNavigateToMyAccountPages);

Given(/^I am on my account (details|addresses|orders|preferences|notifications) page on locale (default|[^\s]+) of langCode (default|[^\s]+)?( with accepted cookies| with forced accepted cookies)?$/, async (
  page: string, locale: string, langCode: string, withAcceptedCookies: string,
) => {
  await DeepLink.stepNavigateToHomePageByDeepLink(locale, langCode, withAcceptedCookies);
  await stepIAmLoggedInOrGuest('logged in');
  await stepNavigateToMyAccountPages(page);
});

Given(/^I am (default|Charles|Henk|Pierre|Cross|Joost|T&T) account on orders page on locale (default|[^\s]+) of langCode (default|[^\s]+)( with accepted cookies| with forced accepted cookies)?$/, async (
  userType: string, locale: string, langCode: string, withAcceptedCookies: string,
) => {
  await DeepLink.stepNavigateToHomePageByDeepLink(locale, langCode, withAcceptedCookies);
  await DeepLink.stepNavigateToUrlByDeepLink(locale, 'shopping-bag', langCode, '');

  if (services.env.IsMobile) {
    await OpenUnifiedMegaMenuOnMobile();
    const signInButton = await exist$('Experience.Header.SignInButton');
    await signInButton.scrollIntoView({ behavior: 'auto', block: 'center' });
  }

  await clickElement('Experience.Header.SignInButton');
  // eslint-disable-next-line default-case
  switch (userType) {
    case 'default':
      await MyAccount.SignInPopUp.DefaultUserSignIn();
      break;
    case 'Charles':
      await MyAccount.SignInPopUp.UserSignIn('my.account.charles.automation@outlook.com', 'AutoNation2023');
      break;
    case 'Henk':
      await MyAccount.SignInPopUp.UserSignIn('my.account.henk.automation@outlook.com', 'AutoNation2023');
      break;
    case 'Pierre':
      await MyAccount.SignInPopUp.UserSignIn('my.account.pierre.automation@outlook.com', 'AutoNation2023');
      break;
    case 'Cross':
      await MyAccount.SignInPopUp.UserSignIn(`pvh.${services.site.locale}.automation@outlook.com`, 'AutoNation2023');
      break;
    case 'Joost':
      await MyAccount.SignInPopUp.UserSignIn('joost@pvh.com', 'qwerty1234');
      break;
    case 'T&T':
      await MyAccount.SignInPopUp.UserSignIn('AutomationTrackAndTrace@testing.com', 'AutoNation2023');
      break;
  }

  if (services.env.IsDesktop) {
    await sleep(2000);
    await hoverElement('Experience.Header.MyAccountButton');
  }
  await exist$('MyAccount.AccountFlyout.AccountOrdersLink').then((ele) => ele.jsClick());
});

Given(/^I am on (.*) page with sign in flyout open on locale (default|[^\s]+) of langCode (default|[^\s]+)?( with accepted cookies| with forced accepted cookies)?$/, async (
  page: string, locale: string, langCode: string, withAcceptedCookies: string,
) => {
  await DeepLink.stepNavigateToHomePageByDeepLink(locale, langCode, withAcceptedCookies);
  await DeepLink.stepNavigateToUrlByDeepLink(locale, page, langCode, '');

  if (services.env.IsMobile) {
    await OpenUnifiedMegaMenuOnMobile();
    const signInButton = await exist$('Experience.Header.SignInButton');
    await signInButton.scrollIntoView({ behavior: 'auto', block: 'center' });
  }

  await clickElement('Experience.Header.SignInButton');
});

When(/^I sign in with user "(.*)" and password "(.*)"$/, async (user: string, password: string) => {
  await MyAccount.SignInPopUp.UserSignIn(user, password);
});

When(/^I add a new address as (Mrs|Mr|Other)$/, async (sex: string) => {
  // eslint-disable-next-line default-case
  switch (sex) {
    case 'Mrs':
      break;
    case 'Mr':
      await clickElement('MyAccount.AddressPage.MrButton');
      break;
    case 'Other':
      await clickElement('MyAccount.AddressPage.OtherButton');
      break;
  }
  await MyAccount.AddressPage.NewAddress();
});
