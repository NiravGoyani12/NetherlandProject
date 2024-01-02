import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';


@Singleton
export default class SizeGuide extends Page {
  public readonly SizeGuideCategories = (index?: number) => this.derived({
    Desktop: `(//div[@class="size-guide-landing__category"])${index ? `[${index}]` : ''}`,
    Mobile: `(//div[@class="size-guide-landing-mobile"]/a)${index ? `[${index}]` : ''}`,
  });

  public readonly SizeGuideLinks = (href?: string) => this.derived({
    Desktop: `//div[@class="_1WXmASUw"]//a[contains(@href,"${href || ''}")]`,
    Mobile: `//div[@class="mJeFRZsA"]/a[contains(@href,"${href || ''}")]`,
  });

  public readonly SizeGuideLinksTH = (href?: string) => this.derived({
    Desktop: `//div[@data-testid="DynamicModule-image-cta-component"]//a[contains(@href,"${href || ''}")]`,
    Mobile: `//div[@data-testid="DynamicModule-image-cta-component"]//a[contains(@href,"${href || ''}")]`,
  });

  public readonly SizeGuideCategoriesImage = () => this.derived({
    Desktop: '//div[@class="size-guide-landing__category"]//img',
    Mobile: '//div[@class="size-guide-landing-mobile"]//img',
  });

  public readonly WomenSizeGuidePageTitle = () => this.derived({
    Desktop: '//h1[@class="pageTitle"]',
    Mobile: '//h1[@class="pageTitle"]',
  });

  public readonly WomenSizeGuidePageTitleTH = () => this.derived({
    Desktop: '//div[@class="THPageHeader__title"]',
    Mobile: '//div[@class="THPageHeader__title"]',
  });

  public readonly WomenSizeGuideTables = () => this.derived({
    Desktop: '//div[@data-testid="sizeGuideCollectionWrapper"]',
    Mobile: '//div[@data-testid="sizeGuideCollectionWrapper"]',
  });

  public readonly WomenSizeGuideTablesTH = () => this.derived({
    Desktop: '//div[@class="THTables__wrap"]',
    Mobile: '//div[@class="THTables__wrap"]',
  });

  public readonly SizeGuideTableToggleByIndex = (index?: number) => this.derived({
    Desktop: `(//button[@class="SizeGuideTable__header-toggle-button"])${index ? `[${index}]` : ''}`,
  });

  public readonly SizeGuideTableToggleByIndexTH = (index?: number) => this.derived({
    Desktop: `(//div[@class="THCMTable__unitSwitcher"])${index ? `[${index}]` : ''}`,
  });

  public readonly SizeGuideTableMetricUnits = (index?: number) => this.derived({
    Desktop: `(//button[contains(@class,"header-toggle-button__metric-selected")])${index ? `[${index}]` : ''}`,
  });

  public readonly SizeGuideTableImperialUnits = (index?: number) => this.derived({
    Desktop: `(//button[contains(@class,"header-toggle-button__imperial-selected")])${index ? `[${index}]` : ''}`,
  });

  public readonly SizeGuideTableValueByColumn = (index?: number) => this.derived({
    Desktop: `(//div[@class="sizeGuideSpecialTable"]//tr//td)${index ? `[${index}]` : ''}`,
    Mobile: `(//div[@class="sizeGuideRowTable"]//tr//td)${index ? `[${index}]` : ''}`,
  });

  public readonly SizeGuideTablePrevIcon = () => this.derived({
    Desktop: '//table[@class="fixedHeadTable"]//button[contains(@class,"prevIcon")]',
  });

  public readonly SizeGuideTableNextIcon = () => this.derived({
    Desktop: '//table[@class="fixedHeadTable"]//button[contains(@class,"nextIcon")]',
  });

  public readonly SizeGuideHowToMeasureMySelfButton = () => this.derived({
    Desktop: '//div[contains(@class,"sizeGuideHowTo")]//button',
  });

  public readonly SizeGuideHowToMeasureMySelfModal = () => this.derived({
    Desktop: '//div[@data-testid="ck-modal"]//div//div[@data-qa="modal-content"]',
  });

  public readonly SizeGuideHowToMeasureCloseButton = () => this.derived({
    Desktop: '//button[@data-qa="modal-close-btn"]',
  });

  public readonly SizeGuideHowToMeasureModalImage = () => this.derived({
    Desktop: '//div[@data-testid="ck-modal"]//div//div[@data-qa="modal-content"]//img',
  });
}
