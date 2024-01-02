/* eslint-disable no-await-in-loop */
import { Singleton } from 'typescript-ioc';
import { TableDefinition } from '@pvhqa/cucumber';
import { Page } from '../../page';
import { exist$ } from '../../general';
import { GetTestLogger } from '../../../core/logger/test.logger';
// import { XCOMREG } from '../../../core/constents';

@Singleton
export default class GiftCardPage extends Page {
  public readonly GiftCardForm = () => this.derived({
    Desktop:
        '//div[@class="payment" or @data-testid="revealContent-giftcard-payment-method"]',
  });

  public readonly AdyenIframe = (index: number) => this.derived({
    Desktop: `(//iframe[@class="js-iframe"])[${index}]`,
  });

  public readonly AdyenIframeWithIndex1 = () => this.derived({
    Desktop: '(//iframe[@class="js-iframe"])[1]',
  });

  public readonly GiftCardNumberField = () => this.derived({
    Desktop: '//input[contains(@id, "encryptedCardNumber")]',
  });

  public readonly GiftCardNumberFieldValidated = () => this.derived({
    Desktop:
        '//input[contains(@id, "encryptedCardNumber")] [contains(@class,"input-field--validated")]',
  });

  public readonly GiftCardNumberFieldLabel = () => this.derived({
    Desktop:
        '//label[contains(@class, "adyen-checkout__label")]//span[contains(@data-id,"encryptedCardNumber")]',
  });

  public readonly SecurityPin = () => this.derived({
    Desktop: '//input[contains(@id, "encryptedSecurityCode")]',
  });

  public readonly ApplyGiftCardButton = () => this.derived({
    Desktop: '//div[@id="payment-container_giftcard"]//button[@data-testid="giftcard-redeem-pvh-button"]',
  });

  public readonly GiftCardNumberFieldError = () => this.derived({
    Desktop: '(//div[@data-testid="giftcard-container"]//span[contains(@class,"error-text")])[1]',
  });

  public readonly GiftSecurityFieldError = () => this.derived({
    Desktop: '(//div[@data-testid="giftcard-container"]//span[contains(@class,"error-text")])[2]',
  });

  public readonly SecurityPinFieldLabel = () => this.derived({
    Desktop:
        '//label[contains(@class, "adyen-checkout__label")]//span[contains(@data-id,"encryptedSecurityCode")]',
  });

  public readonly GiftCardSufficientBalanceTitle = () => this.derived({
    Desktop:
        '//div[@data-testid="revealContent-giftcard-payment-method"]//div[@data-testid="pvh-PageNotification-success"]',
  });

  public readonly GiftCardInSufficientBalanceTitle = () => this.derived({
    Desktop:
        '//div[@data-testid="giftcard-insufficient-balance-title-wrapper"]//div[@data-testid="pvh-PageNotification-success"]',
  });

  public readonly RemoveGiftCardButton = () => this.derived({
    Desktop: '//button[@data-testid="gift-card-remove-button"]',
  });

  public readonly KlarnaPaymentDisabled = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-klarna-payment-method"][contains(@class,"DisabledPayment")]',
  });

  public readonly PayPalPaymentDisabled = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-paypal-payment-method"][contains(@class,"DisabledPayment")]',
  });

  public readonly CreditCardPaymentDisabled = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-scheme-payment-method"][contains(@class,"DisabledPayment")]',
  });

  public readonly GiftCardBalanceDetailsWithSplit = (index?: number) => this.derived({
    Desktop: `(//div//span[@data-testid="giftcard-balance-container"]//span)${index ? `[${index}]` : ''}`,
  });

  public readonly GiftCardOnlyBalance = (index?: number) => this.derived({
    Desktop: `(//div[@id="payment-container_giftcard"]//span[@data-testid="giftcard-balance-container"]//span)${index ? `[${index}]` : ''}`,
  });

  public readonly GiftCardRemainingBalance = (index?: number) => this.derived({
    Desktop: `(//div[@id="payment-container_giftcard"]//span[@data-testid="giftcard-remaining-balance-container"]//span)${index ? `[${index}]` : ''}`,
  });

  public readonly GiftCardAppliedSuccessMessage = () => this.derived({
    Desktop: '//div[@id="payment-container_giftcard"]//span[@id="sufficient-balance-toast-info-content"]',
  });

  public async fillInGiftCardDetails(cardDetails: TableDefinition) {
    const commands: Array<Promise<any>> = [];
    let element;

    await exist$(this.GiftCardForm(), 10000);
    await exist$(this.AdyenIframe(1), 10000);

    for (let row = 0; row < cardDetails.rows().length; row += 1) {
      const name = cardDetails.rows()[row][0];
      const value = cardDetails.rows()[row][1];
      switch (name) {
        case 'cardNumber':
          await browser.switchToFrame(null);
          element = await exist$(this.AdyenIframe(1), 10000);
          await browser.switchToFrame(element);
          await (await exist$(this.GiftCardNumberField())).safeType(value);
          break;
        case 'pin':
          await browser.switchToFrame(null);
          element = await exist$(this.AdyenIframe(2));
          await browser.switchToFrame(element);
          await (await exist$(this.SecurityPin())).safeType(value);
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
  }

  public async fillInGiftCardByNumberPin(giftCardNumber : number, pin : number) {
    let element;
    (await exist$('Checkout.PaymentPage.GiftCardButton')).click();
    await ((await exist$(this.ApplyGiftCardButton())).isEnabled());
    await exist$(this.GiftCardForm(), 10000);
    await exist$(this.AdyenIframe(1), 10000);

    await browser.switchToFrame(null);
    element = await exist$(this.AdyenIframe(1));
    await browser.switchToFrame(element);
    await (await exist$(this.GiftCardNumberField())).safeType(giftCardNumber);

    await browser.switchToFrame(null);
    element = await exist$(this.AdyenIframe(2));
    await browser.switchToFrame(element);
    await (await exist$(this.SecurityPin())).safeType(pin);
    await browser.switchToFrame(null);
    await ((await exist$(this.ApplyGiftCardButton())).isEnabled());
  }
}
