import ProductParser from './product-parser';
import DBService from '../services/db.service';
import { Products } from './product-model';
import EnvService from '../services/env.service';
import { SiteService } from '../services/site.service';
import fh from '../fh';
import TestCache from '../test-cache';
import { GetTestLogger } from '../logger/test.logger';
import { getSpecificSapInStockProductItems } from '../sap/product-item-stock';

export default class ProductBase extends TestCache {
  public GBPC_NAME = '';

  constructor(
    protected env: EnvService,
    protected db: DBService,
    protected site: SiteService,
    protected parser: ProductParser,
  ) {
    super();
    this.GBPC_NAME = this.env.Brand === 'ck' ? 'CKSizeguide' : 'Product_GBPC';
  }

  protected async getFHResult(
    products: Products, resultCount: number, locale?: string, languageLocaleName?: string,
  ) {
    const styleColourIdList = await fh.query(
      this.site.siteInfo.FHInfo.FH_ENDPOINT_URL,
      this.site.siteInfo.FHInfo.FH_USERNAME,
      this.site.siteInfo.FHInfo.FH_PASSWORD,
      products.map((r) => `p${r.STYLECOLOUR_ID}`),
      this.env.Brand,
      locale || this.site.locale,
      languageLocaleName || this.site.siteInfo.LOCALENAME,
      this.env.Platform,
    );
    const validResults = products.filter(
      (r) => styleColourIdList.indexOf(`p${r.STYLECOLOUR_ID}`) >= 0,
    );
    if (validResults.length < resultCount) {
      throw new Error(`Expected to get ${resultCount} FH products, but only ${validResults.length}`);
    }
    // TODO: workaround so that TH and CK don't have same returned items for FH
    if (this.env.Brand === 'ck') {
      return validResults.slice(0, resultCount);
    }
    return validResults.splice(Math.floor(Math.random() * validResults.length), resultCount);
  }

  protected async getFHDiscountedResult(
    products: Products, resultCount: number, locale?: string, languageLocaleName?: string,
  ) {
    const styleColourIdList = await fh.queryOnSale(
      this.site.siteInfo.FHInfo.FH_ENDPOINT_URL,
      this.site.siteInfo.FHInfo.FH_USERNAME,
      this.site.siteInfo.FHInfo.FH_PASSWORD,
      products.map((r) => `p${r.STYLECOLOUR_ID}`),
      this.env.Brand,
      locale || this.site.locale,
      languageLocaleName || this.site.siteInfo.LOCALENAME,
      this.env.Platform,
    );
    const validResults = products.filter(
      (r) => styleColourIdList.indexOf(`p${r.STYLECOLOUR_ID}`) >= 0,
    );
    if (validResults.length < resultCount) {
      throw new Error(`Expected to get ${resultCount} FH products, but only ${validResults.length}`);
    }
    // TODO: workaround so that TH and CK don't have same returned items for FH
    if (this.env.Brand === 'ck') {
      return validResults.slice(0, resultCount);
    }
    return validResults.splice(Math.floor(Math.random() * validResults.length), resultCount);
  }

  protected async getSapResult(
    products: Products, resultCount: number, inventoryMin: number,
  ) {
    const brand = this.env.Brand;
    const sapEanList = await getSpecificSapInStockProductItems(brand, inventoryMin, products
      .map((r) => r.SKU_PARTNUMBER));
    const sapResult: Products = products.filter((r) => sapEanList
      .findIndex((s) => s === r.SKU_PARTNUMBER) >= 0);
    if (sapResult.length < resultCount) {
      throw new Error(`Expected to get ${resultCount} products available in SAP and DB, but got only ${sapResult.length}`);
    }
    return sapResult;
  }

  /**
   * Get correct size name
   * @param localSizeName the translated size name based on current locale storeent_id
   * @param defaultLocalSizeName the translated size name based on main storeent_id
   * @param stringSizeName the origin size name
   */
  protected getSizeName(
    localSizeName: string,
    defaultLocalSizeName: string,
    stringSizeName: string,
  ) {
    if (stringSizeName && !Number.isNaN(+stringSizeName) && localSizeName && localSizeName.toLowerCase().startsWith('w')) {
      return stringSizeName;
    }
    return localSizeName || defaultLocalSizeName || stringSizeName;
  }

