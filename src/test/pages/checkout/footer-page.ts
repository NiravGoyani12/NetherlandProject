import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class FooterPage extends Page {
  // #region Links
  public readonly FooterLink = (index: number) => this.derived({
    Desktop: `(//div[@data-testid="checkout-footer"]//a)[${index || 1}]`,
  });

  public readonly CustomerServiceText = () => this.derived({
    Desktop: '//div[@data-testid="THCustomerServicePage-text-section" or @class ="LegalPagesCollectionArticle"]',
  });
}
