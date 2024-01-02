import { Singleton, Inject } from 'typescript-ioc';
import EnvService from '../services/env.service';
import DBService from '../services/db.service';
import { SiteService } from '../services/site.service';
import {
  XCOMREG, ShippingPromoThreshold, SEOUrl, RedirectSEOUrl, CTXMGMT,
} from './product-model';
import { GetTestLogger } from '../logger/test.logger';
import TestCache from '../test-cache';

@Singleton
export default class OthersDB extends TestCache {
  constructor(
    @Inject private env: EnvService,
    @Inject private db: DBService,
    @Inject private site: SiteService,
  ) {
    super();
  }

  public async GetXComReg(name: string) {
    const cacheKey = `getxcomreg${name}${this.site.siteInfo.STORE_ID}`;
    const cacheValue = this.getFromCache<string>(cacheKey);
    if (cacheValue) {
      return cacheValue;
    }
    const query = `SELECT NAME,
                      VALUE,
                      OVERRIDE_VALUE
                    FROM B2CEUSWC.XCOMREG
                    WHERE NAME = '${name}'
                    AND STOREENT_ID=${this.site.siteInfo.STORE_ID}`;
    const result: Array<XCOMREG> = await this.db.query(query);
    if (result.length === 1) {
      let value = 'false';
      if (name.includes('injection')) {
        if (result[0].VALUE) {
          value = 'true';
        }
      } else {
        value = result[0].OVERRIDE_VALUE || result[0].VALUE;
      }
      this.logger.info(`[DB] Retrieve XCOMREG ${name} with value ${value}`);
      this.saveToCache(cacheKey, value);
      return value;
    }
    throw new Error(`Cannot get XCOMREG attribute ${name}`);
  }

  public async UpdateCtxMgmtByDays(callerid: string, numberOfDays: number) {
    const query = `UPDATE B2CEUSWC.CTXMGMT CM SET CM.LASTACCESSTIME= LASTACCESSTIME -  ${numberOfDays} DAYS,CM.STATUS='A' WHERE CM.CALLER_ID IN ('${callerid}')`;
    await this.db.query(query);
    this.logger.info(`[DB] updated the LASTACCESSTIME for ${callerid}`);
  }

  public async DeleteCtxMgmt(callerid: string) {
    const query = `DELETE FROM B2CEUSWC.CTXMGMT CM WHERE CM.STATUS='A' AND CM.CALLER_ID='${callerid}'`;
    await this.db.query(query);
    this.logger.info(`[DB] deleted the entry for ${callerid}`);
  }

  public async UpdateStatusCtxMgmt(callerid: string, status: string) {
    const query = `UPDATE B2CEUSWC.CTXMGMT CM SET CM.STATUS='${status}' WHERE CM.CALLER_ID='${callerid}'`;
    await this.db.query(query);
    this.logger.info(`[DB] updated status for ${callerid}`);
  }

  public async GetCtxMgmt(callerid: string) {
    const query = `SELECT * FROM B2CEUSWC.CTXMGMT CM WHERE CM.CALLER_ID='${callerid}'`;
    await this.db.query(query);
    const result: Array<CTXMGMT> = await this.db.query(query);
    return result;
  }

  public async GetShippingPromoThreshold() {
    const cacheKey = `getshippingpromothreshold${this.site.siteInfo.STORE_ID}`;
    const cacheValue = this.getFromCache<number>(cacheKey);
    if (cacheValue) {
      return cacheValue;
    }
    const query = `SELECT MIN(B2CEUSWC.px_elementnvp.value) AS THRESHOLD
                  FROM B2CEUSWC.shpmodclcd,
                    B2CEUSWC.clcdpromo,
                    B2CEUSWC.px_promotion,
                    B2CEUSWC.px_element,
                    B2CEUSWC.px_elementnvp
                  WHERE B2CEUSWC.shpmodclcd.shipmode_id IN
                  (SELECT shipmode_id
                    FROM B2CEUSWC.shipmode
                    WHERE storeent_id= ${this.site.siteInfo.STORE_ID})
                  AND B2CEUSWC.px_promotion.cdrequired = 0
                  AND B2CEUSWC.clcdpromo.calcode_id = B2CEUSWC.shpmodclcd.calcode_id
                  AND B2CEUSWC.px_promotion.px_promotion_id = B2CEUSWC.clcdpromo.px_promotion_id
                  AND B2CEUSWC.px_promotion.status = 1
                  AND B2CEUSWC.px_element.px_promotion_id = B2CEUSWC.px_promotion.px_promotion_id
                  AND B2CEUSWC.px_element.type = 'PurchaseCondition'
                  AND B2CEUSWC.px_element.subtype IN ('OrderLevelFixedShippingDiscountPurchaseCondition')
                  AND B2CEUSWC.px_elementnvp.px_element_id = B2CEUSWC.px_element.px_element_id
                  AND B2CEUSWC.px_elementnvp.name = 'MinimumPurchase' WITH UR`;
    const result: Array<ShippingPromoThreshold> = await this.db.query(query);
    if (result.length === 1) {
      const value = result[0].THRESHOLD;
      this.logger.info(`[DB] Retrieve Shipping Promo Threshold of store ${this.site.siteInfo.STORE_ID} with value ${value}`);
      this.saveToCache(cacheKey, Number(value));
      return Number(value);
    }
    throw new Error(`Cannot get Shipping Promo Threshold for store ${this.site.siteInfo.STORE_ID}`);
  }

