import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class SpaMembershipLoyaltySignInForm extends Page {
  public readonly MembershipLogo = () => this.derived({
    Desktop: '//*[@data-testid="authentication-modal-membership-logo"] | //div[@data-testid="pvh-auth-drawer-Modal-component"]//*[@data-testid="membership-hub-logo-svg"] | //*[@data-testid="membership-hub-logo-svg"]',
  });

  public readonly CloseButton = () => this.derived({
    Desktop: '//button[@data-testid="modal-close-btn"] | //div[@data-testid="pvh-auth-drawer-Modal-component"]//button[contains(@class, "Modal_CloseButton")]',
  });

  public readonly Email = () => this.derived({
    Desktop: '//input[@id="signin-email"] | //input[@id="email-login-form"]',
  });

  public readonly Password = () => this.derived({
    Desktop: '//input[@id="signin-password"] | //input[@id="password-login-form"]',
  });

  public readonly ShowPasswordButton = () => this.derived({
    Desktop: '//*[@data-qa="show-hide-password-text"] | //*[@data-testid="icon-utility-unmask-svg"]',
  });

  public readonly SubmitButton = () => this.derived({
    Desktop: '//button[@data-testid="Button-primary"] | //button[@data-testid="login-form-submit-pvh-button"]',
  });

  public readonly GoToMyAccountButton = () => this.derived({
    Desktop: '//button[@data-testid="join-membership-pvh-button"]',
  });

  public readonly RememberMeCheckbox = () => this.derived({
    Desktop: '//input[@id="signin-remember-me"] | //div[@data-testid="rememberMe-Checkbox-Component-icon"]',
  });

  public readonly ForgotPasswordLink = () => this.derived({
    Desktop: '//button[@data-testid="forgot-password"] | //button[@data-testid="forgot-password-link"]',
  });

  public readonly DiscoverTommyLink = () => this.derived({
    Desktop: '//button[@data-testid="membership-sign-in-discover"]',
  });

  public readonly BecomeMemberButton = () => this.derived({
    Desktop: '//button[@data-testid="register"] | //button[@data-testid="register-pvh-button"]',
  });

  public readonly MemebrshipSignInTitle = () => this.derived({
    Desktop: '//div[contains(@class,"membership-sign-in__title")] | //h3[@data-testid="typography-h3"] | //*[@id="main-and-footer"]/main/div[2]/div/div/div/div/div[2]/div/div[1]/h3',
  });

  public readonly MemebrshipBenefitText = () => this.derived({
    Desktop: '//div[@data-testid="MembershipBenefitsDetails-component"]//h3[@data-testid="typography-h3"]',
    Mobile: '//div[@data-testid="MembershipBenefitsDetails-component"]//h3[@data-testid="typography-h3"]',
  });

  public readonly SignInForm = () => this.derived({
    Desktop: '//div[@data-testid="modal-backdrop"]',
  });

  public readonly ForgetPasswordEmail = () => this.derived({
    Desktop: '//input[@name="forgot-password-email"] | //input[@data-testid="email-inputField"]',
  });

  public readonly SendButton = () => this.derived({
    Desktop: '//button[@data-testid="Button-primary"] | //button[@data-testid="forgot-password-form-submit-pvh-button"]',
  });
}
