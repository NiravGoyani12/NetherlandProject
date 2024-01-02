import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class Breadcrumbs extends Page {
  // PLP breadCrumbs
  public readonly CatalogHead = () => this.derived({
    Desktop: '//*[@data-testid="ProductListHeader-Title"]',
    Mobile: '//div[@data-testid="AppWrapper"]//span[@data-testid="catalog-heading__page-link"]//a',
  });

  public readonly BreadcrumbNavigationRegion = () => this.derived({
    Desktop: '//*[@data-testid="breadcrumbs__container-GridItem"]//nav',
  });

  public readonly BreadcrumbsItem = (index?: number) => this.derived({
    Desktop: `(//*[@data-testid="breadcrumbs__container-GridItem"]//nav//li/a)${index ? `[${index}]` : ''}`,
  });

  public readonly BreadcrumbsItemLast = () => this.derived({
    Desktop: '(//*[@data-testid="breadcrumbs__container-GridItem"]//nav//li/a)[last()]',
  });
}
