import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class AccountFlyout extends Page {
  public readonly FlyMenu = () => this.derived({
    Desktop: '//div[@data-testid="pvh-account-drawer-Modal-component"]',
  });

  public readonly FlyMenuSignIn = () => this.derived({
    Desktop: '//div[@data-testid="pvh-auth-drawer-Modal-component"]',
  });

  public readonly TommyMembershipLink = () => this.derived({
    Desktop: '//a[contains(@href, "/myaccount/membershiphub")]',
  });

  public readonly AccountDetailsLink = () => this.derived({
    Desktop: '//a[contains(@href, "/myaccount/details")]',
  });

  public readonly AccountOrdersLink = () => this.derived({
    Desktop: '//a[contains(@href, "/myaccount/orders")]',
  });

  public readonly AccountAddressesLink = () => this.derived({
    Desktop: '//a[contains(@href, "/myaccount/addresses")]',
  });

  public readonly AccountEmailPreferencesLink = () => this.derived({
    Desktop: '//a[contains(@href, "/myaccount/preferences")]',
  });

  public readonly AccountNotificationsLink = () => this.derived({
    Desktop: '//a[contains(@href, "/myaccount/notifications")]',
  });

  public readonly SignOutButton = () => this.derived({
    Desktop: '//button[@data-testid="sign-out-pvh-ResponsiveNavListItem"]',
    Mobile: '//a[@data-testid="mega-menu-third-level-sign-out"]',
  });
}
