import got from 'got';
import { GetTestLogger } from '../logger/test.logger';

export async function wcsSignUp(
  baseUrl: string, storeId: number, email: string, password: string,
) {
  const payload = {
    email1: email,
    logonPassword: password,
    logonPasswordVerify: password,
    updateCookies: true,
    x_registerNewsletter: false,
    x_optInDateTime: (Date.now()).toString(),
  };
  try {
    GetTestLogger().info(`wcsSignUp url: ${baseUrl}/wcs/resources/store/${storeId}/person?updateCookies=true`);
    GetTestLogger().info(`wcsSignUp payload: ${JSON.stringify(payload)}`);
    const response = await got.post<any>(`${baseUrl}/wcs/resources/store/${storeId}/person?updateCookies=true`, { json: payload, responseType: 'json' });
    if (response.body.errorMessage) {
      GetTestLogger().info(`Sign up post request had problems. Error message: ${response.body.errorMessage}. Status: ${response.statusCode}`);
    }
    return response;
  } catch (e) {
    throw new Error(`Sign up request failed. Status: ${e.response.statusCode}
  Response body: 
  ${JSON.stringify(e.response.body)}`);
  }
}

export async function wcsSignIn(
  baseUrl: string, storeId: number, email: string, password: string,
) {
  const payload = {
    logonId: email,
    logonPassword: password,
    rememberMe: false,
    updateCookies: true,
  };
  try {
    GetTestLogger().info(`wcsSignIn url: ${baseUrl}/wcs/resources/store/${storeId}/loginidentity?updateCookies=true`);
    GetTestLogger().info(`wcsSignIn payload: ${JSON.stringify(payload)}`);
    const response = await got.post<any>(`${baseUrl}/wcs/resources/store/${storeId}/loginidentity?updateCookies=true`, { json: payload, responseType: 'json' });
    if (response.body.errorMessage) {
      GetTestLogger().info(`Sign in post request had problems. Error message: ${response.body.errorMessage}. Status: ${response.statusCode}`);
    }
    return response;
  } catch (e) {
    throw new Error(`Sign in request failed. Status: ${e.response.statusCode}. Email: ${payload.logonId}, password: ${payload.logonPassword}
    Response body: 
    ${JSON.stringify(e.response.body)}`);
  }
}
