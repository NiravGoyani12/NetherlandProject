/* eslint-disable implicit-arrow-linebreak */
import { When, Then } from '@pvhqa/cucumber';
import services from '../../core/services';
import { GetTestLogger } from '../../core/logger/test.logger';
import {
  siteModuleSchema, versionModuleSchemaUnified, guestUserModuleSchemaUnified,
  guestUserModulePlpSchemaUnified, registeredUserModuleSchemaUnified,
  registeredUserModulePlpSchemaUnified,
  pageModuleSchemaUnified, pageModuleSchema,
  versionModuleSchema, guestUserModuleSchema, registeredUserModuleSchema,
  wishlistModuleSchemaUnified, pdpProductModuleSchemaUnified, pdpProductModuleSchema,
  wishlistModuleSchema, cartItemModuleSchema, cartModuleSchema, transactionModuleSchema,
  transactionItemModuleSchema, plpProductModuleSchema, variable, pageVariablesSchema,
  // eslint-disable-next-line import/named
  digitalDataModules, emptyWishlistSchema, pageModulePlpSchemaUnified, giftcardModuleSchema,
  guestUserOrderConfirmationModuleSchemaUnified,
} from '../helper/digital-data-schema.helper';

When(/I validate digital data site module with report key (#[A-Za-z0-9]+)/, async (key: string) => {
  const moduleName = 'site';
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName};`));
      return result;
    }, `window.digitalData.${moduleName} is not defined`, 15000,
  );
  GetTestLogger().info(`Digital data Site module: ${JSON.stringify(json)}`);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  validations.push(siteModuleSchema().validateAsync({ site: json }, { abortEarly: false }));
  services.world.store(key, validations);
});

When(/I validate( unified)? digital data (registered|guest) user module( with allowed unknown attributes)? with report key (#[A-Za-z0-9]+)/, async (isUnified: string, userType: string, allowUnknownAttribute: string, key: string) => {
  const moduleName = 'user';
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName};`));
      return result;
    }, `window.digitalData.${moduleName} is not defined`, 15000,
  );
  GetTestLogger().info(`Digital data User module: ${JSON.stringify(json)}`);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  let module;
  if (isUnified) {
    if (userType === 'guest') {
      module = guestUserModuleSchemaUnified();
    } else {
      module = registeredUserModuleSchemaUnified();
    }
  } else if (userType === 'guest') {
    module = guestUserModuleSchema();
  } else {
    module = registeredUserModuleSchema();
  }
  validations.push(module.validateAsync({ user: json },
    { abortEarly: false, allowUnknown: !!allowUnknownAttribute }));
  services.world.store(key, validations);
});

When(/I validate( unified)? digital data (registered|guest) order confirmation user module( with allowed unknown attributes)? with report key (#[A-Za-z0-9]+)/, async (isUnified: string, userType: string, allowUnknownAttribute: string, key: string) => {
  const moduleName = 'user';
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName};`));
      return result;
    }, `window.digitalData.${moduleName} is not defined`, 15000,
  );
  GetTestLogger().info(`Digital data User module: ${JSON.stringify(json)}`);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  let module;
  if (isUnified) {
    if (userType === 'guest') {
      module = guestUserOrderConfirmationModuleSchemaUnified();
    } else {
      module = registeredUserModuleSchemaUnified();
    }
  } else if (userType === 'guest') {
    module = guestUserModuleSchema();
  } else {
    module = registeredUserModuleSchema();
  }
  validations.push(module.validateAsync({ user: json },
    { abortEarly: false, allowUnknown: !!allowUnknownAttribute }));
  services.world.store(key, validations);
});

When(/I validate( unified)? digital data (registered|guest) plp user module( with allowed unknown attributes)? with report key (#[A-Za-z0-9]+)/, async (isUnified: string, userType: string, allowUnknownAttribute: string, key: string) => {
  const moduleName = 'user';
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName};`));
      return result;
    }, `window.digitalData.${moduleName} is not defined`, 15000,
  );
  GetTestLogger().info(`Digital data User module: ${JSON.stringify(json)}`);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  let module;
  if (isUnified) {
    if (userType === 'guest') {
      module = guestUserModulePlpSchemaUnified();
    } else {
      module = registeredUserModulePlpSchemaUnified();
    }
  }
  validations.push(module.validateAsync({ user: json },
    { abortEarly: false, allowUnknown: !!allowUnknownAttribute }));
  services.world.store(key, validations);
});

