/* eslint-disable no-await-in-loop */
/* eslint-disable import/prefer-default-export */
import services from '../../core/services';
import {
  maybeDisplayed$, maybeExist$$, exist$,
} from '../general';
import { sleep } from './utils.helper';

export const SelectSizeInSizeSelector = async (sizeState: string, sizePosition: string) => {
  const availableSizes = sizeState === 'in stock'
    ? await maybeExist$$('SizeSelectorFlyout.SizesInStock')
    : await maybeExist$$('SizeSelectorFlyout.SizesOOS');
  if (availableSizes.length > 0) {
    const sizeIndex = sizePosition && sizePosition === ' last' ? availableSizes.length - 1 : 0;
    if (services.env.IsDesktop) {
      await availableSizes[sizeIndex].safeClick();
    } if (services.env.IsMobile) {
      await availableSizes[sizeIndex].scrollIntoView();
      await availableSizes[sizeIndex].jsClick();
      if (sizeState === 'oos') {
        (await maybeDisplayed$('SizeSelectorFlyout.MobileNotifyMeButton')).safeClick();
      }
    }
  } else {
    throw new Error(`No ${sizeState} sizes found`);
  }
};

export const CloseSizeSelector = async () => {
  await (await exist$('SizeSelectorFlyout.CloseButton')).safeClick();
  await sleep(1000);
  await browser.waitUntil(async () => (
    await maybeExist$$('SizeSelectorFlyout.MainBlock', undefined, 2000)).length === 0, { timeout: services.env.DriverConfig.timeout.elementDisplayed, timeoutMsg: 'Size selector was not closed' });
  await sleep(1000);
};
