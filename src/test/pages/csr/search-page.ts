import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class SearchPage extends Page {
  // #region Csr search
  public readonly OrderSearchTab = () => this.derived({
    Desktop: '//a[@href="/csr/orders"]',
  });

  public readonly PartnerOrderSearchTab = () => this.derived({
    Desktop: '//a[@href="/csr/partner-orders"]',
  });

  public readonly OrderIdInput = () => this.derived({
    Desktop: '//input[@name="orderIds"]',
  });

  public readonly EmailInput = () => this.derived({
    Desktop: '//input[@name="emails"]',
  });

  public readonly SearchButton = () => this.derived({
    Desktop: '//button[@data-qa="button-search-submit"]',
  });

  public readonly ClearButton = () => this.derived({
    Desktop: '//button[@data-qa="button-search-clear"]',
  });

  public readonly AdvancedSearchButton = () => this.derived({
    Desktop: '//button[@data-qa="button-toggle-date-range"]',
  });

  public readonly EmptyInputError = () => this.derived({
    Desktop: '//div[@class= "error"]',
  });
  // #endregion

  // #region data picker
  public readonly DatePickerFromInput = (date?: string) => this.derived({
    Desktop: `//input[@data-qa="input-search-from" and contains(@value, "${date ?? ''}")]`,
  });

  public readonly DatePickerToInput = (date?: string) => this.derived({
    Desktop: `//input[@data-qa="input-search-to" and contains(@value, "${date ?? ''}")]`,
  });
  // #endregion

  // #region advanced search fields
  public readonly FirstNameInput = (text?: string) => this.derived({
    Desktop: `//input[@name="firstName" and contains(., "${text || ''}")]`,
  });

  public readonly LastNameInput = (text?: string) => this.derived({
    Desktop: `//input[@name="lastName" and contains(., "${text || ''}")]`,
  });

  public readonly AddressInput = (text?: string) => this.derived({
    Desktop: `//input[@name="address" and contains(., "${text || ''}")]`,
  });

  public readonly CityInput = () => this.derived({
    Desktop: '//input[@name="city"]',
  });

  public readonly PostCodeInput = () => this.derived({
    Desktop: '//input[@name="postCode"]',
  });

  public readonly CountryDropdown = (text?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//div[contains(@class, "-select") and @id="country-select"]',
      optionSelector: `//ul[@aria-labelledby="country-label"]//li[contains(@data-value, "${text || ''}")]`,
    },
  });

  public readonly CountryDropdownListCount = () => this.derived({
    Desktop: '//ul[@aria-labelledby="country-label"]//li',
  });

  public readonly CountryDropdownText = (text?: string) => this.derived({
    Desktop: `//input[@name="country" and contains(@value, "${text || ''}")]`,
  });

  public readonly OrderStatusDropdown = (text?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//div[contains(@class, "-select") and @id="status-select"]',
      optionSelector: `//ul[contains(@aria-labelledby, "status")]//li[contains(., "${text || ''}")]`,
    },
  });

  public readonly OrderStatusText = (text?: string) => this.derived({
    Desktop: `//div[contains(@class, "_orderStatus")]//div[@id="status-select" and contains(., "${text || ''}")]`,
  });

  public readonly PaymentMethodDropdown = (text?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//div[contains(@class, "OrdersSearchForm_paymentMethod")]',
      optionSelector: `//ul[contains(@aria-labelledby, "paymentMethod-label")]//li[contains(., "${text || ''}")]`,
    },
  });

  public readonly PaymentMethodText = (text?: string) => this.derived({
    Desktop: `//div[@id="paymentMethod-select" and contains(., "${text || ''}")]`,
  });

  public readonly WCSReturnNumberInput = () => this.derived({
    Desktop: '//input[@name="returnNumber"]',
  });

  public readonly PromocodeInput = () => this.derived({
    Desktop: '//input[@name="promotionCode"]',
  });

  public readonly InputError = () => this.derived({
    Desktop: '//p[contains(@class, "error")]',
  });

  public readonly DateInputError = () => this.derived({
    Desktop: '//div[@class="error"]',
  });

  // #region  search result table
  public readonly SearchResultTable = () => this.derived({
    Desktop: '//tbody[@data-qa="table-search-results"]',
  });

  public readonly SearchResultTableOrderIDColumn = (text?: string) => this.derived({
    Desktop: `//table//a[contains(., "${text || ''}")]`,
  });

  public readonly SearchResultTableEmailColumn = (text?: string) => this.derived({
    Desktop: `//table//td[1][contains(., "${text || ''}")]`,
  });

  public readonly SearchResultCustomerTypeColumn = (text?: string) => this.derived({
    Desktop: `//table//td[2][contains(., "${text || ''}")]`,
  });

  public readonly SearchResultTableCountryColumn = (text?: string) => this.derived({
    Desktop: `//table//td[3][contains(., "${text || ''}")]`,
  });

  public readonly SearchResultTablePaymentMethodColumn = (text?: string) => this.derived({
    Desktop: `//table//td[4][contains(., "${text || ''}")]`,
  });

  public readonly SearchResultTableTotalValueColumn = (text?: string) => this.derived({
    Desktop: `//table//td[5][contains(., "${text || ''}")]`,
  });

  public readonly SearchResultTableOrderDateColumn = (text?: string) => this.derived({
    Desktop: `//table//td[6][contains(., "${text || ''}")]`,
  });

  public readonly SearchResultTableStatusColumn = (text?: string) => this.derived({
    Desktop: `//table//td[7][contains(., "${text || ''}")]`,
  });

  public readonly SearchResultTableReturnIdColumn = (text?: string) => this.derived({
    Desktop: `//table//td[8][contains(., "${text || ''}")]`,
  });

  public readonly SearchResultTableSAPOrderNoColumn = (text?: string) => this.derived({
    Desktop: `//table//td[9][contains(., "${text || ''}")]`,
  });

  public readonly SearchResultText = (text?: string) => this.derived({
    Desktop: `//div[@class="results"]/h2[contains(., "${text || ''}")]`,
  });
  // #endregion

  public readonly PageNumber = (text?: string) => this.derived({
    Desktop: `//span[@class="paginationLinks"]//a[contains(., "${text || ''}")]`,
  });

  public readonly PageNumberInput = () => this.derived({
    Desktop: '//input[@data-qa="input-search-page"]',
  });

  public readonly GoButton = () => this.derived({
    Desktop: '//button[@data-qa="button-search-page-submit"]',
  });

  public readonly OrderDetailsByTableIndex = (index = 1) => this.derived({
    Desktop: `//table//tbody//th[${index}]//a`,
  });

  public readonly OrderShippingLink = () => this.derived({
    Desktop: '//div[contains(@class, "MuiPaper-root details-box MuiPaper-elevation1 MuiPaper-rounded")][3]//div[contains(@class, "lineItem")][3]//a',
  });

  public readonly GiftCardItemDetailLabel = () => this.derived({
    Desktop: '//h3[@class="OrderItem_upper__sCF6V"]',
  });

  public readonly GiftCardItemDetailImg = () => this.derived({
    Desktop: '//div[@class="OrderItem_item__1WW5a"][1]//a',
  });

  public readonly GiftCardTableAsPaymentItem = () => this.derived({
    Desktop: '//table[contains(@class, "Summary_paymentTable")]',
  });

  public readonly GiftCardAsPaymentItem = (text: string) => this.derived({
    Desktop: `//table[contains(@class, "Summary_paymentTable")]//tr[contains(@class, "lineItem")]//td[contains(., "${text || ''}")]`,
  });

  public readonly GiftCardInPaymentStatus = (text?: string) => this.derived({
    Desktop: `//div[contains(@class, "details-box--payment-status")]//div[contains(@class, "lineItem heading")]//span[contains(., "${text || ''}")]`,
  });

  public readonly GoodWillDivForGiftCardAsItemLevel = (text?: string) => this.derived({
    Desktop: `//div[contains(@class, "MuiPaper-root details-box MuiPaper-elevation1 MuiPaper-rounded")][2]//div//div//div[contains(.,"${text || ''}")]`,
  });

  public readonly GoodWillDivForGiftCardAsOrderLevel = (text?: string) => this.derived({
    Desktop: `//*[@id="__next"]/div/div/div/main/div/div[3]/div[contains(., "${text || ''}")]`,
  });

  public readonly OrderPaymentInformation = (text?: string) => this.derived({
    Desktop: `//table[contains(@class, "Summary_paymentTable")]//tbody//tr//td[contains(., "${text || ''}")]`,
  });
}
