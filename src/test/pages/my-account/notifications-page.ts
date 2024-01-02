import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class NotificationsPage extends Page {
  public readonly NotificationProduct = () => this.derived({
    Desktop: '//div[@data-testid="ProductNotifications"]//div[@data-testid="basketItem"]',
  });

  public readonly CancelNotificationsButton = () => this.derived({
    Desktop: '//button[@data-testid="pvh-button" and contains(@class, "Button_secondary")]',
  });
}
