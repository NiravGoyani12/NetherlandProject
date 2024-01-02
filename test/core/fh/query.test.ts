import 'mocha';
import { expect } from 'chai';
import { Container } from 'typescript-ioc';
import { fhQuery } from '../../../src/core/fh/query';
import { styleColourIdList } from '../../utils/db-query';
import { SiteService, THSiteService } from '../../../src/core/services/site.service';
import { SetUpSimpleTestLogger } from '../../../src/core/logger/test.logger';
import { getCurrentDateTime } from '../../../src/core/fh/utils';

describe('FH Query', () => {
  let siteService:SiteService;
  before(async () => {
    SetUpSimpleTestLogger();
    Container.bind(SiteService).to(THSiteService);
    siteService = Container.get(SiteService);
    siteService.initilizeSize('default', 'default');
    await siteService.extractSiteInfo();
  });

  it('get correct date time', () => {
    const dateTime = getCurrentDateTime();
    expect(dateTime).lengthOf(15);
    expect(dateTime.indexOf('T') > 0).to.be.true;
  });

  it('query with results', async () => {
    const items = await fhQuery(
      siteService.siteInfo.FHInfo.FH_ENDPOINT_URL,
      siteService.siteInfo.FHInfo.FH_USERNAME,
      siteService.siteInfo.FHInfo.FH_PASSWORD,
      styleColourIdList,
      'th',
      'uk',
      'en_GB',
      'desktop',
    );
    expect(items.length > 0).to.be.true;
  });

  it('query with single result', async () => {
    const items = await fhQuery(
      siteService.siteInfo.FHInfo.FH_ENDPOINT_URL,
      siteService.siteInfo.FHInfo.FH_USERNAME,
      siteService.siteInfo.FHInfo.FH_PASSWORD,
      ['p1355910'],
      'th',
      'uk',
      'en_GB',
      'desktop',
    );
    expect(items).to.lengthOf(1);
  });

  it('query with no results', async () => {
    const items = await fhQuery(
      siteService.siteInfo.FHInfo.FH_ENDPOINT_URL,
      siteService.siteInfo.FHInfo.FH_USERNAME,
      siteService.siteInfo.FHInfo.FH_PASSWORD,
      ['p43889', 'p242430'],
      'th',
      'uk',
      'en_GB',
      'desktop',
    );
    expect(items).to.lengthOf(0);
  });
});
