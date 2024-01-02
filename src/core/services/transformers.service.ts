/* eslint-disable import/prefer-default-export */
import got from 'got/dist/source';
import { Inject, Provides, Singleton } from 'typescript-ioc';
import { GetTestLogger } from '../logger/test.logger';
import DBService from './db.service';
import EnvService from './env.service';
import { CKSiteService, SiteService } from './site.service';

const httpTimeout = 5000;
const httpRetry = 5;
@Provides(SiteService)
@Singleton
export default class TransformersService extends CKSiteService {
  // eslint-disable-next-line @typescript-eslint/no-useless-constructor
  constructor(@Inject env: EnvService, @Inject db: DBService) {
    super(env, db);
  }

  public async getProducts(productId: string, locale: string, store: string) {
    const correctUrl = this.getPrefixUrl();
    GetTestLogger().info('[getProducts] url', correctUrl, `products/${productId}`, 'locale', locale, 'store', store);
    try {
      const client = got.extend({
        prefixUrl: correctUrl,
        headers: {
          Accept: 'application/json',
          'Accept-Locale': locale,
          'Accept-Store': store,
        },
        timeout: httpTimeout,
        retry: httpRetry,
      });
      const resp = await client.get<any>(`products/${productId}`);
      if (resp.statusCode < 200 || resp.statusCode >= 300) {
        throw new Error(`GET products request failed with status code ${resp.statusCode}`);
      }
      if (resp.body === null || !resp.body) {
        throw new Error('GET products request failed due to null response body received');
      }
      return resp.body;
    } catch (e) {
      throw new Error(`Error encountered for GET Products: ${e}`);
    }
  }

  public async getLiveProducts(productId: string, locale: string, store: string) {
    const correctUrl = `https://live.${this.env.Brand}.prd.b2c-api.eu.pvh.cloud`;
    GetTestLogger().info('[getProducts] url', correctUrl, `products/${productId}`, 'locale', locale, 'store', store);
    try {
      const client = got.extend({
        prefixUrl: correctUrl,
        headers: {
          Accept: 'application/json',
          'Accept-Locale': locale,
          'Accept-Store': store,
        },
        timeout: httpTimeout,
        retry: httpRetry,
      });
      const resp = await client.get<any>(`products/${productId}`);
      if (resp.statusCode < 200 || resp.statusCode >= 300) {
        throw new Error(`GET products request failed with status code ${resp.statusCode}`);
      }
      if (resp.body === null || !resp.body) {
        throw new Error('GET products request failed due to null response body received');
      }
      return resp.body;
    } catch (e) {
      throw new Error(`Error encountered for GET Products: ${e}`);
    }
  }

  public async getCategoryInformation(categoryName: string, locale: string,
    store: string, storeLocale: string) {
    if (storeLocale.trim().toLocaleLowerCase() === 'uk') {
      storeLocale = 'uki';
    } else if (storeLocale.trim().toLocaleLowerCase() === 'sk') {
      // Note: don't know why it's like this, but it's what WCS returns,
      // and transformers gets this from WCS
      // Reference: curl --location --request GET https://b2ceuup.calvinklein.sk/wcs/resources/store/20026/category-hierarchy?langId=44&depth=3
      storeLocale = 'de';
    } else if (storeLocale.trim().toLocaleLowerCase() === 'lu') {
      storeLocale = 'be';
    } else if (storeLocale.trim().toLocaleLowerCase() === 'cz' || storeLocale.trim().toLocaleLowerCase() === 'pl') {
      storeLocale = 'de';
    } else if (storeLocale.trim().toLocaleLowerCase() === 'ee') {
      storeLocale = 'scan';
    }

    const correctUrl = this.getPrefixUrl();
    const catName = `${categoryName.toLocaleUpperCase()}_${storeLocale.toLocaleUpperCase()}`;
    const categoryUrl = `categories/${catName}`;
    GetTestLogger().info('[getCategoryInformation] url', correctUrl, `${categoryUrl}`, 'locale', locale, 'store', store, 'storeLocale', storeLocale);

    try {
      const client = got.extend({
        prefixUrl: correctUrl,
        headers: {
          Accept: 'application/json',
          'Accept-Locale': locale,
          'Accept-Store': store,
        },
        timeout: httpTimeout,
        retry: httpRetry,
      });
      const resp = await client.get<any>(`${categoryUrl}`);
      if (resp.statusCode < 200 || resp.statusCode >= 300) {
        throw new Error(`GET categories request failed with status code ${resp.statusCode}`);
      }
      if (resp.body === null || !resp.body) {
        throw new Error('GET categories request failed due to null response body received');
      }
      return resp.body;
    } catch (e) {
      throw new Error(`Error encountered for GET Categories: ${e}`);
    }
  }

