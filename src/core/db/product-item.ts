import { Singleton } from 'typescript-ioc';
import { Products, DetailTemp, ProductItemDetail } from './product-model';
import ProductBase from './product-base';
import EnvService from '../services/env.service';
import DBService from '../services/db.service';
import { SiteService } from '../services/site.service';
import ProductParser from './product-parser';
import { getRandomSapInStockProductItems } from '../sap/product-item-stock';

@Singleton
export default class ProductItem extends ProductBase {
  public details: Map<string, ProductItemDetail>;

  private defaultRecordsCount = 40;

  private defaultResultCount = 40;

  constructor(env: EnvService,
    db: DBService,
    site: SiteService,
    parser: ProductParser) {
    super(env, db, site, parser);
    this.details = new Map();
  }

  public async getDetail(skuPartNumber: string) {
    const detail = this.details.get(skuPartNumber);
    if (!detail) {
      await this.fetchProductItemDetail(skuPartNumber);
    }
    return this.details.get(skuPartNumber);
  }

  public extractWidthLenghNames(details: ProductItemDetail[]) {
    const widthNames: Map<string, boolean> = new Map();
    const lengthNames: Map<string, boolean> = new Map();

    details.forEach((d) => {
      if (d.WIDTH_NAME && !widthNames.get(d.WIDTH_NAME)) {
        widthNames.set(d.WIDTH_NAME, true);
      }
      if (d.LENGTH_NAME && !lengthNames.get(d.LENGTH_NAME)) {
        lengthNames.set(d.LENGTH_NAME, true);
      }
    });
    return {
      widthList: Array.from(widthNames.keys()),
      lengthList: Array.from(lengthNames.keys()),
    };
  }

