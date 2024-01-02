/* eslint-disable import/prefer-default-export */

import services from '../../core/services';
import { sleep } from '../helper/utils.helper';
import { Selector, DropdownSelector } from '../../core/constents';
import { ensureSelector } from '../general';

/**
 * Click when element is displayed and clickable
 * @param this
 * @param waitForClickable
 * @param clickOptions
 */
export async function safeClick(
  this: WebdriverIO.Element, waitForClickable?: WebdriverIO.WaitForOptions,
  clickOptions?: WebdriverIO.ClickOptions,
) {
  try {
    await browser.waitForPageLoaded();
    await this.click(clickOptions);
  } catch (e) {
    await this.waitForClickable(
      waitForClickable || services.env.DriverConfig.timeout.elementClickable,
    );
    await this.click(clickOptions);
  }
}

export async function safeClickRetry(
  this: WebdriverIO.Element,
  displayedElementSelector: Selector | DropdownSelector,
) {
  await this.safeClick();
  const locator = await ensureSelector(displayedElementSelector);
  const ele = await $(locator);
  return browser.waitUntil(async () => {
    let interacted = await ele.isExisting();
    if (!interacted) {
      await sleep(1000);
      interacted = await ele.isExisting();
    }
    if (interacted) {
      interacted = await ele.isDisplayed();
    }
    if (!interacted) {
      await this.click();
    }
    return interacted;
  },
  {
    timeout: 15000,
    timeoutMsg: 'click failed because condition is always failed after click',
    interval: 1500,
  });
}

export async function jsClick(this: WebdriverIO.Element) {
  await browser.execute((element) => {
    element.click();
  }, this);
}
