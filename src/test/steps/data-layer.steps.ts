import { When, Then } from '@pvhqa/cucumber';
import { expect } from 'chai';
import joi from '@hapi/joi';
import services from '../../core/services';
import { GetTestLogger } from '../../core/logger/test.logger';
import { getStore } from '../helper/utils.helper';

const sessionStorageName = 'utagtest';
const utagInject = `
  window.utag_events = [];
  window.utag.link = function(data) {
    window.utag_events.push(data);
    if(sessionStorage.getItem('${sessionStorageName}')) {
          var list = JSON.parse(sessionStorage.getItem('${sessionStorageName}'));
          list.push(data);
          sessionStorage.setItem('${sessionStorageName}', JSON.stringify(list));
    } else {
          sessionStorage.setItem('${sessionStorageName}', JSON.stringify(window.utag_events));
    }
  }
`;

When(/I inject utag event listener/, async () => {
  await browser.waitUntilResult(async () => {
    const result = await browser.execute('return utag.data');
    return result;
  }, 'Utag is not defined', services.env.DriverConfig.timeout.pageLoad);
  await browser.execute((name) => {
    if (sessionStorage.getItem(name)) {
      sessionStorage.removeItem(name);
    }
  }, sessionStorageName);
  await browser.execute(utagInject);
});

When(/I clear record utag event listener/, async () => {
  await browser.execute((name) => {
    if (sessionStorage.getItem(name)) {
      sessionStorage.removeItem(name);
    }
    (window as any).utag_events = [];
  }, sessionStorageName);
});

Then(/utag event ([^\s]+) is not fired/, async (utagEventName: string) => {
  const storage: Array<any> = await browser.waitUntilResult(async () => {
    const s: Array<any> = await browser.execute(`return JSON.parse(sessionStorage.getItem("${sessionStorageName}"))`);
    if (s !== null) {
      const results = s.filter((item) => item.event_name === utagEventName);
      if (results && results.length === 0) {
        return [];
      }
    } else {
      return [];
    }
    return null;
  }, 'unexpected error raised', 20000);
  expect(storage).to.be.empty;
});

Then(/utag event (.*) is fired saved to key (#[A-Za-z0-9]+)/, async (utagEventName: string, key: string) => {
  const storage: Array<any> = await browser.waitUntilResult(async () => {
    const s: Array<any> = await browser.execute(`return JSON.parse(sessionStorage.getItem("${sessionStorageName}"))`);
    const results = s.filter((item) => item.event_name === utagEventName);
    if (results && results.length === 0) {
      return undefined;
    }
    return results;
  }, 'There are no utag events recorded', 20000);
  const event = storage.filter((s) => s.event_name === utagEventName);
  if (!event || event.length === 0) {
    throw new Error(`The event ${utagEventName} is not fired`);
  }
  if (event.length > 1) {
    throw new Error(`The event ${utagEventName} should be fired only 1 time, but fired ${event.length} times`);
  }
  GetTestLogger().info(`Utag event: ${JSON.stringify(event[0])}`);
  services.world.store(key, event[0]);
  services.world.store(`${key}-report`, { event_name: joi.string().min(1).required() });
});

Then(/utag event (#[A-Za-z0-9]+) should contain attr ([^\s]+) with( value| one of the values|) "(.*)"( in upper case| in lower case|)?/, async (key: string, attrName: string, numberOfValues: string, attrValue: string, valueCase: string) => {
  const report = services.world.parseByType<Map<string, any>>(`${key}-report`);
  attrValue = services.world.parse(attrValue);
  attrValue = services.product.parse(attrValue);
  if (valueCase && valueCase.indexOf('upper') > 0) {
    attrValue = attrValue.toLocaleUpperCase();
  } else if (valueCase && valueCase.indexOf('lower') > 0) {
    attrValue = attrValue.toLocaleLowerCase();
  }
  // in case two values are correct
  if (numberOfValues.includes('one of the values')) {
    const values: any[] = attrValue.split(',');
    const firstValue = values[0];
    const secondValue = values[1];
    report[attrName] = joi.string().valid(`${firstValue}`, `${secondValue}`).required();
  } else {
    report[attrName] = joi.string().custom((value: string) => {
      if ((attrName === 'product_combi_upper_case') && value !== attrValue) {
        throw new Error(`(High priority) Expected value: product_combi_uppercase:"${attrValue}" ,
      Actual value: product_combi_uppercase:"${value}"`);
      } else if (value !== attrValue) {
        throw new Error(`expected value is "${attrValue}" but current value is "${value}"`);
      }
    }).required();
  }
  services.world.store(`${key}-report`, report);
});

