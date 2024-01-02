/* eslint-disable import/prefer-default-export */

import services from '../../core/services';

export async function swipeToElementMobile(
  this: WebdriverIO.Element,
) {
  if (services.env.IsMobile) {
    const deviceHeight = +(await browser.execute(`
    return Math.max(document.documentElement.clientHeight, window.innerHeight || 0)`));
    const scrollHeight = +(await browser.execute(`
    return window.pageYOffset`));
    const screenTopBorder = scrollHeight + 180;
    const screenBottomBorder = scrollHeight + deviceHeight;
    const elementPosition = (await this.getLocation()).y;
    if (!(elementPosition >= screenTopBorder && elementPosition <= screenBottomBorder)) {
      const swipeToY = (elementPosition < screenTopBorder) ? deviceHeight : 0;
      await browser.performActions([{
        type: 'pointer',
        id: 'action1',
        parameters: { pointerType: 'touch' },
        actions: [
          {
            type: 'pointerMove',
            duration: 0,
            x: 10,
            y: screenTopBorder + 100,
          },
          {
            type: 'pointerDown',
            button: 0,
          },
          {
            type: 'pointerMove',
            duration: 1000,
            x: 10,
            y: swipeToY,
          },
          {
            type: 'pointerUp',
            button: 0,
          },
        ],
      }]);
    }
  }
}
