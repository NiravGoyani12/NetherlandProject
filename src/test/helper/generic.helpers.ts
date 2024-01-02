/* eslint-disable max-len */
import services from '../../core/services';
import { whenPageLoaded } from '../general';

// eslint-disable-next-line import/prefer-default-export
export const swipeGesture = async (pickerElement: WebdriverIO.Element, direction: string, x: number) => {
  const directionIndex = direction === 'left' ? -1 : 1;
  await browser.performActions([{
    type: 'pointer',
    id: 'action1',
    parameters: { pointerType: services.env.IsDesktop ? 'mouse' : 'touch' },
    actions: [
      {
        type: 'pointerMove',
        origin: pickerElement,
        duration: 0,
        x: 0,
        y: 0,
      },
      {
        type: 'pointerDown',
        button: 0,
      },
      {
        type: 'pause',
        duration: 0,
      },
      {
        type: 'pointerMove',
        duration: 0,
        origin: pickerElement,
        x: x * directionIndex,
        y: 0,
      },
      {
        type: 'pointerUp',
        button: 0,
      },
    ],
  }]);
};

export const waitForNetworkRequest = async (requestType: string, partialRequestName: string) => {
  const timeout = 8000;
  let actualRequestNumber: number;
  return whenPageLoaded(async () => {
    const res = await browser.waitUntil(
      async () => {
        actualRequestNumber = await browser.getNetworkRequestNumber(
          requestType,
          partialRequestName,
        );
        return actualRequestNumber === 1;
      },
      {
        timeout,
        timeoutMsg: `Number of network requests for ${partialRequestName} is not correct. Expected: 1 request, Actual number was: ${actualRequestNumber}`,
      },
    );
    return res;
  });
};
