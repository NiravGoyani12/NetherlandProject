/* eslint-disable import/no-dynamic-require */
import { GetTestLogger } from '../logger/test.logger';
import data from '../json/csr-accounts.json';

export default class CsrAccountService {
  private csrAccount;

  constructor() {
    this.csrAccount = data;
  }

  public getCsrUser(accountType: string, brand: string, databaseName: string) {
    let env;
    if (databaseName.indexOf('uat') === 0 || databaseName.indexOf('sit') === 0 || databaseName.indexOf('db0') === 0) {
      env = databaseName.slice(0, 3);
    } else {
      throw new Error('databaseName not on list. Please verify Database Name provided and if accounts/passwords are available in ../json/csr-accounts.json');
    }

    if (!accountType || !brand) {
      throw new Error('The accountType or brand cannot be null!');
    }

    const key = `${brand.toLocaleUpperCase()}_CSR_${accountType.toLocaleUpperCase()}_USER`;
    if (!this.csrAccount[env][key]) {
      throw new Error(`Cannot get CSR user with key ${key}`);
    }

    GetTestLogger().info(`CSR User Env: ${env} - Key: ${key} - Value: ${this.csrAccount[key]}`);

    return this.csrAccount[env][key];
  }

  public getCsrPassword(accountType: string, brand: string, databaseName: string) {
    let env;
    if (databaseName.indexOf('uat') === 0 || databaseName.indexOf('sit') === 0 || databaseName.indexOf('db0') === 0) {
      env = databaseName.slice(0, 3);
    } else {
      throw new Error('databaseName not on list. Please verify Database Name provided and if accounts/passwords are available in ../json/csr-accounts.json');
    }

    if (!accountType || !brand) {
      throw new Error('The accountType or brand cannot be null!');
    }

    const key = `${brand.toLocaleUpperCase()}_CSR_${accountType.toLocaleUpperCase()}_PASSWORD`;
    if (!this.csrAccount[env][key]) {
      throw new Error(`Cannot get CSR password with key ${key}`);
    }

    GetTestLogger().info(`CSR User Env: ${env} - Password: ${key} - Value: ${this.csrAccount[key]}`);
    return this.csrAccount[env][key];
  }
}
