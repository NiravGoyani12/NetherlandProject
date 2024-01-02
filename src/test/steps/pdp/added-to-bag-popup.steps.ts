import { Then } from '@pvhqa/cucumber';
import { expect } from 'chai';
import services from '../../../core/services';
import AddToBagPopup from '../../pages/experience/add-to-bag-pop-up';
import { p$, maybeDisplayed$ } from '../../general';
import { formatCurrency } from '../../helper/currency.helper';
import { sleep } from '../../helper/utils.helper';

const addToBagPopup = p$(AddToBagPopup);

Then(/in unified added to bag panel I see content is matched to product item by sku part number (.*)/, async (skuPartNumber: string) => {
  skuPartNumber = services.world.parse(skuPartNumber);
  skuPartNumber = services.product.parse(skuPartNumber);
  const productItemDetail = await services.product.productItem.getDetail(skuPartNumber);
  const commands = [
    maybeDisplayed$(
      addToBagPopup.ItemColour(productItemDetail.COLOUR_NAME),
    ),
  ];
  if (productItemDetail.SIZE_NAME) {
    commands.push(
      maybeDisplayed$(
        addToBagPopup.ItemSize(productItemDetail.SIZE_NAME),
      ),
    );
  } else if (productItemDetail.WIDTH_NAME && !productItemDetail.LENGTH_NAME) {
    commands.push(
      maybeDisplayed$(
        addToBagPopup.ItemSize(productItemDetail.WIDTH_NAME),
      ),
    );
  } else if (productItemDetail.WIDTH_NAME && productItemDetail.LENGTH_NAME) {
    commands.push(
      maybeDisplayed$(
        addToBagPopup.ItemSize(productItemDetail.WIDTH_NAME),
      ),
      maybeDisplayed$(
        addToBagPopup.ItemSize(productItemDetail.LENGTH_NAME),
      ),
    );
  } else {
    throw new Error(`Cannot identify the size of ${skuPartNumber}`);
  }

  if (productItemDetail.CURRENTPRICE) {
    const currentPrice = formatCurrency(productItemDetail.CURRENTPRICE, productItemDetail.CURRENCY);
    commands.push(
      maybeDisplayed$(
        addToBagPopup.PriceSelling(currentPrice),
      ),
    );
  }

  if (productItemDetail.WASPRICE && productItemDetail.WASPRICE !== productItemDetail.CURRENTPRICE) {
    const wasPrice = formatCurrency(productItemDetail.WASPRICE, productItemDetail.CURRENCY);

    commands.push(
      maybeDisplayed$(
        addToBagPopup.PriceWas(wasPrice),
      ),
    );
  }
  const results = await Promise.all(commands);
  results.forEach((r) => {
    expect(r, 'some elements are not displayed in Added To Bag Panel').not.to.be.null;
  });
  await sleep(500);
});
