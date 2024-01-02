import { Singleton, Inject } from 'typescript-ioc';
// import * as changeCase from 'change-case';
import { GetTestLogger } from '../logger/test.logger';
import EnvService from './env.service';
import { SiteService } from './site.service';
import consoleLog from '../logger/console.logger';

/**
 * contidionFunc:  a function to tell when the strategy should be applied
 * appliedPagePathList: a list of page path,
 *                      such as [Experience.ShoppingBag, Checkout.DeliveryPage]
 * applyFunc: a function to adjust the pagePath
 */
export interface PageObjectStrategy {
  brand: string,
  strategyName: string,
  conditionFunc: (pagePath: string, env: EnvService, site: SiteService) => Promise<boolean>
  appliedPagePathList: Array<string>
  applyFunc: (pagePath: string) => string
  enabled: boolean
}

@Singleton
export default class PageObjectStrategyService {
  private strategyList: Array<PageObjectStrategy>;

  private strategyInitialStateList: Array<boolean>;

  constructor(@Inject private env: EnvService) {
    this.strategyList = [];
    this.strategyInitialStateList = [];
  }

  public addStrategy(pageObjectStrategy: PageObjectStrategy) {
    if (pageObjectStrategy.brand === '*' || this.env.Brand === pageObjectStrategy.brand) {
      consoleLog(`Loaded Page object strategy ${pageObjectStrategy.strategyName}`);
      this.strategyList.push(pageObjectStrategy);
      this.strategyInitialStateList.push(pageObjectStrategy.enabled);
    }
  }

  public resetAllStrategy() {
    for (let i = 0; i < this.strategyList.length; i += 1) {
      if (this.strategyList[i].enabled !== this.strategyInitialStateList[i]) {
        this.logger.info(`Reseting page strategy ${this.strategyList[i].strategyName}`);
      }
      this.strategyList[i].enabled = this.strategyInitialStateList[i];
    }
  }

  public disableStrategy(name: string) {
    const strategy = this.strategyList.find((s) => s.strategyName === name);
    if (!strategy) {
      throw new Error(`Cannot find strategy ${name}`);
    }
    strategy.enabled = false;
  }

  public enableStrategy(name: string) {
    const strategy = this.strategyList.find((s) => s.strategyName === name);
    if (!strategy) {
      throw new Error(`Cannot find strategy ${name}`);
    }
    strategy.enabled = true;
  }

  /**
   * Apply strategy if condition matched
   * The priority depends on from high to low by the order of definition
   * first defined will have high priority
   * @param pagePath a string like Experience.ShoppingBag
   */
  public async applyStrategy(
    pagePath: string, env: EnvService, site: SiteService,
  ): Promise<string> {
    const strategyList = this.findStrategies(pagePath);
    if (strategyList.length > 0) {
      for (let i = 0; i < strategyList.length; i += 1) {
        const strategy = strategyList[i];
        if (strategy && strategy.enabled) {
          // eslint-disable-next-line no-await-in-loop
          const inCondition = await strategy.conditionFunc(pagePath, env, site);
          if (inCondition) {
            // eslint-disable-next-line no-await-in-loop
            const newPagePath = strategy.applyFunc(pagePath);
            this.logger.info(`Applied Page Object strategy ${strategy.strategyName}, changed page path from ${pagePath} to ${newPagePath}`);
            return newPagePath;
          }
        }
      }
    }
    return pagePath;
  }

  private findStrategies(pagePath: string) {
    // TODO: make pagePath case insensitive
    // pagePath = pagePath.split('.').map((s) => changeCase.pascalCase(s)).join('.');
    return this.strategyList.filter((s) => s.appliedPagePathList.indexOf(pagePath) >= 0);
  }

  private get logger() { return GetTestLogger(); }
}
