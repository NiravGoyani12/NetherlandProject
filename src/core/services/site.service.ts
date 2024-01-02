/* eslint-disable max-classes-per-file */
import { Singleton, Provides, Inject } from 'typescript-ioc';
import EnvService from './env.service';
import { GetTestLogger } from '../logger/test.logger';
import DBService from './db.service';
import { XCOMREG } from '../db/product-model';
import TestCache from '../test-cache';
import Encryption from './encryption.service';

export interface FHInfo {
  FH_PASSWORD: string
  FH_USERNAME: string
  FH_ENDPOINT_URL: string
}

export interface SiteInfo {
  STORE_ID: number
  FFMCENTER_ID: number
  LANGUAGE_ID: number
  LOCALENAME: string
  CATALOG_ID: number
  SETCCURR: string
  MAIN_STORE_ID: number
  FHInfo: FHInfo
}

export abstract class SiteService extends TestCache {
  public siteInfo: SiteInfo = undefined;

  public locale: string = undefined;

  public langCode: string = undefined;

  public baseUrl: string = undefined;

  public abstract initilizeSize(locale: string, langCode: string): void;

  abstract async getSiteInfo(locale: string, langCode: string): Promise<SiteInfo>;

  abstract async getBaseUrl(locale: string, langCode?: string);

  abstract async extractSiteInfo(): Promise<void>;
}

abstract class BaseSite extends SiteService {
  protected env: EnvService;

  protected db: DBService;

  constructor(env: EnvService, db: DBService) {
    super();
    this.env = env;
    this.db = db;
  }

  public initilizeSize(locale: string, langCode: string) {
    if (this.env.Site === 'localhost') {
      locale = 'uk';
      langCode = 'default';
      this.logger.info(`[localhost testing] Site Force Initialized with locale: ${locale}, langCode: ${langCode}`);
    } else {
      this.logger.info(`Site Initialized with locale: ${locale}, langCode: ${langCode}`);
    }

    if (!langCode) {
      langCode = undefined;
    }
    if (locale && locale.toLocaleLowerCase() === 'spadefault') {
      locale = this.env.SpaDefaultLocale;
    }
    if (locale && locale.toLocaleLowerCase() === 'multilangdefault') {
      locale = this.env.MultiLangDefaultLocale;
    }
    if (langCode && langCode.toLocaleLowerCase() === 'multilangdefault') {
      langCode = this.env.MultiLangDefaultLangCode;
    }
    if (langCode && langCode.toLocaleLowerCase() === 'spadefault') {
      langCode = this.env.SpaDefaultLangCode;
    }
    if (!locale || (locale && locale.toLocaleLowerCase() === 'default')) {
      locale = this.env.DefaultLocale;
    }
    if (langCode && langCode.toLocaleLowerCase() === 'default') {
      langCode = undefined;
    }
    if (locale && locale.toLocaleLowerCase() === 'xodefault') {
      locale = this.env.XoDefaultLocale;
    }
    if (langCode && langCode.toLocaleLowerCase() === 'xodefault') {
      langCode = undefined;
    }
    if (locale !== this.locale || langCode !== this.langCode) {
      this.locale = locale ? locale.toLowerCase() : locale;
      this.langCode = langCode && langCode.toLocaleLowerCase() !== 'default' ? langCode : undefined;
      this.reExtractSiteInfo = true;
    } else {
      this.reExtractSiteInfo = false;
    }
  }

