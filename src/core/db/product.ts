import { Singleton } from 'typescript-ioc';
import ProductBase from './product-base';
import {
  ProductDetail,
  Products,
  DetailTemp,
  StyleColourPartNumber,
  ProductStyleDetail,
  ProductItemDetail,
  PlusSizeIdentifiers,
} from './product-model';
import EnvService from '../services/env.service';
import DBService from '../services/db.service';
import { SiteService } from '../services/site.service';
import ProductParser from './product-parser';

@Singleton
export default class Product extends ProductBase {
  public details: Map<string, ProductDetail>;

  private defaultResultCount = 40;

  constructor(env: EnvService,
    db: DBService,
    site: SiteService,
    parser: ProductParser) {
    super(env, db, site, parser);
    this.details = new Map();
  }

  public extractInStockStyleColours(detail: ProductDetail): ProductStyleDetail[] {
    const styleColours = Array.from(detail.PRODUCT_STYLE_DICT.values());
    return styleColours.filter((s) => s.QUANTITY > 0);
  }

  public extractOutOfStockStyleColours(detail: ProductDetail): ProductStyleDetail[] {
    const styleColours = Array.from(detail.PRODUCT_STYLE_DICT.values());
    return styleColours.filter((s) => s.QUANTITY <= 0 || !s.QUANTITY);
  }

  public extractOutOfStockProductItems(detail: ProductDetail): ProductItemDetail[] {
    const styleColours = Array.from(detail.PRODUCT_STYLE_DICT.values());
    const result: ProductItemDetail[] = [];
    styleColours.forEach(
      (s) => {
        const r = Array.from(s.PRODUCT_ITEM_DICT.values()).filter((i) => i.QUANTITY <= 0);
        result.push(...r);
      },
    );
    return result;
  }

  public extractStyleColourByColourName(detail: ProductDetail, colourName: string) {
    const styleColours = Array.from(detail.PRODUCT_STYLE_DICT.values());
    return styleColours.find(
      (s) => s.COLOUR_NAME.toLocaleLowerCase() === colourName.toLocaleLowerCase(),
    );
  }

  public async getDetail(stylePartNumber: string) {
    const detail = this.details.get(stylePartNumber);
    if (!detail) {
      await this.fetchProductDetail(stylePartNumber);
    }
    return this.details.get(stylePartNumber);
  }

