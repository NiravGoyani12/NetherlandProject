import { Singleton } from 'typescript-ioc';
import services from '../../../core/services';
import { waitForPageLoaded } from '../../commands/browser';
import { exist$, maybeDisplayed$ } from '../../general';
import { sleep } from '../../helper/utils.helper';
import { Page } from '../../page';

@Singleton
export default class SignInPage extends Page {
  public readonly ProceedAsGuestButton = () => this.derived({
    Desktop: '//a[@data-testid="guest-pvh-button"]',
  });

  public readonly HiddenSignInButton = () => this.derived({
    Desktop: '//button[contains(@class, "signInButton")]',
  });

  public readonly SignInButton = () => this.derived({
    Desktop: '//button[@data-testid="login-form-submit-pvh-button"]',
  });

  public readonly EmailField = () => this.derived({
    Desktop: '//input[@type="email"]',
  });

  public readonly PasswordField = () => this.derived({
    Desktop: '//input[@type="password"]',
  });

  public readonly ResetPasswordLink = () => this.derived({
    Desktop: '//button[@data-testid="forgot-password-link"]',
  });

  public readonly ResetPasswordEmailField = () => this.derived({
    Desktop: '//input[@id="email-forgot-password-form"]',
  });

  public readonly ResetPasswordSubmit = () => this.derived({
    Desktop: '//button[@data-testid="forgot-password-form-submit-pvh-button"]',
  });

  public readonly ResetPasswordSuccess = () => this.derived({
    Desktop: '//p[@data-testid="forgot-password-success-text-typography-p"]',
  });

  public readonly ResetPasswordCloseButton = () => this.derived({
    Desktop: '//div[@data-testid="pvh-forgot-password-success"]//button[@data-testid="pvh-button"]',
  });

  public readonly EmailSignInError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-email"]',
  });

  public readonly SignInError = () => this.derived({
    Desktop: '//div[@data-testid="checkout-pvh-login-form"]/div[@data-testid="alert-error"]',
  });

  public readonly PasswordSignInError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-password"]',
  });

  public readonly RememberMeCheckbox = () => this.derived({
    Desktop: '//input[@data-testid="rememberMe-Checkbox-Component-input"]',
  });

  public readonly CheckoutSignInButton = () => this.derived({
    Desktop: '//button[@data-testid="checkout-login-pvh-button"]',
  });

  public async RegisteredUserSignIn(email: string, password: string) {
    if (services.env.IsMobile) {
      await (await exist$(this.HiddenSignInButton())).safeClick();
    }
    await sleep(1000);
    await waitForPageLoaded();
    await (await exist$(this.EmailField())).safeType(email);
    await (await exist$(this.PasswordField())).safeType(password);
    const signInButton = await (await exist$(this.SignInButton()));

    const isEnabled = await signInButton.waitForEnabled({
      timeout: 12000,
      interval: 500,
    }).catch(() => false);

    if (isEnabled) {
      await signInButton.safeClick();
    } else {
      throw new Error('Login button is still disabled');
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
    const resetPasswordLink = await (await exist$(this.ResetPasswordLink()));
    const email = `pvh.${locale}.automation@outlook.com`;

    await resetPasswordLink.jsClick();
    const resetPasswordEmailField = await (await maybeDisplayed$(this.ResetPasswordEmailField()));
    const resetPasswordButton = await (await exist$(this.ResetPasswordSubmit()));
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
    const resetPasswordMessage = await (await maybeDisplayed$(this.ResetPasswordSuccess()));
    const successfulReset = await (await resetPasswordMessage.getText()).lastIndexOf(email);

    if (successfulReset < 0) {
      throw new Error('Success message does not contain account email address');
    } else {
      // eslint-disable-next-line max-len
      const closeResetSuccessButton = await (await maybeDisplayed$(this.ResetPasswordCloseButton()));
      closeResetSuccessButton.safeClick();
    }
  }

  // region paypal express
  public readonly PaypalExpressButton = () => this.derived({
    Desktop: '//button[@data-testid="paypal-express-pvh-button"]',
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

  public async signInFromShippingPage(email:string, password:string, checkbox:string) {
    await sleep(1000);
    await waitForPageLoaded();
    await (await exist$(this.CheckoutSignInButton())).safeClick();
    await (await exist$(this.EmailField())).safeType(email);
    await (await exist$(this.PasswordField())).safeType(password);
    const signInButton = await (await exist$(this.SignInButton()));
    const rememberMeCheckbox = await (await exist$(this.RememberMeCheckbox()));

    const isEnabled = await signInButton.waitForEnabled({
      timeout: 12000,
      interval: 500,
    }).catch(() => false);
    if (checkbox === 'true') {
      await rememberMeCheckbox.setCheckbox(true);
    } else {
      await rememberMeCheckbox.setCheckbox(false);
    }
    if (isEnabled) {
      await signInButton.safeClick();
    } else {
      throw new Error('Login button is still disabled');
    }
  }
}
