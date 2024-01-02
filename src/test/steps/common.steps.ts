/* eslint-disable no-await-in-loop */
import { When, Then } from '@pvhqa/cucumber';
import he from 'he';
import randomstring from 'randomstring';
import { expect } from 'chai';
import services from '../../core/services';
import { GetTestLogger } from '../../core/logger/test.logger';
import { verifyPDPSEOStructuredData, verifyWebSiteSEOStructuredData } from '../helper/seo.helper';
import { getPriceFormat } from '../helper/currency.helper';
import { sleep } from '../helper/utils.helper';
import { exist$ } from '../general';
import { swipeGesture } from '../helper/generic.helpers';
import consoleLog from '../../core/logger/console.logger';
import Payment from '../pages/payments';


When(/I store the value "(.*)" with key (#[A-Za-z0-9]+)/, (value: string, key: string) => {
  services.world.store(key, value);
});

When(/I store translated value of "(.*)" with key (#[A-Za-z0-9]+)/, async (value: string, key: string) => {
  await services.site.extractSiteInfo();
  const siteLanguage = services.site.siteInfo.LOCALENAME.toLowerCase();
  const translatedValue = services.translation.get(siteLanguage, value);
  services.world.store(key, translatedValue);
});

When(/I store current langCode with key (#[A-Za-z0-9]+)/, async (key: string) => {
  await services.site.extractSiteInfo();
  const currentLangCode = `/${services.site.langCode}`;
  services.world.store(key, currentLangCode);
});

When(/I store current site (STORE_ID|LANGUAGE_ID|LOCALENAME|CATALOG_ID|SETCCURR|MAIN_STORE_ID) with key (#[A-Za-z0-9]+)/, (property: string, key: string) => {
  const siteProperty = services.site.siteInfo[property].toString();
  services.world.store(key, siteProperty);
});

When(/I save random string of length (\d+) to key "(#[A-Za-z0-9]+)"/, async (length: string, keyName: string) => {
  const randomString = `${randomstring.generate(parseInt(length, 10) - 1)}1`;
  services.world.store(keyName, randomString);
});

When(/I (enable|disable) page strategy ([^\s]+)/, async (actionType: string, strategyName: string) => {
  if (actionType === 'disable') {
    services.pageObjectStragety.disableStrategy(strategyName);
  } else {
    services.pageObjectStragety.enableStrategy(strategyName);
  }
});

When(/in js extract (.*) save to (#[A-Za-z0-9]+)/, async (jsCode: string, key: string) => {
  const r = await browser.waitUntilResult(async () => {
    const result = await browser.execute(`return ${jsCode}`);
    return result;
  });
  GetTestLogger().info(`Extract js ${jsCode}, value is ${r}`);
  services.world.store(key, r);
});

Then(/key (.*) is not saved in sessionStorage/, async (key: string) => {
  expect(await browser.execute(`return window.sessionStorage.getItem(${key})`)).to.be.null;
});

When(/I combine value "(.*)" with the stored value (#[A-Za-z0-9]+)/, async (firstValue: string, key: string) => {
  let r = (services.world.parse(key)).toString();
  r = firstValue + r;
  GetTestLogger().info(`First part of the value is ${firstValue}, new combined value is ${r}`);
  services.world.store(key, r);
});

When(/in DB I extract the shipping promo threshold save to (#[A-Za-z0-9]+)(?: with default threshold (\d+))?/, async (key: string, defaltThreshold?: number) => {
  let threshold = await services.othersDB.GetShippingPromoThreshold();
  if (threshold <= 1) {
    threshold = defaltThreshold > 0 ? defaltThreshold : 1;
  }
  services.world.store(key, threshold);
});

When(/In DB I update the last access time by reducing it by (.*) day for (#[A-Za-z0-9]+) in CTXMGMT table/, async (numberOfDays: number, key: string) => {
  const callerId = (services.world.parse(key)).toString().toLowerCase();
  const beforeUpate = await services.othersDB.GetCtxMgmt(callerId);
  await services.othersDB.UpdateCtxMgmtByDays(callerId, numberOfDays);
  const afterUpdate = await services.othersDB.GetCtxMgmt(callerId);
  if (beforeUpate[0].LASTACCESSTIME > afterUpdate[0].LASTACCESSTIME) {
    GetTestLogger().info(`successfully updated the last access time  from ${beforeUpate[0].LASTACCESSTIME} to ${afterUpdate[0].LASTACCESSTIME}`);
  } else { throw new Error(`the last access time is not updated properly: actual ${afterUpdate[0].LASTACCESSTIME}`); }
});

