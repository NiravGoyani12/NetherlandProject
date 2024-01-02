import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class CsrCreateUserPage extends Page {
  public readonly FirstNameInput = () => this.derived({
    Desktop: '#firstname',
  });

  public readonly LastNameInput = () => this.derived({
    Desktop: '#surname',
  });

  public readonly EmailInput = () => this.derived({
    Desktop: '#email',
  });

  public readonly TempPasswordInput = () => this.derived({
    Desktop: '#password',
  });

  public readonly CsrLevelDropdown = (text?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//div[contains(@class, "-select") and contains(@id, "level")]',
      optionSelector: `//div[@id="menu-csrlevel"]//li[contains(., "${text || ''}")]`,
    },
  });

  public readonly CsrCompanyDropdown = (text?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//div[contains(@class, "-select") and contains(@id, "company")]',
      optionSelector: `//div[@id="menu-company"]//li[contains(., "${text || ''}")]`,
    },
  });

  public readonly CreateUserSubmitButton = () => this.derived({
    Desktop: '//button[@data-qa="button-csr-create-submit"]',
  });

  // #region created CSR user details
  public readonly CreatedUserText = () => this.derived({
    Desktop: '//h2[contains(text(), "Created")]',
  });

  public readonly CreatedUserEmail = (text?: string) => this.derived({
    Desktop: `//main//table//td[contains(., "${text || ''}")]`,
  });

  public readonly CreatedUserPassword = (text?: string) => this.derived({
    Desktop: `//main//table//td[2][contains(., "${text || ''}")]`,
  });

  public readonly CreatedUserPasswordCopyButton = () => this.derived({
    Desktop: '//main//table//td/button',
  });
  // #endregion

  // #region error messages
  public readonly FirstNameInputError = (text?: string) => this.derived({
    Desktop: `//p[@id="firstname-helper-text" and contains(., "${text || ''}")]`,
  });

  public readonly LastNameInputError = (text?: string) => this.derived({
    Desktop: `//p[@id="surname-helper-text" and contains(., "${text || ''}")]`,
  });

  public readonly EmailInputError = (text?: string) => this.derived({
    Desktop: `//p[@id="email-helper-text" and contains(., "${text || ''}")]`,
  });

  public readonly TempPasswordInputError = (text?: string) => this.derived({
    Desktop: `//p[@id="password-helper-text" and contains(., "${text || ''}")]`,
  });

  public readonly AccountCreateError = (text?: string) => this.derived({
    Desktop: `//div[@data-qa="text-search-error" and contains(., "${text || ''}")]`,
  });

  public readonly InputError = () => this.derived({
    Desktop: '//form[@class="accountCreateCsr"]//div[contains(@class, "-error")]',
  });
  // #endregion
}
