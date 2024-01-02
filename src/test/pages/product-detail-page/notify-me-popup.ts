import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class NotifyMePopup extends Page {
  public readonly Title = (TitleName: string) => this.derived({
    Desktop: `//div[contains(@class, "NotifyMePopup_NotifyMeModal")]//h3[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜÉÈÊÀÁÂÒÓÔÙÚÛÇÅÏÕÑŒŻ', 'abcdefghijklmnopqrstuvwxyzäöüéèêàáâòóôùúûçåïõñœż'), "${TitleName.toLowerCase()}")]`,
  });

  public readonly EmailInput = (Email?: string) => this.derived({
    Desktop: `//input[@data-testid="notifyme-form-email-inputField" ${Email ? `and @value="${Email}"` : ''}]`,
  });

  public readonly NotifyMeButton = (NotifyMeText?: string) => this.derived({
    Desktop: `//button[@data-testid="notfiy-me-form-submit-pvh-button" ${NotifyMeText ? `and div/span[contains(text(), "${NotifyMeText}")]` : ''}]`,
  });

  public readonly NotifyMeSuccessMessage = () => this.derived({
    Desktop: '//div[contains(@class, "NotifyMePopup_Success")]',
  });

  public readonly EmailErrorMessage = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-notifyme-form-email"]',
  });

  public readonly OosPopupSize = (Size: string) => this.derived({
    Desktop: `(//div/span[@data-testid="basketItem-attribute-value" and contains(text(), "${Size}")])`,
  });

  public readonly OosPopupColor = (Color: string) => this.derived({
    Desktop: `(//div/span[@data-testid="basketItem-attribute-value" and contains(text(), "${Color}")])`,
  });

  public readonly OosPopupProductName = () => this.derived({
    Desktop: '//div[@data-testid="NotifyMePopup-component"]//span[contains(@class, "BasketItem_basketTitle")]',
  });

  public readonly OosPopupProductPrice = () => this.derived({
    Desktop: '//div[@data-testid="NotifyMePopup-component"]//span[@data-testid="PriceText"]',
  });

  public readonly OosPopupSoldoutLabel = () => this.derived({
    Desktop: '//div[@data-testid="NotifyMePopup-component"]//div[contains(@class, "BasketItem_SoldOut")]/span',
  });

  public readonly ContinueShoppingButton = () => this.derived({
    Desktop: '//button[@data-testid="notfiy-me-continue-shopping-pvh-button"]',
  });

  public readonly ConsentText = (ConsentText: string) => this.derived({
    Desktop: `//div[@data-testid="NotifyMePopup-consent-me" and p[contains(text(), '${ConsentText.split('<')[0]}')]]`,
  });
}