  public async getDesktopProductList(categoryOrSearchName: string, locale: string,
    store: string, storeLocale: string, getListForSearch: boolean = false) {
    let categoryUrl;
    const correctUrl = this.getPrefixUrl();

    if (storeLocale.trim().toLocaleLowerCase() === 'uk') {
      storeLocale = 'uki';
    } else if (storeLocale.trim().toLocaleLowerCase() === 'sk') {
      // Note: don't know why it's like this, but it's what WCS returns,
      // and transformers gets this from WCS
      // Reference: curl --location --request GET https://b2ceuup.calvinklein.sk/wcs/resources/store/20026/category-hierarchy?langId=44&depth=3
      storeLocale = 'de';
    } else if (storeLocale.trim().toLocaleLowerCase() === 'lu') {
      storeLocale = 'be';
    } else if (storeLocale.trim().toLocaleLowerCase() === 'ee') {
      storeLocale = 'scan';
    }

    let catName = `${categoryOrSearchName.toLocaleUpperCase()}_${storeLocale.toLocaleUpperCase()}`;
    catName = encodeURIComponent(catName);
    if (getListForSearch) {
      categoryUrl = `products?filter[search]=${categoryOrSearchName}&filter[device]=desktop`;
    } else {
      categoryUrl = `products?filter[category]=${catName}&filter[device]=desktop`;
    }
    GetTestLogger().info('[getProductList] url', correctUrl, `${categoryUrl}`, 'locale', locale, 'store', store, 'storeLocale', storeLocale);

    try {
      const client = got.extend({
        prefixUrl: correctUrl,
        headers: {
          Accept: 'application/json',
          'Accept-Locale': locale,
          'Accept-Store': store,
        },
        timeout: httpTimeout,
        retry: httpRetry,
      });
      const resp = await client.get<any>(`${categoryUrl}`);
      if (resp.statusCode < 200 || resp.statusCode >= 300) {
        throw new Error(`GET getDesktopProductList request failed with status code ${resp.statusCode}`);
      }
      if (resp.body === null || !resp.body) {
        throw new Error('GET getDesktopProductList request failed due to null response body received');
      }
      return resp.body;
    } catch (e) {
      throw new Error(`Error encountered for GET getDesktopProductList: ${e}`);
    }
  }

  public getPrefixUrl() {
    let prefixUrl = '';
    switch (this.env.Site) {
      case 'systestp':
        prefixUrl = `https://systest.${this.env.Brand.toLowerCase()}.dev.b2c-api.eu.pvh.cloud`;
        break;
      case 'systests':
        prefixUrl = `https://staging-systest.${this.env.Brand.toLowerCase()}.dev.b2c-api.eu.pvh.cloud`;
        break;
      case 'devtestp1':
        prefixUrl = `https://db1.${this.env.Brand.toLowerCase()}.dev.b2c-api.eu.pvh.cloud`;
        break;
      case 'devtests1':
        prefixUrl = `https://staging-db1.${this.env.Brand.toLowerCase()}.dev.b2c-api.eu.pvh.cloud`;
        break;
      case 'devtestp':
        prefixUrl = `https://db0.${this.env.Brand.toLowerCase()}.dev.b2c-api.eu.pvh.cloud`;
        break;
      case 'devtests':
        prefixUrl = `https://staging-db0.${this.env.Brand.toLowerCase()}.dev.b2c-api.eu.pvh.cloud`;
        break;
      case 'localhost':
      case 'b2ceuup':
        prefixUrl = `https://uat.${this.env.Brand.toLowerCase()}.stg.b2c-api.eu.pvh.cloud`;
        break;
      case 'b2ceuus':
        prefixUrl = `https://staging-uat.${this.env.Brand.toLowerCase()}.stg.b2c-api.eu.pvh.cloud`;
        break;
      case 'b2ceusp':
        prefixUrl = `https://sit.${this.env.Brand.toLowerCase()}.stg.b2c-api.eu.pvh.cloud`;
        break;
      case 'b2ceuss':
        prefixUrl = `https://staging-sit.${this.env.Brand.toLowerCase()}.stg.b2c-api.eu.pvh.cloud`;
        break;
      case 'preprod-live':
      case 'preprod-stag':
        prefixUrl = `https://ppt.${this.env.Brand.toLowerCase()}.stg.b2c-api.eu.pvh.cloud`;
        break;
      case 'prod-stag':
        prefixUrl = `https://staging.${this.env.Brand.toLowerCase()}.prd.b2c-api.eu.pvh.cloud`;
        break;
      default:
        throw new Error(`Site value provided for getPrefixUrl is not recognized: ${this.env.Site}`);
    }
    return prefixUrl;
  }
}
