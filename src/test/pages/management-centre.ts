import { Singleton } from 'typescript-ioc';
import { Page } from '../page';

@Singleton
export default class ManagementCentre extends Page {
  public readonly Username = () => this.derived({
    Desktop: '//*[@widgetid="dijit__WidgetBase_345"]//*[@name="inputText"]',
  });

  public readonly Password = () => this.derived({
    Desktop: '//*[@widgetid="dijit__WidgetBase_354"]//*[@name="inputText"]',
  });

  public readonly LoginButton = () => this.derived({
    Desktop: '//*[@widgetid="dijit__WidgetBase_365"]',
  });

  public readonly Hamburg = () => this.derived({
    Desktop: '//*[@widgetid="dijit__WidgetBase_6"]',
  });

  public readonly Scheduler = () => this.derived({
    Desktop: '//*[@widgetid="dijit__WidgetBase_277"]',
  });

  public readonly SystemAdministration = () => this.derived({
    Desktop: '//*[@widgetid="dijit__WidgetBase_254"]',
  });

  public readonly Searchbar = () => this.derived({
    Desktop: '//input[contains(@data-placeholder,"By command")]',
  });

  public readonly tool = (name: String) => this.derived({
    Desktop: `//*[contains(@class, "mat-cell")]//a[text()="${name}"]`,
  });

  public readonly schedulerHeader = () => this.derived({
    Desktop: '//*[@class="hc-type-h1" and contains(text(),\' Scheduler \')]',
  });

  public readonly ManagementCentreIframeMain = () => this.derived({
    // Desktop: `//iframe[contains(@src,'${name}')]`,
    Desktop: '//iframe[contains(@src,"scheduler")]',
  });

  public readonly SchedulerTab = () => this.derived({
    Desktop: '(//*[contains(@widgetid,"dijit__WidgetBase") and contains(text(),"Scheduler")])[2]',
  });

  public readonly button = (name: String) => this.derived({
    Desktop: `//button[contains(text(),'${name}')]`,
  });

  public readonly successMessageBar = () => this.derived({
    Desktop: '//*[@class="mat-simple-snackbar ng-star-inserted"]',
  });
}
