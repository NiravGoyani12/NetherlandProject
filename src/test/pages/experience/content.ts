/* eslint-disable max-len */
import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class Content extends Page {
  // #region Generic Template :
  public readonly TemplateCTA = (templateName?: string, href?: string) => this.derived({
    Desktop: `//div[contains(@data-testid,${templateName || ''})]//a[contains(@href,"${href || ''}")]`,
  });

  public readonly TemplateImage = (templateName?: string) => this.derived({
    Desktop: `//div[contains(@data-testid,${templateName || ''})]//img`,
  });

  public readonly TemplateVideo = (templateName?: string) => this.derived({
    Desktop: `//div[contains(@data-testid,${templateName || ''})]//video[contains(@src,".mp4")]`,
  });

  public readonly TemplateImageByIndex = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,${templateName || ''})]//picture)${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateCTAByIndex = (templateName?: string, href?: string, index?: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,${templateName || ''})]//a[contains(@href,"${href || ''}")])${index ? `[${index}]` : ''}`,
    Mobile: `(//div[contains(@data-testid,${templateName || ''})]//a[contains(@href,"${href || ''}")])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateHrefByIndex = (templateName?: string, href?: string, index?: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,${templateName || ''})]//a[contains(@href,"${href || ''}")])${index ? `[${index}]` : ''}`,
    Mobile: `(//div[contains(@data-testid,${templateName || ''})]//a[contains(@href,"${href || ''}")])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateBody = (templateName?: string) => this.derived({
    Desktop: `//div[contains(@data-testid,${templateName || ''})]//div[contains(@data-testid,"body")]`,
  });

  public readonly TemplateBlock = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//*[contains(@data-testid,${templateName || ''})])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateQuerySelectorBlock = (templateName?: string) => this.derived({
    Desktop: `[data-testid=${templateName || ''}] img`,
  });

  public readonly TemplateButton = (templateName?: string, buttonType?: string, index?: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,${templateName || ''})]//*[contains(@data-testid,${buttonType || ''})])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateButtonLink = (templateName?: string, href?: string, index?: number) => this.derived({
    Desktop: `(//*[contains(@data-testid,${templateName || ''})]//a[contains(@href,"${href || ''}")])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateBodyByIndex = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,${templateName || ''})]//div[contains(@data-testid,"body")])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateTitle = (templateName?: string) => this.derived({
    Desktop: `//div[contains(@data-testid,${templateName || ''})]//div[contains(@data-testid,"title")]`,
  });

  public readonly TemplateTitleByIndex = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//*[contains(@data-testid,${templateName || ''})]//*[contains(@data-testid,"typography-h")])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateHeaderByIndex = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,${templateName || ''})]//h2)${index ? `[${index}]` : ''}`,
  });

  public readonly GlpLink = (templateName?: string, href?: string) => this.derived({
    Desktop: `//li[contains(@data-testid,${templateName || ''})]//a[@href="${href || ''}"]`,
  });

  public readonly MobileGlpLink = (templateName?: string, href?: string, linklevel?: string) => this.derived({
    Mobile: `//li[contains(@data-testid,${templateName || ''})]//a[@href="${href || ''}"][@data-testid="${linklevel || ''}"]`,
  });

  public readonly TemplatePictureLink = (templateName?: string) => this.derived({
    Desktop: `//div[contains(@data-testid,${templateName || ''})]//a[contains(@class,"link")]`,
  });

  public readonly TemplatePictureLinkByIndex = (templateName?: string, href?: string, index?: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,${templateName || ''})]//a[contains(@href,"${href || ''}")])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateSubTitleByIndex = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//*[contains(@data-testid,${templateName || ''})]//p[contains(@data-testid,"typography-p")])${index ? `[${index}]` : ''}`,
  });

  public readonly Module4ImageSliderNext = () => this.derived({
    Desktop: '//div[@class="swiper-slide swiper-slide-next"]',
  });

  public readonly Module4ImageSliderActive = () => this.derived({
    Desktop: '//div[@class="swiper-slide swiper-slide-active"]',
  });

  public readonly Module4SliderImageByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@class="swiper-wrapper"]//img)${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateCounterDays = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,${templateName || ''})]//div[contains(@data-testid,"CountdownTimer-days")])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateCounterDaysText = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,${templateName || ''})]//div[contains(@data-testid,"CountdownTimer-days")]/following-sibling::div[1])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateCounterHours = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,${templateName || ''})]//div[contains(@data-testid,"CountdownTimer-hours")])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateCounterHoursText = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,${templateName || ''})]//div[contains(@data-testid,"CountdownTimer-hours")]/following-sibling::div[1])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateCounterMinutes = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,${templateName || ''})]//div[contains(@data-testid,"CountdownTimer-minutes")])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateCounterMinutesText = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,${templateName || ''})]//div[contains(@data-testid,"CountdownTimer-minutes")]/following-sibling::div[1])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateCounterSeconds = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,${templateName || ''})]//div[contains(@data-testid,"CountdownTimer-seconds")])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateCounterSecondsText = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//div[contains(@data-testid,${templateName || ''})]//div[contains(@data-testid,"CountdownTimer-seconds")]/following-sibling::div[1])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateElement = (templateName?: string, element?: string, index?: number) => this.derived({
    Desktop: `(//*[@data-testid=${templateName || ''}]//*[@data-testid=${element || ''}])${index ? `[${index}]` : ''}`,
  });

  public readonly PromoCodeCopyButton = () => this.derived({
    Desktop: '//div[@data-testid="PromoCode-component"]//button[@data-testid="PromoCode-copy-pvh-button"]',
  });

  public readonly CopySuccessNotification = (text: string) => this.derived({
    Desktop: `//div[@data-testid="pvh-PageNotification-success"]//span[contains(text(), ${text || ''})]`,
  });

  public readonly TemplateProductTitleByIndex = (templateName?: string, element?: string, index?: number) => this.derived({
    Desktop: `(//*[contains(@data-testid,${templateName || ''})]//*[contains(@class,${element || ''})])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateCarouselArrowButton = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//*[contains(@data-testid,${templateName || ''})]//nav[contains(@data-testid,"carousel-arrow-nav")]//button[contains(@data-testid,"pvh-icon-button")])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateCarouselItemByLink = (templateName?: string, href?: string, index?: number) => this.derived({
    Desktop: `(//*[contains(@data-testid,${templateName || ''})]//div[contains(@data-testid,"CarouselItem")]//a[contains(@href,"${href || ''}")])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateCategoryCardNameByIndex = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//*[contains(@data-testid,${templateName || ''})]//*[contains(@class,"CategoryCards_categoryCardName__IkNoD")])${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateCategoryCardlinkslistItemByIndex = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//*[contains(@data-testid,${templateName || ''})]//*[contains(@data-testid,"pvh-List")]//li)${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateSplitNewsLetterDownArrowByIndex = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//*[contains(@data-testid,${templateName || ''})]//*[contains(@data-testid,"icon-utility-chevron-down-svg")]//*)${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateEventDetailsHeadingByIndex = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//*[contains(@data-testid,${templateName || ''})]//h4)${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateEventDetailsTextByIndex = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//*[contains(@data-testid,${templateName || ''})]//p)${index ? `[${index}]` : ''}`,
  });

  public readonly TemplateRecommendationsProductTitleIndex = (templateName?: string, index?: number) => this.derived({
    Desktop: `(//*[contains(@data-testid,${templateName || ''})]//h3[contains(@class,"Recommendations_title__iKmZ0")])${index ? `[${index}]` : ''}`,
  });

  public readonly SplitContainerEmailInputField = () => this.derived({
    Desktop: '(//div[contains(@data-testid,"split-container")]//input[contains(@data-testid,"email-inputField")])[2]',
  });

  public readonly ShopTheLookTemplateCarouselItemElement = (element?: string, index?: number) => this.derived({
    Desktop: `(//*[@data-testid="ShopTheLook-component"]//*[@data-testid="Carousel-component"]//*[@data-testid=${element || ''}])${index ? `[${index}]` : ''}`,
  });

  public readonly ShopTheLookWishlistButtonByIndex = (element1?: string, element2?: string, index?: number) => this.derived({
    Desktop: `(//*[@data-testid="ShopTheLook-component"]//*[@data-testid=${element1 || ''}]//*[@data-testid=${element2 || ''}])${index ? `[${index}]` : ''}`,
  });

  public readonly ShopTheLookTemplateCarouselItemImgElement = (element?: string, index?: number) => this.derived({
    Desktop: `(//*[@data-testid="ShopTheLook-component"]//*[@data-testid="Carousel-component"]//*[@data-testid="CarouselItem"]//img)${index ? `[${index}]` : ''}`,
  });
  // #endregion

  // #region SignUp
  public readonly SignUpComponent = () => this.derived({
    Desktop: '(//form[@class="CKSignupForm__formWrapper"])[1]',
  });

  public readonly SignUpImage = () => this.derived({
    Desktop: '(//div[@data-testid="CKSignupForm"]//img)[1]',
  });

  public readonly SignUpEmailInputByIndex = (index?: number) => this.derived({
    Desktop: `(//input[@name="emailSignUp"])${index ? `[${index}]` : ''}`,
  });

  public readonly SignUpFirstNameInput = () => this.derived({
    Desktop: '(//input[@name="firstName"])[1]',
  });

  public readonly SignUpCheckBoxNotMandatoryOptions = () => this.derived({
    Desktop: '//label[@for="-5"]',
  });

  public readonly SignUpCheckBoxMandatoryOptions = () => this.derived({
    Desktop: '//label[@for="termsAgreement-5"]',
  });

  public readonly SignUpCheckBoxMandatory_OptionsByIndex = (index?: number) => this.derived({
    Desktop: `(//label[contains(@for,"termsAgreement")])${index ? `[${index}]` : ''}`,
  });

  public readonly SignUpSideDrawerCheckBoxMandatory_Options = () => this.derived({
    Desktop: '//div[@data-testid="drawer-container"]//input[@data-qa="sign-up-form-checkbox-termsAgreement"]',
  });

  public readonly SignUpSideDrawerButton = () => this.derived({
    Desktop: '//div[@data-testid="drawer-container"]//button',
  });

  public readonly SignUpSideDrawerCtaTrigger = () => this.derived({
    Desktop: '//div[@data-testid="module-6-refresh-cta-container"]//button[@data-testid="module-6-refresh-cta-sign-up-trigger"]',
  });

  public readonly SignUpSideDrawer = () => this.derived({
    Desktop: '//div[contains(@data-testid,"sign-up-form-drawer")]',
  });

  public readonly SignUpSideDrawerScrollByIndex = (index?: number) => this.derived({
    Desktop: `(//form[@data-testid="sign-up-form"]//p)${index ? `[${index}]` : ''}`,
  });

  public readonly SignUpTermsDescription = () => this.derived({
    Desktop: '(//div[@class="CKSignupForm__formWrapper-termsDescription"])[1]',
  });

  public readonly SignUpButton = () => this.derived({
    Desktop: '(//form[@class="CKSignupForm__formWrapper"]//button[contains(@class,"submitSignUp")])[1]',
  });

  public readonly SignUpThankYou = () => this.derived({
    Desktop: '(//div[@data-testid="CKSignupForm"]//div[contains(@class,"CKSignupForm__thankYou")]//p)[1]',
  });

  public readonly RefreshSignUpSubmitButtonByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="signup-form-refresh"]//button)${index ? `[${index}]` : ''}`,
  });

  public readonly RefreshSignUpRightAlingedImage = () => this.derived({
    Desktop: '//div[@class="IZ6mkjlS _2CCtXXqp"]//img',
  });

  public readonly RefreshSideDrawerSignUpSubmitButton = () => this.derived({
    Desktop: '//div[@data-testid="drawer-container"]//button[@data-testid="sign-up-form-submit-btn"]',
  });

  public readonly RefreshSignUpInputError = () => this.derived({
    Desktop: '//div[@data-testid="signup-form-refresh"]//div[contains(@class,"form-input__error")]',
  });

  public readonly RefreshSignUpMandatoryCheckBoxError = () => this.derived({
    Desktop: '//div[@data-testid="signup-form-refresh"]//input[contains(@data-qa,"ck-Checkbox")]',
  });

  public readonly RefreshSignUpNonMandatoryCheckBoxError = () => this.derived({
    Desktop: '//div[@data-testid="signup-form-refresh"]//div[contains(@class,"ck-Checkbox ck-Checkbox--error")]',
  });

  public readonly RefreshSignUpDescriptionsByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="signup-form-refresh"]//p)${index ? `[${index}]` : ''}`,
  });

  public readonly NewsLetterSubscribeButton = (index?: number) => this.derived({
    Desktop: `(//button[@data-testid="pdpActionButton-membersOnlySignUpToBuy-pvh-button"])${index ? `[${index}]` : ''}`,
  });

  public readonly NewsLetterPopUp = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="NewsletterPopup-component"])${index ? `[${index}]` : ''}`,
  });

  public readonly NewsLetterEmailInput = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="NewsletterSignUpForm-component"]//input[@data-testid="newsletter-form-email-inputField"])${index ? `[${index}]` : ''}`,
  });

  public readonly NewsLetterSubmitButton = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="NewsletterSignUpForm-component"]//button[@data-testid="newsletter-banner-form-submit-pvh-button"])${index ? `[${index}]` : ''}`,
  });

  public readonly NewsLetterCheckBox = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="NewsletterSignUpForm-component"]//*[@data-testid="newsletter-terms-Checkbox-Component-icon"])${index ? `[${index}]` : ''}`,
  });

  public readonly NewsLetterSignUpSuccess = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="NewsletterPopup-component"]//*[@data-testid="NewsletterSignUpSuccess-component"])${index ? `[${index}]` : ''}`,
  });

  public readonly NewsLetterPopUpCloseButton = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="NewsletterPopup-component"]//button[@data-testid="Newsletter-close-pvh-icon-button"])${index ? `[${index}]` : ''}`,
  });

  public readonly NewsLetterSubscribeLockIcon = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="ProductHeader-component"]//*[@data-testid="icon-utility-lock-svg"])${index ? `[${index}]` : ''}`,
  });

  public readonly NewsLetterSubscribeUnlockIcon = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="ProductHeader-component"]//*[@data-testid="icon-utility-unlocked-svg"])${index ? `[${index}]` : ''}`,
  });
  // #endregion

  // #region Accordion Template
  public readonly AccordionTitleByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="ckaccordion"]//div[@class="CKAccordion__items-list--title"])${index ? `[${index}]` : ''}`,
  });

  public readonly AccordionTitleActiveByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="ckaccordion"]//div[@class="CKAccordion__items-list active "])${index ? `[${index}]` : ''}`,
  });

  public readonly AccordionTitleHideByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="ckaccordion"]//div[@class="CKAccordion__items-list  hide"])${index ? `[${index}]` : ''}`,
  });

  public readonly AccordionTitleImageByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="ckaccordion"]//div[@data-testid="lazy-image-container"])${index ? `[${index}]` : ''}`,
  });

  public readonly AccordionTitleBodyByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="ckaccordion"]//div[@class="CKAccordion__items-list--body"])${index ? `[${index}]` : ''}`,
  });
  // #endregion

  // #region PLPBanner Template

  public readonly PlpPageHeader = () => this.derived({
    Desktop: '//h1[@class="plpHeading__header-title"]',
  });

  public readonly PlpBannerBlock = () => this.derived({
    Desktop: '//div[@class="CKPLPBanner"]',
  });

  public readonly PlpBannerImage = () => this.derived({
    Desktop: '//div[@class="CKPLPBanner"]//div[@data-testid="lazy-image-container"]//img',
  });

  public readonly PlpBannerWrapperByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@class="CKPLPBanner"]//div[contains(@class,"CKPLPBanner")])${index ? `[${index}]` : ''}`,
  });

  public readonly PlpBannerTitle = () => this.derived({
    Desktop: '//div[@class="CKPLPBanner"]//div[contains(@class,"CKPLPBanner__title")]',
  });

  public readonly PlpBannerBody = () => this.derived({
    Desktop: '//div[@class="CKPLPBanner"]//div[contains(@class,"CKPLPBanner__body")]',
  });

  public readonly SignInFormElement = (element?: string) => this.derived({
    Desktop: `(//div[@data-testid="pvh-AuthPanel"]//*[@data-testid=${element || ''}])`,
  });
  // #endregion

  // #region Size Fit Template
  public readonly SizeFitBlock = () => this.derived({
    Desktop: '//div[@class="CKSizeFit"]',
  });

  public readonly SizeFitTitle = () => this.derived({
    Desktop: '//div[@class="CKSizeFit__info-titles"]',
  });

  public readonly SizeFitImage = () => this.derived({
    Desktop: '//div[@class="CKSizeFit"]//img',
  });

  public readonly SizeFitHeader = () => this.derived({
    Desktop: '//div[@class="CKSizeFit__data"]//header',
  });

  public readonly SizeFitUnitSwitcherButton = (index?: number) => this.derived({
    Desktop: `(//section[@class="SizeGuideTable"]//ul//button)${index ? `[${index}]` : ''}`,
  });

  public readonly SizeFitTableLastColumRoWVal = () => this.derived({
    Desktop: '(//section[@data-testid="CKColumnTableSection"]//tbody//td)[1]',
  });
  // #endregion

  // #region Icon modules Template
  public readonly IconModulesImageByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="lazy-image-container"]//img)${index ? `[${index}]` : ''}`,
  });

  public readonly IconModulesTeasers = (index?: number) => this.derived({
    Desktop: `(//div[@id="CareTips"]//div[contains(@class,"Icons2Columns__teaser")])${index ? `[${index}]` : ''}`,
  });

  public readonly IconModulesTitles = (index?: number) => this.derived({
    Desktop: `(//div[contains(@class,"IconsOneLine__teaser-title")])${index ? `[${index}]` : ''}`,
  });

  public readonly IconModulesAlignLeftTeaser = (index?: number) => this.derived({
    Desktop: `(//div[contains(@class,"align--left")])${index ? `[${index}]` : ''}`,
  });
  // #endregion

  // #region Quic Shop
  public readonly CurrentImage = () => this.derived({
    Desktop: '//img[contains(@data-testid,"QuickShopRefresh-main-image")] [contains(@alt,"QuickSsop-Image-2")]',
  });

  public readonly ChangeImage = () => this.derived({
    Desktop: '//img[contains(@data-testid,"QuickShopRefresh-main-image")] [contains(@alt,"QuickShop-Image")]',
  });

  public readonly ChangeHrefLink = (href?: string) => this.derived({
    Desktop: `//div[contains(@data-testid,"QuickShopRefresh")]//a[contains(@href,"${href || ''}")]`,
  });
  // #endregion

  // #region Module 7 refresh video
  public readonly Module7FullVideoBlockStatus = () => this.derived({
    Desktop: '//div[@data-testid="module7-video-teaser-video"]//video[contains(@src,".mp4")][contains(@style,"display: block;")]',
  });
  // #endregion

  // #CK divider
  public readonly TeaserBackGroundDiver = (teaserName?: string, style?: string) => this.derived({
    Desktop: `//div[contains(@data-testid,${teaserName || ''})]//hr[contains(@style,${style || ''})]`,
  });

  public readonly TeaserMuteButtonByIndex = (teaserName?: string) => this.derived({
    Desktop: `//div[contains(@data-testid,${teaserName || ''})]//button[contains(@data-testid,"audio-mute-button")]`,
  });

  public readonly TeaserUnMuteButtonByIndex = (teaserName?: string) => this.derived({
    Desktop: `//div[contains(@data-testid,${teaserName || ''})]//button[contains(@data-testid,"audio-unmute-button")]`,
  });
  // #endregion

  // #CK BlackFriday Questions
  public readonly BlackFridayFaqsQuestions = () => this.derived({
    Desktop: '(//div[@data-testid="module-faq"]//ul)',
  });

  public readonly BlackFridayFaqsQuestionByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="module-faq"]//li)${index ? `[${index}]` : ''}`,
  });

  public readonly BlackFridayFaqsAnswerByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="module-faq"]//div[contains(@data-testid,"answer-inner")])${index ? `[${index}]` : ''}`,
  });
  // #endregion

  //  # Mega Menu 1st level Active check
  public readonly MegaMenuWomenActive = () => this.derived({
    Desktop: '(//ul[@data-testid="mega-menu-first-level"]//li[contains(@class,"women --active")])',
  });

  public readonly MegaMenuMenActive = () => this.derived({
    Desktop: '(//ul[@data-testid="mega-menu-first-level"]//li[contains(@class,"men --active")])',
  });

  public readonly MegaMenuKidsActive = () => this.derived({
    Desktop: '(//ul[@data-testid="mega-menu-first-level"]//li[contains(@class,"kids --active")])',
  });

  public readonly StickyNaviagtionBarActiveByTemplate = (teaserName?: string) => this.derived({
    Desktop: `//div[contains(@data-testid,${teaserName || ''})][contains(@class,"---active")]`,
  });

  public readonly MegaMenuActive = () => this.derived({
    Desktop: '(//ul[@data-testid="pvh-List"]//li[contains(@class,"MegaMenu_FirstLevelMenuItem__1aFOD MegaMenu_Selected__KADDX MegaMenu_Active__TMJk1")])',
  });
  // #endregion

  //  # GLP Sales templates
  public readonly GlpSaleTeaserContentByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="glp-sale"])${index ? `[${index}]` : ''}`,
  });

  public readonly GlpSaleTitlesByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="glp-sale"]//div[contains(@class,"GLPSale__teaser--flexible-content")]//div[contains(@class,"title")])${index ? `[${index}]` : ''}`,
    Mobile: `(//div[@data-testid="glp-sale"]//div[contains(@class,"GLPSale__teaser--mobile")]//div[contains(@class,"title")])${index ? `[${index}]` : ''}`,
  });

  public readonly GlpSaleTeaserLabels = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="glp-sale"]//span[contains(@class,"GLPSale__teaser-label")])${index ? `[${index}]` : ''}`,
  });
  // #endregion

  // #GLP Product list templates
  public readonly GlpProductlistTeaserContent = () => this.derived({
    Desktop: '//div[@class="ProductList"]//div[@class="ProductList__wrapper"]',
    Mobile: '//div[@class="ProductList"]//div[@class="ProductList__products"]',
  });

  public readonly GlpProductListImageByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@class="ProductList"]//img)${index ? `[${index}]` : ''}`,
  });

  public readonly GlpProductListTeaserPriceLabelByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@class="ProductList"]//div[@class="ProductList__product-price"])${index ? `[${index}]` : ''}`,
  });

  public readonly GlpProductListTeaserTitle = () => this.derived({
    Desktop: '//div[@class="ProductList"]//div[@class="ProductList__title"]',
  });

  public readonly GlpProductListTeaserNameByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@class="ProductList"]//div[@class="ProductList__product-name"])${index ? `[${index}]` : ''}`,
  });

  public readonly GlpProductListTeaserPaginationText = () => this.derived({
    Desktop: '(//div[@class="ProductList"]//div[@class="swiper-pagination swiper-pagination-custom swiper-pagination-horizontal"])',
  });

  public readonly GlpProductListTeaserPaginationNext = () => this.derived({
    Desktop: '(//div[@class="ProductList"]//div[@class="swiper-button-next"])',
  });

  public readonly GlpProductListTeaserPaginationPrev = () => this.derived({
    Desktop: '(//div[@class="ProductList"]//div[@class="swiper-button-prev"])',
  });

  public readonly GlpProductListLinkByIndexAndHref = (index?: number, href?: string) => this.derived({
    Desktop: `(//div[@class="ProductList__product-image-wrapper"]//a[@data-testid="product-list-link-${index || ''}"][contains(@href,"${href || ''}")])`,
  });
  // #endregion

  // #Side bar
  public readonly SideBar = () => this.derived({
    Desktop: '//div[@data-testid="Left-GridItem"]//*[@data-testid="side-nav"]',
  });

  public readonly SideBarTitle = () => this.derived({
    Desktop: '//div[@data-testid="Left-GridItem"]//*[@data-testid="side-nav"]//h3[@data-testid="typography-h3"]',
  });

  public readonly SideBarMenuList = () => this.derived({
    Desktop: '//div[@data-testid="Left-GridItem"]//*[@data-testid="side-nav"]//ul[@data-testid="pvh-List"]',
  });

  public readonly SideBarMenuListItem = () => this.derived({
    Desktop: '//div[@data-testid="Left-GridItem"]//*[@data-testid="side-nav"]//ul[@data-testid="pvh-List"]//li',
  });

  public readonly SideBarSizeGuideTH = () => this.derived({
    Desktop: '//div[@data-testid="THMenuLinks"]//section[@class="THMenuLinks__Section"]',
  });

  public readonly SideBarTitleSizeGuideTH = () => this.derived({
    Desktop: '//div[@data-testid="THMenuLinks"]//h3[@class="THMenuLinks__title"]',
  });

  public readonly SideBarMenuListSizeGuideTH = () => this.derived({
    Desktop: '//div[@data-testid="THMenuLinks"]//ul[@class="THMenuLinks__Menu"]',
  });

  public readonly SideBarMenuListItemSizeGuideTH = () => this.derived({
    Desktop: '//div[@data-testid="THMenuLinks"]//ul[@class="THMenuLinks__Menu"]//li',
  });

  public readonly SideBarSizeGuideCK = () => this.derived({
    Desktop: '//section[@class="sidebar"]',
  });

  public readonly SideBarTitleSizeGuideCK = () => this.derived({
    Desktop: '//section[@class="sidebar"]//h3[@class="sidebar__title"]',
  });

  public readonly SideBarMenuListSizeGuideCK = () => this.derived({
    Desktop: '//section[@class="sidebar"]//nav[@class="sidebar__container"]',
  });

  public readonly SideBarMenuListItemSizeGuideCK = () => this.derived({
    Desktop: '//section[@class="sidebar"]//nav[@class="sidebar__container"]//li',
  });
  // #endregion

  // #Live Selling
  public readonly LivesellingIframePlayer = () => this.derived({
    Desktop: '//iframe[@data-test-id="iframePlayer"]',
  });

  public readonly LivesellingClosePlayedButton = () => this.derived({
    Desktop: '//button[@class="close-player-btn"]',
  });

  public readonly LivesellingVideoRecordedIcon = () => this.derived({
    Desktop: '//div[@data-test-id="videoRecordedIcon"]',
  });

  public readonly LivesellingVideoPauseButton = () => this.derived({
    Desktop: '//button[@data-test-id="pauseButton"]',
  });

  public readonly LivesellingVideoMenuButton = () => this.derived({
    Desktop: '//button[@data-test-id="menuButton"]',
  });

  public readonly LivesellingVideoLikeButton = () => this.derived({
    Desktop: '//div[@data-test-id="likeButton"]',
  });
  // #endregion

  // #Accordion
  public readonly AccordionTitle = () => this.derived({
    Desktop: '//h1[@data-testid="typography-h1"]',
  });

  public readonly AccordionSubTitle = () => this.derived({
    Desktop: '//p[@data-testid="typography-p"]',
  });

  public readonly AccordianElement = (templateName?: string, element?: string, index?: number) => this.derived({
    Desktop: `(//*[@data-testid=${templateName || ''}]//*[@data-testid=${element || ''}])${index ? `[${index}]` : ''}`,
  });

  public readonly AccordionTextByIndex = (index?: number) => this.derived({
    Desktop: `(//span[contains(@class,"Accordion_Title__zT0hw accordion-title")])${index ? `[${index}]` : ''}`,
  });

  public readonly AccordionContentByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="html-content-component"])${index ? `[${index}]` : ''}`,
  });

  public readonly AccordionImageByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="html-content-component"])${index ? `[${index}]` : ''}`,
  });

  public readonly AccordionHyperlinkByHref = (href?: string) => this.derived({
    Desktop: `(//div[@data-testid="html-content-component"]//a[contains(@href,"${href || ''}")])`,
  });
  // #endregion

  // #Retail
  public readonly RetailModuleMapLinkByIndex = (href?: string, index?: number) => this.derived({
    Desktop: `(//div[@data-testid="RetailModule-component"]//a[contains(@href,"${href || ''}")])${index ? `[${index}]` : ''}`,
  });
  // #endregion

  // #Promo Code
  public readonly PromoCodePlacement = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="pdp-promo-code-spot"])${index ? `[${index}]` : ''}`,
  });

  public readonly PromoCodeTitle = () => this.derived({
    Desktop: '(//div[@data-testid="pdp-promo-code-spot"]//h4)',
  });

  public readonly PromoCodeSubTitle = () => this.derived({
    Desktop: '(//div[@data-testid="pdp-promo-code-spot"]//p)',
  });

  public readonly PromoCodeButton = () => this.derived({
    Desktop: '(//div[@data-testid="pdp-promo-code-spot"]//button[@data-testid="PromoCode-code"])',
  });

  public readonly PromoCodeCopy = () => this.derived({
    Desktop: '(//div[@data-testid="pdp-promo-code-spot"]//button[@data-testid="PromoCode-copy-pvh-button"])',
  });
  // #endregion

  // #Brand Logo
  public readonly BrandLogo = () => this.derived({
    Desktop: '(//a[@data-testid="brand-logo"])',
  });

  public readonly BrandLogoLink = (href?: string) => this.derived({
    Desktop: `//a[@data-testid="brand-logo"][contains(@href,"${href || ''}")]`,
  });
  // #endregion
}
