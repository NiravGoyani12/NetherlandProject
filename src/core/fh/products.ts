/* eslint-disable import/prefer-default-export */

import xmlParser from 'fast-xml-parser';
import { getCurrentDateTime, fhRequest, FHQueryItem } from './utils';

/**
 * It will return product style colours which contains "Check Store Availaibility" feature in PDP
 * As @Rebecca's comment, it's only works for DE locale
 * @param baseUrl
 * @param userName
 * @param password
 * @param brand
 * @param locale
 * @param storeId
 * @param languageLocaleName
 * @param platform
 * @param count
 * @returns a list of style colour part number
 */
export async function getProductStyleColoursWithStoreAvailaibility(
  baseUrl: string,
  userName: string,
  password: string,
  brand: string,
  locale: string,
  storeId: string,
  languageLocaleName: string,
  platform: string,
  count: number,
  sizeAttrExpression: string,
): Promise<Array<string>> {
  // TODO: double check universe index for prod-stag and systest
  const universeIndex = brand === 'th' ? 0 : 1; // temporary workaround to call proper universe depending on brand
  languageLocaleName = languageLocaleName.trim();
  locale = locale.toLocaleLowerCase();
  const path = `/query?method=getAll&fh_location=//${brand}/${languageLocaleName}/countries_pvh%3E{${locale}}/clickreserve=${storeId}/${sizeAttrExpression}`
      + '&fh_view=lister' // the view type, this need to be set to lister
      + `&fh_view_size=${count}` // up to 150(confirmed with Otto)
      // + '&fh_displayfields_mode=none' // will only return secondid
      + '&fh_suppress=url-params,campaigns,redirect,facets' // will suppress the campaigns, redirect and facets and the URL-params is suppressed.
      + `&${brand}_device=${platform}` // devide type, optional,  can be desktop, tablet, mobile
      + `&${brand}_date_time=${getCurrentDateTime()}` // current date and time
      + `&${brand}_country=${locale}` // specific country,not used currently
      + `&${brand}_isavailable=1` // only return available product
      + `&${brand}_page_template=plp`;

  const resp = await fhRequest(
    userName,
    password,
    baseUrl,
    path,
  );

  const result = xmlParser.parse(resp.body, {
    arrayMode: 'strict',
    ignoreAttributes: false,
  });
  try {
    const list = result.page[0].universes[0].universe[universeIndex]['items-section'][0].items[0].item as Array<FHQueryItem>;
    const listOfStyleColourPartNumber = list.map((s) => (s.attribute as any).find(
      (d) => d['@_name'][0] === 'partnumber',
    ).value[0]['#text'][0]);
    return listOfStyleColourPartNumber;
  } catch (e) {
    return [];
  }
}
