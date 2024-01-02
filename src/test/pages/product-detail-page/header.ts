import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class Header extends Page {
  // #region breadcrumbs
  public readonly BreadcrumbsItem = (index?: number) => this.derived({
    Desktop: `//ol[contains(@class,"Breadcrumbs")]/li${index ? `[${index}]` : ''}`,
  });

  public readonly ActiveWishListIcon = () => this.derived({
    Desktop: '//*[contains(@class,"Header_WishlistIcon") and contains(@class,"BadgeFilled")and @data-testid="wishlist-IconWithBadge-component"]',
  });

  public readonly ActiveWishListCount = (count: string) => this.derived({
    Desktop: `//*[contains(@class,"Header_WishlistIcon") and contains(@class,"BadgeFilled")]/span[contains(text(), "${count}")]`,
  });

  public readonly ShoppingBagCounter = (text?: string) => this.derived({
    Desktop: `//*[@data-testid="basket-IconWithBadge-component"]//*[contains(@class,"IconCount")${text ? `and contains(., "${text}")` : ''}]`,
  });

  public readonly ShoppingBagButton = () => this.derived({
    Desktop: '//*[@data-testid="basket-IconWithBadge-component"]',
  });
}
