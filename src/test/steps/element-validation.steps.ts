/* eslint-disable no-loop-func */
/* eslint-disable no-await-in-loop */
/* eslint-disable import/prefer-default-export */
import { Then, TableDefinition } from '@pvhqa/cucumber';
import { expect } from 'chai';
import {
  maybeDisplayed$,
  exist$,
  maybeExist$,
  whenPageLoaded,
  maybeDisplayed$$,
  maybeExist$$,
  exist$$,
  maybeNotExist$,
} from '../general';
import services from '../../core/services';
import { Selector, DropdownSelector, REVERSE_CHECK } from '../../core/constents';
import BasePage from '../pages/base-page';

Then(/I see following elements are displayed(?: in (\d+) seconds?)?/, async (timeoutInSeconds: number, table: TableDefinition) => {
  const selectorCommands: Array<Promise<Selector | DropdownSelector>> = [];
  const timeout = timeoutInSeconds
    ? timeoutInSeconds * 1000
    : services.env.DriverConfig.timeout.elementDisplayed;

  for (let row = 0; row < table.rows().length; row += 1) {
    const args = services.product.parse(table.rows()[row][1]);
    selectorCommands.push(services.pageObject.getSelector(table.rows()[row][0], args.split(',')));
  }
  const selectors = await Promise.all(selectorCommands);
  const commands = selectors.map((s) => maybeDisplayed$(s, timeout));
  const results = await Promise.all(commands);
  results.forEach((r) => {
    expect(r, 'some elements are not displayed').not.to.be.null;
  });
});

Then(/I (?:wait until|see) ([^\s]+)(?: with (?:args|value|text|index|href|data-testid|id) (.*))? is( not)? (displayed|in viewport|existing)(?: in (\d+) seconds?)?(?: with (.*) case?)?/, async (
  elementPath: string, args: string, notDisplayed: string,
  displayType: string, timeoutInSeconds?: number, textCase?: string) => {
  const countryInfo = services.checkoutaddress.getCountryDetails(services.site.locale);
  let selector;
  if (args) {
    if (args.includes('#itemIndex')) {
      args = services.world.parse(args);
      selector = await services.pageObject.getSelector(elementPath, [args]);
    } else if (args.indexOf('##') > 0) {
      args = args.split('##').map((a) => {
        a = services.world.parse(a);
        a = services.product.parse(a);
        a = services.account.parse(a);
        if (a === 'POSTCODE') {
          a = countryInfo.postcode;
        }
        if (a === 'NEWPOSTCODE') {
          a = countryInfo.newpostcode;
        }
        if (a === 'PHONE') {
          a = countryInfo.province;
        }
        if (a === 'STATE') {
          a = countryInfo.phone;
        }
        return a;
      }).join('##');
    } else {
      args = services.world.parse(args);
      args = services.product.parse(args);
      args = services.account.parse(args);
      if (args === '#POSTCODE') {
        args = countryInfo.postcode;
      }
      if (args === '#NEWPOSTCODE') {
        args = countryInfo.newpostcode;
      }
      if (args === '#PHONE') {
        args = countryInfo.phone;
      }
      if (args === '#STATE') {
        args = countryInfo.province;
      }
      // This is used for CSR only so locale is hardcoded as CSR data is always in en
      if (args === 'todays date') {
        args = (new Date()).toLocaleDateString('en-GB');
      }
    }

    if (textCase === 'upper') {
      args = args.toUpperCase();
    } else if (textCase === 'lower') {
      args = args.toLowerCase();
    }
  }

  selector = selector || await services.pageObject.getSelector(elementPath, args ? args.split('##') : null);
  const timeout = timeoutInSeconds
    ? timeoutInSeconds * 1000
    : services.env.DriverConfig.timeout.elementDisplayed;
  if (notDisplayed) {
    const ele = await maybeNotExist$(selector, timeout);
    if (ele != null) {
      if (displayType === 'displayed') {
        await ele.waitForDisplayed({ timeout, reverse: REVERSE_CHECK, timeoutMsg: `Expected: ${elementPath} should NOT be displayed in ${timeout}ms. Actual: element was displayed` });
      } else if (displayType === 'in viewport') {
        await browser.waitUntil(async () => {
          const isInViewport = await ele.isDisplayedInViewport();
          return !isInViewport;
        }, { timeout, timeoutMsg: `Expected: ${elementPath} should NOT be in viewport in ${timeout}ms. Actual: element was in the viewport` });
      } else {
        throw new Error(`Expected: ${elementPath} should NOT be existed, Actual: element is exist`);
      }
    }
  } else {
    const ele = await maybeExist$(selector, timeout);
    expect(ele, `the element ${elementPath} with selector "${selector}" does not exist`).not.to.be.null;
    if (displayType === 'displayed') {
      await ele.waitForDisplayed({ timeout, timeoutMsg: `Expected: ${elementPath} should be displayed in ${timeout}ms. Actual: element was not displayed` });
    } else if (displayType === 'in viewport') {
      await browser.waitUntil(async () => {
        const isInViewport = await ele.isDisplayedInViewport();
        return isInViewport;
      }, { timeout, timeoutMsg: `Expected: ${selector} should be in viewport in ${timeout}ms. Actual: element was not in the viewport` });
    }
  }
});

