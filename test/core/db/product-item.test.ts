/* eslint-disable max-len */
import services from '../../../src/core/services';
import { SetUpSimpleTestLogger } from '../../../src/core/logger/test.logger';

const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');

chai.use(chaiAsPromised);
const { expect } = chai;

describe('Parser with Product Item', () => {
  before(async () => {
    SetUpSimpleTestLogger();
    services.site.initilizeSize('default', 'default');
    await services.site.extractSiteInfo();
  });

  it('getAnyProductItem', async () => {
    await expect(services.product.productItem.getAnyProductItem()).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
    expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourId')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourPartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#skuId')).not.to.be.empty;
    expect(services.product.parse('product1#skuPartNumber')).not.to.be.empty;
    expect(services.product.productCount).to.equal(1);

    services.product.cleanUp();

    await expect(services.product.productItem.getAnyProductItem(1, 9999, 5)).to.be.fulfilled;
    expect(services.product.productCount).to.equal(5);
  });

  xit('getAnyProductItem with FH filter', async () => {
    await expect(services.product.productItem.getAnyProductItem(0, 10000, 1, true)).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
  });

  it('getProductItemOfStyleOneSize', async () => {
    services.product.cleanUp();

    await expect(services.product.productItem.getProductItemOfStyleOneSize(10)).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
    expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourId')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourPartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#skuId')).not.to.be.empty;
    expect(services.product.parse('product1#skuPartNumber')).not.to.be.empty;
    expect(services.product.productCount).to.equal(1);

    services.product.cleanUp();

    await expect(
      services.product.productItem.getProductItemOfStyleOneSize(1, 9999, 5),
    ).to.be.fulfilled;
    expect(services.product.productCount).to.equal(5);
  });

  it('getProductItemOfStyleNormalSize', async () => {
    services.product.cleanUp();
    await expect(
      services.product.productItem.getProductItemOfStyleNormalSize(5),
    ).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
    expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourId')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourPartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#skuId')).not.to.be.empty;
    expect(services.product.parse('product1#skuPartNumber')).not.to.be.empty;
    expect(services.product.productCount).to.equal(1);

    services.product.cleanUp();

    await expect(
      services.product.productItem.getProductItemOfStyleNormalSize(1, 9999, 5),
    ).to.be.fulfilled;
    expect(services.product.productCount).to.equal(5);
  });

  it('getProductItemBasedOnStyleAttr', async () => {
    services.product.cleanUp();
    await expect(
      services.product.productItem.getProductItemOfStyleMultipleSize(10),
    ).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
    expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourId')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourPartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#skuId')).not.to.be.empty;
    expect(services.product.parse('product1#skuPartNumber')).not.to.be.empty;
    expect(services.product.productCount).to.equal(1);

    services.product.cleanUp();

    await expect(
      services.product.productItem.getProductItemOfStyleMultipleSize(1, 9999, 5),
    ).to.be.fulfilled;
    expect(services.product.productCount).to.equal(5);
  });

  xit('getProductWithSpecificWasPrice', async () => {
    services.product.cleanUp();
    await expect(
      services.product.productItem.getProductWithSpecificWasPrice(0.5, 10, 10000, 1, 9999, 1, true),
    ).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
    expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourId')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourPartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#skuId')).not.to.be.empty;
    expect(services.product.parse('product1#skuPartNumber')).not.to.be.empty;
    expect(services.product.productCount).to.equal(1);

    services.product.cleanUp();

    await expect(
      services.product.productItem.getProductWithSpecificWasPrice(0.5, 10, 10000, 1, 9999, 3),
    ).to.be.fulfilled;
    expect(services.product.productCount).to.equal(3);
  });

  it('getProductWithWasPrice', async () => {
    services.product.cleanUp();
    // TODO change SAP filter to true once WCS and SAP inventories are in sync
    await expect(
      services.product.productItem.getProductWithWasPrice(5, 10000, 1, true, false),
    ).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
    expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourId')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourPartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#skuId')).not.to.be.empty;
    expect(services.product.parse('product1#skuPartNumber')).not.to.be.empty;
    expect(services.product.productCount).to.equal(1);

    services.product.cleanUp();

    await expect(
      services.product.productItem.getProductWithWasPrice(10, 10000, 5),
    ).to.be.fulfilled;
    expect(services.product.productCount).to.equal(5);
  });

  it('getProductItemOfStyleOnlyWidthSize', async () => {
    services.product.cleanUp();
    await expect(
      services.product.productItem.getProductItemOfStyleWidthOnlySize(1),
    ).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
    expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourId')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourPartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#skuId')).not.to.be.empty;
    expect(services.product.parse('product1#skuPartNumber')).not.to.be.empty;
    expect(services.product.productCount).to.equal(1);

    services.product.cleanUp();

    await expect(
      services.product.productItem.getProductItemOfStyleWidthOnlySize(1, 9999, 5),
    ).to.be.fulfilled;
    expect(services.product.productCount).to.equal(5);
  });

  xit('getProductWithPendingPrice', async () => {
    services.product.cleanUp();
    await expect(
      services.product.productItem.getProductItemWithPendingPrice(1),
    ).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
    expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourId')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourPartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#skuId')).not.to.be.empty;
    expect(services.product.parse('product1#skuPartNumber')).not.to.be.empty;
    expect(services.product.productCount).to.equal(1);

    services.product.cleanUp();

    await expect(
      services.product.productItem.getProductItemWithPendingPrice(1, 9999, 3),
    ).to.be.fulfilled;
    expect(services.product.productCount).to.equal(3);
  });

  it('fetchProductItemDetail', async () => {
    await expect(services.product.productItem.fetchProductItemDetail('8720107976665')).to.be.fulfilled;
    expect(services.product.productItem.details).length.of(1);
  });
});
