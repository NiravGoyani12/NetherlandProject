/* eslint-disable max-len */
/* eslint-disable no-await-in-loop */
import { Then, When } from '@pvhqa/cucumber';
import services from '../../../core/services';
import {
  CollapseSpecificFilter,
  CloseFilterPanelOnMobile, OpenFilterPanelOnMobile, OpenSpecificFilter, SelectFilterOption, FilterScrollIntoViewport, GetFiltersWithNumberOptionsLessThan, SelectSortByOption,
} from '../../helper/filter.helper';
import {
  exist$, maybeDisplayed$, maybeExist$$, whenPageLoaded,
} from '../../general';
import { sleep } from '../../helper/utils.helper';

When(/in unified PLP I ensure filter panel is opened/, async () => {
  await OpenFilterPanelOnMobile();
});

When(/in unified PLP I ensure filter panel is closed/, async () => {
  await CloseFilterPanelOnMobile();
});

When(/^in unified filter panel I open filter type ([^\s]+)(?: and (?:deselect|select) ([^\s]+) as filter option)?( faceted|)?( and panel stays open)?$/, async (filterType: string, filterOption: string, faceted: string, panelOpen: string) => {
  await OpenFilterPanelOnMobile();
  await OpenSpecificFilter(filterType);
  if (filterOption) {
    await SelectFilterOption(filterOption, filterType, faceted);
    if (!panelOpen) { await CloseFilterPanelOnMobile(); }
  }
});

When(/in unified filter panel I close filter type ([^\s]+)?/, async (filterType: string) => {
  await OpenFilterPanelOnMobile();
  await CollapseSpecificFilter(filterType);
});

When(/in unified filter panel I (?:deselect|select) ([^\s]+) as filter option/, async (filterOption: string) => {
  await OpenFilterPanelOnMobile();
  await SelectFilterOption(filterOption);
  await CloseFilterPanelOnMobile();
});

Then(/in unified filter panel I (?:wait until|see) filter type ([^\s]+) with (filter|collapsed facet) ([^\s]+) is( not)? active(?: in (\d+) seconds?)?/, async (filterName: string, filterType: string, filterOptionName: string, filterNotActive: string, timeoutInSeconds: number) => {
  await services.site.extractSiteInfo();
  // eslint-disable-next-line no-restricted-globals
  const translatedFilterOptionName = !isNaN(Number(filterOptionName)) ? filterOptionName
    : services.translation.get(services.site.siteInfo.LOCALENAME.toLowerCase(),
      filterOptionName).toLowerCase();
  const timeout = timeoutInSeconds
    ? timeoutInSeconds * 1000
    : services.env.DriverConfig.timeout.elementDisplayed;
  const activeFiltersText = [];
  let filterIsActive: boolean;
  if (services.env.IsDesktop) {
    const ActiveFilterRegion = await exist$('Experience.PlpFilters.ActiveFilterRegion');
    await ActiveFilterRegion.scrollIntoView();
  }
  await OpenFilterPanelOnMobile();
  if (filterName) {
    const translatedfilterType = services.translation
      .get(services.site.siteInfo.LOCALENAME.toLowerCase(), filterName);
    const filterShowMoreButtonSelector = await services.pageObject.getSelector('Experience.PlpFilters.FilterShowMoreButton', [translatedfilterType]);
    const filterShowMoreButton = await maybeDisplayed$(filterShowMoreButtonSelector, 5000);
    if (filterShowMoreButton && filterType !== 'collapsed facet') {
      await FilterScrollIntoViewport(filterShowMoreButton);
      await filterShowMoreButton.safeClick();
    }
  }
  return whenPageLoaded(async () => {
    const res = await browser.waitUntil(
      async () => {
        const activeFilters = filterType === 'filter'
          ? await maybeExist$$('Experience.PlpFilters.ActiveFilterLabels', undefined, timeout)
          : await maybeExist$$('Experience.PlpFilters.ActiveFilterOptions', undefined, timeout);
        activeFilters.forEach(async (activeFilter) => {
          const activeFilterText = (await activeFilter.getTextByJs()).toLowerCase();
          if (activeFiltersText.indexOf(activeFilterText) === -1) {
            activeFilterText.split(',').forEach((text) => activeFiltersText.push(text.trim()));
          }
          filterIsActive = activeFiltersText.includes(translatedFilterOptionName.toLocaleLowerCase());
        });

        // solution to idenfity active filter option with item count from nested span
        if (filterIsActive === false) {
          const matches = activeFiltersText.filter((s) => s.includes(translatedFilterOptionName.toLocaleLowerCase()));
          if (matches.length > 0) {
            filterIsActive = true;
          }
        }

        return filterIsActive === !filterNotActive;
      },
      {
        timeout,
        timeoutMsg: `Expected: filter "${translatedFilterOptionName}" should${filterNotActive || ''} be active. Actual: active filters are "${activeFiltersText.toString()}".`,
      },
    );
    await CloseFilterPanelOnMobile();
    return res;
  });
});

