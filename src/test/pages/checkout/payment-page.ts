/* eslint-disable max-len */
/* eslint-disable no-await-in-loop */
import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';
import { exist$, maybeExist$, maybeNotExist$ } from '../../general';
import services from '../../../core/services';
import { sleep } from '../../helper/utils.helper';
import { DropdownSelector, XCOMREG } from '../../../core/constents';
import data from '../../../core/json/checkout-address-format.json';
import { GetTestLogger } from '../../../core/logger/test.logger';
import Payment from '../payments';

@Singleton
export default class PaymentPage extends Page {
  // #region payment page
  public readonly ErrorNotification = () => this.derived({
    Desktop: '//div[@data-testid="pvh-PageNotification-error"]//span',
  });

  public readonly ErrorNotificationCloseIcon = () => this.derived({
    Desktop: '//button[@data-testid="pvh-PageNotification-error-close-button-pvh-icon-button"]',
  });

  public readonly ProductLowOnStockText = () => this.derived({
    Desktop: '//div[@data-testid="pvh-IconWithText"]/span',
  });

  public readonly ProductOutOfStockText = () => this.derived({
    Desktop: '//div[@data-testid="OutOfStock-StatusText"]',
  });

  public readonly ProductOutOfStockRemoveButton = () => this.derived({
    Desktop: '//button[@data-testid="deleteOrderItem-pvh-button"]',
  });

  public readonly ProductLowOnStockEditButton = () => this.derived({
    Desktop: '//button[@data-testid="editOrderItem-pvh-button"]',
  });
  // #endregion

