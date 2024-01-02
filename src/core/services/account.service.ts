/* eslint-disable max-classes-per-file */
import randomstring from 'randomstring';

export interface PVHAccount {
  firstName: string
  lastName: string
  email: string
  password: string
}

const defaultLastName = 'PVHQA';
const defaultPassword = '12345sdf67890';

export default class AccountService {
  private accounts: Array<PVHAccount>;

  constructor() {
    this.accounts = [];
  }

  public cleanUp() {
    this.accounts = [];
  }

  public provideFakeAccount(count: number = 1) {
    for (let i = 0; i < count; i += 1) {
      const firstName = randomstring.generate(8);
      const account: PVHAccount = {
        firstName,
        lastName: defaultLastName,
        email: `pvhqatester+${firstName}@gmail.com`.toLowerCase(),
        password: defaultPassword,
      };
      this.accounts.push(account);
    }
  }

  public parse(text: string) {
    if (text && text.startsWith('user') && text.indexOf('#') > 0) {
      text = text.replace('user', '');
      const parts = text.split('#');
      const index = Number(parts[0]) - 1;
      switch (parts[1].toLocaleLowerCase()) {
        case 'email':
          return this.accounts[index].email;
        case 'newemail':
          return `new${this.accounts[index].email}`;
        case 'password':
          return this.accounts[index].password;
        case 'firstname':
          return this.accounts[index].firstName;
        case 'lastname':
          return this.accounts[index].lastName;
        default:
          throw new Error('Cannot parse account key');
      }
    }
    return text;
  }
}
