import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class ShoppingBagToast extends Page {
  public readonly MainBlock = () => this.derived({
    Desktop: '//div[@data-testid="pvh-PageNotification-info"]',
  });

  public readonly ShoppingBagLink = () => this.derived({
    Desktop: '//*[@data-test-id="notification-view-sb"]',
  });

  public readonly ShoppingBagToastCloseBtn = () => this.derived({
    Desktop: '//div[@data-testid="pvh-PageNotification-info"]//*[@data-testid="icon-utility-cross-svg"]',
  });

  public readonly ShoppingBagToastText = () => this.derived({
    Desktop: '//div[@data-testid="pvh-PageNotification-info"]//p',
  });

  public readonly ShoppingBagToastImage = () => this.derived({
    Desktop: '//div[@data-testid="pvh-PageNotification-info"]//img',
  });
}