  public async GetAllSEOUrls() {
    const query = `SELECT SK.URLKEYWORD AS URL,
                    PL.ADMINNAME
                FROM B2CEUSWC.PLPAGE PL
                JOIN B2CEUSWC.STORE ST ON PL.STOREENT_ID=ST.STORE_ID
                AND ST.STATUS IN (1)
                AND (ST.DIRECTORY LIKE CONCAT('PVH', '%')
                  OR ST.DIRECTORY LIKE CONCAT('${this.env.Brand === 'ck' ? 'Calvin' : 'Tommy'}', '%')
                  OR ST.DIRECTORY LIKE CONCAT('${this.env.Brand.toUpperCase()}', '%'))
                JOIN B2CEUSWC.SEOURL S ON S.TOKENVALUE=PL.PLPAGE_ID
                AND S.TOKENNAME IN ('StaticPagesToken')
                JOIN B2CEUSWC.SEOURLKEYWORD SK ON S.SEOURL_ID=SK.SEOURL_ID
                AND SK.LANGUAGE_ID = ${this.site.siteInfo.LANGUAGE_ID}
    `;
    const result: Array<SEOUrl> = await this.db.query(query);
    return result;
  }

  public async GetRedirectSEOURL(hasEmptyRedirectUrl: boolean, resultCount: number = 1) {
    const query = `WITH PRODUCTS (CATENTRY_ID, BUYABLE, PARTNUMBER) AS
                          (SELECT DISTINCT C.CATENTRY_ID,
                                          C.BUYABLE,
                                          C.PARTNUMBER
                          FROM B2CEUSWC.CATENTRY C
                          JOIN B2CEUSWC.CATGPENREL CG ON C.CATENTRY_ID = CG.CATENTRY_ID
                          AND C.FIELD1=3
                          JOIN B2CEUSWC.CATALOG CA ON CG.CATALOG_ID = CA.CATALOG_ID
                          AND CA.IDENTIFIER LIKE CONCAT('${this.env.Brand === 'ck' ? 'CK' : 'TH'}', '%')),
                            UNBUYABLEPRODUCTSPRIMARYCATEGORYURL (CATENTRY_ID, PRIMARYCATEGORYURL) AS
                          (SELECT DISTINCT UC.CATENTRY_ID,
                                          CAT.CATEGORYURL AS PRIMARYCATEGORYURL
                          FROM B2CEUSWC.XMQTUNPUBLISHEDPRODUCTPRIMARYCATEGORY UC
                          JOIN B2CEUSWC.XMQTCATGRPRELDATA CAT ON UC.CATGROUP_ID_PRIMARY=CAT.CATGROUP_ID
                          AND CAT.LANGUAGE_ID = ${this.site.siteInfo.LANGUAGE_ID})
                        SELECT DISTINCT TRIM(SUBSTR(sk.urlkeyword, LOCATE_IN_STRING(sk.urlkeyword, '|')+1, LENGTH(sk.urlkeyword))) AS PRODUCTURL,
                                        CASE
                                            WHEN C.BUYABLE=0 THEN UC.PRIMARYCATEGORYURL
                                            ELSE NULL
                                        END AS PRIMARYCATEGORYURL
                        FROM PRODUCTS C
                        JOIN B2CEUSWC.SEOURL S ON S.TOKENVALUE = C.CATENTRY_ID
                        AND S.TOKENNAME = 'ProductToken'
                        JOIN B2CEUSWC.SEOURLKEYWORD SK ON (S.SEOURL_ID = SK.SEOURL_ID
                                                  AND SK.STATUS = 1)
                        AND SK.LANGUAGE_ID = ${this.site.siteInfo.LANGUAGE_ID}
                        LEFT OUTER JOIN UNBUYABLEPRODUCTSPRIMARYCATEGORYURL UC ON C.CATENTRY_ID=UC.CATENTRY_ID
                        WHERE BUYABLE = 0 ${hasEmptyRedirectUrl ? 'AND PRIMARYCATEGORYURL IS NULL' : ''}
                        FETCH FIRST ${resultCount} ROWS ONLY
                        WITH UR`;
    const results: Array<RedirectSEOUrl> = await this.db.query(query);
    return results;
  }

  private get logger() { return GetTestLogger(); }
}
