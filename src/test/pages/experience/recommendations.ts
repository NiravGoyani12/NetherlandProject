import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';
@Singleton
export default class Recommendations extends Page {
  public readonly RecoForYouItem = (index?: number) => this.derived({
    Desktop: `((//article[@data-testid="Recommendations-component-pdp_rec_injection2"]//div[@data-testid="ProductTile-component"]))${index ? `[${index}]` : ''}`,
  });

  public readonly MatchedItem = (index?: number) => this.derived({
    Desktop: `((//article[@data-testid="Recommendations-component-pdp_rec_injection1"]//div[@data-testid="ProductTile-component"]))/a${index ? `[${index}]` : ''}`,
  });

  public readonly RecentlyViewedItem = (index?: number) => this.derived({
    Desktop: `((//article[@data-testid="Recommendations-component-pdp_rec_injection3"]//div[@data-testid="ProductTile-component"]))${index ? `[${index}]` : ''}`,
  });

  public readonly RecoProductName = (index?: number) => this.derived({
    Desktop: `(//article[@data-testid="Recommendations-component-nosearch_rec_injection1"]//div[@data-testid="ProductTile-component"]//div//h3)${index ? `[${index}]` : ''}`,
  });

  public readonly RecoProductLink = (index?: number) => this.derived({
    Desktop: `(//article[@data-testid="Recommendations-component-nosearch_rec_injection1"]//div[@data-testid="ProductTile-component"]//a)${index ? `[${index}]` : ''}`,
  });

  public readonly XoWishlistIcon = (index?: number) => this.derived({
    Desktop: `(//*[@data-testid="CarouselItem"]//*[@data-testid="WishListAdornment-component"]//button)${index ? `[${index}]` : ''}`,
  });

  // #region shopping basket recommendation
  public readonly RecoShoppingBasketSection = () => this.derived({
    Desktop: '[data-testid="Recommendations-component-cart_rec_injection1"]',
  });

  public readonly RecoShoppingBasketItem = (styleColourPartNumber?: string) => this.derived({
    Desktop: `//*[@data-testid="CarouselItem"]//*[@data-partnumber='${styleColourPartNumber ? styleColourPartNumber.toUpperCase() : ''}']`,
    // Desktop: '//*[@data-testid="ProductTile-component"]',
  });

  public readonly RecoShoppingBasketItemImage = (styleColourPartNumber?: string) => this.derived({
    Desktop: `//*[@data-testid="CarouselItem"]//*[@data-partnumber='${styleColourPartNumber ? styleColourPartNumber.toUpperCase() : ''}']//a`,
    // Desktop: '//*[@data-testid="ProductTile-component"]',
  });

  public readonly RecoShoppingBasketItemByIndex = (index?: number) => this.derived({
    Desktop: `(//*[@data-testid="CarouselItem"]//*[@data-testid='ProductTile-component']/a)${index ? `[${index}]` : ''}`,
  });

  public readonly RecoShoppingBasketCarouselNextButton = () => this.derived({
    Desktop: '//*[@data-testid="carousel-arrow-nav"]//*[contains(@class,"Next")]',
  });

  public readonly RecoShoppingBasketCarouselPreviousButton = () => this.derived({
    Desktop: '//*[@data-testid="carousel-arrow-nav"]//*[contains(@class,"Prev")]',
  });

  public readonly RecoShoppingBasketWishlistBtn = (styleColourPartNumber?: string) => this.derived({
    Desktop: `//*[@data-testid="CarouselItem"]//*[@data-partnumber='${styleColourPartNumber ? styleColourPartNumber.toUpperCase() : ''}']//*[@data-testid="icon-utility-wishlist-svg"]`,
  });

  public readonly RecoShoppingBasketAddToBagBtn = (styleColourPartNumber?: string) => this.derived({
    Desktop: `//*[@data-testid="CarouselItem"]//*[@data-partnumber='${styleColourPartNumber ? styleColourPartNumber.toUpperCase() : ''}']//button[contains(@data-testid,'${styleColourPartNumber.toUpperCase()}')]`,
  });