  public async fetchProductItemDetail(skuPartNumber: string) {
    const tradePoscnId = await this.GetTradePoscnId(this.site.locale);
    const query = `WITH query2 AS
                      (SELECT *
                      FROM B2CEUSWC.XMQTCATENTRELDATA CT
                      WHERE SKU_PARTNUMBER = '${skuPartNumber}'),
                        query3 AS
                      (SELECT IDENTIFIER
                      FROM B2CEUSWC.CATGROUP
                      WHERE CATGROUP_ID IN
                          (SELECT CATGROUP_ID
                            FROM B2CEUSWC.CATGPENREL
                            WHERE CATENTRY_ID =
                                (SELECT STYLE_ID
                                FROM query2)
                              AND CATALOG_ID IN
                                (SELECT CATALOG_ID
                                FROM B2CEUSWC.CATALOG
                                WHERE IDENTIFIER = 'PVHExtendedSitesCatalogAssetStore') ))
                    SELECT STYLE_ID,
                          STYLE_PARTNUMBER,
                          STYLECOLOUR_PARTNUMBER,
                          SKU_PARTNUMBER,
                          QUANTITY,
                          CP.CURRENCY,
                          CP.CURRENTPRICE,
                          CP.WASPRICE,
                          ARV.IDENTIFIER,
                          ARVDESC.STRINGVALUE,
                          XL.LOCAL_VALUE,
                          XLDEFAULT.LOCAL_VALUE AS DEFAULT_LOCAL_VALUE
                    FROM query2 CT
                    LEFT JOIN B2CEUSWC.INVENTORY INV ON CT.SKU_ID = INV.CATENTRY_ID
                    AND INV.QUANTITYMEASURE = 'C62'
                    AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID}
                    LEFT JOIN B2CEUSWC.CATENTRYATTR CR ON CT.SKU_ID = CR.CATENTRY_ID AND CR.USAGE = 1
                    LEFT JOIN B2CEUSWC.ATTRVAL ARV ON CR.ATTRVAL_ID = ARV.ATTRVAL_ID
                    LEFT JOIN B2CEUSWC.ATTRVALDESC ARVDESC ON CR.ATTRVAL_ID = ARVDESC.ATTRVAL_ID
                    AND ARVDESC.LANGUAGE_ID = '${this.site.siteInfo.LANGUAGE_ID}'
                    LEFT JOIN B2CEUSWC.XLOCALSIZE XL ON XL."SIZE" = ARVDESC.STRINGVALUE
                    AND XL.STOREENT_ID = ${this.site.siteInfo.STORE_ID}
                    AND XL.MH_IDENTIFIER IN
                      (SELECT*
                      FROM query3)
                    LEFT JOIN B2CEUSWC.XLOCALSIZE XLDEFAULT ON XLDEFAULT."SIZE" = ARVDESC.STRINGVALUE
                    AND XLDEFAULT.STOREENT_ID = ${this.site.siteInfo.MAIN_STORE_ID}
                    AND XLDEFAULT.MH_IDENTIFIER IN
                      (SELECT*
                            FROM query3)
                    LEFT JOIN B2CEUSWC.XMQTSKUPRICEDATA CP ON CP.CATENTRY_ID = INV.CATENTRY_ID
                    AND CP.TRADEPOSCN_ID = ${tradePoscnId}
                    WITH UR
                  `;
    const results: Array<DetailTemp> = await this.db.query(query);
    if (!results || results.length <= 0) {
      throw new Error(`Cannot fetch product item detail for ${skuPartNumber}`);
    }
    let r = results[0];
    const productItemDetail: ProductItemDetail = {
      STYLE_PARTNUMBER: r.STYLE_PARTNUMBER,
      STYLECOLOUR_PARTNUMBER: r.STYLECOLOUR_PARTNUMBER,
      SKU_PARTNUMBER: r.SKU_PARTNUMBER,
      QUANTITY: r.QUANTITY,
      CURRENCY: r.CURRENCY,
      CURRENTPRICE: Number(r.CURRENTPRICE),
      WASPRICE: r.WASPRICE ? Number(r.WASPRICE) : null,
    };

    for (let i = 0; i < results.length; i += 1) {
      r = results[i];
      const identifier = r.IDENTIFIER.toLowerCase();
      if (identifier.startsWith('size')) {
        if (identifier.startsWith('sizewidth')) {
          productItemDetail.WIDTH_NAME = this.getSizeName(
            r.LOCAL_VALUE,
            r.DEFAULT_LOCAL_VALUE,
            r.STRINGVALUE,
          );
        } else if (identifier.startsWith('sizelength')) {
          productItemDetail.LENGTH_NAME = this.getSizeName(
            r.LOCAL_VALUE,
            r.DEFAULT_LOCAL_VALUE,
            r.STRINGVALUE,
          );
        } else {
          productItemDetail.SIZE_NAME = this.getSizeName(
            r.LOCAL_VALUE,
            r.DEFAULT_LOCAL_VALUE,
            r.STRINGVALUE,
          );
        }
      } else if (identifier.indexOf('attr_colour') >= 0) {
        productItemDetail.COLOUR_NAME = r.STRINGVALUE;
      }
    }
    this.details.set(skuPartNumber, productItemDetail);
  }

  public async getAnyProductItem(
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ): Promise<void> {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    if (isFHFiltered) {
      this.validFHFilter(resultCount);
    }
    if (resultCount === 1 && !isFHFiltered) {
      resultCount = this.defaultResultCount;
    }
    const query = `
                       SELECT DISTINCT CT.STYLE_ID,
                                       CT.STYLE_PARTNUMBER,
                                       CT.STYLECOLOUR_ID,
                                       CT.STYLECOLOUR_PARTNUMBER,
                                       CT.SKU_ID,
                                       CT.SKU_PARTNUMBER
                       FROM B2CEUSWC.XMQTCATENTRELDATA CT
                       JOIN B2CEUSWC.INVENTORY INV ON CT.SKU_ID = INV.CATENTRY_ID
                       JOIN B2CEUSWC.XMQTSKUPRICEDATA CP ON CP.CATENTRY_ID = CT.SKU_ID
                       AND INV.QUANTITYMEASURE = 'C62'
                       AND CP.CURRENTPRICE IS NOT NULL
                       AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID}
                       AND INV.QUANTITY >= ${inventoryMin}
                       AND INV.QUANTITY <= ${inventoryMax} FETCH FIRST ${isFHFiltered ? this.defaultRecordsCount : resultCount} ROWS ONLY`;
    const results: Products = await this.db.query(query);
    if (results.length === 0) {
      throw Error('No product items returned from DB');
    }
    if (isFHFiltered) {
      const fhResults = await this.getFHResult(results, resultCount);
      this.parser.save(fhResults);
    } else if (resultCount === this.defaultResultCount) {
      this.parser.save(results.splice(Math.floor(Math.random() * results.length), 1));
    } else {
      this.parser.save(results);
    }
  }

