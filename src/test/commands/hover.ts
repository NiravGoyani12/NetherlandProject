/* eslint-disable import/prefer-default-export */

import services from '../../core/services';

export async function hover(
  this: WebdriverIO.Element,
  timeout?: number,
) {
  if (!services.env.IsDesktop) {
    throw new Error('Hover function only support Desktop');
  }
  await this.waitForDisplayed(
    {
      timeout: timeout || browser.options.waitforTimeout,
    },
  );
  if (services.env.IsFireFox) {
    await browser.performActions([{
      type: 'pointer',
      id: 'action1',
      parameters: { pointerType: 'mouse' },
      actions: [
        {
          type: 'pointerMove',
          duration: 0,
          x: 0,
          y: 0,
        },
        {
          type: 'pause',
          duration: 100,
        },
        {
          type: 'pointerMove',
          origin: this,
          duration: 300,
          x: 0,
          y: 0,
        },
        {
          type: 'pause',
          duration: 1500,
        },
      ],
    }]);
  } else {
    await browser.performActions([{
      type: 'pointer',
      id: 'action1',
      parameters: { pointerType: 'mouse' },
      actions: [
        {
          type: 'pointerMove',
          origin: this,
          duration: 0,
          x: 0,
          y: 0,
        },
        {
          type: 'pause',
          duration: 1000,
        },
      ],
    }]);
  }
  await browser.releaseActions();
}
