import { expect } from 'chai';
import { SetUpSimpleTestLogger } from '../../../src/core/logger/test.logger';
import XoWidgetService from '../../../src/core/services/xo-widget.service';

describe('XO Widget Service Tests', () => {
  let xoWidgetService: XoWidgetService;

  before(() => {
    SetUpSimpleTestLogger();
    xoWidgetService = new XoWidgetService(null);
  });

  it('can get trendingOn widget id successfully for fr site with site id 20011', async () => {
    const widgetIdRetrieved = await xoWidgetService.getWidgetId('TRENDING_ON', '20011');
    expect(widgetIdRetrieved).to.equal('61018278e10b28740058d787');
  });

  it('can get recentlyViewed widget id successfully for be site with site id 20002', async () => {
    const widgetIdRetrieved = await xoWidgetService.getWidgetId('RECENTLY_VIEWED', '20002');
    expect(widgetIdRetrieved).to.equal('610176b7e6037d5a3e1d5579');
  });

  it('can get matchingItems widget id successfully for be site with site id 20002', async () => {
    const widgetIdRetrieved = await xoWidgetService.getWidgetId('MATCHING_ITEMS', '20002');
    expect(widgetIdRetrieved).to.equal('6101769fe6037d5a3e1d5577');
  });

  it('can get noSearch widget id successfully for be site with site id 20002', async () => {
    const widgetIdRetrieved = await xoWidgetService.getWidgetId('NO_SEARCH', '20002');
    expect(widgetIdRetrieved).to.equal('610176c6e10b28740058d6e7');
  });

  it('can get basket widget id successfully for fr site with site id 20011', async () => {
    const widgetIdRetrieved = await xoWidgetService.getWidgetId('BASKET', '20011');
    expect(widgetIdRetrieved).to.equal('61018292300e29582a57e621');
  });
});
