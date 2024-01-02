/**
 * App type: the type of the app which we test against
 */

export enum AppType {
  SPA = 'SPA',
  UC = 'UC'
}

export interface ConfigItem {
  site: string
  appType: AppType
  config: Map<string, Array<string>>
}

export interface AppTypeConfig {
  th: Array<ConfigItem>
  ck: Array<ConfigItem>
}

const DEFAULT_APP_TYPE = AppType.SPA;

export const getAppType = (
  appTypeConfig: AppTypeConfig,
  brand: string,
  locale: string,
  site: string,
  pageType: string,
): AppType => {
  const brandConfig = appTypeConfig[brand] as Array<ConfigItem>;
  if (!brandConfig) {
    throw new Error(`Cannot identify App type by brand ${brand}`);
  }

  const config = brandConfig.find(
    (c) => c.site === site
      && c.config
      && c.config[pageType]
      && c.config[pageType]
        .findIndex((_locale) => _locale.toLowerCase() === locale.toLowerCase()) >= 0,
  );
  return config ? config.appType : DEFAULT_APP_TYPE;
};
