import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class SessionExpiryPopUp extends Page {
  // #region Session Expiry Pop Up
  public readonly MainBlock = () => this.derived({
    Desktop: '//*[@data-testid="pvh-dialog-Modal-component"]',
  });

  public readonly ItemTitle = () => this.derived({
    Desktop: '//*[@data-testid="pvh-dialog-title" and contains(text(),"expired")]',
  });

  public readonly CloseButton = () => this.derived({
    Desktop: '//*[@data-testid="pvh-dialog-Modal-component"]//*[@data-testid="icon-utility-cross-svg"]',
  });

  public readonly EmailField = () => this.derived({
    Desktop: '//*[@data-testid="email-inputField"]',
  });

  public readonly PasswordField = () => this.derived({
    Desktop: '//*[@data-testid="password-inputField"]',
  });

  public readonly RememberMeCheckBox = () => this.derived({
    Desktop: '//*[@data-testid="rememberMe-Checkbox-Component-icon"]',
  });

  public readonly SignInButton = () => this.derived({
    Desktop: '//*[@data-testid="login-form-submit-pvh-button"]',
  });
  // #endregion
}
