import { GetTestLogger } from '../../core/logger/test.logger';
import services from '../../core/services';

/* eslint-disable import/prefer-default-export */
export const sleep = async (ms: number) => {
  await new Promise((resolve) => setTimeout(resolve, ms));
};

export const getPageType = async () => {
  try {
    const pageType:string = await (browser as any).waitUntilResult(async () => {
      let page;
      try {
        page = (await browser.execute('return utag.data.page_type')).toString();
      } catch (e) {
        page = (await browser.execute('return digitalData.page.category.pageType')).toString();
      }
      return page;
    }, 'utag.data.page_type or digitalData.page.category.pageType was not loaded', 10000);
    return pageType;
  } catch (e) {
    GetTestLogger().info(`Cannot get page type, ${e}`);
    return undefined;
  }
};

export const getStore = async (locale: string) => {
  let storePrefix: string;
  try {
    if (services.env.Brand === 'ck') {
      storePrefix = 'CalvinKlein';
    } else {
      storePrefix = 'Tommy';
    }
    storePrefix = storePrefix.concat(locale.toUpperCase());
  } catch (e) {
    throw new Error(`Error when getting store value: ${e}`);
  }
  return storePrefix;
};

export const getLocaleLang = async (locale: string, langCode: string) => {
  let langToInclude;

  if (locale === 'be' && langCode.toLocaleLowerCase() === 'fr_fr') {
    langToInclude = 'FR/';
  } else if (locale === 'ch' && langCode.toLocaleLowerCase() === 'fr_fr') {
    langToInclude = 'FR/';
  } else if (locale === 'lu' && langCode.toLocaleLowerCase() === 'de_de') {
    langToInclude = 'DE/';
  } else {
    langToInclude = '';
  }

  return langToInclude;
};
