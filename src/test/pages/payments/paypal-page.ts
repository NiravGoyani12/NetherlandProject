import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';
import { maybeDisplayed$, exist$, maybeExist$ } from '../../general';
import { sleep } from '../../helper/utils.helper';
import { REVERSE_CHECK } from '../../../core/constents';
import { GetTestLogger } from '../../../core/logger/test.logger';
import services from '../../../core/services';

@Singleton
export default class PayPalPage extends Page {
  public readonly Loader = () => this.derived({
    Desktop: '.loader',
  });

  public readonly LogoHeader = () => this.derived({
    Desktop: '//*[@data-testid="header-container"]',
  });

  public readonly GuestScreenLoginButton = () => this.derived({
    Desktop: '//div[contains(@class,"baslLoginButtonContainer")]/a',
  });

  public readonly PaypalLogo = () => this.derived({
    Desktop: '//div[@id="content"]//p[@class="paypal-logo paypal-logo-long"]',
  });

  public readonly ChangeEmailButton = () => this.derived({
    Desktop: '//a[@id="backToInputEmailLink"]',
  });

  public readonly LoginEmailField = () => this.derived({
    Desktop: '//input[@name="login_email" and not(@style)]',
  });

  public readonly LoginIframe = () => this.derived({
    Desktop: '//iframe[contains(@src, "signin")]',
  });

  public readonly LoginNextButton = () => this.derived({
    Desktop: '#btnNext',
  });

  public readonly LoginPasswordField = () => this.derived({
    Desktop: '//*[@name="login_password"]',
  });

  public readonly PayPalLockIcon = () => this.derived({
    Desktop: '//body//div[@class="lockIcon"]',
  });

  public readonly LoginLoginButton = () => this.derived({
    Desktop: '#btnLogin',
  });

  public readonly CancelAndReturnButton = () => this.derived({
    Desktop: '//button[@data-qa="disagree-terms"] | //a[@id="cancelLink"] | //*[@data-testid="cancel-link"]',
  });

  public readonly ConfirmPaymentButton = () => this.derived({
    Desktop: '//button[@data-testid="submit-button-initial"]',
  });

  public readonly ConfirmPaymentSecondaryButton = () => this.derived({
    Desktop: '//input[@id="confirmButtonTop"]',
  });

  public readonly PaypalTermsConditionsCheckbox = () => this.derived({
    Desktop: '//input[@data-testid="terms-condition-checkbox"]',
  });

  public readonly PayPalModal = () => this.derived({
    Desktop: '//div[@data-qa="modal-content" or @data-testid="modal-content"]',
  });

  public readonly ModalCheckoutButton = () => this.derived({
    Desktop: '//div[@data-qa="modal-content" or @data-testid="modal-content"]//button[@data-qa="agree-terms" or @data-testid="PayPalExpress-button"]',
  });

  public readonly OneTouchDeclineButton = () => this.derived({
    Desktop: '//a[@id="notNowLink"]',
  });

  public readonly PayPalUserInfo = () => this.derived({
    Desktop: '//*[@data-testid="personalized-banner"]',
  });

  public readonly PayPalLogOutButton = () => this.derived({
    Desktop: '//*[@data-testid="personalized-banner-logout-btn"]',
  });

  public readonly paypalPaymentLogoVisa = () => this.derived({
    Desktop: '//div[contains(@data-testid,"fi-content")]',
  });

  public readonly paypalCreditCardLink = () => this.derived({
    Desktop: '//div[contains(@data-testid,"add-fi-link")]',
  });

  public readonly paypalAcceptCookiesButton = () => this.derived({
    Desktop: '//button[@id="acceptAllButton"]',
  });

  public readonly paypalExpressTermsButton = () => this.derived({
    Desktop: '//button[@data-testid="paypal-terms-portal-pvh-button"]',
  });

  public readonly paypalExpressTermsCheckBox = () => this.derived({
    Desktop: '//input[@data-testid="checkout-terms-conditions-Checkbox-Component-input"]',
  });

  public async Pay(email: string, password: string) {
    GetTestLogger().info(services.env.Site);

    await this.login(email, password);
    await this.confirm();
    await sleep(1000);
  }

