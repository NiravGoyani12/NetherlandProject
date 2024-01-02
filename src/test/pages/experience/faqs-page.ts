import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class FaqsPage extends Page {
  public readonly CentreFAQFrame = () => this.derived({
    Desktop: '//div[@data-testid="FaqIndex-component"]',
  });

  public readonly LeftFAQCategoryBar = () => this.derived({
    Desktop: '//a[@data-testid="pvh-ResponsiveNavListItem"]',
  });

  public readonly CategoryElement = (text?: string) => this.derived({
    Desktop: `//h4[@data-testid="ListNavigation-label" and contains(.,"${text || ''}")]`,
  });

  public readonly QuestionList = () => this.derived({
    Desktop: '//div[@data-testid="FaqCategoryComponent"]',
  });

  public readonly CategoryCard = () => this.derived({
    Desktop: '//div[@data-testid="pvh-card"]',
  });

  public readonly CategoryTitle = (text?: string) => ({
    Desktop: `//*[contains(@class, "FaqCategoryTitle")] and [contains(., "${text || ''}")]`,
  });

  public readonly CategoryQuestion = (text?: string) => this.derived({
    Desktop: `//span[contains(@class,"Accordion_Title")][contains(text(),"${text || ''}")]`,
  });

  public readonly CategoryAnswer = (text?: string) => this.derived({
    Desktop: `//*[@data-testid="accordion-collapse"]//p[contains(text(),"${text || ''}")]`,
  });

  public readonly HelpSection = () => this.derived({
    Desktop: '//div[@data-testid="FaqsHelp-component"]',
  });

  public readonly ContactUsButton = () => this.derived({
    Desktop: '//a[@data-testid="faqsActionButton-pvh-button"]',
  });

  public readonly CategoryBackLinkOnQuestion = () => this.derived({
    Desktop: '//*[@data-testid="FaqLinkIcon"]',
  });

  public readonly SideBarCategoryList = () => this.derived({
    Desktop: '//nav[@data-testid="side-nav"]',
  });

  public readonly SideBarCategoryMenu = (text?: string) => this.derived({
    Desktop: `//a[contains(@data-testid,"pvh-ResponsiveNavListItem") and contains(@href,"${text || ''}")]`,
  });

  public readonly SelectedFAQCategorySideMenu = (text?: string) => this.derived({
    Desktop: `//a[contains(@class,"ResponsiveNavListItem_selected")] and [contains(., "${text || ''}")] `,
  });

  public readonly CategoryQuestionExpanded = () => this.derived({
    Desktop: '//div[contains(@class,"Accordion_expanded")]',
  });

  public readonly CategoryLink = (text?: string) => this.derived({
    Desktop: `//a[contains(@data-testid, "ListNavigation-link") and contains(., "${text || ''}")]`,
  });

  public readonly CategoryQuestions = (text?: string) => this.derived({
    Desktop: `//a[contains(@id, "${text}?-accordion") and contains(., "${text || ''}")]`,
  });

  public readonly Answers = (text?: string) => this.derived({
    Desktop: `//div[contains(@data-testid, "answer-inner") and contains(., "${text || ''}")]/p`,
  });

  public readonly NeedMoreHelpSection = (text?: string) => this.derived({
    Desktop: `//h4[contains(@data-testid, "faqsHelpTitle") and contains(., "${text || ''}")]`,
  });

  public readonly BackToCategoryButton = () => this.derived({
    Desktop: '//a[contains(@class, "back-link")]',
  });

  public readonly SideBarCategoryMenuUsingText = (text?: string) => this.derived({
    Desktop: `//a[@data-testid="pvh-ResponsiveNavListItem" and contains(.,"${text || ''}")] | //a[@data-testid="mainMenu-pvh-ResponsiveNavListItem" and contains(.,"${text || ''}")]`,
  });

  public readonly FaqTitleWithText = (text?: string) => this.derived({
    Desktop: `//h1[@data-testid="FaqTitle" and contains(.,"${text || ''}")]`,
  });

  public readonly CheckGiftCardBalanceButton = () => this.derived({
    Desktop: '//button[@data-testid="triggerOpenCheckBalance-pvh-button"]',
  });

  public readonly GiftCardInputIframe = () => this.derived({
    Desktop: '//iframe[contains(@title,"Iframe für Kartennummer")]',
  });

  public readonly GiftCardPinIframe = () => this.derived({
    Desktop: '//iframe[contains(@title,"Iframe für Stift")]',
  });

  public readonly CheckGiftCardBalanceModal = () => this.derived({
    Desktop: '//div[@data-testid="Modal-component"]',
  });

  public readonly GiftCardCardNumberInput = () => this.derived({
    Desktop: '//input[@data-fieldtype="encryptedCardNumber"]',
  });

  public readonly GiftCardPinInput = () => this.derived({
    Desktop: '//input[@data-fieldtype="encryptedSecurityCode"]',
  });

  public readonly GiftCardBalanceButton = () => this.derived({
    Desktop: '//button[@data-testid="triggerCheckBalance-pvh-button"]',
  });

  public readonly GiftCardModalFormErrorMsg = () => this.derived({
    Desktop: '//div[@data-testid="errorDisplay-StatusText"]',
  });
}