  public async getAnyProductItemFilteredBySap(
    inventoryMin: number = 0,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ): Promise<void> {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    if (isFHFiltered) {
      this.validFHFilter(resultCount);
    }
    if (resultCount === 1 && !isFHFiltered) {
      resultCount = this.defaultResultCount;
    }
    const brand = this.env.Brand;
    const sapEans = (await getRandomSapInStockProductItems(brand, inventoryMin)).join(',');
    const query = `
      SELECT DISTINCT CT.STYLE_ID,
      CT.STYLE_PARTNUMBER,
      CT.STYLECOLOUR_ID,
      CT.STYLECOLOUR_PARTNUMBER,
      CT.SKU_ID,
      CT.SKU_PARTNUMBER
      FROM B2CEUSWC.XMQTCATENTRELDATA CT
      JOIN B2CEUSWC.INVENTORY INV ON CT.SKU_ID = INV.CATENTRY_ID
      JOIN B2CEUSWC.XMQTSKUPRICEDATA CP ON CP.CATENTRY_ID = CT.SKU_ID
      AND INV.QUANTITYMEASURE = 'C62'
      AND CP.CURRENTPRICE IS NOT NULL
      AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID}
      AND INV.QUANTITY >= ${inventoryMin}
      WHERE SKU_PARTNUMBER in (${sapEans}) 
      FETCH FIRST ${isFHFiltered ? this.defaultRecordsCount : resultCount} ROWS ONLY
      WITH UR`;
    const results: Products = await this.db.query(query);
    if (results.length < resultCount) {
      throw new Error(`Expected to get ${resultCount} products available in SAP and DB, but got only ${results.length}`);
    }
    if (isFHFiltered) {
      const fhResults = await this.getFHResult(results, resultCount);
      this.parser.save(fhResults);
    } else if (resultCount === this.defaultResultCount) {
      this.parser.save(results.splice(Math.floor(Math.random() * results.length), 1));
    } else {
      this.parser.save(results);
    }
  }

  public async getProductWithSpecificWasPrice(
    percentageInDecimal: number,
    minCurrentPrice: number = 1,
    maxCurrentPrice: number = 10000,
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
    isSAPFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    if (percentageInDecimal < 0 || percentageInDecimal > 1) {
      throw new Error('the percentage should be in decimal format between 0 and 1');
    }
    const tradePoscnId = await this.GetTradePoscnId(this.site.locale);
    const wasPriceFilter = percentageInDecimal === 1 ? 'AND CP.WASPRICE IS NULL' : `AND CP.WASPRICE * ${percentageInDecimal} = CP.CURRENTPRICE`;
    const query = `WITH query1 AS
                  (SELECT STYLE_ID,
                          STYLE_PARTNUMBER,
                          STYLECOLOUR_ID,
                          STYLECOLOUR_PARTNUMBER,
                          SKU_ID,
                          SKU_PARTNUMBER
                  FROM B2CEUSWC.XMQTCATENTRELDATA CT
                  LEFT JOIN B2CEUSWC.XMQTSKUPRICEDATA CP ON CP.CATENTRY_ID = CT.SKU_ID
                  AND CP.TRADEPOSCN_ID = ${tradePoscnId}
                  WHERE CP.CURRENTPRICE >= ${minCurrentPrice}
                    AND CP.CURRENTPRICE <= ${maxCurrentPrice - 1}
                    ${wasPriceFilter}
                  )
                SELECT DISTINCT STYLE_ID,
                                STYLE_PARTNUMBER,
                                STYLECOLOUR_ID,
                                STYLECOLOUR_PARTNUMBER,
                                SKU_ID,
                                SKU_PARTNUMBER
                FROM query1 AS CT
                LEFT JOIN B2CEUSWC.INVENTORY INV ON CT.SKU_ID = INV.CATENTRY_ID
                AND INV.QUANTITYMEASURE = 'C62'
                AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID}
                WHERE INV.QUANTITY >= ${inventoryMin} AND INV.QUANTITY <= ${inventoryMax} FETCH FIRST ${(isFHFiltered || isSAPFiltered) ? this.defaultRecordsCount : resultCount} ROWS ONLY`;
    const results: Products = await this.db.query(query);
    if (results.length === 0) {
      throw Error('No product items returned from DB');
    }
    let sapResult: Products = null;
    if (isSAPFiltered) {
      sapResult = await this.getSapResult(results, resultCount, inventoryMin);
    }
    if (isFHFiltered) {
      const fhResults = await this.getFHResult(sapResult || results, resultCount);
      this.parser.save(fhResults);
    } else {
      if (sapResult) {
        sapResult = sapResult.slice(0, resultCount);
      }
      this.parser.save(sapResult || results);
    }
  }

