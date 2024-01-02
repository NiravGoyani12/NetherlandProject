/* eslint-disable import/prefer-default-export */

import got from 'got/dist/source';

const httpTimeout = 5000;
const httpRetry = 5;

export interface FHQueryItem {
  attribute: {
    value: string
  }
}

export function getCurrentDateTime() {
  const currentDateTime = new Date();
  const month = currentDateTime.getMonth() < 10 ? `0${currentDateTime.getMonth()}` : currentDateTime.getMonth();
  const day = currentDateTime.getDay() < 10 ? `0${currentDateTime.getDay()}` : currentDateTime.getDay();
  const hours = currentDateTime.getHours() < 10 ? `0${currentDateTime.getHours()}` : currentDateTime.getHours();
  const minutes = currentDateTime.getMinutes() < 10 ? `0${currentDateTime.getMinutes()}` : currentDateTime.getMinutes();
  const seconds = currentDateTime.getSeconds() < 10 ? `0${currentDateTime.getSeconds()}` : currentDateTime.getSeconds();
  return `${currentDateTime.getFullYear()}${month}${day}T${hours}${minutes}${seconds}`;
}

export async function fhRequest(userName: string, password: string, baseUrl: string, path: string) {
  const auth = Buffer.from(`${userName}:${password}`).toString('base64');
  const client = got.extend({
    prefixUrl: baseUrl,
    headers: {
      Authorization: `Basic ${auth}`,
    },
    timeout: httpTimeout,
    retry: httpRetry,
  });
  const resp = await client.get<any>(path);
  if (resp.statusCode < 200 || resp.statusCode >= 300) {
    throw new Error('fh query failed');
  }
  return resp;
}