  public async extractSiteInfo() {
    const cacheKey = `siteinfo${this.locale}#${this.langCode}`;
    if (!this.siteInfo || this.reExtractSiteInfo) {
      const cachedValue = this.getFromCache<SiteInfo>(cacheKey);
      if (cachedValue) {
        this.logger.info(`Use cached site info by key ${cacheKey}`);
        this.siteInfo = cachedValue;
      } else {
        this.logger.info('Extract Site Info successful');
        const [info, mainStoreId] = await Promise.all(
          [this.getSiteInfo(this.locale, this.langCode), this.getMainStoreInfo()],
        );
        this.siteInfo = info;
        this.siteInfo.MAIN_STORE_ID = mainStoreId;
        this.siteInfo.FHInfo = await this.getFHInfo(this.siteInfo.MAIN_STORE_ID);
        this.saveToCache(cacheKey, this.siteInfo);
      }
    } else {
      this.logger.info(`No site infor extracted, using the previous site info of locale ${this.locale} and langCode ${this.langCode}`);
    }
    this.logger.info(`# MAIN_STORE_ID: ${this.siteInfo.MAIN_STORE_ID}`);
    this.logger.info(`# STORE_ID: ${this.siteInfo.STORE_ID}`);
    this.logger.info(`# CATALOG_ID: ${this.siteInfo.CATALOG_ID}`);
    this.logger.info(`# SETCCURR : ${this.siteInfo.SETCCURR}`);
    this.logger.info(`# LANGUAGE_ID: ${this.siteInfo.LANGUAGE_ID}`);
    this.logger.info(`# LANGUAGE_NAME: ${this.siteInfo.LOCALENAME}`);
    this.logger.info(`# FFMCENTER_ID: ${this.siteInfo.FFMCENTER_ID}`);
    this.logger.info(`# FH_ENDPOINT: ${this.siteInfo.FHInfo.FH_ENDPOINT_URL}`);
  }

  /**
   * Get Site Info
   * @param locale uk | de | etc..
   * @param langCode en | fr | de | etc..
   */
  public async getSiteInfo(
    locale: string, langCode: string,
  ): Promise<SiteInfo | undefined> {
    const directory = this.env.Brand === 'th' ? 'Tommy' : 'CalvinKlein';
    const langFilter = langCode ? `AND LANGUAGE = '${langCode.toLocaleLowerCase()}'` : '';
    const query = `SELECT S.STORE_ID,
                          S.FFMCENTER_ID,
                          SL.LANGUAGE_ID,
                          L.LOCALENAME,
                          SC.CATALOG_ID,
                          SL.SETCCURR
                      FROM B2CEUSWC.STORE S
                      JOIN B2CEUSWC.STORELANG SL ON S.STORE_ID = SL.STOREENT_ID
                      JOIN B2CEUSWC.LANGUAGE L ON SL.LANGUAGE_ID = L.LANGUAGE_ID
                      JOIN B2CEUSWC.STOREDEFCAT SC ON SC.STOREENT_ID = S.STORE_ID
                      WHERE
                      DIRECTORY = '${directory}${locale.toUpperCase()}' ${langFilter}
                      WITH UR`;
    const result: Array<SiteInfo> = await this.db.query(query);
    if (result) {
      let finalResult = result[0];
      if (result.length > 1) {
        const defaultLanguageId = await this.getDefaultLangID(directory, locale);
        finalResult = result.find((s) => s.LANGUAGE_ID === defaultLanguageId);
      }
      finalResult.LOCALENAME = finalResult.LOCALENAME.trim();
      return finalResult;
    }
    throw new Error('Cannot extract site info');
  }

  private async getDefaultLangID(directory: string, locale: string) {
    const query = `SELECT LANGUAGE_ID FROM B2CEUSWC.STORE WHERE DIRECTORY = '${directory}${locale.toUpperCase()}'`;
    const result: Array<{ LANGUAGE_ID: number }> = await this.db.query(query);
    if (result) {
      return result[0].LANGUAGE_ID;
    }
    throw new Error('Cannot extract default langId');
  }

  private async getMainStoreInfo() {
    const query = `SELECT STORE_ID FROM B2CEUSWC.STORE WHERE DIRECTORY = '${this.env.Brand.toUpperCase()}StoreFrontAssetStore'`;
    const result: Array<{ STORE_ID: number }> = await this.db.query(query);
    if (result) {
      return result[0].STORE_ID;
    }
    throw new Error('Cannot retrieve Main Store info');
  }

