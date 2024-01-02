/* eslint-disable no-await-in-loop */
/* eslint-disable import/prefer-default-export */
import { Then, When } from '@pvhqa/cucumber';
import { expect } from 'chai';
import services from '../../../core/services';
import {
  maybeDisplayed$, maybeExist$$, exist$, p$, maybeNotExist$,
} from '../../general';
import { OpenUnifiedMegaMenuOnMobile, CloseUnifiedMegaMenuMobile } from '../../helper/mega-menu.helper';
import { sleep } from '../../helper/utils.helper';
import { clickElement } from '../browser.steps';

import UXHeader from '../../pages/experience/header';

const uxHeader = p$(UXHeader);


Then(/in header I (?:see|wait until) unified wishlist is( not)? active(?: in (\d+) seconds?)?/, async (wishlistNotActive: string, timeoutInSeconds: number) => {
  const timeout = timeoutInSeconds
    ? timeoutInSeconds * 1000
    : services.env.DriverConfig.timeout.elementDisplayed;
  const wishlistActive = !wishlistNotActive;
  await browser.waitUntil(
    async () => {
      const ele = await maybeDisplayed$('Experience.Header.ActiveWishListIcon', 300);
      return wishlistActive === !!ele;
    },
    {
      timeout,
      timeoutMsg: `Wishlist in the header should${wishlistNotActive || ''} be active`,
    },
  );
  await sleep(1000);
});

Then(/in unified header I see every search suggestion matches search query "(.*)"/, async (searchQuery: string) => {
  let searchSuggestionLinksCount = (await maybeExist$$('Experience.SearchSuggestionPanel.SearchSuggestionLinks')).length;
  const maximum = 8;
  if (searchSuggestionLinksCount > maximum) {
    searchSuggestionLinksCount = 8;
  }
  let i = 1;
  while (i <= searchSuggestionLinksCount) {
    const selector = await services.pageObject.getSelector(
      'Experience.SearchSuggestionPanel.SearchSuggestionHighlightText', [i],
    );
    await (await exist$(selector)).scrollIntoView();
    const actualText = await (await exist$(selector)).getText();
    expect(actualText.toLowerCase()).to.contain(searchQuery.toLowerCase(),
      `Search suggestion link with index ${i} doesn't contain expected query ${searchQuery}. Actual value: ${actualText}`);
    i += 1;
  }
});

export const stepOpenSignInForm = async () => {
  if (services.env.IsMobile) {
    await OpenUnifiedMegaMenuOnMobile();
    const signInButton = await exist$('Experience.Header.SignInButton');
    await signInButton.scrollIntoView({ behavior: 'auto', block: 'center' });
  }

  await clickElement('Experience.Header.SignInButton');
};
When(/in unified header I open sign in panel/, stepOpenSignInForm);

When(/in unified header I search "(.*)"/, async (searchTerm: string) => {
  searchTerm = services.product.parse(searchTerm);
  if (services.env.IsMobile) {
    await OpenUnifiedMegaMenuOnMobile();
    await (await exist$(uxHeader.SearchField())).safeType(searchTerm);
    await sleep(500);
  } else {
    await (await exist$(uxHeader.SearchField())).safeType(searchTerm);
  }
});

When(/I open search content container/, async () => {
  const selector = await services.pageObject.getSelector('Experience.Header.UnifiedSearchInputLabelText');
  const ele = await maybeDisplayed$(selector);
  // move focus to element first
  if (services.env.IsMobile) {
    await ele.scrollIntoView();
  }
  await ele.jsClick();
});

export const OpenSignInPanelCK = async () => {
  const authPanelDisplayed = await maybeDisplayed$('AuthPanel.MainBlock', 500);
  if (!authPanelDisplayed) {
    await OpenUnifiedMegaMenuOnMobile();
    const signInButton = await exist$('Header.SignInButton');
    if (services.env.IsMobile) {
      await signInButton.scrollIntoView();
    }
    await signInButton.safeClick();
  }
  await sleep(500);
  const loginFormDisplayed = await maybeDisplayed$('AuthPanel.SignInForm', 1000);
  if (!loginFormDisplayed) {
    await (await exist$('AuthPanel.SignInExpandButton')).safeClick();
    await exist$('AuthPanel.SignInEmailInput');
  }
};