  public async getProductWithWasPrice(
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
    isSAPFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    const tradePoscnId = await this.GetTradePoscnId(this.site.locale);
    const query = `WITH query1 AS
                  (SELECT STYLE_ID,
                          STYLE_PARTNUMBER,
                          STYLECOLOUR_ID,
                          STYLECOLOUR_PARTNUMBER,
                          SKU_ID,
                          SKU_PARTNUMBER
                  FROM B2CEUSWC.XMQTCATENTRELDATA CT
                  LEFT JOIN B2CEUSWC.XMQTSKUPRICEDATA CP ON CP.CATENTRY_ID = CT.SKU_ID
                  AND CP.TRADEPOSCN_ID = ${tradePoscnId}
                  WHERE CP.WASPRICE > 0 AND CP.WASPRICE <> CP.CURRENTPRICE
                  )
                SELECT STYLE_ID,
                      STYLE_PARTNUMBER,
                      STYLECOLOUR_ID,
                      STYLECOLOUR_PARTNUMBER,
                      SKU_ID,
                      SKU_PARTNUMBER
                FROM query1 AS CT
                LEFT JOIN B2CEUSWC.INVENTORY INV ON CT.SKU_ID = INV.CATENTRY_ID
                AND INV.QUANTITYMEASURE = 'C62'
                AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID}
                WHERE INV.QUANTITY >= ${inventoryMin} AND INV.QUANTITY <= ${inventoryMax} FETCH FIRST ${(isFHFiltered || isSAPFiltered) ? this.defaultRecordsCount : resultCount} ROWS ONLY`;
    const results: Products = await this.db.query(query);
    if (results.length === 0) {
      throw Error('No product items returned from DB');
    }
    let sapResult: Products = null;
    if (isSAPFiltered) {
      sapResult = await this.getSapResult(results, resultCount, inventoryMin);
    }
    if (isFHFiltered) {
      const fhResults = this.env.Brand.toLocaleLowerCase() === 'ck' ? await this.getFHDiscountedResult(sapResult || results, resultCount) : await this.getFHResult(sapResult || results, resultCount);
      this.parser.save(fhResults);
    } else {
      if (sapResult) {
        sapResult = sapResult.slice(0, resultCount);
      }
      this.parser.save(sapResult || results);
    }
  }

  public async getProductItemWithPendingPrice(
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    const tradePoscnId = await this.GetTradePoscnId(this.site.locale);
    const query = `WITH query1 AS
                    (SELECT STYLE_ID,
                            STYLE_PARTNUMBER,
                            STYLECOLOUR_ID,
                            STYLECOLOUR_PARTNUMBER,
                            SKU_ID,
                            SKU_PARTNUMBER
                    FROM B2CEUSWC.XMQTCATENTRELDATA CT
                    LEFT JOIN B2CEUSWC.XMQTSKUPRICEDATA CP ON CP.CATENTRY_ID = CT.SKU_ID
                    AND CP.TRADEPOSCN_ID = ${tradePoscnId}
                    WHERE CP.CURRENTPRICE IS NULL)
                  SELECT STYLE_ID,
                        STYLE_PARTNUMBER,
                        STYLECOLOUR_ID,
                        STYLECOLOUR_PARTNUMBER,
                        SKU_ID,
                        SKU_PARTNUMBER
                  FROM query1 AS CT
                  LEFT JOIN B2CEUSWC.INVENTORY INV ON CT.SKU_ID = INV.CATENTRY_ID
                  AND INV.QUANTITYMEASURE = 'C62'
                  AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID}
                  WHERE INV.QUANTITY >= ${inventoryMin} AND INV.QUANTITY <= ${inventoryMax} FETCH FIRST ${isFHFiltered ? this.defaultRecordsCount : resultCount} ROWS ONLY`;
    const results: Products = await this.db.query(query);
    if (results.length === 0) {
      throw Error('No product items returned from DB');
    }
    if (isFHFiltered) {
      const fhResults = await this.getFHResult(results, resultCount);
      this.parser.save(fhResults);
    } else {
      this.parser.save(results);
    }
  }

