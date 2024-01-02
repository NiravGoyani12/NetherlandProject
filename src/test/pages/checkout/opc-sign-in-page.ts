/* eslint-disable import/no-cycle */
/* eslint-disable max-len */
import { Singleton } from 'typescript-ioc';
import MyAccount from '../my-account';
import { waitForPageLoaded } from '../../commands/browser';
import { exist$, maybeDisplayed$ } from '../../general';
import { Page } from '../../page';

@Singleton
export default class OPCSignInPage extends Page {
  public readonly SignInButton = () => this.derived({
    Desktop: '//button[@data-testid="checkout-login-pvh-button"]',
  });

  public readonly LoginButton = () => this.derived({
    Desktop: '//button[@data-testid="login-form-submit-pvh-button"]',
  });

  public readonly PayPalExpressButton = () => this.derived({
    Desktop: '//button[@data-testid="paypal-express-pvh-button"]',
  });

  public async RegisteredUserSignIn(email: string, password: string) {
    const signIn = await exist$(this.SignInButton());
    await signIn.safeClick();
    const emailField = await exist$(MyAccount.SignInPopUp.EmailField());
    const passwordField = await exist$(MyAccount.SignInPopUp.PasswordField());

    const emailDisplayed = await emailField.waitForDisplayed({
      timeout: 12000,
      interval: 500,
    }).catch(() => false);

    const passwordDisplayed = await passwordField.waitForDisplayed({
      timeout: 12000,
      interval: 500,
    }).catch(() => false);

    if (emailDisplayed && passwordDisplayed) {
      await emailField.safeType(email);
      await passwordField.safeType(password);
      await (await exist$(this.LoginButton())).safeClick();
      await waitForPageLoaded();
    } else {
      throw new Error('Login menu not displayed');
    }

    const address = await (await exist$('Checkout.ShippingPage.EditAddressButton'));
    const shipping = await (await exist$('Checkout.ShippingPage.StandardRadioButton'));

    const addressIsDisplayed = await address.waitForDisplayed({
      timeout: 10000,
      interval: 500,
    }).catch(() => false);

    const shippingIsDisplayed = await shipping.waitForDisplayed({
      timeout: 10000,
      interval: 500,
    }).catch(() => false);

    if (!addressIsDisplayed && !shippingIsDisplayed) {
      throw new Error('Shipping address or method did not load in 10 seconds');
    }
  }

  public async ResetPassword(locale: string) {
    const resetPasswordLink = await (await exist$(MyAccount.SignInPopUp.ForgotPasswordLink()));
    const email = `pvh.${locale}.automation@outlook.com`;

    await resetPasswordLink.jsClick();
    const resetPasswordEmailField = await (await maybeDisplayed$(MyAccount.SignInPopUp.ForgotPasswordEmailField()));
    const resetPasswordButton = await (await exist$(MyAccount.SignInPopUp.ForgotPasswordSendButton()));
    resetPasswordEmailField.safeType(email);

    const isClickAble = await resetPasswordButton.waitForClickable({
      timeout: 12000,
      interval: 500,
    }).catch(() => false);

    if (isClickAble) {
      resetPasswordButton.safeClick();
    } else {
      await resetPasswordButton.jsClick();
    }
    const resetPasswordMessage = await (await maybeDisplayed$(MyAccount.SignInPopUp.PasswordResetMessage()));
    const successfulReset = await (await resetPasswordMessage.getText()).lastIndexOf(email);

    if (successfulReset < 0) {
      throw new Error('Success message does not contain account email address');
    } else {
      // eslint-disable-next-line max-len
      const closeResetSuccessButton = await (await maybeDisplayed$(MyAccount.SignInPopUp.PasswordResetCloseButton()));
      closeResetSuccessButton.safeClick();
    }
  }

  // region paypal express
  public readonly PaypalExpressButton = () => this.derived({
    Desktop: '//button[@data-testid="paypal-express-pvh-button"]',
  });

  public readonly DisabledPaypalExpressButton = () => this.derived({
    Desktop: '//button[@data-testid="paypal-express-pvh-button" and contains(@class, "disabled")]',
  });

  public readonly PaypalExpressTermsModal = () => this.derived({
    Desktop: '//div[@data-testid="paypal-express-modal-Modal-component"]',
  });

  public readonly PaypalExpressTermsCheckbox = () => this.derived({
    Desktop: '//input[@data-testid="checkout-terms-conditions-Checkbox-Component-input"]',
  });

  public readonly PayWithPaypalExpressButton = () => this.derived({
    Desktop: '//button[@data-testid="pvh-button" and contains(@class,"PaypalExpress")]| //button[@data-testid="paypal-terms-portal-pvh-button"]',
  });

  public readonly PaypalExpressErrorMessage = () => this.derived({
    Desktop: '//div[@data-testid="pvh-PageNotification-error"]',
  });

  public readonly PaypalExpressCloseButton = () => this.derived({
    Desktop: '//button[contains(@class, "Modal_CloseButton") and @data-testid="pvh-icon-button"]',
  });

  public readonly PaypalExpressUnavailable = () => this.derived({
    Desktop: '//div[@data-testid="paypal-express-checkout-modal-content"]//h3',
  });

  public readonly PaypalExpressErrorModalClose = () => this.derived({
    Desktop: '//button[@data-testid="paypal-epxress-checkout-modal-button-pvh-button"]',
  });
}
