import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class ContactUsOverviewPage extends Page {
  public readonly LiveChatBlock = () => this.derived({
    Desktop: '//*[@data-testid="CUOverviewLiveChat-card"]//h3[@data-testid="title"]',
  });

  public readonly StartChatButton = () => this.derived({
    Desktop: '//*[@data-testid="CUOverviewLiveChat-card"]//button[@data-testid="OpenLivechat-pvh-button"]',
  });

  public readonly TelephoneBlock = () => this.derived({
    Desktop: '//*[@data-testid="CUOverviewTelephone-card"]//h3[@data-testid="title"]',
  });

  public readonly ContactUSBlock = () => this.derived({
    Desktop: '//*[@data-testid="CUOverviewForm-card"]//h3[@data-testid="title"]',
  });

  public readonly FAQBlock = () => this.derived({
    Desktop: '//*[@data-testid="CUOverviewFaqs-card"]//h2[@data-testid="FaqTitle"]',
  });

  public readonly SendUSMessageLink = () => this.derived({
    Desktop: '//*[@data-testid="CUOverviewForm-card"]//button[@data-testid="FormLink"]',
  });

  public readonly OpenFAQAccord = (index = 1) => this.derived({
    Desktop: `//*[@data-testid="pvh-accordion"][${index}]//a[@data-testid="accordion-trigger"]//span[@data-testid="accordion-icon"]`,
  });

  public readonly FAQAccordOpened = (index = 1) => this.derived({
    Desktop: `//*[@data-testid="pvh-accordion"][${index}]//a[@aria-expanded="true"]`,
  });

  public readonly ContactUSBlockLink = () => this.derived({
    Desktop: '//*[@data-testid="ContactUs-Form-GridItem"]//button[contains(@class, "ContactUsForm_GoBackToOVerView__Zcm4A")]',
  });

  public readonly LiveChatSideBarWindow = () => this.derived({
    Desktop: '//div[contains(@class, "sidebarBody")]',
  });

  public readonly LiveChatSideBarMinimizedButton = () => this.derived({
    Desktop: '//header[contains(@class,"sidebarHeader")]//button[contains(@class, "minimizeButton")]',
  });

  public readonly LiveChatSideBarClosedButton = () => this.derived({
    Desktop: '//header[contains(@class,"sidebarHeader")]//button[contains(@class, "closeButton")]',
  });

  public readonly LiveChatSideBarMinimizedDocked = () => this.derived({
    Desktop: '//div[contains(@class, "modalContainer sidebarMinimized")]//button[contains(@class, "minimizedContainer")]',
  });

  public readonly LiveChatFirstNameInput = () => this.derived({
    Desktop: '//input[@id="FirstName"]',
  });

  public readonly LiveChatLastNameInput = () => this.derived({
    Desktop: '//input[@id="LastName"]',
  });

  public readonly LiveChatEmailInput = () => this.derived({
    Desktop: '//input[@id="Email"]',
  });

  public readonly LiveChatSubjectInput = () => this.derived({
    Desktop: '//input[@id="Subject"]',
  });

  public readonly StartChattingButton = () => this.derived({
    Desktop: '//div[contains(@class, "buttonWrapper embeddedServiceSidebarForm")]//button[contains(@class, "startButton")]',
  });
}
