/* eslint-disable no-console */
import {
  After, Before, setDefaultTimeout, Status, BeforeAll, ITestCaseHookParameter,
} from '@pvhqa/cucumber';
import { attach, BrowserObject, remote } from 'webdriverio';
import fs from 'fs';
import { ContentType } from 'allure-js-commons';
import {
  safeClick, jsClick, safeClickRetry,
} from '../commands/click';
import { selectDropdown } from '../commands/select';
import { setCheckbox } from '../commands/check';
import { safeType, getTextByJs, setAttribute } from '../commands/input';
import { hash } from '../../core/services/allure.service';
import SetUpWdiologger from '../../core/logger/wdio.logger';
import { GetTestLogger, SetUpTestlogger } from '../../core/logger/test.logger';
import {
  setInitCookiesAndRefresh,
  setCookiesAndRefresh,
  resetAuthCookies,
  waitUntilResult,
  deleteAuthenticationCookies,
  deleteUserActivityCookies,
  deletePersistentCookies,
  deleteGDPRCookies,
  deleteNewsletterCookies,
  waitForPageLoaded,
  scrollToWindowDirection,
  smoothScrollToWindowDirection,
  deleteAllStorage,
  getNetworkRequestNumber,
  getNetworkRequest,
  getPvhCookiesState,
  safeDeleteAllCookies,
  getGenderCookiesState,
  getOlapicCookiesState,
  setAuthCookies,
  setInitCookiesAndNavigate,
  setOnlyFunctionalCookiesAndNavigate,
  setInitStorage,
  deleteGenderCookies,
  safeTouch,
  mouseMove,
  setPaginationCookiesAndRefresh,
} from '../commands/browser';
import services from '../../core/services';
import { hover } from '../commands/hover';
import { swipeToElementMobile } from '../commands/swipe';
import { smoothScrollToElement } from '../commands/scroll';
import consoleLog from '../../core/logger/console.logger';
import { KEY_BROWSER_WIDTH } from '../../core/world-key';
import { XCOMREG } from '../../core/constents';

/** Enable insure ssl request */
process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

/** Set cucumber step default timeout */
setDefaultTimeout(services.env.DriverConfig.timeout.step);

/** Reassign Global */
const thisGlobal = global as any;

const getDriver = async (options: WebdriverIO.RemoteOptions, timeout) => {
  if (process.env.CUCUMBER_PARALLEL === 'true') {
    // Use shared session only if in parallel mode
    GetTestLogger().info('[Before] This is a reused session');
    const attachSessionOptions = await services.drivers.takeDriver(options, timeout);
    if (!attachSessionOptions || !attachSessionOptions.sessionId) {
      consoleLog('Unable to get the session!!!');
      throw new Error('Unable to get the session');
    }
    return attach(attachSessionOptions);
  }
  GetTestLogger().info('[Before] This is a new session');
  const { connectionRetryCount } = options;
  options.connectionRetryCount = 0;
  const driver = await remote(options);
  options.connectionRetryCount = connectionRetryCount;
  await driver.setTimeout(timeout);
  return driver;
};

const releaseDriver = async () => {
  if (browser && browser.sessionId) {
    if (process.env.CUCUMBER_PARALLEL === 'true') {
      await browser.safeDeleteAllCookies();
      await services.drivers.releaseDriver(browser.sessionId);
    } else {
      await browser.deleteSession();
    }
  }
};

const getTestUniqueNamePathFormat = (testUniqueName: string) => testUniqueName.replace(/[^a-zA-Z0-9]/g, '_');

const testStart = async (_browser: WebdriverIO.BrowserObject, testName: string) => {
  const currentRetry = _browser.options.connectionRetryCount;
  _browser.options.connectionRetryCount = 0;
  await _browser.addCookie(
    {
      name: 'testStart',
      value: getTestUniqueNamePathFormat(testName),
    },
  ).catch(() => {
  });
  _browser.options.connectionRetryCount = currentRetry;
};

