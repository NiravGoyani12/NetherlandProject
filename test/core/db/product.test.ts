import services from '../../../src/core/services';
import { SetUpSimpleTestLogger } from '../../../src/core/logger/test.logger';

const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');

chai.use(chaiAsPromised);
const { expect } = chai;

describe('Parser with Product', () => {
  before(async () => {
    SetUpSimpleTestLogger();
    services.site.initilizeSize('uk', undefined);
    await services.site.extractSiteInfo();
  });

  it('getProductWithMultipleColurs', async () => {
    services.product.cleanUp();

    await expect(
      services.product.product.getProductWithMultipleColurs(2, '>=', 100, 9999, 1),
    ).to.be.fulfilled;
    expect(services.product.parse('product1#styleId')).not.to.be.empty;
    expect(services.product.parse('product1#stylePartNumber')).not.to.be.empty;
    expect(services.product.parse('product1#styleColourId')).to.be.empty;
    expect(services.product.parse('product1#styleColourPartNumber')).to.be.empty;
    expect(services.product.parse('product1#skuId')).to.be.empty;
    expect(services.product.parse('product1#skuPartNumber')).to.be.empty;
    expect(services.product.productCount).to.equal(1);

    services.product.cleanUp();

    await expect(
      services.product.product.getProductWithMultipleColurs(2, '>=', 100, 9999, 5),
    ).to.be.fulfilled;
    expect(services.product.productCount).to.equal(5);
  });

  it('fetchProductStyleDetail', async () => {
    await expect(services.product.product.fetchProductDetail('WW0WW28681')).to.be.fulfilled;
    expect(services.product.product.details).length.of(1);
  });
});
