/* eslint-disable no-await-in-loop */
/* eslint-disable max-len */
import { Singleton } from 'typescript-ioc';
import { expect } from 'chai';
import { Page } from '../../page';
import { exist$, waitAndClickElement$ } from '../../general';
import services from '../../../core/services';
import { ProductListAttribute } from '../../../core/db/product-model';
import { sleep } from '../../helper/utils.helper';
import shipModeData from '../../../core/json/checkout-shipMode-data.json';

@Singleton
export default class ShippingPage extends Page {
  public readonly ProceedToPayment = () => this.derived({
    Desktop: '//button[contains(@data-testid,"proceed-to-payment-pvh-button")]',
  });

  public readonly ErrorNotification = () => this.derived({
    Desktop: '//div[@data-testid="pvh-PageNotification-error"]//span',
  });

  public readonly ErrorNotificationCloseIcon = () => this.derived({
    Desktop: '//button[@data-testid="pvh-PageNotification-error-close-button-pvh-icon-button"]',
  });

  // #region Standard Personal Details Form
  public readonly GCEmailSubtitle = () => this.derived({
    Desktop: '//span[@data-testid="address-subtitle"]',
  });

  public readonly AddAddressManually = () => this.derived({
    Desktop: '//a[@data-testid="addressAutocompleteEnterManually-ManualLink"]',
  });

  public readonly NewAddressSection = () => this.derived({
    Desktop: '//div[@data-testid="new-address-section"]',
  });

  public readonly FirstNameInput = () => this.derived({
    Desktop: '//input[@id="firstName-checkoutSform"]',
  });

  public readonly LastNameInput = () => this.derived({
    Desktop: '//input[@id="lastName-checkoutSform"]',
  });

  public readonly Address1Input = () => this.derived({
    Desktop: '//input[@id="address1-checkoutSform"]',
  });

  public readonly Address2Input = () => this.derived({
    Desktop: '//input[@id="address2-checkoutSform"]',
  });

  public readonly CityInput = () => this.derived({
    Desktop: '//input[@id="city-checkoutSform"]',
  });

  public readonly StateInput = () => this.derived({
    Desktop: '//input[@id="state-checkoutSform"]',
  });

  public readonly PostcodeInput = () => this.derived({
    Desktop: '//input[@id="zipCode-checkoutSform"]',
  });

  public readonly PhoneInput = () => this.derived({
    Desktop: '//input[@id="phone1-checkoutSform"]',
  });

  public readonly EmailInput = () => this.derived({
    Desktop: '//input[contains(@data-testid,"email1")]',
  });

  public readonly EmailInputMessage = () => this.derived({
    Desktop: '//div[@data-testid="inputHelperText"]/p',
  });

  public readonly InputError = () => this.derived({
    Desktop: '//div[contains(@data-testid, "alert-error")]',
  });