Then(/in dropdown ([^\s]+) I see the option with (?:value|text|args) "(.*)" exists/, async (dropDownContainerPath: string, value: string) => {
  const dropdown = await services
    .pageObject
    .getSelector(dropDownContainerPath, [value]) as DropdownSelector;
  const timeout = services.env.DriverConfig.timeout.elementDisplayed;
  const option = await maybeExist$(dropdown.optionSelector, timeout);
  expect(option, `Expected: Select option: ${dropDownContainerPath} with args ${value} should be exist in ${timeout}ms. Path is ${dropdown.optionSelector}`).not.to.be.null;
});

Then(/in dropdown ([^\s]+) I (?:wait until|see) current selected text (is|contains) "(.*)"(?: in (\d+) seconds?)?/, async (dropDownContainerPath: string, compareType: string, expectedText: string, timeoutInSeconds?: number) => {
  const dropdown = await services
    .pageObject
    .getSelector(dropDownContainerPath) as DropdownSelector;
  if (dropdown.selectedValueSelector) {
    const timeout = timeoutInSeconds
      ? timeoutInSeconds * 1000
      : services.env.DriverConfig.timeout.elementDisplayed;
    let actualText: string;
    return whenPageLoaded(async () => {
      const res = await browser.waitUntil(
        async () => {
          const ele = await exist$(dropdown.selectedValueSelector);
          const textList = await Promise.all([ele.getTextByJs(), ele.getText(), ele.getValue()]);
          actualText = textList[0] || textList[1] || textList[2];
          actualText = actualText.replace(/[\u00A0]/g, ' ');
          actualText = actualText.trim();
          if (compareType === 'is') {
            return actualText === expectedText;
          }
          return actualText.indexOf(expectedText) >= 0;
        },
        {
          timeout,
          timeoutMsg: `Expected: current selected text of dropdown ${dropDownContainerPath} should be ${expectedText}, but actual value was: ${actualText}`,
        },
      );
      return res;
    });
  }
  throw new Error(`The locator ${dropDownContainerPath} doesn't have selectedValueSelector`);
});

export const stepISeeTextOfInputIs = async (
  elementPath: string, expectedText: string, timeoutInSeconds?: number,
) => {
  expectedText = services.account.parse(expectedText);
  const selector = await services.pageObject.getSelector(elementPath);
  const timeout = timeoutInSeconds
    ? timeoutInSeconds * 1000
    : services.env.DriverConfig.timeout.elementDisplayed;
  const ele = await exist$(selector, timeout);
  let actualValue: string;
  return whenPageLoaded(async () => {
    const res = await browser.waitUntil(
      async () => {
        actualValue = await ele.getValue();
        return actualValue === expectedText;
      },
      {
        timeout,
        timeoutMsg: `Expected: input ${elementPath} should be ${expectedText}, but actual value was: ${actualValue}`,
      },
    );
    return res;
  });
};
Then(/I see the text of input (.*) is "(.*)"(?: in (\d+) seconds?)?/, stepISeeTextOfInputIs);

