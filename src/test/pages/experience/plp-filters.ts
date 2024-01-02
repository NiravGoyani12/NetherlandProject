import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class PlpFilters extends Page {
  public readonly FilterButton = () => this.derived({
    Mobile: '//button[@data-testid="plp-filter-by-mobile-pvh-button"]',
  });

  public readonly FilterCloseButton = () => this.derived({
    Mobile: '//button[@data-testid="pvh-icon-button" and contains(@class, "CloseButton")]',
  });

  public readonly FilterCloseButtonText = (text?: string) => this.derived({
    Mobile: `//*[@data-testid="pvh-drawer-Modal-component"]//button[@data-testid="product-list-close-pvh-button"]//div[${text ? `contains(text(), '${text.toLowerCase()}') or contains(text(), '${text}')` : ''}]`,
  });

  public readonly OpenedFilterPanel = () => this.derived({
    Mobile: '//div[@data-testid="pvh-drawer-Modal-component"]|//header[@data-testid="product-list-drawer-header"]',
    Desktop: '//div[contains(@class,"expanded")]',
  });

  public readonly OpenedFilter = () => this.derived({
    Mobile: '//*[@data-testid ="pvh-drawer-Modal-component"]//div[contains(@class, "catalog-facets__group") and not(contains(@class, "isMobile"))]//h5[contains(@class, "catalog-facets__group-label") and contains(@class, "open") and not(contains(@class, "catalog-facets__group-label--pricefilter")]',
  });

  public readonly ApplyFilterButton = () => this.derived({
    Mobile: '//*[@data-testid ="pvh-drawer-Modal-component"]//button[@data-testid="product-list-all-results-pvh-button"]',
  });

  public readonly ApplyFilterButtonText = (text?: string) => this.derived({
    Mobile: `//*[@data-testid ="pvh-drawer-Modal-component"]//button[@data-testid="product-list-all-results-pvh-button"]//div[${text ? `contains(text(), '${text.toLowerCase()}') or contains(text(), '${text}')` : ''}]`,
  });

  public readonly FilterShowMoreButton = (filterType?: string) => this.derived({
    Desktop: `//*[contains(@data-testid,"${filterType}-link-showmore-listItem")]//button`,
    Mobile: `//*[@data-testid ="pvh-drawer-Modal-component"]//*[contains(@data-testid,"${filterType}-link-showmore-listItem")]//button`,
  });

  public readonly FilterName = (filterName?: string) => this.derived({
    Desktop: `//button[@data-testid = "accordion-trigger"]${filterName ? `//span[contains(translate(., 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ'), "${filterName}")]` : ''}`,
    Mobile: `//*[@data-testid ="pvh-drawer-Modal-component"]${filterName ? `//span[contains(translate(., 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ'), "${filterName}")]` : ''}`,
  });

  public readonly FilterNameAccordion = (filterName?: string) => this.derived({
    Desktop: `//button[@data-testid="accordion-trigger"]${filterName ? `/span[contains(translate(., 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ'), "${filterName}")]/parent::button/following-sibling::div[@data-testid="accordion-collapse"]` : ''}`,
    Mobile: `//*[@data-testid ="pvh-drawer-Modal-component"]${filterName ? `/span[contains(translate(., 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ'), "${filterName}")]/parent::button/following-sibling::div[@data-testid="accordion-collapse"]` : ''}`,
  });

  public readonly FilterContainer = (filterName?: string) => this.derived({
    Desktop: `//button[@data-testid = "accordion-trigger"]${filterName ? `//span[contains(translate(., 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ'), "${filterName}")]` : ''}/parent::button`,
    Mobile: `//*[@data-testid ="pvh-drawer-Modal-component"]${filterName ? `//span[contains(translate(., 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ'), "${filterName}")]` : ''}/parent::button`,
  });

  public readonly FilterChecked = (filterName?: string) => this.derived({
    Desktop: `//button[@data-testid = "accordion-trigger"]${filterName ? `//span[contains(translate(., 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ'), "${filterName}")]` : ''}/preceding-sibling::input`,
    Mobile: `//*[@data-testid ="pvh-drawer-Modal-component"]${filterName ? `//span[contains(translate(., 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ'), "${filterName}")]` : ''}/preceding-sibling::input`,
  });

  public readonly FilterOption = (filterOption: string) => this.derived({
    Desktop: `//*[@data-testid="PlpMultiselectFilter"]//*[contains(@data-testid,"Checkbox-Component-content")${filterOption ? ` and translate(text(), 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ') = "${filterOption}"` : ''}] | //*[@data-testid="PlpMultiselectFilter"]//*[contains(@data-testid,"Checkbox-Component-content")]//a${filterOption ? `[translate(text(), 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ') = "${filterOption}"` : ''}]`,
    Mobile: `//*[@data-testid ="pvh-drawer-Modal-component"]//*[@data-testid="PlpMultiselectFilter"]//*[contains(@data-testid,"Checkbox-Component-content")${filterOption ? ` and translate(text(), 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ') = "${filterOption}"` : ''}] | //*[@data-testid="PlpMultiselectFilter"]//*[contains(@data-testid,"Checkbox-Component-content")]//a${filterOption ? `[translate(text(), 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ') = "${filterOption}"` : ''}]`,
  });

  public readonly FilterOptionsCount = () => this.derived({
    Desktop: '//*[@data-testid="PlpMultiselectFilter"]//*[contains(@data-testid,"Checkbox-Component-content")]/span',
    Mobile: '//*[@data-testid ="pvh-drawer-Modal-component"]//*[@data-testid="PlpMultiselectFilter"]//*[contains(@data-testid,"Checkbox-Component-content")]/span',
  });

  public readonly FilterOptionWithCountZero = () => this.derived({
    Desktop: '//*[@data-testid="PlpMultiselectFilter"]//*[contains(@data-testid,"Checkbox-Component-content")]/span[text()[2]="0"]',
    Mobile: '//*[@data-testid ="pvh-drawer-Modal-component"]//*[@data-testid="PlpMultiselectFilter"]//*[contains(@data-testid,"Checkbox-Component-content")]/span[text()[2]="0"]',
  });

  public readonly FilterOptionFaceted = (filterOption: string) => this.derived({
    Desktop: `//*[@data-testid="PlpMultiselectFilter"]//*[contains(@data-testid,"Checkbox-Component-content")]//a${filterOption ? `[translate(text(), 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ') = "${filterOption}"` : ''}]`,
    Mobile: `//*[@data-testid ="pvh-drawer-Modal-component"]//*[@data-testid="PlpMultiselectFilter"]//*[contains(@data-testid,"Checkbox-Component-content")]//a${filterOption ? `[translate(text(), 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ') = "${filterOption}"` : ''}]`,
  });

  public readonly FilterOptionsInsideContainer = (index: any) => this.derived({
    Desktop: `//*[@data-testid="PlpMultiselectFilter"][${index}]//*[contains(@data-testid,"Checkbox-Component-icon")]`,
    Mobile: `//*[@data-testid ="pvh-drawer-Modal-component"]//*[@data-testid="PlpMultiselectFilter"][${index}]//*[contains(@data-testid,"Checkbox-Component-icon")]`,
  });

  public readonly ActiveFilterLabels = () => this.derived({
    Desktop: '//button[@data-testid="activeFacet"]',
    Mobile: '//*[@data-testid="PlpMultiselectFilter"]//input[@aria-checked="true"]/following-sibling::*[contains(@data-testid,"Checkbox-Component-content")]',
  });

  public readonly ActiveFilterRegion = () => this.derived({
    Desktop: '//*[@data-testid="ActiveFilters-component"]',
  });

  public readonly ActiveFilterOptions = () => this.derived({
    Desktop: '//*[@data-testid="accordion-trigger"]//div[contains(@class,"subheading")]',
    Mobile: '//*[@data-testid ="pvh-drawer-Modal-component"]//*[@data-testid="accordion-trigger"]//div[contains(@class,"subheading")]',
  });

  public readonly ActiveFilterOptionsText = () => this.derived({
    Desktop: '//*[@data-testid="accordion-trigger"]//div[contains(@class,"subheading")]',
    Mobile: '//*[@data-testid ="pvh-drawer-Modal-component"]//*[@data-testid="accordion-trigger"]//div[contains(@class,"subheading")]',
  });

  public readonly FilterResetAll = () => this.derived({
    Desktop: '//*[@data-testid="resetAllButton"]',
    Mobile: '//*[@data-testid="pvh-drawer-Modal-component"]//*[@data-testid="product-list-reset-pvh-button"]',
  });

  public readonly FilterResetAllText = (text?: string) => this.derived({
    Mobile: `//*[@data-testid="pvh-drawer-Modal-component"]//*[@data-testid="product-list-reset-pvh-button"]//div[${text ? `contains(text(), '${text.toLowerCase()}') or contains(text(), '${text}')` : ''}]`,
  });

  public readonly PriceFilterMin = () => this.derived({
    Desktop: '//span[@data-testid="slider-price-min"]',
  });

  public readonly PriceFilterMax = () => this.derived({
    Desktop: '//span[@data-testid="slider-price-max"]',
  });

  public readonly OnSalePriceFilter = (filterOption: string) => this.derived({
    Desktop: `//div[@data-testid="1-Checkbox-Component-content"${filterOption ? ` and translate(., 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ') = "${filterOption.toLocaleUpperCase()}"` : ''}]`,
  });

  // SortBy filter region
  public readonly SortByOption = (filterOption: string) => this.derived({
    Desktop: `//*[@data-testid="plp-sort-filters"]//*[@data-testid="RadioButton-Component-content"${filterOption ? ` and translate(., 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ') = "${filterOption.toLocaleUpperCase()}"` : ''}]`,
    Mobile: `//*[@data-testid="plp-sort-filters"]//*[@data-testid="RadioButton-Component-input"${filterOption ? ` and following-sibling::div[translate(., 'abcdefghijklmnopqrstuvwxyzáàåäæçéèêíìîñóòôöøúùü', 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÅÄÆÇÉÈÊÍÌÎÑÓÒÔÖØÚÙÜ') = "${filterOption.toLocaleUpperCase()}"` : ''}]]`,
  });

  public readonly SortByActiveFilterOption = () => this.derived({
    Desktop: '//*[@data-testid="plp-sort-filters"]//div[contains(@class,"subheading")]',
  });

  public readonly ActiveSortByOptionLabel = () => this.derived({
    Desktop: '//span[@class="catalog-facets__button-text"]',
  });

  public readonly MobileFilterByButton = () => this.derived({
    Desktop: '//*[@data-testid="plp-sort-filters"]/following-sibling::button[@data-testid="pvh-button"]',
  });

  public readonly MobileSortByButton = () => this.derived({
    Desktop: '//*[@data-testid="plp-sort-filters"]/following-sibling::button[@data-testid="plp-sort-by-mobile-pvh-button"]',
  });

  public readonly BubbleFilter = (index?: number) => this.derived({
    Desktop: `(//*[@data-testid="MoreForYouBubbleFilter"])${index ? `[${index}]` : ''}`,
  });

  public readonly BubbleFilterSelected = (index?: number) => this.derived({
    Desktop: `(//*[@data-testid="MoreForYouBubbleFilter" and contains(@class,"selected")])${index ? `[${index}]` : ''}`,
  });
}
