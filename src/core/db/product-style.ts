import { Singleton } from 'typescript-ioc';
import ProductBase from './product-base';
import {
  Products, DetailTemp, ProductItemDetail, SkuPartNumber, ProductStyleDetail,
} from './product-model';
import EnvService from '../services/env.service';
import DBService from '../services/db.service';
import { SiteService } from '../services/site.service';
import ProductParser from './product-parser';
import fh from '../fh';

@Singleton
export default class ProductStyle extends ProductBase {
  public details: Map<string, ProductStyleDetail>;

  private defaultRecordsCount = 40;

  private defaultResultCount = 40;

  constructor(env: EnvService,
    db: DBService,
    site: SiteService,
    parser: ProductParser) {
    super(env, db, site, parser);
    this.details = new Map();
  }

  public async getDetail(styleColourPartNumber: string) {
    const detail = this.details.get(styleColourPartNumber);
    if (!detail) {
      await this.fetchProductStyleDetail(styleColourPartNumber);
    }
    return this.details.get(styleColourPartNumber);
  }

  public extractMinMaxPrice(detail: ProductStyleDetail) {
    let minPrice = Number.MAX_VALUE;
    let maxPrice = -1;
    let minWasPrice = Number.MAX_VALUE;
    let maxWasPrice = -1;
    let currency: string;
    detail.PRODUCT_ITEM_DICT.forEach((productItem: ProductItemDetail) => {
      if (productItem.CURRENCY) {
        currency = productItem.CURRENCY;
      }
      if (productItem.CURRENTPRICE && productItem.CURRENTPRICE !== 0) {
        if (productItem.CURRENTPRICE < minPrice) {
          minPrice = productItem.CURRENTPRICE;
        }
        if (productItem.CURRENTPRICE > maxPrice) {
          maxPrice = productItem.CURRENTPRICE;
        }
      }
      if (productItem.WASPRICE && productItem.CURRENTPRICE !== 0) {
        if (productItem.WASPRICE < minWasPrice) {
          minWasPrice = productItem.WASPRICE;
        }
        if (productItem.WASPRICE > maxWasPrice) {
          maxWasPrice = productItem.WASPRICE;
        }
      }
    });
    return {
      minCurrentPrice: minPrice,
      maxCurrentPrice: maxPrice,
      minWasPrice,
      maxWasPrice,
      currency,
    };
  }

  public extractFirstProductItem(detail: ProductStyleDetail) {
    return detail.PRODUCT_ITEM_DICT.values().next().value as ProductItemDetail;
  }

  public extractProductItemWithWasPrice(detail: ProductStyleDetail) {
    const values = Array.from(detail.PRODUCT_ITEM_DICT.values());
    const result = values.find((p) => p.WASPRICE > 0);
    if (!result) {
      throw new Error('Cannot fetch product item which has was price');
    }
    return result;
  }

  public extractProductItemWithLowestCurrentPrice(
    detail: ProductStyleDetail,
  ) {
    const values = Array.from(detail.PRODUCT_ITEM_DICT.values());
    const sortedInstockItems = values
      .filter((s) => s.QUANTITY > 0)
      .sort((a, b) => a.CURRENTPRICE - b.CURRENTPRICE);

    return sortedInstockItems[0];
  }

  public extractProductItemWithInventory(
    detail: ProductStyleDetail,
    min: number = 1,
    max: number = 99999,
  ) {
    const values = Array.from(detail.PRODUCT_ITEM_DICT.values());
    const result = values.find((p) => p.QUANTITY >= min && p.QUANTITY <= max);
    if (!result) {
      throw new Error(`Cannot fetch product item which has inventory between ${min} and ${max} included`);
    }
    return result;
  }

  public extractProductItemListWithInventory(
    detail: ProductStyleDetail,
    min: number = 1,
    max: number = 99999,
  ) {
    const values = Array.from(detail.PRODUCT_ITEM_DICT.values());
    const result = values.filter((p) => p.QUANTITY >= min && p.QUANTITY <= max);
    if (!result) {
      throw new Error(`Cannot fetch product item which has inventory between ${min} and ${max} included`);
    }
    return result;
  }

  public extractProductItems(detail: ProductStyleDetail) {
    const values = Array.from(detail.PRODUCT_ITEM_DICT.values());
    return values;
  }

