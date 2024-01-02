/* eslint-disable max-len */
import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class Header extends Page {
  public readonly MainBlock = () => this.derived({
    Desktop: '//header[contains(@class,"header")] | //header[@data-testid="Header-component"]',
  });

  public readonly Logo = () => this.derived({
    Desktop: '//a[contains(@class, "Header_LogoWrapperTransparent__q6NhX") and @data-testid="brand-logo"] | //a[contains(@class, "Header_LogoWrapper__uagdR") and @data-testid="brand-logo"]',
  });

  public readonly CategorySelectButton = () => this.derived({
    Desktop: '//*[@data-testid="MM-first-level-link" and contains(text(),\'Women\')]',
    Mobile: '//div[@class="mega-menu--wrapper"]//button[contains(@class,"header-search__input-container__button")]',
  });

  public readonly SearchField = () => this.derived({
    Desktop: '//header[@data-testid="Header-component"]//input[contains(@data-testid,"searchInputHeaderDesktop-inputField")]',
    Mobile: '//input[contains(@data-testid, "searchInputMegaMenuMobile-inputField")]',
  });

  public readonly SearchFieldInputLabelText = () => this.derived({
    Desktop: '//header[@data-testid="Header-component"]//span[@data-testid="searchInputHeaderDesktop-inputLabelText"]',
    Mobile: '//header[@data-testid="Header-component"]//span[@data-testid="searchInputMegaMenuMobile-inputLabelText"]',
  });

  public readonly SearchIcon = () => this.derived({
    Desktop: '//header[@data-testid="Header-component"]//button[@data-testid="SearchIcon-pvh-icon-button"]',
  });

  public readonly ClearSearchButton = () => this.derived({
    Desktop: '//*[@data-testid="ClearSearchButton"]',
  });

  public readonly ClearSearchText = () => this.derived({
    Desktop: '//*[@data-testid="ClearSearchButton"]/span',
  });

  public readonly HeaderSearchContainer = () => this.derived({
    Desktop: '//div[contains(@class, "Header_SearchFieldContainer")]',
  });

  public readonly SearchFieldContainer = () => this.derived({
    Desktop: '//header[@data-testid="Header-component"]//div[contains(@data-testid,"pvh-InputField")]',
  });

  public readonly MegaMenuFirstLevelItems = (index?: number) => this.derived({
    Desktop: `(//ul[@data-testid="pvh-List"]//li[@data-testid="MM-first-level-item"])${index ? `[${index}]` : ''}/a`,
  });

  public readonly MegaMenuFirstLevelItemsByText = (text?: string) => this.derived({
    Desktop: `//*[@data-testid="MM-first-level-link" and contains(text(),'${text}')]`,
  });

  public readonly MegaMenuSecondLevelItems = (text?: string) => this.derived({
    Desktop: `//li[contains(@class, 'MegaMenu_Active')]//*[@data-testid="Second-level-menu-link"]//*[contains(text(),'${text}')]`,
    Mobile: `//li[contains(@class, 'MegaMenu_Active')]//*[@data-testid='header-mobile-menu-trigger']//span[contains(@class,'fadeInRight_fadeInRight') and contains(text(),'${text || ''}')]`,
  });

  public readonly MegaMenuSecondLevelItemsWithThirdLevelItems = (text?: string) => this.derived({
    Mobile: `//li[contains(@class, 'MegaMenu_Active')]//*[@data-testid='header-mobile-menu-trigger']//span[contains(@class,'fadeInRight_fadeInRight') and contains(text(),'${text || ''}')]//following-sibling::span[@data-testid="icon-expand-collapsed"]`,
  });

  public readonly MegaMenuSecondLevelItemNonGender = (text?: string) => this.derived({
    Desktop: `//li[contains(@class, 'MegaMenu_Active')]//*[@data-testid="MM-second-level-item" and not(@data-active="false")]//*[@data-testid="Second-level-menu-link"]//*[contains(text(),'${text}')]`,
  });

  public readonly MegaMenuSecondLevelItemNonGenderByIndex = (index?: number) => this.derived({
    Desktop: `(//li[contains(@class, 'MegaMenu_Active')]//*[@data-testid="MM-second-level-item" and not(@data-active="false")])${index ? `[${index}]` : ''}`,
  });

  public readonly MegaMenuSecondLevelItemsByIndex = (index?: number) => this.derived({
    Desktop: `(//li[contains(@class, 'MegaMenu_Active')]//*[@data-testid='MM-second-level-item'])${index ? `[${index}]` : ''}`,
    Mobile: `(//li[contains(@class, 'MegaMenu_Active')]//*[@data-testid='header-mobile-menu-trigger'])${index ? `[${index}]` : ''}`,
  });

  public readonly MegaMenuSecondLevelContentLinks = (text?: string) => this.derived({
    Desktop: `//li[@data-active="true"]//*[contains(@data-testid,"MM-CategoryHeading")]//following-sibling::li/a[contains(text(), "${text}")] | //li[@data-active="true"]//*[@data-testid="ThirdLevelCollection-desktop"]//a[contains(text(), "${text}")]`,
  });

  public readonly MegaMenuSecondLevelNonGenderContentLinks = (text?: string) => this.derived({
    Desktop: `(//li[@data-active="true"]//*[contains(@data-testid,"SecondLevelCategories-pvh-List")]/li//li/a[contains(text(), "${text}")])[1] | //li[@data-active="true"]//*[@data-testid="ThirdLevelCollection-desktop"]//a[contains(text(), "${text}")]`,
  });

  public readonly MegaMenuThirdLevelItems = (text?: string, index?: number) => this.derived({
    Desktop: '//*[contains(@data-testid,"MM-CategoryHeading")]//following-sibling::li',
    Mobile: `(//*[@data-testid='mega-menu-third-level-secondary-nav' and ${text ? `contains(text(), ${text})` : ''}])${index ? `[${index}]` : ''}`,
  });

  public readonly MegaMenuThirdLevelItemsByIndex = (secondLevelIndex?: number, index?: number) => this.derived({
    Desktop: `((//*[@data-testid="Sub-MegaMenu"])[${secondLevelIndex}]//*[contains(@data-testid,"MM-CategoryHeading")]//following-sibling::li)${index ? `[${index}]` : ''}`,
  });

  public readonly MegaMenuThirdLevelLinks = (index?: number) => this.derived({
    Desktop: `(//*[contains(@data-testid,"MM-CategoryHeading")]//following-sibling::li/a)${index ? `[${index}]` : ''}`,
  });

  public readonly MegaMenuThirdLevelHrefByIndex = (href?: string, index?: number) => this.derived({
    Desktop: `(//*[contains(@data-testid,"MM-CategoryHeading")]//following-sibling::li//a[contains(@href,"${href || ''}")])${index ? `[${index}]` : ''}`,
    Mobile: `(//ul[@class="third-level-collection-item"]//a[contains(@href,"${href || ''}")])${index ? `[${index}]` : ''}`,
  });

  public readonly MegaMenuThirdLevelCategoryHeading = (text?: string) => this.derived({
    Mobile: `//li[contains(@class, 'MegaMenu_Active')]//*[@data-testid='header-mobile-menu-trigger' and @aria-expanded='true']//parent::h6//parent::div//a[contains(text(), '${text}')]`,
  });

  public readonly SecondaryNavigationLinks = () => this.derived({
    Mobile: '(//li[@data-testid="MM-first-level-item"])[1]//div[@data-testid="SecondaryNavigation"]/li',
  });

  public readonly MegaMenuSecondLevelItemWithNextLevel = (text?: string) => this.derived({
    Desktop: '//*[@id="MM-second-level"]/li/div/a[following-sibling::div]',
    Mobile: `//li[contains(@class, '--active')]//a[contains(@class, 'external-link link mega-menu__second-level-link')]/span${text ? `[contains(text(), ${text})]` : ''}`,
  });

  public readonly MegaMenuOpenSecondLevel = () => this.derived({
    Desktop: '//ul[@data-testid="MM-second-level"]/li//a[span]',
    Mobile: '//li[contains(@class,"--active")]//ul[@class="mega-menu__second-level"]/li[contains(@class, "--active")]/a',
  });

  public readonly HamburgerMenuOpen = () => this.derived({
    Mobile: '//button[@data-testid="pvh-icon-button" and contains(@class,"HomeSearchMobile")] | //button[contains(@class,"mega-menu__toggle")] | //div[@data-testid="navigation"]//input[@id="nav__toggle"] | //*[@data-testid="header-home-search-pvh-icon-button"]',
  });

  public readonly HamburgerMenuClose = () => this.derived({
    Mobile: '(//button[@data-testid="pvh-icon-button"])[1] | //button[contains(@class,"mega-menu__close")]',
  });

  // #region Wishlist
  public readonly WishListIcon = () => this.derived({
    Desktop: '//*[@data-testid="wishlist-IconWithBadge-component"]',
  });

  public readonly WishListCounter = (args: string[]) => this.derived({
    Desktop: `//div[@data-testid="wishlist-IconWithBadge-component"]//span[contains(text(), "${args || ''}")]`,
  });

  public readonly ActiveWishListIcon = () => this.derived({
    Desktop: '//*[contains(@class,"Wishlist") and contains(@class,"BadgeFilled")and @data-testid="wishlist-IconWithBadge-component"]',
  });

  public readonly MegaMenuOverlay = () => this.derived({
    Mobile: '//div[@data-testid="Mobile-header-controls"]',
  });

  public readonly MegaMenuOverlayLogo = () => this.derived({
    Mobile: '//a[@data-testid="brand-logo" and preceding-sibling::button]',
  });

  public readonly UnifiedSearchContainer = () => this.derived({
    Desktop: '//div[contains(@data-testid,"searchContainer")]',
  });

  public readonly UnifiedSearchField = () => this.derived({
    Desktop: '//form[@data-testid="searchForm"]//input[@id="searchTerm"]',
  });

  public readonly UnifiedSearchInputLabelText = () => this.derived({
    Desktop: '//span[@data-testid="searchInputHeaderDesktop-inputLabelText"]',
  });
  // #endregion

  // #region Shopping bag
  public readonly ShoppingBagButton = () => this.derived({
    Desktop: '//*[@data-testid="basket-IconWithBadge-component"]',
  });

  public readonly ShoppingBagCounter = () => this.derived({
    Desktop: '//div[@data-testid="basket-IconWithBadge-component"]//span',
  });

  public readonly ShoppingBasketIcon = () => this.derived({
    Desktop: '//*[@data-testid="icon-utility-basket-svg"]',
  });
  // #endregion

  // #region Account
  public readonly SignInButton = () => this.derived({
    Desktop: '//button[@data-testid="HeaderAccount-signin-button"]',
    Mobile: '//li[@data-testid="SecondaryNavigation-sl-sign-in-or-register"]//*[@data-testid="SecondaryNavigationItem"]//button',
  });

  public readonly MyAccountButton = (index?: number) => this.derived({
    Desktop: '//button[@data-testid="HeaderAccount-myaccount-button"]',
    Mobile: `(//*[@data-testid="SecondaryNavigation-myAccount"]//button[@data-testid="header-mobile-menu-trigger"])${index ? `[${index}]` : ''}`,
  });

  public readonly StoreLocator = (index?: number) => this.derived({
    Mobile: `(//li[@data-testid="SecondaryNavigation-header-store-locator"]//*[@data-testid="header-mobile-menu-trigger"])${index ? `[${index}]` : ''}`,
  });

  public readonly CustomerService = (index?: number) => this.derived({
    Mobile: `(//li[@data-testid="SecondaryNavigation-customerserviceview"]//*[@data-testid="header-mobile-menu-trigger"])${index ? `[${index}]` : ''}`,
  });

  public readonly SignOutButton = (index?: number) => this.derived({
    Desktop: '//button[@data-testid="HeaderAccount-signin-button"]',
    Mobile: `(//*[@data-testid="mega-menu-third-level-sign-out"])${index ? `[${index}]` : ''}`,
  });
  // #endregion

  public readonly OnBehalfText = () => this.derived({
    Desktop: '//div[@data-testid="CsrHeader-component"]/div[2]/span',
  });

  public readonly ReturnToCsr = () => this.derived({
    Desktop: '//div[@data-testid="CsrHeader-component"]/div/a',
  });
  // #region Espot

  public readonly EspotImage = () => this.derived({
    Desktop: '//*[@data-testid="pvh-List" and contains(@class,"Espot")]//a/img',
  });

  public readonly EspotTitle = () => this.derived({
    Desktop: '//*[@data-testid="pvh-List" and contains(@class,"Espot")]//a[contains(@class,"EspotTitle")]',
  });
  // #endregion

  // #Region country switch
  public readonly CountrySwitchIcon = () => this.derived({
    Desktop: '//button[@data-testid="pvh-icon-button"]//*[@data-testid="icon-globe-svg"]',
  });

  // #endregion
}
