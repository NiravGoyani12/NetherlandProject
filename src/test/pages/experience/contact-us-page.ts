import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class ContactUsPage extends Page {
  public readonly ContactUsForm = () => this.derived({
    Desktop: '//div[@data-testid="ContactUs-Form-GridItem"]',
  });

  public readonly RequestTypeDropdown = (text?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//input[@name="requestTypeDescription"]/../../..',
      optionSelector: `//input[@name="requestTypeDescription"]/../../..//ul//li[contains(., "${text || ''}")]`,
    },
    Mobile: {
      dropdownSelector: '//div[@data-testid="category-select-component"]',
      optionSelector: `//select[@data-testid="category-native-select"]//child::option[contains(text(),"${text}")]`,
    },
  });

  public readonly RequestTypeSubCategoryDropdown = (text?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//input[@name="subCategoryDescription"]/../../..',
      optionSelector: `//input[@name="subCategoryDescription"]/../../../ul//li[contains(., "${text || ''}")]`,
    },
    Mobile: {
      dropdownSelector: '//div[@data-testid="subcategory-select-component"]',
      optionSelector: `//select[@data-testid="subcategory-native-select"]//child::option[contains(text(),"${text}")]`,
    },
  });

  public readonly MessageInput = () => this.derived({
    Desktop: '//textarea[@id="yourMessage"]',
  });

  public readonly CharactersLimitMessage = (text?: string) => this.derived({
    Desktop: `//span[@id="counter-info"][contains(., "${text || ''}")]`,
  });

  public readonly FirstNameInput = () => this.derived({
    Desktop: '//input[@data-testid="firstName-inputField"]',
  });

  public readonly LastNameInput = () => this.derived({
    Desktop: '//input[@data-testid="lastName-inputField"]',
  });

  public readonly EmailInput = () => this.derived({
    Desktop: '//input[@data-testid="email1-inputField"]',
  });

  public readonly GenderToggleInput = (index?: number) => this.derived({
    Desktop: `//button[@data-testid="pvh-ToggleButton"]${index ? `[${index}]` : ''}`,
  });

  public readonly PhoneInput = () => this.derived({
    Desktop: '//input[@data-testid="phone1-inputField"]',
  });

  public readonly OrderNumber = () => this.derived({
    Desktop: '//input[@data-testid="orderNumber-inputField"]',
  });

  public readonly ItemNumberInput = () => this.derived({
    Desktop: '//input[@id="itemNumbers-contact-form"]',
  });

  public readonly ContactUsSubmitButton = () => this.derived({
    Desktop: '//button[@data-testid="contactusform-pvh-button"]',
  });

  public readonly FormErrorMsg = (text?: string) => this.derived({
    Desktop: `//div[@data-testid="alert-error"][contains(., "${text || ''}")]`,
  });

  public readonly NoInputError = () => this.derived({
    Desktop: '//div[contains(@data-testid, "alert-error")]',
  });

  public readonly EmailErrorMsg = (text?: string) => this.derived({
    Desktop: `//div[@data-testid="alert-error-email1"][contains(., "${text || ''}")]`,
  });

  public readonly PhoneErrorMsg = (text?: string) => this.derived({
    Desktop: `//div[@data-testid="alert-error-phone1"][contains(., "${text || ''}")]`,
  });

  public readonly MessageLengthError = () => this.derived({
    Desktop: '//div[contains(@class, "TextareaErrorMessage")]//div[@data-testid="alert-error-yourMessage"]',
  });

  public readonly CallUsComponent = () => this.derived({
    Desktop: '//div[@data-testid="CallUs-Content"]',
  });

  public readonly CallUsDetails = () => this.derived({
    Desktop: '//*[contains(@data-testid,"pvh-IconWithText")]',
  });

  public readonly FirstNameError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-firstName"]',
  });

  public readonly LastNameError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-lastName"]',
  });

  public readonly promoCodeError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-promoCode"]',
  });
}
