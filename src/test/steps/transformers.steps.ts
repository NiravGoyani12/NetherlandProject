/* eslint-disable import/prefer-default-export */
import { When } from '@pvhqa/cucumber';
import { GetTestLogger } from '../../core/logger/test.logger';
import services from '../../core/services';
import { getStore } from '../helper/utils.helper';

/*
* informationType - values allowed: lastPageItemCount, lastPageNumber, totalItemCount
* plpType - values allowed: search, category
* searchOrCategoryName - example value allowed: women_clothes_t-shirts
*/
export const getPageInformation = async (informationType: string, plpType: string,
  searchOrCategoryName: string, locale?: string, langCode?: string) => {
  let responseBody;
  let results: number;
  if (!locale || !langCode) {
    await services.site.extractSiteInfo();
  } else {
    await services.site.initilizeSize(locale, langCode);
    await services.site.extractSiteInfo();
  }
  const acceptStore: string = await getStore(services.site.locale);

  if (plpType.includes('category')) {
    responseBody = JSON.parse(await services.transformers
      .getDesktopProductList(
        searchOrCategoryName,
        services.site.siteInfo.LOCALENAME,
        acceptStore,
        services.site.locale,
      ));
  } else if (plpType.includes('search')) {
    responseBody = JSON.parse(await services.transformers
      .getDesktopProductList(
        searchOrCategoryName,
        services.site.siteInfo.LOCALENAME,
        acceptStore,
        services.site.locale,
        true,
      ));
  } else {
    throw new Error(`Something went wrong trying to get default ${plpType} product list from transformers. Please check logs.`);
  }

  const remainder: number = Number(responseBody.meta.page.total)
    % Number(responseBody.meta.page.limit);
  if (informationType === 'lastPageItemCount') {
    results = remainder;
    if (results === 0) {
      results = 48;
    }
  } else if (informationType === 'lastPageNumber') {
    if (remainder > 0) {
      results = Math.trunc(Number(responseBody.meta.page.total)
        / Number(responseBody.meta.page.limit)) + 1;
    } else {
      results = Math.round((Number(responseBody.meta.page.total)
        / Number(responseBody.meta.page.limit)));
    }
  } else if (informationType === 'totalItemCount') {
    results = Number(responseBody.meta.page.total);
  } else {
    throw new Error(`Something went wrong trying to get information type ${informationType}. Only values available are: lastPageItemCount, lastPageNumber, totalItemCount. Please check logs.`);
  }

  return results;
};

When(/I extract seo url of ([^\s]+) for locale (default|[^\s]+)(?: of langCode (default|[^\s]+))? saved as (#[A-Za-z0-9]+)/, async (categoryName: string, locale: string, langCode: string, key: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  const acceptStore: string = await getStore(services.site.locale);

  const responseBody = JSON.parse(await services.transformers
    .getCategoryInformation(
      categoryName,
      services.site.siteInfo.LOCALENAME,
      acceptStore,
      services.site.locale,
    ));
  // NOTE: Workaround for when langCode does not work
  // const seoUrl = `${await getLocaleLang(services.site.locale, services.site.siteInfo.LOCALENAME)}
  // ${responseBody.data.metadata.keywords}`;
  const seoUrl = responseBody.data.metadata.keywords;
  services.world.store(key, seoUrl);
  GetTestLogger().info(`${seoUrl} saved as ${key}`);
});

When(/I save page (lastPageItemCount|lastPageNumber|totalItemCount) for (search|category) ([^\s]+) for locale (default|[^\s]+)(?: of langCode (default|[^\s]+))? as key (#[A-Za-z0-9]+)/, async (informationType: string, plpType: string, searchOrCategoryName: string, locale: string, langCode: string, key: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();

  const resultValue = await getPageInformation(informationType, plpType,
    searchOrCategoryName, locale, langCode);
  services.world.store(key, resultValue);

  GetTestLogger().info(`${informationType} with value ${resultValue} saved as ${key}`);
});