const testStop = async (_browser: WebdriverIO.BrowserObject, testName: string) => {
  const currentRetry = _browser.options.connectionRetryCount;
  _browser.options.connectionRetryCount = 0;
  await _browser.addCookie(
    {
      name: 'testStop',
      value: getTestUniqueNamePathFormat(testName),
    },
  ).catch(() => {
  });
  _browser.options.connectionRetryCount = currentRetry;
};

/**
 * First defined will have high priority when stragy has same applied page path
 */
BeforeAll(async () => {
  // One Page Checkout strategy
  services.pageObjectStragety.addStrategy({
    brand: '*',
    strategyName: 'OnePageCheckout',
    conditionFunc: async () => {
      const onePageCheckoutEnabled = await services.othersDB.GetXComReg(
        XCOMREG.ToggleEnabledOnePageCheckout,
      );
      return onePageCheckoutEnabled.toLowerCase() === 'true';
    },
    appliedPagePathList: [
      'Checkout.SignInPage'],
    applyFunc: (pagePath: string) => {
      const parts = pagePath.split('.');
      if (parts.length === 2) {
        return `${parts[0]}.OPC${parts[1]}`;
      }
      if (parts.length === 1) {
        return `OPC${parts[0]}`;
      }
      throw new Error(`Failed to apply unified checkout strategy for page ${pagePath}`);
    },
    enabled: true,
  });
});

Before(async function (scenario: ITestCaseHookParameter) {
  await fs.promises.mkdir(`./output/${scenario.testCaseStartedId}`, { recursive: true });
  SetUpWdiologger(
    `./output/${scenario.testCaseStartedId}/wdio.log`,
    services.env.DriverConfig.options.logLevel,
  );
  SetUpTestlogger(
    `./output/${scenario.testCaseStartedId}/test.log`,
    'info',
  );
  GetTestLogger().info('[Before] Start');
  this.store = new Map();
  services.account.cleanUp();
  services.product.cleanUp();
  services.checkoutaddress.cleanUp();
  services.world.init(this);
  this.testUniqueName = `${scenario.pickle.name}_${hash(scenario.testCaseStartedId)}`;
  // services.env.DriverConfig.options.capabilities['zal:name'] = this.testUniqueName;
  consoleLog(`===> ${this.testUniqueName}`);

  GetTestLogger().info('[Before] Starting/Retrieving test session');
  const browser = await getDriver(
    services.env.DriverConfig.options, services.env.DriverConfig.timeout,
  );
  if (services.env.DriverName.toLowerCase().includes('safari')) {
    browser.maximizeWindow();
  }
  browser.addCommand('jsClick', jsClick, true);
  browser.addCommand('safeClick', safeClick, true);
  browser.addCommand('safeClickRetry', safeClickRetry, true);
  browser.addCommand('selectDropdown', selectDropdown, true);
  browser.addCommand('setCheckbox', setCheckbox, true);
  browser.addCommand('safeType', safeType, true);
  browser.addCommand('setAttribute', setAttribute, true);
  browser.addCommand('hover', hover, true);
  browser.addCommand('getTextByJs', getTextByJs, true);
  browser.addCommand('swipeToElementMobile', swipeToElementMobile, true);
  browser.addCommand('smoothScrollToElement', smoothScrollToElement, true);
  browser.addCommand('waitForPageLoaded', waitForPageLoaded, false);
  browser.addCommand('setInitStorage', setInitStorage, false);
  browser.addCommand('setInitCookiesAndRefresh', setInitCookiesAndRefresh, false);
  browser.addCommand('setPaginationCookiesAndRefresh', setPaginationCookiesAndRefresh, false);
  browser.addCommand('setInitCookiesAndNavigate', setInitCookiesAndNavigate, false);
  browser.addCommand('setOnlyFunctionalCookiesAndNavigate', setOnlyFunctionalCookiesAndNavigate, false);
  browser.addCommand('setAuthCookies', setAuthCookies, false);
  browser.addCommand('setCookiesAndRefresh', setCookiesAndRefresh, false);
  browser.addCommand('resetAuthCookies', resetAuthCookies, false);
  browser.addCommand('getPvhCookiesState', getPvhCookiesState, false);
  browser.addCommand('waitUntilResult', waitUntilResult, false);
  browser.addCommand('deleteAuthenticationCookies', deleteAuthenticationCookies, false);
  browser.addCommand('deletePersistentCookies', deletePersistentCookies, false);
  browser.addCommand('deleteUserActivityCookies', deleteUserActivityCookies, false);
  browser.addCommand('deleteGDPRCookies', deleteGDPRCookies, false);
  browser.addCommand('deleteGenderCookies', deleteGenderCookies, false);
  browser.addCommand('deleteNewsletterCookies', deleteNewsletterCookies, false);
  browser.addCommand('deleteAllStorage', deleteAllStorage, false);
  browser.addCommand('scrollToWindowDirection', scrollToWindowDirection, false);
  browser.addCommand('smoothScrollToWindowDirection', smoothScrollToWindowDirection, false);
  browser.addCommand('getNetworkRequestNumber', getNetworkRequestNumber, false);
  browser.addCommand('getNetworkRequest', getNetworkRequest, false);
  browser.addCommand('safeDeleteAllCookies', safeDeleteAllCookies, false);
  browser.addCommand('getGenderCookiesState', getGenderCookiesState, false);
  browser.addCommand('getOlapicCookiesState', getOlapicCookiesState, false);
  browser.addCommand('safeTouch', safeTouch, false);
  browser.addCommand('mouseMove', mouseMove, false);

  thisGlobal.browser = browser;
  thisGlobal.$ = async (selector) => thisGlobal.browser.$(selector);
  thisGlobal.$$ = async (selector) => thisGlobal.browser.$$(selector);
  services.pageObjectStragety.resetAllStrategy();

  // Only for local run
  if (process.env.CUCUMBER_PARALLEL !== 'true') {
    const innerWidth = await browser.execute('return window.innerWidth') as string;
    services.world.store(KEY_BROWSER_WIDTH, parseInt(innerWidth, 10));
  }
  await testStart(browser, this.testUniqueName);
  GetTestLogger().info(`[Before] Session ID ${browser.sessionId}`);
  GetTestLogger().info('[Before] Complete');
});

