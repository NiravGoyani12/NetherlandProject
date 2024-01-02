import 'mocha';
import { expect } from 'chai';
import { THSiteService, CKSiteService } from '../../../src/core/services/site.service';
import { SetUpSimpleTestLogger } from '../../../src/core/logger/test.logger';
import { ProdStagFakeEnvService, UatFakeEnvService, SystestFakeEnvService } from '../../utils/env-service-mock';

describe('TH UAT Base url', () => {
  const uatSiteService = new THSiteService(new UatFakeEnvService(), null);
  before(() => {
    SetUpSimpleTestLogger();
  });

  it('can generate UAT base url without lang code', async () => {
    const baseUrl = uatSiteService.getBaseUrl('uk', null);
    expect(baseUrl).to.equal('https://uk.b2ceuup.tommy.com');
  });

  it('can generate UAT base url with lang code', async () => {
    const baseUrl = uatSiteService.getBaseUrl('ch', 'FR');
    expect(baseUrl).to.equal('https://ch.b2ceuup.tommy.com/FR');
  });
});

describe('TH Systest Base url', () => {
  const systestSiteService = new THSiteService(new SystestFakeEnvService(), null);
  before(() => {
    SetUpSimpleTestLogger();
  });

  it('can generate Systest base url without lang code', async () => {
    const baseUrl = systestSiteService.getBaseUrl('de', null);
    expect(baseUrl).to.equal('https://de.systestp.tommy.com');
  });

  it('can generate Systest base url with lang code', async () => {
    const baseUrl = systestSiteService.getBaseUrl('be', 'FR');
    expect(baseUrl).to.equal('https://be.systestp.tommy.com/FR');
  });
});

describe('TH Prod-stag Base url', () => {
  const prodStagSiteService = new THSiteService(new ProdStagFakeEnvService(), null);
  before(() => {
    SetUpSimpleTestLogger();
  });

  it('can generate Prod-stag base url without lang code', async () => {
    const baseUrl = prodStagSiteService.getBaseUrl('nl', null);
    expect(baseUrl).to.equal('https://nl.prod-stag.tommy.com');
  });

  it('can generate Prod-stag base url with lang code', async () => {
    const baseUrl = prodStagSiteService.getBaseUrl('ch', 'FR');
    expect(baseUrl).to.equal('https://ch.prod-stag.tommy.com/FR');
  });
});

describe('CK UAT Base url', () => {
  const uatSiteService = new CKSiteService(new UatFakeEnvService(), null);
  before(() => {
    SetUpSimpleTestLogger();
  });

  it('can generate UAT base url without lang code', async () => {
    const baseUrl = uatSiteService.getBaseUrl('de', null);
    expect(baseUrl).to.equal('https://b2ceuup.calvinklein.de');
  });

  it('can generate UAT base url with lang code', async () => {
    const baseUrl = uatSiteService.getBaseUrl('ch', 'FR');
    expect(baseUrl).to.equal('https://b2ceuup.calvinklein.ch/FR');
  });
});

describe('CK Systest Base url', () => {
  const systestSiteService = new CKSiteService(new SystestFakeEnvService(), null);
  before(() => {
    SetUpSimpleTestLogger();
  });

  it('can generate Systest base url without lang code', async () => {
    const baseUrl = systestSiteService.getBaseUrl('uk', null);
    expect(baseUrl).to.equal('https://uk.systestp.calvinklein.com');
  });

  it('can generate Systest base url with lang code', async () => {
    const baseUrl = systestSiteService.getBaseUrl('be', 'FR');
    expect(baseUrl).to.equal('https://be.systestp.calvinklein.com/FR');
  });
});

describe('CK Prod-stag Base url', () => {
  const prodStagSiteService = new CKSiteService(new ProdStagFakeEnvService(), null);
  before(() => {
    SetUpSimpleTestLogger();
  });

  it('can generate Prod-stag base url without lang code', async () => {
    const baseUrl = prodStagSiteService.getBaseUrl('ru', null);
    expect(baseUrl).to.equal('https://www.prod-stag.calvinklein.ru');
  });

  it('can generate Prod-stag base url with lang code', async () => {
    const baseUrl = prodStagSiteService.getBaseUrl('be', 'FR');
    expect(baseUrl).to.equal('https://www.prod-stag.calvinklein.be/FR');
  });

  it('can generate Prod-stag base url for RO locale', async () => {
    const baseUrl = prodStagSiteService.getBaseUrl('ro', null);
    expect(baseUrl).to.equal('https://ro.prod-stag.calvinklein.com');
  });

  it('can generate Prod-stag base url for UK locale', async () => {
    const baseUrl = prodStagSiteService.getBaseUrl('uk', null);
    expect(baseUrl).to.equal('https://www.prod-stag.calvinklein.co.uk');
  });
});