  public async getProductItemOfStyleOneSize(
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    await this.getProductItemBasedOnStyleAttr("IDENTIFIER = 'Size_OS'", inventoryMin, inventoryMax, resultCount, isFHFiltered);
  }

  public async getProductItemOfStyleNormalSize(
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    const attrExpression = "IDENTIFIER NOT LIKE 'Size_OS%' AND IDENTIFIER NOT LIKE 'SizeLength_%' AND IDENTIFIER NOT LIKE 'SizeWidth_%' AND IDENTIFIER LIKE 'Size_%'";
    await this.getProductItemBasedOnStyleAttr(
      attrExpression, inventoryMin, inventoryMax, resultCount, isFHFiltered,
    );
  }

  public async getProductItemOfStyleMultipleSize(
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    const attrExpression = "IDENTIFIER LIKE 'SizeWidth_%' OR IDENTIFIER LIKE 'SizeLength_%'";
    await this.getProductItemBasedOnStyleAttr(
      attrExpression, inventoryMin, inventoryMax, resultCount, isFHFiltered,
    );
  }

  public async getProductItemOfStyleWidthOnlySize(
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    if (isFHFiltered) {
      this.validFHFilter(resultCount);
    }
    const soldOutTrue = `,query2 AS
    (SELECT CR2.CATENTRY_ID
     FROM B2CEUSWC.CATENTRYATTR CR2
     WHERE CR2.ATTRVAL_ID IN
         (SELECT ATTRVAL_ID
          FROM B2CEUSWC.ATTRVAL
          WHERE IDENTIFIER = 'Soldout_TRUE'))`;
    const isNegativeInventoryCheck = inventoryMin === 0;

    const query = `WITH query0 AS (SELECT ATTRVAL_ID, IDENTIFIER
                    FROM B2CEUSWC.ATTRVAL
                  WHERE IDENTIFIER LIKE 'SizeWidth_%' OR IDENTIFIER LIKE 'SizeLength_%'),
                  query1 AS (select CATENTRY_ID FROM B2CEUSWC.CATENTRYATTR CR 
                  JOIN query0 ON query0.ATTRVAL_ID = CR.ATTRVAL_ID
                  GROUP BY CATENTRY_ID
                  HAVING COUNT(query0.IDENTIFIER) = 1 AND LISTAGG(query0.IDENTIFIER, ',') LIKE 'SizeWidth_%')
                  ${isNegativeInventoryCheck ? soldOutTrue : ''}
                  SELECT DISTINCT CT.STYLE_ID,
                                  CT.STYLE_PARTNUMBER,
                                  CT.STYLECOLOUR_ID,
                                  CT.STYLECOLOUR_PARTNUMBER,
                                  CT.SKU_ID,
                                  CT.SKU_PARTNUMBER
                  FROM B2CEUSWC.XMQTCATENTRELDATA CT
                  JOIN query1 CR ON CT.SKU_ID = CR.CATENTRY_ID
                  ${isNegativeInventoryCheck ? 'JOIN query2 CR2 ON CT.STYLECOLOUR_ID = CR2.CATENTRY_ID' : ''}
                  JOIN B2CEUSWC.INVENTORY INV ON CT.SKU_ID = INV.CATENTRY_ID
                  JOIN B2CEUSWC.XMQTSKUPRICEDATA CP ON CP.CATENTRY_ID = CT.SKU_ID
                  AND INV.QUANTITYMEASURE = 'C62'
                  AND CP.CURRENTPRICE IS NOT NULL
                  AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID}
                  WHERE INV.QUANTITY >= ${inventoryMin} AND INV.QUANTITY <= ${inventoryMax} FETCH FIRST ${isFHFiltered ? this.defaultRecordsCount : resultCount} ROWS ONLY`;
    const results: Products = await this.db.query(query);
    if (results.length === 0) {
      throw Error('No product items returned from DB');
    }
    if (isFHFiltered) {
      const fhResults = await this.getFHResult(results, resultCount);
      this.parser.save(fhResults);
    } else {
      this.parser.save(results);
    }
  }