// Before Hooks for Firefox
Before({ tags: '@FireFox' }, async () => {
  if (services.env.IsFireFox) {
    await browser.mouseMove(0, 0);
  }
});

After(async function (scenario: ITestCaseHookParameter) {
  if (this.testUniqueName) {
    consoleLog(`<=== ${this.testUniqueName}`);
  }
  if (browser) {
    browser.options.connectionRetryCount = 0;
    browser.options.connectionRetryTimeout = 30000;
    if (services.env.DriverName.toLowerCase().includes('browserstack')) {
      if (scenario.result.status === Status.PASSED) {
        services.browserstackService.setTestStatus(browser.sessionId,
          'PASSED', 'Test Passed');
      } else {
        services.browserstackService.setTestStatus(browser.sessionId,
          'FAILED', 'Test Failed. Please check logs for reason.');
      }
    }
    try {
      // Remove chromium command
      if (this.store.get('@addScriptToEvaluateOnNewDocument')) {
        const resp = await services.chromium.sendRequest(
          services.env.RemoteServerUrl,
          browser.sessionId,
          'Page.removeScriptToEvaluateOnNewDocument',
          this.store.get('@addScriptToEvaluateOnNewDocument'),
        );
        GetTestLogger().info(`Remove chromium with ${JSON.stringify(resp.body)}`);
      }
      let cookies: WebDriver.Cookie[];
      if (scenario.result.status === Status.FAILED) {
        try {
          cookies = await browser.getAllCookies() as Array<WebDriver.Cookie>;
          GetTestLogger().info(`Cookies: ${JSON.stringify(cookies)}`);
        } catch (e) {
          GetTestLogger().error(`Get browser cookies failed because ${e}`);
        }

        if (process.env.CUCUMBER_PARALLEL === 'true' && cookies && cookies.length > 0 && process.env.NO_ALLURE !== 'true') {
          const base64encodedStr = await browser.takeScreenshot();
          await services.allure.testAddAttchmentBase64(scenario.testCaseStartedId, 'screenshot', base64encodedStr, ContentType.PNG);
        }
        // TODO: currently Device Lab dashboard can not support to show shared session.
        // await browser.addCookie(
        //   {
        //     name: 'zaleniumTestPassed',
        //     value: 'false',
        //   },
        // )
        //   .catch((reason: any) => {
        //     GetTestLogger().error(`Add cookie of zalenium test result failed.${reason}`);
        //   });
      }
      await testStop(browser as BrowserObject, this.testUniqueName);
    } catch (e) {
      GetTestLogger().warn(`After failed: ${e}`);
    } finally {
      await releaseDriver();
    }
  }
  if (process.env.CUCUMBER_PARALLEL === 'true' && process.env.NO_ALLURE !== 'true') {
    const wdioLogFile: string = `./output/${scenario.testCaseStartedId}/wdio.log`;
    if (fs.existsSync(wdioLogFile)) {
      await services.allure.testAddAttchmentFilePath(scenario.testCaseStartedId, 'wdio-log', wdioLogFile);
    } else {
      console.error(`Cannot attach wdio log file because ${wdioLogFile} does not exist`);
    }
    const testLogFile = `./output/${scenario.testCaseStartedId}/test.log`;
    if (fs.existsSync(testLogFile)) {
      await services.allure.testAddAttchmentFilePath(scenario.testCaseStartedId, 'test-log', testLogFile);
    } else {
      console.error(`Cannot attach test log file because ${testLogFile} does not exist`);
    }
    await Promise.all([
      services.allure.testAddLink(scenario.testCaseStartedId, `${services.env.RemoteServerUrl}/dashboard/${getTestUniqueNamePathFormat(this.testUniqueName)}.mp4`, 'Recorded video', 'video/mp4'),
      services.allure.testAddLink(scenario.testCaseStartedId, `${services.env.RemoteServerUrl}/dashboard/${getTestUniqueNamePathFormat(this.testUniqueName)}.log`, 'Grid log', 'text/plain'),
    ]);
  }
});

