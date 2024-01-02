import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';
import { exist$, maybeExist$ } from '../../general';
import services from '../../../core/services';
import { GetTestLogger } from '../../../core/logger/test.logger';
import { sleep } from '../../helper/utils.helper';
import * as KlarnaDetailsHelper from '../../helper/klarna-details.helper';

@Singleton
export default class KlarnaPage extends Page {
  public readonly PhoneInput = () => this.derived({
    Desktop: '//input[contains(@id,"phone")]',
  });

  public readonly BDInput = () => this.derived({
    Desktop: '//input[contains(@id,"purchase-approval-form-date-of-birth")]',
  });

  public readonly BankID = () => this.derived({
    Desktop: '//button[@id="signInWithBankId"]',
  });

  public readonly GDInput = () => this.derived({
    Desktop: '//select[@id="invoice_kp-purchase-approval-form-user-title"]//option[2]',
  });

  public readonly IDInput = () => this.derived({
    Desktop: '//input[contains(@id,"purchase-approval-form-national-identification-number")][@name="nationalIdentificationNumber"]',
  });

  public readonly ContinueButton = () => this.derived({
    Desktop: '//button[@id="btn-continue"]|//button[@id="onContinue"]|//button[@data-cid="btn-primary"]|//button[@data-testid="select-payment-category"]|//button[@data-testid="pick-plan"]',
  });

  public readonly SkipButton = () => this.derived({
    Desktop: '//button[@data-testid="PushFavoritePayment:skip-favorite-selection"]| //button[@data-testid="SmoothCheckoutPopUp:skip"]',
  });

  public readonly BackButton = () => this.derived({
    Desktop: '//button[@id="back-button"]',
  });

  public readonly ReturnButton = () => this.derived({
    Desktop: '//button[@data-testid="select-payment-category"]',
  });

  public readonly ClosingButton = () => this.derived({
    Desktop: '//button[contains(@id,"close-button")]',
  });

  public readonly IconCloseButton = () => this.derived({
    Desktop: '//div[@id="newCollectPhone__navbar__right-icon__overlay"]',
  });

  public readonly IconMainCloseButton = () => this.derived({
    Desktop: '(//button[@type="button"])[1]',
  });

  public readonly ClosePopupButton = () => this.derived({
    Desktop: '//div[@id="ua-opf-dialog__navbar__right-icon__icon-wrapper"]',
  });

  public readonly CloseButtonConfirm = () => this.derived({
    Desktop: '//button[@id="payment-cancel-dialog-express__confirm"]',
  });

  public readonly CodeInput = () => this.derived({
    Desktop: '//input[@id="otp_field"]',
  });

  public readonly KlarnaIframeFullscreen = () => this.derived({
    Desktop: '//iframe[@id="klarna-hpp-instance-fullscreen"]|//iframe[@id="klarna-apf-iframe"]',
  });

  public readonly KlarnaIframeMain = () => this.derived({
    Desktop: '//iframe[@id="klarna-hpp-instance-main"]|//iframe[@id="klarna-apf-iframe"]|//iframe[@id="klarna-pay-over-time-fullscreen"]|//iframe[@id="klarna-pay-later-fullscreen"]',
  });

  public readonly KlarnaIframeSubmit = () => this.derived({
    Desktop: '//iframe[@id="payinparts_kp.0-card-authentication-3ds-dialog-challenger-iframe"]',
  });

  public readonly ConfirmButton = () => this.derived({
    Desktop: '//button[contains(@id, "continue-button")]|//button[@data-testid="confirm-and-pay"]',
  });

  public readonly SubmitButton = () => this.derived({
    Desktop: '//button[@id="submit-button"]',
  });

  public readonly payFirstOption = () => this.derived({
    Desktop: '//label[contains(@id,"invoice")]',
  });

  public readonly PayMethod = () => this.derived({
    Desktop: '//div[contains(@id,"invoice_kp.92792_30_invoice__article-wrapper")]|//input[@id="pay_later-pay_later"]',
  });

  public readonly PayMethod2 = () => this.derived({
    Desktop: '//input[@name="pay_over_time"]',
  });

  public readonly paySecondOption = () => this.derived({
    Desktop: '//div[@id="payment-method-selector"]//label[2] | //div[@id="pay-later-variants"]//label[2]',
  });

  public readonly payThirdOption = () => this.derived({
    Desktop: '//div[@id="payment-method-selector"]//label[3]',
  });

  public readonly BuyButton = () => this.derived({
    Desktop: '//button[@id="buy-button"]',
  });

  public readonly tandc = () => this.derived({
    Desktop: '//p[@id="pay-later-terms-text"]//a',
  });

  public readonly PolandTermsAndConditions = () => this.derived({
    Desktop: '//div[@id="invoice_kp.92792_30_invoice-purchase-review-terms-checkbox-list-1-checkbox__box"]',
  });

  public readonly PolandFirstCheckbox = () => this.derived({
    Desktop: '//div[2]/div/label[contains(@for,"SwitchCheckbox")]/div[2]',
  });

