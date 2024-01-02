import { expect } from 'chai';
import fs from 'fs';
import 'mocha';
import { SetUpTestlogger } from '../../../src/core/logger/test.logger';
import CsrAccountService from '../../../src/core/services/csr-account.service';

describe('CSR Account Service Tests', () => {
  let csrAccountService: CsrAccountService;

  before(async () => {
    await fs.promises.mkdir('./output/test', { recursive: true });
    SetUpTestlogger('./output/test/test.log', 'info');
    csrAccountService = new CsrAccountService();
  });

  it('can get csr account successfully', () => {
    process.env.Brand = 'ck';
    const csrUserRetrieved = csrAccountService.getCsrUser('L4_1', 'CK', 'uat-prod');
    expect(csrUserRetrieved).to.equal('automationl41@pvh.com');
  });

  it('can get csr password successfully', () => {
    process.env.Brand = 'th';
    const csrUserRetrieved = csrAccountService.getCsrPassword('L2_2', 'TH', 'db0-prod');
    expect(csrUserRetrieved).to.equal('Tester@12345678910');
  });

  xit('raise error when accountType does not exist for getCsrUser', () => {
    expect(() => csrAccountService.getCsrUser('L7', 'CK', 'uat-prod')).to.throw('Cannot get CSR user with key CK_CSR_L7_USER');
  });

  it('raise error when accountType is null for getCsrUser', () => {
    expect(() => csrAccountService.getCsrUser(null, 'TH', 'uat-prod')).to.throw('The accountType or brand cannot be null!');
  });

  it('raise error when brand is null for getCsrUser', () => {
    expect(() => csrAccountService.getCsrUser('L1', null, 'uat-prod')).to.throw('The accountType or brand cannot be null!');
  });

  it('raise error when databaseName does not exist for getCsrUser', () => {
    expect(() => csrAccountService.getCsrUser('L1', 'CK', 'prod-live')).to.throw('databaseName not on list. Please verify Database Name provided and if accounts/passwords are available in ../json/csr-accounts.json');
  });

  it('raise error when accountType does not exist for getCsrPassword', () => {
    expect(() => csrAccountService.getCsrPassword('L7', 'CK', 'uat-prod')).to.throw('Cannot get CSR password with key CK_CSR_L7_PASSWORD');
  });

  it('raise error when accountType is null for getCsrPassword', () => {
    expect(() => csrAccountService.getCsrPassword(null, 'TH', 'uat-prod')).to.throw('The accountType or brand cannot be null!');
  });

  it('raise error when brand is null for getCsrPassword', () => {
    expect(() => csrAccountService.getCsrPassword('L2', null, 'uat-prod')).to.throw('The accountType or brand cannot be null!');
  });

  it('raise error when databaseName does not exist for getCsrPassword', () => {
    expect(() => csrAccountService.getCsrUser('L1', 'TH', 'something')).to.throw('databaseName not on list. Please verify Database Name provided and if accounts/passwords are available in ../json/csr-accounts.json');
  });
});
