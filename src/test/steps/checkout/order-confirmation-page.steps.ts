import { Then } from '@pvhqa/cucumber';
import Checkout from '../../pages/checkout';

Then(/I see Order Confirmation Page with my delivery details(:? with index "(.*)")?/, async (index?: number) => {
  await Checkout.OrderConfirmation.CheckAddressDetails('confirmation', index);
});