When(/In DB I update the status to '(.*)' for (#[A-Za-z0-9]+) in CTXMGMT table/, async (status: string, key: string) => {
  const callerId = (services.world.parse(key)).toString().toLowerCase();
  const beforeUpate = await services.othersDB.GetCtxMgmt(callerId);
  await services.othersDB.UpdateStatusCtxMgmt(callerId, status);
  const afterUpdate = await services.othersDB.GetCtxMgmt(callerId);
  if (afterUpdate[0].STATUS === status) {
    GetTestLogger().info(`successfully updated the status from ${beforeUpate[0].STATUS} to ${afterUpdate[0].STATUS}`);
  } else { throw new Error(`the status is not updated properly: actual ${afterUpdate[0].STATUS}`); }
});

When(/In DB there should be (.*) entry for (#[A-Za-z0-9]+) in CTXMGMT table/, async (number: string, key: string) => {
  const callerId = (services.world.parse(key)).toString().toLowerCase();
  const result = await services.othersDB.GetCtxMgmt(callerId);
  if (result.length === parseInt(number, 10)) {
    GetTestLogger().info(`${number} entry found in CTXMGMT: ${callerId}`);
  } else { throw new Error(`expected number of entries ${number} doesnt match for callerID ${callerId} with result ${result.length}`); }
});

When(/In DB I delete the entry for (#[A-Za-z0-9]+) in CTXMGMT table/, async (key: string) => {
  const callerId = (services.world.parse(key)).toString().toLowerCase();
  await services.othersDB.DeleteCtxMgmt(callerId);
});

When(/I (add|subtract) ([^\s]+) (?:to|from) numeric store value (#[A-Za-z0-9]+) save to (#[A-Za-z0-9]+)/, async (op: string, addValue: string, keyToRetrieve: string, keyToStore: string) => {
  const value = services.world.parse(keyToRetrieve);
  addValue = (addValue.replace(/[^0-9.,]/g, '').replace(',', '.'));
  addValue = addValue.match(/\d+\.\d{3}(?:\.\d{2})?/)
    ? addValue.slice(0, addValue.indexOf('.')) + addValue.slice(addValue.indexOf('.') + 1)
    : addValue;
  const addValueNum = Math.round(Number(addValue) * 100) / 100;
  if (op === 'add') {
    services.world.store(keyToStore, Number(value) + addValueNum);
  } else {
    services.world.store(keyToStore, Number(value) - addValueNum);
  }
});

When(/I (add|subtract) (#[A-Za-z0-9]+) (?:to|from) (#[A-Za-z0-9]+) and save to (#[A-Za-z0-9]+)/, async (op: string, key1: string, key2: string, keyToStore: string) => {
  const value1 = services.world.parse(key1);
  const value2 = services.world.parse(key2);
  if (op === 'add') {
    services.world.store(keyToStore, Number(value1) + Number(value2));
  } else {
    services.world.store(keyToStore, Number(value2) - Number(value1));
  }
});

When(/I (multiply|divide) (#[A-Za-z0-9]+) by ([^\s]+) and save to (#[A-Za-z0-9]+)/, async (op: string, key1: string, key2: string, keyToStore: string) => {
  const value1 = services.world.parse(key1);
  const value2 = key2.startsWith('#') ? services.world.parse(key2) : key2;
  if (op === 'multiply') {
    services.world.store(keyToStore, Number(value1) * Number(value2));
  } else {
    services.world.store(keyToStore, Number(value1) / Number(value2));
  }
});

When(/I tap on the screen with coordinates x (\d+) and y (\d+)/, async (xCoord: number, yCoord: number) => {
  await browser.safeTouch(xCoord, yCoord);
});

