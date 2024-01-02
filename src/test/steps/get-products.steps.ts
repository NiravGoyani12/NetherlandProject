/* eslint-disable import/prefer-default-export */
import { When } from '@pvhqa/cucumber';
import { GetTestLogger } from '../../core/logger/test.logger';
import services from '../../core/services';
import { getStore } from '../helper/utils.helper';

export const getProductDetails = async (
  encoded: string, detailType: string, locale: string, langCode: string,
  productId: string, key: string,
) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  const acceptStore: string = await getStore(services.site.locale);
  productId = services.world.parse(productId);

  const responseBody = JSON.parse(await services.transformers
    .getProducts(productId, services.site.siteInfo.LOCALENAME, acceptStore));

  GetTestLogger().info(`Response Body: ${JSON.stringify(responseBody)}`);

  let value;
  if (detailType.trim().toLocaleLowerCase() === 'name') {
    value = responseBody.data.name;
  } else if (detailType.trim().toLocaleLowerCase() === 'price') {
    value = responseBody.data.price.price;
  } else if (detailType.trim().toLocaleLowerCase() === 'currency') {
    value = responseBody.meta.currency.code;
  } else if (detailType.trim().toLocaleLowerCase() === 'url') {
    value = responseBody.data.url.replace('/', '');
  } else {
    throw new Error(`${detailType} not recognized. Please provide correct information.`);
  }
  if (encoded.includes('encoded')) {
    value = encodeURIComponent(value);
  }
  services.world.store(key, value);
};
When(/^I store the (encoded product|product) (name|price|currency|url) for locale (default|[^\s]+)(?: with langCode (default|[^\s]+))? for product style (#[A-Za-z0-9]+) with key (#[A-Za-z0-9]+)$/, getProductDetails);

export const getLiveProductDetails = async (
  encoded: string, detailType: string, locale: string, langCode: string,
  productId: string, key: string,
) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  const acceptStore: string = await getStore(services.site.locale);
  productId = services.world.parse(productId);

  const responseBody = JSON.parse(await services.transformers
    .getLiveProducts(productId, services.site.siteInfo.LOCALENAME, acceptStore));

  GetTestLogger().info(`Response Body: ${JSON.stringify(responseBody)}`);

  let value;
  if (detailType.trim().toLocaleLowerCase() === 'name') {
    value = responseBody.data.name;
  } else if (detailType.trim().toLocaleLowerCase() === 'price') {
    value = responseBody.data.price.price;
  } else if (detailType.trim().toLocaleLowerCase() === 'currency') {
    value = responseBody.meta.currency.code;
  } else if (detailType.trim().toLocaleLowerCase() === 'url') {
    value = responseBody.data.url.replace('/', '');
  } else {
    throw new Error(`${detailType} not recognized. Please provide correct information.`);
  }
  if (encoded.includes('encoded')) {
    value = encodeURIComponent(value);
  }
  services.world.store(key, value);
};
When(/^I store the LIVE (product|encoded product) (name|price|currency|url) for locale (default|[^\s]+)(?: with langCode (default|[^\s]+))? for product style (#[A-Za-z0-9]+) with key (#[A-Za-z0-9]+)$/, getLiveProductDetails);
