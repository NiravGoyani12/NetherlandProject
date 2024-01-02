import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';
import services from '../../../core/services';

@Singleton
export default class CountrySwitchPopup extends Page {
  private container = '//*[@data-testid="CountrySwitch-Modal-component"]';

  public readonly MainBlock = () => this.derived({
    Desktop: this.container,
  });

  public readonly CloseButton = () => this.derived({
    Desktop: `${this.container}//*[@data-testid="pvh-icon-button"]`,
  });

  public readonly Title = (text?: string) => this.derived({
    Desktop: `${this.container}//div/p[@data-testid="typography-p"${text ? ` and text()="${text}"` : ''}]`,
  });

  public readonly LinkUrl = (locale?: string) => this.derived({
    Desktop: `${this.container}//a[@href="${services.site.getBaseUrl(locale)}"]`,
  });

  public readonly Link = () => this.derived({
    Desktop: `${this.container}//a`,
  });
}
