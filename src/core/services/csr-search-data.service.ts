/* eslint-disable import/no-dynamic-require */
import { GetTestLogger } from '../logger/test.logger';
import data from '../json/csr-search-data.json';

export default class CsrSearchDataService {
  private csrData;

  constructor() {
    this.csrData = data;
  }

  public getSearchData(brand: string, orderInfo: string, databaseName: string) {
    let env;
    if (databaseName.indexOf('uat') === 0 || databaseName.indexOf('sit') === 0 || databaseName.indexOf('db0') === 0) {
      env = databaseName.slice(0, 3);
    } else {
      throw new Error('databaseName not on list. Please verify Database Name provided and if search data is available in ../json/csr-search-data.json');
    }

    if (!brand || !orderInfo) {
      throw new Error('The brand and key cannot be null!');
    }

    const key = `${brand.toLocaleUpperCase()}_${orderInfo.toUpperCase()}`;
    if (!this.csrData[env][key]) {
      throw new Error(`Cannot get CSR search data with key ${key}`);
    }

    GetTestLogger().info(`CSR search data: ${env} - Key: ${key} - Value: ${this.csrData[key]}`);
    return this.csrData[env][key];
  }
}
