/* eslint-disable max-len */
/* eslint-disable no-await-in-loop */
/* eslint-disable import/prefer-default-export */
import services from '../../core/services';
import {
  exist$, exist$$, maybeDisplayed$, maybeExist$, maybeExist$$,
} from '../general';
import { sleep } from './utils.helper';

export const OpenFilterPanelOnMobile = async () => {
  if (services.env.IsMobile) {
    let openFilterPanel;
    try {
      openFilterPanel = await (await maybeDisplayed$('Experience.PlpFilters.OpenedFilterPanel', 1000)).isDisplayedInViewport();
    } catch (err) {
      openFilterPanel = null;
    }

    if (!openFilterPanel) {
      await (await exist$('Experience.PlpFilters.FilterButton')).jsClick();
      await sleep(500);
    }
    await maybeDisplayed$('Experience.PlpFilters.OpenedFilterPanel', 1000);
  }
};

export const CloseFilterPanelOnMobile = async () => {
  if (services.env.IsMobile) {
    await (await exist$('Experience.PlpFilters.FilterCloseButton')).jsClick();
    await sleep(500);
    const openFilterPanel = await maybeDisplayed$('Experience.PlpFilters.OpenedFilterPanel', 500);
    if (openFilterPanel) {
      await (await (await exist$('Experience.PlpFilters.FilterCloseButton')).getText()).match(/[A-Z ]+[(]+[0-9]+[)]/);
      await (await exist$('Experience.PlpFilters.FilterCloseButton')).jsClick();
      await sleep(500);
    }
  }
};

export const FilterScrollIntoViewport = async (filter: WebdriverIO.Element) => {
  if (services.env.IsDesktop) {
    let isInViewport = await filter.isDisplayedInViewport();
    let i = 0;
    while (!isInViewport && i <= 10) {
      await browser.execute('window.scrollBy(0, 100)');
      await sleep(200);
      isInViewport = await filter.isDisplayedInViewport();
      i += 1;
    }
  }
};

export const OpenSpecificFilter = async (filterName?: string, filterIndex?: number) => {
  await services.site.extractSiteInfo();
  let filter: WebdriverIO.Element;
  let filterContainer: WebdriverIO.Element;
  let filterAccordionOpened = false;
  if (filterName) {
    const translatedFilterName = services.translation
      .get(services.site.siteInfo.LOCALENAME.toLowerCase(), filterName).toLocaleUpperCase();
    const filterSelector = await services.pageObject.getSelector('Experience.PlpFilters.FilterName', [translatedFilterName]);
    const filterContainerSelector = await services.pageObject.getSelector('Experience.PlpFilters.FilterContainer', [translatedFilterName]);
    filter = await exist$(filterSelector, 5000);
    filterContainer = await exist$(filterContainerSelector, 5000);
  } else if (filterIndex || filterIndex === 0) {
    filter = (await exist$$('Experience.PlpFilters.FilterName'))[filterIndex];
  }

  filterAccordionOpened = (await filterContainer.getAttribute('aria-expanded')).includes('true');

  if (!filterAccordionOpened) {
    if (services.env.IsDesktop) {
      await FilterScrollIntoViewport(filter);
      await filter.safeClick();
    } if (services.env.IsMobile) {
      await filter.swipeToElementMobile();
      await filter.jsClick();
    }
    await sleep(500);
  }
};

export const SelectFilterOption = async (filterName: string, filterType?: string, faceted?: string) => {
  await services.site.extractSiteInfo();
  let translatedFilterName;
  if (Number.isNaN(Number(filterName))) {
    translatedFilterName = services.translation
      .get(services.site.siteInfo.LOCALENAME.toLowerCase(), filterName).toLocaleUpperCase();
  } else {
    translatedFilterName = filterName;
  }
  if (filterType) {
    const translatedfilterType = services.translation
      .get(services.site.siteInfo.LOCALENAME.toLowerCase(), filterType);
    const filterShowMoreButtonSelector = await services.pageObject.getSelector('Experience.PlpFilters.FilterShowMoreButton', [translatedfilterType]);
    const filterShowMoreButton = await maybeExist$(filterShowMoreButtonSelector, 5000);
    if (filterShowMoreButton) {
      await FilterScrollIntoViewport(filterShowMoreButton);
      await filterShowMoreButton.safeClick();
    }
  }

  let filterOptionSelector;
  if (faceted) {
    filterOptionSelector = await services.pageObject.getSelector('Experience.PlpFilters.FilterOptionFaceted', [translatedFilterName]);
  } else {
    filterOptionSelector = await services.pageObject.getSelector('Experience.PlpFilters.FilterOption', [translatedFilterName]);
  }
  const filterOption = await exist$(filterOptionSelector, 5000);

  if (services.env.IsDesktop) {
    await FilterScrollIntoViewport(filterOption);
    await filterOption.safeClick();
  } if (services.env.IsMobile) {
    await filterOption.swipeToElementMobile();
    await filterOption.jsClick();
  }
  if (services.env.IsDesktop) {
    await sleep(3000);
  }
};

