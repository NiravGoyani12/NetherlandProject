import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class UXWishlist extends Page {
  public readonly EmptyWishlistTitle = (text?: string) => this.derived({
    Desktop: `//*[@data-testid="pvh-IconWithText" and contains(@class,"EmptyList") and contains(., "${text || ''}")]`,
  });

  public readonly EmptyWishlistCopy = (text?: string) => this.derived({
    Desktop: `//*[contains(@class,"EmptyWishlist_contentText") and contains(., "${text || ''}")]`,
  });

  public readonly EmptyWishlistButton = (text?: string) => this.derived({
    Desktop: `//*[@data-testid="emptyWishlist-pvh-button" and contains(., "${text || ''}")]`,
  });

  public readonly FilledWishlistTitle = (text?: string) => this.derived({
    Desktop: `//*[@data-testid="FilledWishlist-component"]//h2[contains(., "${text || ''}")]`,
  });

  public readonly FilledWishlistCopy = (text?: string) => this.derived({
    Desktop: `//*[@data-testid="FilledWishlist-component"]//p[contains(., "${text}")]`,
  });

  public readonly FilledWishlistSignInButton = () => this.derived({
    Desktop: '//*[@data-testid="filledWishlist-sign-in-pvh-button"]',
  });

  public readonly ProductTileComponent = (index?: number) => this.derived({
    Desktop: `(//*[@data-testid="ProductTile-component"])${index ? `[${index}]` : ''}`,
  });

  public readonly ProductTileDeleteButton = (index?: number) => this.derived({
    Desktop: `(//*[@data-testid='ProductTile-component']//button[@data-testid='pvh-icon-button'])${index ? `[${index}]` : ''}`,
  });

  public readonly ProductImage = (index?: number) => this.derived({
    Desktop: `(//*[@data-testid="ProductTile-component"]//img)${index ? `[${index}]` : ''}`,
  });

  public readonly ItemTitle = (index?: number) => this.derived({
    Desktop: `(//*[@data-testid='WishlistProduct-title'])${index ? `[${index}]` : ''}`,
  });

  public readonly ListingItems = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid='ProductTile-component'])${index ? `[${index}]` : ''}`,
  });

  public readonly LoadMoreButton = () => this.derived({
    Desktop: '//button[@data-testid="loadMore-pvh-button"]',
  });

  public readonly ProductCount = () => this.derived({
    Desktop: '//span[@class="wishlist__count" and string-length(text()) > 0]',
  });

  // eslint-disable-next-line max-len
  public readonly EditSizeDropdown = (styleColourPartNumber?: string, text?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//div[@data-testid="WishlistProduct-size-select-select-component"]',
      optionSelector: `//*[@data-testid="select-component-options-list"]//li[contains(text(),normalize-space("${text}"))]`,
    },
  });

  public readonly AllSizes = () => this.derived({
    Desktop: '//div[@data-testid="SingleSelectForm-component"]//li',
  });

  public readonly EnabledAddToBagButton = (index?: number) => this.derived({
    Desktop: `(//button[@data-testid="SingleSelectForm-pvh-button" and not(contains(@class,"disabled"))])${index ? `[${index}]` : ''}`,
  });

  public readonly DisabledAddToBagButton = (index?: number) => this.derived({
    Desktop: `(//button[@data-testid="SingleSelectForm-pvh-button" and (contains(@class,"disabled"))])${index ? `[${index}]` : ''}`,
    Mobile: `(//button[@data-testid="SingleSelectForm-pvh-button" and (contains(@class,"disabled"))])${index ? `[${index}]` : ''} | (//button[@data-testid="SingleSelectForm-pvh-button" and (contains(@class,"disabled"))])${index ? `[${index}]` : ''}`,
  });

  public readonly RemoveButton = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="ProductTile-component"]/button)${index ? `[${index}]` : ''}`,
  });

  // price format
  public readonly ProductCurrentPrice = () => this.derived({
    Desktop: '//span[@data-testid="WishlistProduct-PriceText"]',
  });

  public readonly ProductWasPrice = () => this.derived({
    Desktop: '//span[@data-testid="WishlistProduct-WasPriceText"]',
  });

  // #region Items
  public readonly WishListItem = (styleColourPartNumber?: string) => this.derived({
    Desktop: `//*[@data-testid='FilledWishlist-component']//*[@data-testid='pvh-GridItem']//div[@data-partnumber="${styleColourPartNumber ? styleColourPartNumber.toUpperCase() : ''}"]`,
  });

  public readonly WishListItemPrice = (styleColourPartNumber?: string) => this.derived({
    Desktop: `//div[@data-partnumber="${styleColourPartNumber ? styleColourPartNumber.toUpperCase() : ''}"]//*[@data-testid="WishlistProduct-PriceText"]`,
  });

  // eslint-disable-next-line max-len
  public readonly ItemFromCurrentPrice = (styleColourPartNumber?: string, price?: string) => this.derived({
    Desktop: `//div[@class='wishlist-item-info__desc' and div//a[contains(@href, "${styleColourPartNumber ? styleColourPartNumber.toLowerCase() : ''}")]]/../..//span[@data-testid='price-display__from' and contains(text(), "${price || ''}")]`,
  });

  public readonly ItemWasPrice = (styleColourPartNumber?: string, price?: string) => this.derived({
    Desktop: `//div[@class='wishlist-item-info__desc' and div//a[contains(@href, "${styleColourPartNumber ? styleColourPartNumber.toLowerCase() : ''}")]]/../..//span[@data-testid='price-display__was' and contains(text(), "${price || ''}")]`,
  });

  public readonly WishListItemByIndex = (index: number) => this.derived({
    Desktop: `(//a[contains(@class, "wishlist-item-info__desc-title")])[${index}]`,
  });
}
