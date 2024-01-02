/* eslint-disable import/prefer-default-export */

import { exist$ } from '../general';
import { sleep } from '../helper/utils.helper';

export async function selectDropdown(
  this: WebdriverIO.Element,
  optionLocator: string,
  byJs: boolean = false,
  bySimpleClick: boolean = false,
) {
  await this.scrollIntoView({ block: 'center' });
  await this.safeClick();
  const option = await exist$(optionLocator);
  await sleep(500);
  if (byJs) {
    await option.jsClick();
  } else if (bySimpleClick) {
    await option.scrollIntoView();
    await option.click();
  } else {
    await option.safeClick();
  }
}
