import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class Pdp extends Page {
  public isLoaded = async (): Promise<boolean> => (
    ((await browser.getNetworkRequestNumber('fetch', 'FHUserInfoView')) >= 1 || (await browser.getNetworkRequestNumber('fetch', 'userinfo')) >= 1)
    && ((await browser.getNetworkRequestNumber('fetch', 'FHMiniBagView')) === 1 || (await browser.getNetworkRequestNumber('fetch', 'minibag')) === 1));

  // #region Product Info
  public readonly ProductName = (text?: string) => this.derived({
    Desktop: `//h1[@data-testid="ProductHeader-ProductName-typography-h1" ${text ? `and contains(text(), "${text.trim()}")` : ''}]`,
  });

  public readonly FromCurrentPrice = (price: string) => this.derived({
    Desktop: `//span[contains(@data-testid, "labelPrefix")]/../span[@data-testid="ProductHeaderPrice-PriceText" and contains(text(), '${price.replace(/\s/g, '\u00A0')}')]`,
  });

  public readonly CurrentPrice = (price?: string) => this.derived({
    Desktop: `//span[@data-testid="ProductHeaderPrice-PriceText" ${price ? `and contains(text(), '${price.replace(/\s/g, '\u00A0')}')` : ''}]`,
  });

  public readonly FromWasPrice = (price: string) => this.derived({
    Desktop: `//span[contains(@data-testid, "labelPrefix")]/../span[@data-testid="ProductHeaderPrice-WasPriceText" and contains(text(), '${price.replace(/\s/g, '\u00A0')}')]`,
  });

  public readonly WasPrice = (price: string) => this.derived({
    Desktop: `//span[@data-testid="ProductHeaderPrice-WasPriceText" and contains(text(), '${price.replace(/\s/g, '\u00A0')}')]`,
  });

  public readonly VatInfo = () => this.derived({
    Desktop: '//span[contains(@class,"ProductHeader_VATDisplay")]',
  });

  public readonly PriorPriceMessage = (text: string) => this.derived({
    Desktop: `//div[contains(@class,"ProductHeader_priorPrice") and contains(text(), "${text.split(':')[0]}")]`,
  });

  public readonly PricePrefixFrom = () => this.derived({
    Desktop: '[data-testid="ProductHeaderPrice-labelPrefix"]',
  });

  // End region

  public readonly Content = () => this.derived({
    Desktop: '//div[@data-testid="pdp-main"]',
  });

  // Accordion region
  public readonly ExpandedProductDetailsSection = () => this.derived({
    Desktop: '//div[@data-testid="description-accordion"]/button[@id="description-accordion" and @aria-expanded="true"]',
  });

  public readonly ClosedProductDetailsSection = () => this.derived({
    Desktop: '//div[@data-testid="description-accordion"]/button[@id="description-accordion" and @aria-expanded="false"]',
  });

  public readonly ProductDetailsButton = () => this.derived({
    Desktop: '//button[@id="description-accordion"]/span',
  });

  public readonly ExpandedProductShippingAndReturnsSection = () => this.derived({
    Desktop: '//div[@data-testid="shippingAndReturns-accordion"]/button[@id="shippingAndReturns-accordion" and @aria-expanded="true"]',
  });

  public readonly ClosedProductShippingAndReturnsSection = () => this.derived({
    Desktop: '//div[@data-testid="shippingAndReturns-accordion"]/button[@id="shippingAndReturns-accordion" and @aria-expanded="false"]',
  });

  public readonly ProductShippingAndReturnsButton = () => this.derived({
    Desktop: '//button[@id="shippingAndReturns-accordion"]/span',
  });

  public readonly SustainableStyleSection = () => this.derived({
    Desktop: '//div[contains(@class, "ProductAccordions_sustainable")]',
  });

  public readonly ExpandedSustainableDetailsSection = () => this.derived({
    Desktop: '//div[contains(@class, "ProductAccordions_sustainable")]/button[@aria-expanded="true"]',
  });

  public readonly SustainableIcon = () => this.derived({
    Desktop: '//div[contains(@class, "ProductAccordions_sustainable")]//div[@id="sustainable"]',
  });

  public readonly SustainableType = (text: string) => this.derived({
    Desktop: `//div[@id="sustainable"]//div[@data-testid="pvh-IconWithText" and span[contains(text(), '${text.trim()}')]]`,
  });

  public readonly BenefitsSection = () => this.derived({
    Desktop: '//div[@data-testid="benefits-accordion" and button[@id="benefits-accordion"]]',
  });

  public readonly ExpandedBenefitsSection = () => this.derived({
    Desktop: '//div[@data-testid="benefits-accordion"]/button[@id="benefits-accordion" and @aria-expanded="true"]',
  });

  public readonly ClosedBenefitsSection = () => this.derived({
    Desktop: '//div[@data-testid="benefits-accordion"]/button[@id="benefits-accordion" and @aria-expanded="false"]',
  });

  public readonly BenefitsIcon = () => this.derived({
    Desktop: '//div[@data-testid="benefits-accordion"]//div[@id="benefits"]',
  });

  public readonly BenefitsType = () => this.derived({
    Desktop: '//div[@id="benefits"]//div[@data-testid="pvh-IconWithText"]/span',
  });
  // End region

  // Color Selector region
  public readonly ColorSwatches = () => this.derived({
    Desktop: '//ul[contains(@class, "ProductColourSelector_ColourList")]/li',
  });

  public readonly ColorSwatchButton = (index: string) => this.derived({
    Desktop: `(//ul[contains(@class, "ProductColourSelector_ColourList")]/li/button)[${index}]`,
  });

  public readonly ColorLabel = (colourName?: string) => this.derived({
    Desktop: `//span[@data-testid="pdpColourName-typography-span" ${colourName ? `and contains(., "${colourName.toLocaleLowerCase()}")` : ''}]`,
  });

  public readonly FirstColour = (colourName: string) => this.derived({
    Desktop: `//div[span[contains(.,"${colourName.toLocaleLowerCase()}")]]/following-sibling::ul/li[1]`,
  });
  // End region

  // Product images region
  public readonly ProductImages = (index?: string) => this.derived({
    Desktop: `(//div[@data-testid="ProductImages-component"]//div[@data-testid="CarouselItem"])${index ? `[${index}]` : ''}`,
  });

  public readonly ProductVideoElement = () => this.derived({
    Desktop: '[data-testid="productVideoElement"]',
  });

  public readonly VideoPlayButton = () => this.derived({
    Desktop: '//button[contains(@class,"ProductVideo_PlayButton")]',
  });

  public readonly ProductImagesWithAltText = () => this.derived({
    Desktop: '//div[@data-testid="CarouselItem" and not(contains(@class, "Recommendations"))]//img[@data-testid="prod-mainImage_img" and string-length(@alt)!=0 and normalize-space(@alt)]',
  });

  public readonly ProductImageCarouselBullets = () => this.derived({
    Desktop: '//div[contains(@class, "ProductImages_ImageBullet")]',
  });

  public readonly ProductZoomElement = (index?: string) => this.derived({
    Desktop: `(//div[@data-testid="ProductImages-component"]//div[@data-testid="CarouselItem"])${index ? `[${index}]` : ''}//div[@data-testid="Zoom-component"]`,
    Mobile: `//div[@data-testid="Mobile Zoom-Modal-component"]//div[@data-testid="Zoomed Image"]${index ? `[${index}]` : ''}`,
  });

  public readonly ProductZoomCloseButton = () => this.derived({
    Mobile: '//div[@data-testid="Mobile Zoom-Modal-component"]//button[contains(@class,"Modal_CloseButton")]',
  });

  public readonly MobileImageThumbNails = () => this.derived({
    Mobile: '//div[@data-testid="ProductImagesThumbnail_component"]',
  });

  public readonly MobileImageThumbNailImage = (index: string) => this.derived({
    Mobile: `(//div[@data-testid="ImageThumbnail_component"]/img)[${index}]`,
  });

  public readonly MobileZoomThumbNails = () => this.derived({
    Mobile: '//div[@data-testid="Thumbnails"]',
  });

  public readonly MobileZoomThumbSlider = (index: string) => this.derived({
    Mobile: `(//div[@data-testid="Thumbnails"]/button)[${index}]`,
  });
  // End region

  // Size selector region
  public readonly OneSizeButton = () => this.derived({
    Desktop: '//button[@data-testid="button-size-One Size"] | //button[@data-testid="button-size-OS"] ',
  });


  public readonly SingleSizeButton = (sizeName?: string) => this.derived({
    Desktop: `//div[contains(@class, 'ProductSizeSelector_SizeList')]//button[not(contains(@class, "ProductSize_IsOos")) ${sizeName ? `and span/span[text()='${sizeName.trim()}']` : ''}]`,
  });

  public readonly SingleSizeButtonByIndex = (index: string) => this.derived({
    Desktop: `(//div[contains(@class, 'ProductSizeSelector_SizeList')]//button[not(contains(@class, "ProductSize_IsOos"))])[${index ? `${index}` : ''}]`,
  });

  public readonly WidthSizeButton = (sizeName?: string) => this.derived({
    Desktop: `//div[contains(@class, 'ProductSizeSelector_SizeList')]//button[contains(@data-testid, "button-width") and not(contains(@class, "ProductSize_IsOos")) ${sizeName ? `and span/span[text()='${sizeName.trim().replace('EU', '').replace('W', '')}']` : ''}]`,
  });

  public readonly WidthSizeButtonByIndex = (index: string) => this.derived({
    Desktop: `(//div[contains(@class, 'ProductSizeSelector_SizeList')]//button[contains(@data-testid, "button-width") and not(contains(@class, "ProductSize_IsOos"))])[${index ? `${index}` : ''}]`,
  });

  public readonly LengthSizeButton = (sizeName?: string) => this.derived({
    Desktop: `//div[contains(@class, 'ProductSizeSelector_SizeList')]//button[contains(@data-testid, "button-length") and not(contains(@class, "ProductSize_IsOos")) ${sizeName ? `and span/span[text()='${sizeName.trim().replace('EU', '')}']` : ''}]`,
  });

  public readonly LengthSizeButtonByIndex = (index: string) => this.derived({
    Desktop: `(//div[contains(@class, 'ProductSizeSelector_SizeList')]//button[contains(@data-testid, "button-length") and not(contains(@class, "ProductSize_IsOos"))])[${index ? `${index}` : ''}]`,
  });

  public readonly SizeLabel = (text: string) => this.derived({
    Desktop: `//div[contains(@class, "ProductSizeSelector_DisplayText") and contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), "${text.toLowerCase()}")]`,
  });

  public readonly SizeSoldOutButton = (sizeName?: string) => this.derived({
    Desktop: `//button[contains(@class, "ProductSize_IsOos") ${sizeName ? `and span/span[text()='${sizeName}']` : ''}]`,
  });

  public readonly SoldOutButton = (index?: string) => this.derived({
    Desktop: `(//button[contains(@class, "ProductSize_IsOos")])[${index}]`,
  });

  public readonly AllSizes = () => this.derived({
    Desktop: '//div[contains(@class, "ProductSizeSelector_SizeList")]//button[contains(@data-testid, "button-size")]/span/span',
  });

  public readonly SelectedSize = () => this.derived({
    Desktop: '//button[contains(@class, "ProductSize_SizeSelected")]',
  });

  public readonly WidthSizeSoldOutButton = (sizeName?: string) => this.derived({
    Desktop: `//div[contains(@class, 'ProductSizeSelector_SizeList')]//button[contains(@data-testid, "button-width") and contains(@class, "ProductSize_IsOos") ${sizeName ? `and span/span[text()='${sizeName.trim().replace('EU', '')}']` : ''}]`,
  });

  public readonly LengthSizeSoldOutButton = (sizeName?: string) => this.derived({
    Desktop: `//div[contains(@class, 'ProductSizeSelector_SizeList')]//button[contains(@data-testid, "button-length") and contains(@class, "ProductSize_IsOos") ${sizeName ? `and span/span[text()='${sizeName.trim().replace('EU', '')}']` : ''}]`,
  });

  public readonly SizeSelectorButtons = (index?: string) => this.derived({
    Desktop: `(//div[@data-testid="ProductSize-component"]/button)${index ? `[${index}]` : ''}`,
  });

  public readonly SelectSizeErrorMessage = (text?: string) => this.derived({
    Desktop: `//div[@data-testid="selectSizeError" and contains(text(), "${text}")]`,
  });

  public readonly AvailableSize = () => this.derived({
    Desktop: '//button[contains(@class,"ProductSize_SizeButton")]',
  });
  // End region

  // CTAs region
  public readonly AddToBagButton = (AddToBagText?: string) => this.derived({
    Desktop: `//button[@data-testid="pdpActionButton-addToBag-pvh-button" ${AddToBagText ? `and div/span[contains(text(), "${AddToBagText}")]` : ''}]`,
  });

  public readonly ItemAddedButton = (ItemAddedText?: string) => this.derived({
    Desktop: `//button[@data-testid="pdpActionButton-itemAdded-pvh-button" ${ItemAddedText ? `and div/span[contains(text(), "${ItemAddedText}")]` : ''}]`,
  });

  public readonly AddedtoBagPopup = () => this.derived({
    Desktop: '//div[@data-testid="added-to-bag-popup"]',
  });

  public readonly AddedtoBagPopupClose = () => this.derived({
    Desktop: '//*[contains(@class, "AddedToBagPopup_AddedToBagPopupCloseBtn")]',
  });

  public readonly DisabledAddToBagButton = () => this.derived({
    Desktop: '//button[@data-testid="pdpActionButton-addToBag-pvh-button" and @disabled]',
  });

  public readonly NotifyMeButton = (NotifyMeText?: string) => this.derived({
    Desktop: `//button[@data-testid="pdpActionButton-notifyMe-pvh-button" ${NotifyMeText ? `and div/span[contains(text(), "${NotifyMeText}")]` : ''}]`,
  });

  public readonly OutOfStockButton = (OutOfStockText?: string) => this.derived({
    Desktop: `//button[@data-testid="pdpActionButton-soldOut-pvh-button" ${OutOfStockText ? `and div/span[contains(text(), "${OutOfStockText}")]` : ''}]`,
  });

  public readonly NewsletterCheckboxContent = (CheckBoxText) => this.derived({
    Desktop: `//div[@data-testid="Checkbox-Component-content"]//p[contains(text(), "${CheckBoxText}")]`,
  });

  public readonly NewsletterCheckboxInput = () => this.derived({
    Desktop: '//input[@data-testid="Checkbox-Component-input"]',
  });

  public readonly NewsletterCheckbox = () => this.derived({
    Desktop: '//div[@data-testid="Checkbox-Component-icon"]',
  });

  public readonly CheckoutButton = () => this.derived({
    Desktop: '//button[@data-testid="pdpProceedToCheckout-pvh-button"]',
  });

  public readonly StickyAddToBagPanel = () => this.derived({
    Desktop: '//div[@data-testid="stickyAddToBag"]',
  });

  public readonly StickyAddToBagButton = (AddToBagText?: string) => this.derived({
    Desktop: `//button[@data-testid="stickyAddToBagButton-addToBag-pvh-button"  ${AddToBagText ? `and div/span[contains(text(), "${AddToBagText}")]` : ''}]`,
  });

  public readonly StickyNotifyMeButton = (NotifyMeText?: string) => this.derived({
    Desktop: `//button[@data-testid="stickyAddToBagButton-notifyMe-pvh-button" ${NotifyMeText ? `and div/span[contains(text(), "${NotifyMeText}")]` : ''}]`,
  });

  public readonly SizeGuideButton = () => this.derived({
    Desktop: '//div[@data-testid="pdp-size-guide"]/a | //div[@data-testid="pdp-size-guide"]/button',
  });

  public readonly SizeGuidePageTitle = (text: string) => this.derived({
    Desktop: `//div[@class="THPageHeader__title" and contains(text(), ${text})] | //h1[@class="pageTitle" and contains(text(), ${text})] | //section[contains(@class, "SizeGuideTable_TableConfigHeader") and span[contains(text(), ${text})]]`,
  });

  public readonly SizeGuideTableModal = () => this.derived({
    Desktop: '//div[contains(@class, "SizeGuideTable")]',
  });

  public readonly HowToMeasureMyselfLink = () => this.derived({
    Desktop: '//button[contains(@class, "HowTo_HowToLinkText")]',
  });

  public readonly HowToContentSection = () => this.derived({
    Desktop: 'section[data-testid="HowToContent-Section"]',
  });

  public readonly HowToContentSectionImage = () => this.derived({
    Desktop: '//section[@data-testid="HowToContent-Section"]//img',
  });

  public readonly HowToContentSectionItems = () => this.derived({
    Desktop: '//ul[contains(@class, "HowTo_HowToContentItems")]',
  });

  public readonly SizeGuideSizeSelectorDropdown = (index: number) => this.derived({
    Mobile: {
      dropdownSelector: '//select[@data-testid="pdp-size-native-select"]',
      optionSelector: `//select[@data-testid="pdp-size-native-select"]//option[${index}]`,
    },
  });

  public readonly SizeGuideAddToBagButton = () => this.derived({
    Desktop: '//button[@data-testid="SingleSelectForm-pvh-button"]',
  });

  public readonly NotifyMePopup = () => this.derived({
    Desktop: '//div[@data-testid="pvh-drawer-Modal-component"]',
    Mobile: '//div[@data-testid="Modal-component"]',
  });

  public readonly SoldOutMessage = () => this.derived({
    Desktop: '//div[contains(@class, "ProductSizeSelector_soldOut")]/span',
  });

  // Wishlist region
  public readonly WishListIcon = () => this.derived({
    Desktop: '//div[@data-testid="ProductActions-component"]/div[@data-testid="WishListAdornment-component"]/button',
    Mobile: '//div[@data-testid="ProductImages-component"]/div[@data-testid="WishListAdornment-component"]/button',
  });

  public readonly ActiveWishListIcon = () => this.derived({
    Desktop: '//div[@data-testid="ProductActions-component"]/div[@data-testid="WishListAdornment-component" and button//*[@data-testid="icon-utility-wishlist-filled-svg"]]',
    Mobile: '//div[@data-testid="ProductImages-component"]/div[@data-testid="WishListAdornment-component"]/button//*[@data-testid="icon-utility-wishlist-filled-svg"]',
  });
  // End region

  // Warning messages region
  public readonly LowStockMessage = () => this.derived({
    Desktop: '//div[contains(@class,"ProductSizeSelector_lowStockMessage")] | //div[contains(@class, "StockUrgencyMessage")]/span',
  });

  public readonly LowStockDot = () => this.derived({
    Desktop: '//div[contains(@class,"ProductSizeSelector_lowStockMessage")]//*[name()="svg"]',
  });

  public readonly NoStockMessage = () => this.derived({
    Desktop: '//div[contains(@class,"ProductSizeSelector_soldOut")]',
  });

  public readonly NoStockDot = () => this.derived({
    Desktop: '//div[contains(@class,"ProductSizeSelector_soldOut")]//*[name()="svg"]',
  });

  // Labels region
  public readonly MarkDownPercentageLabel = () => this.derived({
    Desktop: '//div[contains(@class,"ProductLabel_discount")]',
  });

  public readonly ProductLabel = (LabelText?: string) => this.derived({
    Desktop: `//div[@data-testid="ProductImages-component"]//div[@data-testid="ProductLabel-component" ${LabelText ? `and span[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜÉÈÊÀÁÂÒÓÔÙÚÛÇÅÏÕÑŒ', 'abcdefghijklmnopqrstuvwxyzäöüéèêàáâòóôùúûçåïõñœ'), "${LabelText.toLocaleLowerCase()}")]` : ''}]`,
  });
  // End region

  // Members Only
  public readonly SignUpToBuyButton = (SignUpToBuy?: string) => this.derived({
    Desktop: `//button[@data-testid="pdpActionButton-membersOnlySignUpToBuy-pvh-button" ${SignUpToBuy ? `and div/span[contains(text(), "${SignUpToBuy}")]` : ''}]`,
  });

  public readonly SignInToBuyButton = (SignInToBuy?: string) => this.derived({
    Desktop: `//button[@data-testid="pdpActionButton-membersOnlySignInToBuy-pvh-button" ${SignInToBuy ? `and div/span[contains(text(), "${SignInToBuy}")]` : ''}]`,
  });

  public readonly SignInModal = () => this.derived({
    Desktop: '//div[@data-testid="pvh-auth-drawer-Modal-component"]',
  });

  public readonly ProductMembersOnlyHeader = (membersOnlyHeaderText: string) => this.derived({
    Desktop: `//div[@data-testid="ProductHeader-component" ${membersOnlyHeaderText ? `and p/span[contains(text(), "${membersOnlyHeaderText}")]` : ''}]`,
  });

  public readonly NewsletterPopUpEmailInputField = () => this.derived({
    Desktop: '//div[@data-testid="NewsletterPopup-component"]//input[@data-testid="newsletter-form-email-inputField"]',
  });

  public readonly TermsAndConditionsCheckbox = () => this.derived({
    Desktop: 'div[data-testid="newsletter-terms-Checkbox-Component-icon"]',
  });

  public readonly NewsletterPopUpSubmitButton = () => this.derived({
    Desktop: '//div[@data-testid="NewsletterPopup-component"]//button[@data-testid="newsletter-banner-form-submit-pvh-button"]',
  });

  public readonly NewsletterPopUpCloseButton = () => this.derived({
    Desktop: 'button[data-testid="Newsletter-close-pvh-icon-button"]',
  });

  public readonly EmailField = () => this.derived({
    Desktop: 'input[data-testid="email-inputField"]',
  });

  public readonly PasswordField = () => this.derived({
    Desktop: 'input[data-testid="password-inputField"]',
  });

  public readonly SubmitButton = () => this.derived({
    Desktop: 'button[data-testid="login-form-submit-pvh-button"]',
  });

  public readonly signInModalCloseButton = () => this.derived({
    Desktop: '//button[contains(@class, "Modal_CloseButton")]',
  });

  public readonly ProductImagePadlock = () => this.derived({
    Desktop: 'button[data-testid="lock-pvh-icon-button"]',
  });

  public readonly ErrorPage = () => this.derived({
    Desktop: 'div[data-testid="ErrorPage-component"]',
  });
  // End region

  // Content spot
  public readonly ContentSpotPlusSizeLink = () => this.derived({
    Desktop: '//div[@data-testid="pdp-curve-spot"]//a',
  });

  public readonly ShippingBannerSpot = () => this.derived({
    Desktop: 'div[data-testid="Content-Shipping-Banner"]',
  });

  public readonly ShippingBannerSpotLink = () => this.derived({
    Desktop: '//div[@data-testid="Content-Shipping-Banner"]//a',
  });

  public readonly UspContentSpot = () => this.derived({
    Desktop: '//div[contains(@class, "content_shopping_bag_usp_uspSpot")]',
  });

  public readonly UspContentSpotLink = () => this.derived({
    Desktop: '//div[contains(@class, "content_shopping_bag_usp_uspSpot")]//a',
  });

  public readonly PromoCodeContentSpot = () => this.derived({
    Desktop: 'div[data-testid="pdp-promo-code-spot"]',
  });

  public readonly PromoCode = () => this.derived({
    Desktop: 'button[data-testid="PromoCode-code"]',
  });

  public readonly PromoCodeCopyButton = (text: string) => this.derived({
    Desktop: `//button[@data-testid="PromoCode-copy-pvh-button" and div[contains(text(), "${text}")]]`,
  });

  public readonly CopySuccessNotification = (text: string) => this.derived({
    Desktop: `//div[@data-testid="pvh-PageNotification-success"]//span[contains(text(), "${text.split(':')[0]}")]`,
  });

  public readonly FhCampaign = () => this.derived({
    Desktop: 'div[data-testid="pdp-campaign-spot"]',
  });

  public readonly FhCampaignLink = () => this.derived({
    Desktop: '//div[@data-testid="pdp-campaign-spot"]//a',
  });
  // End region
}
