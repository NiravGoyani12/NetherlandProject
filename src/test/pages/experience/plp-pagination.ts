import { Singleton } from 'typescript-ioc';
import { exist$, maybeDisplayed$ } from '../../general';
import { Page } from '../../page';

@Singleton
export default class PlpPagination extends Page {
  public readonly ViewedOfItems = () => this.derived({
    Desktop: '//div[@data-testid="pagination-label"] | //div[@data-testid="Pagination-item-count"]',
  });

  public readonly PreviousButton = () => this.derived({
    Desktop: '//div[@data-testid="catalog-pagination"]//a[@data-testid="previous-page"] | //*[@data-testid="PaginationButton-prev-pvh-button"]',
  });

  public readonly CurrentPageNumber = () => this.derived({
    Desktop: '//span[@data-testid="Pagination-current-page"]',
  });

  public readonly TotalPageCount = () => this.derived({
    Desktop: '//span[@data-testid="Pagination-total-page"]',
  });

  public readonly NextButton = () => this.derived({
    Desktop: '//div[@data-testid="catalog-pagination"]//a[@data-testid="next-page"] | //*[@data-testid="PaginationButton-next-pvh-button"]',
  });

  public readonly MobileExposedSearchBar = () => this.derived({
    Desktop: '//*[@data-testid="searchInputHeaderMobile-inputField"]',
  });

  public readonly MobileBurgerMenuWithSearchIcon = () => this.derived({
    Desktop: '//*[@data-testid="icon-home-search-svg"]',
  });

  public readonly MobileBurgerMenuWithoutSearchIcon = () => this.derived({
    Desktop: '//*[@data-testid="icon-utility-burger-svg"]',
  });

  public isLoaded = async (): Promise<boolean> => {
    const totalPageCount = await exist$(this.TotalPageCount());
    await totalPageCount.waitForDisplayed({ timeout: 10000 });
    await totalPageCount.jsClick();
    const isPageLoaded = !!(await maybeDisplayed$(this.TotalPageCount()));
    return isPageLoaded;
  };
}
