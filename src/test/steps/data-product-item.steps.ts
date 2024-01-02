import { Given, When } from '@pvhqa/cucumber';
import services from '../../core/services';

Given(/There (?:is|are) (\d+) any product items? of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?( and filtered by SAP)?/, async (resultCount: number, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string, hasSAPFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  if (!hasSAPFilter) {
    await services.product.productItem.getAnyProductItem(
      inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
    );
  } else {
    await services.product.productItem.getAnyProductItemFilteredBySap(
      inventoryMin, resultCount, !!hasFHFilter,
    );
  }
});

Given(/There (?:is|are) (\d+) one size product items? of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productItem.getProductItemOfStyleOneSize(
    inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+) width-length size product items? of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productItem.getProductItemOfStyleMultipleSize(
    inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+) normal size product items? of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productItem.getProductItemOfStyleNormalSize(
    inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+) width only size product items? of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productItem.getProductItemOfStyleWidthOnlySize(
    inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+) product items? with (\d+)% discount of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with price between (.*) and (.*) and inventory between (\d+) and (\d+)( filtered by FH)?( filtered by SAP)?/, async (resultCount: number, percent: number, locale: string, langCode: string, priceMin: string, priceMax: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string, hasSAPFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  percent = 1 - percent / 100;
  priceMin = services.world.parse(priceMin);
  priceMax = services.world.parse(priceMax);
  await services.product.productItem.getProductWithSpecificWasPrice(
    percent,
    Number(priceMin),
    Number(priceMax),
    inventoryMin,
    inventoryMax,
    resultCount,
    !!hasFHFilter,
    !!hasSAPFilter,
  );
});

Given(/There (?:is|are) (\d+) discounted product items? of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?( filtered by SAP)?/, async (
  resultCount: number, locale: string, langCode: string,
  inventoryMin: number, inventoryMax: number, hasFHFilter: string, hasSAPFilter: string,
) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productItem.getProductWithWasPrice(
    inventoryMin,
    inventoryMax,
    resultCount,
    !!hasFHFilter,
    !!hasSAPFilter,
  );
});

Given(/There (?:is|are) (\d+) product items? with pending price of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? and inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productItem.getProductItemWithPendingPrice(
    inventoryMin,
    inventoryMax,
    resultCount,
    !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+) sold out product items? of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))?( filtered by FH)?/, async (resultCount: number, locale: string, langCode: string, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productItem.getSoldOutProductItem(
    resultCount, !!hasFHFilter,
  );
});

When(/I fetch (current price|was price|currency|size name|width name|length name|colour name) of product item ([^\s]+) saved as (#[A-Za-z0-9]+)/, async (attrName: string, skuPartNumber: string, key: string) => {
  skuPartNumber = services.world.parse(skuPartNumber);
  skuPartNumber = services.product.parse(skuPartNumber);
  const productItem = await services.product.productItem.getDetail(skuPartNumber);
  if (attrName === 'current price') {
    services.world.store(key, productItem.CURRENTPRICE);
  }
  if (attrName === 'was price') {
    services.world.store(key, productItem.WASPRICE);
  }
  if (attrName === 'currency') {
    services.world.store(key, productItem.CURRENCY);
  }
  if (attrName === 'colour name') {
    services.world.store(key, productItem.COLOUR_NAME);
  }
  if (attrName === 'size name') {
    if (productItem.SIZE_NAME) {
      if (productItem.SIZE_NAME.match('s*([0-9]{4})') && productItem.SIZE_NAME.trim().length === 4 && services.env.Brand === 'ck') {
        const newSize = `${productItem.SIZE_NAME.slice(0, 2)}/${productItem.SIZE_NAME.slice(2)}`;
        services.world.store(key, newSize);
      } else {
        services.world.store(key, productItem.SIZE_NAME);
      }
    } else {
      let sizeName = '';
      if (productItem.WIDTH_NAME) {
        sizeName = productItem.WIDTH_NAME;
      }
      if (productItem.LENGTH_NAME) {
        const firstDigit = productItem.WIDTH_NAME.search(/\d/);
        if (firstDigit > 0) {
          sizeName = productItem.WIDTH_NAME.substring(firstDigit);
        }
        sizeName = `${sizeName} x ${productItem.LENGTH_NAME}`;
      }
      services.world.store(key, sizeName);
    }
  }
  if (attrName === 'width name') {
    services.world.store(key, productItem.WIDTH_NAME);
  }
  if (attrName === 'length name') {
    services.world.store(key, productItem.LENGTH_NAME);
  }
});

Given(/There (?:is|are) (\d+) one size product items? with find in store option of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))?/, async (resultCount: number, locale: string, langCode: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();

  await services.product.productItem.getProductItemOfOneSizeFindInStore(
    resultCount,
  );
});

Given(/There (?:is|are) (\d+) normal size product items? with find in store option of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))?/, async (resultCount: number, locale: string, langCode: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();

  await services.product.productItem.getProductItemOfNormalSizeFindInStore(
    resultCount,
  );
});