  private async getFHInfo(mainStoreId: number) {
    const FHdecrypt: Encryption = new Encryption();
    const query = `SELECT NAME,
                      VALUE,
                      OVERRIDE_VALUE
                    FROM B2CEUSWC.XCOMREG
                    WHERE NAME IN ('FH_ENDPOINT_URL')
                    AND STOREENT_ID=${mainStoreId}`;
    const result: Array<XCOMREG> = await this.db.query(query);
    if (result && result.length === 1) {
      const url = result.find((s) => s.NAME === 'FH_ENDPOINT_URL');
      // TODO: add username in query once DB copybacks are done
      // const userName = result.find((s) => s.NAME === 'FH_USERNAME');
      const username = this.env.fhUsername;
      const password = FHdecrypt.passDecrypt(this.env.fhPassword, FHdecrypt.IV, FHdecrypt.KEY);
      return {
        FH_ENDPOINT_URL: (url.OVERRIDE_VALUE || url.VALUE).trim(),
        // FH_USERNAME: (userName.OVERRIDE_VALUE || userName.VALUE).trim(),
        FH_USERNAME: username,
        FH_PASSWORD: password,
      };
    }
    throw new Error(`Cannot retrive FH info based on store id ${mainStoreId}`);
  }

  private get logger() { return GetTestLogger(); }

  private reExtractSiteInfo = false;
}

@Provides(SiteService)
@Singleton
export class THSiteService extends BaseSite {
  // eslint-disable-next-line @typescript-eslint/no-useless-constructor
  constructor(@Inject env: EnvService, @Inject db: DBService) {
    super(env, db);
  }

  public initilizeSize(locale: string, langCode: string) {
    super.initilizeSize(locale, langCode);
    this.baseUrl = this.getBaseUrl(this.locale, this.langCode);
  }

  public getBaseUrl(locale: string, langCode?: string) {
    let baseUrl = `https://${locale}.${this.env.Site}.tommy.com`;
    if (langCode) {
      baseUrl += `/${langCode.toUpperCase()}`;
    }
    return baseUrl;
  }
}

@Provides(SiteService)
@Singleton
export class CKSiteService extends BaseSite {
  // eslint-disable-next-line @typescript-eslint/no-useless-constructor
  constructor(@Inject env: EnvService, @Inject db: DBService) {
    super(env, db);
  }

  public initilizeSize(locale: string, langCode: string) {
    super.initilizeSize(locale, langCode);
    this.baseUrl = this.getBaseUrl(this.locale, this.langCode);
  }

  public getBaseUrl(locale: string, langCode: string) {
    let baseUrl = '';
    switch (this.env.Site) {
      case 'systestp':
      case 'systests':
      case 'devtestp1':
      case 'devtests1':
      case 'devtestp':
      case 'devtests':
        baseUrl = `https://${locale}.${this.env.Site}.calvinklein.com`;
        break;
      case 'b2ceuup':
      case 'b2ceuus':
      case 'b2ceusp':
      case 'b2ceuss':
      case 'preprod-live':
      case 'preprod-stag':
        baseUrl = `https://${this.env.Site}.calvinklein.${locale}`;
        break;
      case 'localhost':
        baseUrl = 'https://localhost:3000';
        break;
      default:
        // for preprod-live and prod-stag
        locale = locale === 'uk' ? 'co.uk' : locale;
        baseUrl = locale !== 'ro' ? `${this.env.Site}.calvinklein.${locale}` : `${locale}.${this.env.Site}.calvinklein.com`;
        baseUrl = this.env.Site === 'prod-stag' && locale !== 'ro' ? `https://www.${baseUrl}` : `https://${baseUrl}`;
    }
    if (langCode) {
      baseUrl += `/${langCode.toUpperCase()}`;
    }
    return baseUrl;
  }
}
