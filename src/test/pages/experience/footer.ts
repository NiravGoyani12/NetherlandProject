import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class Footer extends Page {
  public readonly MainBlock = () => this.derived({
    Desktop: '//footer[@data-testid="Footer-component"]',
  });

  public readonly ContenBlock = () => this.derived({
    Desktop: '//div[@data-testid="Footer-columns"]',
  });

  public readonly ConnectSocialFacebook = () => this.derived({
    Desktop: '//a[@class="social-media__link" and @title="Facebook"]',
  });

  public readonly ConnectSocialPinterest = () => this.derived({
    Desktop: '//a[@class="social-media__link" and @title="Pinterest"]',
  });

  public readonly ConnectSocialTwitter = () => this.derived({
    Desktop: '//a[@class="social-media__link" and @title="Twitter"]',
  });

  public readonly ConnectSocialInstagram = () => this.derived({
    Desktop: '//a[@class="social-media__link" and @title="Instagram"]',
  });

  public readonly ConnectSocialYoutube = () => this.derived({
    Desktop: '//a[@class="social-media__link" and @title="Youtube"]',
  });

  public readonly BciLogo = () => this.derived({
    Desktop: '//div[@class="bci-logo"]',
  });

  public readonly HelpAndSupportSection = () => this.derived({
    Desktop: '//div[@data-testid="Footer-column"][1]',
  });

  public readonly ContactUsSection = () => this.derived({
    Desktop: '//div[@data-testid="Footer-column"][1]',
  });

  public readonly OrderStatus = () => this.derived({
    Desktop: '//*[@data-testid="pvh-List"]/li/a[contains(@href, "/services/view-order")]',
  });

  public readonly ContactUsSectionOpen = () => this.derived({
    Mobile: '//div[@data-testid="Footer-column"][1]',
  });

  public readonly ContactUsSectionLinks = () => this.derived({
    Desktop: '//div[@data-testid="Footer-column"][1]//a',
  });

  public readonly ExploreSection = () => this.derived({
    Desktop: '//div[@data-testid="Footer-column"][2]',
  });

  public readonly ExploreSectionLinks = () => this.derived({
    Desktop: '//div[@data-testid="Footer-column"][2]//a',
  });

  public readonly CustomerServiceSection = () => this.derived({
    Desktop: '//div[@data-testid="Footer-column"][3]',
  });

  public readonly ExploreSectionLinkByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="Footer-column"][2]//a)${index ? `[${index}]` : ''}`,
  });

  public readonly HelpAndSupportSectionLinkByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="Footer-column"][1]//a)${index ? `[${index}]` : ''}`,
  });

  public readonly AboutUsSectionLinkByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="Footer-column"][4]//a)${index ? `[${index}]` : ''}`,
  });

  public readonly LegalPageCollectionsSection = () => this.derived({
    Desktop: '//div[@class="LegalPageCollectionWrapper"]',
  });

  public readonly CustomerServiceSectionByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="Footer-column"][3]//a)${index ? `[${index}]` : ''}`,
  });

  public readonly CustomerServiceSectionLinks = () => this.derived({
    Desktop: '//div[@data-testid="Footer-column"][3]//a',
  });

  public readonly AboutSection = () => this.derived({
    Desktop: '//div[@data-testid="Footer-column"][4]',
  });

  public readonly AboutSectionLinks = () => this.derived({
    Desktop: '//div[@data-testid="Footer-column"]//a',
  });

  public readonly CopyrightText = () => this.derived({
    Desktop: '//div[contains(@class,"Footer_Copyright")]',
  });

  public readonly StoreLocatorLink = () => this.derived({
    Desktop: '(//div[@data-testid="Footer-column"][1]//a)[last()]',
  });

  public readonly FootermenuSection2 = () => this.derived({
    Desktop: '//div[@data-testid="Footer-column"][2]',
  });

  public readonly FootermenuSection2Links = () => this.derived({
    Desktop: '//div[@data-testid="Footer-column"][2]//a',
  });

  public readonly FootermenuSection2LinkByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="Footer-column"][2]//a)${index ? `[${index}]` : ''}`,
  });

  public readonly FootermenuSection3 = () => this.derived({
    Desktop: '//div[@data-testid="Footer-column"][3]',
  });

  public readonly FootermenuSection3Links = () => this.derived({
    Desktop: '//div[@data-testid="Footer-column"][3]//a',
  });

  public readonly FootermenuSection3LinkByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="Footer-column"][3]//a)${index ? `[${index}]` : ''}`,
  });

  public readonly FootermenuSection4 = () => this.derived({
    Desktop: '//div[@data-testid="Footer-column"][4]',
  });

  public readonly FootermenuSection4Links = () => this.derived({
    Desktop: '//div[@data-testid="Footer-column"][4]//a',
  });

  public readonly FootermenuSection4LinkByIndex = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="Footer-column"][4]//a)${index ? `[${index}]` : ''}`,
  });

  public readonly FooterMobileMenuExpandByIndex = (index?: number) => this.derived({
    Mobile: `(//button[@data-testid="footer-mobile-menu-trigger"])${index ? `[${index}]` : ''}`,
  });

  // #region Country selection
  public readonly CountrySelectSection = () => this.derived({
    Desktop: '//*[@data-testid="Footer-component"]//div[@data-testid="LocaleSelect-component"]',
  });

  public readonly CountryDropdown = (text?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//label[@data-testid="country-select"]',
      optionSelector: `//*[@data-testid="country-select-component"]//ul//li[contains(.,"${text || ''}")]`,
    },
    Mobile: {
      dropdownSelector: '//div[@data-testid="Footer-LocaleSelect-component"]//label[@data-testid="country-select"]',
      optionSelector: `//div[@data-testid="Footer-LocaleSelect-component"]//select[@data-testid='country-native-select']//option[contains(text(),"${text || ''}")] | //div[@data-testid="Footer-LocaleSelect-component"]//*[@data-testid='select-component-options-list']//li[contains(text(),"${text || ''}")]`,
    },
  });

  public readonly LanguageDropdown = (text?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//label[@data-testid="lang-select"]',
      optionSelector: `//*[@data-testid="language-select-component"]//ul//li[contains(.,"${text || ''}")]`,
    },
    Mobile: {
      dropdownSelector: '//div[@data-testid="Footer-LocaleSelect-component"]//label[@data-testid="lang-select"]',
      optionSelector: `//div[@data-testid="Footer-LocaleSelect-component"]//select[@data-testid='language-native-select']//option[contains(text(),"${text || ''}")] | //*[@data-testid="language-select-component"]//ul//li[contains(.,"${text || ''}")]`,
    },
  });

  public readonly CountrySwitchButton = () => this.derived({
    Desktop: '//div[@data-testid="Footer-LocaleSelect-component"]//*[@data-testid="pvh-button" and contains(@class,"Locale")]',
  });

  public readonly CountryDropdownOpen = () => this.derived({
    Mobile: '//div[@data-testid="Footer-LocaleSelect-component"]//*[@data-testid="footer-mobile-menu-trigger"]',
  });
  // #endregion
}
