import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class GiftCardsPage extends Page {
  public readonly BackgroundImage = () => this.derived({
    Desktop: '//div[@data-testid="giftCardImage"]//img',
  });

  public readonly GiftCardName = () => this.derived({
    Desktop: 'h1[data-testid="ProductHeader-ProductName-typography-h1"]',
  });

  public readonly FromProductPrice = () => this.derived({
    Desktop: '//span[contains(@data-testid, "labelPrefix")]/../span[@data-testid="ProductHeaderPrice-PriceText"]',
  });

  public readonly ProductPrice = () => this.derived({
    Desktop: 'span[data-testid="ProductHeaderPrice-PriceText"]',
  });

  public readonly VatInfo = () => this.derived({
    Desktop: '//span[contains(@class,"ProductHeader_VATDisplay")]',
  });

  public readonly DetailsAccordion = () => this.derived({
    Desktop: 'div[data-testid="Details-accordion"]',
  });

  public readonly DetailsAccordionButton = () => this.derived({
    Desktop: '//div[@data-testid="Details-accordion"]//button',
  });

  public readonly WhereToRedeemAccordion = () => this.derived({
    Desktop: 'div[data-testid="Where to Redeem-accordion"]',
  });

  public readonly NeedAssistanceAccordion = () => this.derived({
    Desktop: 'div[data-testid="Need Assistance-accordion"]',
  });

  public readonly PriceSelectLabel = (text: string) => this.derived({
    Desktop: `//div[contains(@class,"GiftCardPriceSelector_DisplayText") and contains(text(), "${text}")]`,
  });

  public readonly PriceSelectorButton = (index?: number) => this.derived({
    Desktop: `(//div[contains(@class, "GiftCardPriceSelector_PriceList")]//button)${index ? `[${index}]` : ''}`,
  });

  public readonly GiftCardAddToBagButton = () => this.derived({
    Desktop: 'button[data-testid="giftCardActionButton-giftCardAddToBag-pvh-button"]',
  });

  public readonly GiftCardNotifyMeButton = () => this.derived({
    Desktop: 'button[data-testid="giftCardActionButton-giftCardNotifyMe-pvh-button"]',
  });

  public readonly GiftCardComingSoonPopup = () => this.derived({
    Desktop: 'div[data-testid="NotifyMePopup-component"]',
  });

  public readonly AddToBagPopup = () => this.derived({
    Desktop: 'button[data-testid="giftCardActionButton-giftCardAddToBag-pvh-button"]',
  });

  public readonly GiftCardPriceSelectErrorMessage = () => this.derived({
    Desktop: 'div[data-testid="giftCardselectPriceError"]',
  });

  public readonly CheckoutButton = () => this.derived({
    Desktop: 'button[data-testid="giftCardProceedToCheckout-pvh-button"]',
  });

  public readonly GiftCardOverLimitError = (errorMessage: string) => this.derived({
    Desktop: `//div[@data-testid="giftCardOverLimitError" and contains(text(), "${errorMessage.split('(')[0]}")]`,
  });

  public readonly GiftCardsUsp = () => this.derived({
    Desktop: '//div[contains(@data-testid, "giftcardusp")]',
  });

  public readonly ComingSoonPopupFromDisplayPrice = () => this.derived({
    Desktop: '//span[contains(@data-testid, "labelPrefix")]/../span[@data-testid="PriceText"]',
  });

  public readonly ComingSoonPopupDisplayPrice = () => this.derived({
    Desktop: 'span[data-testid="PriceText"]',
  });
}
