import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class RegisterPopUp extends Page {
  public readonly RegisterFormButton = () => this.derived({
    Desktop: '//button[@data-testid="register-pvh-button"]',
  });

  public readonly EmailField = () => this.derived({
    Desktop: '#email-register-form',
  });

  public readonly PasswordField = () => this.derived({
    Desktop: '#password-register-form',
  });

  public readonly RepeatPasswordField = () => this.derived({
    Desktop: '#passwordConfirmation-register-form',
  });

  public readonly DayField = () => this.derived({
    Desktop: '#day-register-form',
  });

  public readonly MonthField = () => this.derived({
    Desktop: '#month-register-form',
  });

  public readonly YearField = () => this.derived({
    Desktop: '#year-register-form',
  });

  public readonly TermsAndConditionsCheckbox = () => this.derived({
    Desktop: '//div[@data-testid="terms-Checkbox-Component-icon"] | //div[@data-testid="newsletter-Checkbox-Component-icon"]',
    Mobile: '//div[@data-testid="terms-Checkbox-Component-icon"] | //div[@data-testid="newsletter-Checkbox-Component-icon"]',
  });

  public readonly PasswordRequirementsList = (index: number) => this.derived({
    Desktop: `(//div[@data-testid="pvh-PasswordHelp"]//ul[@data-testid="pvh-List"]//li)[${index}]`,
  });

  public readonly NewsletterCheckbox = () => this.derived({
    Desktop: '//div[@data-testid="newsletter-terms-Checkbox-Component-icon"]',
  });

  public readonly RegisterButton = () => this.derived({
    Desktop: '//button[@data-testid="register-form-submit-pvh-button"]',
  });

  public readonly NewsletterNoButton = () => this.derived({
    Desktop: '//button[@data-testid="newsletter-banner-form-submit-pvh-button"][2]',
  });

  public readonly NewsletterYesButton = () => this.derived({
    Desktop: '//button[@data-testid="newsletter-banner-form-submit-pvh-button"][1]',
  });

  public readonly EmailError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-email"]',
  });

  public readonly PasswordErrorList = (index: number) => this.derived({
    Desktop: `(//div[@data-testid="pvh-PasswordHelp"]//ul[@data-testid="pvh-List"]/li)[${index}]`,
  });

  public readonly RepeatPasswordError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-password-confirm"]',
  });

  public readonly DateError = () => this.derived({
    Desktop: '//div[@class="InputGroup_inputFields__EGy0M"]/..//div[@data-testid="alert-error"]',
  });

  public readonly RegisterationError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error"]',
  });

  public readonly DOBError = () => this.derived({
    Desktop: '//div [@data-testid="alert-error"]',
  });

  public readonly CheckYourInboxMessage = () => this.derived({
    Desktop: '//div[@data-testid="pvh-AuthPanel"]//h3[@data-testid="typography-h3"]',
  });

  public readonly CustomerServiceLink = () => this.derived({
    Desktop: '//div[@data-testid="pvh-AuthPanel"]//a[contains(@href,"faqs")]',
  });
}