Then(/^utag event (#[A-Za-z0-9]+) should contain attr ([^\s]+) with( upper case| in lower case|)? value of digitalData.(.*)$/, async (key: string, attrName: string, valueCase: string, digitalDataKey: string) => {
  const report = services.world.parseByType<Map<string, any>>(`${key}-report`);
  let attrValue = await browser.waitUntilResult(async () => {
    const result = await browser.execute(`return digitalData.${digitalDataKey}`);
    return result;
  }, `digitalData.${digitalDataKey} is not defined`, services.env.DriverConfig.timeout.pageLoad);
  if (valueCase && valueCase.indexOf('upper') > 0) {
    attrValue = attrValue.toLocaleUpperCase();
  } else if (valueCase && valueCase.indexOf('lower') > 0) {
    attrValue = attrValue.toLocaleLowerCase();
  }
  report[attrName] = joi.string().custom((value: string) => {
    if (value !== attrValue) {
      throw new Error(`expected value is "${attrValue}" but current value is "${value}"`);
    }
  }).required();
  services.world.store(`${key}-report`, report);
});

Then(/utag event (#[A-Za-z0-9]+) should at least contain attr ([^\s]+) with value "(.*)"/, async (key: string, attrName: string, atLeastValue: string) => {
  const report = services.world.parseByType<Map<string, any>>(`${key}-report`);
  report[attrName] = joi.string().custom((value: string) => {
    if (!value.includes(atLeastValue)) {
      throw new Error(`expected value contains at least "${atLeastValue}" but current value is "${value}"`);
    }
  });
  services.world.store(`${key}-report`, report);
});

Then(/utag event (#[A-Za-z0-9]+) should( optionally)? contain( upper case| lower case|)? non-empty attr ([^\s]+)/, async (key: string, option: string, valueCase: string, attrName: string) => {
  const report = services.world.parseByType<Map<string, any>>(`${key}-report`);
  if (option) {
    valueCase === ' lower case' ? (report[attrName] = joi.string().lowercase().optional()) : (report[attrName] = joi.string().uppercase().optional());
  } else {
    valueCase === ' lower case' ? (report[attrName] = joi.string().min(1).lowercase().required()) : (report[attrName] = joi.string().uppercase().min(1).required());
  }
  services.world.store(`${key}-report`, report);
});

Then(/utag event (#[A-Za-z0-9]+) should contain non-empty array ([^\s]+)/, async (key: string, attrName: string) => {
  const report = services.world.parseByType<Map<string, any>>(`${key}-report`);
  report[attrName] = joi.array().items().required();
  services.world.store(`${key}-report`, report);
});

Then(/utag event (#[A-Za-z0-9]+) should not contain attr ([^\s]+)/, async (key: string, attrName: string) => {
  const report = services.world.parseByType<Map<string, any>>(`${key}-report`);
  report[attrName] = joi.string().forbidden();
  services.world.store(`${key}-report`, report);
});

