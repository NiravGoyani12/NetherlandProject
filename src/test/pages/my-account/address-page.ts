import { Singleton } from 'typescript-ioc';
import services from '../../../core/services';
import { exist$ } from '../../general';
import { Page } from '../../page';

@Singleton
export default class AddressPage extends Page {
  public readonly AddAddressButton = () => this.derived({
    Desktop: '//*[@data-testid="icon-utility-account-add-address-svg"]',
  });

  public readonly AddressCard = () => this.derived({
    Desktop: '//section[@data-testid="pvh-content-switch-card"]',
  });

  // #region Address input fields
  public readonly MrsButton = () => this.derived({
    Desktop: '//button[@data-testid="pvh-ToggleButton"][1]',
  });

  public readonly MrButton = () => this.derived({
    Desktop: '//button[@data-testid="pvh-ToggleButton"][2]',
  });

  public readonly OtherButton = () => this.derived({
    Desktop: '//button[@data-testid="pvh-ToggleButton"][3]',
  });

  public readonly FirstNameInput = () => this.derived({
    Desktop: '//input[contains(@id, "firstName-")]',
  });

  public readonly LastNameInput = () => this.derived({
    Desktop: '//input[contains(@id, "lastName-")]',
  });

  public readonly AddressInput = () => this.derived({
    Desktop: '//input[contains(@id, "address1-")]',
  });

  public readonly AditionInput = () => this.derived({
    Desktop: '//input[contains(@id, "address2-")]',
  });

  public readonly StateInput = () => this.derived({
    Desktop: '//input[contains(@id, "state-")]',
  });

  public readonly CityInput = () => this.derived({
    Desktop: '//input[contains(@id, "city-")]',
  });

  public readonly PostCodeInput = () => this.derived({
    Desktop: '//input[contains(@id, "zipCode-")]',
  });

  public readonly PhoneInput = () => this.derived({
    Desktop: '//input[contains(@id, "phone1-")]',
  });

  public readonly ClosePopUp = () => this.derived({
    Desktop: '//button[@data-testid="pvh-PageNotification-info-close-button-pvh-icon-button"]',
  });

  public readonly CountryDropdown = (text: string) => this.derived({
    Desktop: {
      dropdownSelector: '//input[@data-testid="addressCountryInput-inputField"]',
      optionSelector: `//li[contains(@id, "downshift-") and text()="${text}"]`,
    },
    Mobile: {
      dropdownSelector: '//select[@data-testid="addressCountry-native-select"]',
      optionSelector: `//select[@data-testid="addressCountry-native-select"]//option[text()="${text}"]`,
    },
  });

  public readonly AddressTypeDropdown = (index: string) => this.derived({
    Desktop: {
      dropdownSelector: '//div[@data-testid="addressType-select-component"]',
      optionSelector: `//ul[contains(@id, "downshift-")]//li[${index}]`,
    },
    Mobile: {
      dropdownSelector: '//select[@data-testid="addressType-native-select"]',
      optionSelector: `//select[@data-testid="addressType-native-select"]//option[${index}]`,
    },
  });
  // #endregion

  // #region Buttons
  public readonly SaveAddressButton = () => this.derived({
    Desktop: '//button[@data-testid="address-form-add-pvh-button"]',
  });

  public readonly CancelButton = () => this.derived({
    Desktop: '//button[@data-testid="address-form-cancel-pvh-button"]',
  });

  public readonly AddFormCloseButton = () => this.derived({
    Desktop: '//button[@data-testid="address-open-close"]',
  });

  public readonly AddressEditButton = () => this.derived({
    Desktop: '//button[contains(@data-testid, "address-open-close")]',
  });

  public readonly DeleteAddressButton = () => this.derived({
    Desktop: '//button[contains(@data-testid,"address-delete")]',
  });
  // #endregion

  // #region Pop up
  public readonly ChangesNotSavedPopUpTitle = () => this.derived({
    Desktop: '//h2[@data-testid="pvh-dialog-title"]',
  });

  public readonly ChangesNotSavedPopUpInfo = () => this.derived({
    Desktop: '//span[@data-testid="pvh-dialog-subtitle"]',
  });

  public readonly DiscardButton = () => this.derived({
    Desktop: '//button[@data-testid="discard-pvh-button"]',
  });

  public readonly ContinueEdittingButton = () => this.derived({
    Desktop: '//button[@data-testid="continue-editing-pvh-button"]',
  });

  public readonly PopUpCloseButton = () => this.derived({
    Desktop: '//button[@aria-label="Click to close"]',
  });
  // #endregion

  public readonly SuccessfullDoneNotification = () => this.derived({
    Desktop: '//div[@data-testid="page-notification-transition"]',
  });

  //  #region Errors
  public readonly FirstNameError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-firstName"]',
  });

  public readonly LastNameError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-lastName"]',
  });

  public readonly EmailFieldError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-email1"]',
  });

  public readonly AddressError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-address1"]',
  });

  public readonly StateError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-state"]',
  });

  public readonly CityError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-city"]',
  });

  public readonly PostCodeError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-zipCode"]',
  });
  // #endregion

  public readonly EmailAddress = () => this.derived({
    Desktop: '//section[@data-testid="pvh-content-switch-card"]//p[@data-testid="address-email-typography-p"]',
  });

  public async NewAddress() {
    services.checkoutaddress.provideNewAddress(services.site.locale);
    const shippingAddress = services.checkoutaddress.getLatestCheckoutAddress();
    await (await exist$(this.FirstNameInput())).safeType(shippingAddress.firstname);
    await (await exist$(this.LastNameInput())).safeType(shippingAddress.lastname);
    await (await exist$(this.AddressInput())).safeType(shippingAddress.address);
    if (shippingAddress.addition) {
      await (await exist$(this.AditionInput())).safeType(shippingAddress.addition);
    }
    await (await exist$(this.CityInput())).safeType(shippingAddress.city);
    await (await exist$(this.PostCodeInput())).safeType(shippingAddress.postcode);
    if (shippingAddress.province) {
      await (await exist$(this.StateInput())).safeType(shippingAddress.province);
    }
    if (shippingAddress.phone) {
      await (await exist$(this.PhoneInput())).safeType(shippingAddress.phone);
    }
  }
}
