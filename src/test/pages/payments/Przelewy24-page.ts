import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';
import { exist$ } from '../../general';
import services from '../../../core/services';
import { GetTestLogger } from '../../../core/logger/test.logger';

@Singleton
export default class Przelewy24Page extends Page {
  public readonly AcceptTransactionButton = () => this.derived({
    Desktop: '//input[@id="submit_success"] | //input[@class="thank-you-page-button"] | //div[@class="button button--size-m button--gray"]',
  });

  public readonly SubmitButton = () => this.derived({
    Desktop: '//button[@id="user_account_pbl_correct"]',
  });

  public readonly PendingButton = () => this.derived({
    Desktop: '//button[@id="user_account_pbl_pending"]',
  });

  public readonly CancelTransactionButton = () => this.derived({
    Desktop: '//button[@id="user_account_pbl_noPayment"]',
  });

  public async Pay() {
    GetTestLogger().info(services.env.Site);
    // const Przelewy24Button = await exist$(this.AcceptTransactionButton() as string);
    const Przelewy24Button = await exist$(this.SubmitButton() as string);
    const isClickAble = await Przelewy24Button.waitForClickable({
      timeout: 8000,
      interval: 500,
    }).catch(() => false);
    if (isClickAble) {
      await Przelewy24Button.safeClick();
    } else {
      await Przelewy24Button.jsClick();
    }
    // await (await exist$(this.SubmitButton())).safeClick();
  }

  public async PendingPay() {
    GetTestLogger().info(services.env.Site);
    const Przelewy24Button = await exist$(this.PendingButton() as string);
    // const Przelewy24Button = await exist$(this.AcceptTransactionButton() as string);
    const isClickAble = await Przelewy24Button.waitForClickable({
      timeout: 8000,
      interval: 500,
    }).catch(() => false);
    if (isClickAble) {
      await Przelewy24Button.safeClick();
    } else {
      await Przelewy24Button.jsClick();
    }
    // await (await exist$(this.PendingButton())).safeClick();
  }

  public async CancelPay() {
    GetTestLogger().info(services.env.Site);
    await (await exist$(this.CancelTransactionButton())).safeClick();
  }
}