  public async fetchProductStyleDetail(styleColourPartNumber: string) {
    const tradePoscnId = await this.GetTradePoscnId(this.site.locale);
    const query = `With query1 AS (SELECT CATALOG_ID
                      FROM B2CEUSWC.CATALOG
                      WHERE IDENTIFIER = 'PVHExtendedSitesCatalogAssetStore'),
                   query2 AS
                    (SELECT *
                    FROM B2CEUSWC.XMQTCATENTRELDATA CT
                    WHERE STYLECOLOUR_PARTNUMBER = '${styleColourPartNumber}'),
                      query3 AS
                    (SELECT IDENTIFIER
                    FROM B2CEUSWC.CATGROUP
                    WHERE CATGROUP_ID IN
                        (SELECT CATGROUP_ID
                          FROM B2CEUSWC.CATGPENREL
                          WHERE CATENTRY_ID IN
                              (SELECT STYLE_ID FROM query2)
                            AND CATALOG_ID IN
                              (SELECT CATALOG_ID FROM query1) 
                        )
                    )
                  SELECT STYLE_PARTNUMBER,
                        STYLECOLOUR_PARTNUMBER,
                        SKU_PARTNUMBER,
                        QUANTITY,
                        CD.NAME,
                        ENGCD.NAME AS ANALYTICS_NAME,
                        CGD.NAME AS DIVISION,
                        (SELECT CAT.IDENTIFIER AS CATGROUP_PRIMARY_IDENTIFIER FROM B2CEUSWC.XCATGPENREL XCGP
                          INNER JOIN B2CEUSWC.CATGROUP CAT ON CAT.CATGROUP_ID = XCGP.CATGROUP_ID_PRIMARY
                          WHERE XCGP.CATENTRY_ID = STYLECOLOUR_ID
                          AND XCGP.CATALOG_ID = ${this.site.siteInfo.CATALOG_ID}
                        ) AS LIST_PRIMARY,
                        (SELECT CAT.IDENTIFIER AS CATGROUP_ALTERNATE_IDENTIFIER FROM B2CEUSWC.CATGPENREL CGP
                          INNER JOIN B2CEUSWC.CATGRPREL ON CGP.CATGROUP_ID = B2CEUSWC.CATGRPREL.CATGROUP_ID_CHILD
                          INNER JOIN B2CEUSWC.CATGROUP CAT ON CAT.CATGROUP_ID = CGP.CATGROUP_ID
                          WHERE STYLECOLOUR_ID = CGP.CATENTRY_ID AND CGP.CATALOG_ID =  ${this.site.siteInfo.CATALOG_ID}
                          ORDER BY CAT.CATGROUP_ID DESC
                        FETCH FIRST 1 ROW ONLY) AS LIST_ALTERNATE,
                        (SELECT DISTINCT AVDESC.VALUE FROM B2CEUSWC.XMQTCATENTRELDATA XC
                          JOIN B2CEUSWC.CATENTRYATTR CA ON CA.CATENTRY_ID=XC.STYLECOLOUR_ID
                          AND CA.ATTR_ID IN (SELECT ATTR_ID FROM B2CEUSWC.ATTR WHERE IDENTIFIER = '${this.GBPC_NAME}') and XC.STYLECOLOUR_PARTNUMBER='${styleColourPartNumber}'
                          JOIN B2CEUSWC.ATTRVALDESC AVDESC ON AVDESC.ATTRVAL_ID=CA.ATTRVAL_ID FETCH FIRST 1 ROW ONLY) AS GBPC,
                        (SELECT DISTINCT AVDESC.VALUE FROM B2CEUSWC.XMQTCATENTRELDATA XC
                          JOIN B2CEUSWC.CATENTRYATTR CA ON CA.CATENTRY_ID=XC.STYLECOLOUR_ID
                          AND CA.ATTR_ID IN (SELECT ATTR_ID FROM B2CEUSWC.ATTR WHERE IDENTIFIER = 'MainColour') and XC.STYLECOLOUR_PARTNUMBER='${styleColourPartNumber}'
                          JOIN B2CEUSWC.ATTRVALDESC AVDESC ON AVDESC.ATTRVAL_ID=CA.ATTRVAL_ID AND AVDESC.LANGUAGE_ID = 44) AS ANALYTICS_MAIN_COLOUR,
                        (SELECT DISTINCT AVDESC.VALUE FROM B2CEUSWC.XMQTCATENTRELDATA XC
                          JOIN B2CEUSWC.CATENTRYATTR CA ON CA.CATENTRY_ID=XC.STYLECOLOUR_ID
                          AND CA.ATTR_ID IN (SELECT ATTR_ID FROM B2CEUSWC.ATTR WHERE IDENTIFIER = 'MainColour') and XC.STYLECOLOUR_PARTNUMBER='${styleColourPartNumber}'
                          JOIN B2CEUSWC.ATTRVALDESC AVDESC ON AVDESC.ATTRVAL_ID=CA.ATTRVAL_ID AND AVDESC.LANGUAGE_ID = ${this.site.siteInfo.LANGUAGE_ID}) AS MAIN_COLOUR,
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
                  LEFT JOIN B2CEUSWC.CATENTDESC CD ON CD.CATENTRY_ID = CT.STYLECOLOUR_ID AND CD.LANGUAGE_ID=${this.site.siteInfo.LANGUAGE_ID}
                  LEFT JOIN B2CEUSWC.CATENTDESC ENGCD ON ENGCD.CATENTRY_ID = CT.STYLECOLOUR_ID AND ENGCD.LANGUAGE_ID=44
                  LEFT JOIN B2CEUSWC.CATENTRYATTR CR ON CT.SKU_ID = CR.CATENTRY_ID AND CR.USAGE = 1
                  LEFT JOIN B2CEUSWC.ATTRVAL ARV ON CR.ATTRVAL_ID = ARV.ATTRVAL_ID
                  LEFT JOIN B2CEUSWC.ATTRVALDESC ARVDESC ON CR.ATTRVAL_ID = ARVDESC.ATTRVAL_ID
                  AND ARVDESC.LANGUAGE_ID = ${this.site.siteInfo.LANGUAGE_ID}
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
                  LEFT JOIN B2CEUSWC.CATGPENREL CG ON CG.CATENTRY_ID = CT.STYLECOLOUR_ID AND CG.CATALOG_ID IN (SELECT CATALOG_ID FROM query1)
                  LEFT JOIN B2CEUSWC.CATGRPDESC CGD ON CGD.CATGROUP_ID = CG.CATGROUP_ID AND CGD.LANGUAGE_ID = 44
                  WITH UR
                `;
    const results: Array<DetailTemp> = await this.db.query(query);
    if (results.length <= 0) {
      throw new Error(`Cannot fetch product style detail for ${styleColourPartNumber}`);
    }
    const dict = new Map<SkuPartNumber, ProductItemDetail>();
    let totalQuantity = 0;
    let colorName = '';
    results.forEach((r) => {
      let productItemDetail: ProductItemDetail;
      if (dict.get(r.SKU_PARTNUMBER)) {
        productItemDetail = dict.get(r.SKU_PARTNUMBER);
      } else {
        productItemDetail = {
          STYLE_PARTNUMBER: r.STYLECOLOUR_PARTNUMBER,
          STYLECOLOUR_PARTNUMBER: r.STYLECOLOUR_PARTNUMBER,
          SKU_PARTNUMBER: r.SKU_PARTNUMBER,
          QUANTITY: r.QUANTITY,
          CURRENCY: r.CURRENCY,
          CURRENTPRICE: Number(r.CURRENTPRICE),
          WASPRICE: r.WASPRICE ? Number(r.WASPRICE) : null,
        };
        totalQuantity += r.QUANTITY;
      }
      const identifier = r.IDENTIFIER.toLocaleLowerCase();
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
        colorName = r.STRINGVALUE;
      }
      dict.set(r.SKU_PARTNUMBER, productItemDetail);
    });
    const productStyleDetail: ProductStyleDetail = {
      STYLE_PARTNUMBER: results[0].STYLE_PARTNUMBER,
      STYLECOLOUR_PARTNUMBER: results[0].STYLECOLOUR_PARTNUMBER,
      PRODUCT_ITEM_DICT: dict,
      QUANTITY: totalQuantity,
      NAME: results[0].NAME,
      ANALYTICS_NAME: results[0].ANALYTICS_NAME,
      DIVISION: results[0].DIVISION,
      LIST: results[0].LIST_PRIMARY || results[0].LIST_ALTERNATE,
      GBPC: results[0].GBPC,
      ANALYTICS_MAIN_COLOUR: results[0].ANALYTICS_MAIN_COLOUR,
      MAIN_COLOUR: results[0].MAIN_COLOUR,
      COLOUR_NAME: colorName,
    };
    this.details.set(styleColourPartNumber, productStyleDetail);
  }

  public async getProductStyleOfEsteeLauder(
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    const query = "select value from B2CEUSWC.xcomreg where NAME IN ('ESTEE_LAUDER_PDP_PRODUCT_IDS')";
    const results: Array<{ value: string }> = await this.db.query(query);
    if (!results || results.length !== 1) {
      throw new Error('try to get ESTEE_LAUDER_PDP_PRODUCT_IDS failed from DB');
    }
    const list = results[0].value.split(',');
    if (list.length < resultCount) {
      throw new Error(`there is no enough ESTEE_LAUDER products, DB has ${list.length} products,  but you expect ${resultCount}`);
    }

    const query2 = `SELECT DISTINCT STYLE_ID,
                        STYLE_PARTNUMBER,
                        STYLECOLOUR_ID,
                        STYLECOLOUR_PARTNUMBER
                    FROM B2CEUSWC.XMQTCATENTRELDATA
                    WHERE STYLECOLOUR_PARTNUMBER IN (${list.map((s) => `'${s}'`).join(',')}) FETCH FIRST ${isFHFiltered ? this.defaultRecordsCount : resultCount} ROWS ONLY WITH UR`;

    const finalResult: Products = await this.db.query(query2);
    if (isFHFiltered) {
      const fhResults = await this.getFHResult(finalResult, resultCount);
      this.parser.save(fhResults);
    } else {
      this.parser.save(finalResult);
    }
  }

  public async getProductStyleOfMultipleWidthAndSingleLength(
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    if (resultCount === 1 && !isFHFiltered) {
      resultCount = this.defaultResultCount;
    }
    const query = `WITH query0 AS
                  (SELECT CATENTRY_ID,
                          count(ATTRVAL_ID) AS test
                  FROM B2CEUSWC.CATENTRYATTR
                  WHERE ATTRVAL_ID IN
                      (SELECT ATTRVAL_ID
                        FROM B2CEUSWC.ATTRVAL
                        WHERE IDENTIFIER LIKE 'SizeWidth_%'
                          OR IDENTIFIER LIKE 'SizeLength_%')
                  GROUP BY CATENTRY_ID),
                    query1 AS
                  (SELECT CT.STYLE_ID,
                                  CT.STYLE_PARTNUMBER,
                                  CT.STYLECOLOUR_ID,
                                  CT.STYLECOLOUR_PARTNUMBER,
                                  CT.SKU_ID
                  FROM B2CEUSWC.XMQTCATENTRELDATA CT
                  WHERE CT.SKU_ID IN
                      (SELECT DISTINCT CATENTRY_ID
                        FROM query0
                        WHERE TEST = 2) ),
                    query2 AS
                  (SELECT query1.STYLE_ID,
                          query1.STYLE_PARTNUMBER,
                          query1.STYLECOLOUR_ID,
                          query1.STYLECOLOUR_PARTNUMBER,
                          COUNT(DISTINCT ATTRVAL_ID) AS COUNT_LENGTH,
                          SUM(INV.QUANTITY) AS QUANTITY
                  FROM query1
                  JOIN B2CEUSWC.INVENTORY INV ON query1.SKU_ID = INV.CATENTRY_ID
                  AND INV.QUANTITYMEASURE = 'C62'
                  AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID}
                  LEFT JOIN B2CEUSWC.CATENTRYATTR CR ON query1.SKU_ID = CR.CATENTRY_ID
                  AND CR.ATTRVAL_ID IN
                    (SELECT ATTRVAL_ID
                      FROM B2CEUSWC.ATTRVAL
                      WHERE IDENTIFIER LIKE 'SizeLength_%')
                  GROUP BY STYLE_ID, STYLE_PARTNUMBER, STYLECOLOUR_ID, STYLECOLOUR_PARTNUMBER)
                SELECT query2.STYLE_ID,
                          query2.STYLE_PARTNUMBER,
                          query2.STYLECOLOUR_ID,
                          query2.STYLECOLOUR_PARTNUMBER
                FROM query2
                WHERE COUNT_LENGTH = 1 
                AND QUANTITY >= ${inventoryMin}
                AND QUANTITY <= ${inventoryMax} FETCH FIRST ${resultCount} ROWS ONLY
              `;
    const results: Products = await this.db.query(query);
    if (results.length === 0) {
      throw Error('No product styles returned from DB');
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

  public async getProductStyleOfOneSize(
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
    isSAPFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    await this.getProductStyleBasedOnAttr("IDENTIFIER = 'Size_OS'", inventoryMin, inventoryMax, resultCount, isFHFiltered, isSAPFiltered);
  }

  public async getProductSytleOfNormalSize(
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
    isSAPFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    const attrExpression = "IDENTIFIER NOT LIKE 'Size_OS' AND IDENTIFIER LIKE 'Size_%'";
    await this.getProductStyleBasedOnAttr(
      attrExpression, inventoryMin, inventoryMax, resultCount, isFHFiltered, isSAPFiltered,
    );
  }

  public async getProductStyleOfNormalSizeWithSizeStock(
    minOutOfStockSizeCount: number,
    inventoryMin: number = 1,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    const attrExpression = "IDENTIFIER NOT LIKE 'Size_OS' AND IDENTIFIER NOT LIKE 'SizeWidth_%' AND IDENTIFIER NOT LIKE 'SizeLength_%' AND IDENTIFIER LIKE 'Size_%'";
    await this.getProductStyleWithAvaiableSize(
      attrExpression,
      minOutOfStockSizeCount,
      inventoryMin,
      inventoryMax,
      resultCount,
      isFHFiltered,
    );
  }

  public async getProductStyleOfWidthLengthSizeWithSizeStock(
    minOutOfStockSizeCount: number,
    inventoryMin: number = 1,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    const attrExpression = "IDENTIFIER LIKE 'SizeWidth_%' OR IDENTIFIER LIKE 'SizeLength_%'";
    await this.getProductStyleWithAvaiableSize(
      attrExpression,
      minOutOfStockSizeCount,
      inventoryMin,
      inventoryMax,
      resultCount,
      isFHFiltered,
    );
  }

  public async getProductStyleOfMultipleSize(
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
    isSAPFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    const attrExpression = "IDENTIFIER LIKE 'SizeWidth_%' OR IDENTIFIER LIKE 'SizeLength_%'";
    await this.getProductStyleBasedOnAttr(
      attrExpression, inventoryMin, inventoryMax, resultCount, isFHFiltered, isSAPFiltered,
    );
  }

  public async getProductStyleByGBPC(
    gbpc: string,
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    const attrIdentifier = this.GBPC_NAME;
    if (!gbpc.startsWith('%')) {
      // in TH like Product_GBPC_men_sport_coatsjackets_%
      // in CK like CKSizeguide_testabcd_%
      gbpc = `${this.GBPC_NAME}_${gbpc}`;
    }
    const attrValExpression = `LIKE '${gbpc}'`;
    // TODO: to make this function to support different size type IF necessary
    const sizeAttrExpression = '%';
    await this.getProductStyleBasedOnAttrVar(
      attrIdentifier,
      attrValExpression,
      sizeAttrExpression,
      inventoryMin,
      inventoryMax,
      resultCount,
      isFHFiltered,
    );
  }

  public async getProductStyleOfExtraDiscount(
    percent: number,
    groupLocale: string,
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    const groupExpression = `IDENTIFIER LIKE '%BASKETPROMO_${percent}PERCENT_${groupLocale.toUpperCase()}%'`;
    await this.getProductStyleBasedOnGroup(
      groupExpression, inventoryMin, inventoryMax, resultCount, isFHFiltered,
    );
  }

  public async getProductStyleWithSameCurrentPrice(
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    const condition = 'COUNT(DISTINCT(CP.CURRENTPRICE)) = 1 AND COUNT(DISTINCT(CP.WASPRICE)) = 0';
    await this.getProductStyleWithDifferentPrice(condition, false, resultCount, isFHFiltered);
  }

  public async getProductStyleWithSameCurrentPriceAndWasPrice(
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    const condition = 'COUNT(DISTINCT(CP.CURRENTPRICE)) = 1 AND COUNT(DISTINCT(CP.WASPRICE)) = 1';
    await this.getProductStyleWithDifferentPrice(condition, true, resultCount, isFHFiltered);
  }

  public async getProductStyleWithDifferentCurrentPrice(
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    const condition = 'COUNT(DISTINCT(CP.CURRENTPRICE)) > 1 AND COUNT(DISTINCT(CP.WASPRICE)) = 0';
    await this.getProductStyleWithDifferentPrice(condition, false, resultCount, isFHFiltered);
  }

  public async getProductStyleWithDifferentCurrentPriceAndWasPrice(
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    const condition = 'COUNT(DISTINCT(CP.CURRENTPRICE)) > 1 AND COUNT(DISTINCT(CP.WASPRICE)) = 1';
    await this.getProductStyleWithDifferentPrice(condition, true, resultCount, isFHFiltered);
  }

  public async getProductStylesWithStoreAvailability(
    resultCount: number = 1,
    locale: string,
    sizeAttrExpression: string,
  ) {
    const styleColourNumberList = await fh.getStyleColourOfStoreAvailibility(
      this.site.siteInfo.FHInfo.FH_ENDPOINT_URL,
      this.site.siteInfo.FHInfo.FH_USERNAME,
      this.site.siteInfo.FHInfo.FH_PASSWORD,
      this.env.Brand,
      this.site.locale,
      this.site.siteInfo.STORE_ID.toString(),
      this.site.siteInfo.LOCALENAME,
      this.env.Platform,
      resultCount,
      sizeAttrExpression,
    );
    await this.getProductStyleByStyleColourNumbers(styleColourNumberList);
  }

  public async getProductStyleOfWidthOnlySize(
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    if (isFHFiltered) {
      this.validFHFilter(resultCount);
    }
    if (resultCount === 1 && !isFHFiltered) {
      resultCount = this.defaultResultCount;
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
                  SELECT CT.STYLE_ID,
                        CT.STYLE_PARTNUMBER,
                        CT.STYLECOLOUR_ID,
                        CT.STYLECOLOUR_PARTNUMBER
                  FROM B2CEUSWC.XMQTCATENTRELDATA CT
                  JOIN query1 CR ON CT.SKU_ID = CR.CATENTRY_ID
                  ${isNegativeInventoryCheck ? 'JOIN query2 CR2 ON CT.STYLECOLOUR_ID = CR2.CATENTRY_ID' : ''}
                  JOIN B2CEUSWC.INVENTORY INV ON CT.SKU_ID = INV.CATENTRY_ID
                  AND INV.QUANTITYMEASURE = 'C62'
                  AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID}
                  GROUP BY STYLE_ID,
                    STYLE_PARTNUMBER,
                    STYLECOLOUR_ID,
                    STYLECOLOUR_PARTNUMBER
                  HAVING SUM(INV.QUANTITY) >= ${inventoryMin} AND SUM(INV.QUANTITY) <= ${inventoryMax} FETCH FIRST ${isFHFiltered ? this.defaultRecordsCount : resultCount} ROWS ONLY`;
    const results: Products = await this.db.query(query);
    if (results.length === 0) {
      throw Error('No product styles returned from DB');
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

  public async getProductStyleOfCurvedProduct(
    inventoryMin: number = 1,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    if (resultCount === 1 && !isFHFiltered) {
      resultCount = this.defaultResultCount;
    }
    const query = `WITH query1 AS
                      (SELECT *
                      FROM B2CEUSWC.XRELATEDPRODUCT RT
                      WHERE TYPE='Plus Size')
                    SELECT DISTINCT STYLE_ID,
                                    STYLE_PARTNUMBER,
                                    STYLECOLOUR_ID,
                                    STYLECOLOUR_PARTNUMBER
                    FROM query1 AS RT
                    JOIN B2CEUSWC.XMQTCATENTRELDATA CT ON CT.STYLECOLOUR_ID = RT.MAINPRODUCT_ID
                    OR CT.STYLECOLOUR_ID = RT.RELATEDPRODUCT_ID
                    JOIN B2CEUSWC.INVENTORY INV ON CT.SKU_ID = INV.CATENTRY_ID
                    AND INV.QUANTITYMEASURE = 'C62'
                    AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID}
                    GROUP BY STYLE_ID,
                            STYLE_PARTNUMBER,
                            STYLECOLOUR_ID,
                            STYLECOLOUR_PARTNUMBER
                    HAVING SUM(INV.QUANTITY) >= ${inventoryMin} AND SUM(INV.QUANTITY) <= ${inventoryMax} FETCH FIRST ${isFHFiltered ? this.defaultRecordsCount : resultCount} ROWS ONLY WITH UR`;
    const results: Products = await this.db.query(query);
    if (isFHFiltered) {
      const fhResults = await this.getFHResult(results, resultCount);
      this.parser.save(fhResults);
    } else if (resultCount === this.defaultResultCount) {
      this.parser.save(results.splice(Math.floor(Math.random() * results.length), 1));
    } else {
      this.parser.save(results);
    }
  }

  public async getProductStyleByStyleColourNumbers(styleColourPartNumberList: Array<string>) {
    if (styleColourPartNumberList && styleColourPartNumberList.length > 0) {
      const query = `SELECT DISTINCT STYLE_ID,
                      STYLE_PARTNUMBER,
                      STYLECOLOUR_ID,
                      STYLECOLOUR_PARTNUMBER,
                      SKU_PARTNUMBER
                  FROM B2CEUSWC.XMQTCATENTRELDATA CT
                  WHERE CT.STYLECOLOUR_PARTNUMBER IN(${styleColourPartNumberList.map((s) => `'${s}'`).join(',')})
    `;
      const results: Products = await this.db.query(query);
      if (results.length === 0) {
        throw Error('No product styles returned from DB');
      }
      this.parser.save(results);
    }
  }

  private async getProductStyleBasedOnAttr(
    attrExpression: string,
    inventoryMin: number,
    inventoryMax: number,
    resultCount: number,
    isFHFiltered: boolean,
    isSAPFiltered: boolean,
  ) {
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

    const query = `WITH query1 AS
                    (SELECT CR.CATENTRY_ID
                    FROM B2CEUSWC.CATENTRYATTR CR
                    WHERE CR.ATTRVAL_ID IN
                        (SELECT ATTRVAL_ID
                          FROM B2CEUSWC.ATTRVAL
                          WHERE ${attrExpression}))
                  ${isNegativeInventoryCheck ? soldOutTrue : ''}
                  SELECT CT.STYLE_ID,
                        CT.STYLE_PARTNUMBER,
                        CT.STYLECOLOUR_ID,
                        CT.STYLECOLOUR_PARTNUMBER
                  FROM B2CEUSWC.XMQTCATENTRELDATA CT
                  JOIN query1 CR ON CT.SKU_ID = CR.CATENTRY_ID
                  ${isNegativeInventoryCheck ? 'JOIN query2 CR2 ON CT.STYLECOLOUR_ID = CR2.CATENTRY_ID' : ''}
                  JOIN B2CEUSWC.INVENTORY INV ON CT.SKU_ID = INV.CATENTRY_ID
                  AND INV.QUANTITYMEASURE = 'C62'
                  AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID}
                  GROUP BY STYLE_ID,
                          STYLE_PARTNUMBER,
                          STYLECOLOUR_ID,
                          STYLECOLOUR_PARTNUMBER
                  HAVING SUM(INV.QUANTITY) >= ${inventoryMin} AND SUM(INV.QUANTITY) <= ${inventoryMax} FETCH FIRST ${isFHFiltered ? this.defaultRecordsCount : resultCount} ROWS ONLY`;
    const results: Products = await this.db.query(query);
    if (results.length === 0) {
      throw Error('No product styles returned from DB');
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

  private async getProductStyleBasedOnAttrVar(
    attrIdentifier: string,
    attrValExpression: string,
    sizeAttrExpression: string,
    inventoryMin: number,
    inventoryMax: number,
    resultCount: number,
    isFHFiltered: boolean,
  ) {
    if (resultCount === 1 && !isFHFiltered) {
      resultCount = this.defaultResultCount;
    }
    const query = `with query1 as 
                  (
                    SELECT DISTINCT
                        CA.CATENTRY_ID 
                    FROM
                        B2CEUSWC.CATENTRYATTR CA 
                        JOIN
                          B2CEUSWC.ATTRVAL ARV 
                          ON CA.ATTRVAL_ID = ARV.ATTRVAL_ID 
                          AND CA.ATTR_ID IN 
                          (
                              SELECT
                                ATTR_ID 
                              FROM
                                B2CEUSWC.ATTR 
                              WHERE
                                IDENTIFIER = '${attrIdentifier}'
                          )
                          AND ARV.IDENTIFIER ${attrValExpression}
                  )
                  ,
                  query2 as 
                  (
                    SELECT
                        CR.CATENTRY_ID 
                    FROM
                        B2CEUSWC.CATENTRYATTR CR 
                    WHERE
                        CR.ATTRVAL_ID IN 
                        (
                          SELECT
                              ATTRVAL_ID 
                          FROM
                              B2CEUSWC.ATTRVAL 
                          WHERE
                              IDENTIFIER LIKE '${sizeAttrExpression}'
                        )
                  )
                  SELECT DISTINCT
                    CT.STYLE_ID,
                    CT.STYLE_PARTNUMBER,
                    CT.STYLECOLOUR_ID,
                    CT.STYLECOLOUR_PARTNUMBER 
                  FROM
                    B2CEUSWC.XMQTCATENTRELDATA CT 
                    JOIN
                        query1 
                        on CT.STYLECOLOUR_ID = query1.CATENTRY_ID 
                    JOIN
                        query2 
                        on CT.SKU_ID = query2.CATENTRY_ID 
                    JOIN
                        B2CEUSWC.INVENTORY INV 
                        ON CT.SKU_ID = INV.CATENTRY_ID 
                        AND INV.QUANTITYMEASURE = 'C62' 
                        AND FFMCENTER_ID = 715838484 
                  GROUP BY
                    STYLE_ID,
                    STYLE_PARTNUMBER,
                    STYLECOLOUR_ID,
                    STYLECOLOUR_PARTNUMBER
                  HAVING SUM(INV.QUANTITY) >= ${inventoryMin} AND SUM(INV.QUANTITY) <= ${inventoryMax} FETCH FIRST ${isFHFiltered ? this.defaultRecordsCount : resultCount} ROWS ONLY
                  `;
    const results: Products = await this.db.query(query);
    if (results.length === 0) {
      throw Error('No product styles returned from DB');
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

  private async getProductStyleWithAvaiableSize(
    attrExpression: string,
    minOutOfStockCount: number,
    inventoryMin: number,
    inventoryMax: number,
    resultCount: number,
    isFHFiltered: boolean,
  ) {
    if (resultCount === 1 && !isFHFiltered) {
      resultCount = this.defaultResultCount;
    }
    const query = `WITH query1 AS
                      (SELECT CR.CATENTRY_ID
                      FROM B2CEUSWC.CATENTRYATTR CR
                      WHERE CR.ATTRVAL_ID IN
                          (SELECT ATTRVAL_ID
                            FROM B2CEUSWC.ATTRVAL
                            WHERE ${attrExpression})),
                    query2 as (SELECT CT.STYLE_ID,
                          CT.STYLE_PARTNUMBER,
                          CT.STYLECOLOUR_ID,
                          CT.STYLECOLOUR_PARTNUMBER,
                          CT.SKU_PARTNUMBER,
                          INV.QUANTITY
                    FROM B2CEUSWC.XMQTCATENTRELDATA CT
                    JOIN query1 CR ON CT.SKU_ID = CR.CATENTRY_ID
                    JOIN B2CEUSWC.INVENTORY INV ON CT.SKU_ID = INV.CATENTRY_ID
                    AND INV.QUANTITYMEASURE = 'C62'
                    AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID})
                    SELECT 
                      STYLE_ID,
                      STYLE_PARTNUMBER,
                      STYLECOLOUR_ID,
                      STYLECOLOUR_PARTNUMBER
                    FROM query2
                    GROUP BY STYLE_ID, STYLE_PARTNUMBER, STYLECOLOUR_ID, STYLECOLOUR_PARTNUMBER
                    HAVING SUM(QUANTITY) >= ${inventoryMin} AND SUM(QUANTITY) <= ${inventoryMax}
                    AND
                    SUM(CASE WHEN (QUANTITY > 0) THEN 1 ELSE 0 END) > 1
                    AND
                    SUM(CASE WHEN (QUANTITY > 0) THEN 0 ELSE 1 END) >= ${minOutOfStockCount}
                    FETCH FIRST ${isFHFiltered ? this.defaultRecordsCount : resultCount} ROWS ONLY`;
    const results: Products = await this.db.query(query);
    if (results.length === 0) {
      throw Error('No product styles returned from DB');
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

  private async getProductStyleBasedOnGroup(
    groupExpression: string,
    inventoryMin: number,
    inventoryMax: number,
    resultCount: number,
    isFHFiltered: boolean,
  ) {
    if (isFHFiltered) {
      this.validFHFilter(resultCount);
    }
    if (resultCount === 1 && !isFHFiltered) {
      resultCount = this.defaultResultCount;
    }
    const query = `WITH query1 AS
                    (SELECT CATENTRY_ID
                    FROM B2CEUSWC.CATGPENREL
                    WHERE CATGROUP_ID IN
                        (SELECT CATGROUP_ID
                          FROM B2CEUSWC.CATGROUP
                          WHERE ${groupExpression}))
                  SELECT CT.STYLE_ID,
                        CT.STYLE_PARTNUMBER,
                        CT.STYLECOLOUR_ID,
                        CT.STYLECOLOUR_PARTNUMBER
                  FROM B2CEUSWC.XMQTCATENTRELDATA CT
                  JOIN query1 CG ON CT.STYLECOLOUR_ID = CG.CATENTRY_ID
                  JOIN B2CEUSWC.INVENTORY INV ON CT.SKU_ID = INV.CATENTRY_ID
                  AND INV.QUANTITYMEASURE = 'C62'
                  AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID}
                  GROUP BY STYLE_ID,
                          STYLE_PARTNUMBER,
                          STYLECOLOUR_ID,
                          STYLECOLOUR_PARTNUMBER
                  HAVING SUM(INV.QUANTITY) >= ${inventoryMin} AND SUM(INV.QUANTITY) <= ${inventoryMax} FETCH FIRST ${isFHFiltered ? this.defaultRecordsCount : resultCount} ROWS ONLY`;
    const results: Products = await this.db.query(query);
    if (results.length === 0) {
      throw Error('No product styles returned from DB');
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

  private async getProductStyleWithDifferentPrice(
    condition: string, injectWasPriceFilter: boolean, resultCount: number, isFHFiltered: boolean,
  ) {
    if (resultCount === 1 && !isFHFiltered) {
      resultCount = this.defaultResultCount;
    }
    const tradePoscnId = await this.GetTradePoscnId(this.site.locale);
    const injection = injectWasPriceFilter
      ? 'AND CP.CURRENTPRICE != CP.WASPRICE'
      : '';
    const query = `WITH query1 AS
                    (SELECT CT.STYLE_ID,
                            CT.STYLE_PARTNUMBER,
                            CT.STYLECOLOUR_ID,
                            CT.STYLECOLOUR_PARTNUMBER,
                            CT.SKU_ID,
                            CT.SKU_PARTNUMBER
                    FROM B2CEUSWC.XMQTCATENTRELDATA CT
                    LEFT JOIN B2CEUSWC.INVENTORY INV ON CT.SKU_ID = INV.CATENTRY_ID
                    AND INV.QUANTITYMEASURE = 'C62'
                    AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID}
                    WHERE QUANTITY > 1),
                      query2 AS
                    (SELECT *
                    FROM B2CEUSWC.XMQTSKUPRICEDATA CP
                    WHERE CP.TRADEPOSCN_ID = ${tradePoscnId} ${injection})
                  SELECT CT.STYLE_ID,
                        CT.STYLE_PARTNUMBER,
                        CT.STYLECOLOUR_ID,
                        CT.STYLECOLOUR_PARTNUMBER
                  FROM query1 CT
                  LEFT JOIN query2 CP ON CP.CATENTRY_ID = CT.SKU_ID
                  GROUP BY STYLE_ID,
                          STYLE_PARTNUMBER,
                          STYLECOLOUR_ID,
                          STYLECOLOUR_PARTNUMBER
                  HAVING ${condition}
                  FETCH FIRST ${isFHFiltered ? this.defaultRecordsCount : resultCount} ROWS ONLY`;
    const results: Products = await this.db.query(query);
    if (results.length === 0) {
      throw Error('No product styles returned from DB');
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

  public async getProductStyleOfSustainableType(
    sustainableType: string,
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    const attrValExpression = `LIKE '${sustainableType}'`;
    await this.getProductStyleBasedonProductAttr(
      attrValExpression,
      inventoryMin,
      inventoryMax,
      resultCount,
      isFHFiltered,
    );
  }

  public async getProductStyleOfBenefitType(
    BenefitType: string,
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    const attrValExpression = `LIKE '%${BenefitType}%'`;
    await this.getProductStyleBasedonProductAttr(
      attrValExpression,
      inventoryMin,
      inventoryMax,
      resultCount,
      isFHFiltered,
    );
  }

  public async getProductStyleOfPromotionType(
    PromotionType: string,
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    const locale = await this.site.locale;
    const attrValExpression = `LIKE '%PRODUCT_ATTR_PROMO_${locale.toUpperCase()}_${PromotionType}%'`;
    await this.getProductStyleBasedonProductAttr(
      attrValExpression,
      inventoryMin,
      inventoryMax,
      resultCount,
      isFHFiltered,
    );
  }

  public async getExclusiveProductofType(
    ProductType: string,
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
    isFHFiltered: boolean = false,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    const locale = await this.site.locale;
    const attrValExpression = `LIKE 'PRODUCT_ATTR_ExclusiveAccess_${locale.toUpperCase()}_${ProductType}%'`;
    await this.getProductStyleBasedonProductAttr(
      attrValExpression,
      inventoryMin,
      inventoryMax,
      resultCount,
      isFHFiltered,
    );
  }

  private async getProductStyleBasedonProductAttr(
    attrValExpression: string,
    inventoryMin: number,
    inventoryMax: number,
    resultCount: number,
    isFHFiltered: boolean,
  ) {
    if (resultCount === 1 && !isFHFiltered) {
      resultCount = this.defaultResultCount;
    }
    const query = `with query1 as 
                  (
                    SELECT
                        C.PARTNUMBER,
                        C.CATENTRY_ID
                    FROM
                        B2CEUSWC.CATENTRY C
                        WHERE
                          C.FIELD1 = 3
                          AND C.CATENTRY_ID IN 
                          (
                              SELECT
                                CA.CATENTRY_ID
                              FROM
                                B2CEUSWC.CATENTRYATTR CA
                              WHERE
                                CA.ATTRVAL_ID IN (
                                  SELECT
                                    A.ATTRVAL_ID
                                  FROM
                                    B2CEUSWC.ATTRVAL A
                                  WHERE A.IDENTIFIER ${attrValExpression}
                                )
                          )
                  )
                  SELECT DISTINCT
                    CT.STYLE_ID,
                    CT.STYLE_PARTNUMBER,
                    CT.STYLECOLOUR_ID,
                    CT.STYLECOLOUR_PARTNUMBER 
                  FROM
                    B2CEUSWC.XMQTCATENTRELDATA CT 
                    JOIN
                        query1 
                        on CT.STYLECOLOUR_ID = query1.CATENTRY_ID
                    JOIN
                        B2CEUSWC.INVENTORY INV 
                        ON CT.SKU_ID = INV.CATENTRY_ID
                        AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID}
                    GROUP BY
                    STYLE_ID,
                    STYLE_PARTNUMBER,
                    STYLECOLOUR_ID,
                    STYLECOLOUR_PARTNUMBER
                    HAVING SUM(INV.QUANTITY) >= ${inventoryMin} AND SUM(INV.QUANTITY) <= ${inventoryMax} FETCH FIRST ${isFHFiltered ? this.defaultRecordsCount : resultCount} ROWS ONLY
                  `;
    const results: Products = await this.db.query(query);
    if (results.length === 0) {
      throw Error('No product styles returned from DB');
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
}
