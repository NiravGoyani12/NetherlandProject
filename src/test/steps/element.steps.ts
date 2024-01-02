/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable no-redeclare */
/* eslint-disable no-await-in-loop */
import { When, Then, TableDefinition } from '@pvhqa/cucumber';
import randomstring from 'randomstring';
import { env } from 'process';
import {
  exist$, maybeDisplayed$, maybeExist$, maybeDisplayed$$, maybeExist$$,
} from '../general';
import services from '../../core/services';
import { DropdownSelector } from '../../core/constents';
import { GetTestLogger } from '../../core/logger/test.logger';
import { stepPressKeyOnKeyboard } from './browser.steps';

When(/I( scroll to and)? click on ([^\s]+)( by js)?(?: with (?:args|value|text|index|href|data-testid) ([^\s]+))?(?: until (.*) is displayed)?(?: in (\d+) seconds?)?( if displayed)?/, async (enableScroll: string, elementPath: string, byJs: string, args: string, displayedElementPath: string, timeoutInSec?: number, ifDisplayed?: string) => {
  let selector;
  if (args && args.includes('#itemIndex')) {
    args = services.world.parse(args);
    selector = await services.pageObject.getSelector(elementPath, [args]);
  } else if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  if (!selector) {
    selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  }

  const timeout = timeoutInSec ? timeoutInSec * 1000 : null;
  const element = ifDisplayed
    ? await maybeDisplayed$(selector, timeout)
    : await exist$(selector, timeout);
  if (element) {
    if (enableScroll) {
      await element.scrollIntoView({
        behavior: 'smooth',
        block: 'center',
      });
    }
    if (byJs) {
      await element.jsClick();
    } else if (displayedElementPath) {
      await element.safeClickRetry(displayedElementPath);
    } else {
      await element.safeClick();
    }
  }
});

When(/I( scroll in mobile view and)? click on to ([^\s]+)( by js)?(?: with (?:args|value|text|index|href|data-testid) ([^\s]+))?(?: until (.*) is displayed)?(?: in (\d+) seconds?)?( if displayed)?/, async (enableScroll: string, elementPath: string, byJs: string, args: string, displayedElementPath: string, timeoutInSec?: number, ifDisplayed?: string) => {
  let selector;
  if (args && args.includes('#itemIndex')) {
    args = services.world.parse(args);
    selector = await services.pageObject.getSelector(elementPath, [args]);
  } else if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  if (!selector) {
    selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  }

  const timeout = timeoutInSec ? timeoutInSec * 1000 : null;
  const element = ifDisplayed
    ? await maybeDisplayed$(selector, timeout)
    : await exist$(selector, timeout);
  if (element && services.env.IsMobile === true) {
    if (enableScroll) {
      await element.scrollIntoView({
        behavior: 'smooth',
        block: 'center',
      });
      await element.jsClick();
    }
  } else if (services.env.IsMobile === false) {
    if (byJs) {
      await element.jsClick();
    } else if (displayedElementPath) {
      await element.safeClickRetry(displayedElementPath);
    } else {
      await element.safeClick();
    }
  }
});

When(/in dropdown ([^\s]+)(?: with (?:args|value|text|index) (.*))? I select the option( by js| by simple click|)? by (?:value|text|index|data-qa) "(.*)"( if displayed)?/, async (elementPath: string, args: string, byClickOption: string, value: string, ifDisplayedCheck: string) => {
  value = services.world.parse(value);
  const countryInfo = services.checkoutaddress.getCountryDetails(services.site.locale);
  if (value === '#POSTCODE') {
    value = countryInfo.postcode;
  }
  if (value === '#NEWPOSTCODE') {
    value = countryInfo.newpostcode;
  }
  if (value === '#PHONE') {
    value = countryInfo.phone;
  }
  if (value === '#STATE') {
    value = countryInfo.province;
  }
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  const locatorParms = args ? [...args.split('##'), value] : [value];
  const dropdown = await services.pageObject.getSelector(
    elementPath, locatorParms,
  ) as DropdownSelector;
  const element = ifDisplayedCheck
    ? await maybeDisplayed$(dropdown.dropdownSelector)
    : await exist$(dropdown.dropdownSelector);
  if (element) {
    await element.selectDropdown(dropdown.optionSelector, byClickOption && byClickOption.indexOf('js') >= 0, byClickOption && byClickOption.indexOf('simple click') >= 0);
  }
});