Then(/I (?:wait until|see) ([^\s]+)(?: with (?:args|value|text|index|href|data-testid) (.*))? is( not)? clickable(?: in (\d+) seconds?)?/, async (elementPath: string, args: string, notClickable: string, timeoutInSec: number) => {
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  const selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  const ele = await exist$(selector);
  await ele.waitForClickable({
    timeout: timeoutInSec * 1000 || services.env.DriverConfig.timeout.elementClickable.timeout,
    reverse: !!notClickable,
  });
});

Then(/(?:I wait until )?the count of( displayed)? elements ([^\s]+)(?: with (?:args|value|text|index|href|data-testid) (.*))? is (equal to|greater than|less than|not less than) ([^\s]+)(?: in (\d+) seconds?)?/, async (
  displayed: string, elementPath: string, args: string,
  compareType: string, expectedCountStr: string, timeoutInSeconds?: number) => {
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  const selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  const timeout = timeoutInSeconds
    ? timeoutInSeconds * 1000
    : services.env.DriverConfig.timeout.elementDisplayed;
  const expectedCount = Number(services.world.parse(expectedCountStr));
  if (!expectedCount && expectedCount !== 0) {
    throw new Error(`The expected count of ${elementPath} is invalid, actual is : ${expectedCountStr}`);
  }
  let actualCount: number;
  return whenPageLoaded(async () => {
    const r = await browser.waitUntil(
      async () => {
        const eles = displayed
          ? await maybeDisplayed$$(selector, undefined, timeout)
          : await maybeExist$$(selector, undefined, timeout);
        actualCount = eles.length;
        if (compareType === 'equal to') {
          return actualCount === expectedCount;
        }
        if (compareType === 'greater than') {
          return actualCount > expectedCount;
        }
        if (compareType === 'not less than') {
          return actualCount >= expectedCount;
        }
        return actualCount < expectedCount;
      },
      {
        timeout,
        timeoutMsg: `Expected count of${displayed ? ' displayed' : ''} ${elementPath} should be ${compareType} ${expectedCount}. Actual count was: ${actualCount}`,
      },
    );
    return r;
  });
});

Then(/I (?:wait until|see) ([^\s]+)(?: with (?:args|value|text|index|href|data-testid) (.*))? (contains|does not contain) (translated text|text) "(.*)"/, async (elementPath: string, args: string, compareState: string, translatedOption: string, expectedText: string) => {
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  const selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  const shouldContain = compareState === 'contains';
  if (translatedOption.indexOf('translated') >= 0) {
    const currentLanguage = services.site.siteInfo.LOCALENAME.toLowerCase();
    expectedText = services.translation.get(currentLanguage, expectedText);
    expectedText = expectedText.toLocaleLowerCase();
  } else {
    expectedText = services.world.parse(expectedText).toString().toLowerCase();
    expectedText = services.account.parse(expectedText).toString().toLowerCase();
  }
  if (expectedText.indexOf('<br>') > 0) {
    const textSplit = expectedText.split('<br>');
    // eslint-disable-next-line prefer-destructuring
    expectedText = textSplit[0];
  }
  if (expectedText.indexOf('<a href=') > 0) {
    const textSplit = expectedText.split('<a href=');
    // eslint-disable-next-line prefer-destructuring
    expectedText = textSplit[0];
  }

  let actualText: string;
  let res = null;
  return whenPageLoaded(async () => {
    if (expectedText !== 'ignore') {
      res = await browser.waitUntil(
        async () => {
          // eslint-disable-next-line max-len
          const element = await exist$(selector, services.env.DriverConfig.timeout.elementDisplayed);
          const textList = await Promise.all([element.getText(), element.getTextByJs()]);
          const text = textList[0] || textList[1];
          actualText = text.replace(/\u00a0/g, ' ').toLowerCase();
          if (shouldContain) {
            return actualText.indexOf(expectedText.trim()) >= 0;
          }
          return actualText.indexOf(expectedText.trim()) < 0;
        },
        {
          timeout: services.env.DriverConfig.timeout.elementDisplayed,
          timeoutMsg: `Actual text "${actualText}" of element ${elementPath} should${shouldContain ? '' : ' not'}  contain expected "${expectedText}"`,
        },
      );
    }
    return res;
  });
  // }
});