  public async CancelPay() {
    await this.cancel();
  }

  private async cancel() {
    const acceptCookieButton = await maybeDisplayed$(this.paypalAcceptCookiesButton(), 2000);
    if (acceptCookieButton) {
      await acceptCookieButton.safeClick();
    }
    this.ensureNotLoggedIn();
    const cancelButton = await (await exist$(this.CancelAndReturnButton()));

    const isClickAble = await cancelButton.waitForClickable({
      timeout: 12000,
      interval: 500,
    }).catch(() => false);

    if (isClickAble) {
      await cancelButton.safeClick();
    } else {
      await cancelButton.jsClick();
    }
  }

  private async ensureNotLoggedIn() {
    const loader = await $(this.Loader() as string);
    await loader.waitForDisplayed({ timeout: 10000, reverse: REVERSE_CHECK });
    if (await maybeDisplayed$(this.PayPalUserInfo(), 2000)) {
      await (await exist$(this.PayPalLogOutButton())).safeClick();
    }
  }

  private async login(email: string, password: string) {
    const guestScreenLoginButton = await maybeDisplayed$(this.GuestScreenLoginButton(), 15000);
    if (guestScreenLoginButton) {
      await guestScreenLoginButton.safeClick();
    }
    const paypalLogoPromise = maybeDisplayed$(this.PaypalLogo());
    const logoPromise = maybeDisplayed$(this.LogoHeader());
    await Promise.race([paypalLogoPromise, logoPromise]);
    await browser.deleteAllCookies();
    await browser.refresh();
    const acceptCookieButton = await maybeDisplayed$(this.paypalAcceptCookiesButton(), 2000);
    if (acceptCookieButton) {
      await acceptCookieButton.safeClick();
    }
    const loginIframe = await maybeExist$(this.LoginIframe(), 2000);
    if (loginIframe) {
      await browser.switchToFrame(loginIframe);
    }
    const changeEmail = await maybeDisplayed$(this.ChangeEmailButton(), 2000);
    if (changeEmail) {
      await changeEmail.safeClick();
    }
    const loginEmail = await exist$(this.LoginEmailField(), 2000);
    await loginEmail.safeType(email, true);
    const nextBtn = await maybeDisplayed$(this.LoginNextButton(), 2000);
    if (nextBtn) {
      await nextBtn.safeClick();
    }

    const spinerLoader = await $(this.PayPalLockIcon() as string);
    await sleep(2000);
    await spinerLoader.waitForDisplayed({ timeout: 30000, reverse: true });
    if (spinerLoader && await maybeDisplayed$(this.LoginPasswordField(), 2000)) {
      await (await exist$(this.LoginPasswordField())).safeType(password, true);
    }
    // await (await exist$(this.LoginPasswordField())).safeType(password, true);
    await sleep(2000);
    await (await exist$(this.LoginLoginButton())).safeClick();
    await browser.switchToFrame(null);
  }

  private async confirm() {
    const oneTouchDeclineBtnPromise = maybeDisplayed$(this.OneTouchDeclineButton(), 2000);
    const acceptCookieButtonPromise = maybeDisplayed$(this.paypalAcceptCookiesButton(), 2000);
    const [oneTouchDeclineBtn, acceptCookieButton] = await Promise.all(
      [oneTouchDeclineBtnPromise, acceptCookieButtonPromise],
    );
    if (oneTouchDeclineBtn) {
      await oneTouchDeclineBtn.safeClick();
    }
    if (acceptCookieButton) {
      await acceptCookieButton.safeClick();
    }
    const logoVisa = maybeDisplayed$(this.paypalPaymentLogoVisa(), 2000);
    const cardLink = maybeDisplayed$(this.paypalCreditCardLink(), 2000);
    await Promise.all([logoVisa, cardLink]);
    const confirmButtonPromise = maybeExist$(this.ConfirmPaymentButton(), 2000);
    const confirmSecondaryButtonPromise = maybeExist$(this.ConfirmPaymentSecondaryButton(), 2000);
    const displayedConfirmButton = await Promise.race(
      [confirmButtonPromise, confirmSecondaryButtonPromise],
    ) as WebdriverIO.Element;
    await displayedConfirmButton.safeClick();
  }
}
