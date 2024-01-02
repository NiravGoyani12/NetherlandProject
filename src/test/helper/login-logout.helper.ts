import services from '../../core/services';
import { exist$ } from '../general';
import { OpenUnifiedMegaMenuOnMobile } from './mega-menu.helper';
import { clickElement } from '../steps/browser.steps';
import { hoverElement } from '../steps/account/account-page.steps';


export const OpenUnifiedSignInPanel = async () => {
  if (services.env.IsMobile) {
    await OpenUnifiedMegaMenuOnMobile();
    const signInButton = await exist$('Experience.Header.SignInButton');
    await signInButton.scrollIntoView({ behavior: 'auto', block: 'center' });
  }

  await clickElement('Experience.Header.SignInButton');
};

export const OpenUnifiedSignUpPanel = async () => {
  await OpenUnifiedSignInPanel();
  await clickElement('MyAccount.RegisterPopUp.RegisterFormButton');
};

export const ClickRememberMeCheckBox = async () => {
  await clickElement('MyAccount.SignInPopUp.RememberMeCheckbox');
};

export const SignInWithUserAndPassword = async (email: string, password: string) => {
  email = services.account.parse(email);
  password = services.account.parse(password);

  await OpenUnifiedSignInPanel();
  await Promise.all([
    exist$('MyAccount.SignInPopUp.EmailField').then((ele) => ele.safeType(email)),
    exist$('MyAccount.SignInPopUp.PasswordField').then((ele) => ele.safeType(password)),
  ]);
  await exist$('MyAccount.SignInPopUp.SignInButton').then((ele) => ele.jsClick());
};

export const SignInWithUserAndPasswordWithoutPanel = async (email: string, password: string) => {
  email = services.account.parse(email);
  password = services.account.parse(password);

  await Promise.all([
    exist$('MyAccount.SignInPopUp.EmailField').then((ele) => ele.safeType(email)),
    exist$('MyAccount.SignInPopUp.PasswordField').then((ele) => ele.safeType(password)),
  ]);
  await exist$('MyAccount.SignInPopUp.SignInButton').then((ele) => ele.jsClick());
};

export const SignUpWithUserAndPassword = async (email: string, password: string) => {
  email = services.account.parse(email);
  password = services.account.parse(password);

  await OpenUnifiedSignUpPanel();
  await Promise.all([
    exist$('MyAccount.RegisterPopUp.EmailField').then((ele) => ele.safeType(email)),
    exist$('MyAccount.RegisterPopUp.PasswordField').then((ele) => ele.safeType(password)),
    // exist$('MyAccount.RegisterPopUp.RepeatPasswordField').then((ele) => ele.safeType(password)),
    exist$('MyAccount.RegisterPopUp.TermsAndConditionsCheckbox').then((ele) => ele.jsClick()),
  ]);
  await exist$('MyAccount.RegisterPopUp.RegisterButton').then((ele) => ele.jsClick());
  await exist$('MyAccount.RegisterPopUp.NewsletterNoButton').then((ele) => ele.jsClick());

  // await browser.waitUntil(async () => {
  //   const url = await browser.getUrl();
  //   return url.indexOf('/myaccount') >= 0;
  // }, {
  //   timeout: 10000,
  //   interval: 1000,
  //   timeoutMsg: 'my account page is not opened',
  // });
};

export const SignUpWithUserAndPasswordWithoutPanel = async (email: string, password: string) => {
  email = services.account.parse(email);
  password = services.account.parse(password);
  await Promise.all([
    exist$('MyAccount.RegisterPopUp.EmailField').then((ele) => ele.safeType(email)),
    exist$('MyAccount.RegisterPopUp.PasswordField').then((ele) => ele.safeType(password)),
    // exist$('MyAccount.RegisterPopUp.RepeatPasswordField').then((ele) => ele.safeType(password)),
    exist$('MyAccount.RegisterPopUp.TermsAndConditionsCheckbox').then((ele) => ele.setCheckbox(true)),
  ]);
  await clickElement('MyAccount.RegisterPopUp.RegisterButton');
  await exist$('MyAccount.RegisterPopUp.NewsletterNoButton').then((ele) => ele.jsClick());


  // await browser.waitUntil(async () => {
  //   const url = await browser.getUrl();
  //   return url.indexOf('/myaccount') >= 0;
  // }, {
  //   timeout: 10000,
  //   interval: 1000,
  //   timeoutMsg: 'my account page is not opened',
  // });
};

export const UnifiedSignOut = async () => {
  if (services.env.IsMobile) {
    await OpenUnifiedMegaMenuOnMobile();
    const signInButton = await exist$('Experience.Header.MyAccountButton');
    await signInButton.scrollIntoView({ behavior: 'auto', block: 'center' });
    await clickElement('Experience.Header.MyAccountButton');
  } else {
    await hoverElement('Experience.Header.MyAccountButton');
  }
  await exist$('MyAccount.AccountFlyout.SignOutButton');
  await clickElement('MyAccount.AccountFlyout.SignOutButton');
};


export const SignUpWithEmailTH = async (email: string) => {
  email = services.account.parse(email);
  await Promise.all([
    exist$('MyAccount.RegisterPopUp.EmailField').then((ele) => ele.safeType(email)),
    exist$('MyAccount.RegisterPopUp.TermsAndConditionsCheckbox').then((ele) => ele.setCheckbox(true)),
  ]);
  await clickElement('MyAccount.RegisterPopUp.RegisterButton');
  await exist$('MyAccount.RegisterPopUp.CheckYourInboxMessage');
};