Then(/I (?:wait until|see) the checkbox ([^\s]+)(?: with (?:args|value|text|index) (.*))? is (checked|unchecked)(?: in (\d+) seconds?)?/, async (elementPath: string, args: string, checkboxState: string, timeoutInSeconds: number) => {
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  const selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  const timeout = timeoutInSeconds
    ? timeoutInSeconds * 1000
    : services.env.DriverConfig.timeout.elementDisplayed;
  const expectedCheckboxState = checkboxState === 'checked';
  let actualCheckboxState: boolean;
  return whenPageLoaded(async () => {
    const res = await browser.waitUntil(
      async () => {
        const checkbox = await exist$(selector);
        actualCheckboxState = await checkbox.isSelected();
        return actualCheckboxState === expectedCheckboxState;
      },
      {
        timeout,
        timeoutMsg: `State of checkbox ${elementPath} is not correct. Expected: checkbox is ${checkboxState}. Actual state was: ${actualCheckboxState}`,
      },
    );
    return res;
  });
});

Then(/I (?:wait until|see) ([^\s]+)(?: with (?:args|value|text|index|data-testid) (.*))? is (enabled|disabled)(?: in (\d+) seconds?)?/, async (elementPath: string, args: string, elementState: string, timeoutInSeconds: number) => {
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  const selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  const timeout = timeoutInSeconds
    ? timeoutInSeconds * 1000
    : services.env.DriverConfig.timeout.elementDisplayed;
  const expectedElementState = elementState === 'enabled';
  let actualElementState: boolean;
  return whenPageLoaded(async () => {
    const res = await browser.waitUntil(
      async () => {
        const ele = await exist$(selector);
        actualElementState = await ele.isEnabled();
        return actualElementState === expectedElementState;
      },
      {
        timeout,
        timeoutMsg: `State of element ${elementPath} is not correct. Expected: element is ${elementState}. Actual state was: ${actualElementState}`,
      },
    );
    return res;
  });
});

Then(/the( numeric)? value of(?: attribute (.*) of element)? ([^\s]+)(?: with (?:args|value|text|index) (.*))? should( not)? (be equal to|contain) the stored value with key (#[^\s]+)/, async (
  isNumeric: string, attribute: string, elementPath: string, args: string,
  compareState: string, compareType: string, key: string) => {
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  const selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  const isEqual = !compareState;
  const strictEqual = compareType === 'be equal to';
  let expectedValue = (services.world.parse(key)).toString().toLowerCase();
  const numericValueHasOnlyOneDecimal = !!expectedValue.match(/\d+\.\d{1}/) && !expectedValue.match(/\d+\.\d{2}/);
  expectedValue = numericValueHasOnlyOneDecimal ? `${expectedValue}0` : expectedValue;
  expectedValue = expectedValue.replace(/\.(0)+$/g, ''); // remove any trailing zeros after the dot sign,
  let actualValue: string;
  return whenPageLoaded(async () => {
    const res = await browser.waitUntil(
      async () => {
        if (services.env.Brand === 'ck' && services.env.IsMobile === true) {
          const plpSelector = await services.pageObject.getSelector('Experience.PlpHeader.ProductCount', args ? args.split('##') : null);
          const ele = await maybeExist$(plpSelector, 5000);
          if (ele) {
            ele.jsClick();
          }
        } else if (services.env.Brand === 'ck' && services.env.IsMobile === false) {
          await browser.mouseMove(0, 0);
        }
        if (attribute) {
          actualValue = (await (await exist$(selector)).getAttribute(attribute))
            .toString().toLowerCase().trimStart();
        } else {
          const ele = await exist$(selector);
          const textList = await Promise.all([ele.getText(), ele.getTextByJs()]);
          const text = textList[0] || textList[1];
          actualValue = text.toString().toLowerCase().trimStart();
        }
        if (isNumeric) {
          actualValue = actualValue.replace(/[^0-9.,]/g, '').replace(',', '.');
          actualValue = actualValue.replace(/\D+$/g, ''); // remove all characters after last digit - can be .,
          actualValue = actualValue.replace(/\.(0)+$/g, ''); // remove any trailing zeros after the dot sign,
          actualValue = actualValue.match(/\d+\.\d{3}(?:\.\d{2})?/)
            ? actualValue.slice(0, actualValue.indexOf('.')) + actualValue.slice(actualValue.indexOf('.') + 1)
            : actualValue;
        }
        const compareResult = strictEqual
          ? expectedValue === actualValue
          : actualValue.indexOf(expectedValue) >= 0;
        return isEqual === compareResult;
      },
      {
        timeout: services.env.DriverConfig.timeout.elementDisplayed,
        timeoutMsg: `Actual value "${actualValue}" should${compareState || ''} ${compareType} ${expectedValue}`,
      },
    );
    return res;
  });
});

