import { Singleton } from 'typescript-ioc';
import { exist$ } from '../../general';
import { sleep } from '../../helper/utils.helper';
import { Page } from '../../page';

@Singleton
export default class SignInPopUp extends Page {
  public readonly EmailField = () => this.derived({
    Desktop: '#email-login-form',
  });

  public readonly PasswordField = () => this.derived({
    Desktop: '#password-login-form',
  });

  public readonly RememberMeCheckbox = () => this.derived({
    Desktop: '//div[@data-testid="rememberMe-Checkbox-Component-content"]',
  });

  public readonly ForgotPasswordLink = () => this.derived({
    Desktop: '//button[@data-testid="forgot-password-link"]',
  });

  public readonly SignInButton = () => this.derived({
    Desktop: '//button[@data-testid="login-form-submit-pvh-button"]',
  });

  public readonly CloseButton = () => this.derived({
    Desktop: '//button[contains(@class, "CloseButton")]',
  });

  public readonly EmailError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-email"]',
  });

  public readonly PasswordError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-password"]',
  });

  public readonly SignInError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error"]',
  });

  // #region Forgot password
  public readonly ForgotPasswordEmailField = () => this.derived({
    Desktop: '#email-forgot-password-form',
  });

  public readonly ForgotPasswordSendButton = () => this.derived({
    Desktop: '//button[@data-testid="forgot-password-form-submit-pvh-button"]',
  });

  public readonly ForgotPasswordCancelButton = () => this.derived({
    Desktop: '//div[contains(@class, "ForgotPasswordForm_buttons")]//button[@data-testid="pvh-button"]',
  });

  public readonly PasswordResetMessageTitle = () => this.derived({
    Desktop: '//div[@data-testid="pvh-AuthPanel"]//h3[@data-testid="typography-h3"]',
  });

  public readonly PasswordResetMessage = () => this.derived({
    Desktop: '//div[@data-testid="pvh-forgot-password-success"]/p',
  });

  public readonly PasswordResetCloseButton = () => this.derived({
    Desktop: '//div[@data-testid="pvh-forgot-password-success"]/button',
  });

  public readonly ForgotPasswordEmailError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-email"]',
  });
  // #endregion

  public readonly CloseSignInPopUp = () => this.derived({
    Desktop: '//button[@data-testid="modal-close-btn"] | //div[@class="ReactModalPortal"]//button[@data-testid="pvh-icon-button"]',
  });

  public async DefaultUserSignIn() {
    await (await exist$(this.EmailField())).safeType('pvhqatester+4dc7ad77@gmail.com');
    await (await exist$(this.PasswordField())).safeType('qwerty1234');
    await (await exist$(this.SignInButton())).safeClick();
    await sleep(1000);
  }

  public async UserSignIn(email: string, password: string) {
    await (await exist$(this.EmailField())).safeType(email);
    await (await exist$(this.PasswordField())).safeType(password);
    await (await exist$(this.SignInButton())).safeClick();
    await sleep(1000);
  }
}