export const CollapseSpecificFilter = async (filterName?: string, filterIndex?: number) => {
  await services.site.extractSiteInfo();
  const translatedFilterName = services.translation
    .get(services.site.siteInfo.LOCALENAME.toLowerCase(), filterName).toLocaleUpperCase();
  let filter: WebdriverIO.Element;
  const filterContainerSelector = await services.pageObject.getSelector('Experience.PlpFilters.FilterContainer', [translatedFilterName]);
  const filterContainer = await exist$(filterContainerSelector, 5000);
  const filterAccordionOpened = (await filterContainer.getAttribute('aria-expanded')).includes('true');
  if (filterAccordionOpened) {
    if (filterName) {
      const filterSelector = await services.pageObject.getSelector('Experience.PlpFilters.FilterName', [translatedFilterName]);
      filter = await exist$(filterSelector);
    } else if (filterIndex || filterIndex === 0) {
      filter = (await exist$$('Experience.PlpFilters.FilterName'))[filterIndex];
    }

    await FilterScrollIntoViewport(filter);
    await filter.safeClick();
    await sleep(500);
  }
};

export const GetFiltersWithNumberOptionsLessThan = async (
  numberOptions: number, isLessThan: boolean, isUpperLimitSet: boolean,
) => {
  await services.site.extractSiteInfo();
  const availableFilters = await maybeExist$$('Experience.PlpFilters.FilterName');
  const filtersWithSpecificNumberOptions = [] as WebdriverIO.Element[];
  const filtersCount = availableFilters.length;
  let i = 1;
  while (i <= filtersCount) {
    const filterSelector = await services.pageObject.getSelector('Experience.PlpFilters.FilterOptionsInsideContainer', [i]);
    const optionCount = (await maybeExist$$(filterSelector, undefined, 1000)).length;
    const isColorFilter = (await availableFilters[i - 1].getText()).toLowerCase()
      .indexOf((services.translation.get(
        services.site.siteInfo.LOCALENAME.toLowerCase(), 'Colour',
      )).toLowerCase()) >= 0;
    const isPriceFilter = (await availableFilters[i - 1].getText()).toLowerCase()
      .indexOf((services.translation.get(
        services.site.siteInfo.LOCALENAME.toLowerCase(), 'Price',
      )).toLowerCase()) >= 0;
    if ((optionCount < numberOptions) === isLessThan && !isColorFilter && !isPriceFilter) {
      if (isUpperLimitSet) {
        if (optionCount <= 20) {
          filtersWithSpecificNumberOptions.push(availableFilters[i - 1]);
        }
      } else {
        filtersWithSpecificNumberOptions.push(availableFilters[i - 1]);
      }
    }
    i += 1;
  }
  if (!filtersWithSpecificNumberOptions.length) {
    throw new Error('No available filters found. This is 100% data issue.');
  }
  return filtersWithSpecificNumberOptions;
};

export const SelectSortByOption = async (filterName: string) => {
  await services.site.extractSiteInfo();
  const translatedFilterName = services.translation
    .get(services.site.siteInfo.LOCALENAME.toLowerCase(), filterName).toLocaleUpperCase();
  const filterOptionSelector = await services.pageObject.getSelector('Experience.PlpFilters.SortByOption', [translatedFilterName]);
  const filterOption = await exist$(filterOptionSelector);
  if (services.env.IsDesktop) {
    await FilterScrollIntoViewport(filterOption);
    await filterOption.safeClick();
  } if (services.env.IsMobile) {
    await filterOption.swipeToElementMobile();
    await filterOption.jsClick();
  }
  if (services.env.IsDesktop) {
    await sleep(2000);
  }
};
