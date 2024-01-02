/* eslint-disable max-len */
import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class ShoppingBag extends Page {
  public readonly EmptyShoppingBagTitle = (text?: string) => this.derived({
    Desktop: `//*[@data-testid="pvh-IconWithText" and contains(@class,"EmptyList") and contains(., "${text || ''}")]`,
  });

  public readonly ErrorNotification = () => this.derived({
    Desktop: '//div[@data-testid="pvh-PageNotification-error"]//span',
  });

  public readonly ErrorNotificationCloseIcon = () => this.derived({
    Desktop: '//button[@data-testid="pvh-PageNotification-error-close-button-pvh-icon-button"]',
  });

  public readonly EmptyShoppingBagCopy = (text?: string) => this.derived({
    Desktop: `//p[contains(@class,'EmptyShoppingBag') and contains(., "${text || ''}")]`,
  });

  public readonly EmptyShoppingBagButton = (text?: string) => this.derived({
    Desktop: `//button[@data-testid="emptyShoppingBag-pvh-button" and contains(., "${text || ''}")]`,
  });

  public readonly FilledShoppingBagSection = () => this.derived({
    Desktop: '//section[@data-testid="ShoppingBag-component"]',
  });

  // #region filled bag to CTAs
  public readonly FilledBagStartCheckoutTopButton = () => this.derived({
    Desktop: '//*[@data-testid="filledShoppingBagTopCtas"]//*[@data-testid="proceed-to-checkout-pvh-button"]',
  });

  public readonly FilledBagContinueShoppingTopButton = () => this.derived({
    Desktop: '//*[@data-testid="filledShoppingBagTopCtas"]//*[@data-testid="filledShoppingBagContinueShopping-pvh-button"]',
  });

  public readonly EditOrderItemSection = () => this.derived({
    Desktop: '//div[@data-testid="EditOrderItem-component"]',
  });
  // #endregion

  // #region Checkout section
  public readonly StartCheckoutButton = () => this.derived({
    Desktop: '//*[@data-testid="ShoppingBagOverview-GridItem"]//*[@data-testid="proceed-to-checkout-pvh-button"]',
  });

  public readonly CheckoutWithPaypalButton = () => this.derived({
    Desktop: '//*[@data-testid="ShoppingBagOverview-GridItem"]//button[@data-testid="paypal-express-pvh-button"]',
  });

  public readonly MobileSecondaryCheckoutButton = () => this.derived({
    Mobile: '//*[@data-testid="ShoppingBagHeader-GridItem"]//*[@data-testid="listItem"]//following-sibling::*[@data-testid="proceed-to-checkout-pvh-button"]',
  });

  public readonly MobileSecondaryPaypalButton = () => this.derived({
    Mobile: '//*[@data-testid="ShoppingBagHeader-GridItem"]//*[@data-testid="PaypalExpress-component"]',
  });
  // #endregion

  // #region Overview section
  public readonly OverviewSection = () => this.derived({
    Desktop: '//div[@data-testid="common-basketOverviewView"]',
  });

  public readonly TotalPriceInfo = () => this.derived({
    Desktop: '//*[@data-testid="BasketOverview-GrandTotal-PriceText"]',
  });

  public readonly TotalPriceLabel = () => this.derived({
    Desktop: '//*[@data-testid="BasketOverview-TotalQtyText"]',
  });

  public readonly SubTotalPriceInfo = () => this.derived({
    Desktop: '//*[@data-testid="common-basketOverviewView"]//*[@data-testid="BasketOverview-SubTotal-PriceText"]',
  });

  public readonly SubTotalPriceLabel = () => this.derived({
    Desktop: '//*[@data-testid="common-basketOverviewView"]//*[@data-testid="BasketOverview-SubTotal-Text"]',
  });

  public readonly ShippingChargeAmount = () => this.derived({
    Desktop: '//*[@data-testid="BasketOverview-Shipping-PriceText"]',
  });

  public readonly ShippingChargeLabel = () => this.derived({
    Desktop: '//*[@data-testid="BasketOverview-DeliveryMethodText"]',
  });

  public readonly PromoCodeDiscountInfo = () => this.derived({
    Desktop: '//*[@data-testid="BasketOverview-Discount-PriceText"]',
  });

  public readonly PromoCodeDiscountInfoTotal = () => this.derived({
    Desktop: '//*[@data-testid="BasketOverview-Discount-PriceDisplay"]',
  });

  public readonly PromoCodeDiscountLabel = () => this.derived({
    Desktop: '//*[@data-testid="BasketOverview-DiscountLabel"]',
  });

  public readonly PromoCodeButton = () => this.derived({
    Desktop: '//*[@data-testid="add-promo-link"]',
  });

  public readonly PromoCodeRemoveButton = () => this.derived({
    Desktop: '//button[@data-testid="promocode-removeButton"]',
  });

  public readonly MobileTotalPriceInfo = () => this.derived({
    Mobile: '//*[@data-testid="ShoppingBagHeader-GridItem"]//*[@data-testid="BasketOverview-total-PriceText"]',
  });

  public readonly MobileTotalPriceLabel = () => this.derived({
    Mobile: '//*[@data-testid="ShoppingBagHeader-GridItem"]//*[@data-testid="BasketOverview-total-Text"]',
  });
  // #endregion

  // #region Promocode section
  public readonly PromoCodeField = () => this.derived({
    Desktop: '//input[@data-testid="promocode-apply-inputField"]',
  });

  public readonly PromoCodeApplyButton = () => this.derived({
    Desktop: '//button[@data-testid="promocode-apply-pvh-button"]',
  });

  public readonly PromoCodeErrorMsg = () => this.derived({
    Desktop: '//*[@data-testid="alert-error-promocode-apply"]',
  });

  public readonly PromoCodeErrorMsgNotEligible = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-promocode-noadjustment"]',
  });
  // #endregion

  // #region Payment method logo
  public readonly AcceptedPaymentMethods = () => this.derived({
    Desktop: '//div[@data-testid="accepted-paymentmethod-view"]/p',
  });

  public readonly PaymentMethodLogos = () => this.derived({
    Desktop: '//ul[@data-testid="payment-logos"]',
  });

  public readonly PayPalLogo = () => this.derived({
    Desktop: '//li[@data-testid="payment-logos-paypal"]',
  });

  public readonly VisaLogo = () => this.derived({
    Desktop: '//li[@data-testid="payment-logos-visa"]',
  });

  public readonly MastercardLogo = () => this.derived({
    Desktop: '//li[@data-testid="payment-logos-mc"]',
  });

  public readonly AmericanExpressLogo = () => this.derived({
    Desktop: '//li[@data-testid="payment-logos-amex"]',
  });

  public readonly PaypalTermsAndConditionCheckBox = () => this.derived({
    Desktop: '//*[@data-testid="checkout-terms-conditions-Checkbox-Component-icon"]',
  });

  public readonly PaypalTermsAndConditionCheckoutButton = () => this.derived({
    Desktop: '//*[@data-testid="paypal-express-modal-Modal-component"]//button[@data-testid="paypal-terms-portal-pvh-button"] | //*[@data-testid="paypal-express-modal-Modal-component"]//*[@data-testid="pvh-button"]',
  });
  // #endregion

  // #region item
  public readonly Item = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]`,
  });

  public readonly RemoveButton = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//button[@data-testid="deleteOrderItem-pvh-button"]`,
    Mobile: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid="basketItem-cross-icon-pvh-icon-button"]`,
  });

  public readonly RemoveItemModal = () => this.derived({
    Desktop: '//div[@data-testid="deleteOrderItemPopup-Modal-component"]',
  });

  public readonly RemoveConfirmButton = () => this.derived({
    Desktop: '//button[@data-testid="deleteOrderItemConfirm-pvh-button"]',
  });

  public readonly RemoveAddWishlistButton = () => this.derived({
    Desktop: '//button[@data-testid="deleteOrderItemAndAddToWishlist-pvh-button"]',
  });

  public readonly RemoveCancelButton = () => this.derived({
    Desktop: '//div[@data-testid="Modal-component-logo"]/following::button[contains(@aria-label, "close")]',
  });

  public readonly EditProductButton = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid="editOrderItem-pvh-button"]`,
  });

  public readonly LowOnStockMessage = (skuPartNumber?: string, text?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid="LowStock-StatusText" ${text ? `and contains(text(), "${text}")` : ''} ]`,
  });

  public readonly OnlyXItemsLeftMessage = (skuPartNumber?: string, text?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//span[contains(@class, "lowStock")${text ? ` and contains(text(), '${text}')` : ''}]`,
  });

  public readonly OutOfStockMessage = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//span[contains(@class, "outOfStock")]`,
  });

  public readonly ItemNameLink = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-qa="ShoppingBag-basketItem"${skuPartNumber ? ` and contains(@data-partnumber, "${skuPartNumber}")` : ''}]//a[contains(@class, "ProductItem__description")]`,
  });

  public readonly ItemImage = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='ShoppingBag-image']`,
  });

  public readonly ItemTitle = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='basketItem-title']`,
  });

  public readonly ItemTitleLink = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//div[contains(@class, "product-details__title")]//a`,
  });

  public readonly ItemAtrribute = (text?: string) => this.derived({
    Desktop: `//*[@data-testid="basketItem-attribute"]//span[${text ? `contains(text(), '${text.toLowerCase()}') or contains(text(), '${text}')` : ''}]`,
  });

  public readonly ItemAtrributeValue = (text?: string) => this.derived({
    Desktop: `//*[@data-testid="basketItem-attribute-value" and contains(text(), '${text.toLowerCase()}')]`,
  });

  public readonly ItemDetailsInfoByIndex = (index?: number) => this.derived({
    Desktop: `(//span[contains(@class,"BasketItem_attributesLabelText")])[${index || 1}]`,
  });

  public readonly ItemDetailsValueByIndex = (index?: number) => this.derived({
    Desktop: `(//*[@data-testid="basketItem-attribute-value"])[${index || 1}]`,
  });

  public readonly ItemLoader = () => this.derived({
    Desktop: '//*[@data-testid="button-inLoading-state"]',
  });

  public readonly ReservedBanner = () => this.derived({
    Desktop: '//div[@data-testid="item-not-reserved-BannerCard"]/span',
  });

  public readonly ProductLowOnStockText = () => this.derived({
    Desktop: '//div[@data-testid="pvh-IconWithText"]/span',
  });

  public readonly ProductOutOfStockText = () => this.derived({
    Desktop: '//div[@data-testid="OutOfStock-StatusText"]',
  });

  // When there is no was price
  public readonly ItemPrice = (skuPartNumber?: string, text?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//span[@data-testid='ProductList-PriceText' and contains(translate(text(),'\u00A0', ' '), "${text || ''}")]`,
  });

  public readonly ItemCurrentPrice = (skuPartNumber?: string, text?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//span[@data-testid='ProductList-PriceText' and contains(translate(text(),'\u00A0', ' '), "${text || ''}")]`,
  });

  public readonly ItemWasPrice = (skuPartNumber?: string, text?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//span[@data-testid='ProductList-WasPriceText' and contains(translate(text(),'\u00A0', ' '), "${text || ''}")]`,
  });

  public readonly ItemByIndex = (index: number) => this.derived({
    Desktop: `(//div[@data-testid="basketItem"])[${index || 1}]`,
  });
  // #endregion

  // #region Edit item
  public readonly EditSaveButton = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='editOrderSave-pvh-button']`,
  });

  public readonly EditCancelButton = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='editOrderCancel-pvh-button']`,
  });

  public readonly EditColourDropdownSelector = (skuPartNumber?: string, text?: string) => this.derived({
    Desktop: {
      dropdownSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='attr_colourInput-inputField']`,
      optionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='select-component-options-list']//li[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), "${text ? text.toLocaleLowerCase() : ''}")]`,
      selectedValueSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='attr_colourInput-inputField']`,
      selectEnableOptionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//div[@id='edit-colour']//div[contains(@class, 'Select__option') and (contains(@class, 'Select__option--is-selected') or not(contains(@class, "Select__option--is-disabled")))]`,
      selectDisabledOptionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//div[@id='edit-colour']//div[contains(@class, 'Select__option') and contains(@class, 'Select__option--is-disabled') and not(contains(@class, 'Select__option--is-selected'))]`,
    },
    Mobile: {
      dropdownSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid="attr_colour-native-select"]`,
      optionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='attr_colour-native-select']//option[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), "${text ? text.toLocaleLowerCase() : ''}")]`,
      selectedValueSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='attr_colourInput-inputField']`,
      selectEnableOptionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//div[@id='edit-colour']//div[contains(@class, 'Select__option') and (contains(@class, 'Select__option--is-selected') or not(contains(@class, "Select__option--is-disabled")))]`,
      selectDisabledOptionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//div[@id='edit-colour']//div[contains(@class, 'Select__option') and contains(@class, 'Select__option--is-disabled') and not(contains(@class, 'Select__option--is-selected'))]`,
    },
  });

  public readonly EditColourDropdown = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='attr_colourInput-inputField']`,
  });

  public readonly EditSizeDropdownSelector = (skuPartNumber?: string, text?: string) => this.derived({
    Desktop: {
      dropdownSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='attr_sizeInput-inputField']`,
      optionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='select-component-options-list']//li[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), "${text ? text.toLocaleLowerCase() : ''}")]`,
      selectedValueSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='attr_sizeInput-inputField']`,
      selectEnableOptionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='select-component-options-list']//li`,
      selectDisabledOptionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='select-component-options-list']//li[@disabled]`,
    },
    Mobile: {
      dropdownSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid="attr_size-native-select"]`,
      optionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid="attr_size-native-select"]//option[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), "${text ? text.toLocaleLowerCase() : ''}")]`,
      selectedValueSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid="attr_sizeInput-inputField"]`,
      selectEnableOptionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//div[@id='edit-colour']//div[contains(@class, 'Select__option') and (contains(@class, 'Select__option--is-selected') or not(contains(@class, "Select__option--is-disabled")))]`,
      selectDisabledOptionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//div[@id='edit-colour']//div[contains(@class, 'Select__option') and contains(@class, 'Select__option--is-disabled') and not(contains(@class, 'Select__option--is-selected'))]`,
    },
  });

  public readonly EditWidthDropdownSelector = (skuPartNumber?: string, text?: string) => this.derived({
    Desktop: {
      dropdownSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='attr_widthInput-inputField']`,
      optionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='select-component-options-list']/li[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), "${text ? text.toLocaleLowerCase() : ''}")]`,
      selectedValueSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='attr_widthInput-inputField']`,
      selectEnableOptionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='select-component-options-list']//li`,
      selectDisabledOptionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='select-component-options-list']//li[@disabled]`,
    },
    Mobile: {
      dropdownSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid="attr_size-native-select"]`,
      optionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid="attr_size-native-select"]//option[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), "${text ? text.toLocaleLowerCase() : ''}")]`,
      selectedValueSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid="attr_widthInput-inputField"]`,
      selectEnableOptionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//div[@id='edit-colour']//div[contains(@class, 'Select__option') and (contains(@class, 'Select__option--is-selected') or not(contains(@class, "Select__option--is-disabled")))]`,
      selectDisabledOptionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//div[@id='edit-colour']//div[contains(@class, 'Select__option') and contains(@class, 'Select__option--is-disabled') and not(contains(@class, 'Select__option--is-selected'))]`,
    },
  });

  public readonly EditSizeDropdown = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='attr_sizeInput-inputField']`,
  });

  public readonly EditQuantityDropdownSelector = (skuPartNumber?: string, text?: string) => this.derived({
    Desktop: {
      dropdownSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='attr_quantityInput-inputField']`,
      optionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='select-component-options-list']//li[contains(.,"${text || ''}")]`,
      selectedValueSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='attr_quantityInput-inputField']`,
      selectEnableOptionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='attr_quantityInput-inputField']`,
      selectDisabledOptionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='select-component-options-list']//div[contains(@class, 'Select__option') and contains(@class, 'Select__option--is-disabled') and not(contains(@class, 'Select__option--is-selected'))]`,
    },
    Mobile: {
      dropdownSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid="attr_quantity-native-select"]`,
      optionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid="attr_quantity-native-select"]//option[contains(.,"${text || ''}")]`,
      selectedValueSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='attr_quantityInput-inputField']`,
      selectEnableOptionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//div[@id='edit-colour']//div[contains(@class, 'Select__option') and (contains(@class, 'Select__option--is-selected') or not(contains(@class, "Select__option--is-disabled")))]`,
      selectDisabledOptionSelector: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//div[@id='edit-colour']//div[contains(@class, 'Select__option') and contains(@class, 'Select__option--is-disabled') and not(contains(@class, 'Select__option--is-selected'))]`,
    },
  });

  public readonly EditQuantityDropdown = (skuPartNumber?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='attr_quantityInput-inputField']`,
  });
  // #endregion

  // outOfStock
  public readonly OutOfStockErrorMessage = () => this.derived({
    Desktop: '//*[@data-testid="pvh-PageNotification-error"]',
  });

  public readonly NoStockMessage = (skuPartNumber?: string, text?: string) => this.derived({
    Desktop: `//div[@data-testid="basketItem"${skuPartNumber ? ` and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid='OutOfStock-StatusText' and contains(translate(text(),'\u00A0', ' '), "${text || ''}")]`,
  });
  // #endregion

  // Shopping bag USP
  public readonly ShoppingBagUSP = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="shoppingBag-Content-Shopping-Bag-USP"])${index ? `[${index}]` : ''}`,
  });
}
