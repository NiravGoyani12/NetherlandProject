import got from 'got/dist/source';
import { GetTestLogger } from '../logger/test.logger';

/* eslint-disable import/prefer-default-export */
export async function getRandomSapInStockProductItems(
  brand: string, inventoryMin: number,
): Promise<string[]> {
  /* to renew auth token run
  auth = 'Basic ' + Buffer.from('<userName>:<password>').toString('base64');
  */
  const authToken = 'Basic V0NTVVNFUjpwYTU1d29yZDI0SnVs';
  /* Request parameters */
  const brandParam = brand === 'ck' ? 'calvinklein' : 'tommy';
  const locationParam = brand === 'ck' ? '7999' : '1999';
  const inventoryMinParam = inventoryMin.toString().trim();
  const endpointUrl = `https://uat.api-${brandParam}.dev.b2cecom.eu.pvh.cloud/inventory/store`;
  const filterParam = `$filter=(Location eq '${locationParam}') and (CurrentStock gt ${inventoryMinParam})`;
  const topParam = '$top=250';
  const selectParam = '$select=InternationalArticleNumber';

  const client = got.extend({
    headers: {
      Authorization: authToken,
    },
  });
  try {
    const response = await client.get<any>(`${endpointUrl}?$format=json&${topParam}&${filterParam}&${selectParam}`, { responseType: 'json' });
    if (response.body.errorMessage) {
      GetTestLogger().info(`Fetching product items from SAP request had problems. Error message: ${response.body.errorMessage}. Status: ${response.statusCode}`);
    }
    const sapResults = response.body.d.results;
    const sapEanList = sapResults.map((result) => result.InternationalArticleNumber);
    return sapEanList;
  } catch (e) {
    throw new Error(`Fetching product items from SAP request failed. Status: ${e.response.statusCode}
  Response body: 
  ${e.response.body}`);
  }
}

export async function getSpecificSapInStockProductItems(
  brand: string, inventoryMin: number, eans: string[],
): Promise<string[]> {
  /* to renew auth token run
  auth = 'Basic ' + Buffer.from('<userName>:<password>').toString('base64');
  */
  const authToken = 'Basic V0NTVVNFUjpwYTU1d29yZDI0SnVs';
  /* Request parameters */
  const brandParam = brand === 'ck' ? 'calvinklein' : 'tommy';
  const locationParam = brand === 'ck' ? '7999' : '1999';
  const inventoryMinParam = inventoryMin.toString().trim();
  const endpointUrl = `https://uat.api-${brandParam}.dev.b2cecom.eu.pvh.cloud/inventory/store`;
  let eanFilter = '';
  eans.forEach((ean) => {
    eanFilter = `${eanFilter} InternationalArticleNumber eq '${ean}' or`;
  });
  eanFilter = `(${eanFilter.slice(0, -3)})`;
  const filterParam = `$filter=(Location eq '${locationParam}') and (CurrentStock gt ${inventoryMinParam}) and ${eanFilter}`;
  const selectParam = '$select=InternationalArticleNumber';

  const client = got.extend({
    headers: {
      Authorization: authToken,
    },
  });
  try {
    const response = await client.get<any>(`${endpointUrl}?$format=json&${filterParam}&${selectParam}`, { responseType: 'json' });
    if (response.body.errorMessage) {
      GetTestLogger().info(`Fetching product items from SAP request had problems. Error message: ${response.body.errorMessage}. Status: ${response.statusCode}`);
    }
    const sapResults = response.body.d.results;
    const sapEanList = sapResults.map((result) => result.InternationalArticleNumber);
    return sapEanList;
  } catch (e) {
    throw new Error(`Fetching product items from SAP request failed. Status: ${e.response.statusCode}
  Response body: 
  ${e.response.body}`);
  }
}
