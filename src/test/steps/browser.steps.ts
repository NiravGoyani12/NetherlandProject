/* eslint-disable max-len */
/* eslint-disable import/prefer-default-export */
import { When, Then } from '@pvhqa/cucumber';
import got from 'got/dist/source';
import { expect } from 'chai';
import { sleep } from '../helper/utils.helper';
import { GetTestLogger } from '../../core/logger/test.logger';
import { exist$, whenPageLoaded } from '../general';
import services from '../../core/services';
import { ChromeCookie } from '../commands/browser';


When(/I wait for (\d+) seconds?/, async (seconds: number) => {
  await sleep(seconds * 1000);
});

When(/I wait for (\d+) ms?/, async (ms: number) => {
  await sleep(ms);
});

When(/I navigate back in the browser/, async () => {
  await browser.back();
});

When(/I refresh page/, async () => {
  await browser.refresh();
});

When(
  /I save current( decoded)? url( without trailing slash)? as key (#[A-Za-z0-9]+)/,
  async (decodeUrl: string, excludeTrailingSlash: string, key: string) => {
    let url = await browser.getUrl();
    url = decodeUrl ? decodeURI(url) : url;
    url = excludeTrailingSlash && url.endsWith('/') ? url.slice(0, -1) : url;
    services.world.store(key, url);
  },
);

/*
TODO: this step doesn't consistently work on android
we should have a good strategy for handling key events across devices
*/
export const stepPressKeyOnKeyboard = async (keyName: string) => {
  let keyCodeDesktop: string;
  let keyCodeAndroid: number;
  switch (keyName) {
    case 'Escape':
      keyCodeDesktop = '\uE00C';
      keyCodeAndroid = 111;
      break;
    case 'Enter':
      keyCodeDesktop = '\uE007';
      keyCodeAndroid = 66;
      break;
    case 'Tab':
      keyCodeDesktop = '\uE004';
      keyCodeAndroid = 61;
      break;
    case 'Backspace':
      keyCodeDesktop = '\uE003';
      keyCodeAndroid = 67;
      break;
    case 'End':
      keyCodeDesktop = '\uE010';
      keyCodeAndroid = 123;
      break;
    default:
      throw new Error(`Not implemented keyName ${keyName}
        For correct desktop keycodes refer to https://w3c.github.io/webdriver/#keyboard-actions
        For correct Android keyevent refer to https://developer.android.com/reference/android/view/KeyEvent#constants`);
  }
  try {
    await browser.keys(keyCodeDesktop);
  } catch (e) {
    await browser.pressKeyCode(keyCodeAndroid);
  }
};
When(
  /I press key (Escape|Enter|Tab|Backspace) on the keyboard/,
  stepPressKeyOnKeyboard,
);

When(
  /I( smoothly)? move to the (top|bottom) of the page/,
  async (smoothBehavior: string, position: 'bottom' | 'top') => {
    try {
      if (smoothBehavior) {
        await (browser as any).smoothScrollToWindowDirection(position);
      } else {
        await (browser as any).scrollToWindowDirection(position);
      }
    } catch (e) {
      // Handle mobile scroll in case of "Cannot read property 'scrollHeight' of null"
      GetTestLogger().warn(`Move to ${position} failed, with error ${e}`);
    }
  },
);

When(
  /I resize screen size with width (\d+) and height (\d+)/,
  async (width: number, height: number) => {
    if (services.env.IsDesktop) {
      await browser.setWindowSize(width, height);
      await sleep(1000);
    }
  },
);

Then(
  /URL should( not)? contain "(.*)"(?: in (\d+) seconds?)?/,
  async (notContains: string, part: string, timeoutInSeconds: number) => {
    part = services.world.parse(part);
    const timeout = timeoutInSeconds
      ? timeoutInSeconds * 1000
      : services.env.DriverConfig.timeout.elementDisplayed;
    let currentUrl;
    let matchColorSearchPartOfCurrentUrl;
    let matchesDestructuredVerficationPart;
    part = part.toLocaleLowerCase();
    return whenPageLoaded(async () => {
      const res = await browser.waitUntil(
        async () => {
          currentUrl = (await browser.getUrl()).toLocaleLowerCase();
          if (currentUrl.includes('/search/c/')) {
            matchColorSearchPartOfCurrentUrl = currentUrl.match('.*(/c/.*)[?]');
            if (part.includes('/search')) {
              matchesDestructuredVerficationPart = part.match('(.*)(/search)(.*)');
              part = `${matchesDestructuredVerficationPart[1]}${matchesDestructuredVerficationPart[2]}${matchColorSearchPartOfCurrentUrl[1]}${matchesDestructuredVerficationPart[3]}`;
            }
          }
          const result = notContains
            ? currentUrl.indexOf(part) < 0
            : currentUrl.indexOf(part) >= 0;
          return result;
        },
        {
          timeout,
          timeoutMsg: `Expected URL should${
            notContains || ''
          } contains "${part}". Actual: "${currentUrl}"`,
        },
      );
      return res;
    });
  },
);

// TODO: this step haven't been test!!!
When(
  /I delete (all|authentication|gdpr|newsletter|userActivity|persistent) cookies( and refresh)?/,
  async (cookiesType: string, refreshPage: string) => {
    switch (cookiesType) {
      case 'authentication':
        await (browser as any).deleteAuthenticationCookies();
        break;
      case 'userActivity':
        await (browser as any).deleteUserActivityCookies();
        break;
      case 'persistent':
        await (browser as any).deletePersistentCookies();
        break;
      case 'gdpr':
        await (browser as any).deleteGDPRCookies();
        break;
      case 'newsletter':
        await (browser as any).deleteNewsletterCookies();
        break;
      default:
        await browser.deleteAllCookies();
    }
    if (refreshPage) {
      await browser.refresh();
    }
  },
);

When(
  /I set( gender)? cookies ([^\s]+) to "(.*)"/,
  async (isGenderCookies: string, name: string, value: string) => {
    if (isGenderCookies) {
      value = `${services.site.siteInfo.LANGUAGE_ID}%2C%2F${value}`;
    }
    await browser.setCookies({ name, value });
  },
);

When(
  /I set (session|local) storage ([^\s]+) to (.*)/,
  async (storageType: string, key: string, value: string) => {
    let valueToInsert = '';
    if (storageType === 'session') {
      await browser.execute(`sessionStorage.setItem("${key}", ${value});`);
    } else {
      const val = (JSON.parse(value));
      if (typeof val === 'object') {
        valueToInsert = JSON.stringify(value);
      } else {
        valueToInsert = value;
      }
      await browser.execute(`localStorage.setItem(${key}, ${valueToInsert});`);
    }
    await sleep(1000);
  },
);

Then(
  /(functional PVH|all PVH|gender) cookies should( not)? be set/,
  async (cookiesType: string, notSet: string) => {
    let cookieState: boolean;
    return whenPageLoaded(async () => {
      const res = await browser.waitUntil(
        async () => {
          cookieState = cookiesType.indexOf('PVH') >= 0
            ? await (browser as any).getPvhCookiesState(
              cookiesType.indexOf('functional') >= 0,
            )
            : await (browser as any).getGenderCookiesState();
          if (notSet) {
            return !cookieState;
          }
          return cookieState;
        },
        {
          timeout: services.env.DriverConfig.timeout.elementDisplayed,
          timeoutMsg: `Expected: ${cookiesType} cookies should${
            notSet || ''
          } be set. Actual: ${cookiesType} cookies are set to ${cookieState}.`,
        },
      );
      return res;
    });
  },
);

Then(
  /olapic cookies should( not)? be set/,
  async (notSet: string) => {
    let cookieState: boolean;
    return whenPageLoaded(async () => {
      const res = await browser.waitUntil(
        async () => {
          cookieState = await (browser as any).getOlapicCookiesState();
          if (notSet) {
            return !cookieState;
          }
          return cookieState;
        },
        {
          timeout: services.env.DriverConfig.timeout.elementDisplayed,
          timeoutMsg: `Expected: Olapic cookies should${
            notSet || ''
          } be set. Actual: Olapic cookies are set to ${cookieState}.`,
        },
      );
      return res;
    });
  },
);

Then(
  /cookie (.*) should( not)? have parameter (value|secure|sameSite|expiryDate) set to (.*)/,
  async (
    cookieName: string,
    notSet: string,
    cookieParameter: string,
    expectedValue: string,
  ) => {
    let actualCookieValue: string;
    let date: Date;
    expectedValue = services.world.parse(expectedValue);
    expectedValue = services.product.parse(expectedValue);

    if (cookieParameter === 'expiryDate') {
      const currentDate = new Date();
      // Adding number of passed months to current date
      currentDate.setMonth(currentDate.getMonth() + Number(expectedValue));
      const expectedExpiryDate = currentDate.toISOString();
      expectedValue = expectedExpiryDate.toString();
      // eslint-disable-next-line prefer-destructuring
      expectedValue = expectedValue.split(/[T ]/i, 1)[0];
    }
    return whenPageLoaded(async () => {
      const res = await browser.waitUntil(
        async () => {
          try {
            const cookie = (await browser.getNamedCookie(
              cookieName,
            )) as ChromeCookie;
            switch (cookieParameter) {
              case 'value':
                actualCookieValue = cookie.value;
                break;
              case 'secure':
                actualCookieValue = cookie.secure.toString();
                break;
              case 'sameSite':
                actualCookieValue = cookie.sameSite;
                break;
              case 'expiryDate':
                date = new Date(0);
                date.setUTCSeconds(cookie.expiry);
                actualCookieValue = date.toISOString();
                // eslint-disable-next-line prefer-destructuring
                actualCookieValue = actualCookieValue.split(/[T ]/i, 1)[0];
                break;
              default:
                throw new Error(
                  `Parameter ${cookieParameter} is not implemented`,
                );
            }
          } catch {
            actualCookieValue = null;
          }
          if (notSet) {
            return !(actualCookieValue === expectedValue);
          }
          return actualCookieValue === expectedValue;
        },
        {
          timeout: services.env.DriverConfig.timeout.elementDisplayed,
          timeoutMsg: `Expected: Cookie ${cookieName} should${
            notSet || ''
          } have parameter ${cookieParameter} "${expectedValue}". Actual: cookie parameter ${cookieParameter} was "${actualCookieValue}".`,
        },
      );
      return res;
    });
  },
);

Then(
  /(?:I wait until )?the count of cookies ([^\s]+) is (equal to|greater than|less than) ([^\s]+)(?: in (\d+) seconds?)?/,
  async (
    partialCookieName: string,
    compareType: string,
    expectedCountStr: string,
    timeoutInSeconds?: number,
  ) => {
    const timeout = timeoutInSeconds
      ? timeoutInSeconds * 1000
      : services.env.DriverConfig.timeout.elementDisplayed;
    const expectedCount = Number(services.world.parse(expectedCountStr));
    if (!expectedCount && expectedCount !== 0) {
      throw new Error(
        `The expected count of ${partialCookieName} is invalid, actual is : ${expectedCountStr}`,
      );
    }
    let actualCount: number;
    return whenPageLoaded(async () => {
      const r = await browser.waitUntil(
        async () => {
          const allCookies = (await browser.getAllCookies()) as ChromeCookie[];
          actualCount = allCookies.filter(
            (cookie) => cookie.name.indexOf(partialCookieName) >= 0,
          ).length;
          if (compareType === 'equal to') {
            return actualCount === expectedCount;
          }
          if (compareType === 'greater than') {
            return actualCount > expectedCount;
          }
          return actualCount < expectedCount;
        },
        {
          timeout,
          timeoutMsg: `Expected count of cookies with name ${partialCookieName} should be ${compareType} ${expectedCount}. Actual count was: ${actualCount}`,
        },
      );
      return r;
    });
  },
);

Then(
  /cookie (.*) paramater value( without country suffix)? is stored with key (#[A-Za-z0-9]+)/,
  async (cookieName: string, countrySuffix: string, key: string) => {
    const locale = services.site.locale.toString().toLocaleLowerCase();
    let { langCode } = services.site;
    langCode ? (langCode = langCode.toString().toLocaleUpperCase()) : undefined;
    let actualCookieValue: string;
    const cookie = (await browser.getNamedCookie(cookieName)) as ChromeCookie;
    actualCookieValue = cookie.value.toLocaleLowerCase();
    if (countrySuffix || langCode) {
      if (
        actualCookieValue.includes(locale)
        || actualCookieValue.includes(langCode.toLocaleLowerCase())
      ) {
        actualCookieValue = actualCookieValue
          .substr(0, actualCookieValue.lastIndexOf('_'))
          .toLocaleLowerCase();
      }
    }
    services.world.store(key, actualCookieValue);
  },
);

Then(
  /I get the callerId from cookie (.*) paramater and stored with (#[^\s]+) key/,
  async (cookieName: string, keyToStore: string) => {
    let callerId: string;
    let { langCode } = services.site;
    langCode ? (langCode = langCode.toString().toLocaleUpperCase()) : undefined;
    const cookie = await browser.getCookies();
    callerId = cookie.find((cookies) => cookies.name.match(`${cookieName}`)).value;
    // eslint-disable-next-line prefer-destructuring
    callerId = callerId.split('%')[0];
    services.world.store(keyToStore, callerId);
    GetTestLogger().info(`VALUE for KEY ${keyToStore} is `, callerId);
  },
);

When(
  /I set the browser geo location to ([0-9.-]+) and ([0-9.-]+)/,
  async (newLat: number, newLong: number) => {
    await browser.execute(`
    window.navigator.geolocation.getCurrentPosition = function(success){ 
    const position = {
      'coords' : {  
        'latitude': ${newLat},
        'longitude': ${newLong} 
      }};
      success(position);
    }`);
  },
);

When(
  /I increase the nework buffer size to ([0-9.]+)/,
  async (bufferSize: number) => {
    await browser.execute(
      `window.performance.setResourceTimingBufferSize(${bufferSize});`,
    );
  },
);

When(
  /I (?:wait for|expect)?( at least| not more than|)? (\d+) network requests? named (.*) of type (.*) to be processed(?: in (\d+) seconds?)?/,
  async (
    compareType: string,
    expectedRequestNumber: number,
    partialRequestName: string,
    requestType: string,
    timeoutInSeconds?: number,
  ) => {
    const timeout = timeoutInSeconds
      ? timeoutInSeconds * 1000
      : services.env.DriverConfig.timeout.elementDisplayed;
    let actualRequestNumber: number;
    return whenPageLoaded(async () => {
      const res = await browser.waitUntil(
        async () => {
          actualRequestNumber = await (browser as any).getNetworkRequestNumber(
            requestType,
            partialRequestName,
          );
          if (compareType === ' at least') {
            return actualRequestNumber >= expectedRequestNumber;
          }
          if (compareType === ' not more than') {
            return actualRequestNumber <= expectedRequestNumber;
          }
          return actualRequestNumber === expectedRequestNumber;
        },
        {
          timeout,
          timeoutMsg: `Number of network requests is not correct. Expected:${
            compareType || ''
          } ${expectedRequestNumber} requests, Actual number was: ${actualRequestNumber}`,
        },
      );
      return res;
    });
  },
);

When(/I open a new browser tab/, async () => {
  await browser.execute('window.open();');
  const tabs = await browser.getWindowHandles();
  await browser.switchToWindow(tabs[tabs.length - 1]);
});

When(/I close current browser tab/, async () => {
  if (!(services.env.IsMobile && services.env.IsSafari)) {
    await browser.execute('window.open();');
    await browser.switchToWindow((await browser.getWindowHandles())[0]);
    await browser.closeWindow();
    await browser.switchToWindow((await browser.getWindowHandles())[0]);
  } else {
    // TODO: investigate a better solution for ios
    await browser.execute('window.sessionStorage.clear();');
  }
});

When(
  /I(?: am able to)? switch to (\d+)(?:st|nd|rd|th) browser tab/,
  async (tabNumber: number) => {
    let numberOpenTabs: number;

    return whenPageLoaded(async () => {
      const res = await browser.waitUntil(
        async () => {
          numberOpenTabs = (await browser.getWindowHandles()).length;
          return numberOpenTabs >= tabNumber;
        },
        {
          timeout: services.env.DriverConfig.timeout.elementDisplayed,
          timeoutMsg: `Can not switch to ${tabNumber} tab. Total number of open tabs was: ${numberOpenTabs}`,
        },
      );

      await browser.switchToWindow(
        (
          await browser.getWindowHandles()
        )[tabNumber - 1],
      );
      return res;
    });
  },
);

When(
  /I(?: am able to)? clear session storage item (.*) and (?:switch to|stay on) (\d+)(?:st|nd|rd|th) browser tab/,
  async (key: string, tabNumber: number) => {
    let numberOpenTabs: number;

    return whenPageLoaded(async () => {
      const res = await browser.waitUntil(
        async () => {
          numberOpenTabs = (await browser.getWindowHandles()).length;
          return numberOpenTabs >= tabNumber;
        },
        {
          timeout: services.env.DriverConfig.timeout.elementDisplayed,
          timeoutMsg: `Can not switch to ${tabNumber} tab. Total number of open tabs was: ${numberOpenTabs}`,
        },
      );
      await browser.execute(
        `return window.sessionStorage.removeItem('${key}')`,
      );
      await browser.switchToWindow(
        (
          await browser.getWindowHandles()
        )[tabNumber - 1],
      );
      return res;
    });
  },
);

/* Don't use this step at the end of scenario
Use @MultipleTabs tag instead, then browser tabs will be handled by After hook
Use this step only if you need it in the middle of your scenario
*/
When(/I close unused browser tabs?/, async () => {
  if (!(services.env.IsMobile && services.env.IsSafari)) {
    const tabs = await browser.getWindowHandles();
    if (tabs.length > 1) {
      for (let i = tabs.length - 1; i > 0; i -= 1) {
        // eslint-disable-next-line no-await-in-loop
        await browser.switchToWindow(tabs[i]);
        // eslint-disable-next-line no-await-in-loop
        await browser.closeWindow();
      }
      await browser.switchToWindow(tabs[0]);
    }
  }
});

Then(/Js object (.*) is set and not empty/, async (dataObject: string) => {
  const dataObjectScript = `
  try {
    const response = ${dataObject};
    if (response === null || response === undefined) {
      return 'Set but empty';
    }
    return 'Set and not empty';
  } catch {
    return 'Not set';
  }`;
  let consoleResponse: string;
  return whenPageLoaded(async () => {
    const res = await browser.waitUntil(
      async () => {
        consoleResponse = (await browser.execute(dataObjectScript)).toString();
        return consoleResponse === 'Set and not empty';
      },
      {
        timeout: services.env.DriverConfig.timeout.elementDisplayed,
        timeoutMsg: `Data object ${dataObject} should be set set and not empty. Actual: ${consoleResponse}`,
      },
    );
    return res;
  });
});

When(
  /I intercept request and check if in content header ([^\s]+) the value ([^\s]+) is( not)? equal to the actual value/,
  async (contentHeader: string, headerValue: string, notEqual: string) => {
    let response: any;
    try {
      response = await got.get(await browser.getUrl());
    } catch (e) {
      throw new Error(
        `Getting response headers failed with code ${
          e.response.statusCode
        }. Response body: ${JSON.stringify(e.response.body)}`,
      );
    }
    const actualHeaderValue = response.headers[`${contentHeader}`];
    const expectedValue = headerValue;
    expect(
      (actualHeaderValue === expectedValue) === !notEqual,
      `Stored value with the key should${
        notEqual || ''
      } be equal to "${expectedValue}", actual value was: "${actualHeaderValue}"`,
    ).to.be.true;
  },
);

// eslint-disable-next-line import/prefer-default-export
export const clickElement = async (element: string) => {
  const selector = await services.pageObject.getSelector(element);
  const button = await exist$(selector);
  await button.safeClick();
};

Then(
  /I simulate optimizley experiment id (.*) by updating local storage key with variation id (.*)/,
  async (experimentId: string, variationId: string) => {
    let storageIdValue = null;
    const attrValue = await browser.waitUntilResult(async () => {
      let propFilterValue = null;
      let idValue : string = null;
      const count = (await browser.execute('return localStorage.length'));
      for (let propFilterIndex = 0; propFilterIndex < count; propFilterIndex += 1) {
        // eslint-disable-next-line no-await-in-loop
        idValue = (await browser.execute(`return localStorage.key(${propFilterIndex})`));
        // eslint-disable-next-line eqeqeq
        if (idValue.includes('variation_map')) {
          // eslint-disable-next-line no-await-in-loop, max-len
          storageIdValue = (await browser.execute(`return localStorage.key(${propFilterIndex})`));
          // eslint-disable-next-line no-await-in-loop, max-len
          propFilterValue = (await browser.execute(`return JSON.parse(localStorage.getItem("${idValue}"))`));
          break;
        }
      }
      return propFilterValue;
    }, 'There is no variation_map key in local storage', 20000);
    if (attrValue != null) {
      const myJSON = JSON.stringify(attrValue);
      const currentVariantId = (JSON.parse(myJSON)[`${experimentId}`]);
      const actualVariantId = (JSON.stringify(currentVariantId).split(':')[1]).replace(/["}{}"]/g, '');
      let simulateVariant = null;
      // eslint-disable-next-line radix, no-empty
      if (parseInt(actualVariantId) === parseInt(variationId)) {

      } else {
        simulateVariant = ((JSON.stringify(attrValue)).replace(actualVariantId, variationId)).replace(/[,]/g, '');
      }
      await browser.execute(`localStorage.setItem('${storageIdValue}','${simulateVariant}');`);
      await browser.refresh();
    } else {
      throw new Error(`Cannot get values from local storage varant_map key ${attrValue}`);
    }
    await sleep(1000);
  },
);
