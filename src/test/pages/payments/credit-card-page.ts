/* eslint-disable no-await-in-loop */
import { Singleton } from 'typescript-ioc';
import { TableDefinition } from '@pvhqa/cucumber';
import { Page } from '../../page';
import { exist$, waitAndClickElement$ } from '../../general';
import { GetTestLogger } from '../../../core/logger/test.logger';
import services from '../../../core/services';
import { XCOMREG } from '../../../core/constents';
import { sleep } from '../../helper/utils.helper';
import paymentData from '../../../core/json/payment-data.json';

@Singleton
export default class CreditCardPage extends Page {
  public readonly CreditCardForm = () => this.derived({
    Desktop:
        '//div[@class="payment" or @data-testid="revealContent-scheme-payment-method"]',
  });

  public readonly AdyenIframe = (index: number) => this.derived({
    Desktop: `(//iframe[@class="js-iframe"])[${index}]`,
  });

  public readonly AdyenIframeWithIndex1 = () => this.derived({
    Desktop: '(//iframe[@class="js-iframe"])[1]',
  });

  public readonly SaveCardAdyenIframe = () => this.derived({
    Desktop: '//iframe[@class="js-iframe"]',
  });

  public readonly AdyenPasswordIframe = (index: number) => this.derived({
    Desktop: `(//iframe[@class="adyen-checkout__iframe adyen-checkout__iframe--threeDSIframe"])[${index}]`,
  });

  public readonly CardNumberField = () => this.derived({
    Desktop: '//input[contains(@id, "encryptedCardNumber")]',
  });

  public readonly CardNumberFieldValidated = () => this.derived({
    Desktop:
        '//input[contains(@id, "encryptedCardNumber")] [contains(@class,"input-field--validated")]',
  });

  public readonly CardNumberFieldLabel = () => this.derived({
    Desktop:
        '//div[contains(@class, "adyen-checkout__label")]//span[contains(@data-id,"encryptedCardNumber")]',
  });

  public readonly ExpiryDateField = () => this.derived({
    Desktop: '//input[contains(@id, "encryptedExpiryDate")]',
  });

  public readonly ExpiryDateFieldLabel = () => this.derived({
    Desktop:
        '//div[contains(@class, "adyen-checkout__label")]//span[contains(@data-id,"encryptedExpiryDate")]',
  });

  public readonly SecurityCodeField = () => this.derived({
    Desktop: '//input[contains(@id, "encryptedSecurityCode")]',
  });

  public readonly SecurityCodeFieldLabel = () => this.derived({
    Desktop:
        '//div[contains(@class, "adyen-checkout__label")]//span[contains(@data-id,"encryptedSecurityCode")]',
  });

  public readonly CardNameField = () => this.derived({
    Desktop: '//input[contains(@class, "card__holderName__input")]',
  });

  public readonly CardNameFieldLabel = () => this.derived({
    Desktop:
        '//label[contains(@class, "adyen-checkout__label")]//span[contains(@data-id,"holderName")]',
  });

  public readonly UserName3DS1 = () => this.derived({
    Desktop: '//input[@id="username"]',
  });

  public readonly PasswordField3DS1 = () => this.derived({
    Desktop: '//input[@id="password"]',
  });

  public readonly SubmitButton3DS1 = () => this.derived({
    Desktop:
        '//input[@name="authenticate"] | //input[@class="button paySubmit"]',
  });

  public readonly PasswordField3DS2 = () => this.derived({
    Desktop:
        '//input[contains(@class, "input-field")] | //input[contains(@placeholder, "enter the word")]',
  });

  public readonly SubmitButton3DS2 = () => this.derived({
    Desktop: '//button[@type="submit"]',
  });

  public async fillInCardDetails(cardDetails: TableDefinition) {
    const commands: Array<Promise<any>> = [];
    let year;
    let month;
    let lastName;
    let firstName;
    let element;

    await exist$(this.CreditCardForm(), 10000);
    await exist$(this.AdyenIframe(1), 10000);

    for (let row = 0; row < cardDetails.rows().length; row += 1) {
      const name = cardDetails.rows()[row][0];
      const value = cardDetails.rows()[row][1];
      switch (name) {
        case 'cardNumber':
          await browser.switchToFrame(null);
          element = await exist$(this.AdyenIframe(1), 10000);
          await browser.switchToFrame(element);
          await (await exist$(this.CardNumberField())).safeType(value);
          // TBD to enable back once adyen SDK is upgraded into latest version ...
          // await (await exist$(this.CardNumberField())).clearValue();
          // await (await exist$(this.CardNumberField())).click();
          // eslint-disable-next-line no-plusplus
          // for (let i = 0; i < value.length; i++) {
          //   await (await exist$(this.CardNumberField())).safeType(value[i]);
          //   await sleep(50);
          // }
          break;
        case 'firstName':
          firstName = value;
          break;
        case 'lastName':
          lastName = value;
          break;
        case 'cvv':
          await browser.switchToFrame(null);
          element = await exist$(this.AdyenIframe(3));
          await browser.switchToFrame(element);
          await (await exist$(this.SecurityCodeField())).safeType(value);
          break;
        case 'year':
          year = value;
          break;
        case 'month':
          month = value;
          break;
        default:
          GetTestLogger().info(
            `No specific action performed because value for name is: ${name}`,
          );
          break;
      }
    }
    await Promise.all(commands);

    await browser.switchToFrame(null);
    element = await exist$(this.AdyenIframe(2), 5000);
    await browser.switchToFrame(element);

    await (
      await exist$(this.ExpiryDateField())
    ).safeType(`${month}${year.substring(2)}`, true);

    await browser.switchToFrame(null);
    await (
      await exist$(this.CardNameField())
    ).safeType(`${firstName} ${lastName}`);
  }

