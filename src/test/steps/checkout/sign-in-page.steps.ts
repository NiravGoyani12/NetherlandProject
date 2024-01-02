import { When } from '@pvhqa/cucumber';
import services from '../../../core/services';
import { GetTestLogger } from '../../../core/logger/test.logger';
import { exist$ } from '../../general';

When(/I store the cartId/, async () => {
  const cartId = await browser.waitUntilResult(async () => {
    const result = await browser.execute('return digitalData.cart.cartId');
    return result;
  }, 'The digitalData card cart Id does not exist', 10000, 1000);
  services.world.store('#cartId', cartId);
  GetTestLogger().info(`The cart id is: ${cartId}`);
});

// TODO: will be removed in the future. Only used for Adyen test
When(/in sign in page I store the scenario name (.*)/, async (text: string) => {
  GetTestLogger().info(`Scenario name is: ${text}`);
});

// TODO: will be removed in the future. Only used for Adyen test
When(/in sign in page I store the payment type (.*)/, async (text: string) => {
  GetTestLogger().info(`Payment type is: ${text}`);
});

// TODO: will be removed in the future. Only used for Adyen test
When(/in sign in page I store if SAP Auto is needed (.*)/, async (text: string) => {
  GetTestLogger().info(`SAP Auto: ${text}`);
});

When(/in sign in page I ensure login is visible/, async () => {
  if (services.env.IsMobile && services.env.Brand === 'ck') {
    const signInShowButton = await exist$('Checkout.SignInPage.SignInShowButton');
    await signInShowButton.safeClick();
  }
});
