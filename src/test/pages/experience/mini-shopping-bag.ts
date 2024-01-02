import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class MiniShoppingBag extends Page {
  // #region Mini Basket
  public readonly MainPanel = () => this.derived({
    Desktop: '//*[@data-testid="MiniShoppingBag-component"]',
  });

  public readonly Products = () => this.derived({
    Desktop: '//div[@data-testid="MiniShoppingBag-component"]//*[@data-testid="basketItem"]',
  });

  public readonly ItemAtrributeValue = (text?: string) => this.derived({
    Desktop: `//*[@data-testid="basketItem-attribute-value" and contains(text(), '${text.toLowerCase()}')]`,
  });

  public readonly ProductNameLink = () => this.derived({
    Desktop: '//*[@data-testid="common-productlist"]//*[@data-testid="basketItem-title"]/span',
  });

  public readonly ProductColorInfo = (skuPartNumber?: string) => this.derived({
    Desktop: `(//*[@data-testid="MiniShoppingBag-component"]//div[@data-testid="basketItem"${skuPartNumber ? `and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid="basketItem-attribute"])[1]`,
  });

  public readonly ProductSizeInfo = (skuPartNumber?: string) => this.derived({
    Desktop: `(//*[@data-testid="MiniShoppingBag-component"]//div[@data-testid="basketItem"${skuPartNumber ? `and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid="basketItem-attribute"])[2]`,
  });

  public readonly ProductQuantityInfo = (skuPartNumber?: string) => this.derived({
    Desktop: `(//*[@data-testid="MiniShoppingBag-component"]//div[@data-testid="basketItem"${skuPartNumber ? `and @data-partnumber='${skuPartNumber}'` : ''}]//*[@data-testid="basketItem-attribute"])[3]`,
  });

  public readonly ProductPriceSelling = (skuPartNumber?: string) => this.derived({
    Desktop: `//*[@data-testid="MiniShoppingBag-component"]//div[@data-testid="basketItem"${skuPartNumber ? `and @data-partnumber='${skuPartNumber}'` : ''}]//span[@data-testid="ProductList-PriceText"]`,
  });

  public readonly ProductPriceWas = (skuPartNumber?: string) => this.derived({
    Desktop: `//*[@data-testid="MiniShoppingBag-component"]//div[@data-testid="basketItem"${skuPartNumber ? `and @data-partnumber='${skuPartNumber}'` : ''}]//span[@data-testid="ProductList-WasPriceText"]`,
  });

  public readonly ButtonBlock = () => this.derived({
    Desktop: '//div[@class="mini-basket__summary"]',
  });

  public readonly Buttons = () => this.derived({
    Desktop: '//*[@data-testid="MiniShoppingBag-component"]//*[@type="button" or @role="button" or @type="submit"]',
  });

  public readonly ShoppingBagButton = () => this.derived({
    Desktop: '//*[@data-testid="MiniShoppingBag-component"]//*[@data-testid="MiniShoppingBag-sb-pvh-button"]',
  });

  public readonly CheckOutButton = () => this.derived({
    Desktop: '//*[@data-testid="MiniShoppingBag-component"]//*[@data-testid="proceed-to-checkout-pvh-button"]',
  });

  public readonly PaypalButton = () => this.derived({
    Desktop: '//*[@data-testid="MiniShoppingBag-component"]//*[@data-testid="paypal-express-pvh-button"]',
  });

  public readonly TotalPrice = () => this.derived({
    Desktop: '//*[@data-testid="MiniShoppingBag-Total-PriceText"]',
  });

  public readonly ImageContainers = () => this.derived({
    Desktop: '//*[@data-testid="ShoppingBag-image"]',
  });

  public readonly PaypalPayLaterLink = () => this.derived({
    Desktop: '//div[@data-testid="MiniShoppingBag-component"]//div[@data-testid="paypal-paylater-message-dom"]//span',
  });

  public readonly MiniBagPaypalExpress = () => this.derived({
    Desktop: '//div[@data-testid="MiniShoppingBag-component"]//button[@data-testid="paypal-express-pvh-button"]',
  });

  public readonly IframePaypalPayLaterModal = () => this.derived({
    Desktop: '//iframe[@title="PayPal Modal 1"]',
  });

  public readonly PaypalPayLaterModalCloseIcon = () => this.derived({
    Desktop: '//button[@id="close-btn"]',
  });
  // #endregion
}