When(/I set the checkbox ([^\s]+)(?: with (?:args|value|text|index|data-testid) (.*))? status to (true|false)( if exist)?/, async (elementPath: string, args: string, isChecked: string, ifExistCheck: string) => {
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  const selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  const element = ifExistCheck ? await maybeExist$(selector) : await exist$(selector);
  if (element) {
    await element.setCheckbox(isChecked === 'true');
  }
});

When(/I enter CSR L4 password in the field ([^\s]+)/, async (elementPath: string) => {
  const account = `L4_${services.world.parse('#acountNumber')}`;
  // eslint-disable-next-line max-len
  const password = services.csraccount.getCsrPassword(account, services.env.Brand, services.env.DatabaseName);
  const selector = await services.pageObject.getSelector(elementPath);
  const element = await exist$(selector);
  await element.safeType(password);
});

When(/I type "(.*)" in the( empty)? field ([^\s]+)(?: with (?:args|value|text|index|href|data-testid)(.*))?( if displayed)?/, async (textOrKey: string, needToClear: string, elementPath: string, args: string, ifDisplayedCheck: string) => {
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  let text = services.world.parse(textOrKey);
  text = services.account.parse(text);
  if (text === '#POSTCODE') {
    const countryInfo = services.checkoutaddress.getCountryDetails(services.site.locale);
    text = countryInfo.postcode;
  }
  if (text === '#RANDOM') {
    services.account.provideFakeAccount(1);
    text = services.account.parse('user2#email');
  }
  const selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  const element = ifDisplayedCheck ? await maybeDisplayed$(selector) : await exist$(selector);
  if (element) {
    if (needToClear) {
      await element.clearValue();
      await element.safeType(text, true);
    } else {
      await element.safeType(text, false);
    }
  }
});

/**
 * Table definition
 *  | element | value |
 */
When(/I type to following( empty)? inputs/, async (emptyField: string, table: TableDefinition) => {
  const commands: Array<Promise<any>> = [];
  for (let row = 0; row < table.rows().length; row += 1) {
    const selectorPath = table.rows()[row][0];
    let text = table.rows()[row][1];
    text = services.account.parse(text);
    const countryInfo = services.checkoutaddress.getCountryDetails(services.site.locale);
    if (text === '#POSTCODE') {
      text = countryInfo.postcode;
    }
    if (text === '#NEWPOSTCODE') {
      text = countryInfo.newpostcode;
    }
    if (text === '#PHONE') {
      text = countryInfo.phone;
    }
    if (text === '#STATE') {
      text = countryInfo.province;
    }
    if (text && text.trim().length > 0) {
      commands.push(new Promise((resolve, rejects) => {
        exist$(selectorPath).then((ele) => {
          ele.safeType(text, !!emptyField).then(resolve, rejects);
        }, rejects);
      }));
    }
  }
  await Promise.all(commands);
});

When(/I type random string with length (\d+) in the field ([^\s]+)/, async (length: string, elementPath: string) => {
  const randomText = randomstring.generate(parseInt(length, 10));
  if (randomText) {
    const selector = await services.pageObject.getSelector(elementPath);
    const element = await maybeDisplayed$(selector);
    await element.safeType(randomText, true);
  }
});

When(/I hover over ([^\s]+)(?: with (?:args|value|text|index|href|data-testid) (.*))?/, async (elementPath: string, args: string) => {
  if (services.env.IsDesktop) {
    if (args) {
      args = services.world.parse(args);
      args = services.product.parse(args);
    }
    const selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
    const ele = await exist$(selector);
    await ele.hover();
  }
});