When(/I get translation for "([^\s]+)" and store it with key (#[^\s]+)/, async (valueToTranslate: string, keyToStore: string) => {
  let translatedValue;
  if (process.env.Site === 'localhost') {
    translatedValue = services.translation.get(
      'en_gb', valueToTranslate,
    );
  } else {
    translatedValue = services.translation.get(
      services.site.siteInfo.LOCALENAME.toLowerCase(), valueToTranslate,
    );
  }

  services.world.store(keyToStore, translatedValue);
});

When(/I get translation from lokalise for "([^\s]+)" and store it with key (#[^\s]+)/, async (valueToTranslate: string, keyToStore: string) => {
  let translatedValue;
  if (process.env.Site === 'localhost') {
    translatedValue = await services.translationLokalise.getTranslation(valueToTranslate, 'en_gb');
  } else {
    translatedValue = await services.translationLokalise.getTranslation(
      valueToTranslate, services.site.siteInfo.LOCALENAME.toLowerCase(),
    );
    if (translatedValue.endsWith('{{0}}')) {
      translatedValue = translatedValue.replace('{{0}}', '');
    }
  }

  const translationWithoutSpace = translatedValue.replace(/&nbsp;/g, ' ');
  services.world.store(keyToStore, translationWithoutSpace);
});

When(/I add text "([^\s]+)" to placeholder in text "([^\s]+)" and store it with key (#[^\s]+)/, async (variableText: string, placeHolderText: string, keyToStore: string) => {
  let finalText;
  variableText = services.world.parse(variableText);
  placeHolderText = services.world.parse(placeHolderText);

  if (placeHolderText.includes('{{0}}')) {
    finalText = placeHolderText.replace('{{0}}', variableText);
  }

  const translationWithoutSpace = finalText.replace(/&nbsp;/g, ' ');
  services.world.store(keyToStore, translationWithoutSpace);
});

When(/I get (price format|currency code) for current locale and store it with key (#[^\s]+)/, async (attributeToFetch: string | RegExp, keyToStore: string) => {
  attributeToFetch = attributeToFetch === 'price format'
    ? getPriceFormat(services.site.locale)
    : services.site.siteInfo.SETCCURR;
  services.world.store(keyToStore, attributeToFetch);
});

Then(/I see the stored value with key (#[A-Za-z0-9]+) is( not)? equal to "(.*)"/, async (key: string, notEqual: string, expectedValue: string) => {
  const actualValue = (services.world.parse(key)).toString();
  expectedValue = services.world.parse(expectedValue);
  expect((actualValue === expectedValue) === !notEqual,
    `Stored value with the key should${notEqual || ''} be equal to "${expectedValue}", actual value was: "${actualValue}"`)
    .to.be.true;
});

Then(/I see the stored value with key (#[A-Za-z0-9]+) should( not)? contain "(.*)"/, async (key: string, notContains: string, expectedValue: string) => {
  if (expectedValue) {
    expectedValue = services.world.parse(expectedValue).toString();
    expectedValue = services.product.parse(expectedValue).toString();
  }
  const actualValue = (services.world.parse(key)).toString();
  expect((actualValue.toLowerCase().includes(expectedValue.toLowerCase())) === !notContains,
    `Stored value with the key should${notContains || ''} contain "${expectedValue}", actual value was: "${actualValue}"`)
    .to.be.true;
});

Then(/I see the (stringified|encoded|decoded) value with key (#[A-Za-z0-9]+) should( not)? contain "(.*)"/, async (typeOfValue: string, key: string, notContains: string, expectedValue: string) => {
  if (expectedValue) {
    expectedValue = services.world.parse(expectedValue).toString();
    expectedValue = services.product.parse(expectedValue).toString();
  }

  let actualValue = services.world.parse(key);

  if (typeOfValue.trim().includes('encoded')) {
    expectedValue = encodeURIComponent(expectedValue);
    actualValue = encodeURIComponent(actualValue);
  } else if (typeOfValue.trim().includes('decoded')) {
    expectedValue = decodeURIComponent(expectedValue);
    actualValue = decodeURIComponent(actualValue);
  } else if (typeOfValue.trim().includes('stringified')) {
    expectedValue = JSON.stringify(expectedValue);
    actualValue = JSON.stringify(actualValue);
  } else {
    throw new Error(`Valid values for typeOfValue is encoded / decoded / stringified. typeOfValue value is :${typeOfValue}`);
  }

  expect((actualValue.toLowerCase().includes(expectedValue.toLowerCase())) === !notContains,
    `Stored value with the key should${notContains || ''} contain "${expectedValue}", actual value was: "${actualValue}"`)
    .to.be.true;
});

