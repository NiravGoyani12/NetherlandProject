/* eslint-disable import/no-dynamic-require */
import { GetTestLogger } from '../logger/test.logger';
import data from '../json/checkout-data.json';

export default class CheckoutDataService {
  private checkoutData;

  constructor() {
    this.checkoutData = data;
  }

  public getData(brand: string, info: string) {
    if (!brand || !info) {
      throw new Error('The brand and key cannot be null!');
    }

    const key = `${brand.toLocaleUpperCase()}_${info.toUpperCase()}`;
    if (!this.checkoutData[key]) {
      throw new Error(`Cannot get checkout data with key ${key}`);
    }

    GetTestLogger().info(`Checkout data: ${key} - Value: ${this.checkoutData[key]}`);
    return this.checkoutData[key];
  }
}
