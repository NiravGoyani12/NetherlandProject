import 'mocha';
import { expect } from 'chai';
import { Container } from 'typescript-ioc';
import { THSiteService, SiteService } from '../../../src/core/services/site.service';
import { SetUpSimpleTestLogger } from '../../../src/core/logger/test.logger';

describe('Site service', () => {
  before(() => {
    SetUpSimpleTestLogger();
    Container.bind(SiteService).to(THSiteService);
  });

  it('can get site info', async () => {
    const siteSerivce = Container.get(SiteService);
    siteSerivce.initilizeSize('default', 'default');
    await siteSerivce.extractSiteInfo();
    expect(siteSerivce.siteInfo).not.to.be.null;
    expect(siteSerivce.locale).to.equal('uk');
    expect(siteSerivce.langCode).to.be.undefined;
    expect(siteSerivce.siteInfo.FFMCENTER_ID > 0).to.be.true;
    expect(siteSerivce.siteInfo.LANGUAGE_ID).to.equal(44);
    expect(siteSerivce.siteInfo.FHInfo).not.to.be.null;
    expect(siteSerivce.siteInfo.FHInfo.FH_ENDPOINT_URL.length > 0).to.be.true;
    expect(siteSerivce.siteInfo.FHInfo.FH_USERNAME.length > 0).to.be.true;
    expect(siteSerivce.siteInfo.FHInfo.FH_PASSWORD.length > 0).to.be.true;
  });

  it('can regenerate site info', async () => {
    const siteSerivce = Container.get(SiteService);
    siteSerivce.initilizeSize('default', null);
    await siteSerivce.extractSiteInfo();
    expect(siteSerivce.siteInfo).not.to.be.null;
    const storeId1 = siteSerivce.siteInfo.STORE_ID;

    siteSerivce.initilizeSize('pt', null);
    await siteSerivce.extractSiteInfo();
    expect(siteSerivce.siteInfo).not.to.be.null;
    const storeId2 = siteSerivce.siteInfo.STORE_ID;
    expect(storeId1).not.equal(storeId2);

    siteSerivce.initilizeSize('default', null);
    await siteSerivce.extractSiteInfo();
    expect(siteSerivce.siteInfo).not.to.be.null;
    const storeId3 = siteSerivce.siteInfo.STORE_ID;
    expect(storeId2).not.equal(storeId3);

    siteSerivce.initilizeSize('ch', 'fr');
    await siteSerivce.extractSiteInfo();
    expect(siteSerivce.siteInfo).not.to.be.null;
    const storeId4 = siteSerivce.siteInfo.STORE_ID;
    expect(storeId3).not.equal(storeId4);

    siteSerivce.initilizeSize('default', 'default');
    await siteSerivce.extractSiteInfo();
    expect(siteSerivce.siteInfo).not.to.be.null;
    const storeId5 = siteSerivce.siteInfo.STORE_ID;
    expect(storeId4).not.equal(storeId5);

    siteSerivce.initilizeSize('spaDefault', null);
    await siteSerivce.extractSiteInfo();
    expect(siteSerivce.siteInfo).not.to.be.null;
    const storeId6 = siteSerivce.siteInfo.STORE_ID;
    expect(storeId5).not.equal(storeId6);

    siteSerivce.initilizeSize('default', 'default');
    await siteSerivce.extractSiteInfo();
    expect(siteSerivce.siteInfo).not.to.be.null;
    const storeId7 = siteSerivce.siteInfo.STORE_ID;
    expect(storeId6).not.equal(storeId7);

    siteSerivce.initilizeSize('spaDefault', 'spaDefault');
    await siteSerivce.extractSiteInfo();
    expect(siteSerivce.siteInfo).not.to.be.null;
    const storeId8 = siteSerivce.siteInfo.STORE_ID;
    expect(storeId7).not.equal(storeId8);

    siteSerivce.initilizeSize('multilangdefault', 'multilangdefault');
    await siteSerivce.extractSiteInfo();
    expect(siteSerivce.siteInfo).not.to.be.null;
    const storeId9 = siteSerivce.siteInfo.STORE_ID;
    expect(storeId8).not.equal(storeId9);
  });
});
