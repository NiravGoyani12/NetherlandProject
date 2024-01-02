import { Singleton } from 'typescript-ioc';
import { maybeDisplayed$ } from '../../general';
import { Page } from '../../page';

@Singleton
export default class LoginPage extends Page {
  public readonly EmailField = () => this.derived({
    Desktop: '//input[@name="logonId"]',
  });

  public readonly PasswordField = () => this.derived({
    Desktop: '//input[@name="logonPassword"]',
  });

  public readonly LoginButton = () => this.derived({
    Desktop: '//button[@data-qa="button-login-submit"]',
  });

  public async FillEmailPassword(email: string, password: string) {
    await (await maybeDisplayed$(this.EmailField(), 10000)).safeType(email);
    await (await maybeDisplayed$(this.PasswordField(), 10000)).safeType(password);
    await (await maybeDisplayed$(this.LoginButton(), 10000)).safeClick();
  }
}