Then(/the values of (all|displayed) elements ([^\s]+) should( not)? be equal to the stored values with key (#[^\s]+)/, async (displayState: string, elementPath: string, compareState: string, key: string) => {
  const isEqual = !compareState;
  const expectedValues = services.world.parse(key);
  let actualValues = [];
  return whenPageLoaded(async () => {
    const res = await browser.waitUntil(
      async () => {
        const elements = displayState === 'all'
          ? await maybeExist$$(elementPath)
          : await maybeDisplayed$$(elementPath);
        let i = 0;
        actualValues = [];
        while (i < elements.length) {
          const textList = await Promise.all([elements[i].getText(), elements[i].getTextByJs()]);
          const text = textList[0] || textList[1];
          actualValues.push(text.toString());
          i += 1;
        }
        const compareResult = expectedValues.toString() === actualValues.toString();
        return isEqual === compareResult;
      },
      {
        timeout: services.env.DriverConfig.timeout.elementDisplayed,
        timeoutMsg: `Actual values "${actualValues.toString()}" should${compareState || ''} be equal to "${expectedValues.toString()}"`,
      },
    );
    return res;
  });
});

Then(/(?:I wait until )?the numeric value of ([^\s]+)(?: with (?:args|value|text|index|href) (.*))? is (equal to|greater than|less than|greater or equal than) ([^\s]+)(?: in (\d+) seconds?)?/, async (
  elementPath: string, args: string,
  compareType: string, expectedCountStr: string, timeoutInSeconds?: number) => {
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  const selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  let expectedValue = services.world.parse(expectedCountStr);
  const timeout = timeoutInSeconds
    ? timeoutInSeconds * 1000
    : services.env.DriverConfig.timeout.elementDisplayed;
  expectedValue = Number(Number(expectedValue).toFixed(2));
  if (!expectedValue && expectedValue !== 0) {
    throw new Error(`The expected value of ${elementPath} is invalid, actual is : ${expectedCountStr}`);
  }
  let actualValue: number;
  return whenPageLoaded(async () => {
    const r = await browser.waitUntil(
      async () => {
        const ele = await exist$(selector, timeout);
        const textList = await Promise.all([ele.getText(), ele.getTextByJs()]);
        const text = textList[0] || textList[1];
        let actualValueStr = text.toLowerCase().replace(/[^0-9.,]/g, '').replace(',', '.');
        actualValueStr = actualValueStr.replace(/\D+$/g, ''); // remove all characters after last digit - can be .,
        actualValueStr = actualValueStr.match(/\d+\.\d{3}(?:\.\d{2})?/)
          ? actualValueStr.slice(0, actualValueStr.indexOf('.')) + actualValueStr.slice(actualValueStr.indexOf('.') + 1)
          : actualValueStr;
        actualValue = Number(actualValueStr);
        if (!actualValue && actualValue !== 0) {
          throw new Error(`The expected value of ${elementPath} is invalid, actual is : ${actualValueStr}`);
        }
        if (compareType === 'equal to') {
          if (actualValue === expectedValue) {
            return true;
          }
          throw new Error(`The expected value of ${elementPath} is ${expectedValue} not equal to actual : ${actualValue}`);
        }
        if (compareType === 'greater than') {
          return actualValue > expectedValue;
        }
        if (compareType === 'greater or equal than') {
          return actualValue >= expectedValue;
        }
        return actualValue < expectedValue;
      },
      {
        timeout,
        timeoutMsg: `Expected value of ${elementPath} should be ${compareType} ${expectedValue}. Actual value was: ${actualValue}`,
      },
    );
    return r;
  });
});