  // eslint-disable-next-line max-len
  public readonly OpenSizeDropdownContainer = (injectionId: string, styleColourPartNumber?: string) => this.derived({
    Desktop: `//article[contains(@data-testid, "${injectionId}")]//div[@data-partnumber='${styleColourPartNumber}']//ul[@class="isMenuOpened"]`,
  });

  // eslint-disable-next-line max-len
  public readonly EditSizeDropdown = (styleColourPartNumber?: string, text?: string) => this.derived({
    Desktop: {
      dropdownSelector: `//*[@data-testid="CarouselItem"]//*[@data-partnumber='${styleColourPartNumber ? styleColourPartNumber.toUpperCase() : ''}']//*[@data-testid="Recommendations-size-selectInput-inputField"]`,
      optionSelector: `//*[@data-testid="CarouselItem"]//*[@data-partnumber='${styleColourPartNumber ? styleColourPartNumber.toUpperCase() : ''}']//*[@data-testid="select-component-options-list"]//li[contains(text(),normalize-space("${text.toUpperCase()}"))]`,
    },

    Mobile: {
      dropdownSelector: `//*[@data-testid="CarouselItem"]//*[@data-partnumber='${styleColourPartNumber ? styleColourPartNumber.toUpperCase() : ''}']//*[@data-testid="Recommendations-size-select-select-component"]`,
      optionSelector: `//*[@data-testid="CarouselItem"]//*[@data-partnumber='${styleColourPartNumber ? styleColourPartNumber.toUpperCase() : ''}']//*[@data-testid="Recommendations-size-select-native-select"]//*[contains(text(),normalize-space("${text.toUpperCase()}"))]`,
    },
  });

  public readonly RecoForYouSection = () => this.derived({
    Desktop: '//article[@data-testid="Recommendations-component-pdp_rec_injection2"]',
  });

  public readonly MatchingItemsSection = () => this.derived({
    Desktop: '//article[@data-testid="Recommendations-component-pdp_rec_injection1"]',
  });

  public readonly RecentlyViewedSection = () => this.derived({
    Desktop: '//article[@data-testid="Recommendations-component-pdp_rec_injection3"]',
  });

  public readonly AddToCartButtonByStyleColour = (
    injectionId: string, styleColourPartNumber?: string,
  ) => this.derived({
    Desktop: `//article[contains(@data-testid, "${injectionId}")]//div[@data-partnumber='${styleColourPartNumber.toUpperCase()}']//button[contains(@data-testid,'${styleColourPartNumber.toUpperCase()}')]`,
  });

  // #region Search - No search result Recommendations
  public readonly RecoNoSearchSection = () => this.derived({
    Desktop: '//article[@data-testid="Recommendations-component-nosearch_rec_injection1"]',
  });

  public readonly RecoNoSearchItem = () => this.derived({
    Desktop: '//*[@data-testid="Carousel-component"]//*[@data-testid="ProductTile-component"]',
  });

  public readonly RecoNoSearchAddToBagBtn = () => this.derived({
    Desktop: '//*[contains(@data-testid,"Recommendations-add-button-nosearch")]',
  });

  // end region

  // PLP xo recommedations
  public readonly PlpRecoForYouItem = (index?: number) => this.derived({
    Desktop: `((//article[@data-testid="Recommendations-component-plp_rec_injection2"]//div[@data-testid="ProductTile-component"]))${index ? `[${index}]` : ''}`,
  });

  public readonly PlpMatchedItem = (index?: number) => this.derived({
    Desktop: `((//article[@data-testid="Recommendations-component-plp_rec_injection3"]//div[@data-testid="ProductTile-component"]))/a${index ? `[${index}]` : ''}`,
  });

  public readonly PlpRecentlyViewedItem = (index?: number) => this.derived({
    Desktop: `((//article[@data-testid="Recommendations-component-plp_rec_injection1"]//div[@data-testid="ProductTile-component"]))${index ? `[${index}]` : ''}`,
  });

  // Markdown flag
  public readonly RecoMakrdownFlag = () => this.derived({
    Desktop: '//*[@data-testid="ProductLabel-component"]//span[contains(@class,\'discount\')]',
  });

  // Shop All Link
  public readonly XoShopAllLink = () => this.derived({
    Desktop: '//*[contains(@data-testid,"Recommendations-component")]//a[@data-testid="pvh-button" and contains(@class,shopAll)]',
  });
}