When(/I validate( unified)? digital data pdp product module of style colour partnumber ([^\s]+) with report key (#[A-Za-z0-9]+)/, async (isUnified: string, styleColourPartNumber: string, key: string) => {
  styleColourPartNumber = services.world.parse(styleColourPartNumber);
  styleColourPartNumber = services.product.parse(styleColourPartNumber);
  const moduleName = 'product';
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName};`));
      return result;
    }, `window.digitalData.${moduleName} is not defined`, 15000,
  );
  GetTestLogger().info(`Digital data Product module: ${JSON.stringify(json)}`);
  const detail = await services.product.productStyle.getDetail(styleColourPartNumber);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  let module;
  isUnified ? (module = await pdpProductModuleSchemaUnified(detail))
    : (module = await pdpProductModuleSchema(detail));
  validations.push((module)
    .validateAsync({ product: json }, { abortEarly: false, allowUnknown: true }));
  services.world.store(key, validations);
});

When(/I validate( unified)? digital data page module on (.*) with following data with report key (#[A-Za-z0-9]+)/, async (isUnified: string, pageType: string, key: string, data: string) => {
  const moduleName = 'page';
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName};`));
      return result;
    }, `window.digitalData.${moduleName} is not defined`, 15000,
  );
  GetTestLogger().info(`Digital data Page module: ${JSON.stringify(json)}`);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  let module;
  if (pageType === 'plp') {
    module = await pageModulePlpSchemaUnified(json);
  } else {
    isUnified ? (module = await pageModuleSchemaUnified(pageType, JSON.parse(data)))
      : (module = await pageModuleSchema(pageType, JSON.parse(data)));
  }
  validations.push(module
    .validateAsync({ page: json }, { abortEarly: false, allowUnknown: false }));
  services.world.store(key, validations);
});

When(/I validate empty digital data wishlist module with report key (#[A-Za-z0-9]+)/, async (key: string) => {
  const moduleName = 'wishlist';
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName};`));
      return result;
    }, `window.digitalData.${moduleName} is not defined`, 15000,
  );
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  validations.push(emptyWishlistSchema().validateAsync({ wishlist: json },
    { abortEarly: false, allowUnknown: true }));
  services.world.store(key, validations);
});

When(/I validate( unified)? digital data wishlist module of style colour partnumber ([^\s]+) with report key (#[A-Za-z0-9]+)/, async (isUnified: string, styleColourPartNumber: string, key: string) => {
  styleColourPartNumber = services.world.parse(styleColourPartNumber);
  styleColourPartNumber = services.product.parse(styleColourPartNumber);
  const moduleName = 'wishlist';
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName};`));
      return result;
    }, `window.digitalData.${moduleName} is not defined`, 15000,
  );
  const detail = await services.product.productStyle.getDetail(styleColourPartNumber);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  let module;
  isUnified ? module = wishlistModuleSchemaUnified(detail) : module = wishlistModuleSchema(detail);
  validations.push(module.validateAsync({ wishlist: json },
    { abortEarly: false, allowUnknown: true }));
  services.world.store(key, validations);
});

When(/I validate digital data (\d+)(?:st|nd|rd|th|) cart item module of style colour partnumber ([^\s]+) with following data( with allowed unknown attributes)? with report key (#[A-Za-z0-9]+)/, async (index: number, styleColourPartNumber: string, allowUnknownAttribute: string, key: string) => {
  const productPosition = index - 1;
  const moduleName = `cart.item[${productPosition}]`;
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName};`));
      return result;
    }, `window.digitalData.${moduleName} is not defined`, 15000,
  );
  styleColourPartNumber = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName}.productCombiUppercase;`));
      return result;
    }, `window.digitalData.${moduleName}.productCombiUppercase`, 15000,
  );
  GetTestLogger().info(`Digital data Cart module: ${JSON.stringify(json)}`);
  const detail = await services.product.productStyle.getDetail(styleColourPartNumber);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  validations.push(cartItemModuleSchema(detail).validateAsync(json,
    { abortEarly: false, allowUnknown: !!allowUnknownAttribute }));
  services.world.store(key, validations);
});

When(/I validate digital data cart module with following data( with allowed unknown attributes)? with report key (#[A-Za-z0-9]+)/, async (allowUnknownAttribute: string, key: string, data: string) => {
  const moduleName = 'cart';
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName};`));
      return result;
    }, `window.digitalData.${moduleName} is not defined`, 15000,
  );
  GetTestLogger().info(`Digital data Cart module: ${JSON.stringify(json)}`);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  validations.push(cartModuleSchema(JSON.parse(data)).validateAsync({ cart: json },
    { abortEarly: false, allowUnknown: !!allowUnknownAttribute }));
  services.world.store(key, validations);
});

When(/I validate digital data transaction module with following data( with allowed unknown attributes)? with report key (#[A-Za-z0-9]+)/, async (allowUnknownAttribute: string, key: string, data: string) => {
  const moduleName = 'transaction';
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName};`));
      return result;
    }, `window.digitalData.${moduleName} is not defined`, 15000,
  );
  GetTestLogger().info(`Digital data Transaction module: ${JSON.stringify(json)}`);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  validations.push((await transactionModuleSchema(JSON.parse(data), json)).validateAsync(
    { transaction: json },
    { abortEarly: false, allowUnknown: true },
  ));
  services.world.store(key, validations);
});