  public readonly PolandSecondCheckbox = () => this.derived({
    Desktop: '//div[4]/div/label[contains(@for,"SwitchCheckbox")]/div[2]',
  });

  public readonly TermsAndConditions = () => this.derived({
    Desktop: '//*[@id="root"]//div/label/div[2]',
  });

  public readonly ErrorButton = () => this.derived({
    Desktop: '//button[@id="message-dialog-dismiss-button"] | //button[contains(@id,"message-close-button")]',
  });

  public readonly ErrorHand = () => this.derived({
    Desktop: '//div[@id="message-dialog__container"]//h1[@id="message-component-root__header__title"]',
  });

  public async Pay(scenario: string) {
    GetTestLogger().info(services.env.Site);
    let phoneNumber;
    if (scenario === 'Positive') {
      phoneNumber = KlarnaDetailsHelper.parse('#PHONE');
    } else if (scenario === 'Negative') {
      phoneNumber = KlarnaDetailsHelper.parse('#NEGATIVEPHONE');
    } else if (scenario === 'Pending Accept') {
      phoneNumber = KlarnaDetailsHelper.parse('#PENDINGPHONEACCEPT');
    } else if (scenario === 'Pending Refuse') {
      phoneNumber = KlarnaDetailsHelper.parse('#PENDINGPHONEREJECT');
    } else if (scenario === 'Instalments') {
      phoneNumber = KlarnaDetailsHelper.parse('#PHONEINSTALMENTS');
    } else if (scenario === 'NoInstalments') {
      phoneNumber = KlarnaDetailsHelper.parse('#PHONEINSTALMENTSNEGATIVE');
    }

    const idNumber = KlarnaDetailsHelper.parse('#NATIONALID');
    const birthDate = '01011990';
    const confirmationCode = '123456';

    let iframe;
    await sleep(10000);
    iframe = await exist$(this.KlarnaIframeMain());
    await browser.switchToFrame(iframe);

    await browser.switchToFrame(null);
    if (services.site.locale === 'be' || services.site.locale === 'nl' || services.site.locale === 'fi'
      || services.site.locale === 'ch' || services.site.locale === 'at') {
      await (await exist$(this.BuyButton())).safeClick();
      await sleep(10000);
    }
    iframe = await exist$(this.KlarnaIframeFullscreen());
    await browser.switchToFrame(iframe);

    if (services.site.locale === 'fi') {
      await (await exist$(this.IDInput())).safeType(idNumber);
    }

    if (services.site.locale === 'se') {
      await (await exist$(this.BankID())).safeClick();
    }

    // if (services.site.locale === 'at' || services.site.locale === 'de') {
    //   await (await exist$(this.BDInput())).safeType(birthDate);
    //   await (await exist$(this.PhoneInput())).safeType(phoneNumber);
    // }

    if (services.site.locale === 'ch') {
      await (await exist$(this.BDInput())).safeType(birthDate);
      await (await exist$(this.GDInput())).safeClick();
    }

    if (services.site.locale === 'es' || services.site.locale === 'it'
      || services.site.locale === 'fr' || services.site.locale === 'ie' || services.site.locale === 'pt' || services.site.locale === 'ro' || services.site.locale === 'cz') {
      await (await exist$(this.PhoneInput())).safeType(phoneNumber);
      await (await exist$(this.ContinueButton())).safeClick();
      await sleep(1000);
      await (await exist$(this.CodeInput())).safeType(confirmationCode);
      await sleep(1000);
      if (services.site.locale === 'pt') {
        await (await exist$(this.TermsAndConditions())).safeClick();
        await (await exist$(this.ConfirmButton())).safeClick();
      }
    }

    if (services.site.locale === 'be' || services.site.locale === 'nl' || services.site.locale === 'at' || services.site.locale === 'de') {
      await (await exist$(this.PhoneInput())).safeType(phoneNumber);
      await (await exist$(this.ContinueButton())).safeClick();
      await sleep(1000);
      await (await exist$(this.CodeInput())).safeType(confirmationCode);
    }

    if (services.site.locale === 'pl') {
      await (await exist$(this.PhoneInput())).safeType(phoneNumber);
      await (await exist$(this.ContinueButton())).safeClick();
      await (await exist$(this.CodeInput())).safeType(confirmationCode);
      // await (await exist$(this.ContinueButton())).safeClick();
      await sleep(3000);
      await (await exist$(this.PolandFirstCheckbox())).safeClick();
      await (await exist$(this.PolandSecondCheckbox())).safeClick();
      await sleep(2000);
    }

    if (services.site.locale === 'uk') {
      await (await exist$(this.PhoneInput())).safeType(phoneNumber);
      await (await exist$(this.ContinueButton())).safeClick();
      await (await exist$(this.CodeInput())).safeType(confirmationCode);
    }

    if (services.site.locale === 'dk') {
      await (await exist$(this.ContinueButton())).safeClick();
      await (await exist$(this.CodeInput())).safeType(confirmationCode);
    }

    if ((scenario === 'Negative' && services.site.locale === 'fi') || (scenario === 'Negative' && services.site.locale === 'dk') || (scenario === 'Negative' && services.site.locale === 'se') || (scenario === 'Negative' && services.site.locale === 'de') || (scenario === 'Negative' && services.site.locale === 'at')) {
      await (await exist$(this.ConfirmButton())).safeClick();
      await (await exist$(this.ErrorButton())).safeClick();
    } else if ((scenario === 'Negative' && services.site.locale === 'uk') || (scenario === 'Negative' && services.site.locale === 'be')) {
      await (await exist$(this.ConfirmButton())).safeClick();
      await (await exist$(this.ErrorButton())).safeClick();
    } else if (scenario === 'Negative' && services.site.locale === 'pl') {
      await (await exist$(this.ConfirmButton())).safeClick();
      await (await exist$(this.SkipButton())).safeClick();
      await (await exist$(this.ClosingButton())).safeClick();
      await (await exist$(this.ReturnButton())).safeClick();
    } else if (scenario === 'Negative' && services.site.locale === 'nl') {
      await (await exist$(this.ConfirmButton())).safeClick();
      await (await exist$(this.ErrorButton())).safeClick();
    } else if (scenario === 'NoInstalments' && services.site.locale === 'uk') {
      await (await exist$(this.ConfirmButton())).safeClick();
      await (await exist$(this.ErrorButton())).safeClick();
    } else if (scenario === 'NoInstalments' && services.site.locale === 'nl') {
      await (await exist$(this.ErrorButton())).safeClick();
    } else if ((scenario === 'NoInstalments' && services.site.locale === 'fr') || (scenario === 'NoInstalments' && services.site.locale === 'es') || (scenario === 'NoInstalments' && services.site.locale === 'it') || (scenario === 'NoInstalments' && services.site.locale === 'ie')) {
      await (await exist$(this.ConfirmButton())).safeClick();
      await (await exist$(this.SkipButton())).safeClick();
      await (await exist$(this.ClosingButton())).safeClick();
      await (await exist$(this.ReturnButton())).safeClick();
    } else if ((scenario === 'Positive' && services.site.locale === 'pl') || (scenario === 'Positive' && services.site.locale === 'se') || (scenario === 'Positive' && services.site.locale === 'uk') || (scenario === 'Pending Accept' && services.site.locale === 'uk')) {
      const PayButton = await (await exist$(this.ConfirmButton()));
      const isClickAble = await PayButton.waitForClickable({
        timeout: 12000,
        interval: 500,
      }).catch(() => false);

      if (isClickAble) {
        await PayButton.safeClick();
      } else {
        await PayButton.jsClick();
      }
      const Skip = await maybeExist$(this.SkipButton(), 5000);
      if (Skip) {
        await Skip.safeClick();
      }
    } else if ((scenario === 'Instalments' && services.site.locale === 'uk') || (scenario === 'Instalments' && services.site.locale === 'es') || (scenario === 'Instalments' && services.site.locale === 'ie') || (scenario === 'Instalments' && services.site.locale === 'cz') || (scenario === 'Instalments' && services.site.locale === 'fr') || (scenario === 'Instalments' && services.site.locale === 'it')) {
      const PayButton = await (await exist$(this.ConfirmButton()));
      const isClickAble = await PayButton.waitForClickable({
        timeout: 12000,
        interval: 500,
      }).catch(() => false);

      if (isClickAble) {
        await PayButton.safeClick();
      } else {
        await PayButton.jsClick();
      }
      if (services.site.locale === 'fr') {
        iframe = await exist$(this.KlarnaIframeSubmit());
        await browser.switchToFrame(iframe);
        await (await exist$(this.SubmitButton())).safeClick();
      }
      const Skip = await maybeExist$(this.SkipButton(), 5000);
      if (Skip) {
        await Skip.safeClick();
      }
    } else if (scenario === 'Positive' || scenario === 'Pending Refuse' || (scenario === 'Instalments' && services.site.locale === 'nl')) {
      const PayButton = await (await exist$(this.ConfirmButton()));
      const isClickAble = await PayButton.waitForClickable({
        timeout: 12000,
        interval: 500,
      }).catch(() => false);

      if (isClickAble) {
        await PayButton.safeClick();
      } else {
        await PayButton.jsClick();
      }
    }
  }

  public async CancelPay() {
    await sleep(4000);
    // eslint-disable-next-line prefer-const
    const iframe = await exist$(this.KlarnaIframeFullscreen());
    if (services.site.locale === 'uk') {
      await browser.switchToFrame(iframe);
      await (await exist$(this.ClosePopupButton())).safeClick();
      await (await exist$(this.IconCloseButton())).safeClick();
      await browser.switchToFrame(null);
      await (await exist$(this.CloseButtonConfirm())).safeClick();
    } else if ((services.site.locale === 'it') || (services.site.locale === 'es') || (services.site.locale === 'de') || (services.site.locale === 'be')) {
      await browser.switchToFrame(iframe);
      await (await exist$(this.IconCloseButton())).safeClick();
      await (await exist$(this.IconMainCloseButton())).safeClick();
      await browser.switchToFrame(null);
      await (await exist$(this.CloseButtonConfirm())).safeClick();
    }
  }
}
