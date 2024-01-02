import 'mocha';
import { expect } from 'chai';
import { Container } from 'typescript-ioc';
import { SiteService, THSiteService } from '../../../src/core/services/site.service';
import { SetUpSimpleTestLogger } from '../../../src/core/logger/test.logger';
import { getProductStyleColoursWithStoreAvailaibility } from '../../../src/core/fh/products';
// import { getProductStyleColoursWithStoreAvailaibility } from '../../../src/core/fh/products';

describe('Product Style Colours with store availibity', () => {
  let siteService: SiteService;
  before(async () => {
    SetUpSimpleTestLogger();
    Container.bind(SiteService).to(THSiteService);
    siteService = Container.get(SiteService);
    siteService.initilizeSize('default', 'default');
    await siteService.extractSiteInfo();
  });

  it('get 1 product', async () => {
    const items = await getProductStyleColoursWithStoreAvailaibility(
      siteService.siteInfo.FHInfo.FH_ENDPOINT_URL,
      siteService.siteInfo.FHInfo.FH_USERNAME,
      siteService.siteInfo.FHInfo.FH_PASSWORD,
      'th',
      'de',
      '30006',
      'de_DE',
      'desktop',
      1,
      'size_de=size_os_de',
    );
    expect(items.length === 1).to.be.true;
  });
});
