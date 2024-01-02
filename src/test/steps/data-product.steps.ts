import { Given, When } from '@pvhqa/cucumber';
import { PlusSizeIdentifiers } from '../../core/db/product-model';
import { GetTestLogger } from '../../core/logger/test.logger';
import services from '../../core/services';

// eslint-disable-next-line max-len
// TODO: add 'filtered by FH' paramater to the step (DB query also needs to be updated since it only returns 2 variables, and we need to send secondid to FH query. Which isn't included in the current query results)
Given(/There (?:is|are) (\d+)(?: multi colour| single colour|) products? with( at least)? (\d+) colours? of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)/, async (resultCount: number, atLeast: string, colours: number, locale: string, langCode: string, inventoryMin: number, inventoryMax: number) => {
  const operator = atLeast ? '>=' : '=';
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.product.getProductWithMultipleColurs(
    colours, operator, inventoryMin, inventoryMax, resultCount,
  );
});

When(/I extract a product style from product ([^\s]+) saved as (#[A-Za-z0-9]+)/, async (stylePartNumber: string, key: string) => {
  stylePartNumber = services.product.parse(stylePartNumber);
  const detail = await services.product.product.getDetail(stylePartNumber);

  const colourDetailList = services.product.product.extractInStockStyleColours(detail);
  if (!colourDetailList || colourDetailList.length <= 0) {
    throw new Error(`Failed to extract product colour from product ${stylePartNumber}`);
  }
  const index = colourDetailList.length > 1 ? 1 : 0;
  services.world.store(key, colourDetailList[index].STYLECOLOUR_PARTNUMBER);
});

When(/I extract product style from product ([^\s]+)(?: with index (.*))? saved as (#[A-Za-z0-9]+)/, async (stylePartNumber: string, indexNo: string, key: string) => {
  stylePartNumber = services.product.parse(stylePartNumber);
  const detail = await services.product.product.getDetail(stylePartNumber);

  const colourDetailList = services.product.product.extractInStockStyleColours(detail);
  if (!colourDetailList || colourDetailList.length <= 0) {
    throw new Error(`Failed to extract product colour from product ${stylePartNumber}`);
  }
  if (colourDetailList.length > 1
    && Number.parseInt(indexNo, 10) <= colourDetailList.length - 1) {
    services.world.store(key, colourDetailList[indexNo].STYLECOLOUR_PARTNUMBER);
  } else {
    throw new Error(`Failed to extract product colour from product ${stylePartNumber} with index ${indexNo}. There are only ${colourDetailList.length} available. (Note: Index count starts at zero)`);
  }
});

When(/I extract(?: (.*))? plus-sized identifiers? saved as (#[A-Za-z0-9]+)/, async (count: number, key: string) => {
  let plusSizeIdentifiers: PlusSizeIdentifiers;
  if (!count) {
    plusSizeIdentifiers = await services.product.product
      .extractIdentifierForPlusSize(1);
  } else {
    plusSizeIdentifiers = await services.product.product
      .extractIdentifierForPlusSize(count);
  }
  let i = 0;
  let identifier: string = '';
  plusSizeIdentifiers.forEach(() => {
    identifier = plusSizeIdentifiers[i].IDENTIFIER;
    identifier = identifier.substr(identifier.indexOf('_') + 1, identifier.length);
    services.world.store(key + i, identifier);
    GetTestLogger().info(`Identifier stored: ${identifier} as ${key + i}`);
    i += 1;
  });
});
