import { expect } from 'chai';
import fs from 'fs';
import 'mocha';
import { SetUpTestlogger } from '../../../src/core/logger/test.logger';
import CheckoutDataService from '../../../src/core/services/checkout-data.service';

describe('CSR Search Data Service Tests', () => {
  let checkoutDataService: CheckoutDataService;

  before(async () => {
    await fs.promises.mkdir('./output/test', { recursive: true });
    SetUpTestlogger('./output/test/test.log', 'info');
    checkoutDataService = new CheckoutDataService();
  });

  it('can get checkout data successfully', () => {
    const checkoutDataRetrieved = checkoutDataService.getData('CK', 'PromoCode');
    expect(checkoutDataRetrieved).to.equal('CKAUTOMATION');
  });

  it('raise error when search info does not exist', () => {
    expect(() => checkoutDataService.getData('CK', 'notHere')).to.throw('Cannot get checkout data with key CK_NOTHERE');
  });

  it('raise error when brand is null', () => {
    expect(() => checkoutDataService.getData(null, 'ORDERID')).to.throw('The brand and key cannot be null!');
  });

  it('raise error when search info is null', () => {
    expect(() => checkoutDataService.getData('TH', null)).to.throw('The brand and key cannot be null!');
  });

  it('raise error when brand does not exist', () => {
    expect(() => checkoutDataService.getData('BOSS', 'PromoCode')).to.throw('Cannot get checkout data with key BOSS_PROMOCODE');
  });
});
