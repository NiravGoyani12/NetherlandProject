import { Given } from '@pvhqa/cucumber';
import services from '../../core/services';

Given(/I extract (product|product style|product item)? detail by (?:product|style colour|sku) part number (.*)/, async (detailType: string, partNumber: string) => {
  partNumber = services.world.parse(partNumber);
  partNumber = services.product.parse(partNumber);
  if (detailType === 'product style') {
    await services.product.productStyle.fetchProductStyleDetail(partNumber);
  } else if (detailType === 'product item') {
    await services.product.productItem.fetchProductItemDetail(partNumber);
  } else {
    await services.product.product.fetchProductDetail(partNumber);
  }
});
