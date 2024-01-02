import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';
import { exist$, maybeDisplayed$ } from '../../general';

@Singleton
export default class PlpHeader extends Page {
  public ProductGridItems = (index?: number) => this.derived({
    Desktop: `(//li[@data-testid="ProductGrid-item-GridItem"]//a)${index ? `[${index}]` : ''}`,
  });

  public ProductCount = () => this.derived({
    Desktop: '//p[@data-testid="ProductListHeader-Count"]',
  });

  public readonly PageHeader = () => this.derived({
    Desktop: '(//h1[@data-testid="ProductListHeader-Title"]) | (//h2[@data-testid="ProductListHeader-Title"])',
  });

  public readonly CatalogHeading = () => this.derived({
    Desktop: '[data-testid="ProductListHeader-Title"]',
  });

  public readonly CategoryNavigationBlock = () => this.derived({
    Desktop: '//div[contains(@class,"more_for_you")]|//*[@data-testid="MoreForYou-component"]',
  });

  public readonly CategoryNavigationItem = (index?: number) => this.derived({
    Desktop: `(//*[@data-testid="MoreForYouItem"])${index ? `[${index}]` : ''}`,
  });

  public isLoaded = async (): Promise<boolean> => {
    const productCount = await exist$(this.ProductCount());
    await productCount.waitForDisplayed({ timeout: 10000 });
    await productCount.jsClick();
    const isPageLoaded = !!(await maybeDisplayed$(this.ProductCount()));
    return isPageLoaded;
  };
}
