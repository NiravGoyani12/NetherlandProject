/* eslint-disable import/no-dynamic-require */
/* eslint-disable no-eval */
/* eslint-disable @typescript-eslint/no-unused-vars */
import { Singleton, Inject } from 'typescript-ioc';
import * as ts from 'typescript';
import * as changeCase from 'change-case';
import EnvService from './env.service';
import { Selector, DropdownSelector } from '../constents';
import PageObjectStrategyService from './page-object-strategy.service';
import { SiteService } from './site.service';

interface ElementParse {
  className: string,
  methodName: string
}

@Singleton
export default class PageObjectService {
  constructor(
    @Inject private envService: EnvService,
    @Inject private siteService: SiteService,
    @Inject private strategyService: PageObjectStrategyService,
  ) {

  }

  public async getSelector(
    elementPath: string, args?: any[],
  ): Promise<Selector | DropdownSelector> {
    const originalPagePath = this.getPagePathFromElementPath(elementPath);
    const pagePath = await this.strategyService
      .applyStrategy(originalPagePath, this.envService, this.siteService);
    let originalElementPathClassName = null;
    // if it has strategy page
    if (originalPagePath !== pagePath) {
      const originalElementPath = this.applyPagePathToElementPath(elementPath, originalPagePath);
      const originalElementPathResult = this.parseElementPath(originalElementPath);
      originalElementPathClassName = originalElementPathResult.className;
    }
    elementPath = this.applyPagePathToElementPath(elementPath, pagePath);
    const elementPathResult = this.parseElementPath(elementPath);
    const iocContainer = require('typescript-ioc').Container;
    const pageObject = this.getRequire(elementPathResult.className, originalElementPathClassName);
    const code: string = `(function(){ return iocContainer.get(pageObject).${elementPathResult.methodName}})()`;
    const func = eval(ts.transpile(code));
    if (typeof func === 'function') {
      if (!args) {
        return func();
      }
      if (args.length === 1) {
        return func(args[0]);
      }
      if (args.length === 2) {
        return func(args[0], args[1]);
      }
      if (args.length === 3) {
        return func(args[0], args[1], args[2]);
      }
    }
    throw new Error(`Cannot parse ${elementPath}`);
  }

  public async doFunction<T>(functionPath: string, precondition?: () => Promise<void>): Promise<T> {
    const originalPagePath = this.getPagePathFromElementPath(functionPath);
    const pagePath = await this.strategyService
      .applyStrategy(originalPagePath, this.envService, this.siteService);
    let originalFunctionPathClassName = null;
    // if it has strategy page
    if (originalPagePath !== pagePath) {
      const originalFunctionPath = this.applyPagePathToElementPath(functionPath, originalPagePath);
      const originalFunctionPathResult = this.parseElementPath(originalFunctionPath);
      originalFunctionPathClassName = originalFunctionPathResult.className;
    }
    functionPath = this.applyPagePathToElementPath(functionPath, pagePath);
    const functionPathResult = this.parseElementPath(functionPath);
    const iocContainer = require('typescript-ioc').Container;
    const pageObject = this.getRequire(functionPathResult.className, originalFunctionPathClassName);
    const code: string = `(function(){  return iocContainer.get(pageObject).${functionPathResult.methodName}})()`;
    const func = eval(ts.transpile(code));
    if (typeof func === 'function') {
      if (precondition) {
        const result = await func(precondition) as T;
        return result;
      }
      const result = await func() as T;
      return result;
    }
    throw new Error(`Cannot parse the name of the function ${functionPath}`);
  }

  private getRequire(className: string, originalClassName?: string): any {
    try {
      // strategy page
      return require(`../../test/${this.envService.Brand}/pages/${className}`).default;
    } catch {
      try {
        // common strategy page
        return require(`../../test/pages/${className}`).default;
      } catch (e) {
        // original page
        if (originalClassName && className !== originalClassName) {
          return require(`../../test/${this.envService.Brand}/pages/${originalClassName}`).default;
        }
        throw e;
      }
    }
  }

  private applyPagePathToElementPath(elementPath: string, pagePath: string) {
    if (elementPath.indexOf(pagePath) === 0) {
      return elementPath;
    }
    const parts = elementPath.split('.');
    const pagePathParts = pagePath.split('.');
    if (parts.length === 3 && pagePathParts.length === 2) {
      return `${pagePath}.${parts[2]}`;
    }
    if (parts.length === 2 && pagePathParts.length === 1) {
      return `${pagePath}.${parts[1]}`;
    }
    throw new Error(`Cannot apply page path into element path, invalid path: ${elementPath} / ${pagePath}`);
  }

  private getPagePathFromElementPath(elementPath: string): string {
    const parts = elementPath.split('.');
    if (parts.length === 3) {
      return `${parts[0]}.${parts[1]}`;
    } if (parts.length === 2) {
      return parts[0];
    }
    throw new Error(`Cannot get page path from element path, invalid path: ${elementPath}`);
  }

  private parseElementPath(elementPath: string): ElementParse {
    const parts = elementPath.split('.');
    if (parts.length === 3) {
      return {
        className: `${changeCase.paramCase(parts[0])}/${changeCase.paramCase(parts[1])}`,
        methodName: parts[2],
      };
    } if (parts.length === 2) {
      return {
        className: `${changeCase.paramCase(parts[0])}`,
        methodName: parts[1],
      };
    }
    throw new Error(`Can not parse element path ${elementPath}`);
  }
}