When(/^in unified filter panel I select (\d+) random filter options?$/, async (filterOptionNumber: number) => {
  await OpenFilterPanelOnMobile();
  let filterOptionCount = 0;
  let filterCount = 1;
  let filterOption: WebdriverIO.Element;
  /*
  * 1st while is responsible for looping inside each filter container
  * Inside 1st while specific filter container is opened,
  * filters options are selected (2nd while), and container is closed
  */
  while (filterOptionCount < filterOptionNumber && filterCount < 10) {
    let filterSelector = await services.pageObject.getSelector(
      'Experience.PlpFilters.FilterOptionsInsideContainer', [filterCount + 1],
    );
    let filterHasOption = (await maybeExist$$(
      filterSelector, undefined, 1000,
    )).length > 1;
    if (filterHasOption) {
      await OpenSpecificFilter(undefined, filterCount);
      let i = 0;
      /* 2nd while is responsible for looping through filter options
      * 2nd while selects max 3 filter options in opened filter container
      * if there are less than 3 available options, the loop will exit to 1st while
      */
      while (filterHasOption && i < 3 && filterOptionCount < filterOptionNumber) {
        filterSelector = await services.pageObject.getSelector(
          'Experience.PlpFilters.FilterOptionsInsideContainer', [filterCount + 1],
        );
        filterOption = (await maybeExist$$(filterSelector, undefined, 2000))[i];
        /* This is a workaround to avoid clicking XXS because when XXS is selected,
        * then it only gives very small number of product results
        * (and removes other filters chosen)
        */
        const internalOptionsCount = (await maybeExist$$(filterSelector, undefined, 2000)).length;
        const textToCheck = await filterOption.getTextByJs();
        if (textToCheck.toUpperCase().includes('XXS')) {
          filterOption = (await maybeExist$$(filterSelector,
            undefined, 2000))[internalOptionsCount - 1];
        }
        if (services.env.IsDesktop) {
          await FilterScrollIntoViewport(filterOption);
          await filterOption.jsClick();
        } if (services.env.IsMobile) {
          await filterOption.swipeToElementMobile();
          await filterOption.jsClick();
        }
        await sleep(2000);
        filterSelector = await services.pageObject.getSelector(
          'Experience.PlpFilters.FilterOptionsInsideContainer', [filterCount + 1],
        );
        filterHasOption = (await maybeExist$$(filterSelector, undefined, 1000)).length > i + 1;
        i += 1;
        filterOptionCount += 1;
      }
      CollapseSpecificFilter(undefined, filterCount);
      if (services.env.IsMobile) {
        // This is to check that the Filter Button fits the regex
        await (await (await exist$('Experience.PlpFilters.ApplyFilterButton')).getText()).match(/[A-Z ]+[(]+[0-9]+[)]/);
        await (await exist$('Experience.PlpFilters.ApplyFilterButton')).jsClick();
      }
    }
    filterCount += 1;
  }
});

When(/in unified filter panel I (open|close) (all||first) filters? with (less||more) than (\d+) options( and less than 20 options)?/, async (action: string, allFilters: string, compareType: string, numberOptions: number, upperLimit: string) => {
  const applyToAllFilters = allFilters === 'all';
  const isLessThan = compareType === 'less';
  let availableFilters = await GetFiltersWithNumberOptionsLessThan(
    numberOptions, isLessThan, !!upperLimit,
  );
  if (!applyToAllFilters) {
    availableFilters = [availableFilters[0]];
  }
  let i = 0;
  while (i < availableFilters.length) {
    await FilterScrollIntoViewport(availableFilters[i]);
    const filterOpened = (await availableFilters[i].getAttribute('class')).indexOf('open') >= 0;
    if (filterOpened !== (action === 'open')) {
      await availableFilters[i].safeClick();
      await sleep(400);
    }
    i += 1;
  }
});

When(/in unified filter panel I open sorting option ([^\s]+)(?: and (?:deselect|select) ([^\s]+) as sort by option)?/, async (filterType: string, filterOption: string) => {
  await OpenFilterPanelOnMobile();
  await OpenSpecificFilter(filterType);
  if (filterOption) {
    await SelectSortByOption(filterOption);
    await CloseFilterPanelOnMobile();
  }
});