Then(/utag event (#[A-Za-z0-9]+) for categoryId ([^\s]+) should contain (PriceFilter|maincolour) attr ([^\s]+)/, async (key: string, searchOrCategoryName: string, searchOrfacetType: string, attrName: string) => {
  const report = services.world.parseByType<Map<string, any>>(`${key}-report`);
  const acceptStore: string = await getStore(services.site.locale);
  let expectedTrackingId: string;
  let index: number;
  const responseBody = JSON.parse(await services.transformers
    .getDesktopProductList(
      searchOrCategoryName,
      services.site.siteInfo.LOCALENAME,
      acceptStore,
      services.site.locale,
    ));
  // Get correct tracking id via transformers api
  for (let n = 0; n < responseBody.meta.filters.length; n += 1) {
    if (responseBody.meta.filters[n].id.trim().toLocaleLowerCase()
      === searchOrfacetType.toLocaleLowerCase()) {
      expectedTrackingId = responseBody.meta.filters[n].trackingId;
    }
  }

  const count = await browser.execute('return window.__NEXT_DATA__.props.initialState.productList.meta.filters.length');

  for (let propFilterIndex = 0; propFilterIndex < count; propFilterIndex += 1) {
    // eslint-disable-next-line no-await-in-loop
    const idValue: string = await browser.execute(`return window.__NEXT_DATA__.props.initialState.productList.meta.filters[${propFilterIndex}].id`);
    if (idValue.trim().toLocaleLowerCase() === searchOrfacetType.toLocaleLowerCase()) {
      index = propFilterIndex;
      break;
    }
  }
  const actualXoTrackingId = await browser.execute(`return window.__NEXT_DATA__.props.initialState.productList.meta.filters[${index}].trackingId`);

  report[attrName] = await joi.string().custom(async () => {
    if (actualXoTrackingId !== expectedTrackingId) {
      throw new Error(`"Actual value: ${actualXoTrackingId},
      Expected value: ${expectedTrackingId}"`);
    }
    services.world.store(`${key}-report`, report);
  }).required();
});


