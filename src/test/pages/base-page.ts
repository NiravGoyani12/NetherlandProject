import { Singleton } from 'typescript-ioc';
import { Page } from '../page';

@Singleton
export default class BasePage extends Page {
  public readonly Metatag = (name: string) => this.derived({
    Desktop: `//meta[@name="${name}"]`,
  });

  public readonly MetatagHttpEquiv = (name: string) => this.derived({
    Desktop: `//meta[@http-equiv="${name}"]`,
  });

  public readonly TitleTag = () => this.derived({
    Desktop: '//title',
  });

  public readonly MetaLink = (property: string) => this.derived({
    Desktop: `//link[@*="${property}"]`,
  });

  public readonly RecommendationsLink = (property: string) => this.derived({
    Desktop: `//article[@data-recommendations__item]//a[contains(@href,"${property}")]`,
  });

  public readonly CookiesLink = (property: string) => this.derived({
    Desktop: `//div[@data-testid="CookieNoticeMain"]//a[@*="${property}"]`,
  });

  public readonly CookiesSettingInsideLink = (property: string) => this.derived({
    Desktop: `//div[@data-testid="CookieNoticeMore"]//a[@*="${property}"]`,
  });

  public readonly MetaProperty = (property: string) => this.derived({
    Desktop: `//meta[@property="${property}" and string-length(@content) > 1]`,
  });

  public readonly Script = (property: string) => this.derived({
    Desktop: `//script[@*="${property}"]`,
  });

  public readonly ScriptByText = (text: string) => this.derived({
    Desktop: `//script[contains(text(), "${text}")]`,
  });

  public readonly AnyItem = (text: string) => this.derived({
    Desktop: `//*[local-name()!='script' and contains(text(), "${text}")]`,
  });

  public readonly Footerlink = () => this.derived({
    Desktop: '//footer//li//a[@data-footer__link]',
  });

  public readonly HtmlLang = (lang: string) => this.derived({
    Desktop: `//html[@lang='${lang}']`,
  });

  public readonly InvalidItem = () => this.derived({
    Desktop: '//*[local-name()!="script" and normalize-space(.)="?"]',
  });

  public readonly UsabillaFeedbackButton = () => this.derived({
    Desktop: '//div[@class="usabilla_live_button_container"]',
  });

  public readonly SpaSign = () => this.derived({
    Desktop: '#__next',
  });

  public readonly AcceptAllCookies = () => this.derived({
    Desktop: '//div[contains(@data-testid, "CookieNotice-main-wrapper")]//button[contains(@data-testid, "accept-cookies-pvh-button")]',
  });

  public readonly AcceptCookies = () => this.derived({
    Desktop: '//button[contains(@class, "cookie-notice__agree-button")]',
  });

  public readonly ErrorPage = () => this.derived({
    Desktop: 'div[data-testid="ErrorPage-component"]',
  });
}
