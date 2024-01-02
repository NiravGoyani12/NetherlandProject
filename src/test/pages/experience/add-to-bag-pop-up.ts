import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class AddToBagPopUp extends Page {
  // #region Add to Bag popup
  public readonly MainBlock = () => this.derived({
    Desktop: '//*[@data-testid="added-to-bag-popup"]',
  });

  public readonly CloseButton = () => this.derived({
    Desktop: '//*[@data-testid="added-to-bag-popup"]//*[@data-testid="icon-utility-cross-svg"]',
  });

  public readonly ItemTitle = () => this.derived({
    Desktop: '//*[@data-testid="basketItem"]//div[contains(@class,"Title")]',
  });

  public readonly ItemColour = (colourText: string) => this.derived({
    Desktop: `//*[@data-testid="basketItem-attribute-value" and contains(text(), "${colourText.toLowerCase()}")]`,
  });

  public readonly ItemAtrribute = (text: string) => this.derived({
    Desktop: `//*[@data-testid="basketItem-attribute"]//*[${text ? `contains(text(), '${text.toLowerCase()}') or contains(text(), '${text}')` : ''}]`,
  });

  public readonly ItemAtrributeValue = (text: string) => this.derived({
    Desktop: `//*[@data-testid="basketItem-attribute-value" and ${text ? `contains(text(), '${text.toLowerCase()}') or contains(text(), '${text}')` : ''}]`,
  });

  public readonly ItemSize = (sizeText: string) => this.derived({
    Desktop: `//*[@data-testid="basketItem-attribute-value" and contains(text(), "${sizeText.toLowerCase()}")]`,
  });

  public readonly PriceSelling = (sellingPrice: string) => this.derived({
    Desktop: `//*[@data-testid="basketItem"]//*[@data-testid="PriceText" ${sellingPrice ? `and contains(., "${sellingPrice.replace(/\s/g, '\u00A0')}")` : ''}]`,
  });

  public readonly PriceWas = (wasPrice?: string) => this.derived({
    Desktop: `//*[@data-testid="basketItem"]//*[@data-testid="WasPriceText" ${wasPrice ? `and contains(., "${wasPrice.replace(/\s/g, '\u00A0')}")` : ''}]`,
  });

  public readonly ImageContainer = () => this.derived({
    Desktop: '//*[@data-testid="basketItem"]//img',
  });
  // #endregion
}
