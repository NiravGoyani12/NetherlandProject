import { expect } from 'chai';
import { SetUpSimpleTestLogger } from '../../../src/core/logger/test.logger';
import services from '../../../src/core/services';

describe('Others DB', () => {
  before(async () => {
    SetUpSimpleTestLogger();
    services.site.initilizeSize('default', 'default');
    await services.site.extractSiteInfo();
  });

  it('GetRedirectSEOURL', async () => {
    const seoUrl = await services.othersDB.GetRedirectSEOURL(false, 2);
    expect(seoUrl.length === 2).is.true;
  });

  it('GetCtxMgmt', async () => {
    const result = await services.othersDB.GetCtxMgmt('111111');
    expect(result.length === 0).is.true;
  });
});
