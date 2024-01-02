import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';
import { exist$, maybeDisplayed$ } from '../../general';

@Singleton
export default class PlpNosearch extends Page {
  public readonly NoSearchResultMessage = () => this.derived({
    Desktop: '//h1[@data-testid="NoSearchResults-title"]',
  });

  public isLoaded = async (): Promise<boolean> => {
    const noSearchResultMessage = await exist$(this.NoSearchResultMessage());
    await noSearchResultMessage.waitForDisplayed({ timeout: 10000 });
    await noSearchResultMessage.jsClick();
    const isPageLoaded = !!(await maybeDisplayed$(this.NoSearchResultMessage()));
    return isPageLoaded;
  };
}
