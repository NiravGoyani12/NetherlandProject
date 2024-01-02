import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class SpaSignInForm extends Page {
  public readonly MembershipLogo = () => this.derived({
    Desktop: '//*[contains(@data-testid,"membership-hub-logo")]',
  });

  public readonly BannerWithText = () => this.derived({
    Desktop: '//div[contains(@class,"MembershipHub_headerSectionInfo")]',
  });

  public readonly MemberId = () => this.derived({
    Desktop: '//*[contains(@class,"MembershipHub_headerSectionInfo")]/span[2]',
  });

  public readonly VoucherComponent = () => this.derived({
    Desktop: '//section[contains(@class,"MembershipVoucherList")]',
  });

  public readonly VoucherCodeCopyBtn = () => this.derived({
    Desktop: '//*[name()="svg" and @data-testid="pvh-voucher-copy-icon"]',
  });
}
