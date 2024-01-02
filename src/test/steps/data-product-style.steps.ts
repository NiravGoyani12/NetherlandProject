import { Given, When } from '@pvhqa/cucumber';
import services from '../../core/services';
import { GetTestLogger } from '../../core/logger/test.logger';
import { ProductItemDetail } from '../../core/db/product-model';

Given(/There (?:is|are) (\d+) product style with GBPC ([^\s]+) of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, gbpc: string, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productStyle.getProductStyleByGBPC(
    gbpc, inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+) normal size product styles? with store availibility of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))?/, async (resultCount: number, locale: string, langCode: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  const sizeAttrExpression = `size_${locale}>{size_xs_${locale}; size_s_${locale};size_l_${locale};size_xl_${locale};size_xxl_${locale}}`;

  await services.product.productStyle.getProductStylesWithStoreAvailability(
    resultCount, locale, sizeAttrExpression,
  );
});

Given(/There (?:is|are) (\d+) one size product styles? with store availibility of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))?/, async (resultCount: number, locale: string, langCode: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  const sizeAttrExpression = `size_${locale}=size_os_${locale}`;

  await services.product.productStyle.getProductStylesWithStoreAvailability(
    resultCount, locale, sizeAttrExpression,
  );
});

Given(/There (?:is|are) (\d+) width-length size product styles? with store availibility of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))?/, async (resultCount: number, locale: string, langCode: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  const sizeAttrExpression = `size_${locale}>{size_2528_${locale};size_2728_${locale};size_2530_${locale};size_3330_${locale};size_3332_${locale}}`;

  await services.product.productStyle.getProductStylesWithStoreAvailability(
    resultCount, locale, sizeAttrExpression,
  );
});

Given(/There (?:is|are) (\d+) one size product style of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?( filtered by SAP)?/, async (resultCount: number, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string, hasSAPFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productStyle.getProductStyleOfOneSize(
    inventoryMin, inventoryMax, resultCount, !!hasFHFilter, !!hasSAPFilter,
  );
});

Given(/There (?:is|are) (\d+) normal size product style of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productStyle.getProductSytleOfNormalSize(
    inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+) normal size product style of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? where (\d+) sizes? (?:is|are) out of stock with inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, locale: string, langCode: string, outOfStockCount: number, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productStyle.getProductStyleOfNormalSizeWithSizeStock(
    outOfStockCount, inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+) width-length size product style of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productStyle.getProductStyleOfMultipleSize(
    inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+) width-length size product style of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? where (\d+) sizes? (?:is|are) out of stock with inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, locale: string, langCode: string, outOfStockCount: number, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productStyle.getProductStyleOfWidthLengthSizeWithSizeStock(
    outOfStockCount, inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+) mul-width and single length size product style of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productStyle.getProductStyleOfMultipleWidthAndSingleLength(
    inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+) width only size product style of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productStyle.getProductStyleOfWidthOnlySize(
    inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+) Estee Lauder product style of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))?/, async (resultCount: number, locale: string, langCode: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productStyle.getProductStyleOfEsteeLauder(
    resultCount,
  );
});

Given(/There (?:is|are) (\d+) curved product style of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productStyle.getProductStyleOfCurvedProduct(
    inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+) (\d+)% extra discount product style of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)/, async (resultCount: number, percent: number, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productStyle.getProductStyleOfExtraDiscount(
    percent, services.site.locale, inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+)( discounted)? product style with (different|same) current price of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))?( filtered by FH)?/, async (resultCount: number, discounted: string, priceType: string, locale: string, langCode: string, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  if (priceType === 'different') {
    if (discounted) {
      await services.product.productStyle.getProductStyleWithDifferentCurrentPriceAndWasPrice(
        resultCount, !!hasFHFilter,
      );
    } else {
      await services.product.productStyle.getProductStyleWithDifferentCurrentPrice(
        resultCount, !!hasFHFilter,
      );
    }
  } else if (priceType === 'same') {
    if (discounted) {
      await services.product.productStyle.getProductStyleWithSameCurrentPriceAndWasPrice(
        resultCount, !!hasFHFilter,
      );
    } else {
      await services.product.productStyle.getProductStyleWithSameCurrentPrice(
        resultCount, !!hasFHFilter,
      );
    }
  }
});

