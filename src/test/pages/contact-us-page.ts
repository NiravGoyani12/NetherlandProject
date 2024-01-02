import { Singleton } from 'typescript-ioc';
import { Page } from '../page';

@Singleton
export default class ContactUsPage extends Page {
  public readonly RequestTypeDropdown = (text?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//input[@name="requestTypeDescription"]/../../..',
      optionSelector: `//input[@name="requestTypeDescription"]/../../..//ul//li[contains(., "${text || ''}")]`,
    },
  });

  public readonly RequestTypeSubCategoryDropdown = (text?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//input[@name="subCategoryDescription"]/../../..',
      optionSelector: `//input[@name="subCategoryDescription"]/../../../ul//li[contains(., "${text || ''}")]`,
    },
  });

  public readonly MessageInput = () => this.derived({
    Desktop: '//textarea[@id="yourMessage"]',
  });

  public readonly FirstNameInput = () => this.derived({
    Desktop: '//input[contains(@id,"firstName")]',
  });

  public readonly LastNameInput = () => this.derived({
    Desktop: '//input[contains(@id,"lastName")]',
  });

  public readonly EmailInput = () => this.derived({
    Desktop: '//input[contains(@id,"email")]',
  });

  public readonly GenderToggleInput = (index?: number) => this.derived({
    Desktop: `//button[@data-testid="pvh-ToggleButton"]${index ? `[${index}]` : ''}`,
  });

  public readonly PhoneInput = () => this.derived({
    Desktop: '//input[contains(@id,"phone")]',
  });

  public readonly OrderNumber = () => this.derived({
    Desktop: '//input[contains(@id,"orderNumber")]',
  });

  public readonly ContactUsSubmitButton = () => this.derived({
    Desktop: '//button[contains(@class, "ContactUsForm_SubmitButton")]',
  });
}
