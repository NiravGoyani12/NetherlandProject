import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class SpaForgotPasswordForm extends Page {
  public readonly MembershipLogo = () => this.derived({
    Desktop: '//*[@data-testid="authentication-modal-membership-logo"] | //div[@data-testid="Modal-component-ml-logo"] | //*[@data-testid="membership-hub-logo-svg"]',
  });

  public readonly Heading = () => this.derived({
    Desktop: '//*[contains(@class,"authentication-success__heading")] | //div[@data-testid="pvh-AuthPanel"]//h3[@data-testid="typography-h3"]',
  });

  public readonly SuccessText = () => this.derived({
    Desktop: '//p[contains(@class,"authentication-success__text")] | //p[@data-testid="forgot-password-success-text-typography-p"]',
  });

  public readonly ContinueShopping = () => this.derived({
    Desktop: '//button[@data-testid="Button-secondary"] | //div[@data-testid="pvh-forgot-password-success"]//button[@data-testid="pvh-button"]',
  });
}
