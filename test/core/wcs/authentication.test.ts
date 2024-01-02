import 'mocha';
import { expect } from 'chai';
import setCookieParser from 'set-cookie-parser';
import { wcsSignUp } from '../../../src/core/wcs/authentication';
import AccountService from '../../../src/core/services/account.service';
import { SetUpSimpleTestLogger } from '../../../src/core/logger/test.logger';

process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

describe('WCS Authentication', () => {
  let accountService: AccountService;
  before(() => {
    SetUpSimpleTestLogger();
    accountService = new AccountService();
  });

  it('can sign up', async () => {
    accountService.provideFakeAccount();
    const respones = await wcsSignUp('https://be.b2ceuup.tommy.com', 30027, accountService.parse('user1#email'), accountService.parse('user1#password'));
    const cookies = setCookieParser.parse(respones, { decodeValues: false });
    expect(cookies).lengthOf(11);
    expect(cookies.find((c) => c.name === 'WC_PERSISTENT')).to.not.be.null.and.not.be.undefined;
  });

  // it('can sign in', async () => {
  //   accountService.provideFakeAccount();
  //   await wcsSignUp('https://be.b2ceuup.calvinklein.com', 30027, accountService.parse('user2#email'), accountService.parse('user2#password'));
  //   const respones = await wcsSignIn('https://be.b2ceuup.calvinklein.com', 20027, accountService.parse('user2#email'), accountService.parse('user2#password'));
  //   const cookies = setCookieParser.parse(respones, { decodeValues: false });
  //   expect(cookies).lengthOf(5);
  //   expect(cookies.find((c) => c.name === 'WC_PERSISTENT')).to.not.be.null.and.not.be.undefined;
  // });
});
