/* eslint-disable import/prefer-default-export */

import services from '../../core/services';

/**
 * Click when element is displayed and clickable
 * @param this
 * @param isSet set works like you type in the clear field
 * @param waitForClickable
 * @param clickOptions
 */
export async function safeType(
  this: WebdriverIO.Element, value: string, isSet: boolean = false,
  waitForIntractAble?: WebdriverIO.WaitForOptions,
): Promise<void> {
  if (value && value.length > 0) {
    try {
      if (isSet) {
        await browser.execute('return arguments[0].value = "";', this);
      }
      await (browser as any).elementClick(this.elementId);
      await (browser as any).elementSendKeys(this.elementId, value);
    } catch (e) {
      if (e instanceof Error && e.message.indexOf('interactable') > 0) {
        await this.waitForClickable(waitForIntractAble
          || services.env.DriverConfig.timeout.elementClickable);
        await (browser as any).elementSendKeys(this.elementId, value);
      } else {
        throw e;
      }
    }
  }
}

export async function getTextByJs(this: WebdriverIO.Element): Promise<string> {
  const text = await browser.execute('return arguments[0].text || arguments[0].textContent', this) as string;
  return text;
}

export async function setAttribute(
  this: WebdriverIO.Element, attributeName: string, attributeValue: string,
): Promise<void> {
  await browser.execute('arguments[0].setAttribute(arguments[1], arguments[2]);', this, attributeName, attributeValue);
}
