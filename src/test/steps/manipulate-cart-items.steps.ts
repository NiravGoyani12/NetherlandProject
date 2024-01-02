import { When } from '@pvhqa/cucumber';
import services from '../../core/services';

When(/I clear shopping bag for the registered user of this locale/, async () => {
  const locale = services.site.locale.toLowerCase();
  const email = `pvh.${locale}.automation@outlook.com`;
  await services.maniPulateCartItemsDB.clearItemsFromSB(email);
});

When(/I fetch from the DB the quantity of product item ([^\s]+) and store it with key (#[A-Za-z0-9]+)/, async (skuPartNumber: string, key: string) => {
  skuPartNumber = services.world.parse(skuPartNumber);
  skuPartNumber = services.product.parse(skuPartNumber);
  const qty = await services.maniPulateCartItemsDB.getItemInventory(skuPartNumber);
  services.world.store(key, qty);
});

When(/I update in the DB the quantity of product item ([^\s]+) to ([^\s]+)/, async (skuPartNumber: string, qty: string) => {
  skuPartNumber = services.world.parse(skuPartNumber);
  skuPartNumber = services.product.parse(skuPartNumber);

  if (qty.indexOf('#') === 0) {
    qty = services.world.parse(qty);
  }

  await services.maniPulateCartItemsDB.setItemInventory(skuPartNumber, Number(qty));
});

When(/I (activate|deactivate) promocode "([^\s]+)" in the DB/, async (actionType: string, promoCode: string) => {
  let status: number;
  if (actionType === 'deactivate') {
    status = 0;
  } else {
    status = 1;
  }
  if (promoCode.indexOf('#') === 0) {
    promoCode = services.world.parse(promoCode);
  }

  await services.maniPulateCartItemsDB.setPromoCodeStatus(promoCode, status);
});