  public async fetchProductDetail(stylePartNumber: string) {
    const tradePoscnId = await this.GetTradePoscnId(this.site.locale);
    const query = `With query1 AS (SELECT CATALOG_ID
                    FROM B2CEUSWC.CATALOG
                    WHERE IDENTIFIER = 'PVHExtendedSitesCatalogAssetStore'),
                   query2 AS
                    (SELECT *
                    FROM B2CEUSWC.XMQTCATENTRELDATA CT
                    WHERE STYLE_PARTNUMBER = '${stylePartNumber}'),
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
                  SELECT STYLE_ID,
                        STYLECOLOUR_ID,
                        SKU_ID,
                        STYLE_PARTNUMBER,
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
                          AND CA.ATTR_ID IN (SELECT ATTR_ID FROM B2CEUSWC.ATTR WHERE IDENTIFIER = '${this.GBPC_NAME}') and XC.STYLE_PARTNUMBER='${stylePartNumber}'
                          JOIN B2CEUSWC.ATTRVALDESC AVDESC ON AVDESC.ATTRVAL_ID=CA.ATTRVAL_ID FETCH FIRST 1 ROW ONLY) AS GBPC,
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
      throw new Error(`Cannot fetch product detail for ${stylePartNumber}`);
    }
    const dict = new Map<StyleColourPartNumber, ProductStyleDetail>();
    let totalQuantity = 0;
    results.forEach((r) => {
      let prodcutStyleDetail: ProductStyleDetail;
      if (dict.get(r.STYLECOLOUR_PARTNUMBER)) {
        prodcutStyleDetail = dict.get(r.STYLECOLOUR_PARTNUMBER);
      } else {
        prodcutStyleDetail = {
          STYLE_PARTNUMBER: r.STYLE_PARTNUMBER,
          STYLECOLOUR_PARTNUMBER: r.STYLECOLOUR_PARTNUMBER,
          COLOUR_NAME: '',
          NAME: r.NAME,
          ANALYTICS_NAME: r.ANALYTICS_NAME,
          DIVISION: r.DIVISION,
          LIST: r.LIST_PRIMARY || r.LIST_ALTERNATE,
          GBPC: r.GBPC,
          ANALYTICS_MAIN_COLOUR: 'not implement',
          MAIN_COLOUR: 'not implement',
          QUANTITY: 0,
          PRODUCT_ITEM_DICT: new Map(),
        };
      }

      let productItemDetail: ProductItemDetail;
      if (prodcutStyleDetail.PRODUCT_ITEM_DICT.get(r.SKU_PARTNUMBER)) {
        productItemDetail = prodcutStyleDetail.PRODUCT_ITEM_DICT.get(r.SKU_PARTNUMBER);
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
        prodcutStyleDetail.QUANTITY += r.QUANTITY;
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
        prodcutStyleDetail.COLOUR_NAME = r.STRINGVALUE;
      }
      prodcutStyleDetail.PRODUCT_ITEM_DICT.set(r.SKU_PARTNUMBER, productItemDetail);
      dict.set(r.STYLECOLOUR_PARTNUMBER, prodcutStyleDetail);
    });
    const productDetail: ProductDetail = {
      STYLE_PARTNUMBER: results[0].STYLE_PARTNUMBER,
      PRODUCT_STYLE_DICT: dict,
      QUANTITY: totalQuantity,
    };
    this.details.set(stylePartNumber, productDetail);
  }

  public async getProductWithMultipleColurs(
    minCountOfColour: number,
    operator: string,
    inventoryMin: number = 0,
    inventoryMax: number = 10000,
    resultCount: number = 1,
  ) {
    inventoryMin = this.GetRandomMinInventory(inventoryMin);
    if (resultCount === 1) {
      resultCount = this.defaultResultCount;
    }
    const query = `WITH query1 AS
                  (SELECT STYLE_ID,
                          STYLE_PARTNUMBER,
                          STYLECOLOUR_PARTNUMBER,
                          SUM(INV.QUANTITY) AS QUANTITY
                  FROM B2CEUSWC.XMQTCATENTRELDATA CT
                  LEFT JOIN B2CEUSWC.INVENTORY INV ON CT.SKU_ID = INV.CATENTRY_ID
                  AND INV.QUANTITYMEASURE = 'C62'
                  AND FFMCENTER_ID = ${this.site.siteInfo.FFMCENTER_ID}
                  GROUP BY STYLE_ID, STYLE_PARTNUMBER,
                            STYLECOLOUR_PARTNUMBER)
                SELECT
                    STYLE_ID,
                    STYLE_PARTNUMBER
                FROM query1
                GROUP BY STYLE_ID, STYLE_PARTNUMBER
                HAVING COUNT(CASE WHEN QUANTITY > 0 THEN 1 ELSE NULL END) = COUNT(STYLECOLOUR_PARTNUMBER)  
                AND COUNT(DISTINCT STYLECOLOUR_PARTNUMBER) ${operator} ${minCountOfColour}
                AND SUM(QUANTITY) >= ${inventoryMin}
                AND SUM(QUANTITY) <= ${inventoryMax}
                FETCH FIRST ${resultCount} ROWS ONLY`;
    const results: Products = await this.db.query(query);
    if (results.length === 0) {
      throw Error('[getProductWithMultipleColurs] No products returned from DB');
    }
    if (resultCount === this.defaultResultCount) {
      this.parser.save(results.splice(Math.floor(Math.random() * results.length), 1));
    } else {
      this.parser.save(results);
    }
  }

  public async extractIdentifierForPlusSize(resultCount: number = 1) {
    const query = `SELECT IDENTIFIER FROM B2CEUSWC.ATTRVAL WHERE IDENTIFIER LIKE 'AdditionalSizes%' FETCH FIRST ${resultCount} ROWS ONLY`;
    const results: PlusSizeIdentifiers = await this.db.query(query);
    if (results.length === 0) {
      throw Error('[extractIdentifierForPlusSize] No products returned from DB');
    }
    return results;
  }
}
