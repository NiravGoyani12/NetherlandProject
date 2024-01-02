import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class PartnerOrdersPage extends Page {
  public readonly ClearButton = () => this.derived({
    Desktop: '//button[@data-qa="button-search-clear"]',
  });

  public readonly SearchButton = () => this.derived({
    Desktop: '//button[@data-qa="button-search-submit"]',
  });

  public readonly OrderNumberRequiredError = (text?: string) => this.derived({
    Desktop: `//div[@data-qa="text-search-error" and contains(., "${text ?? ''}")]`,
  });

  public readonly InvalidOrderNumberError = () => this.derived({
    Desktop: '//p[contains(@class, "Mui-error")]',
  });
}