Then(/utag event (#[A-Za-z0-9]+) should contain attr ([^\s]+) with value of (division|list|name|colour|gender|out of stock sizes|colour based full stock|product low price|product price|product base price|discount status|discount|gbpc|availability percentage) of product style ([^\s]+)/, async (key: string, attrName: string, valueType: string, styleColourPartNumber: string) => {
  const report = services.world.parseByType<Map<string, any>>(`${key}-report`);
  styleColourPartNumber = services.world.parse(styleColourPartNumber);
  styleColourPartNumber = services.product.parse(styleColourPartNumber);
  const detail = await services.product.productStyle.getDetail(styleColourPartNumber);
  const priceInfo = services.product.productStyle.extractMinMaxPrice(detail);
  const locale = services.site.locale.toString().toLocaleLowerCase();
  let { langCode } = services.site;
  langCode ? langCode = langCode.toString().toLocaleLowerCase() : undefined;

  let listInfo = '';
  try {
    listInfo = await browser.execute('return window.digitalData.page.category.productStructureGroupId');
    if (listInfo === null) {
      if (detail.LIST) {
        listInfo = detail.LIST;
      }
    }
  } finally {
    listInfo === undefined;
  }
  if (listInfo != null) {
    // exclude country code, language code or scandinavia code
    if (listInfo.includes(locale) || listInfo.includes(locale) || listInfo.includes('SCAN')) {
      let removePart = listInfo.split('_');
      removePart = removePart.splice(0, removePart.length - 1);
      listInfo = removePart.join().replace(/[,]/g, '_');
    }
  }

  const outOfStockItems = services.product.productStyle
    .extractProductItemListWithInventory(detail, 0, 0);

  const basePrice = priceInfo.minWasPrice
    && priceInfo.minWasPrice !== Number.MAX_VALUE
    && priceInfo.minWasPrice !== priceInfo.minCurrentPrice
    ? priceInfo.minWasPrice
    : priceInfo.minCurrentPrice;
  const discount = basePrice - priceInfo.minCurrentPrice;

  switch (valueType) {
    case 'availability percentage':
      report[attrName] = joi.string().custom(async (value: string) => {
        const allSizes = await services.product.productStyle
          .extractProductItems(detail).length;
        const inStockSizes = (allSizes - outOfStockItems.length);
        const percentage = ((inStockSizes / allSizes) * 100).toFixed(2).toString();
        if (value !== percentage) {
          throw new Error(`expected productAvailabilityPercentage is ${percentage} but vurrent value is ${value}`);
        }
        return value;
      }).required();
      break;
    case 'division':
      report[attrName] = joi.string().custom((value: string) => {
        if (value !== detail.DIVISION.toLocaleLowerCase().trim()) {
          throw new Error(`expected value is "${detail.DIVISION.toLocaleLowerCase().trim()}" but current value is "${value}"`);
        }
      }).required();
      break;
    case 'list':
      report[attrName] = joi.string().custom((value: string) => {
        if (listInfo) {
          if (value !== listInfo.toLocaleLowerCase().trim()) {
            throw new Error(`expected value is "${listInfo.toLocaleLowerCase().trim()}" but current value is "${value}"`);
          }
        } else if (listInfo === null) {
          throw new Error('expected product_list value is not present');
        }
      }).required();
      break;
    case 'name':
      report[attrName] = joi.string().custom((value: string) => {
        if (value !== detail.ANALYTICS_NAME.trim().toLocaleLowerCase()) {
          throw new Error(`(High priority) Expected value: product_name:"${detail.ANALYTICS_NAME.trim().toLocaleLowerCase()}",
          Actual value: product_name:"${value}"`);
        }
      }).required();
      break;
    case 'colour':
      report[attrName] = joi.string().custom((value: string) => {
        if (value !== detail.ANALYTICS_MAIN_COLOUR.toLocaleLowerCase()) {
          throw new Error(`expected value is "${detail.ANALYTICS_MAIN_COLOUR.toLocaleLowerCase()}" but current value is "${value}"`);
        }
      }).required();
      break;
    case 'gender':
      report[attrName] = joi.string().custom(async (value: string) => {
        let expectedGender = detail.GBPC.split('_')[0].toLocaleLowerCase();
        if (expectedGender === null) {
          expectedGender = await browser.execute('return window.__NEXT_DATA__.props.initialState.pdp.gender');
        }
        if (value !== expectedGender) {
          throw new Error(`expected product_gender is "${expectedGender}" but current value is "${value}"`);
        }
      }).required();
      break;
    case 'colour based full stock':
      report[attrName] = joi.string().custom((value: string) => {
        const expectedOOSItems = outOfStockItems.length > 0 ? '0' : '1';
        if (value !== expectedOOSItems) {
          throw new Error(`expected value is "${expectedOOSItems}" but current value is "${value}"`);
        }
      }).required();
      break;
    case 'out of stock sizes':
      if (outOfStockItems && outOfStockItems.length > 0) {
        if (outOfStockItems[0].SIZE_NAME) {
          report[attrName] = joi.string().custom((value: string) => {
            value = value.split(',').sort().join(',');
            const expectedValue = outOfStockItems.map((p) => p.SIZE_NAME.toLocaleLowerCase()).sort().join(',');
            if (value !== expectedValue.trim()) {
              throw new Error(`expected product_out_of_stock_sizes is "${expectedValue}" but current value is "${value}"`);
            }
            return value;
          });
        } else if (outOfStockItems[0].WIDTH_NAME && !outOfStockItems[0].LENGTH_NAME) {
          report[attrName] = joi.string().custom((value: string) => {
            value = value.split(',').sort().join(',');
            const expectedValue = outOfStockItems.map((p) => p.WIDTH_NAME.toLocaleLowerCase()).sort().join(',');
            if (value !== expectedValue.trim()) {
              throw new Error(`expected product_out_of_stock_sizes is "${expectedValue}" but current value is "${value}"`);
            }
            return value;
          });
        } else if (outOfStockItems[0].WIDTH_NAME && outOfStockItems[0].LENGTH_NAME) {
          report[attrName] = joi.string().custom((value: string) => {
            value = value.split(',').sort().join(',');
            let expectedValue = outOfStockItems.map((p) => `${p.WIDTH_NAME.toLocaleLowerCase()}-${p.LENGTH_NAME.toLocaleLowerCase()}`).sort().join(',');
            if (expectedValue.includes('eu')) {
              expectedValue = expectedValue.replace('eu', '');
            }
            if (value !== expectedValue.trim()) {
              throw new Error(`expected product_out_of_stock_sizes is "${expectedValue}" but current value is "${value}"`);
            }
            return value;
          });
        } else {
          throw new Error(`Cannot identify the sizes for product stlye: ${styleColourPartNumber}`);
        }
      } else {
        report[attrName] = joi.string().forbidden();
      }
      break;
    case 'product low price':
      report[attrName] = joi.string().custom((value: string) => {
        if (value !== priceInfo.minCurrentPrice.toFixed(2).toString()) {
          throw new Error(`expected value is "${priceInfo.minCurrentPrice.toFixed(2).toString()}" but current value is "${value}"`);
        }
      }).required();
      break;
    case 'product price':
      report[attrName] = joi.string().custom((value: string) => {
        if (value !== priceInfo.minCurrentPrice.toFixed(2).toString()) {
          throw new Error(`expected value is "${priceInfo.minCurrentPrice.toFixed(2).toString()}" but current value is "${value}"`);
        }
      }).required();
      break;
    case 'product base price':
      report[attrName] = joi.string().custom((value: string) => {
        if (value !== basePrice.toFixed(2).toString()) {
          throw new Error(`expected value is "${basePrice.toFixed(2).toString()}" but current value is "${value}"`);
        }
      }).required();
      break;
    case 'discount status':
      report[attrName] = joi.string().custom((value: string) => {
        const expectedDiscountStatus = priceInfo.minWasPrice && priceInfo.minWasPrice !== Number.MAX_VALUE && priceInfo.minWasPrice !== priceInfo.minCurrentPrice ? 'discounted' : 'full';
        if (value !== expectedDiscountStatus) {
          throw new Error(`expected value is "${expectedDiscountStatus}" but current value is "${value}"`);
        }
      }).required();
      break;
    case 'discount':
      report[(attrName)] = joi.string().custom((value: string) => {
        if (value !== '0') {
          report[attrName] = joi.string().custom(() => {
            if (value !== discount.toFixed(2)) {
              throw new Error(`expected value is "${discount.toFixed(2)}" but current value is "${value}"`);
            }
          }).required();
        } else {
          report[attrName] = joi.string().custom(() => {
            if (value !== '0') {
              throw new Error(`expected value is "0" but current value is "${value}"`);
            }
          }).required();
        }
      });
      break;
    case 'gbpc':
      if (detail.GBPC === null) {
        report[attrName] = joi.string().optional();
      } else if (detail.GBPC) {
        report[attrName] = joi.string().custom((value: string) => {
          if (value !== detail.GBPC.toLocaleLowerCase()) {
            throw new Error(`expected value is "${detail.GBPC.toLocaleLowerCase()}" but current value is "${value}"`);
          }
        }).required();
      }
      break;
    default:
      throw new Error(`Cannot match ${valueType}`);
  }
  services.world.store(`${key}-report`, report);
});

