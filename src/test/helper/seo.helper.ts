import { expect } from 'chai';
import { GetTestLogger } from '../../core/logger/test.logger';
import services from '../../core/services';

/* eslint-disable import/prefer-default-export */
const { structuredDataTest } = require('structured-data-testing-tool');
const { Google } = require('structured-data-testing-tool/presets');

interface Offer {
  sku: string,
  name: string,
  price: string,
  priceCurrency: string,
  url: string,
  availability: 'http://schema.org/InStock' | 'http://schema.org/OutOfStock',
  image: string,
}

const getProductSchema = (pdpUrl: string, styleColourPartNumber: string) => {
  const productSchema = {
    name: 'Product',
    description: 'Product',
    schema: 'Product',
    tests: [
      { test: 'Product', expect: true, type: 'jsonld' },
      { test: 'Product[*]."@type"', expect: 'Product' },
      { test: 'Product[*].name' },
      { test: 'Product[*].sku', expect: styleColourPartNumber.toUpperCase() },
      { test: 'Product[*].description' },
      { test: 'Product[*].image' },
      { test: 'Product[*].color' },
      { test: 'Product[*].mpn', expect: styleColourPartNumber.toUpperCase() },
      { test: 'Product[*].url', expect: false },
      { test: 'Product[*].brand' },
      { test: 'Product[*].Offers' },
      { test: 'Product[*].Offers[:].name' },
      { test: 'Product[*].Offers[:].sku' },
      { test: 'Product[*].Offers[:].image' },
      { test: 'Product[*].Offers[:].url', expect: pdpUrl },
      { test: 'Product[*].Offers[:].price', expect: /^\d+\.\d+$/g },
      { test: 'Product[*].Offers[:].priceCurrency', expect: /^(RUB|EUR|GBP|CZK|CHF|DKK|PLN|SEK)$/g },
    ],
  };
  return productSchema;
};

const getWebSiteSchema = (pageUrl: string) => {
  const webSiteSchema = {
    name: 'WebSite',
    description: 'WebSite',
    schema: 'WebSite',
    tests: [
      { test: 'WebSite', expect: true, type: 'jsonld' },
      { test: 'WebSite[0].url', expect: pageUrl },
      { test: 'WebSite[0].name', expect: services.env.Brand === 'th' ? 'Tommy Hilfiger' : 'Calvin Klein' },
      { test: 'WebSite[0].potentialAction', expect: true },
    ],
  };
  return webSiteSchema;
};

const offersValidation = async (offers: [], styleColourPartNumber: string) => {
  const detail = await services.product.productStyle.getDetail(styleColourPartNumber);
  for (let i = 0; i < offers.length; i += 1) {
    const offer: Offer = offers[i];
    const item = detail.PRODUCT_ITEM_DICT.get(offer.sku);
    if (!item) {
      throw new Error(`The offer has non-exist sku: ${offer.sku}, which is not exist for product ${styleColourPartNumber} from DB`);
    }
    expect(offer.name.toLowerCase().trim(), 'name is wrong').equals(detail.NAME.toLowerCase().trim());
    // The lib already parsed http://schema.org/
    expect(offer.availability, `availability is wrong, for style colour ${styleColourPartNumber} with sku: ${item.SKU_PARTNUMBER}`).equals(item.QUANTITY > 0 ? 'InStock' : 'OutOfStock');
    if (item.CURRENTPRICE !== 0) {
      expect(parseFloat(offer.price), `price is wrong, for style colour ${styleColourPartNumber} with sku: ${item.SKU_PARTNUMBER}`).eq(item.CURRENTPRICE);
      expect(offer.priceCurrency.trim(), `price currency is wrong, for style colour ${styleColourPartNumber} with sku: ${item.SKU_PARTNUMBER}`).equals(item.CURRENCY.trim());
    }
  }
};

// Check https://github.com/glitchdigital/structured-data-testing-tool
// To see how this tool works
export const verifyPDPSEOStructuredData = async (
  pdpUrl: string, styleColourPartNumber: string,
) => {
  const productSchema = getProductSchema(pdpUrl, styleColourPartNumber);
  const options = {
    presets: [Google, productSchema],
    auto: true,
  };
  let result;
  await structuredDataTest(encodeURI(pdpUrl), options)
    .then((res) => {
      result = res;
    })
    .catch((err) => {
      if (err.type === 'VALIDATION_FAILED') {
        result = err.res;
      } else {
        throw new Error(err);
      }
    })
    .finally(() => {
      if (result) {
        if (result.schemas.indexOf('Product') < 0) {
          throw new Error(`There is no structuredData schema "Product" at page ${pdpUrl}`);
        }
        GetTestLogger().info(
          `Structed data Test results for url ${pdpUrl}:
            - Passed: ${result.passed.length}
            - Failed: ${result.failed.length}
            - Warnings: ${result.warnings.length}
           Schemas found: ${result.schemas.join(',')}
          `,
        );
        if (result.failed.length > 0) {
          throw new Error(`${result.failed.map((test) => test.error.message)}`);
        }
      }
    });
  // offers validation
  const offers = result.structuredData.jsonld.Product[0].Offers;
  await offersValidation(offers, styleColourPartNumber);
};

export const verifyWebSiteSEOStructuredData = async (pageUrl: string) => {
  const webSiteSchema = getWebSiteSchema(pageUrl);
  const options = {
    presets: [Google, webSiteSchema],
    auto: true,
  };
  let result;
  await structuredDataTest(encodeURI(pageUrl), options)
    .then((res) => {
      result = res;
    })
    .catch((err) => {
      if (err.type === 'VALIDATION_FAILED') {
        result = err.res;
      } else {
        throw new Error(err);
      }
    })
    .finally(() => {
      if (result) {
        if (result.schemas.indexOf('WebSite') < 0) {
          throw new Error(`There is no structuredData schema "WebSite" at page ${pageUrl}`);
        }
        GetTestLogger().info(
          `Structed data Test results for url ${pageUrl}:
          - Passed: ${result.passed.length}
          - Failed: ${result.failed.length}
          - Warnings: ${result.warnings.length}
         Schemas found: ${result.schemas.join(',')}
        `,
        );
        if (result.failed.length > 0) {
          throw new Error(`${result.failed.map((test) => test.error.message)}`);
        }
      }
    });
};
