import { When, Then } from '@pvhqa/cucumber';
import { expect } from 'chai';
import services from '../../core/services';
import { GetTestLogger } from '../../core/logger/test.logger';

interface CustomEvent {
  type: string,
  detail: any
}

const customEventInject = (eventNameList: string[]) => `
window.custom_events = [];
function customEventHanlder(e) {
  var event = {
    type: e.type,
    detail: e.detail
  }
  window.custom_events.push(event);
}
if(window.self === window.top) {
  ${eventNameList.map((eventName) => `document.addEventListener("${eventName}", customEventHanlder)`).join(';\n')};
}`;

When(/I inject custom event listener of events? ([^\s]+)/, async (eventNameList: string) => {
  const source = customEventInject(eventNameList.split(','));
  const resp = await services.chromium.sendRequest(
    services.env.RemoteServerUrl,
    browser.sessionId,
    'Page.addScriptToEvaluateOnNewDocument',
    {
      source,
    },
  );
  if (!resp || !resp.body || !resp.body.value) {
    throw new Error('Inject Custome Event listener failed because the response body is invalid');
  }
  GetTestLogger().info(`Injected addScriptToEvaluateOnNewDocument ${JSON.stringify(resp.body.value)}`);
  services.world.store('@addScriptToEvaluateOnNewDocument', resp.body.value);
});

When(/I clear recorded custom events/, async () => {
  await browser.execute('window.custom_events = []');
});

Then(/I should receive custome event ([^\s]+)/, async (eventName: string) => {
  const storage:Array<CustomEvent> = await browser.waitUntilResult(async () => {
    const s:Array<CustomEvent> = await browser.execute('return window.custom_events');
    const r = s.filter((e) => e.type === eventName);
    return r && r.length > 0 ? s : undefined;
  }, `No custom event ${eventName} catched`, 5000);
  GetTestLogger().info(`Custom events: ${JSON.stringify(storage)}`);
  const recievedEventList = storage.filter((e) => e.type === eventName);
  expect(recievedEventList, `custom event ${eventName} should be recieved only one time`).lengthOf(1);
  expect(recievedEventList[0].detail).not.to.be.null;
});
