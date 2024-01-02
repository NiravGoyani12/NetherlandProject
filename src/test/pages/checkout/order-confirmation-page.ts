/* eslint-disable dot-notation */
/* eslint-disable no-await-in-loop */
import { Singleton } from 'typescript-ioc';
import { expect } from 'chai';
import { Page } from '../../page';
import { exist$ } from '../../general';
import services from '../../../core/services';
import { getOrderAddress } from '../../helper/checkout-address.helper';

@Singleton
export default class OrderConfirmationPage extends Page {
  public readonly ConfirmationDetails = () => this.derived({
    Desktop: '//div[@data-testid="confirmationDetails-addressBlock"] | //section[@data-testid="checkout-confirmation-your-order"] | //div[@class="confirmation-details"]',
  });

  public readonly ConfirmationDetailsMessage = () => this.derived({
    Desktop: '//div[@class="ConfirmationDetails_ConfirmationDetailsBlock__gWne4"]/span',
  });

  public readonly OrderNumberConfirmationMessage = (index: number) => this.derived({
    Desktop: `(//div[@data-testid="confirmationDetails-orderBlock"]//span)${index ? `[${index}]` : ''}`,
  });

  public readonly OrderThankYouMessage = () => this.derived({
    Desktop: '//span[@data-testid="confirmationDetails-thankyouMessage"]',
  });

  public readonly OrderDeliveryMethodMessage = () => this.derived({
    Desktop: '//div[@data-testid="confirmationDetails-deliveryBlock"]/span[1]',
  });

  public readonly OrderDateConfirmationMessage = () => this.derived({
    Desktop: '//div[@data-testid="confirmationDetails-contentBlock"]/div[1]/span',
  });

  public readonly ContinueShoppingButton = () => this.derived({
    Desktop: '//button[@data-testid="continue-shopping-pvh-button"]',
  });

  // #region GiftCard
  public readonly GiftCardBanner = () => this.derived({
    Desktop: '//div[@data-testid="egift-email-message-BannerCard"]',
  });

  public readonly GiftCardBannerText = () => this.derived({
    Desktop: '//div[@data-testid="egift-email-message-BannerCard"]/span',
  });

  public readonly DeliveryMethod = () => this.derived({
    Desktop: '//span[@data-testid="confirmationDetails-delivery-method-text"]',
  });
  // #endregion

  // #region create account
  public readonly SignUpEmailInput = () => this.derived({
    Desktop: '//input[@data-testid="email-inputField"]',
  });

  public readonly SignUpPasswordInput = () => this.derived({
    Desktop: '//input[@data-testid="password-inputField"]',
  });

  public readonly SignUpConfirmPasswordInput = () => this.derived({
    Desktop: '//input[@data-testid="password-confirm-inputField"]',
  });

  public readonly SignUpTermsAndConditionsCheckbox = () => this.derived({
    Desktop: '//input[@data-testid="terms-Checkbox-Component-input"]',
  });

  public readonly SignUpError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error"]',
  });

  public readonly SignUpButton = () => this.derived({
    Desktop: '//button[@type="submit"]',
  });
  // #endregion

  // #region Address details check
  public readonly DeliveryAddressOverview = () => this.derived({
    Desktop: '//div[@data-testid="s-address-overview"]',
  });

  public readonly DeliveryAddressLine = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="s-address-overview"]//div[@data-testid="address-line"])${index ? `[${index}]` : ''}`,
  });

  public readonly BillingAddressLine = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="b-address-overview"]//div[@data-testid="address-line"])${index ? `[${index}]` : ''}`,
  });

  public readonly OrderConfPageAddressLine = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="Address-component"]//div[@data-testid="address-line"])${index ? `[${index}]` : ''}`,
  });

  public readonly OCPCustomerDetails = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="confirmationDetails-addressBlock"]//span)${index ? `[${index}]` : ''}`,
  });
  // #endregion

  public async getAddressLineText(addressType: string, index: number) {
    let text;
    if (addressType === 'shipping') {
      text = await (await (await exist$(this.DeliveryAddressLine(index))).getText()).trim();
    } else if (addressType === 'billing') {
      text = await (await (await exist$(this.BillingAddressLine(index))).getText()).trim();
    } else if (addressType === 'confirmation') {
      if (index === 1) {
        text = await (await (await exist$(this.OCPCustomerDetails())).getText()).trim();
      } else {
        index -= 1;
        text = await (await (await exist$(this.OrderConfPageAddressLine(index))).getText()).trim();
      }
    }
    return text;
  }

  public async CheckAddressDetails(addressType: string, index?: number, locale?: string) {
    index = index ? index - 1 : null;
    const country = (locale === null || locale === undefined) ? services.site.locale : locale;
    const addressDetails = getOrderAddress(index, country);
    const countryInfo = services.checkoutaddress.getCountryDetails(country);
    const addressLines = [];
    let count = countryInfo['addressLinesCount'];

    // Nordic locales do not display phone number on OCP
    if (addressType === 'confirmation') {
      count = (country === 'se' || country === 'fi' || country === 'dk')
        ? count - 1 : count;
    }

    for (let i = 1; i <= count; i += 1) {
      const addressLine = await this.getAddressLineText(addressType, i);
      addressLines.push(addressLine);
    }

    if (addressLines.length === 0) {
      throw new Error('Actual address is null');
    }

    for (let i = 0; i < addressLines.length - 1; i += 1) {
      const line = `Line${i + 1}`;
      expect(addressLines[i], `Address Line ${i} does not match `).to.equal(addressDetails[line]);
    }
  }
}
