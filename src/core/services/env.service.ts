import { ConnStr } from 'ibm_db';
import { Singleton } from 'typescript-ioc';
import { AppTypeConfig } from '../app-type';

export interface Config {
  brand: string
  base: BaseConfig
  th: BaseConfig
  ck: BaseConfig
  databases: Map<string, ConnStr>
  drivers: Map<string, DriverConfig>
}

export interface BaseConfig {
  site?: string
  defaultLocale?: string
  spaDefaultLocale?: string
  spaDefaultLangCode?: string
  multiLangDefaultLocale?: string;
  multiLangDefaultLangCode?: string;
  multiLangPeeriusDefaultLocale?: string;
  xoDefaultLocale?: string;
  mainRedirectPage?: string,
  platform?: string
  databaseName?: string
  driverName?: string
  fhUsername?: string
  fhPassword?: string
  appTypeConfig?: AppTypeConfig
}

export interface CustomTimeouts extends WebdriverIO.Timeouts {
  elementExist: number
  elementClickable: WebdriverIO.WaitForOptions
  elementDisplayed: number
  step: number
}

export interface DriverConfig {
  options: WebdriverIO.RemoteOptions
  timeout: CustomTimeouts
}

@Singleton
export default class EnvService {
  private readonly config: Config;

  private readonly baseConfig: BaseConfig;

  constructor() {
    this.config = require('../../../config.json');
    this.baseConfig = this.Brand === 'ck'
      ? { ...this.config.base, ...this.config.ck }
      : { ...this.config.base, ...this.config.th };
  }

  set AppTypeConfig(value: AppTypeConfig) {
    this.baseConfig.appTypeConfig = value;
  }

  set DatabaseName(value: string) {
    this.baseConfig.databaseName = value;
  }

  get AppTypeConfig() {
    return this.baseConfig.appTypeConfig;
  }

  get DefaultLocale() { return process.env.DefaultLocale || this.baseConfig.defaultLocale; }

  get SpaDefaultLocale() {
    return process.env.SpaDefaultLocale || this.baseConfig.spaDefaultLocale;
  }

  get SpaDefaultLangCode() {
    return process.env.SpaDefaultLangCode || this.baseConfig.spaDefaultLangCode;
  }

  get MultiLangDefaultLocale() {
    return process.env.MultiLangDefaultLocale || this.baseConfig.multiLangDefaultLocale;
  }

  get MultiLangDefaultLangCode() {
    return process.env.MultiLangDefaultLangCode || this.baseConfig.multiLangDefaultLangCode;
  }

  get XoDefaultLocale() {
    return process.env.XoDefaultLocale || this.baseConfig.xoDefaultLocale;
  }

  get MainRedirectPage() {
    return process.env.mainRedirectPage || this.baseConfig.mainRedirectPage;
  }

  get Site() { return process.env.Site || this.baseConfig.site; }

  get Brand() { return process.env.Brand || this.config.brand; }

  get Platform() { return process.env.Platform || this.baseConfig.platform; }

  get fhPassword() { return this.baseConfig.fhPassword; }

  get fhUsername() { return this.baseConfig.fhUsername; }

  get DatabaseName() {
    return process.env.DatabaseName || this.baseConfig.databaseName;
  }

  get DriverName() { return process.env.DriverName || this.baseConfig.driverName; }

  get Database() {
    const config = this.config.databases[this.DatabaseName];
    if (config.PWD && (config.PWD as string).startsWith('QA_ENV_')) {
      config.PWD = process.env[config.PWD];
    }
    return config;
  }

  get DriverConfig(): DriverConfig {
    if (this.DriverName.includes('browserstack')) {
      let bsConfig: DriverConfig;
      // let dynamicBrowserstackName: string;
      const dynamicBrowserstackName = this.DriverName.split('-dynamic', 1).toString();

      const username = process.env.BROWSERSTACK_USERNAME;
      const accessKey = process.env.BROWSERSTACK_KEY;

      const projectName = process.env.TEST_NAME ? process.env.TEST_NAME : 'UNDEFINED';
      const runTime = projectName + new Date().getTime();
      const runDate = `${projectName} ${new Date().toDateString()}`;

      if (this.DriverName.includes('dynamic')) {
        const count = this.config.drivers[dynamicBrowserstackName].length;
        const randomNum = Math.floor(Math.random() * count);
        bsConfig = this.config.drivers[dynamicBrowserstackName][randomNum];
      } else if (this.DriverName.toLocaleLowerCase() === dynamicBrowserstackName) {
        // eslint-disable-next-line prefer-destructuring
        bsConfig = this.config.drivers[dynamicBrowserstackName][0];
      } else {
        bsConfig = this.config.drivers[this.DriverName];
      }
      bsConfig.options.capabilities['bstack:options'].projectName = projectName;
      bsConfig.options.capabilities['bstack:options'].buildName = runDate;
      bsConfig.options.capabilities['bstack:options'].sessionName = runTime;
      bsConfig.options.capabilities['bstack:options'].userName = username;
      bsConfig.options.capabilities['bstack:options'].accessKey = accessKey;
      return bsConfig;
    }
    return this.config.drivers[this.DriverName];
  }

  get RemoteServerUrl() { return `${this.DriverConfig.options.protocol}://${this.DriverConfig.options.hostname}:${this.DriverConfig.options.port}`; }

  get IsMobile() { return this.Platform === 'mobile'; }

  get IsDesktop() { return this.Platform === 'desktop'; }

  get IsTablet() { return this.Platform === 'tablet'; }

  get IsChrome() { return (this.DriverConfig.options.capabilities as any).browserName === 'chrome'; }

  get IsSafari() { return (this.DriverConfig.options.capabilities as any).browserName === 'safari'; }

  get IsFireFox() { return (this.DriverConfig.options.capabilities as any).browserName === 'firefox'; }
}