Then(/I see the stored value with key (#[A-Za-z0-9]+) is( not)? less or equal than the stored value with key (#[A-Za-z0-9]+)/, async (keyActual: string, notLess: string, keyExpected: string) => {
  const actualValue = (services.world.parse(keyActual)).toString();
  const expectedValue = (services.world.parse(keyExpected)).toString();
  expect((actualValue <= expectedValue) === !notLess,
    `Stored value with the key should${notLess || ''} be less than "${expectedValue}", actual value was: "${actualValue}"`)
    .to.be.true;
});

Then(/the PDP structured data of style colour part number ([^\s]+) is correct/, async (styleColourPartNumber: string) => {
  styleColourPartNumber = services.world.parse(styleColourPartNumber);
  styleColourPartNumber = services.product.parse(styleColourPartNumber);
  const seoUrl = await services.product.productStyle.GetSEOUrl(
    styleColourPartNumber, services.site.siteInfo.LOCALENAME,
  );
  const pdpUrl = `${services.site.baseUrl}/${seoUrl}`;
  GetTestLogger().info(`Fetch pdp html: ${pdpUrl}`);
  await verifyPDPSEOStructuredData(pdpUrl, styleColourPartNumber);
});

Then(/the WebSite structured data for url ([^\s]+) is correct/, async (url: string) => {
  url = `${services.site.baseUrl}/${url}`;
  GetTestLogger().info(`Fetch page html: ${url}`);
  await verifyWebSiteSEOStructuredData(url);
});

When(/I store all values with property (.*) nested in (.*) and saved as (#[A-Za-z0-9]+) to array saved as (#[A-Za-z0-9]+)/, async (propertyName: string, nestedPropertyName: string, originalKey: string, newKey: string) => {
  const value = JSON.parse(services.world.parse(originalKey));
  const myArr: Array<string> = [];
  let i: number = 0;
  value[nestedPropertyName].forEach((type) => {
    myArr[i] = type[propertyName];
    i += 1;
  });
  GetTestLogger().info(`Stored information for ${newKey}: ${myArr.toString()}`);
  if (myArr.length === null || !myArr) {
    throw new Error(`No information was stored for json in ${originalKey} with property ${propertyName}`);
  }
  services.world.store(newKey, myArr);
});

Then(/I store index (\d+) from array saved as (#[A-Za-z0-9]+) as (#[A-Za-z0-9]+)/, async (index: number, arrayKey: string, key: string) => {
  const arrayTemp = services.world.parse(arrayKey);
  services.world.store(key, arrayTemp[index]);
});

Then(/I see the stored value with key (#[A-Za-z0-9]+) is( not)? equal to value in uppercase for "(.*)"/, async (key: string, notEqual: string, expectedValue: string) => {
  const actualValue = (services.world.parse(key)).toString();
  expectedValue = services.world.parse(expectedValue);
  expect((actualValue.toLocaleUpperCase() === expectedValue.toLocaleUpperCase()) === !notEqual,
    `Stored value with the key should${notEqual || ''} be equal to "${expectedValue}", actual value was: "${actualValue}"`)
    .to.be.true;
});

When(/I mix uppercase and lowercase of csr L1 account and store it with key (#[A-Za-z0-9]+)/, (key: string) => {
  const email = services.csraccount.getCsrUser('L1_6', services.env.Brand, services.env.DatabaseName);
  let newValue = '';

  services.world.store('#csrL1Email', email);

  // eslint-disable-next-line no-plusplus
  for (let i = 0; i < email.length; i++) {
    if (Math.random() > 0.5) {
      newValue += email.charAt(i).toUpperCase();
    } else {
      newValue += email.charAt(i).toLowerCase();
    }
  }
  services.world.store(key, newValue);
});

/**
 * This step is to simulate mobile swipe gesture
 * On carousel product images either left/right directions
 * It can be used using slider-active or slider-next locators
 * swipeGesture method parameters : element to swipe left/right , direction , x coordinates
 */
