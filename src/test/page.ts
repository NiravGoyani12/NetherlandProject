import services from '../core/services';
import { Selector, DropdownSelector } from '../core/constents';
import { KEY_BROWSER_WIDTH } from '../core/world-key';

export interface PlatformDef {
  Desktop?: Selector | DropdownSelector,
  Mobile?: Selector | DropdownSelector,
  Tablet?: Selector | DropdownSelector
}

export interface PageObjectExtraConfig {
  DesktopMinWidth?: number
}

export abstract class Page {
  public derived(platfromDef: PlatformDef,
    extraConfig?: PageObjectExtraConfig): Selector | DropdownSelector {
    const platform = services.env.Platform.toLowerCase();
    switch (platform) {
      case 'desktop': {
        if (!platfromDef.Desktop) {
          throw new Error('No page object for desktop version');
        }
        // extra condition when pick up locators
        if (extraConfig && extraConfig.DesktopMinWidth > 0
            && services.world.parseByType<number>(KEY_BROWSER_WIDTH)
            && services
              .world.parseByType<number>(KEY_BROWSER_WIDTH) < extraConfig.DesktopMinWidth) {
          return platfromDef.Mobile;
        }
        return platfromDef.Desktop;
      }
      case 'mobile': {
        if (!platfromDef.Mobile) {
          return platfromDef.Desktop;
        }
        return platfromDef.Mobile;
      }
      case 'tablet': {
        if (!platfromDef.Tablet) {
          return platfromDef.Desktop;
        }
        return platfromDef.Tablet;
      }
      default:
        throw new Error(`Incorrect platform ${platform}`);
    }
  }

  protected isMobile() {
    const platform = services.env.Platform.toLowerCase();
    return platform === 'mobile';
  }

  protected isTablet() {
    const platform = services.env.Platform.toLowerCase();
    return platform === 'tablet';
  }
}
