/* eslint-disable import/prefer-default-export */
import xmlParser from 'fast-xml-parser';
import { getCurrentDateTime, FHQueryItem, fhRequest } from './utils';

/**
 * FH Query return only availabled products
 * @param styleColourIdList a list of style colour ID
 * @param brand th | ck
 * @param locale uk | de | etc
 * @param languageLocaleName en_GB | etc
 * @param platform desktop | mobile | tablet
 */
export async function fhQuery(
  baseUrl: string,
  userName: string,
  password: string,
  styleColourIdList: Array<string>,
  brand: string,
  locale: string,
  languageLocaleName: string,
  platform: string,
) {
  // TODO: double check universe index for prod-stag and systest
  const universeIndex = brand === 'th' ? 0 : 1; // temporary workaround to call proper universe depending on brand
  languageLocaleName = languageLocaleName.trim();
  locale = locale.toLocaleLowerCase();
  const path = `/query?method=getAll&fh_location=//${brand}/${languageLocaleName}/countries_pvh%3E{${locale}}/secondid%3C{${styleColourIdList.join(',')}}`
    + '&fh_view=lister' // the view type, this need to be set to lister
    + `&fh_view_size=${styleColourIdList.length}` // up to 150(confirmed with Otto)
    + '&fh_displayfields_mode=none' // will only return secondid, none, live and preview
    + '&fh_suppress=url-params,campaigns,redirect,facets' // will suppress the campaigns, redirect and facets and the URL-params is suppressed.
    + `&${brand}_device=${platform}` // devide type, optional,  can be desktop, tablet, mobile
    + `&${brand}_date_time=${getCurrentDateTime()}` // current date and time
    + `&${brand}_country=${locale}` // specific country,not used currently
    + `&${brand}_isavailable=1` // only return available product
    + `&${brand}_page_template=wishlist`;

  const resp = await fhRequest(
    userName,
    password,
    baseUrl,
    path,
  );
  const result = xmlParser.parse(resp.body);
  try {
    const list = result.page.universes.universe[universeIndex]['items-section'].items.item as Array<FHQueryItem>;
    if (list) {
      if (Array.isArray(list)) {
        return list.map((i) => i.attribute.value);
      }
      return [(list as FHQueryItem).attribute.value];
    }
    return [];
  } catch (e) {
    return [];
  }
}

/**
 * FH Query return only available AND onsale products
 * @param styleColourIdList a list of style colour ID
 * @param brand th | ck
 * @param locale uk | de | etc
 * @param languageLocaleName en_GB | etc
 * @param platform desktop | mobile | tablet
 */
export async function fhQueryOnSale(
  baseUrl: string,
  userName: string,
  password: string,
  styleColourIdList: Array<string>,
  brand: string,
  locale: string,
  languageLocaleName: string,
  platform: string,
) {
  // TODO: double check universe index for prod-stag and systest
  const universeIndex = brand === 'th' ? 0 : 1; // temporary workaround to call proper universe depending on brand
  languageLocaleName = languageLocaleName.trim();
  locale = locale.toLocaleLowerCase();
  const path = `/query?method=getAll&fh_location=//${brand}/${languageLocaleName}/countries_pvh%3E{${locale}}/secondid%3C{${styleColourIdList.join(',')}}`
    + '&fh_view=lister' // the view type, this need to be set to lister
    + `&fh_view_size=${styleColourIdList.length}` // up to 150(confirmed with Otto)
    + '&fh_displayfields_mode=none' // will only return secondid, none, live and preview
    + '&fh_suppress=url-params,campaigns,redirect,facets' // will suppress the campaigns, redirect and facets and the URL-params is suppressed.
    + `&${brand}_device=${platform}` // devide type, optional,  can be desktop, tablet, mobile
    + `&${brand}_date_time=${getCurrentDateTime()}` // current date and time
    + `&${brand}_country=${locale}` // specific country,not used currently
    + `&${brand}_isavailable=1` // only return available product
    + `&${brand}_onsale_${locale}=1` // only return onsale products
    + `&${brand}_page_template=wishlist`;

  const resp = await fhRequest(
    userName,
    password,
    baseUrl,
    path,
  );
  const result = xmlParser.parse(resp.body);
  try {
    const list = result.page.universes.universe[universeIndex]['items-section'].items.item as Array<FHQueryItem>;
    if (list) {
      if (Array.isArray(list)) {
        return list.map((i) => i.attribute.value);
      }
      return [(list as FHQueryItem).attribute.value];
    }
    return [];
  } catch (e) {
    return [];
  }
}
