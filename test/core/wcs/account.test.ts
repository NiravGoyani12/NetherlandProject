import 'mocha';
import { expect } from 'chai';
import setCookieParser from 'set-cookie-parser';
import randomstring from 'randomstring';
import { wcsSignUp } from '../../../src/core/wcs/authentication';
import AccountService from '../../../src/core/services/account.service';
import { SetUpSimpleTestLogger } from '../../../src/core/logger/test.logger';
import { wcsAddAddress, wcsUpdateUserInfo } from '../../../src/core/wcs/account';

process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

describe('WCS Account', () => {
  let accountService: AccountService;
  before(() => {
    SetUpSimpleTestLogger();
    accountService = new AccountService();
  });

  it('registered user can add address', async () => {
    accountService.provideFakeAccount();
    const signUpResponce = await wcsSignUp('https://uk.b2ceuup.tommy.com', 30027, accountService.parse('user1#email'), accountService.parse('user1#password'));
    const cookies = setCookieParser.parse(signUpResponce, { decodeValues: false });
    const authToken = cookies.filter((c) => c.name.startsWith('WC_AUTHENTICATION'))[0].value;
    const memberId = authToken.split('%')[0];
    const nickName = `SHIPBILL_${memberId}_30027_44_${randomstring.generate(8)}`;
    const formattedCookies = cookies.map((c) => `${c.name}=${c.value}`);
    const addAddressResponce = await wcsAddAddress(
      'https://uk.b2ceuup.tommy.com/', '30027', '10151', '44', authToken, memberId,
      'DD10 6TY', '', '', 'GB', nickName, formattedCookies,
    );
    expect(addAddressResponce.statusCode).to.eql(200);
    expect(addAddressResponce.body.errors).lengthOf(0);
    expect(addAddressResponce.body.addressId).to.not.be.null.and.not.be.undefined;
  });

  it('registered user can update account general info', async () => {
    accountService.provideFakeAccount();
    const signUpResponce = await wcsSignUp('https://uk.b2ceuup.tommy.com', 30027, accountService.parse('user2#email'), accountService.parse('user2#password'));
    const cookies = setCookieParser.parse(signUpResponce, { decodeValues: false });
    const formattedCookies = cookies.map((c) => `${c.name}=${c.value}`);
    const updateInfoResponse = await wcsUpdateUserInfo('https://uk.b2ceuup.tommy.com', '30027', formattedCookies, 'male', 'firstname', 'lastname');
    expect(updateInfoResponse.statusCode).to.eql(200);
    expect(updateInfoResponse.body.errors).lengthOf(0);
  });
});
