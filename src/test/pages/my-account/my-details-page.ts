import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class MyDetailsPage extends Page {
  public readonly PageHeader = () => this.derived({
    Desktop: '//h1[contains(@class, "page_heading_title")]',
  });

  public readonly PageSubtitle = () => this.derived({
    Desktop: '//p[@data-testid="page-subtitle"]',
  });

  public readonly PersonalDetailsCard = () => this.derived({
    Desktop: '//section[@aria-labelledby="edit-personal-details"]',
  });

  public readonly EmailCard = () => this.derived({
    Desktop: '//section[@aria-labelledby="edit-email"]',
  });

  public readonly PasswordCard = () => this.derived({
    Desktop: '//section[@aria-labelledby="edit-password"]',
  });

  public readonly DetailsEditCancelButton = () => this.derived({
    Desktop: '//button[@data-testid="details-open-close"]',
  });

  // #region Personal details
  public readonly MrsButton = () => this.derived({
    Desktop: '//button[@data-testid="pvh-ToggleButton"][1]',
  });

  public readonly MrButton = () => this.derived({
    Desktop: '//button[@data-testid="pvh-ToggleButton"][2]',
  });

  public readonly OtherButton = () => this.derived({
    Desktop: '//button[@data-testid="pvh-ToggleButton"][3]',
  });

  public readonly FirstName = () => this.derived({
    Desktop: '//input[@data-testid="first-name-inputField"]',
  });

  public readonly LastName = () => this.derived({
    Desktop: '//input[@data-testid="last-name-inputField"]',
  });

  public readonly Day = () => this.derived({
    Desktop: '//input[@data-testid="day-inputField"]',
  });

  public readonly Month = () => this.derived({
    Desktop: '//input[@data-testid="month-inputField"]',
  });

  public readonly Year = () => this.derived({
    Desktop: '//input[@data-testid="year-inputField"]',
  });

  public readonly DetailsUpdateButton = () => this.derived({
    Desktop: '//button[@data-testid="details-form-submit-pvh-button"]',
  });

  public readonly FirstNameError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-first-name"]',
  });

  public readonly LastNameError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-last-name"]',
  });

  public readonly DateError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error"]',
  });

  public readonly InputFieldsError = () => this.derived({
    Desktop: '//input[@aria-invalid="true"]',
  });
  // #endregion

  public readonly EmailEditCancelButton = () => this.derived({
    Desktop: '//button[@data-testid="email-open-close"]',
  });

  // #region Email
  public readonly CurrentEmail = () => this.derived({
    Desktop: '(//p[@data-testid="typography-p"])[3]',
  });

  public readonly NewEmail = () => this.derived({
    Desktop: '//input[@data-testid="email-inputField"]',
  });

  public readonly NewEmailConfirm = () => this.derived({
    Desktop: '//input[@data-testid="email-confirm-inputField"]',
  });

  public readonly Password = () => this.derived({
    Desktop: '//input[@data-testid="email-password-inputField"]',
  });

  public readonly EmailUpdateButton = () => this.derived({
    Desktop: '//button[@data-testid="email-form-submit-pvh-button"]',
  });

  public readonly NewEmailError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-email"]',
  });

  public readonly ConfirmEmailError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-email-confirm"]',
  });

  public readonly EmailPasswordError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-email-password"]',
  });

  public readonly EmailUpdatedMessage = () => this.derived({
    Desktop: '#success-alert-content',
  });
  // #endregion

  public readonly PasswordEditCancelButton = () => this.derived({
    Desktop: '//button[@data-testid="password-open-close"]',
  });

  // #region Password
  public readonly OldPassword = () => this.derived({
    Desktop: '//input[@data-testid="password-old-inputField"]',
  });

  public readonly NewPassword = () => this.derived({
    Desktop: '//input[@data-testid="password-inputField"]',
  });

  public readonly NewPasswordConfirm = () => this.derived({
    Desktop: '//input[@data-testid="password-confirm-inputField"]',
  });

  public readonly PasswordRequirementsList = (index: number) => this.derived({
    Desktop: `(//form[@id="password-form"]//ul[@data-testid="pvh-List"]//li)[${index}]`,
  });

  public readonly PasswordUpdateButton = () => this.derived({
    Desktop: '//button[@data-testid="password-form-submit-pvh-button"]',
  });

  public readonly PasswordConsecutiveCharError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error"]',
  });
  // #endregion

  public readonly SuccessNotify = () => this.derived({
    Desktop: '//span[@id= "success-alert-content"]',
  });

  public readonly DiscardButton = () => this.derived({
    Desktop: '//button[@data-testid="discard-pvh-button"]',
  });

  public readonly ContinueEditingButton = () => this.derived({
    Desktop: '//button[@data-testid="continue-editing-pvh-button"]',
  });

  public readonly NewsletterText = () => this.derived({
    Desktop: '//span[@data-testid="text-with-read-more-component"]',
  });

  public readonly DeleteAccountButton = () => this.derived({
    Desktop: '//a[@data-testid="account-deactivate-click"]',
  });

  public readonly ExpandTextButton = () => this.derived({
    Desktop: '//button[@data-testid="expand-collapse-icon-pvh-icon-button"]',
  });
}