  protected validFHFilter(resultCount: number) {
    if (resultCount > 150) {
      throw new Error('FH filter can only be available for result count less then 150');
    }
  }

  protected async GetTradePoscnId(isoCountryCode: string): Promise<string> {
    const directory = this.env.Brand === 'th' ? 'Tommy' : 'CalvinKlein';
    const query = `WITH query1 (STOREENT_ID, TRADEPOSCN_ID) AS
                        (SELECT STPC.STOREENT_ID STOREENT_ID,
                                STPC.TRADEPOSCN_ID TRADEPOSCN_ID
                         FROM B2CEUSWC.STORETPC STPC
                         WHERE STPC.STTPCUSG_ID = 2),
                           query2 (STOREENT_ID, TRADEPOSCN_ID) AS
                        (SELECT B2CEUSWC.STORECNTR.STORE_ID STOREENT_ID,
                                B2CEUSWC.TRADEPOSCN.TRADEPOSCN_ID TRADEPOSCN_ID
                         FROM B2CEUSWC.STORECNTR,
                              B2CEUSWC.TDPSCNCNTR,
                              B2CEUSWC.TRADEPOSCN
                         WHERE B2CEUSWC.STORECNTR.CONTRACT_ID = B2CEUSWC.TDPSCNCNTR.CONTRACT_ID
                           AND B2CEUSWC.TDPSCNCNTR.TRADEPOSCN_ID = B2CEUSWC.TRADEPOSCN.TRADEPOSCN_ID
                           AND B2CEUSWC.TRADEPOSCN.PRECEDENCE=1001),
                           STORETRADEPOSID (STOREENT_ID, TRADEPOSCN_ID) AS
                        (SELECT STOREENT_ID,
                                TRADEPOSCN_ID
                         FROM query1
                         WHERE NOT EXISTS
                             (SELECT 1
                              FROM query2
                              WHERE query1.STOREENT_ID = query2.STOREENT_ID)
                         UNION SELECT STOREENT_ID,
                                      TRADEPOSCN_ID
                         FROM query2)
                      SELECT STORE_ID,
                             TRADEPOSCN_ID
                      FROM STORETRADEPOSID SP
                      LEFT JOIN B2CEUSWC.STORE ST ON SP.STOREENT_ID = ST.STORE_ID
                      WHERE DIRECTORY = '${directory}${isoCountryCode.toUpperCase()}'
      `;
    const result: Array<{ STORE_ID: string, TRADEPOSCN_ID: string }> = await this.db.query(query);
    if (result) {
      return result[0].TRADEPOSCN_ID;
    }
    throw new Error(`Cannot get Tradeposcn with isoCountryCode '${isoCountryCode}'`);
  }

  /**
   * Get the min inventory randomly,
   * When your minInventory === 50, then it will return a random min inventory between (50, 71]
   * When your minInventory === 100, then it will return a random min inventory between (100, 121]
   * @param minInventory the given min inventory
   */
  protected GetRandomMinInventory(minInventory: number) {
    if (minInventory === 50 || minInventory === 100) {
      const newMinInventory = minInventory + Math.ceil(Math.random() * 21);
      GetTestLogger().info(`DB - Update the min inventory from ${minInventory} to ${newMinInventory}`);
      return newMinInventory;
    }
    return minInventory;
  }

  public async GetSEOUrl(styleColourPartNumber: string, langCode: string): Promise<string> {
    const query = `SELECT URLKEYWORD
    FROM B2CEUSWC.SEOURLKEYWORD SK
    LEFT JOIN B2CEUSWC.LANGUAGE LA ON SK.LANGUAGE_ID = LA.LANGUAGE_ID
    WHERE SK.SEOURL_ID IN
        (SELECT SEOURL_ID
         FROM B2CEUSWC.SEOURL
         WHERE TOKENVALUE IN
             (SELECT char(CATENTRY_ID)
              FROM B2CEUSWC.CATENTRY
              WHERE PARTNUMBER = '${styleColourPartNumber}'
                AND TOKENNAME='ProductToken'))
      AND SK.STATUS=1
      AND LA.LOCALENAME = '${langCode.trim()}'`;
    const result: Array<{ URLKEYWORD: string }> = await this.db.query(query);
    if (result) {
      return result[0].URLKEYWORD.split('|')[1];
    }
    return '';
  }
}
