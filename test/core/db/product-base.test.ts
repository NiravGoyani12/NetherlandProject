import { expect } from 'chai';
import { SetUpSimpleTestLogger } from '../../../src/core/logger/test.logger';
import services from '../../../src/core/services';

describe('Product Base', () => {
  before(async () => {
    SetUpSimpleTestLogger();
    services.site.initilizeSize('uk', undefined);
    await services.site.extractSiteInfo();
  });

  xit('GetSeoUrl for RU', async () => {
    const seoUrl = await services.product.product.GetSEOUrl('J20J207878112', 'ru_RU');
    expect(seoUrl).equals('футболка-с-логотипом-j20j207878112');
  });
});
