import { When, Then } from '@pvhqa/cucumber';
import { expect } from 'chai';
import services from '../../../core/services';
import { XCOMREG } from '../../../core/constents';
import { GetTestLogger } from '../../../core/logger/test.logger';

const sessionStorageName = 'fhtest';
const fhInject = `window.fht = function(event_name, data) {
  window.fht_events.push({name: event_name, data: data});
  if(sessionStorage.getItem('${sessionStorageName}')) {
        var list = JSON.parse(sessionStorage.getItem('${sessionStorageName}'));
        list.push({name: event_name, data: data});
        sessionStorage.setItem('${sessionStorageName}', JSON.stringify(list));
  } else {
        sessionStorage.setItem('${sessionStorageName}', JSON.stringify(window.fht_events));
  }
}
function testHanlder() {
  var fh_ele = document.querySelector('script[src*="/fh.js"]');
  fh_ele.setAttribute('src', '');
}
if(window.self === window.top) {
  window.fht_events = [];
  document.removeEventListener('DOMContentLoaded', testHanlder);
  document.addEventListener('DOMContentLoaded', testHanlder);
}`;

When(/I inject FH tracker listener?/, async () => {
  if ((browser.options.capabilities as any).browserName !== 'chrome') {
    throw new Error('FH Tracker listener only can be injected to Chrome');
  }
  await browser.execute((name) => {
    if (sessionStorage.getItem(name)) {
      sessionStorage.removeItem(name);
    }
  }, sessionStorageName);
  const resp = await services.chromium.sendRequest(
    services.env.RemoteServerUrl,
    browser.sessionId,
    'Page.addScriptToEvaluateOnNewDocument',
    {
      source: fhInject,
    },
  );
  if (!resp || !resp.body || !resp.body.value) {
    throw new Error('Inject FH failed because the response body is invalid');
  }
  GetTestLogger().info(`Injected addScriptToEvaluateOnNewDocument ${JSON.stringify(resp.body.value)}`);
  services.world.store('@addScriptToEvaluateOnNewDocument', resp.body.value);
});

Then(/the (\d+)(?:st|nd|rd|th) received FH event is Setup Event/, async (index: number) => {
  index -= 1;
  const appId = await services.othersDB.GetXComReg(XCOMREG.FHTrackerAppID);
  const storage:Array<any> = await browser.waitUntilResult(async () => {
    const s:Array<any> = await browser.execute(`return JSON.parse(sessionStorage.getItem("${sessionStorageName}"))`);
    return s && s[index] ? s : null;
  }, `Setup event is not received by index ${index}`);
  GetTestLogger().info(`FH events: ${JSON.stringify(storage)}`);
  expect(storage, 'no event recorded').not.to.be.null;
  expect(storage.length > 0, 'no event recoreded, empty result').to.be.true;
  expect(storage[index].name).to.equal('setUp');
  expect(storage[index].data).not.to.be.undefined;
  expect(storage[index].data.appId).to.equal(appId);
  expect(storage[index].data.anonymous).to.be.false;
  expect(storage[index].data.persistent).to.be.true;
});

Then(/the (\d+)(?:st|nd|rd|th) received FH event is Page View Event of (Product List|Product|Wish List) page/, async (index: number, pageType: string) => {
  index -= 1;
  // let originId = '';
  // switch (pageType) {
  //   case 'Product List':
  //     originId = await browser.waitUntilResult(async () => {
  //       const result:string = await browser.execute('return window.app.productList.resultId');
  //       return result;
  //     }, 'Cannot get window.app.productList.resultId', 15000);
  //     break;
  //   case 'Product':
  //     originId = await browser.waitUntilResult(async () => {
  //       const result:string = await browser.execute('return window.app.product.resultId');
  //       return result;
  //     }, 'Cannot get window.app.product.resultId', 15000);
  //     break;
  //   default:
  // }
  const storage:Array<any> = await browser.waitUntilResult(async () => {
    const s:Array<any> = await browser.execute(`return JSON.parse(sessionStorage.getItem("${sessionStorageName}"))`);
    return s && s[index] ? s : null;
  });
  GetTestLogger().info(`FH events: ${JSON.stringify(storage)}`);
  expect(storage, 'no event recorded').not.to.be.null;
  expect(storage.length > 0, 'no event recoreded, empty result').to.be.true;
  expect(storage[index].name).to.equal('fhr:view');
  expect(storage[index].data).not.to.be.undefined;
  if (pageType === 'Wish List') {
    expect(storage[index].data.originId.length > 0).to.be.true;
  }
});