  private async getProductItemBasedOnStyleAttr(
    attrExpression: string,
    inventoryMin: number,
    inventoryMax: number,
    resultCount: number,
    isFHFiltered: boolean,
  ) {
    if (isFHFiltered) {
      this.validFHFilter(resultCount);
    }
    const soldOutTrue = `query2 AS
    (SELECT CR2.CATENTRY_ID
     FROM B2CEUSWC.CATENTRYATTR CR2
     WHERE CR2.ATTRVAL_ID IN
         (SELECT ATTRVAL_ID
          FROM B2CEUSWC.ATTRVAL
          WHERE IDENTIFIER = 'Soldout_TRUE')),`;
    const isNegativeInventoryCheck = inventoryMin === 0;

    const query = `WITH query1 AS
                    (SELECT CR.CATENTRY_ID
                    FROM B2CEUSWC.CATENTRYATTR CR
                    WHERE CR.ATTRVAL_ID IN
                        (SELECT ATTRVAL_ID
                          FROM B2CEUSWC.ATTRVAL
                          WHERE ${attrExpression})),
                  ${isNegativeInventoryCheck ? soldOutTrue : ''}
                  query3 as (SELECT CT.STYLE_ID,
                        CT.STYLE_PARTNUMBER,
                        CT.STYLECOLOUR_ID,
                        CT.STYLECOLOUR_PARTNUMBER,
                        CT.SKU_ID,
                        CT.SKU_PARTNUMBER
                    FROM B2CEUSWC.XMQTCATENTRELDATA CT
                    JOIN query1 CR ON CT.SKU_ID = CR.CATENTRY_ID
                    ${isNegativeInventoryCheck ? 'JOIN query2 CR2 ON CT.STYLECOLOUR_ID = CR2.CATENTRY_ID' : ''}
                    JOIN B2CEUSWC.INVENTORY INV ON CT.SKU_ID = INV.CATENTRY_ID
                    JOIN B2CEUSWC.XMQTSKUPRICEDATA CP ON CP.CATENTRY_ID = CT.SKU_ID
                    AND INV.QUANTITYMEASURE = 'C62'
                    AND CP.CURRENTPRICE IS NOT NULL
                    AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID}
                    WHERE INV.QUANTITY >= ${inventoryMin} AND INV.QUANTITY <= ${inventoryMax} FETCH FIRST 500 ROWS ONLY)
                    SELECT DISTINCT CT.STYLE_ID,
                      CT.STYLE_PARTNUMBER,
                      CT.STYLECOLOUR_ID,
                      CT.STYLECOLOUR_PARTNUMBER,
                      CT.SKU_ID,
                      CT.SKU_PARTNUMBER
                  FROM query3 as CT
                  LEFT JOIN B2CEUSWC.XMQTSKUPRICEDATA CP ON CP.CATENTRY_ID = CT.SKU_ID
                  WHERE CP.CURRENTPRICE > 0
                  FETCH FIRST ${isFHFiltered ? this.defaultRecordsCount : resultCount} ROWS ONLY`;
    const results: Products = await this.db.query(query);
    if (results.length === 0) {
      throw Error('No product items returned from DB');
    }
    if (isFHFiltered) {
      const fhResults = await this.getFHResult(results, resultCount);
      this.parser.save(fhResults);
    } else {
      this.parser.save(results);
    }
  }

