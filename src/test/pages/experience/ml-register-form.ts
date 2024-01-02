import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class SpaSignInForm extends Page {
  public readonly MembershipLogo = () => this.derived({
    Desktop: '//*[@data-testid="authentication-modal-membership-logo"] | //div[@data-testid="Modal-component-ml-logo"] | //*[@data-testid="membership-hub-logo-svg"]',
  });

  public readonly CloseButton = () => this.derived({
    Desktop: '//button[@data-testid="modal-close-btn"] | //button[contains(@class, "Modal_CloseButton")] | //button[@data-testid="close-pvh-button"]',
  });

  public readonly Email = () => this.derived({
    Desktop: '//input[@id="email"] | //input[@id="email-register-form"]',
  });

  public readonly BirthDay = () => this.derived({
    Desktop: '//input[@id="birthDate"] | //input[@id="day-register-form"]',
  });

  public readonly BirthMonth = () => this.derived({
    Desktop: '//input[@id="birthMonth"] | //input[@id="month-register-form"]',
  });

  public readonly BirthYear = () => this.derived({
    Desktop: '//input[@id="birthYear"] | //input[@id="year-register-form"]',
  });

  public readonly Gender = (index: number) => this.derived({
    Desktop: {
      dropdownSelector: '//select[@id="gender"] | //input[@data-testid="genderInput-inputField"]',
      optionSelector: `//select[@id="gender"]//option[${index}] | //ul[@data-testid="select-component-options-list"]//li[${index}]`,
    },
    Mobile: {
      dropdownSelector: '//select[@id="gender"] | //div[@data-testid="gender-select-component"]',
      optionSelector: `//select[@data-testid="gender-native-select"]//option[${index}] | //ul[@data-testid="select-component-options-list"]//li[${index}]`,
    },
  });

  public readonly NewsletterCheckbox = () => this.derived({
    Desktop: '//label[@data-testid="checkbox-label"] | //div[@data-testid="newsletter-Checkbox-Component-icon"]',
  });

  public readonly BecomeMemberButton = () => this.derived({
    Desktop: '//button[@data-testid="become-member-button"] | //button[@data-testid="register-form-submit-pvh-button"]',
  });

  public readonly MembershipSignUpSuccessTitle = () => this.derived({
    Desktop: '//h3[@data-testid="typography-h3"] | //h5[@data-testid="modal-heading"]',
  });

  public readonly MembeshipSignUpSuccessMessage = () => this.derived({
    Desktop: '//div[@data-testid="pvh-AuthPanel"]//p[@data-testid="typography-p"] | //p[contains(@class, "authentication-success")]',
  });

  public readonly EmailError = () => this.derived({
    Desktop: '//p[contains(@class,"error-text")] | //div [@data-testid="alert-error"]',
  });

  public readonly DiscountText = () => this.derived({
    Desktop: '//p[contains(@class,"membership-form__discount_text")] | //p[contains(@class,"membership-form__discount_text")] | //div[@data-testid="newsletter-Checkbox-Component-content"]//p',
  });

  public readonly DOBError = () => this.derived({
    Desktop: '//div [@data-testid="alert-error"]',
  });
}
