import { Singleton } from 'typescript-ioc';
import { Page } from '../page';

@Singleton
export default class UsabillaForm extends Page {
  public readonly IFrame = () => this.derived({
    Desktop: '//iframe[contains(@title,"Usabilla Feedback Form Frame")]',
  });

  public readonly MainBlock = () => this.derived({
    Desktop: '//body[@id="usabilla-metadata-container"]',
  });

  public readonly Loader = () => this.derived({
    Desktop: '//div[contains(@style,"throbber.gif")]',
  });

  public readonly FiveStarRating = () => this.derived({
    Desktop: '//li[@class="rating_5"]//label',
  });

  public readonly TopicDropdown = (optionName?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//select[@name="Select_A_Topic"]',
      optionSelector: `//select[@name="Select_A_Topic"]//option${optionName ? `[@value="${optionName}"]` : ''}`,
    },
  });

  public readonly SubmitButton = () => this.derived({
    Desktop: '//span[contains(@style, "display: block")]//button[@id="submit_vis"]',
  });

  public readonly SuccessMessage = () => this.derived({
    Desktop: '//div[@class="feedback"]',
  });

  public readonly ContinueShoppingButton = () => this.derived({
    Desktop: '//a[@class="continue"]',
  });

  public readonly CloseButton = () => this.derived({
    Desktop: '//a[@class="close"]',
  });
}