export const LoginWithUserAndPasswordCK = async (email: string, password: string) => {
  email = services.account.parse(email);
  password = services.account.parse(password);
  await OpenSignInPanelCK();
  await Promise.all([
    exist$('AuthPanel.SignInEmailInput').then((ele) => ele.safeType(email)),
    exist$('AuthPanel.SignInPasswordInput').then((ele) => ele.safeType(password)),
  ]);
  await (await exist$('AuthPanel.SignInButton')).safeClick();
  await (await exist$('Header.SignOutButton')).waitForExist({ timeout: 15000, timeoutMsg: 'The sign out button is not displayed' });
  await CloseUnifiedMegaMenuMobile();
};

export const OpenSignUpPanelCK = async () => {
  const authPanelDisplayed = await maybeDisplayed$('AuthPanel.MainBlock', 500);
  if (!authPanelDisplayed) {
    await OpenUnifiedMegaMenuOnMobile();
    const signInButton = await exist$('Header.SignInButton');
    if (services.env.IsMobile) {
      await signInButton.scrollIntoView();
    }
    await signInButton.safeClick();
  }
  await sleep(500);
  const registerFormDisplayed = await maybeDisplayed$('AuthPanel.RegisterForm', 1000);
  if (!registerFormDisplayed) {
    await (await exist$('AuthPanel.RegisterExpandButton')).safeClick();
    await exist$('AuthPanel.RegisterPasswordRepeatField');
  }
};

export const SignUpWithUserAndPasswordCK = async (email: string, password: string) => {
  email = services.account.parse(email);
  password = services.account.parse(password);
  await OpenSignUpPanelCK();
  await Promise.all([
    exist$('AuthPanel.RegisterEmailField').then((ele) => ele.safeType(email)),
    exist$('AuthPanel.RegisterPasswordField').then((ele) => ele.safeType(password)),
    exist$('AuthPanel.RegisterPasswordRepeatField').then((ele) => ele.safeType(password)),
    exist$('AuthPanel.RegisterTermsConditionsCheckBox').then((ele) => ele.setCheckbox(true)),
  ]);
  const registerSubmitButton = await exist$('AuthPanel.RegisterSubmitButton');
  if (services.env.IsMobile) {
    await registerSubmitButton.scrollIntoView();
  }
  await sleep(2000);
  await registerSubmitButton.safeClick();

  await browser.waitUntil(async () => {
    const url = await browser.getUrl();
    return url.indexOf('AjaxLogonForm') > 0 || url.indexOf('/myaccount') > 0;
  }, {
    timeout: 30000,
    interval: 1000,
    timeoutMsg: 'MyAccount url does not contain "AjaxLogonForm" or "/myaccount"',
  });

  await (await exist$('MyAccount.Overview.PageTitle')).waitForDisplayed({ timeout: 10000, timeoutMsg: 'Account overview page is not displayed' });
};

export const InHeaderICanSignOutCK = async () => {
  await browser.waitForPageLoaded();
  await sleep(2000);
  await OpenUnifiedMegaMenuOnMobile();
  if (services.env.IsDesktop) {
    await (await exist$('Header.MyAccountButton')).hover();
  }
  if (services.env.IsMobile) {
    await (await exist$('Header.SignOutButton')).scrollIntoView();
  }
  await (await exist$('Header.SignOutButton')).safeClick();
  if (services.env.IsMobile) {
    await browser.waitUntil(
      async () => {
        const megaMenuDisplayed = await maybeDisplayed$('Header.MegaMenuSecondLevelItems', 1000);
        return megaMenuDisplayed === null;
      },
      {
        timeout: services.env.DriverConfig.timeout.elementDisplayed,
        timeoutMsg: 'Megamenu was not closed after sign out',
      },
    );
  }
  await OpenUnifiedMegaMenuOnMobile();
  await (await exist$('Header.SignInButton')).waitForExist(
    {
      timeout: services.env.DriverConfig.timeout.elementDisplayed,
      timeoutMsg: 'sign in button doesn\'t exist',
    },
  );
  const signOutButton = await maybeNotExist$('Header.SignOutButton', 2000);
  expect(signOutButton, 'sign out button should not exist').to.be.null;
  await CloseUnifiedMegaMenuMobile();
};