  public async fillIn3DS1Details(user: string, password: string) {
    await (await exist$(this.UserName3DS1())).safeType(user);
    await (await exist$(this.PasswordField3DS1())).safeType(password);
    await (await exist$(this.SubmitButton3DS1())).safeClick();
  }

  public async fillIn3DS2Password(password: string) {
    const UnifiedCheckout = await services.othersDB.GetXComReg(
      XCOMREG.ToggleEnabledUnifiedCheckout,
    );
    if (UnifiedCheckout) {
      await sleep(6500);
    }
    const element = await exist$(this.AdyenPasswordIframe(1), 25000);
    await browser.switchToFrame(element);
    await (await exist$(this.PasswordField3DS2())).safeType(password);
    await (await exist$(this.SubmitButton3DS2())).safeClick();
    await browser.switchToFrame(null);
  }

  public async fillInBancontactDetails(cardDetails: TableDefinition) {
    const commands: Array<Promise<any>> = [];
    let year;
    let month;
    let element;
    let cardName;

    await exist$(this.CreditCardForm(), 1000);

    for (let row = 0; row < cardDetails.rows().length; row += 1) {
      const name = cardDetails.rows()[row][0];
      const value = cardDetails.rows()[row][1];
      switch (name) {
        case 'cardNumber':
          await browser.switchToFrame(null);
          element = await exist$(this.AdyenIframe(1), 10000);
          await browser.switchToFrame(element);
          await (await exist$(this.CardNumberField())).safeType(value);
          // TBD to enable back once adyen SDK is upgraded into latest version ...
          // await (await exist$(this.CardNumberField())).clearValue();
          // await (await exist$(this.CardNumberField())).click();
          // // eslint-disable-next-line no-plusplus
          // for (let i = 0; i < value.length; i++) {
          //   await (await exist$(this.CardNumberField())).safeType(value[i]);
          //   await sleep(50);
          // }
          break;
        case 'year':
          year = value;
          break;
        case 'month':
          month = value;
          break;
        case 'cvv':
          await browser.switchToFrame(null);
          element = await exist$(this.AdyenIframe(3));
          await browser.switchToFrame(element);
          await (await exist$(this.SecurityCodeField())).safeType(value);
          break;
        case 'cardName':
          cardName = value;
          break;
        default:
          GetTestLogger().info(
            `No specific action performed because value for name is: ${name}`,
          );
          break;
      }
    }
    await Promise.all(commands);

    await browser.switchToFrame(null);
    element = await exist$(this.AdyenIframe(2), 5000);
    await browser.switchToFrame(element);
    if (month && year.length > 0) {
      await (
        await exist$(this.ExpiryDateField())
      ).safeType(`${month}${year.substring(2)}`, true);
      await browser.switchToFrame(null);
    }

    if (cardName && cardName.length > 0) {
      await browser.switchToFrame(null);
      await (
        await exist$(this.CardNameField())
      ).safeType(cardName);
    }
  }

  public async fillInCVV(value: string) {
    const element = await exist$(this.SaveCardAdyenIframe(), 1000);
    await exist$(this.SaveCardAdyenIframe(), 10000);
    await browser.switchToFrame(null);
    await browser.switchToFrame(element);
    await (await exist$(this.SecurityCodeField())).safeType(value);
    await browser.switchToFrame(null);
  }

  public async fillInCardDetailsInfo(creditCardType: string) {
    const cardNumberValue = paymentData.creditCard[creditCardType].creditCardNumber;
    const expiryDateValue = paymentData.creditCard[creditCardType].expiryDate;
    const cvvValue = paymentData.creditCard[creditCardType].cvv;
    const cardNameValue = paymentData.creditCard[creditCardType].cardName;

    await waitAndClickElement$('Checkout.PaymentPage.CreditCardButton');
    await sleep(3000);

    await exist$(this.CreditCardForm(), 10000);

    await browser.switchToFrame(null);
    let element = await exist$(this.AdyenIframe(1), 10000);
    await browser.switchToFrame(element);
    await (await exist$(this.CardNumberField())).isDisplayedInViewport();
    await (await exist$(this.CardNumberField())).click();
    await (await exist$(this.CardNumberField())).safeType(cardNumberValue);
    await browser.switchToFrame(null);
    element = await exist$(this.AdyenIframe(3));
    await browser.switchToFrame(element);
    await (await exist$(this.SecurityCodeField())).safeType(cvvValue);
    await browser.switchToFrame(null);
    element = await exist$(this.AdyenIframe(2), 5000);
    await browser.switchToFrame(element);
    await (await exist$(this.ExpiryDateField())).safeType(expiryDateValue, true);
    await browser.switchToFrame(null);
    await (await exist$(this.CardNameField())).safeType(cardNameValue);
  }
}