Then(/I (?:wait until|see) the attribute (.*) of element ([^\s]+)(?: with (?:args|value|text|index) ([^\s]+))?( not)? containing "(.*)"(?: in (\d+) seconds?)?/, async (
  attribute: string,
  elementPath: string,
  args: string,
  compareState: string,
  expectedValue: string,
  timeoutInSeconds: number,
) => {
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  expectedValue = services.world.parse(expectedValue);
  expectedValue = services.product.parse(expectedValue);
  expectedValue = services.account.parse(expectedValue);
  const countryInfo = services.checkoutaddress.getCountryDetails(services.site.locale);
  if (expectedValue === '#POSTCODE') {
    expectedValue = countryInfo.postcode;
  }
  if (expectedValue === '#NEWPOSTCODE') {
    expectedValue = countryInfo.newpostcode;
  }
  if (expectedValue === '#PHONE') {
    expectedValue = countryInfo.phone;
  }
  if (expectedValue === '#STATE') {
    expectedValue = countryInfo.province;
  }
  if (expectedValue === '#DELIVERY_FIRST_LINE') {
    expectedValue = services.checkoutaddress.getLatestCheckoutAddress().address;
  }
  const selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  const timeout = timeoutInSeconds
    ? timeoutInSeconds * 1000
    : services.env.DriverConfig.timeout.elementDisplayed;
  const shouldContainValue = !compareState;
  let actualValue: string;
  return whenPageLoaded(async () => {
    const res = await browser.waitUntil(
      async () => {
        const eles = await maybeExist$$(selector, undefined, timeout);
        if (eles && eles.length > 0) {
          // multiple ele match
          if (eles.length > 1) {
            for (let index = 0; index < eles.length; index += 1) {
              const eleValue = await eles[index].getAttribute(attribute);
              if (eleValue.toLowerCase().indexOf(expectedValue.toLowerCase()) >= 0) {
                if (shouldContainValue) {
                  return true;
                }
                return false;
              }
            }
            if (shouldContainValue) {
              return false;
            }
            return true;
          }
          actualValue = await eles[0].getAttribute(attribute);
        } else {
          actualValue = '';
        }
        if (shouldContainValue && actualValue) {
          return actualValue.toLowerCase().indexOf(expectedValue.toLowerCase()) >= 0;
        } if (!shouldContainValue && actualValue) {
          return actualValue.toLowerCase().indexOf(expectedValue.toLowerCase()) < 0;
        } if (shouldContainValue && !actualValue) {
          return false;
        }
        return true;
      },
      {
        timeout,
        timeoutMsg: `Actual value "${actualValue}" should${compareState || ''} contain "${expectedValue}"`,
      },
    );
    return res;
  });
});

