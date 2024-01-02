import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class NewsletterSubscription extends Page {
  public readonly PreferencesInfo = () => this.derived({
    Desktop: '(//p[@data-testid="page-subtitle"])',
  });

  // #region Sign up
  public readonly SignUpTitle = () => this.derived({
    Desktop: '(//div[@data-testid="NewsLetterPreferencesSignup-component"]/h4)',
  });

  public readonly SignUpInfo = () => this.derived({
    Desktop: '(//div[@data-testid="NewsLetterPreferencesSignup-component"]//p[@data-testid="typography-p"])',
  });

  public readonly NewsletterMenCheckbox = () => this.derived({
    Desktop: '//input[@id="Mens"]',
  });

  public readonly NewsletterWomenCheckbox = () => this.derived({
    Desktop: '//input[@id="Ladies"]',
  });

  public readonly NewsletterKidsCheckbox = () => this.derived({
    Desktop: '//input[@id="Kids"]',
  });

  public readonly NewsLetterTCCheckbox = () => this.derived({
    Desktop: '//input[@id="newsLetterTermsAgreement"]',
  });

  public readonly NewsletterSignUpButton = () => this.derived({
    Desktop: '//div[@data-testid="newsLetterSignUp-card"]//div[@class="Button_buttonContent__mX4nT"]',
  });
  // #endregion

  // #region Unsubscribe
  public readonly NewsetterUnsubscribeInfo = () => this.derived({
    Desktop: '//p[@class="NewsletterUnsubscribe_Copy__gYNeS"]',
  });

  public readonly NewsLetterUnsubscribeButton = () => this.derived({
    Desktop: '//div[@data-testid="newsLetterUnSubscribe-card"]//button',
  });

  public readonly NewsLetterUnsubscribeSuccessMessage = () => this.derived({
    Desktop: '//span[@class="PageNotification_content__zOw_9"]',
  });
  // #endregion

  public readonly NewsLetterSavePreferences = () => this.derived({
    Desktop: '//div[@data-testid="NewsLetterPreferencesSignup-component"]//button',
  });

  public readonly NewsletterTCCheckboxError = () => this.derived({
    Desktop: '//*[@id="news-letter-subscribe"]/div[2][contains(@class, "Checkbox_isError")]',
  });

  public readonly NewsletterTermsAndConditionLink = (href: string) => this.derived({
    Desktop: `//div[@data-testid="Checkbox-Component-content"]//a[@href="${href}"]`,
  });

  public readonly CheckoutNewsletterSignupCheckbox = () => this.derived({
    Desktop: '//div[@data-testid="CollapsibleCheckboxContent-Checkbox-Component-icon"]',
  });
}
