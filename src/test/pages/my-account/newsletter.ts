import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class Newsletter extends Page {
  // #region Banner
  public readonly BannerTitle = () => this.derived({
    Desktop: '//div[@data-testid="NewsLetterFormLauncher-component"]//div[contains(@class, "news_letter_form_launcher_news_letter_form_launcher_title__L1pBq")]',
  });

  public readonly BannerInfo = () => this.derived({
    Desktop: '//h3[@data-testid="NewsletterSignUpForm-component-title" and contains(text(), "10%")]',
  });

  public readonly BannerEmailField = () => this.derived({
    Desktop: '#email-newsletter-sign-up-popup',
  });

  public readonly BannerMenCheckbox = () => this.derived({
    Desktop: '//div[@data-testid="newsletter-men-Checkbox-Component-icon"]',
  });

  public readonly BannerWomenCheckbox = () => this.derived({
    Desktop: '//div[@data-testid="newsletter-women-Checkbox-Component-icon"]',
  });

  public readonly BannerKidsCheckbox = () => this.derived({
    Desktop: '//div[@data-testid="newsletter-kids-Checkbox-Component-icon"]',
  });

  public readonly BannerTermsAndConditionsCheckbox = () => this.derived({
    Desktop: '//div[@data-testid="newsletter-terms-Checkbox-Component-icon"]',
  });

  public readonly PopupSubscribeButton = () => this.derived({
    Desktop: '//button[@type="submit" and @data-testid="newsletter-banner-form-submit-pvh-button"]',
  });

  public readonly BannerBenefitsList = (index: number) => this.derived({
    Desktop: `(//div[contains(@class, "MembershipBenefits_MembershipBenefitsList_")]//p)[${index}]`,
  });

  public readonly BannerImage = () => this.derived({
    Desktop: '//div[@data-testid="split-image-module"]',
  });

  public readonly BannerSignUpTitle = () => this.derived({
    Desktop: '//h3[@data-testid="NewsletterSignUpSuccess-component-title"]',
  });

  public readonly BannerSignUpInfo = () => this.derived({
    Desktop: '(//div[@data-testid="NewsletterSignUpSuccess-component"]//p)[1]',
  });
  // #endregion

  public readonly EmailError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-newsletter-form-email"]',
  });

  // #region Pop up
  public readonly PopUp = () => this.derived({
    Desktop: '//div[@data-testid="NewsletterPopup-component"]',
  });

  public readonly PopUpTitle = () => this.derived({
    Desktop: '//h3[@data-testid="minimize-typography-h3"]',
  });

  public readonly PopUpInfo = () => this.derived({
    Desktop: '//div[@data-testid="NewsletterPopup-component"]//h3[@data-testid="NewsletterSignUpForm-component-title"]',
  });

  public readonly PopUpEmailField = () => this.derived({
    Desktop: '#email-newsletter-sign-up-popup',
  });

  public readonly PopUpMenCheckbox = () => this.derived({
    Desktop: '#newsletter-sign-up-popup-mens',
  });

  public readonly PopUpWomenCheckbox = () => this.derived({
    Desktop: '//div[@data-testid="newsletter-women-Checkbox-Component-icon"]',
  });

  public readonly PopUpKidsCheckbox = () => this.derived({
    Desktop: '#newsletter-sign-up-popup-kids',
  });

  public readonly PopUpTermsAndConditionsCheckbox = () => this.derived({
    Desktop: '//div[@data-testid="newsletter-terms-Checkbox-Component-icon"]',
  });

  public readonly PopUpSubscribeButton = () => this.derived({
    Desktop: '//div[@data-testid="NewsletterPopup-component"]//button[@data-testid="newsletter-banner-form-submit-pvh-button"]',
  });

  public readonly PopUpBenefitsList = (index: number) => this.derived({
    Desktop: `(//div[@data-testid="NewsletterPopup-component"]//p[@data-testid="typography-p"])[${index}]`,
  });

  public readonly PopUpSignedUpTitle = () => this.derived({
    Desktop: '//h3[@data-testid="minimize-typography-h3"]',
  });

  public readonly PopUpSignedUpInfo = () => this.derived({
    Desktop: '//h3[@data-testid="NewsletterSignUpSuccess-component-title"]',
  });

  public readonly PopUpCloseButton = () => this.derived({
    Desktop: '//button[@data-testid="Newsletter-close-pvh-icon-button"]',
  });

  public readonly PopUpExpandTermsAndConditions = () => this.derived({
    Desktop: '//div[@data-testid="sign-up-terms-component"]//*[@data-testid="icon-utility-chevron-down-svg"]',
  });

  public readonly PopUpTermsAndConditionsLink = () => this.derived({
    Desktop: '//div[@data-testid="typography-div"]//a[1]',
  });

  public readonly PopUpPrivacyLink = () => this.derived({
    Desktop: '//div[@data-testid="typography-div"]//a[2]',
  });

  public readonly NewsletterSignUpPopup = () => this.derived({
    Desktop: '//div[@data-testid="NewsletterPopup-component"]',
  });

  public readonly BannerSubscribeButton = () => this.derived({
    Desktop: '//button[@data-testid="signUpLauncher-pvh-button"]',
  });

  public readonly PopupDOBBenefit = () => this.derived({
    Desktop: '//div[contains(@class, "newsletter_dob_form_form__radL7")]//p',
  });

  public readonly PopupBenefitDDInput = () => this.derived({
    Desktop: '//input[@data-testid="day-inputField"]',
  });

  public readonly PopupBenefitMMInput = () => this.derived({
    Desktop: '//input[@data-testid="month-inputField"]',
  });

  public readonly PopupBenefitYYInput = () => this.derived({
    Desktop: '//input[@data-testid="year-inputField"]',
  });

  public readonly PopupSignUpSuccessMessage = () => this.derived({
    Desktop: '//div[@id="toast-portal"]//span[contains(@class, "IconWithText_text")]',
  });

  public readonly OnlyTenPecentDiscount = () => this.derived({
    Desktop: '//button[@type="button" and @data-testid="newsletter-banner-form-submit-pvh-button"]',
  });

  public readonly ErrorDOBInput = () => this.derived({
    Desktop: '//div[@data-testid="pvh-InputField" and contains(@class, "InputField_isError")]',
  });
  // #endregion
}
