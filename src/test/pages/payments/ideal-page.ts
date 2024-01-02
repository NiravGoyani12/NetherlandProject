import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';
import { exist$ } from '../../general';
import services from '../../../core/services';
import { GetTestLogger } from '../../../core/logger/test.logger';

@Singleton
export default class IdealPage extends Page {
  public readonly ConfirmTransaction = () => this.derived({
    Desktop: '//button[contains(text(),"Complete")] | //input[@value="Continue"]',
  });

  public async Pay() {
    GetTestLogger().info(services.env.Site);
    await (await exist$(this.ConfirmTransaction())).safeClick();
  }
}