Then(/utag event (#[A-Za-z0-9]+) should contain attr ([^\s]+) with value of (product price|product low price|product base price|discount status|size|discount) of product item ([^\s]+)/, async (key: string, attrName: string, valueType: string, skuPartNumber: string) => {
  const report = services.world.parseByType<Map<string, any>>(`${key}-report`);
  skuPartNumber = services.world.parse(skuPartNumber);
  skuPartNumber = services.product.parse(skuPartNumber);
  const detail = await services.product.productItem.getDetail(skuPartNumber);

  const productLowPrice = detail.CURRENTPRICE || detail.WASPRICE;
  const productBasePrice = detail.WASPRICE || detail.CURRENTPRICE;
  const discount = productBasePrice - productLowPrice;

  switch (valueType) {
    case 'product price':
      report[attrName] = joi.string().custom((value: string) => {
        if (value !== productLowPrice.toFixed(2).toString()) {
          throw new Error(`expected value is "${productLowPrice.toFixed(2).toString()}" but current value is "${value}"`);
        }
      }).required();
      break;
    case 'product low price':
      report[attrName] = joi.string().custom((value: string) => {
        if (value !== productLowPrice.toFixed(2).toString()) {
          throw new Error(`expected value is "${productLowPrice.toFixed(2).toString()}" but current value is "${value}"`);
        }
      }).required();
      break;
    case 'product base price':
      report[attrName] = joi.string().custom((value: string) => {
        if (value !== productBasePrice.toFixed(2).toString()) {
          throw new Error(`expected value is "${productBasePrice.toFixed(2).toString()}" but current value is "${value}"`);
        }
      }).required();
      break;
    case 'discount status':
      report[attrName] = joi.string().custom((value: string) => {
        const expectedDiscountStatus = detail.WASPRICE && detail.WASPRICE !== detail.CURRENTPRICE ? 'discounted' : 'full';
        if (value !== expectedDiscountStatus) {
          throw new Error(`expected value is "${expectedDiscountStatus}" but current value is "${value}"`);
        }
      }).required();
      break;
    case 'discount':
      report[(attrName)] = joi.string().custom((value: string) => {
        if (value !== '0') {
          report[attrName] = joi.string().custom(() => {
            if (value !== discount.toFixed(2)) {
              throw new Error(`expected value is "${discount.toFixed(2)}" but current value is "${value}"`);
            }
          }).required();
        } else {
          report[attrName] = joi.string().custom(() => {
            if (value !== '0') {
              throw new Error(`expected value is "0" but current value is "${value}"`);
            }
          }).required();
        }
      });
      break;
    case 'size':
      if (detail.SIZE_NAME) {
        if (detail.SIZE_NAME.toLocaleLowerCase() === 'one size' || detail.SIZE_NAME.toLocaleLowerCase() === 'os') {
          report[attrName] = joi.string().custom((value: string) => {
            if (value !== 'one size') {
              throw new Error(`expected value is "one size" but current value is "${value}"`);
            }
          }).required();
        } else {
          report[attrName] = joi.string().custom((value: string) => {
            if (value !== detail.SIZE_NAME.toLocaleLowerCase()) {
              throw new Error(`expected value is "${detail.SIZE_NAME.toLocaleLowerCase()}" but current value is "${value}"`);
            }
          }).required();
        }
      } else if (detail.WIDTH_NAME && !detail.LENGTH_NAME) {
        report[attrName] = joi.string().custom((value: string) => {
          if (value !== detail.WIDTH_NAME.toLocaleLowerCase()) {
            throw new Error(`expected value is "${detail.WIDTH_NAME.toLocaleLowerCase()}" but current value is "${value}"`);
          }
        }).required();
      } else if (detail.WIDTH_NAME && detail.LENGTH_NAME) {
        report[(attrName)] = joi.string().equal(`${detail.WIDTH_NAME}-${detail.LENGTH_NAME}`.toLocaleLowerCase()).required();
        report[attrName] = joi.string().custom((value: string) => {
          if (value !== `${detail.WIDTH_NAME}-${detail.LENGTH_NAME}`.toLocaleLowerCase()) {
            throw new Error(`expected value is "${detail.WIDTH_NAME}-${detail.LENGTH_NAME}" but current value is "${value}"`);
          }
        }).required();
      }
      break;
    default:
      throw new Error(`Cannot match ${valueType}`);
  }
  services.world.store(`${key}-report`, report);
});