When(/I validate digital data giftcard module with following data( with allowed unknown attributes)? with report key (#[A-Za-z0-9]+)/, async (allowUnknownAttribute: string, key: string, data: string) => {
  const moduleName = 'giftcard';
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName};`));
      return result;
    }, `window.digitalData.${moduleName} is not defined`, 15000,
  );
  GetTestLogger().info(`Digital data giftcard module: ${JSON.stringify(json)}`);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  validations.push((await giftcardModuleSchema(JSON.parse(data))).validateAsync(
    { giftcard: json },
    { abortEarly: false, allowUnknown: true },
  ));
  services.world.store(key, validations);
});

When(/I validate digital data (\d+)(?:st|nd|rd|th|) transaction item module of style colour partnumber ([^\s]+) with following data( with allowed unknown attributes)? with report key (#[A-Za-z0-9]+)/, async (index: number, styleColourPartNumber: string, allowUnknownAttribute: string, key: string) => {
  const productPosition = index - 1;
  const moduleName = `transaction.item[${productPosition}]`;
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName};`));
      return result;
    }, `window.digitalData.${moduleName} is not defined`, 15000,
  );
  styleColourPartNumber = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName}.productCombi;`)).toString().toUpperCase();
      return result;
    }, `window.digitalData.${moduleName}.productCombiUppercase`, 15000,
  );
  GetTestLogger().info(`Digital data transaction item: ${JSON.stringify(json)}`);
  const detail = await services.product.productStyle.getDetail(styleColourPartNumber);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  validations.push(transactionItemModuleSchema(detail).validateAsync(json,
    { abortEarly: false, allowUnknown: !!allowUnknownAttribute }));
  services.world.store(key, validations);
});

When(/I validate digital data plp (\d+)(?:st|nd|rd|th|) product module of style colour partnumber ([^\s]+) with report key (#[A-Za-z0-9]+)/, async (index: number, styleColourPartNumber: string, key: string) => {
  styleColourPartNumber = services.world.parse(styleColourPartNumber);
  styleColourPartNumber = services.product.parse(styleColourPartNumber);
  const productPosition = index - 1;
  const moduleName = `product[${productPosition}]`;
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName};`));
      return result;
    }, `window.digitalData.${moduleName} is not defined`, 15000,
  );
  GetTestLogger().info(`Digital data Product module: ${JSON.stringify(json)}`);
  const detail = await services.product.productStyle.getDetail(styleColourPartNumber);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  validations.push(plpProductModuleSchema(detail, index)
    .validateAsync(json, { abortEarly: false, allowUnknown: true }));
  services.world.store(key, validations);
});

When(/I validate( unified)? digital data version module with report key (#[A-Za-z0-9]+)/, async (isUnified: string, key: string) => {
  const moduleName = 'version';
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${moduleName};`));
      return result;
    }, `window.digitalData.${moduleName} is not defined`, 15000,
  );
  GetTestLogger().info(`Digital data version module: ${JSON.stringify(json)}`);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  let module;
  isUnified ? module = versionModuleSchemaUnified() : module = versionModuleSchema();
  validations.push(module.validateAsync({ version: json }, { abortEarly: false }));
  services.world.store(key, validations);
});

When(/I validate digitalData.(.*) variable with value "(.*)" with report key (#[A-Za-z0-9]+)/, async (digitalDataKey: string, digitalDataValue: string, key: string) => {
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute(`return window.digitalData.${digitalDataKey};`));
      return result;
    }, `window.digitalData.${digitalDataKey} is not defined`, 15000,
  );
  GetTestLogger().info(`Digital data variable: ${JSON.stringify(json)}`);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  validations.push(variable(digitalDataKey, digitalDataValue)
    .validateAsync({ digitalDataKey: json }, { abortEarly: false }));
  services.world.store(key, validations);
});

When(/I validate digitalData variables pageTitle and destinationURL with report key (#[A-Za-z0-9]+)/, async (key: string) => {
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute('return window.digitalData.page;'));
      return result;
    }, 'window.digitalData.page is not defined', 15000,
  );
  GetTestLogger().info(`Digital data variable: ${JSON.stringify(json)}`);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  validations.push((await pageVariablesSchema())
    .validateAsync({ page: json }, { abortEarly: false, allowUnknown: true }));
  services.world.store(key, validations);
});

When(/I validate digitalData is present with report key (#[A-Za-z0-9]+)/, async (key: string) => {
  const json = await browser.waitUntilResult(
    async () => {
      const result = (await browser.execute('return window.digitalData;'));
      return result;
    }, 'window.digitalData is not defined', 15000,
  );
  GetTestLogger().info(`Digital data object: ${JSON.stringify(json)}`);
  let validations = services.world.parseByType<Array<Promise<any>>>(key);
  if (!validations) {
    validations = new Array<Promise<any>>();
  }
  validations.push((await digitalDataModules())
    .validateAsync({ digitalData: json }, { abortEarly: false }));
  services.world.store(key, validations);
});

Then(/I execute all digital data validation with report key (#[A-Za-z0-9]+)/, async (key: string) => {
  const validations = services.world.parseByType<Array<Promise<any>>>(key);
  const errors = [];
  if (!validations) {
    throw new Error(`No any digital data validation under ${key}`);
  }

  await Promise.all(validations.map((v) => v.catch((e) => errors.push(e))));
  if (errors.length > 0) {
    throw new Error(`Digital Errors:\n ${errors.map((e) => e.message).join(',\n')}`);
  }
});
