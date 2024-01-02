import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class Overview extends Page {
  public readonly DetailsButton = () => this.derived({
    Desktop: '//nav[@data-testid="myaccount-nav"]//ul//a[contains(@href, "details")]',
  });

  public readonly OrdersButton = () => this.derived({
    Desktop: '//nav[@data-testid="myaccount-nav"]//ul//a[contains(@href, "orders")]',
  });

  public readonly AddressesButton = () => this.derived({
    Desktop: '//nav[@data-testid="myaccount-nav"]//ul//a[contains(@href, "addresses")]',
  });

  public readonly PreferencesButton = () => this.derived({
    Desktop: '//nav[@data-testid="myaccount-nav"]//ul//a[contains(@href, "preferences")]',
  });

  public readonly NotificationsButton = () => this.derived({
    Desktop: '//nav[@data-testid="myaccount-nav"]//ul//a[contains(@href, "notifications")]',
  });
}
