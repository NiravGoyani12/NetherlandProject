import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class CookieNotice extends Page {
  public readonly MainScreen = () => this.derived({
    Desktop: '//*[@data-testid="CookieNotice-main-wrapper"] | //*[@data-testid="CookieNotice-main-wrapper-feature"]',
  });

  public readonly SettingsButton = () => this.derived({
    Desktop: '//*[@data-testid="CookieNotice-main-wrapper"]//*[@data-testid="pvh-button"]',
  });

  public readonly ManageCookiePreferencesButton = () => this.derived({
    Desktop: '//*[@data-testid="CookieNotice-main-wrapper"]//*[@data-testid="pvh-button"]',
  });

  public readonly IAgreeButton = () => this.derived({
    Desktop: '//div[contains(@class,"CookieNotice")]//button[@data-testid="accept-cookies-pvh-button"]',
  });

  public readonly RejectAllNonEssentialButton = () => this.derived({
    Desktop: '//div[contains(@class,"CookieNotice")]//button[@data-testid="reject-cookies-pvh-button"]',
  });

  public readonly FunctionalCheckbox = () => this.derived({
    Desktop: '//input[@id="cookie-functional" and @type="checkbox"]',
  });

  public readonly AnalyticalCheckbox = () => this.derived({
    Desktop: '//input[@data-testid="cookie-analytical-Checkbox-Component-input"]',
  });

  public readonly SocialMediaAndAdvertisingCheckbox = () => this.derived({
    Desktop: '//input[@data-testid="cookie-social-Checkbox-Component-input"]',
  });

  public readonly DoneButton = () => this.derived({
    Desktop: '//button[contains(@class,"CookieNotice") and @data-testid="pvh-button"]',
  });

  public readonly CookieNoticeLink = () => this.derived({
    Desktop: '//div[contains(@class,"CookieNotice")]//a[1]',
  });

  public readonly PrivacyNoticeLink = () => this.derived({
    Desktop: '//div[contains(@class,"CookieNotice")]//a[2]',
  });

  public readonly CookieListLink = () => this.derived({
    Desktop: '//div[@id="contentWrapper"]//a[3]',
  });
}
