/* eslint-disable import/prefer-default-export */
import got from 'got/dist/source';
import { GetTestLogger } from '../logger/test.logger';

export async function wcsAddAddress(
  baseUrl: string, storeId: string, catalogId: string, langId: string,
  authToken: string, memberId: string, zipCode: string,
  phone1: string, state: string, country: string, nickName: string, cookies: string[],
) {
  const client = got.extend({
    headers: {
      cookie: cookies.join(';'),
    },
  });
  const payload = {
    storeId,
    catalogId,
    langId,
    actionType: 'add',
    userType: 'R',
    URL: baseUrl,
    authToken,
    addressType: 'SB',
    AddressForm_MemberId: memberId,
    personTitle: 'female',
    firstName: 'firstName',
    lastName: 'lastName',
    address1: 'testStreet',
    address2: 'houseNumber',
    city: 'testCity',
    state,
    zipCode,
    phone1,
    country,
    nickName,
  };
  try {
    const response = await client.post<any>(`${baseUrl}/wcs/resources/store/${storeId}/account/@self/address`, { json: payload, responseType: 'json' });
    if (response.body.errorMessage) {
      GetTestLogger().info(`Adding address post request had problems. Error message: ${response.body.errorMessage}. Status: ${response.statusCode}`);
    }
    return response;
  } catch (e) {
    throw new Error(`Adding address request failed. Status: ${e.response.statusCode}
  Response body: 
  ${e.response.body}`);
  }
}

export async function wcsUpdateUserInfo(
  baseUrl: string,
  storeId: string,
  cookies: string[],
  personTitle: 'male' | 'female',
  firstName: string,
  lastName: string,
  birthDay?: string,
  birthMonth?: string,
  birthYear?: string,
) {
  const client = got.extend({
    headers: {
      cookie: cookies.join(';'),
    },
    hooks: {
      beforeError: [
        (error) => {
          const { response } = error as any;
          if (response && response.body) {
            error.name = 'WCS Error';
            error.message = `${response.body.message} (${response.statusCode})`;
          }

          return error;
        },
      ],
    },
  });
  const payload = {
    personTitle,
    firstName,
    lastName,
    loyaltyNumber: '',
    birth_date: birthDay || '',
    birth_month: birthMonth || '',
    birth_year: birthYear || '',
  };
  try {
    const response = await client.put<any>(`${baseUrl}/wcs/resources/store/${storeId}/account/@self`, { json: payload, responseType: 'json' });
    if (response.body.errorMessage) {
      GetTestLogger().info(`Updating user info put request had problems. Error message: ${response.body.errorMessage}. Status: ${response.statusCode}`);
    }
    return response;
  } catch (e) {
    throw new Error(`Updating user info request failed. Status: ${e.response.statusCode}
  Response body: 
  ${e.response.body}`);
  }
}
