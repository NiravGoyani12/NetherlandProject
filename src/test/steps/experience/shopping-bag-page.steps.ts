import { Then } from '@pvhqa/cucumber';
import { expect } from 'chai';
import { maybeDisplayed$ } from '../../general';
import services from '../../../core/services';
import { formatCurrency } from '../../helper/currency.helper';

const pageName = 'Experience.ShoppingBag';

Then(/in unified shopping bag page I see product item ([^\s]+) has correct price info/, async (skuPartNumber: string) => {
  skuPartNumber = services.world.parse(skuPartNumber);
  skuPartNumber = services.product.parse(skuPartNumber);
  const productItemDetail = await services.product.productItem.getDetail(skuPartNumber);
  const expectedCurrentPrice = formatCurrency(
    productItemDetail.CURRENTPRICE,
    productItemDetail.CURRENCY,
  );
  const commands = [];
  if (productItemDetail.WASPRICE) {
    const wasPrice = formatCurrency(
      productItemDetail.WASPRICE,
      productItemDetail.CURRENCY,
    );
    const itemCurrentPriceSelector = await services.pageObject.getSelector(`${pageName}.ItemCurrentPrice`, [skuPartNumber]);
    const itemWasPriceSelector = await services.pageObject.getSelector(`${pageName}.ItemWasPrice`, [skuPartNumber]);
    commands.push(
      maybeDisplayed$(itemCurrentPriceSelector).then(async (ele) => {
        const text = await ele.getText();
        if (text.replace(/[\u00A0]/g, ' ') !== expectedCurrentPrice) {
          throw new Error(`The expected current price is ${expectedCurrentPrice}, but was ${text}`);
        }
      }),
      maybeDisplayed$(itemWasPriceSelector).then(async (ele) => {
        const text = await ele.getText();
        if (text.replace(/[\u00A0]/g, ' ') !== wasPrice) {
          throw new Error(`The expected WAS price is ${wasPrice}, but was ${text}`);
        }
      }),
    );
  } else {
    const itemPriceSelector = await services.pageObject.getSelector(`${pageName}.ItemPrice`, [skuPartNumber]);
    commands.push(
      maybeDisplayed$(itemPriceSelector).then(async (ele) => {
        const text = await ele.getText();
        if (text.replace(/[\u00A0]/g, ' ') !== expectedCurrentPrice) {
          throw new Error(`The expected price is ${expectedCurrentPrice}, but was ${text}`);
        }
      }),
    );
  }
  const results = await Promise.all(commands);
  results.forEach((r) => {
    expect(r, 'some elements are not displayed in unified Shopping bag page').not.to.be.null;
  });
});