After({ tags: '@MultipleTabs' }, async () => {
  try {
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
  } catch (e) {
    GetTestLogger().info(`Failed to close open tabs in after hook. Error raised: ${e}`);
  }
});

After({ tags: '@IFrame' }, async () => {
  try {
    await browser.switchToFrame(null);
  } catch (e) {
    GetTestLogger().info(`Failed to switch back from iframe to main content. Error raised: ${e}`);
  }
});

After({ tags: '@ClearLocalStorage' }, async () => {
  try {
    await browser.execute(() => {
      localStorage.clear();
    });
  } catch (e) {
    GetTestLogger().info(`Failed to clear local storage. Error raised: ${e}`);
  }
});

After({ tags: '@ScreenResize' }, async () => {
  try {
    if (services.env.IsDesktop) {
      await browser.setWindowSize(1440, 1080);
      GetTestLogger().info('Window size is restored to default');
    }
  } catch (e) {
    GetTestLogger().info(`Failed to maximize screen size. Error raised: ${e}`);
  }
});

After({ tags: '@Adyen' }, async (scenario: ITestCaseHookParameter) => {
  GetTestLogger().info('BRAND', services.env.Brand.toUpperCase());
  const testLogFile = `./output/${scenario.testCaseStartedId}/test.log`;
  if (fs.existsSync(testLogFile) && (scenario.result.status === Status.PASSED)) {
    await fs.promises.mkdir('./output/AdyenOrderScreenshots', { recursive: true });
    await browser.saveScreenshot(`./output/AdyenOrderScreenshots/${scenario.testCaseStartedId}.png`);
    GetTestLogger().info('Screenshot ID', `${scenario.testCaseStartedId}.png`);
    fs.readFile(testLogFile, 'utf-8', (_err, contents) => {
      fs.appendFile('./test.log', contents, (err) => {
        if (err) throw err;
      });
    });
  }
});
