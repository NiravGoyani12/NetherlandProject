/* eslint-disable max-len */
import { expect } from 'chai';
import 'mocha';
import { Container } from 'typescript-ioc';
import { SetUpSimpleTestLogger } from '../../../src/core/logger/test.logger';
import services from '../../../src/core/services';
import { SiteService } from '../../../src/core/services/site.service';
import TransformersService from '../../../src/core/services/transformers.service';
import { getStore } from '../../../src/test/helper/utils.helper';

describe('Transformers Service Tests', () => {
  let transformersService: TransformersService;
  before(() => {
    SetUpSimpleTestLogger();
    transformersService = Container.get(TransformersService);
  });

  it.skip('can get proper response body', async () => {
    process.env.Brand = 'ck';
    const siteService = Container.get(SiteService);
    siteService.initilizeSize('be', 'default');
    await siteService.extractSiteInfo();
    const store = await getStore(services.site.locale);
    const response = await transformersService.getProducts('j20j222130yaf', siteService.siteInfo.LOCALENAME, store);
    expect(response).to.not.be.null;
  });

  it('get error code 404 when product does not exist', async () => {
    process.env.Brand = 'ck';
    const siteService = Container.get(SiteService);
    siteService.initilizeSize('be', 'default');
    await siteService.extractSiteInfo();
    const store = await getStore(services.site.locale);
    await transformersService.getProducts('j12j123412340', siteService.siteInfo.LOCALENAME, store).catch((error) => {
      expect(error.toString()).to.be.eq('Error: Error encountered for GET Products: HTTPError: Response code 404 (Not Found)');
    });
  });
});