  public async getSoldOutProductItem(
    resultCount: number,
    isFHFiltered: boolean,
  ) {
    if (isFHFiltered) {
      this.validFHFilter(resultCount);
    }
    const attrExpression = "'HideNotifyMe_Yes'";
    const soldOutTrue = `query2 AS
    (SELECT CR2.CATENTRY_ID
     FROM B2CEUSWC.CATENTRYATTR CR2
     WHERE CR2.ATTRVAL_ID IN
         (SELECT ATTRVAL_ID
          FROM B2CEUSWC.ATTRVAL
          WHERE IDENTIFIER = 'Soldout_TRUE'))`;
    const query = `with query1 as 
    (
      SELECT C.CATENTRY_ID
      FROM B2CEUSWC.CATENTRY C
      WHERE C.FIELD1 = 3
      AND C.CATENTRY_ID IN 
        (
          SELECT CA.CATENTRY_ID
          FROM B2CEUSWC.CATENTRYATTR CA
          WHERE CA.ATTRVAL_ID IN 
          (
              SELECT A.ATTRVAL_ID
              FROM B2CEUSWC.ATTRVAL A
              WHERE A.IDENTIFIER like ${attrExpression}))), 
              ${soldOutTrue}
    SELECT DISTINCT
      CT.STYLE_ID,
      CT.STYLE_PARTNUMBER,
      CT.STYLECOLOUR_ID,
      CT.STYLECOLOUR_PARTNUMBER 
    FROM
      B2CEUSWC.XMQTCATENTRELDATA CT 
      JOIN query1 on CT.STYLECOLOUR_ID = query1.CATENTRY_ID
      JOIN query2 on CT.STYLECOLOUR_ID = query2.CATENTRY_ID
      GROUP BY
      STYLE_ID,
      STYLE_PARTNUMBER,
      STYLECOLOUR_ID,
      STYLECOLOUR_PARTNUMBER
      FETCH FIRST ${isFHFiltered ? this.defaultRecordsCount : resultCount} ROWS ONLY
    `;
    const results: Products = await this.db.query(query);
    if (results.length === 0) {
      throw Error('No product items returned from DB');
    }
    if (isFHFiltered) {
      const fhResults = await this.getFHResult(results, resultCount);
      this.parser.save(fhResults);
    } else if (resultCount === this.defaultResultCount) {
      this.parser.save(results.splice(Math.floor(Math.random() * results.length), 1));
    } else {
      this.parser.save(results);
    }
  }

  public async getProductItemOfOneSizeFindInStore(
    resultCount: number = 1,
  ) {
    await this.getProductItemOfFindInStoreProduct("IDENTIFIER = 'Size_OS'", resultCount);
  }

  public async getProductItemOfNormalSizeFindInStore(
    resultCount: number = 1,
  ) {
    await this.getProductItemOfFindInStoreProduct("IDENTIFIER NOT LIKE 'Size_OS%' AND IDENTIFIER NOT LIKE 'SizeLength_%' AND IDENTIFIER NOT LIKE 'SizeWidth_%' AND IDENTIFIER LIKE 'Size_%'", resultCount);
  }

  public async getProductItemOfFindInStoreProduct(
    attrValExpression: string,
    resultCount: number = 1,
  ) {
    const query = `WITH query1 AS
                  (
                    SELECT CR.CATENTRY_ID
                    FROM B2CEUSWC.CATENTRYATTR CR
                    WHERE CR.ATTRVAL_ID IN
                    (
                      SELECT ATTRVAL_ID
                      FROM B2CEUSWC.ATTRVAL
                      WHERE ${attrValExpression})),     
                  query2 AS
                    (
                      SELECT C.STYLE_ID,
                             C.STYLECOLOUR_ID,
                             C.STYLECOLOUR_PARTNUMBER,
                             C.SKU_ID,
                             C.SKU_PARTNUMBER
                      FROM B2CEUSWC.XMQTCATENTRELDATA C
                      JOIN query1 CR ON C.SKU_ID = CR.CATENTRY_ID
                      JOIN B2CEUSWC.CATGPENREL CG ON C.STYLECOLOUR_ID= CG.CATENTRY_ID
                      JOIN B2CEUSWC.CATALOG C ON CG.CATALOG_ID=C.CATALOG_ID AND C.IDENTIFIER LIKE CONCAT('TH','%'))
                  SELECT
                    DISTINCT query2.STYLE_ID AS STYLE_ID,
                    'p' || query2.STYLECOLOUR_ID AS CATENTRY_ID,
                    query2.STYLECOLOUR_PARTNUMBER AS STYLECOLOUR_PARTNUMBER,
                    query2.SKU_PARTNUMBER AS SKU_PARTNUMBER,
                    'clickreserve' AS ATTR_IDENTIFIER
                    FROM query2
                    JOIN B2CEUSWC.XSTOREASSORTMENT X ON query2.STYLECOLOUR_ID = X.CATENTRY_ID
                    AND X.STORE_ID = ${this.site.siteInfo.STORE_ID}
                    FETCH FIRST ${resultCount} ROWS ONLY`;

    const results: Products = await this.db.query(query);
    this.parser.save(results);
  }
}