When(/I store the(( numeric| wholePart)(.*))? value of(?: attribute ([^\s]+) of element)? ([^\s]+)(?: with (?:args|value|text|index) (.*))? with key (#[A-Za-z0-9]+)( if displayed)?/, async (
  isNumeric: string, attribute: string, element: string,
  args: string, key: string, ifDisplayedCheck: string) => {
  if (args) {
    if (args.includes('#')) {
      args = services.world.parse(args);
      element = await services.pageObject.getSelector(element, [args]) as string;
    } else {
      args = services.world.parse(args);
      args = services.product.parse(args);
      element = await services.pageObject.getSelector(element, args.split(',')) as string;
    }
  }

  let valueToStore: string;
  let storeLocatorCase: boolean;
  if (element.includes('#')) {
    valueToStore = services.world.parse(element);
    valueToStore = services.product.parse(element);
  } else {
    if (!attribute) {
      const ele = ifDisplayedCheck ? await maybeDisplayed$(element) : await exist$(element);
      if (ele) {
        const textList = await Promise.all([ele.getText(), ele.getTextByJs()]);
        const text = textList[0] || textList[1];
        valueToStore = text.toString();
      } else {
        valueToStore = '0';
      }
    } else if (ifDisplayedCheck) {
      valueToStore = (await (await maybeDisplayed$(element)).getAttribute(attribute)).toString();
      valueToStore = valueToStore || '0';
    } else {
      valueToStore = (await (await exist$(element)).getAttribute(attribute)).toString();
    }
    if (isNumeric === ' numeric') {
      // This is a workaround for the store locator
      // In the future a nicer solutions needs to be found
      if (valueToStore.indexOf('W1B 5SG') > 0) {
        storeLocatorCase = true;
      }
      valueToStore = valueToStore.replace(/[^0-9.,]/g, '').replace(',', '.'); // leave only digits and .,
      valueToStore = valueToStore.replace(/\D+$/g, ''); // remove all characters after last digit - can be .,

      // if the value is in the format nn.nnn.nn (e.g. 2.500.00) then it will keep nnnn.nn (2500.00)
      if (valueToStore.match(/\d+.\d{3}\.\d{2}?/)) {
        valueToStore = valueToStore.slice(0, valueToStore.indexOf('.')) + valueToStore.slice(valueToStore.indexOf('.') + 1);
      }
      // Part of the store locator workaround
      if (storeLocatorCase) {
        valueToStore = valueToStore.slice(0, 2);
      }
    }
    if (isNumeric === ' wholePart') {
      valueToStore = valueToStore.replace(/[^0-9.,]/g, '').replace(',', '.');
      valueToStore = valueToStore.replace(/(\.[0-9]*?)0+/g, ''); // leave all digits after .
    }
  }
  services.world.store(key, valueToStore);
  GetTestLogger().info(`VALUE for KEY ${key} is `, valueToStore);
});

When(/I see the length of key (#[A-Za-z0-9]+) is equal to ([^\s]+)/, async (key: string, value: string) => {
  const actualText = (services.world.parse(key)).toString();
  const actualLength = (services.world.parse(key)).toString().length;
  const expectedValue = Number(services.world.parse(value));

  if (!actualText) {
    throw new Error('The string you are looking for is undefined');
  } else if (actualLength !== expectedValue) {
    throw new Error(`The text '${actualText}' has a length of ${actualLength} different from ${expectedValue}`);
  } else {
    return true;
  }
});

When(/I store the values of all elements ([^\s]+) with key (#[A-Za-z0-9]+)/, async (elementPath: string, key: string) => {
  const elements = await maybeExist$$(elementPath);
  const valuesToStore = [];
  let i = 0;
  while (i < elements.length) {
    const textList = await Promise.all([elements[i].getText(), elements[i].getTextByJs()]);
    const text = textList[0] || textList[1];
    valuesToStore.push(text.toString());
    i += 1;
  }
  services.world.store(key, valuesToStore);
  GetTestLogger().info(`VALUE for KEY ${key} is `, valuesToStore);
});

