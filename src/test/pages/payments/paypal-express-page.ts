import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';
import services from '../../../core/services';
import { exist$ } from '../../general';
import { sleep } from '../../helper/utils.helper';
import { waitForPageLoaded } from '../../commands/browser';

@Singleton
export default class PaypalExpressPage extends Page {
  public readonly PaypalExpressButton = () => this.derived({
    Desktop: '//button[@data-testid="paypal-express-pvh-button"]',
  });

  public readonly ShippingPagePPXTermsLink = (index: number) => this.derived({
    Desktop: `(//div[@data-testid="PaypalExpress-component"]//div[@data-testid="paypal-express-terms-text"]/p/a)[${index || 1}]`,
  });

  public readonly ShoppingBagPPXTermsLink = (index: number) => this.derived({
    Desktop: `(//div[@data-testid="PaypalExpress-component"]/following::div[@data-testid="paypal-express-terms-text"]/p/a)[${index || 1}]`,
  });

  public readonly MiniShoppingBagPPXTermsLink = (index: number) => this.derived({
    Desktop: `(//div[@data-testid="MiniShoppingBag-component"]//div[@data-testid="paypal-express-terms-text"]/p/a)[${index || 1}]`,
  });

  public readonly PaypalExpressTermsModal = () => this.derived({
    Desktop: '//div[@data-testid="paypal-express-modal-Modal-component"]',
  });

  public readonly PaypalExpressTermsCheckbox = () => this.derived({
    Desktop: '//input[contains(@data-testid, "terms-condition")]',
  });

  public readonly PaypalTermsConditionsComponentContent = () => this.derived({
    Desktop: '//div[@data-testid="checkout-terms-conditions-Checkbox-Component-content"]//p',
  });

  public readonly PayWithPaypalExpressButton = () => this.derived({
    Desktop: '//div[contains(@class, "odal")]//button[contains(@data-testid, "PayPalExpress") or @data-qa="agree-terms" or contains(@data-testid, "paypal-terms-portal")]',
  });

  public readonly PayPayExpressAddressValidateButton = () => this.derived({
    Desktop: '//button[@data-testid="address-form-validate-pvh-button"]',
  });

  public readonly PayPayExpressInterimEditAddressForm = () => this.derived({
    Desktop: '//div[@data-testid="edit-address-Modal-component"]',
  });

  public readonly PayPayExpressInterimCloseIcon = () => this.derived({
    Desktop: '//button[@data-testid="pvh-icon-button"]',
  });

  public readonly PayPayExpressInterimWarning = () => this.derived({
    Desktop: '//div[@data-testid="pvh-PageNotification-warning"]',
  });

  public readonly PayPayExpressInterimAddressTitle = () => this.derived({
    Desktop: '//div[@data-testid="edit-address-Modal-component"]//div[contains(@class,"AddressModal_title")]',
  });

  public async PayWithPaypalExpress() {
    const paypalButton = await exist$(this.PaypalExpressButton() as string);
    let isClickAble = await paypalButton.waitForClickable({
      timeout: 8000,
      interval: 500,
    }).catch(() => false);

    const behavior = 'auto';
    const block = 'center';
    await paypalButton.scrollIntoView({
      behavior,
      block,
    });

    if (services.site.locale === 'nl'
      || services.site.locale === 'uk'
      || services.site.locale === 'be'
      || services.site.locale === 'de') {
      if (isClickAble) {
        await paypalButton.safeClick();
      } else {
        await paypalButton.jsClick();
      }
    } else {
      if (isClickAble) {
        await paypalButton.safeClick();
        await waitForPageLoaded();
      } else {
        await paypalButton.jsClick();
      }

      const termsAndConditions = await exist$(this.PaypalExpressTermsCheckbox() as string);
      await termsAndConditions.setCheckbox(true);
      const payWithPaypal = await exist$(this.PayWithPaypalExpressButton() as string);
      isClickAble = await payWithPaypal.waitForClickable({
        timeout: 5000,
        interval: 500,
      }).catch(() => false);

      if (isClickAble) {
        await sleep(2000);
        await payWithPaypal.safeClick();
      } else {
        await payWithPaypal.jsClick();
      }
    }
  }
}
