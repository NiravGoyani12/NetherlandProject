import { When } from '@pvhqa/cucumber';
import {
  p$, exist$,
} from '../../general';
import WishListPage from '../../pages/experience/wishlist';
import services from '../../../core/services';
import { DropdownSelector } from '../../../core/constents';
import { sleep } from '../../helper/utils.helper';

const Wlp = p$(WishListPage);

When(/in unified wishlist page I select sizes? based on product item ([^\s]+)/, async (skuPartNumber: string) => {
  skuPartNumber = services.world.parse(skuPartNumber);
  skuPartNumber = services.product.parse(skuPartNumber);
  const productItem = await services.product.productItem.getDetail(skuPartNumber);
  let size = productItem.WIDTH_NAME;
  if (productItem.WIDTH_NAME) {
    if (productItem.WIDTH_NAME.search(/\d/) > 0) {
      size = productItem.WIDTH_NAME.substring(productItem.WIDTH_NAME.search(/\d/));
    }
  }
  if (productItem.LENGTH_NAME && productItem.WIDTH_NAME) {
    let lengthNoCountryCode = productItem.LENGTH_NAME;
    let widthNoCountryCode = productItem.WIDTH_NAME;
    if (productItem.LENGTH_NAME.search(/\d/) > 0) {
      lengthNoCountryCode = productItem.LENGTH_NAME.substring(productItem.LENGTH_NAME.search(/\d/));
    }
    if (productItem.WIDTH_NAME.search(/\d/) > 0) {
      widthNoCountryCode = productItem.WIDTH_NAME.substring(productItem.WIDTH_NAME.search(/\d/));
    }
    size = `${widthNoCountryCode} x ${lengthNoCountryCode}`;
  }

  const dropdown = Wlp.EditSizeDropdown(
    productItem.STYLECOLOUR_PARTNUMBER,
    productItem.SIZE_NAME || size || productItem.LENGTH_NAME,
  ) as DropdownSelector;

  if (productItem.SIZE_NAME
    && (productItem.SIZE_NAME.toLowerCase() === 'one size' || productItem.SIZE_NAME.toLowerCase() === 'os')
  ) {
    return;
  }
  if (services.env.IsMobile) {
    const selector = await services.pageObject.getSelector('Experience.Wishlist.DisabledAddToBagButton');
    const element = await exist$(selector);
    if (element) {
      await element.safeClick();
    }
  }
  const sizeDropdown = await exist$(dropdown.dropdownSelector);
  await sizeDropdown.selectDropdown(dropdown.optionSelector);
  await sleep(500);
});