When(/I store the number of( displayed)? elements ([^\s]+)(?: with (?:args|value|text|index) (.*))? with key (#[A-Za-z0-9]+)/, async (isDisplayed: string, elementPath: string, args: string, key: string) => {
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  const selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  const elementCount = isDisplayed
    ? (await maybeDisplayed$$(selector)).length
    : (await maybeExist$$(selector)).length;
  services.world.store(key, elementCount);
  GetTestLogger().info(`VALUE for KEY ${key} is `, elementCount);
});

When(/I( smoothly)? scroll to the element ([^\s]+)(?: with (?:args|value|text|index|href|data-testid) (.*))?(?: aligned by (start|end|center))?/, async (smoothScroll: string, elementPath: string, args: string, scrollAlignment: string) => {
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  const selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  const element = await exist$(selector);
  const behavior = smoothScroll ? 'smooth' : 'auto';
  const block = scrollAlignment || 'center';
  await element.scrollIntoView({
    behavior,
    block,
  });
});

When(/I switch to (iframe |default content)([^\s]+)?/, async (iframe: string, elementPath: string) => {
  if (iframe === 'iframe ') {
    const ele = await exist$(elementPath);
    await browser.switchToFrame(ele);
  } else {
    await browser.switchToFrame(null);
  }
});

When(/I set attribute ([^\s]+) of element ([^\s]+) to "([^\s]+)"/, async (attributeName: string, elementPath: string, attributeValue: string) => {
  const ele = await exist$(elementPath);
  await ele.setAttribute(attributeName, attributeValue);
});

/**
 * Function to clean up using backspaces like a user.
 * To use (in CK) when text field keeps value in the internal react storage
 * and function with js clear doesn't work.
 * Text attribute to detect current lenght is read from value field
 */
When(/I clear text field of element ([^\s]+)/, async (elementPath: string) => {
  const selector = await services.pageObject.getSelector(elementPath);
  const ele = await maybeDisplayed$(selector);
  // move focus to element first
  if (services.env.IsMobile) {
    await ele.scrollIntoView();
  }
  await ele.safeClick();
  // get text of an element to understand how many times need to click
  const text = await ele.getAttribute('value');
  for (let i = 0; i < text.length; i += 1) {
    await stepPressKeyOnKeyboard('Backspace');
  }
});

When(/I navigate to end of string and then clear text field of element ([^\s]+)/, async (elementPath: string) => {
  const selector = await services.pageObject.getSelector(elementPath);
  const ele = await maybeDisplayed$(selector);
  // move focus to element first
  if (services.env.IsMobile) {
    await ele.scrollIntoView();
  }
  await ele.safeClick();
  // get text of an element to understand how many times need to click
  await ele.getText();
  await stepPressKeyOnKeyboard('End');
  const text = await ele.getAttribute('value');
  for (let i = 0; i < text.length; i += 1) {
    await stepPressKeyOnKeyboard('Backspace');
  }
});

When(/I click all elements for ([^\s]+)( by js)?/, async (elementPath: string, byJs: string) => {
  const selector = await services.pageObject.getSelector(elementPath);
  const element = await maybeExist$$(selector);
  for (let i = 0; i < element.length; i += 1) {
    if (element[i]) {
      if (byJs) {
        await element[i].jsClick();
      } else {
        await element[i].safeClick();
      }
    }
  }
});

Then(/I (?:see|wait until) element ([^\s]+) is( not)? active(?: in (\d+) seconds)?/, async (elementPath: string, elementNotActive: string, timeoutInSeconds: number) => {
  const timeout = timeoutInSeconds
    ? timeoutInSeconds * 1000
    : services.env.DriverConfig.timeout.elementDisplayed;
  const elementActive = !elementNotActive;
  await browser.waitUntil(
    async () => {
      const ele = await maybeDisplayed$(elementPath, timeout);
      return elementActive === !!ele;
    },
    {
      timeout,
      timeoutMsg: `Element ${elementNotActive || ''} should be active`,
    },
  );
});