When(/I swipe to (left|right) direction on element ([^\s]+)(?: with (?:args|value|text|index|href|data-testid) (.*))?/, async (swipeDirection: string, elementPath: string, args: string) => {
  const selector = await services.pageObject.getSelector(elementPath, args ? args.split('##') : null);
  const elementToSwipe = await exist$(selector);
  if (browser.capabilities.platformName === 'iOS') {
    await browser.execute('mobile:swipe', {
      elementId: await (await elementToSwipe).elementId,
      direction: swipeDirection,
    });
  } else {
    await swipeGesture(elementToSwipe, swipeDirection, 100);
  }
  await sleep(3000);
});

/**
 * This step is to simulate multiple mobile swipe gestures
 * On carousel product images either left/right directions
 * It can be used using slider-active or slider-next locators
 * swipeGesture method parameters : element to swipe left/right , direction , x coordinates
 */
When(/I swipe (.*) times to (left|right) direction on element ([^\s]+)(?: with (?:args|value|text|index|href|data-testid) (.*))?/, async (
  gestureTotal: number, swipeDirection: string, elementPath: string, args: string) => {
  const selector = await services.pageObject.getSelector(elementPath, args ? args.split('##') : null);
  const elementToSwipe = await exist$(selector);
  if (browser.capabilities.platformName === 'iOS') {
    await browser.execute('mobile:swipe', {
      elementId: await (await elementToSwipe).elementId,
      direction: swipeDirection,
    });
  } else {
    for (let j = 0; j < (gestureTotal - 1); j += 1) {
      await swipeGesture(elementToSwipe, swipeDirection, 100);
      await sleep(3000);
    }
  }
});

When(/I store SEO title and save it as (#[A-Za-z0-9]+)/, async (keyToStore: string) => {
  let valueToStore = await browser.waitUntilResult(async () => {
    const result = await browser.execute('return window.__NEXT_DATA__.props.initialState.seoData.data.metadata.title');
    return result;
  }, 'SEO Data title does not exist', services.env.DriverConfig.timeout.pageLoad);
  valueToStore = he.decode(valueToStore);
  services.world.store(keyToStore, valueToStore);
});

When(/I get the media resource (presetSize|width|height|naturalHeight|naturalWidth) on element ([^\s]+)(?: with (?:args|value|text|indexhref|data-testid) (.*))? and save it as (#[A-Za-z0-9]+)/, async (mediaVariable: string, elementPath: string, args: string, keyToStore: string) => {
  let result: any;
  let selector: any;
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
    selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  } else {
    selector = await services.pageObject.getSelector(elementPath);
  }
  const r = await browser.waitUntilResult(async () => {
    if (mediaVariable === 'presetSize') {
      const srcUrl = await browser.execute(`return document.querySelector('${selector}').currentSrc`) as string;
      const presetSize = srcUrl.split(/['plp_max_'@]/);
      result = presetSize;
    } else if (mediaVariable === 'width') {
      result = await browser.execute(`return document.querySelector('${selector}').clientWidth`);
    } else if (mediaVariable === 'height') {
      result = await browser.execute(`return document.querySelector('${selector}').clientHeight`);
    } else if (mediaVariable === 'naturalHeight') {
      result = await browser.execute(`return document.querySelector('${selector}').naturalHeight`);
    } if (mediaVariable === 'naturalWidth') {
      result = await browser.execute(`return document.querySelector('${selector}').naturalWidth`);
    }
    return result;
  });
  GetTestLogger().info(`Extracted media current source of element ${selector}, value is ${r}`);
  services.world.store(keyToStore, r);
});

When(/I get the (text|selected option) on element ([^\s]+)(?: with (?:args|value|text|index|indexhref|data-testid) (.*))? via js and save it as (#[A-Za-z0-9]+)/, async (getTextType: string, elementPath: string, args: string, keyToStore: string) => {
  let result: any;
  let selector: any;
  let getTextValue : string;
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
    selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  } else {
    selector = await services.pageObject.getSelector(elementPath);
  }
  if (getTextType === 'text') {
    getTextValue = await (await exist$(selector)).getText();
    GetTestLogger().info(` getText of element ${selector}, value is stored : ${getTextValue}`);
  } else {
    getTextValue = await browser.waitUntilResult(async () => {
      result = await browser.execute(`return document.querySelector('${selector}').selectedIndex`);
      return result;
    });
    GetTestLogger().info(`Extracted selected options of element ${selector}, value is ${getTextValue}`);
  }
  services.world.store(keyToStore, getTextValue);
});