  // #region Payment Methods
  public readonly CreditCardButton = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-scheme-payment-method"]',
  });

  public readonly PaypalButton = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-paypal-payment-method"]',
  });

  public readonly KlarnaPayInstallments = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-klarna_account-payment-method"]',
  });

  public readonly Klarna = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-klarna-payment-method"]',
  });

  public readonly P24Button = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-onlineBanking_PL-payment-method"]',
  });

  public readonly BcmcCardTypeIcon = (containerName: string) => this.derived({
    Desktop: `//div[contains(@data-testid,${containerName || ''})]//img[@alt="Bancontact card"]`,
  });

  public readonly GiftCardButton = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-giftcard-payment-method"]',
  });

  public readonly VisaCardTypeIcon = (containerName: string) => this.derived({
    Desktop: `//div[contains(@data-testid,${containerName || ''})]//img[@alt="VISA"]`,
  });

  public readonly MaestroCardTypeIcon = (containerName: string) => this.derived({
    Desktop: `//div[contains(@data-testid,${containerName || ''})]//img[@alt="Maestro"]`,
  });

  public readonly BcmcCardTypeIconNotSelected = (containerName: string) => this.derived({
    Desktop: `//div[contains(@data-testid,${containerName || ''})]//img[@alt="Bancontact card"][(contains(@class,"-not-selected"))]`,
  });

  public readonly VisaCardTypeIconNotSelected = (containerName: string) => this.derived({
    Desktop: `//div[contains(@data-testid,${containerName || ''})]//img[@alt="VISA"][(contains(@class,"-not-selected"))]`,
  });

  public readonly MaestroCardTypeIconNotSelected = (containerName: string) => this.derived({
    Desktop: `//div[contains(@data-testid,${containerName || ''})]//img[@alt="Maestro"][(contains(@class,"-not-selected"))]`,
  });

  public readonly BancontactButton = () => this.derived({
    Desktop: '//div[@data-testid="bcmc-pvh-selectionItem"]',
  });

  public readonly RatepayButton = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-ratepay-payment-method"]',
  });

  public readonly IdealButton = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-ideal-payment-method"]',
  });

  public readonly ClosePaymentErrorButton = () => this.derived({
    Desktop: '//button[@data-testid="pvh-PageNotification-error-close-button-pvh-icon-button"]',
  });

  public readonly SaveForNextPaymentCheckbox = () => this.derived({
    Desktop: '//label[@class="adyen-checkout__checkbox"]',
  });

  public readonly PaymentPageNotificationInfo = () => this.derived({
    Desktop: '//div[@id="payment-container_scheme"]//div[@data-testid="page-notification-transition"]',
  });
  // #endregion

  // #region Credit card
  public readonly CreditDebitCardForm = () => this.derived({
    Desktop: '//div[@data-testid="scheme-container"]',
  });

  public readonly CvvNumberField = () => this.derived({
    Desktop: '//span[contains(@data-uid, "adyen-checkout-encryptedSecurityCode")]',
  });

  public readonly StoredCardFrame = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-stored-card-payment-method"]',
  });

  public readonly StoredCardNumber = () => this.derived({
    Desktop: '//div[contains(@class, "PaymentMethods_StoredCardNumber")]',
  });

  public readonly RemoveStoredCard = () => this.derived({
    Desktop: '//div[contains(@id, "payment-container_stored_card")]//button[@data-testid="payment-remove-card-button"]',
  });

  public readonly RemoveStoredCardCancel = () => this.derived({
    Desktop: '//button[@data-testid="payment-remove-card-modal-back-button-pvh-button"]',
  });

  public readonly RemoveStoredCardConfirm = () => this.derived({
    Desktop: '//button[@data-testid="payment-remove-card-modal-remove-button-pvh-button"]',
  });

  public readonly CreditDebitCardNumberLogo = (type: string) => this.derived({
    Desktop: `//img[@alt="${type}"]`,
  });

  public readonly CreditCardErrorMessage = () => this.derived({
    Desktop: '//div[@class="adyen-checkout__field adyen-checkout__field--cardNumber adyen-checkout__field--error"]//span[contains(@class, "adyen-checkout__error-text")]',
  });

  public readonly ExpiryDateErrorMessage = () => this.derived({
    Desktop: '//div[@class="adyen-checkout__field adyen-checkout__field--50 adyen-checkout__field__exp-date adyen-checkout__field--expiryDate adyen-checkout__field--error"]//span[contains(@class, "adyen-checkout__error-text")]',
  });

  public readonly CvvErrorErrorMessage = () => this.derived({
    Desktop: '//div[@class="adyen-checkout__field adyen-checkout__field--50 adyen-checkout__field__cvc adyen-checkout__field--securityCode adyen-checkout__field--error"]//span[contains(@class, "adyen-checkout__error-text")]',
  });

  public readonly HolderNameErrorMessage = () => this.derived({
    Desktop: '//div[@class="adyen-checkout__field adyen-checkout__card__holderName adyen-checkout__field--error"]//span[contains(@class, "adyen-checkout__error-text")]',
  });
  // #endregion

  public readonly PaymentErrorMessage = () => this.derived({
    Desktop: '//div[@data-testid="pvh-PageNotification-error"]',
  });

  // #region Klarna
  public readonly KlarnaText = () => this.derived({
    Desktop: '//label[contains(@data-testid, "labelFor-klarna")]//span[contains(@class, "PaymentMethods_PaymentMethodDescription")]',
  });

  public readonly KlarnaTextTC = () => this.derived({
    Desktop: '//label[contains(@data-testid, "labelFor-klarna_account-payment-method")]//span[contains(@class, "PaymentMethods_PaymentMethodDescription")]',
  });

  public readonly KlarnaPOTTandCLinks = (index: number) => this.derived({
    Desktop: `(//label[contains(@data-testid, "labelFor-klarna-payment-method")]//div[contains(@data-testid, "klarna-terms-text")]/a)[${index}]`,
  });

  public readonly KlarnaPayOverTimeTandCLinks = (index: number) => this.derived({
    Desktop: `(//div[@data-testid="klarna_account-pvh-selectionItem"]//div[contains(@id, "payment-container_klarna")]//div[contains(@class, "terms-text")]/a)[${index}]`,
  });
  // #endregion

  // #region Payment On Invoice
  public readonly BirthdayDayDate = () => this.derived({
    Desktop: '//input[@data-testid="ratepay-dob-inputField"]',
  });

  public readonly PhoneNumberInput = () => this.derived({
    Desktop: '//input[@data-testid="ratepay-phone-number-inputField"]',
  });

  public readonly BirthdateError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-ratepay-dob"]',
  });
  // #endregion

  // #region Dotpay
  public readonly DotpayNoBank = () => this.derived({
    Desktop: '//div[@id="payment-container_onlineBanking_PL"]//div[@data-testid="onlinebankingpl-error-message-container"]',
  });

  public readonly BankSelectionDropDown = (text?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//div[contains(@class,"adyen-checkout__issuer-list__dropdown")]',
      optionSelector: `//ul[contains(@class, 'adyen-checkout__dropdown__list')]//li[@role='option'][contains(.,"${text || ''}")]`,
    },
    Mobile: {
      dropdownSelector: '//div[contains(@class,"adyen-checkout__issuer-list__dropdown")]',
      optionSelector: `//ul[contains(@class, 'adyen-checkout__dropdown__list')]//li[@role='option'][contains(.,"${text || ''}")]`,
    },
  });
  // #endregion

  // #region Billing Address Form
  public readonly FirstNameInput = () => this.derived({
    Desktop: '//input[@id="firstName-checkoutBform"]',
  });

  public readonly LastNameInput = () => this.derived({
    Desktop: '//input[@id="lastName-checkoutBform"]',
  });

  public readonly Address1Input = () => this.derived({
    Desktop: '//input[@id="address1-checkoutBform"]',
  });

  public readonly Address2Input = () => this.derived({
    Desktop: '//input[@id="address2-checkoutBform"]',
  });

  public readonly CityInput = () => this.derived({
    Desktop: '//input[@id="city-checkoutBform"]',
  });

  public readonly StateInput = () => this.derived({
    Desktop: '//input[@id="state-checkoutBform"]',
  });

  public readonly PostcodeInput = () => this.derived({
    Desktop: '//input[@id="zipCode-checkoutBform"]',
  });

  public readonly PhoneInput = () => this.derived({
    Desktop: '//input[@id="phone1-checkoutBform"]',
  });

  public readonly EmailInputMessage = () => this.derived({
    Desktop: '//div[@data-testid="inputHelperText"]/p',
  });

  public readonly CountryInput = () => this.derived({
    Desktop: '//input[@data-testid="countryInput-inputField"]',
  });

  public readonly InputError = () => this.derived({
    Desktop: '//div[contains(@data-testid, "alert-error")]',
  });

  public readonly InputErrorMessage = (index: number) => this.derived({
    Desktop: `(//div[@data-testid="alert-error"])${index ? `[${index}]` : ''}`,
  });

  public readonly AddressModalWindow = () => this.derived({
    Desktop: '//div[@data-testid="add-address-Modal-component"]',
  });
  // #endregion

  // #region Delivery Address Overview
  public readonly DeliveryAddressOverview = () => this.derived({
    Desktop: '//div[@data-testid="s-address-overview"]',
  });

  public readonly GCEmailSubtitle = () => this.derived({
    Desktop: '//span[@data-testid="address-subtitle"]',
  });

  public readonly DeliveryAddressDropdown = (index?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//div[@data-testid="s-addressList-select-component"]',
      optionSelector: `(//div[@data-testid="s-addressList-select-component"]//ul[@data-testid="select-component-options-list"]/li)[${index || 1}]`,
    },
  });

  public readonly DeliveryAddressLine = (index: number) => this.derived({
    Desktop: `(//div[@data-testid="s-address-overview"]//div[@data-testid="address-line"])${index ? `[${index}]` : ''}`,
  });

  public readonly GiftCardAddressDetails = () => this.derived({
    Desktop: '//input[@data-testid="same-as-shipping-checkbox-Checkbox-Component-input"]',
  });

  public readonly PersonalDetailsTitle = () => this.derived({
    Desktop: '//section[contains(@class,"ShippingAddress")]//div//div//div[@data-testid="address-title"]',
  });
  // #endregion

  // #region Billing Address Overview
  public readonly SameAsShippingCheckbox = () => this.derived({
    Desktop: '//input[@data-testid="same-as-shipping-checkbox-Checkbox-Component-input"]',
  });

  public readonly NewBillingAddressButton = () => this.derived({
    Desktop: '//button[@data-testid="b-add-address-pvh-button"]',
  });

  public readonly BillingAddressDropdown = (index?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//div[@data-testid="b-addressList-select-component"]',
      optionSelector: `(//div[@data-testid="b-addressList-select-component"]//ul[@data-testid="select-component-options-list"]/li)[${index || 1}]`,
    },
  });

  public readonly BillingAddressCountryDropdown = (name?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//div[@data-testid="country-select-component"]',
      optionSelector: `//div[@data-testid="country-select-component"]//ul[@data-testid="select-component-options-list"]/li[text()="${name}"]`,
    },
  });

  public readonly BillingCountry = () => this.derived({
    Desktop: '//div[@data-testid="checkoutBform"]/p|//div[@data-testid="checkoutBform"]/label',
  });
  // #endregion

  // #region New Address Modal
  public readonly ModalInputError = () => this.derived({
    Desktop: '//form[contains(@data-testid, "form-builder")]//div[@data-testid="alert-error"]',
  });

  public readonly ModalInputErrorMessage = (index: number) => this.derived({
    Desktop: `(//form[contains(@data-testid, "form-builder")]//div[@data-testid="alert-error"])${index ? `[${index}]` : ''}`,
  });

  public readonly ModalSaveAddress = () => this.derived({
    Desktop: '//div[contains(@class, "AddressModal")]//button[@data-testid="add-address-pvh-button"]',
  });

  public readonly ModalCancelAddress = () => this.derived({
    Desktop: '//button[@data-testid="cancel-add-address-pvh-button"]',
  });
  // #endregion

  // #region Footer
  public readonly PaymentMethodLogos = () => this.derived({
    Desktop: '//div[contains(@class,"Footer_PaymentLogos")]',
  });

  public readonly PayPalLogo = () => this.derived({
    Desktop: '//div[contains(@class,"Footer_PaymentLogos")]//li[@data-testid="payment-logos-paypal"]',
  });

  public readonly VisaLogo = () => this.derived({
    Desktop: '//div[contains(@class,"Footer_PaymentLogos")]//li[@data-testid="payment-logos-visa"]',
  });

  public readonly MastercardLogo = () => this.derived({
    Desktop: '//div[contains(@class,"Footer_PaymentLogos")]//li[@data-testid="payment-logos-mc"]',
  });

  public readonly MaestroLogo = () => this.derived({
    Desktop: '//div[contains(@class,"Footer_PaymentLogos")]//li[@data-testid="payment-logos-maestro"]',
  });

  public readonly AmericanExpressLogo = () => this.derived({
    Desktop: '//div[contains(@class,"Footer_PaymentLogos")]//li[@data-testid="payment-logos-amex"]',
  });

  public readonly iDealLogo = () => this.derived({
    Desktop: '//div[contains(@class,"Footer_PaymentLogos")]//li[@data-testid="payment-logos-ideal"]',
  });

  public readonly KlarnaLogo = () => this.derived({
    Desktop: '//div[contains(@class,"Footer_PaymentLogos")]//li[@data-testid="payment-logos-klarna"]',
  });

  public readonly RatepayLogo = () => this.derived({
    Desktop: '//div[contains(@class,"Footer_PaymentLogos")]//li[@data-testid="payment-logos-ratepay"]',
  });

  public readonly BcmcLogo = () => this.derived({
    Desktop: '//div[contains(@class,"Footer_PaymentLogos")]//li[@data-testid="payment-logos-bcmc"]',
  });

  public readonly P24Logo = () => this.derived({
    Desktop: '//div[contains(@class,"Footer_PaymentLogos")]//li[@data-testid="payment-logos-onlineBanking_PL"]',
  });

  public readonly DankortLogo = () => this.derived({
    Desktop: '//div[contains(@class,"Footer_PaymentLogos")]//li[@data-testid="payment-logos-dankort"]',
  });
  // #endregion

  public readonly TermsAndConditionsCheckbox = () => this.derived({
    Desktop: '//input[@data-testid="checkout-terms-conditions-Checkbox-Component-input"]',
  });

  public readonly TermsAndConditionsCheckboxError = () => this.derived({
    Desktop: '//div[contains(@class, "Checkbox_isError")]',
  });

  public readonly TermsAndConditionsLinks = (index: number) => this.derived({
    Desktop: `(//div[@data-testid="checkout-terms-conditions-Checkbox-Component"]//a)[${index || 1}]`,
  });

  public readonly PlaceOrderButton = () => this.derived({
    Desktop: '//button[@data-testid="place-order-pvh-button"]',
  });

  public readonly PayWithPayPal = () => this.derived({
    Desktop: '//div[contains(@class, "paypal-buttons-label-pay")]',
  });

  public readonly PaymentMethodName = (paymentMethodName?: string) => this.derived({
    Desktop: `//div[contains(@data-testid, ${paymentMethodName || ''})]`,
  });

  public readonly PaymentMethodByIndex = (index?: number) => this.derived({
    Desktop: `(//fieldset[@data-testid="paymentMethods-wrapper"]//label)${index ? `[${index}]` : ''}`,
  });

  public async SelectBillingCountry(billingCountry: string) {
    await (await exist$(this.SameAsShippingCheckbox())).setCheckbox(false);
    const dropdown = this.BillingAddressCountryDropdown(billingCountry) as DropdownSelector;
    const element = await exist$(dropdown.dropdownSelector);
    await element.selectDropdown(dropdown.optionSelector, true);
  }

  public async AddBillingAddress(actionType: string, differentCountry?: string) {
    let locale;
    if (differentCountry) {
      locale = data[differentCountry.toUpperCase()];
    } else {
      locale = services.site.locale;
    }

    if (differentCountry) {
      services.checkoutaddress.provideNewAddress(differentCountry);
    } else {
      services.checkoutaddress.provideNewAddress(locale);
    }

    const billingAddress = services.checkoutaddress.getLatestCheckoutAddress();

    if (actionType === 'new') {
      await (await exist$(this.NewBillingAddressButton())).click();
    } else if (actionType === 'first') {
      await (await exist$(this.SameAsShippingCheckbox())).setCheckbox(false);
    } else if (actionType === 'giftCardFirst') {
      await (await maybeNotExist$(this.SameAsShippingCheckbox()));
    }

    await (await exist$(this.FirstNameInput())).safeType(billingAddress.firstname, true);
    await (await exist$(this.LastNameInput())).safeType(billingAddress.lastname, true);
    await (await exist$(this.LastNameInput())).safeType(billingAddress.lastname, true);
    await (await exist$(this.Address1Input())).safeType(billingAddress.address);
    if ((locale !== 'pl' || differentCountry !== 'PL') && (locale !== 'pt' || differentCountry !== 'PT')) {
      await (await exist$(this.Address2Input())).safeType(billingAddress.addition);
    }
    await (await exist$(this.CityInput())).safeType(billingAddress.city);
    await sleep(500);
    await (await exist$(this.PostcodeInput())).safeType(billingAddress.postcode);

    if (billingAddress.province) {
      await (await exist$(this.StateInput())).safeType(billingAddress.province);
    }

    if (billingAddress.phone) {
      await (await exist$(this.PhoneInput())).safeType(billingAddress.phone, true);
      await (await exist$(this.PhoneInput())).safeType(billingAddress.phone, true);
    }

    if (actionType === 'new') await (await exist$(this.ModalSaveAddress())).safeClick();
  }

  public async InvalidFirstBillingAddress() {
    const shippingAddress = services.checkoutaddress.getCountryDetails(services.site.locale);
    await (await exist$(this.FirstNameInput())).safeType('1', true);
    await (await exist$(this.FirstNameInput())).safeType('1', true);
    await (await exist$(this.LastNameInput())).safeType('2', true);
    await (await exist$(this.LastNameInput())).safeType('2', true);
    await (await exist$(this.Address1Input())).safeType('3');

    if (services.site.locale !== 'pl' && services.site.locale !== 'pt') {
      await (await exist$(this.Address2Input())).safeType('4');
    }

    await (await exist$(this.CityInput())).safeType('5');
    await (await exist$(this.PostcodeInput())).safeType('6');
    if (shippingAddress.province) {
      await (await exist$(this.StateInput())).safeType('7');
    }
    if (shippingAddress.phone) {
      await (await exist$(this.PhoneInput())).safeType('8', true);
      await (await exist$(this.PhoneInput())).safeType('8', true);
    }
  }

  public async InvalidNewBillingAddress(actionType: string, isCanceled: boolean) {
    let clearText: boolean = false;

    if (actionType === 'edit') {
      clearText = true;
    } else {
      clearText = false;
    }

    const shippingAddress = services.checkoutaddress.getCountryDetails(services.site.locale);

    if (actionType === 'add') {
      await (await exist$(this.NewBillingAddressButton())).safeClick();
    } else {
      throw new Error(`Operation '${actionType}' is not supported`);
    }
    await sleep(3000);

    await (await exist$(this.FirstNameInput())).safeType('1', true);
    await (await exist$(this.LastNameInput())).safeType('2', true);

    if (services.site.locale !== 'pt' && services.site.locale !== 'pl') {
      await (await exist$(this.Address2Input())).safeType('4');
    }
    await (await exist$(this.CityInput())).safeType('5', clearText);
    await (await exist$(this.PostcodeInput())).safeType('6', clearText);

    if (shippingAddress.province) {
      // the reason why I have two statements here because sometimes the text does not get overwritten
      await (await exist$(this.StateInput())).safeType('7', true);
      await (await exist$(this.StateInput())).safeType('7', true);
    }

    if (shippingAddress.phone) {
      // the reason why I have two statements here because sometimes the text does not get overwritten
      await (await exist$(this.StateInput())).safeType('8', true);
      await (await exist$(this.StateInput())).safeType('8', true);
    }

    if (isCanceled) {
      await (await exist$(this.ModalCancelAddress())).safeClick();
    } else {
      await (await exist$(this.ModalSaveAddress())).safeClick();
    }
  }

  public async PayWithPaypal() {
    await browser.scrollToWindowDirection('bottom');
    const paypalButton = await exist$(this.PayWithPayPal() as string);
    const isClickAble = await paypalButton.waitForClickable({
      timeout: 12000,
      interval: 500,
    }).catch(() => false);

    if (services.env.IsMobile) {
      await sleep(3000);
    }

    if (isClickAble) {
      await paypalButton.safeClick();
    } else {
      await paypalButton.jsClick();
    }

    await browser.waitUntil(
      async () => (await browser.getWindowHandles()).length > 1,
      {
        timeout: 10000,
        timeoutMsg: 'Second tab is still not opened after 10 seconds',
      },
    );
    await browser.switchToWindow((await browser.getWindowHandles())[1]);
  }

  public async SetTermsCheckbox(value: string) {
    const ImplicitCheckbox = await services.othersDB.GetXComReg(XCOMREG.ToggleImplicitTermsCheckbox);
    const boolValue = (value === 'true');

    if (ImplicitCheckbox === 'false') {
      const checkboxElement = await exist$(this.TermsAndConditionsCheckbox());
      const isEnabled = await checkboxElement.waitForEnabled({
        timeout: 12000,
        interval: 500,
      }).catch(() => false);

      if (isEnabled) {
        await checkboxElement.setCheckbox(boolValue);
      } else {
        throw new Error(`Checkbox is not clickable. XCOMREG value is ${ImplicitCheckbox}`);
      }
    } else {
      const checkboxElement = await maybeExist$(this.TermsAndConditionsCheckbox());

      if (checkboxElement !== null) {
        const isExist = await checkboxElement.waitForExist({
          timeout: 12000,
          interval: 500,
        }).catch(() => false);

        if (isExist) {
          throw new Error(`Checkbox EXISTS! XCOMREG value is ${ImplicitCheckbox}`);
        }
      } else {
        GetTestLogger().info(`Checkbox does not exist, XCOMREG value is ${XCOMREG}`);
      }
    }
  }

  public async choosePaymentMethod(paymentType: string) {
    let paymentMethod = null;
    let creditCardType = null;
    if (paymentType.includes(',')) {
      paymentMethod = paymentType.split(',')[0].toString();
      creditCardType = paymentType.split(',')[1].toString();
    } else {
      paymentMethod = paymentType;
    }
    switch (paymentMethod) {
      case 'creditCard':
        await Payment.CreditCard.fillInCardDetailsInfo(creditCardType);
        if (creditCardType === 'amex' || creditCardType === 'masterCard') {
          await await Payment.CreditCard.fillIn3DS2Password('password');
        } else if (paymentType.split(',')[1] === 'visa') {
          await await Payment.CreditCard.fillIn3DS2Password('password');
        } else if (paymentType.split(',')[1] === 'bcmc') {
          await await Payment.CreditCard.fillIn3DS1Details('user', 'password');
        }
        break;
      case 'payPal':
        (await exist$(this.PaypalButton())).click();
        await this.PayWithPaypal();
        break;
      case 'payPalExpress':
        await this.PayWithPaypal();
        break;
      case 'ratePay':
        break;
      case 'klarna':
        break;
      case 'klarnaPayLater':
        break;
      default:
        throw new Error(`Cannot parse the payment method as ${paymentType}`);
    }
  }
}
