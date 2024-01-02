import services from '../../../src/core/services';
import { SetUpSimpleTestLogger } from '../../../src/core/logger/test.logger';

const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');

chai.use(chaiAsPromised);
const { expect } = chai;

process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

describe('Parser with Product Style', () => {
  before(async () => {
    SetUpSimpleTestLogger();
    services.site.initilizeSize('uk', undefined);
    await services.site.extractSiteInfo();
  });

  it('fetchProductStyleDetail', async () => {
    await expect(services.product.productStyle.fetchProductStyleDetail('MW0MW23563PTY')).to.be.fulfilled;
    expect(services.product.productStyle.details).length.of(1);
  });

  it('getProductStyleOfOneSize', async () => {
    services.product.cleanUp();

    await expect(
      services.product.productStyle.getProductStyleOfOneSize(0, 99999, 1),
    ).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
    expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourId')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourPartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#skuId')).to.be.empty;
    expect(services.product.parse('product1#skuPartNumber')).to.be.empty;
    expect(services.product.productCount).to.equal(1);

    services.product.cleanUp();

    await expect(
      services.product.productStyle.getProductStyleOfOneSize(10, 99999, 5),
    ).to.be.fulfilled;
    expect(services.product.productCount).to.equal(5);
  });

  it('getProductSytleOfNormalSize', async () => {
    services.product.cleanUp();

    await expect(
      services.product.productStyle.getProductSytleOfNormalSize(0, 999999, 1),
    ).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
    expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourId')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourPartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#skuId')).to.be.empty;
    expect(services.product.parse('product1#skuPartNumber')).to.be.empty;
    expect(services.product.productCount).to.equal(1);

    services.product.cleanUp();

    await expect(
      services.product.productStyle.getProductSytleOfNormalSize(10, 99999, 5),
    ).to.be.fulfilled;
    expect(services.product.productCount).to.equal(5);
  });

  it('getProductStyleOfMultipleSize', async () => {
    services.product.cleanUp();

    await expect(
      services.product.productStyle.getProductStyleOfMultipleSize(0, 999999, 1),
    ).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
    expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourId')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourPartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#skuId')).to.be.empty;
    expect(services.product.parse('product1#skuPartNumber')).to.be.empty;
    expect(services.product.productCount).to.equal(1);

    services.product.cleanUp();

    await expect(
      services.product.productStyle.getProductStyleOfMultipleSize(0, 999999, 5),
    ).to.be.fulfilled;
    expect(services.product.productCount).to.equal(5);
  });

  // TODO: uncomment test when extra discount is available in DB
  // it('getProductStyleOfExtraDiscount', async () => {
  //   services.product.cleanUp();

  // eslint-disable-next-line max-len
  //   await expect(services.product.productStyle.getProductStyleOfExtraDiscount(10, 'UK', 1, 9999, 1)).to.be.fulfilled;
  //   expect(services.product.parse('product1#styleId')).not.to.be.empty;
  //   expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
  //   expect(services.product.parse('product1#styleColourId')).not.to.be.empty;
  //   expect(services.product.parse('product1#styleColourPartNumber')).not.to.be.empty;
  //   expect(services.product.parse('product1#skuId')).to.be.empty;
  //   expect(services.product.parse('product1#skuPartNumber')).to.be.empty;
  //   expect(services.product.productCount).to.equal(1);

  //   services.product.cleanUp();

  // eslint-disable-next-line max-len
  //   await expect(services.product.productStyle.getProductStyleOfExtraDiscount(10, 'UK', 1, 9999, 5)).to.be.fulfilled;
  //   expect(services.product.productCount > 0).to.be.true;
  // });

  it('getProductStyleOfMultipleWidthAndSingleLength', async () => {
    services.product.cleanUp();
    await expect(
      services.product.productStyle.getProductStyleOfMultipleWidthAndSingleLength(
        1, 999999, 1,
      ),
    ).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
    expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourId')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourPartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#skuId')).to.be.empty;
    expect(services.product.parse('product1#skuPartNumber')).to.be.empty;
    expect(services.product.productCount).to.equal(1);
  });

  it('getProductStyleWithDifferentCurrentPrice', async () => {
    services.product.cleanUp();
    await expect(
      services.product.productStyle.getProductStyleWithDifferentCurrentPrice(1),
    ).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
    expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourId')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourPartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#skuId')).to.be.empty;
    expect(services.product.parse('product1#skuPartNumber')).to.be.empty;
    expect(services.product.productCount).to.equal(1);

    services.product.cleanUp();

    await expect(services.product.productStyle
      .getProductStyleWithDifferentCurrentPrice(2)).to.be.fulfilled;
    expect(services.product.productCount).to.equal(2);
  });

  it('getProductStyleOfNormalSizeWithSizeStock', async () => {
    services.product.cleanUp();
    await expect(
      services.product.productStyle.getProductStyleOfNormalSizeWithSizeStock(10, 1, 9999, 1),
    ).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
    expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourId')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourPartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#skuId')).to.be.empty;
    expect(services.product.parse('product1#skuPartNumber')).to.be.empty;
    expect(services.product.productCount).to.equal(1);

    services.product.cleanUp();

    await expect(services.product.productStyle
      .getProductStyleOfNormalSizeWithSizeStock(10, 1, 9999, 2)).to.be.fulfilled;
    expect(services.product.productCount).to.equal(2);
  });

  xit('getProductByGBPC', async () => {
    services.product.cleanUp();
    await expect(
      services.product.productStyle.getProductStyleByGBPC('%boys_spw_underwear%', 1, 99999, 1),
    ).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
    expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourId')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourPartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#skuId')).to.be.empty;
    expect(services.product.parse('product1#skuPartNumber')).to.be.empty;
    expect(services.product.productCount).to.equal(1);

    services.product.cleanUp();

    await expect(services.product.productStyle
      .getProductStyleByGBPC('%boys_spw_underwear%', 1, 999999, 2)).to.be.fulfilled;
    expect(services.product.productCount).to.equal(2);
  });

  xit('getProductWithStoreAvailability', async () => {
    services.product.cleanUp();
    await expect(services.product.productStyle.getProductStyleByStyleColourNumbers(['AM0AM08712BDS'])).to.be.fulfilled;
    expect(services.product.productCount).to.equal(1);
  });
});