// eslint-disable-next-line max-len
// This step call's the email validation service methods where pvh.nl.automation@outlook.com account is configured
// eslint-disable-next-line max-len
// along with api permission enabled to access the microsoft graph rest api services to fetch the email based on subject query
// as of now this step can be used to verify order or news-letter confirmation emails.
When(/I verify (order|newsletter|password reset) confirmation email with subject as (.*) from outlook/, async (options: string, valueToSearch: string) => {
  let expectedEmailSubject = null;
  if (options === 'order') {
    const oderNumber = (services.world.parse('#cartId')).toString();
    expectedEmailSubject = `${valueToSearch}${oderNumber}`;
  } else {
    expectedEmailSubject = `${valueToSearch}`;
  }
  await sleep(5000);
  for (let i = 0; i <= 2; i += 1) {
    const response = await services.emailMsOutlook.getSubjectOutlook(expectedEmailSubject.replace(/[&\\/\\#,+()$~%.'":*?<>{}]/gi, ''));
    if (response.body.value.length > 0) {
      const actualEmailSubjectValue = response.body.value[0].subject;
      expect(actualEmailSubjectValue).to.equals(expectedEmailSubject,
        `expected email subject ${expectedEmailSubject} should contain ${valueToSearch}. Actual was: ${actualEmailSubjectValue}`);
      // eslint-disable-next-line no-empty
      if (options === 'order') {
        const emailBodyContent = response.body.value[0].body.content.replace(/[&\\/\\#,+()$~%.'":*?<>{}]/gi, '');
        expect(emailBodyContent).includes('First Name Email',
          'expected first name as : First Name Email is not contains in Actual Email Body Content');
        expect(emailBodyContent).includes('Last Name Email',
          'expected last name as : Last Name Email is not contains in Actual Email Body Content');
        expect(emailBodyContent).includes('Address Email',
          'expected address as : Address Email is not contains in Actual Email Body Content');
        expect(emailBodyContent).includes('POST NL',
          'expected delivery type as : POST NL is not contains in Actual Email Body Content');
        expect(emailBodyContent).includes('PayPal',
          'expected payment mode as : PayPal is not contain in Actual Email Body Content');
      }
      break;
    } else {
      consoleLog(`Number of attaempts : ${i} to verify email using subject as ${expectedEmailSubject}`);
    }
  }
});

When(/I fetch an gift-card number and pin from email (.*) using gift-card order as (.*) to redeem it/, async (giftCardEmailSubject: string, giftCardOrderNumber: string) => {
  const orderNumber = services.world.parse(giftCardOrderNumber);
  consoleLog(giftCardOrderNumber);
  // const orderNumber = '900001872578';
  const expectedEmailSubject = `${giftCardEmailSubject} ${orderNumber}`;
  await sleep(290000);
  // await sleep(2900);
  let giftCardNumber = null;
  let pin = null;
  for (let i = 0; i <= 2; i += 1) {
    const response = await services.emailMsOutlook.getSubjectOutlook(expectedEmailSubject.replace(/[&\\/\\#,+()$~%.'":*?<>{}]/gi, ''));
    if (response.body.value.length > 0) {
      const gcDetails = response.body.value[0].body.content.replace(/<[^>]+>/g, '');
      giftCardNumber = gcDetails.split('E-Geschenkgutschein-Nummer')[1].substring(1, 22);
      pin = gcDetails.split('PIN')[1].substring(1, 7);
      // store the giftCard number and pin info
      services.world.store('#giftCardNumber', giftCardNumber);
      services.world.store('#giftCardPIN', pin);
      GetTestLogger().info(`The giftCardNumber is: ${giftCardNumber}`);
      GetTestLogger().info(`The pin is: ${pin}`);
      await Payment.GiftCard.fillInGiftCardByNumberPin(giftCardNumber, pin);
      break;
    } else if (i === 2) {
      throw new Error('No mail received with given subject');
    } else {
      consoleLog(`Number of attaempts : ${i} to verify email using subject as ${expectedEmailSubject}`);
    }
    if (giftCardNumber) {
      break;
    }
  }
});
