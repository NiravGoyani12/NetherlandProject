import { Container } from 'typescript-ioc';
import services from '../core/services';
import {
  Selector, DropdownSelector, isDropDownSelector, REVERSE_CHECK,
} from '../core/constents';
import { Page } from './page';
import { sleep } from './helper/utils.helper';
import { GetTestLogger } from '../core/logger/test.logger';

export async function ensureSelector(
  selector: Selector | DropdownSelector | string,
): Promise<Selector> {
  if (isDropDownSelector(selector)) {
    return selector.dropdownSelector;
  }
  if (selector.startsWith('(') || selector.startsWith('//') || selector.indexOf('=') > 0 || selector.startsWith('.') || selector.startsWith('#')) {
    return selector;
  }
  return await services.pageObject.getSelector(selector) as Selector;
}

export function p$<T extends Page>(source: Function & { prototype: T; }): T {
  return Container.get(source);
}

export async function whenPageLoaded<T>(func: () => Promise<T>) {
  let result: T;
  let checkPageLoad = false;
  try {
    result = await func();
  } catch (e) {
    checkPageLoad = true;
  }
  if (checkPageLoad) {
    await (browser as any).waitForPageLoaded();
    result = await func();
  }
  return result;
}

export async function exist$(
  selector: Selector | string | DropdownSelector, timeout?: number,
): Promise<WebdriverIO.Element> {
  selector = await ensureSelector(selector);
  const ele = await $(selector);
  if ((ele as any).error) {
    await whenPageLoaded<boolean>(async () => {
      const existed = await browser.waitUntil(
        async () => ele.isExisting(),
        {
          timeout: timeout || services.env.DriverConfig.timeout.elementExist,
          timeoutMsg: `The ${selector} does not exist`,
          interval: 500,
        },
      );
      return existed;
    });
  }
  return ele as WebdriverIO.Element;
}

export async function exist$$(
  selector: Selector | string | DropdownSelector, expectedCount?: number, timeout?: number,
): Promise<Array<WebdriverIO.Element>> {
  selector = await ensureSelector(selector);
  timeout = timeout || services.env.DriverConfig.timeout.elementExist;
  if (expectedCount) {
    await browser.waitUntil(async () => {
      const eles = await $$(selector as string);
      return eles.length === expectedCount;
    },
    {
      timeout,
      timeoutMsg: `Cannot get ${expectedCount} multiple elements`,
    });
  } else {
    await browser.waitUntil(async () => {
      const eles = await $$(selector as string);
      return eles.length > 0;
    }, {
      timeout,
      timeoutMsg: 'Cannot get at least one element',
    });
  }
  await browser.waitUntil(async () => {
    const eles = await $$(selector as string);
    const elementsWithError = [];
    eles.forEach((ele) => {
      if ((ele as any).error) {
        elementsWithError.push(ele);
      }
    });
    const results = await Promise.all(elementsWithError.map((e) => e.waitForExist()));
    return results.find((isExist) => !isExist) === undefined;
  }, { timeout });
  const res = await $$(selector);
  return res;
}

export async function scrollDownUntilExist$(
  selector: Selector | string | DropdownSelector,
  stepPixels: number,
  timeout?: number,
  interval?: number,
) {
  selector = await ensureSelector(selector);
  const ele = await $(selector);
  if ((ele as any).error) {
    await whenPageLoaded<boolean>(async () => {
      const existed = await browser.waitUntil(async () => {
        let isExist = await ele.isExisting();
        if (!isExist) {
          await browser.execute(`window.scrollBy(0, ${stepPixels});`);
        }
        await sleep(800);
        isExist = await ele.isExisting();
        return isExist;
      }, { timeout: timeout || 20000, timeoutMsg: 'The element is still not visible', interval: interval || 1000 });
      return existed;
    });
  }
  return ele as WebdriverIO.Element;
}

export async function maybeExist$(
  selector: Selector | string | DropdownSelector, timeout?: number,
): Promise<WebdriverIO.Element | null> {
  try {
    const ele = await exist$(selector, timeout);
    return ele;
  } catch (e) {
    GetTestLogger().error(`Error in maybeExist$: ${e}`);
    return null;
  }
}

/**
 * if it is not exist, it will return null, otherwise it will return the exist ele
 * @param selector
 * @param timeout
 */
export async function maybeNotExist$(
  selector: Selector | string | DropdownSelector, timeout?: number,
): Promise<WebdriverIO.Element | null> {
  selector = await ensureSelector(selector);
  await (browser as any).waitForPageLoaded();
  const ele = await $(selector);
  if ((ele as any).error) {
    if ((ele as any).error.error.indexOf('no such element') >= 0) {
      return null;
    }
    throw new Error(`Get element failed for ${selector}, with error ${JSON.stringify((ele as any).error)}`);
  }
  try {
    await ele.waitForExist({ timeout, reverse: REVERSE_CHECK });
    return null;
  } catch {
    return ele;
  }
}

export async function maybeExist$$(
  selector: Selector | string | DropdownSelector, expectedCount?: number, timeout?: number,
): Promise<Array<WebdriverIO.Element>> {
  try {
    const eles = await exist$$(selector, expectedCount, timeout);
    return eles;
  } catch (e) {
    GetTestLogger().error(`MaybeExist failed because of:  ${e}`);
    return [];
  }
}

export async function maybeDisplayed$(
  selector: Selector | string | DropdownSelector, timeout?: number,
): Promise<WebdriverIO.Element | null> {
  try {
    const ele = await maybeExist$(selector, timeout);
    if (ele
      && await ele.waitForDisplayed(
        { timeout: timeout || services.env.DriverConfig.timeout.elementDisplayed },
      )) {
      return ele;
    }
    return null;
  } catch (e) {
    return null;
  }
}

export async function maybeDisplayed$$(
  selector: Selector | string | DropdownSelector, expectedCount?: number, timeout?: number,
): Promise<Array<WebdriverIO.Element>> {
  try {
    const eles = await maybeExist$$(selector, expectedCount, timeout);
    const elesIsDisplayedPromise = [];
    eles.forEach((e) => elesIsDisplayedPromise.push(e.isDisplayed()));
    const elesIsDisplayed = await Promise.all(elesIsDisplayedPromise);
    const displayedEles = [];
    for (let i = 0; i < eles.length; i += 1) {
      if (elesIsDisplayed[i]) {
        displayedEles.push(eles[i]);
      }
    }
    return displayedEles;
  } catch (e) {
    return [];
  }
}

export async function maybeInViewport$(
  selector: Selector | string | DropdownSelector, timeout?: number,
): Promise<WebdriverIO.Element | null> {
  try {
    const ele = await maybeExist$(
      selector, timeout || services.env.DriverConfig.timeout.elementExist,
    );
    if (ele
      && await ele.waitForDisplayed(
        { timeout: timeout || services.env.DriverConfig.timeout.elementDisplayed },
      )) {
      await browser.waitUntil(async () => {
        const isInViewport = await ele.isDisplayedInViewport();
        return isInViewport;
      }, { timeout: timeout || services.env.DriverConfig.timeout.elementDisplayed });
      return ele;
    }
    return null;
  } catch (e) {
    return null;
  }
}

export async function waitAndClickElement$(
  selector: Selector | string | DropdownSelector, timeout?: number,
): Promise<WebdriverIO.Element | null> {
  try {
    const ele = await exist$(selector, timeout);
    ele.waitForClickable({ timeout: 3000 });
    ele.isDisplayedInViewport();
    await ele.safeClick();
    return ele;
  } catch (e) {
    GetTestLogger().error(`Error in maybeExist$: ${e}`);
    return null;
  }
}