Given(/I fetch details for product style (.*)/, async (styleColourPartNumber: string) => {
  styleColourPartNumber = services.product.parse(styleColourPartNumber);
  await services.product.productStyle.fetchProductStyleDetail(styleColourPartNumber);
});

When(/I extract a product item from product style ([^\s]+)(?: which has (lowest price|was price|inventory|no inventory|))? saved as (#[A-Za-z0-9]+)/, async (styleColourPartNumber: string, type: string, key: string) => {
  styleColourPartNumber = services.world.parse(styleColourPartNumber);
  styleColourPartNumber = services.product.parse(styleColourPartNumber);
  const styleDetail = await services.product.productStyle.getDetail(styleColourPartNumber);
  let item: ProductItemDetail;
  if (type === 'lowest price') {
    item = services.product.productStyle.extractProductItemWithLowestCurrentPrice(
      styleDetail,
    );
  } else if (type === 'was price') {
    item = services.product.productStyle.extractProductItemWithWasPrice(styleDetail);
  } else if (type === 'inventory') {
    item = services.product.productStyle.extractProductItemWithInventory(styleDetail);
  } else {
    item = services.product.productStyle.extractFirstProductItem(styleDetail);
  }
  GetTestLogger().info(`Extract ${item.SKU_PARTNUMBER} from style ${item.STYLECOLOUR_PARTNUMBER}`);
  services.world.store(key, item.SKU_PARTNUMBER);
});

When(/I extract a product item from product style ([^\s]+) which has stock (less than|equals) (\d+) saved as (#[A-Za-z0-9]+)/, async (styleColourPartNumber: string, type: string, count: number, key: string) => {
  styleColourPartNumber = services.world.parse(styleColourPartNumber);
  styleColourPartNumber = services.product.parse(styleColourPartNumber);
  const styleDetail = await services.product.productStyle.getDetail(styleColourPartNumber);
  let item: ProductItemDetail;
  if (type === 'less than') {
    item = services.product.productStyle.extractProductItemWithInventory(styleDetail, 1, count);
  } else if (type === 'equals') {
    item = services.product.productStyle.extractProductItemWithInventory(styleDetail, count, count);
  }
  GetTestLogger().info(`Extract ${item.SKU_PARTNUMBER} from style ${item.STYLECOLOUR_PARTNUMBER}`);
  services.world.store(key, item.SKU_PARTNUMBER);
});

Given(/I fetch (current price|was price|currency) of product style ([^\s]+) saved as (#[A-Za-z0-9]+)/, async (priceAttribute: string, styleColourPartNumber: string, key: string) => {
  styleColourPartNumber = services.world.parse(styleColourPartNumber);
  styleColourPartNumber = services.product.parse(styleColourPartNumber);
  const productStyle = await services.product.productStyle.getDetail(styleColourPartNumber);
  const productItemValues = Array.from(productStyle.PRODUCT_ITEM_DICT.values()).filter((e) => e[priceAttribute.replace(' ', '').toUpperCase()]);
  if (priceAttribute === 'current price') {
    services.world.store(key, productItemValues[0].CURRENTPRICE);
  }
  if (priceAttribute === 'was price') {
    services.world.store(key, productItemValues[0].WASPRICE);
  }
  if (priceAttribute === 'currency') {
    services.world.store(key, productItemValues[0].CURRENCY);
  }
});

Given(/There (?:is|are) (\d+) sustainable product style with Sustainable type ([^\s]+) of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, sustainableType: string, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productStyle.getProductStyleOfSustainableType(
    sustainableType, inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+) product style with Benefit type ([^\s]+) of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, BenefitType: string, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productStyle.getProductStyleOfBenefitType(
    BenefitType, inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+) product style with Promotion type (.*) of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, promotionType: string, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productStyle.getProductStyleOfPromotionType(
    promotionType, inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});

Given(/There (?:is|are) (\d+) exclusive access product of type (.*) of locale (default|[^\s]+)(?: and langCode (default|[^\s]+))? with inventory between (\d+) and (\d+)( filtered by FH)?/, async (resultCount: number, productType: string, locale: string, langCode: string, inventoryMin: number, inventoryMax: number, hasFHFilter: string) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  await services.product.productStyle.getExclusiveProductofType(
    productType, inventoryMin, inventoryMax, resultCount, !!hasFHFilter,
  );
});
