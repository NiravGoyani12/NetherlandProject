import { expect } from 'chai';
import { Page } from '../../src/test/page';
import services from '../../src/core/services';
import { KEY_BROWSER_WIDTH } from '../../src/core/world-key';


class TestPage extends Page {
  public readonly Hello = () => this.derived({
    Desktop: '//desktop',
    Mobile: '//mobile',
  }, {
    DesktopMinWidth: 1366,
  });
}

describe('Page', () => {
  before(() => {
    services.world.init({ testUniqueName: 'World Service Unit Test', store: new Map<string, any>() });
  });

  it('take extra config of desktop min width when browser width < DesktopMinWidth', () => {
    services.world.store(KEY_BROWSER_WIDTH, '1280');
    const page = new TestPage();
    expect(page.Hello()).equals('//mobile');
  });

  it('take extra config of desktop min width when browser width >= DesktopMinWidth', () => {
    services.world.store(KEY_BROWSER_WIDTH, '1366');
    const page = new TestPage();
    expect(page.Hello()).equals('//desktop');
  });
});
