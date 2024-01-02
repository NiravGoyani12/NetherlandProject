/* eslint-disable max-len */
import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class CountrySwitchFlyout extends Page {
  public readonly MainBlock = () => this.derived({
    Desktop: '//*[@data-testid="pvh-account-drawer-Modal-component"]',
  });

  public readonly Logo = () => this.derived({
    Desktop: '//*[@data-testid="pvh-account-drawer-Modal-component"]//input[@data-testid="countryInput-inputField"]',
  });

  // #region Country selection
  public readonly CountrySelectSection = () => this.derived({
    Desktop: '//*[@data-testid="pvh-account-drawer-Modal-component"]//div[@data-testid="LocaleSelect-component"]',
  });

  public readonly CountryDropdown = (text?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//*[@data-testid="pvh-account-drawer-Modal-component"]//label[@data-testid="country-select"]',
      optionSelector: `//*[@data-testid="pvh-account-drawer-Modal-component"]//*[@data-testid="country-select-component"]//ul//li[contains(.,"${text || ''}")]`,
    },
  });

  public readonly LanguageDropdown = (text?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//*[@data-testid="pvh-account-drawer-Modal-component"]//label[@data-testid="lang-select"]',
      optionSelector: `//*[@data-testid="pvh-account-drawer-Modal-component"]//*[@data-testid="language-select-component"]//ul//li[contains(.,"${text || ''}")]`,
    },
  });

  public readonly CountrySwitchButton = () => this.derived({
    Desktop: '//*[@data-testid="pvh-account-drawer-Modal-component"]//*[@data-testid="pvh-button" and contains(@class,"Locale")]',
  });

  public readonly CountryDropdownOpen = () => this.derived({
    Mobile: '//*[@data-testid="pvh-account-drawer-Modal-component"]//div[@data-testid="LocaleSelect-component"]//*[@data-testid="footer-mobile-menu-trigger"]',
  });
  // #endregion
}