Then(/the( numeric)? value of ([^\s]+)(?: with (?:args|value|text|index) (.*))? should( not)? match regex pattern "(.*)"(?: in (\d+) seconds?)?/, async (isNumeric: string, elementPath: string, args: string, compareState: string, regexPattern: string, timeoutInSeconds: number) => {
  let actualValue: string;
  let selector: string | DropdownSelector;
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  regexPattern = services.world.parse(regexPattern);
  if (elementPath.startsWith('#')) {
    actualValue = services.world.parse(elementPath);
  } else {
    selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  }
  const timeout = timeoutInSeconds
    ? timeoutInSeconds * 1000
    : services.env.DriverConfig.timeout.elementDisplayed;
  const shouldMatchRegexPattern = !compareState;
  return whenPageLoaded(async () => {
    const res = await browser.waitUntil(
      async () => {
        if (selector) {
          const element = await exist$(selector);
          const textList = await Promise.all([element.getText(), element.getTextByJs()]);
          actualValue = textList[0] || textList[1];
        }
        actualValue = isNumeric ? actualValue.replace(/[^0-9.,]/g, '') : actualValue;
        const regexMatch = !!actualValue.match(regexPattern);
        return regexMatch === shouldMatchRegexPattern;
      },
      {
        timeout,
        timeoutMsg: `Actual value "${actualValue}" should${compareState || ''} match expected pattern "${regexPattern}"`,
      },
    );
    return res;
  });
});

Then(/I (?:wait until|see) the count of ([^\s]+) is the same as the count of ([^\s]+)(?: in (\d+) seconds?)?/, async (elementPath1: string, elementPath2: string, timeoutInSeconds: number) => {
  const selector1 = await services.pageObject.getSelector(elementPath1);
  const selector2 = await services.pageObject.getSelector(elementPath2);
  const timeout = timeoutInSeconds
    ? timeoutInSeconds * 1000
    : services.env.DriverConfig.timeout.elementDisplayed;
  let countFirstElement: number;
  let countSecondElement: number;
  return whenPageLoaded(async () => {
    const res = await browser.waitUntil(
      async () => {
        countFirstElement = (await maybeExist$$(selector1, undefined, timeout)).length;
        countSecondElement = (await maybeExist$$(selector2, undefined, timeout)).length;
        return countFirstElement === countSecondElement;
      },
      {
        timeout,
        timeoutMsg: `Number of ${elementPath1} is not correct. Expected: ${countSecondElement}, actual: ${countFirstElement}`,
      },
    );
    return res;
  });
});

Then(/width[/]height ratio for( all)? elements? ([A-Za-z.-]+)(?: with (?:args|value|text|index) (.*))? is between ([\d.]+) and ([\d.]+)/, async (allElements: string, elementPath: string, args: string, lowRange: number, upRange: number) => {
  if (args) {
    args = services.world.parse(args);
    args = services.product.parse(args);
  }
  const selector = await services.pageObject.getSelector(elementPath, args ? args.split(',') : null);
  const elementsToCheck = await (exist$$(selector));
  const elementRange = allElements ? elementsToCheck.length : 1;
  for (let i = 0; i < elementRange; i += 1) {
    await browser.waitUntil(
      async () => {
        const actualRatio = +(await browser.execute('return arguments[0].offsetWidth / arguments[0].offsetHeight;', elementsToCheck[i]));
        const isCorrectRatio = actualRatio >= +lowRange && actualRatio <= +upRange;
        return isCorrectRatio;
      },
      {
        timeout: 3000,
        timeoutMsg: `Width/height ratio for the ${i + 1} element of ${elementPath} has incorrect ratio. Expected ratio between ${lowRange} and ${upRange}. Actual ratio: ${+(await browser.execute('return arguments[0].offsetWidth / arguments[0].offsetHeight;', elementsToCheck[i]))}`,
      },
    );
  }
});

Then(/I see meta tags.*/, async (datatable: TableDefinition) => {
  // These are selectors from the BasePage
  enum TagTypes {
    name = 'Metatag',
    property = 'MetaProperty',
  }
  async function retrieveMeta(metadata: Map<string, string>): Promise<any> {
    const [searchAttr, validationAttr]: Array<string> = Object.keys(metadata);
    const selector = (new BasePage())[TagTypes[searchAttr]](metadata[searchAttr]);
    const metatag = await exist$(selector).then((e) => e.getAttribute(validationAttr));
    return {
      key: metadata[searchAttr],
      value: metadata[validationAttr],
      actual: metatag,
    };
  }
  const results = await Promise.all(datatable.hashes().map(retrieveMeta));
  results.forEach((entry) => expect(entry.value, `Metatag ${entry.key}`).to.be.eq(entry.actual));
});
