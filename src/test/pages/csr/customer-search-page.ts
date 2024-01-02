import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class CustomerSearchPage extends Page {
  // #region Csr customer search
  public readonly CustomerSearchTab = () => this.derived({
    Desktop: '//a[@href="/csr/customers"]',
  });

  public readonly EmailInput = () => this.derived({
    Desktop: '//input[@data-qa="input-search-email"]',
  });

  public readonly FirstNameInput = () => this.derived({
    Desktop: '//input[@data-qa="input-search-firstName"]',
  });

  public readonly LastNameInput = () => this.derived({
    Desktop: '//input[@data-qa="input-search-lastName"]',
  });

  public readonly AddressInput = () => this.derived({
    Desktop: '//input[@data-qa="input-search-address"]',
  });

  public readonly CityInput = () => this.derived({
    Desktop: '//input[@data-qa="input-search-townCity"]',
  });

  public readonly PostcodeInput = () => this.derived({
    Desktop: '//input[@data-qa="input-search-postcode"]',
  });

  public readonly PhoneInput = () => this.derived({
    Desktop: '//input[@data-qa="input-search-phoneNumber"]',
  });

  public readonly SearchButton = () => this.derived({
    Desktop: '//button[@data-qa="button-search-submit"]',
  });

  public readonly ClearButton = () => this.derived({
    Desktop: '//button[@data-qa="button-search-clear"]',
  });
  // #endregion

  // #region error messages
  public readonly EmailInputError = () => this.derived({
    Desktop: '#email-helper-text',
  });

  public readonly NodataErrorMessage = () => this.derived({
    Desktop: '//div[@class="error"]',
  });

  // #endregion
  // #region  search result table
  public readonly SearchResultTableNameColumn = (text?: string) => this.derived({
    Desktop: `//table//tr/th[1][contains(., "${text || ''}")]`,
  });

  public readonly SearchResultTableEmailColumn = (text?: string) => this.derived({
    Desktop: `//table//td[1][contains(., "${text || ''}")]`,
  });

  public readonly SearchResultTableRegisteredFromColumn = (text?: string) => this.derived({
    Desktop: `//table//td[2][contains(., "${text || ''}")]`,
  });

  public readonly SearchResultTableAddressColumn = (text?: string) => this.derived({
    Desktop: `//table//td[3][contains(., "${text || ''}")]`,
  });

  public readonly SearchResultTableCountryColumn = (text?: string) => this.derived({
    Desktop: `//table//td[4][contains(., "${text || ''}")]`,
  });

  public readonly SearchResultTablePhoneColumn = (text?: string) => this.derived({
    Desktop: `//table//td[5][contains(., "${text || ''}")]`,
  });

  public readonly SearchResultTableDOBColumn = (text?: string) => this.derived({
    Desktop: `//table//td[6][contains(., "${text || ''}")]`,
  });

  public readonly SearchResultTableResetPasswordButton = () => this.derived({
    Desktop: '//table//td[7]/button',
  });

  public readonly SearchResultText = (text?: string) => this.derived({
    Desktop: `//div[@class="results"]/h2[contains(., "${text || ''}")]`,
  });

  public readonly SearchResultTable = () => this.derived({
    Desktop: '//tbody[@data-qa="table-search-results"]',
  });
  // #endregion

  // #region  pagination
  public readonly PageNumber = (text?: string) => this.derived({
    Desktop: `//span[@class="paginationLinks"]//a[contains(., "${text || ''}")]`,
  });

  public readonly PageNumberInput = () => this.derived({
    Desktop: '//input[@data-qa="input-search-page"]',
  });

  public readonly GoButton = () => this.derived({
    Desktop: '//button[@data-qa="button-search-page-submit"]',
  });

  public readonly ReturnToCsr = () => this.derived({
    Desktop: '//*[@data-testid="CsrHeader-component"]/div/a',
  });

  public readonly OnBehalfText = () => this.derived({
    Desktop: '//*[@data-testid="CsrHeader-component"]/div/span',
  });

  public readonly MyAccountPreferences = () => this.derived({
    Desktop: '//a[contains(@href, "/myaccount/preferences")]',
  });

  public readonly MyAccountNewsletterComponent = () => this.derived({
    Desktop: '//*[@data-testid="NewsLetterPreferencesSignup-component"]',
  });

  public readonly MyAccountOrders = () => this.derived({
    Desktop: '//a[contains(@href, "/myaccount/orders")]',
  });

  public readonly MyAccountOrderPage = () => this.derived({
    Desktop: '//div[contains(@class, "Orders")]',
  });

  public readonly MyAccountFlyout = () => this.derived({
    Desktop: '//div[contains(@class, "Modal_Content")]//nav[@data-testid="myaccount-nav"]',
  });
  // #endregion
}