Then(/utag event (#[A-Za-z0-9]+) should contain attr ([^\s]+) with value of full stock of product ([^\s]+)/, async (key: string, attrName: string, stylePartNumber: string) => {
  const report = services.world.parseByType<Map<string, any>>(`${key}-report`);
  stylePartNumber = services.product.parse(stylePartNumber);
  const detail = await services.product.product.getDetail(stylePartNumber);

  const outOfStockItems = services.product.product
    .extractOutOfStockProductItems(detail);

  report[attrName] = joi.string().equal(outOfStockItems.length > 0 ? '0' : '1').required();
  services.world.store(`${key}-report`, report);
});

Then(/I execute all datalayer event validation( with allowed unknown attribute)? with report key (#[A-Za-z0-9]+)/, async (allowUnknownAttribute: string, key: string) => {
  const report = services.world.parseByType<Map<string, any>>(`${key}-report`);
  if (!report) {
    throw new Error(`No datalayer schema validation under ${key}`);
  }
  const json = services.world.parseByType<Map<string, any>>(key);
  if (!json) {
    throw new Error(`No datalayer attributes under ${key}`);
  }
  const schema = joi.object(report);
  await schema.validateAsync(json,
    { abortEarly: false, allowUnknown: !!allowUnknownAttribute });
});