Then(/the (\d+)(?:st|nd|rd|th) received FH event is PLP item click follow event/, async (index: number) => {
  index -= 1;
  const productId = await browser.waitUntilResult(async () => {
    const result:string = await browser.execute('return window.app.product?.productId || window.app.pdpData?.data?.catentryId');
    return result;
  }, 'Cannot get window.app.productList.resultId', 15000);

  const storage:Array<any> = await browser.waitUntilResult(async () => {
    const s:Array<any> = await browser.execute(`return JSON.parse(sessionStorage.getItem("${sessionStorageName}"))`);
    return s && s[index] ? s : null;
  });
  GetTestLogger().info(`FH events: ${JSON.stringify(storage)}`);
  expect(storage, 'no event recorded').not.to.be.null;
  expect(storage.length > 0, 'no event recoreded, empty result').to.be.true;
  expect(storage[index], `the event in position ${index + 1} is not exist`).not.to.be.undefined;
  expect(storage[index].name).to.equal('fhr:follow');
  expect(storage[index].data).not.to.be.undefined;
  expect(storage[index].data.type).to.equal('lister-item');
  expect(storage[index].data.element).to.equal('');
  expect(storage[index].data.value).to.equal(`p${productId}`);
});

Then(/the (\d+)(?:st|nd|rd|th) received FH event is Facet click follow event(?: of min price ([^\s+]) and max price ([^\s+]))?/, async (index: number, minPrice?: string, maxPrice?: string) => {
  if (minPrice) {
    minPrice = services.world.parse(minPrice);
    [minPrice] = minPrice.match(/(-\d+|\d+)(,\d+)*(\.\d+)*/g);
  }
  if (maxPrice) {
    maxPrice = services.world.parse(maxPrice);
    [maxPrice] = maxPrice.match(/(-\d+|\d+)(,\d+)*(\.\d+)*/g);
  }
  index -= 1;
  const storage:Array<any> = await browser.waitUntilResult(async () => {
    const s:Array<any> = await browser.execute(`return JSON.parse(sessionStorage.getItem("${sessionStorageName}"))`);
    return s && s[index] ? s : null;
  });
  GetTestLogger().info(`FH events: ${JSON.stringify(storage)}`);
  expect(storage, 'no event recorded').not.to.be.null;
  expect(storage.length > 0, 'no event recoreded, empty result').to.be.true;
  expect(storage[index], `the event in position ${index + 1} is not exist`).not.to.be.undefined;
  expect(storage[index].name).to.equal('fhr:follow');
  expect(storage[index].data).not.to.be.undefined;
  expect(storage[index].data.type).to.equal('facet');
  if (minPrice && maxPrice) {
    expect(storage[index].data.value).contains(Number(minPrice));
    expect(storage[index].data.value).contains(Number(maxPrice));
  } else {
    expect(storage[index].data.value.length > 0).to.be.true;
  }
});

Then(/the (\d+)(?:st|nd|rd|th) received FH event is Add To Basket event with quantity ([^\s]+)/, async (index: number, _quantity: string) => {
  index -= 1;
  _quantity = services.world.parse(_quantity);
  const quantity = Number(_quantity);
  const storage:Array<any> = await browser.waitUntilResult(async () => {
    const s:Array<any> = await browser.execute(`return JSON.parse(sessionStorage.getItem("${sessionStorageName}"))`);
    return s && s[index] ? s : null;
  });
  GetTestLogger().info(`FH events: ${JSON.stringify(storage)}`);
  expect(storage, 'no event recorded').not.to.be.null;
  expect(storage.length > 0, 'no event recoreded, empty result').to.be.true;
  expect(storage[index], `the event in position ${index + 1} is not exist`).not.to.be.undefined;
  expect(storage[index].name).to.equal('fhr:basketAdd');
  expect(storage[index].data).not.to.be.undefined;
  expect(storage[index].data.productId.length > 0).to.be.true;
  expect((storage[index].data.productId as string).startsWith('p')).to.be.true;
  expect(storage[index].data.quantity.toString()).to.equal(quantity.toString());
});
