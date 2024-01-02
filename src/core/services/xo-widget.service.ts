import fs from 'fs-extra';
import { Inject, Singleton } from 'typescript-ioc';
import path from 'path';
import { GetTestLogger } from '../logger/test.logger';
import { SiteService } from './site.service';

export enum WidgetType {
  TRENDING_ON = 'TRENDING_ON',
  RECENTLY_VIEWED = 'RECENTLY_VIEWED',
  MATCHING_ITEMS = 'MATCHING_ITEMS',
  NO_SEARCH = 'NO_SEARCH',
  BASKET = 'BASKET'
}

@Singleton
export default class XoWidgetService {
  private xoWidgetIdInfo;

  constructor(
    @Inject private siteService: SiteService,
  ) {
  }

  private getConfigFile(storeId: string) {
    let pathToConfigFile;
    if (!storeId) {
      throw new Error('storeId cannot be null! Initialize site first.');
    }
    try {
      pathToConfigFile = path.resolve('..', 'ecom-e2e-test/src/core/json/xo-widget-ids', `xowidgetid-${storeId}.json`);
    } catch (e) {
      throw Error(`Error: ${e}`);
    }
    return fs.readJson(pathToConfigFile);
  }

  public async getWidgetId(recommendationType: string, storeId?: string) {
    let widgetId;
    if (!storeId) {
      storeId = this.siteService.siteInfo.STORE_ID.toString();
    }
    this.xoWidgetIdInfo = await this.getConfigFile(storeId);

    if (!recommendationType || recommendationType === undefined) {
      throw new Error('The recommendationType cannot be null!');
    }

    GetTestLogger().info(`JSON: ${JSON.stringify(this.xoWidgetIdInfo)}`);

    switch (recommendationType.toUpperCase()) {
      case WidgetType.TRENDING_ON:
        widgetId = this.xoWidgetIdInfo.json.trendingOn;
        break;
      case WidgetType.RECENTLY_VIEWED:
        widgetId = this.xoWidgetIdInfo.json.recentlyViewed;
        break;
      case WidgetType.MATCHING_ITEMS:
        widgetId = this.xoWidgetIdInfo.json.matchingItems;
        break;
      case WidgetType.NO_SEARCH:
        widgetId = this.xoWidgetIdInfo.json.noSearch;
        break;
      case WidgetType.BASKET:
        widgetId = this.xoWidgetIdInfo.json.basket;
        break;
      default:
        throw Error(`You must provide a recommendationType: ${recommendationType.toUpperCase()}`);
    }
    if (!widgetId || widgetId === undefined) {
      throw new Error(`widgetId was null. Failed to get widgetId for ${recommendationType.toUpperCase()}`);
    }
    GetTestLogger().info(`Widget ID for ${recommendationType.toUpperCase()}: ${widgetId}`);

    return widgetId;
  }
}