  public readonly InputErrorMessage = (index: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,"alert-error")])${index ? `[${index}]` : ''}`,
  });

  public readonly NewsletterInfoIcon = () => this.derived({
    Desktop: '//div[@data-testid="tooltip"]',
  });

  public readonly NewsletterCheckbox = () => this.derived({
    Desktop: '//input[@data-testid="CollapsibleCheckboxContent-Checkbox-Component-input"]',
  });

  public readonly NewsletterExpandButton = () => this.derived({
    Desktop: '//button[@data-testid="chevron-up-pvh-icon-button"]',
  });

  public readonly ExpandedNewsletterSection = () => this.derived({
    Desktop: '//span[@data-testid="CollapsibleCheckboxContent-CheckboxContent" and contains(@class, "expanded")]',
  });

  public readonly NewsletterTandC = () => this.derived({
    Desktop: '//span[@data-testid="CollapsibleCheckboxContent-CheckboxContent"]',
  });

  public readonly NewsletterTandClink = (index: number) => this.derived({
    Desktop: `(//span[@data-testid="CollapsibleCheckboxContent-CheckboxContent"]/a)${index ? `[${index}]` : ''}`,
  });

  public readonly NewsletterTandCCheckbox = () => this.derived({
    Desktop: '//div[@data-testid="CollapsibleCheckboxContent-Checkbox-Component-icon"]',
  });

  // #endregion

  // #region Delivery Methods
  public readonly PickupTabButton = () => this.derived({
    Desktop: '//li[@data-testid="pickup-tab"]',
  });

  public readonly PuPTabIcon = () => this.derived({
    Desktop: '//*[@data-testid="icon-utility-location-svg"]',
  });

  public readonly DeliveryTabIcon = () => this.derived({
    Desktop: '//*[@data-testid="icon-utility-delivery-svg"]',
  });

  public readonly DeliveryTabButton = () => this.derived({
    Desktop: '//li[@data-testid="delivery-tab"]',
  });

  public readonly StandardRadioButton = () => this.derived({
    Desktop: '(//label[contains(@data-testid,"labelFor")])[1]',
  });

  public readonly ExpressRadioButton = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-UPS_Express"]',
  });

  public readonly ToPickup = () => this.derived({
    Desktop: '(//a[@data-testid="tab-link"])[2]',
  });

  public readonly PVHFormBuilder = () => this.derived({
    Desktop: '//form[@data-testid="@pvh-form-builder"]',
  });

  public readonly CollectInStoreRadioButton = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-CLICK_AND_COLLECT"]',
  });

  public readonly UPSAccesPointRadioButton = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-UPS_Access_Point"]',
  });

  public readonly DHLPackstationRadioButton = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-DHL_PACK_ST"]',
  });

  public readonly PostNLRadioButton = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-POST_NL_PUP"]',
  });

  public readonly BRINGRadioButton = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-BRING_PUDO"]',
  });
  // #endregion

  // #region GiftCard
  public readonly GiftCardBanner = () => this.derived({
    Desktop: '//div[@data-testid="egift-email-message-BannerCard"]',
  });

  public readonly GiftCardBannerMessage = () => this.derived({
    Desktop: '//span[@data-testid="banner-text"]',
  });
  // #endregion

  // #region PostNL Pickup Point
  public readonly PostNLSearchField = () => this.derived({
    Desktop: '//input[@data-testid="POST_NL_PUP-inputField"]',
  });

  public readonly PostNLFindStoreButton = () => this.derived({
    Desktop: '//button[@data-testid="POST_NL_PUP-pvh-button"]',
  });

  public readonly PostNLChangeStoreButton = () => this.derived({
    Desktop: '//button[@data-testid="POSTNLPUP-selectAnotherStore-pvh-button"]',
  });

  public readonly PostNLModalSearchFieldError = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-POST_NL_PUP"]//div[contains(@class,"InputField-error")]',
  });

  public readonly PostNLSearchFieldError = () => this.derived({
    Desktop: '//div[contains(@class,"InputField")]//div[@data-testid="alert-error-POST_NL_PUP"]',
  });

  public readonly PostNLRadioButtonText = () => this.derived({
    Desktop: '(//label[@data-testid="labelFor-POST_NL_PUP"]//span)[2]',
  });
  // #endregion

  // #region DHLPackStation
  public readonly DHLPackstationPostnumber = () => this.derived({
    Desktop: '//input[@data-testid="PUPPostNumber-inputField"]',
  });

  public readonly DHLPackstationNumber = () => this.derived({
    Desktop: '//input[@data-testid="PUPNumber-inputField"]',
  });

  public readonly DHLPaymentInfo = () => this.derived({
    Desktop: '//div[@data-testid="StatusText"]',
  });

  public readonly DHLWebsiteLink = () => this.derived({
    Desktop: '//span[@class="CheckoutAddressForm_DHLlinkStye__HmNOP"]/a',
  });

  public readonly DeliveryMethodSubtitle = () => this.derived({
    Desktop: '//*[contains(@class, "AddressSection_subtitle")]',
  });
  // #endregion

  // #region UPSAccessPoint
  public readonly UPSAccesPointSearchField = () => this.derived({
    Desktop: '//input[@data-testid="UPS Access Point-inputField"]',
  });

  public readonly UPSAccesPointFindStoreButton = () => this.derived({
    Desktop: '//button[@data-testid="UPS Access Point-pvh-button"]',
  });

  public readonly UPSAccessPointChangeStoreButton = () => this.derived({
    Desktop: '//button[@data-testid="UPSAP-selectAnotherStore-pvh-button"]',
  });

  public readonly UPSModalSearchFieldError = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-CLICK_AND_COLLECT"]//div[contains(@class,"InputField-error")]',
  });

  public readonly UPSSearchFieldError = () => this.derived({
    Desktop: '//div[contains(@class,"InputField")]//div[@data-testid="alert-error-UPS Access Point"]',
  });

  public readonly UPSRadioButtonText = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-UPS_Access_Point"]//span[@data-testid="PriceText"]',
  });

  public readonly UPSFreeShipping = () => this.derived({
    Desktop: '(//label[@data-testid="labelFor-UPS_Access_Point"]//span)[2]',
  });
  // #endregion

  // #region PuP reusable elements
  public readonly PUPInStoreModalFindStoreButton = () => this.derived({
    Desktop: '//button[@data-testid="pup-search-form-pvh-button"]',
  });

  public readonly PUPSearchResult = (index: number) => this.derived({
    Desktop: `(//div[@data-testid="locator-store-list"]//div[@data-testid="pvh-selectionItem"])${index ? `[${index}]` : ''}`,
  });

  public readonly PUPSearchResults = () => this.derived({
    Desktop: '//div[@data-testid="locator-store-list"]//div[@data-testid="pvh-selectionItem"]',
  });

  public readonly PUPSearchResultButton = (index: number) => this.derived({
    Desktop: `(//div[@data-testid="locator-store-list"]//button[@data-testid="pvh-button"])${index ? `[${index}]` : ''}`,
  });

  public readonly PUPModalPostCodeField = () => this.derived({
    Desktop: '//div[@data-testid="pvh-InputField"]/label/input[@data-testid="pup-search-form-inputField"]',
  });

  public readonly PUPMapMarker = (index?: number) => this.derived({
    Desktop: `(//*[contains(@class,"mapMarker")])${index ? `[${index}]` : ''}`,
  });

  public readonly PUPDistanceToStore = (index?: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,"pvh-selectionItem")]//div[@data-testid="locatorDistance"])${index ? `[${index}]` : ''}`,
  });

  public readonly PUPOpeningHoursLink = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="collapse-trigger"])${index ? `[${index}]` : ''}`,
  });

  public readonly PUPOpeningDays = () => this.derived({
    Desktop: '//span[@class="AttributeListItem_attributeListItemName__rZGjP"]',
  });

  public readonly PUPOpeningHours = () => this.derived({
    Desktop: '//span[@class="AttributeListItem_attributeListItemValue__xvVuM"]',
  });

  public readonly PUPChoosenStoreInfo = () => this.derived({
    Desktop: '(//div[@data-testid="shipping-options-pvh-selectionItem"]//div[@class="ListItem_PrimaryContent__xvoqo"]//h5[@data-testid="typography-h5"])',
  });

  public readonly PUPModalSearchField = () => this.derived({
    Desktop: '//input[@data-testid="pup-search-form-inputField"]',
  });

  public readonly PUPModalSelectStoreButton = () => this.derived({
    Desktop: '//div[@data-testid="location-details"]/button[@data-testid="pvh-button"]',
  });

  public readonly PUPSearchModalFieldError = () => this.derived({
    Desktop: '//div[contains(@class,"InputField")]//div[@data-testid="alert-error-pup-search-form"]',
  });
  // #endregion

  // #region Colect In Store
  public readonly CollectInStoreSearchField = () => this.derived({
    Desktop: '//input[@data-testid="CLICK_AND_COLLECT-inputField"]',
  });

  public readonly CollectInStoreFindStoreButton = () => this.derived({
    Desktop: '//button[@data-testid="CLICK_AND_COLLECT-pvh-button"]',
  });

  public readonly CiSChangeStoreButton = () => this.derived({
    Desktop: '//button[@data-testid="CNC-selectAnotherStore-pvh-button"]',
  });

  public readonly CollectInStoreRadioButtonText = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-CLICK_AND_COLLECT"]/div/span[2]',
  });

  public readonly CollectInstoreSearchFieldError = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-CLICK_AND_COLLECT"]//div[contains(@class,"InputField-error")]',
  });
  // #endregion

  // #region BRING Pakkeshop
  public readonly BringSearchField = () => this.derived({
    Desktop: '//input[@data-testid="BRING_PUDO-inputField"]',
  });

  public readonly BringFindPUPButton = () => this.derived({
    Desktop: '//button[@data-testid="BRING_PUDO-pvh-button"]',
  });

  public readonly BringChangePUPButton = () => this.derived({
    Desktop: '//button[@data-testid="BPUDO-selectAnotherStore-pvh-button"]',
  });

  public readonly BringModalSearchFieldError = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-BRING_PUP"]//div[contains(@class,"InputField-error")]',
  });

  public readonly BringSearchFieldError = () => this.derived({
    Desktop: '//div[contains(@class,"InputField")]//div[@data-testid="alert-error-BRING_PUDO"]',
  });

  public readonly BringRadioButtonText = () => this.derived({
    Desktop: '//label[@data-testid="labelFor-BRING_PUDO"]/div/span[2]',
  });
  // #endregion

  // #region Product List Display
  public readonly PLDItem = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid='basketItem'${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]`,
  });

  public readonly PLDItemName = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid='basketItem'${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//div[contains(@class, 'basketTitle')]//span`,
  });

  public readonly PLDItemImg = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid='basketItem'${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//img`,
  });

  public readonly PLDItemCurrentPrice = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid='basketItem'${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//span[@data-testid='ProductList-PriceText']`,
  });

  public readonly PLDItemWasPrice = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid='basketItem'${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//span[@data-testid="ProductList-WasPriceText"]`,
  });

  public readonly PLDItemColour = (skuPartNumber?: string) => this.derived({
    Desktop: `(//div[@data-testid='basketItem'${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//div[contains(@class, "attributesValue")]//span)[1]`,
  });

  public readonly PLDItemSize = (skuPartNumber?: string) => this.derived({
    Desktop: `(//div[@data-testid='basketItem'${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//div[contains(@class, "attributesValue")]//span)[2]`,
  });

  public readonly PLDItemQuantity = (skuPartNumber?: string) => this.derived({
    Desktop: `(//div[@data-testid='basketItem'${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//div[contains(@class, "attributesValue")]//span)[3]`,
  });

  public readonly PLDAppliedPromo = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid='basketItem'${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//div[@data-testid="PromoAppliedText"]`,
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

  // #region Delivery Address
  public readonly DeliveryAddressOverview = () => this.derived({
    Desktop: '//div[@data-testid="s-address-overview"]',
  });

  public readonly NewAddressButton = () => this.derived({
    Desktop: '//button[@data-testid="s-add-address-pvh-button"]',
  });

  public readonly EditAddressButton = () => this.derived({
    Desktop: '//button[@data-testid="s-edit-address-pvh-button"]',
  });

  public readonly SelectedDeliveryAddress = () => this.derived({
    Desktop: '//input[@data-testid="s-addressListInput-inputField"]',
  });

  public readonly DeliveryAddressDropdown = (index?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//div[@data-testid="s-addressList-select-component"]',
      optionSelector: `(//div[@data-testid="s-addressList-select-component"]//ul[@data-testid="select-component-options-list"]/li)[${index || 1}]`,
    },
  });

  public readonly SavedDeliveryAddress = () => this.derived({
    Desktop: '//div[@data-testid="address-overview-section"]',
  });

  public readonly DeliveryAddressLine = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="s-address-overview"]//div[@data-testid="address-line"])${index ? `[${index}]` : ''}`,
  });

  public readonly DetailsForShippingLink = () => this.derived({
    Desktop: '//*[@data-testid="Stepper"]//li[@id="2"]',
  });

  public readonly BillingAddressOnPaymentPage = () => this.derived({
    Desktop: '//div[@data-testid="b-address-overview"]',
  });

  // #region New Delivery Address Modal
  public readonly ModalEditAddress = () => this.derived({
    Desktop: '//div[@data-testid="edit-address-Modal-component"]',
  });

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

  public async FirstDeliveryAddress(userType: string) {
    services.checkoutaddress.provideNewAddress(services.site.locale);
    const shippingAddress = services.checkoutaddress.getLatestCheckoutAddress();
    if (userType === 'sap_guest') {
      await (await exist$(this.FirstNameInput())).safeType('pvhSapFirstName', true);
      await (await exist$(this.LastNameInput())).safeType('pvhSapLastName', true);
    } else {
      await (await exist$(this.FirstNameInput())).safeType(shippingAddress.firstname, true);
      await sleep(1000);
      await (await exist$(this.LastNameInput())).safeType(shippingAddress.lastname, true);
      await sleep(1000);
    }
    await (await exist$(this.Address1Input())).safeType(shippingAddress.address);

    if (services.site.locale !== 'pl' && services.site.locale !== 'pt') {
      await (await exist$(this.Address2Input())).safeType(shippingAddress.addition);
    }

    await (await exist$(this.CityInput())).safeType(shippingAddress.city, true);
    await (await exist$(this.PostcodeInput())).safeType(shippingAddress.postcode, true);

    if (shippingAddress.province) {
      await (await exist$(this.StateInput())).safeType(shippingAddress.province, true);
    }
    if (shippingAddress.phone) {
      await (await exist$(this.PhoneInput())).safeType(shippingAddress.phone, true);
      await (await exist$(this.PhoneInput())).safeType(shippingAddress.phone, true);
    }
    if (userType === 'sap_guest') {
      await (await exist$(this.EmailInput())).safeType('pvh.sap_user@outlook.com', true);
      await (await exist$(this.EmailInput())).safeType('pvh.sap_user@outlook.com', true);
    } else {
      await (await exist$(this.EmailInput())).safeType(shippingAddress.email, true);
      await (await exist$(this.EmailInput())).safeType(shippingAddress.email, true);
    }
  }

  public async FirstPersonalAddress(userType: string) {
    services.checkoutaddress.provideNewAddress(services.site.locale);
    const shippingAddress = services.checkoutaddress.getLatestCheckoutAddress();
    if (userType === 'sap_guest') {
      await (await exist$(this.FirstNameInput())).safeType('pvhSapFirstName', true);
      await (await exist$(this.LastNameInput())).safeType('pvhSapLastName', true);
    } else {
      await (await exist$(this.FirstNameInput())).safeType(shippingAddress.firstname, true);
      await (await exist$(this.LastNameInput())).safeType(shippingAddress.lastname, true);
    }
    if (userType === 'sap_guest') {
      await (await exist$(this.EmailInput())).safeType('pvh.sap_user@outlook.com', true);
      await (await exist$(this.EmailInput())).safeType('pvh.sap_user@outlook.com', true);
    } else {
      await (await exist$(this.EmailInput())).safeType(shippingAddress.email, true);
      await (await exist$(this.EmailInput())).safeType(shippingAddress.email, true);
    }
  }

  public async InvalidFirstDeliveryAddress(userType: string) {
    const shippingAddress = services.checkoutaddress.getCountryDetails(services.site.locale);
    await (await exist$(this.FirstNameInput())).safeType('1', true);
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
      await (await exist$(this.PhoneInput())).safeType('8');
    }
    if (userType === 'guest') {
      await (await exist$(this.EmailInput())).safeType('9', true);
    }
  }

  public async NewDeliveryAddress(actionType: string, isCanceled: boolean) {
    let clearText: boolean = false;
    let elem;

    if (actionType === 'edit') {
      clearText = true;
    } else {
      clearText = false;
    }

    services.checkoutaddress.provideNewAddress(services.site.locale);
    const shippingAddress = services.checkoutaddress.getLatestCheckoutAddress();
    if (actionType === 'add') {
      elem = await exist$(this.NewAddressButton());
    } else if (actionType === 'edit') {
      elem = await exist$(this.EditAddressButton());
    } else {
      throw new Error(`Operation '${actionType}' is not supported`);
    }

    const isClickAble = await elem.waitForClickable({
      timeout: 12000,
      interval: 500,
    }).catch(() => false);

    if (isClickAble) {
      await elem.safeClick();
    } else {
      await elem.jsClick();
    }

    //  "true" is being used with clearText because issue EESCK-8838 was not desired to be fixed
    await (await exist$(this.FirstNameInput())).safeType(shippingAddress.firstname, true);
    await (await exist$(this.LastNameInput())).safeType(shippingAddress.lastname, true);
    await (await exist$(this.Address1Input())).safeType(shippingAddress.address, clearText);
    if (services.site.locale !== 'pl' && services.site.locale !== 'pt') {
      await (await exist$(this.Address2Input())).safeType(shippingAddress.addition, clearText);
    }
    await (await exist$(this.CityInput())).safeType(shippingAddress.city, clearText);
    await (await exist$(this.PostcodeInput())).safeType(shippingAddress.postcode, clearText);

    if (shippingAddress.province) {
      // the reason why I have two statements here because sometimes the text does not get overwritten
      await (await exist$(this.StateInput())).safeType(shippingAddress.province, true);
      await (await exist$(this.StateInput())).safeType(shippingAddress.province, true);
    }

    if (shippingAddress.phone) {
      // the reason why I have two statements here because sometimes the text does not get overwritten
      await (await exist$(this.PhoneInput())).safeType(shippingAddress.phone, true);
      await (await exist$(this.PhoneInput())).safeType(shippingAddress.phone, true);
    }

    if (isCanceled) {
      await (await exist$(this.ModalCancelAddress())).safeClick();
    } else {
      await (await exist$(this.ModalSaveAddress())).safeClick();
    }
  }

  public async InvalidNewDeliveryAddress(actionType: string, isCanceled: boolean) {
    let clearText: boolean = false;

    if (actionType === 'edit') {
      clearText = true;
    } else {
      clearText = false;
    }

    const shippingAddress = services.checkoutaddress.getCountryDetails(services.site.locale);

    if (actionType === 'add') {
      await (await exist$(this.NewAddressButton())).safeClick();
    } else if (actionType === 'edit') {
      await (await exist$(this.EditAddressButton())).safeClick();
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

  public async GetDisplayedProductDetails(skuPartNumber: string, wasPrice: number) {
    // match only digits with comma as decimal point
    const pattern = new RegExp('([0-9]*[ ]*[0-9]*[,.])?[0-9]+');
    let oldPrice: number;

    const displayedCurrentPrice = (await (
      await exist$(this.PLDItemCurrentPrice(skuPartNumber))).getText()).match(pattern);
    const currentPrice = displayedCurrentPrice[0].indexOf(',') > 0
      ? Number(displayedCurrentPrice[0].replace(',', '.').replace(' ', '')) : Number(displayedCurrentPrice[0]);

    if (wasPrice !== null) {
      const displayedWasPrice = (await (
        await exist$(this.PLDItemWasPrice(skuPartNumber))).getText()).match(pattern);
      oldPrice = +displayedWasPrice[0].indexOf(',') > 0
        ? Number(displayedWasPrice[0].replace(',', '.').replace(' ', '')) : Number(displayedWasPrice[0]);
    }

    const product: ProductListAttribute = {
      SKU_PARTNUMBER: skuPartNumber,
      NAME: await (await exist$(this.PLDItemName(skuPartNumber))).getText(),
      CURRENT_PRICE: currentPrice,
      WASPRICE: wasPrice ? oldPrice : wasPrice,
      MAIN_COLOUR: await (await exist$(this.PLDItemColour(skuPartNumber))).getText(),
      SIZE: await (await exist$(this.PLDItemSize(skuPartNumber))).getText(),
    };

    return product;
  }

  public async CheckAddressErrors(userType: string, errorType: string) {
    let locale = (services.site.locale).toUpperCase();

    if (services.site.langCode) {
      const langCode = services.site.langCode.toUpperCase();
      locale += `_${langCode}`;
    }
    const countryErrors = services.checkoutaddress.getCountryErrorDetails(locale, errorType);
    const errorCount = services.checkoutaddress.getCountryErrorCount(locale, errorType, userType);

    for (let i = 1; i <= errorCount; i += 1) {
      const errorIndex = (userType === 'guest') ? i - 1 : i;
      const actualErrorMessage = await (await exist$(this.InputErrorMessage(i))).getText();
      const expectedErrorIndex = `error${errorIndex}`;
      expect(actualErrorMessage, `Error ${i} does not match `).to.equal(countryErrors[expectedErrorIndex]);
    }
  }

  public async chooseShipMode(shipMode: string) {
    const locale = services.site.locale.toString().toLocaleLowerCase();
    let searchText = null;
    switch (shipMode) {
      case 'standard':
        await waitAndClickElement$(this.ExpressRadioButton());
        break;
      case 'express':
        await waitAndClickElement$(this.ExpressRadioButton());
        break;
      case 'ups':
        searchText = shipModeData.UPS[locale];
        await waitAndClickElement$(this.PickupTabButton());
        await waitAndClickElement$(this.UPSAccesPointRadioButton());
        (await exist$(this.UPSAccesPointSearchField())).safeType(searchText);
        await waitAndClickElement$(this.UPSAccesPointFindStoreButton());
        await waitAndClickElement$(this.PUPSearchResult(1));
        break;
      case 'cis':
        searchText = shipModeData.CIS[locale];
        await waitAndClickElement$(this.PickupTabButton());
        await waitAndClickElement$(this.CollectInStoreRadioButton());
        (await exist$(this.CollectInStoreSearchField())).safeType(searchText);
        await waitAndClickElement$(this.CollectInStoreFindStoreButton());
        await waitAndClickElement$(this.PUPSearchResult(1));
        break;
      case 'dhl':
        await waitAndClickElement$(this.PickupTabButton());
        await waitAndClickElement$(this.DHLPackstationRadioButton());
        break;
      case 'postNl':
        await waitAndClickElement$(this.PickupTabButton());
        await waitAndClickElement$(this.PostNLRadioButton());
        break;
      default:
        throw new Error(`Cannot parse the shipMode as ${shipMode}`);
    }
  }

  public async CheckPuPDetails(index?: number) {
    let email = services.world.parse('user1#email');
    email = services.account.parse(email);
    index = index ? index - 1 : null;
    const currentAddress = (index >= 0 && index !== undefined && index !== null)
      ? services.checkoutaddress.getAddressByIndex(index)
      : services.checkoutaddress.getLatestCheckoutAddress();

    const pupEmail = await (await exist$(this.EmailInput())).getAttribute('value');
    const pupFirstName = await (await exist$(this.FirstNameInput())).getAttribute('value');
    const pupLastName = await (await exist$(this.LastNameInput())).getAttribute('value');

    expect(pupEmail.trim(), 'Email address does not match').to.equal(email);
    expect(pupFirstName.trim(), 'First name does not match').to.equal(currentAddress.firstname);
    expect(pupLastName.trim(), 'Last name does not match').to.equal(currentAddress.lastname);
  }

  public async shortFirstDeliveryAddress(userType: string) {
    services.checkoutaddress.provideNewAddress(services.site.locale);
    const shippingAddress = services.checkoutaddress.getLatestCheckoutAddress();
    if (userType === 'sap_guest') {
      await (await exist$(this.FirstNameInput())).safeType('pvhSapFirstName', true);
      await (await exist$(this.LastNameInput())).safeType('pvhSapLastName', true);
    } else {
      await (await exist$(this.FirstNameInput())).safeType(shippingAddress.firstname, true);
      await (await exist$(this.LastNameInput())).safeType(shippingAddress.lastname, true);
    }
    if (userType === 'sap_guest') {
      await (await exist$(this.EmailInput())).safeType('pvh.sap_user@outlook.com', true);
    } else {
      await (await exist$(this.EmailInput())).safeType(shippingAddress.email, true);
    }
  }
}
