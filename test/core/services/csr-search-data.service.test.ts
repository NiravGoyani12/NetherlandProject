import { expect } from 'chai';
import fs from 'fs';
import 'mocha';
import { SetUpTestlogger } from '../../../src/core/logger/test.logger';
import CsrSearchDataService from '../../../src/core/services/csr-search-data.service';

describe('CSR Search Data Service Tests', () => {
  let csrSearchDataService: CsrSearchDataService;

  before(async () => {
    await fs.promises.mkdir('./output/test', { recursive: true });
    SetUpTestlogger('./output/test/test.log', 'info');
    csrSearchDataService = new CsrSearchDataService();
  });

  it('can get csr search data successfully', () => {
    const csrSearchDataRetrieved = csrSearchDataService.getSearchData('CK', 'RETURNID', 'uat-prod');
    expect(csrSearchDataRetrieved).to.equal('10054502');
  });

  it('raise error when search info does not exist', () => {
    expect(() => csrSearchDataService.getSearchData('CK', 'notHere', 'db0-live')).to.throw('Cannot get CSR search data with key CK_NOTHERE');
  });

  it('raise error when brand is null', () => {
    expect(() => csrSearchDataService.getSearchData(null, 'ORDERID', 'uat-live')).to.throw('The brand and key cannot be null!');
  });

  it('raise error when search info is null', () => {
    expect(() => csrSearchDataService.getSearchData('TH', null, 'db0-dev')).to.throw('The brand and key cannot be null!');
  });

  it('raise error when database name does not exist', () => {
    expect(() => csrSearchDataService.getSearchData('TH', 'promocode', 'prod-dev')).to.throw('databaseName not on list. Please verify Database Name provided and if search data is available in ../json/csr-search-data.json');
  });

  it('raise error when brand does not exist', () => {
    expect(() => csrSearchDataService.getSearchData('BOSS', 'MULTIPLE_ORDERS', 'uat-prod')).to.throw('Cannot get CSR search data with key BOSS_MULTIPLE_ORDERS');
  });
});
