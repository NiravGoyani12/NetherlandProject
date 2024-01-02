/* eslint-disable max-len */
import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class AccountManagementPage extends Page {
  // #region Csr search
  public readonly AccountManagementTab = () => this.derived({
    Desktop: '//a[@href="/csr/account/search"]',
  });

  public readonly CreatehCsrUserTab = () => this.derived({
    Desktop: '//a[contains(@class, "Tab") and contains(., "create")]',
  });

  public readonly CreateCustomerAccountTab = () => this.derived({
    Desktop: '(//a[contains(@class, "Tab") and contains(@href, "/account/create-customer")])',
  });

  public readonly EmailInput = () => this.derived({
    Desktop: '//input[@name="email"]',
  });

  public readonly FisrtNameInput = () => this.derived({
    Desktop: '//input[@name="firstname"]',
  });

  public readonly SurnameInput = () => this.derived({
    Desktop: '//input[@name="surname"]',
  });

  public readonly CsrLevelDropdown = (text?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//div[@id="csrlevel-select"]',
      optionSelector: `//ul[@aria-labelledby="csrlevel-label"]//li[contains(@data-value, "${text || ''}")]`,
    },
  });

  public readonly SearchButton = () => this.derived({
    Desktop: '//button[@data-qa="button-search-submit"]',
  });

  public readonly ClearButton = () => this.derived({
    Desktop: '//button[@data-qa="button-search-clear"]',
  });
  // #endregion

  // #region search result table
  public readonly SearchResultTable = () => this.derived({
    Desktop: '//tbody[@data-qa="table-search-results"]',
  });

  public readonly SearchResultTableEditButton = (itemIndex?: number) => this.derived({
    Desktop: `(//a[contains(@data-qa, "edit")])${itemIndex ? `[${itemIndex}]` : ''}`,
  });

  public readonly SearchResultTablePasswordButton = (itemIndex?: number) => this.derived({
    Desktop: `(//button[contains(@data-qa, "edit")])${itemIndex ? `[${itemIndex}]` : ''}`,
  });

  public readonly SearchResultTableDeactivateButton = (itemIndex?: number) => this.derived({
    Desktop: `(//button[contains(@data-qa, "deactivate")])${itemIndex ? `[${itemIndex}]` : ''}`,
  });

  public readonly SearchResultTableNameColumn = (text?: string, itemIndex?: number) => this.derived({
    Desktop: `(//tbody//th[1][contains(., "${text || ''}")])${itemIndex ? `[${itemIndex}]` : ''}`,
  });

  public readonly SearchResultTableEmailColumn = (text?: string, itemIndex?: number) => this.derived({
    Desktop: `(//tbody//td[1][contains(., "${text || ''}")])${itemIndex ? `[${itemIndex}]` : ''}`,
  });

  public readonly SearchResultTableLevelColumn = (text?: string, itemIndex?: number) => this.derived({
    Desktop: `(//tbody//td[2][contains(., "${text || ''}")])${itemIndex ? `[${itemIndex}]` : ''}`,
  });

  public readonly SearchResultText = (text?: string) => this.derived({
    Desktop: `//div[@class="results"]/h2[contains(., "${text || ''}")]`,
  });
  // #endregion

  // #region edit account
  public readonly EditFirstNameInput = (text?: string) => this.derived({
    Desktop: `//input[@data-qa="input-csr-create-firstname" ${text ? ` and contains(., "${text}")` : ''}]`,
  });

  public readonly EditLastNameInput = (text?: string) => this.derived({
    Desktop: `//input[@data-qa="input-csr-create-surname" ${text ? ` and contains(., "${text}")` : ''}]`,
  });

  public readonly EditEmailField = (text?: string) => this.derived({
    Desktop: `//input[@data-qa="input-csr-create-email" ${text ? ` and contains(., "${text}")` : ''}]`,
  });

  public readonly EditSaveButton = () => this.derived({
    Desktop: '//button[@data-qa="button-csr-create-submit"]',
  });

  public readonly BackToSearchButton = () => this.derived({
    Desktop: '//button[@data-qa="button-csr-create-again"]',
  });

  public readonly SearchErrorMsg = () => this.derived({
    Desktop: '//div[@data-qa="text-search-error"]',
  });
  // #endregion

  // #region reset account password
  public readonly PasswordResetPopup = () => this.derived({
    Desktop: '//div[contains(@class,"UpdatePassword")]//div[@data-qa="text-admin-password"]',
  });

  public readonly PasswordResetPopupClose = () => this.derived({
    Desktop: '//div[contains(@class, "Modal_modal")]/*[contains(@class, "closeIcon")]',
  });

  public readonly PasswordPopupInputField = () => this.derived({
    Desktop: '//input[@data-testid="input-admin-password"]',
  });

  public readonly GeneratePasswordButton = () => this.derived({
    Desktop: '//button[@data-qa="button-update-submit"]',
  });

  public readonly UpdatePasswordPopup = () => this.derived({
    Desktop: '//div[contains(@class, "UpdatePassword")]',
  });
  // #endregion

  // #region deactivate button
  public readonly DeactivatePopup = () => this.derived({
    Desktop: '//div[@class="DeactivateUser_deactivateUser__26rNT"]',
  });

  public readonly DeactivatePopupConfirmButton = () => this.derived({
    Desktop: '//div[@class="DeactivateUser_deactivateUser__26rNT"]//button[contains(., "Confirm")]',
  });

  public readonly DeactivatePopupCancelButton = () => this.derived({
    Desktop: '//div[@class="DeactivateUser_deactivateUser__26rNT"]//button[contains(., "Cancel")]',
  });
  // #endregion
}
