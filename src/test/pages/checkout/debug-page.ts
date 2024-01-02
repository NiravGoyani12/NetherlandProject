import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class DebugPage extends Page {
  // #region Shopping Cart
  public readonly ShoppingCartItem = (text?: string) => this.derived({
    Desktop: `//span[text()="${text}"]/following-sibling::button`,
  });

  public readonly BasketItem = () => this.derived({
    Desktop: '//div[@data-testid="basketItem"]',
  });
}
