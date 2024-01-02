import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';
import { maybeDisplayed$ } from '../../general';

@Singleton
export default class PlpProducts extends Page {
  public readonly ProductGridItems = (index?: number) => this.derived({
    Desktop: `(//li[@data-testid="ProductGrid-item-GridItem"])${index ? `[${index}]` : ''}`,
  });

  public readonly ProductListContainer = () => this.derived({
    Desktop: '//ul[@data-testid="Grid-component"]',
  });

  public readonly ProductListItems = (index?: number) => this.derived({
    Desktop: `((//li[@data-testid="product-list-item"]/a) | (//li[contains(@class,"products__item")]/article/a) | (//a[@data-testid="ProductGrid_Item_Tile_Ssr_link"]))${index ? `[${index}]` : ''}`,
  });

  public readonly WishListIcon = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="WishListAdornment-component"]/button)${index ? `[${index}]` : ''}`,
  });

  public readonly ActiveWishListIcon = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="WishListAdornment-component"])${index ? `[${index}]` : ''}/button//*[@data-testid="icon-utility-wishlist-filled-svg"]`,
  });

  public readonly BreadcrumbItems = (text?: string) => this.derived({
    Desktop: `//li[contains(@class,'Breadcrumbs_BreadcrumbListItem')]//a[contains(text(),"${text}")]`,
  });

  public readonly ListingItems = (index?: number) => this.derived({
    Desktop: `(//li[contains(@class,"products__item")]/article/a | //li[@data-testid="ProductGrid-item-GridItem"]/a)${index ? `[${index}]` : ''}`,
  });

  public readonly ProductsPrice = (index?: number) => this.derived({
    Desktop: `(//span[@data-testid="PriceText"])${index ? `[${index}]` : ''}`,
  });

  public readonly ProductOldPrice = (index?: number) => this.derived({
    Desktop: `(//span[@data-testid="WasPriceText"])${index ? `[${index}]` : ''}`,
  });

  public readonly ProductTitles = () => this.derived({
    Desktop: '//h4[@data-testid="productTileHeading-typography-h4"]',
  });

  public readonly OnSaleCheckbox = () => this.derived({
    Desktop: '[data-testid="1-Checkbox-Component-icon"]',
  });

  public readonly PlpCurrentPageNum = () => this.derived({
    Desktop: '//span[@data-testid="Pagination-current-page"]',
  });

  public readonly ProductCarouselNextButton = () => this.derived({
    Desktop: '//button[@data-testid="product-tile-carousel-nav-next-pvh-icon-button"]',
  });

  public readonly ProductCarouselPrevButton = () => this.derived({
    Desktop: '//button[@data-testid="product-tile-carousel-nav-prev-pvh-icon-button"]',
  });

  public readonly ProductTileDots = (itemIndex?: number) => this.derived({
    Desktop: `${this.ListingItems(itemIndex)}//div[@data-testid="product-tile-dots-wrapper"]/button`,
  });

  public readonly ProductTileDotByIndex = (itemIndex: number, tileIndex: number) => this.derived({
    Desktop: `${this.ListingItems(itemIndex)}//div[@data-testid="product-tile-dots-wrapper"]/button[${tileIndex}]`,
  });

  public readonly ProductImages = (itemIndex?: number) => this.derived({
    Desktop: `${this.ListingItems(itemIndex)}//img`,
  });

  public readonly ProductImagesAltText = (itemIndex?: number) => this.derived({
    Desktop: `${this.ListingItems(itemIndex)}//img[@alt and string-length(@alt)!=0]`,
  });

  public readonly ProductImageByIndex = (itemIndex: number, imgIndex: number) => this.derived({
    Desktop: `(${this.ListingItems(itemIndex)}//img)[${imgIndex}]`,
  });

  public readonly BackToTopButton = () => this.derived({
    Desktop: '//button[@data-testid="BackToTopButton-button"]',
  });

  public readonly ProductDescription = () => this.derived({
    Desktop: '//div[@data-testid="html-content-component"]',
  });

  public readonly ProductDescriptionText = (text?: string) => this.derived({
    Desktop: `//div[@data-testid='html-content-component']/h1[contains(text(),'${text}')]`,
  });

  public readonly ProductDescriptionTextLinks = (href?: string) => this.derived({
    Desktop: `//div[@data-testid='html-content-component']/p/u/a[contains(@href,'${href}')]`,
  });

  public readonly ProductTopBanner = () => this.derived({
    Desktop: '//div[@data-testid="Promo-component"]/*[@data-testid="Promo-text"]',
  });

  public readonly ProductTopBannerLinks = () => this.derived({
    Desktop: '//*[@data-testid="cta-pvh-button"]/*[@class="Button_buttonContent__mX4nT"]',
  });

  public readonly ProductLabelSoldOut = () => this.derived({
    Desktop: '//div[contains(@class,"ProductTile_ProductTitleWrapper")]/ul[contains(@class,"sold")]',
  });

  public readonly ProductLabel = (text?: string) => this.derived({
    Desktop: `//div[@data-testid="ProductLabel-component"]/span[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), "${text.toLowerCase()}")]`,
  });

  public readonly ProductMoreColorText = (text?: string) => this.derived({
    Desktop: `//p[@data-testid="MoreColoursText-typography-p" and ${text ? `contains(text(), '${text.toLowerCase()}') or contains(text(), '${text}')` : ''}]`,
  });

  public isLoaded = async (): Promise<boolean> => {
    const isUnifiedPlp = !!(await maybeDisplayed$(this.ProductListItems()));
    const isSpaPage = !!(await maybeDisplayed$(this.ProductGridItems()));
    return isUnifiedPlp || isSpaPage;
  };
}
