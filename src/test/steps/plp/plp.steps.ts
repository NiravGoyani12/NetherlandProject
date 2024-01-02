/* eslint-disable no-loop-func */
/* eslint-disable no-bitwise */
/* eslint-disable radix */
/* eslint-disable no-await-in-loop */
import { When } from '@pvhqa/cucumber';
import services from '../../../core/services';
import { exist$, maybeExist$, maybeExist$$ } from '../../general';
import { sleep } from '../../helper/utils.helper';
import { getPageInformation } from '../transformers.steps';

When(/in unified PLP I click (next|previous) page button(?: ([^\s]+) times)?/, async (buttonType: string, clickCount?: number) => {
  let selector;

  clickCount = Number(clickCount);
  if (!clickCount) {
    clickCount = 1;
  }

  const elements = await (await maybeExist$$('Experience.PlpProducts.ProductListItems'));
  const elementCount = elements.length;

  const elementSelector = await services.pageObject.getSelector('Experience.PlpProducts.ProductListItems', [elementCount]);

  const lastElementOnPage = await exist$(elementSelector);
  await lastElementOnPage.scrollIntoView({ block: 'center' });
  await browser.execute('window.scrollBy(0, 100)');

  if (buttonType === 'next') {
    selector = await services.pageObject.getSelector(
      'Experience.PlpPagination.NextButton',
    );
  } else {
    selector = await services.pageObject.getSelector(
      'Experience.PlpPagination.PreviousButton',
    );
  }
  for (let i = 0; i < clickCount; i += 1) {
    const ele = await exist$(selector);
    await ele.safeClick();
    const timeout = services.env.DriverConfig.timeout.pageLoad;
    const page = 'Experience.PlpProducts';
    await browser.waitUntil(async () => {
      const isLoaded = await services.pageObject.doFunction<boolean>(`${page}.isLoaded`);
      return isLoaded === true;
    },
    {
      timeout,
      timeoutMsg: `${page} is not loaded within ${timeout} ms`,
      interval: 2000,
    });
  }
});

When(/in unified (search|category) ([^\s]+) PLP for locale (default|[^\s]+)(?: of langCode (default|[^\s]+))? I (verify page numbers and navigate|verify item count and navigate|navigate) to (first|last) page using buttons/, async (
  plpType: string,
  searchOrCategoryName: string,
  locale: string,
  langCode: string,
  doVerification: string,
  goToWhichPage: string) => {
  await services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();

  let elementCount: any; // The final listed product to scroll to
  let itemCount: number; // The final number of products viewed
  let pageitemsarray = []; // Items per page
  let pageitemsTotals: number = 0; // Number used to caluclate final number of products viewed
  let pageitemsarrayTotals = []; // Item totals viewed per page
  let itemPerPage = 0; // Item per page

  const listingPageCount: number = await getPageInformation('lastPageNumber', plpType, searchOrCategoryName, locale, langCode);
  const totalItemCount: number = await getPageInformation('totalItemCount', plpType, searchOrCategoryName, locale, langCode);
  const lastPageItemCount: number = await getPageInformation('lastPageItemCount', plpType, searchOrCategoryName, locale, langCode);

  const currentPageNumberSelector = await services.pageObject.getSelector(
    'Experience.PlpPagination.CurrentPageNumber',
  );

  const nextButtonSelector = await services.pageObject.getSelector(
    'Experience.PlpPagination.NextButton',
  );

  const previousButtonSelector = await services.pageObject.getSelector(
    'Experience.PlpPagination.PreviousButton',
  );

  const viewedOfItemsSelector = await services.pageObject.getSelector(
    'Experience.PlpPagination.ViewedOfItems',
  );

  const alreadyOnLastPage = (await browser.getUrl()).includes(`?page=${listingPageCount}`);

  if (alreadyOnLastPage) {
    itemPerPage = (totalItemCount - lastPageItemCount) / (listingPageCount - 1);
  } else {
    const viewedOfItemsText = (await maybeExist$(viewedOfItemsSelector)).getText();
    const itemPerPageText = ((await viewedOfItemsText).match(/\d+/g))[0];
    itemPerPage = Number(itemPerPageText);
  }

  const productPages = ~~(totalItemCount / itemPerPage);

  for (let item = 1; item <= ~~productPages; item += 1) {
    pageitemsarray.push(itemPerPage);
    pageitemsTotals += itemPerPage;
    pageitemsarrayTotals.push(pageitemsTotals);
  }

  // Calculates the remainder, identifying number of products on last page
  const remainderlastproductpage = totalItemCount % itemPerPage;

  // Add remainder Items last page and do addition for Items totals viewed per page
  if (remainderlastproductpage !== 0) {
    pageitemsTotals += remainderlastproductpage;
    pageitemsarray.push(remainderlastproductpage);
    pageitemsarrayTotals.push(pageitemsTotals);
  }

  // If the direction is to from first to last leave the array, otherwise reverse it.
  pageitemsarray = goToWhichPage.includes('last') ? pageitemsarray : pageitemsarray.reverse();
  pageitemsarrayTotals = goToWhichPage.includes('last') ? pageitemsarrayTotals : pageitemsarrayTotals.reverse();

  // this is the page number count only used if landing on last page as starting point of tests
  let reverseCount = listingPageCount + 1;

  // start the loop to go from page to page
  for (let i = 1; i < listingPageCount + 1; i += 1) {
    reverseCount -= 1;

    // scroll down to the pagination elements
    await sleep(1000);
    const elements = await maybeExist$$('Experience.PlpProducts.ProductListItems');
    elementCount = elements.length;
    const elementSelector = await services.pageObject.getSelector('Experience.PlpProducts.ProductListItems', [elementCount]);
    const lastProductOnPage = await exist$(elementSelector);
    await lastProductOnPage.scrollIntoView({ block: 'center' });
    await browser.execute('window.scrollBy(0, 100)');

    // do the page number verification if indicated in the step
    if (doVerification.includes('page numbers')) {
      const pageNumberElement = await exist$(currentPageNumberSelector);
      const textList = await Promise.all([pageNumberElement.getTextByJs(),
        pageNumberElement.getText(), pageNumberElement.getValue()]);
      let actualText = textList[0] || textList[1] || textList[2];
      actualText = await parseInt(actualText).toString();
      const expectedPageNumber = goToWhichPage.includes('last') ? i : reverseCount;
      if (actualText.trim() !== expectedPageNumber.toString().trim()) {
        throw new Error(`Error: Page number selector ${currentPageNumberSelector} does not contain text ${expectedPageNumber}`);
      }
    }

    // do the item count verification (as displayed in the pagination element)
    // if indicated in the step
    if (doVerification.includes('item count')) {
      itemCount = pageitemsarrayTotals[i - 1];

      const totalItemDisplayedElement = await exist$(viewedOfItemsSelector);
      const textList = await Promise.all([totalItemDisplayedElement.getTextByJs(),
        totalItemDisplayedElement.getText(), totalItemDisplayedElement.getValue()]);
      const actualText = textList[0] || textList[1] || textList[2];

      if (i === listingPageCount) {
        if (!actualText.trim().includes(totalItemCount.toString())) {
          throw new Error(`Error: Listing page count selector ${currentPageNumberSelector} does not contain text ${totalItemCount.toString()}`);
        }
      } else if (!actualText.trim().includes(itemCount.toString())) {
        throw new Error(`Error: Listing page count selector ${currentPageNumberSelector} does not contain text ${itemCount.toString()}`);
      }
    }

    // click previous or next button
    if (goToWhichPage.includes('first') && i < listingPageCount) {
      const previousButtonElement = await exist$(previousButtonSelector);
      await previousButtonElement.safeClick();
    } else if (i < listingPageCount) {
      const nextButtonElement = await exist$(nextButtonSelector);
      await nextButtonElement.safeClick();
    }

    const timeout = services.env.DriverConfig.timeout.pageLoad;
    const page = 'Experience.PlpProducts';
    await browser.waitUntil(async () => {
      const isLoaded = await services.pageObject.doFunction<boolean>(`${page}.isLoaded`);
      return isLoaded === true;
    },
    {
      timeout,
      timeoutMsg: `${page} is not loaded within ${timeout} ms`,
      interval: 2000,
    });
  }
});

When(/in unified PLP I( smoothly)? scroll down to the (\d+)(?:st|nd|rd|th|)? listing item/, async (scrollBehavior: string, itemIndex: number) => {
  const listingPage = Math.ceil(itemIndex / 48);
  const isSmoothScroll = !!scrollBehavior;
  for (let i = 1; i < listingPage; i += 1) {
    const elementSelector = await services.pageObject.getSelector(
      'Experience.PlpProducts.ProductGridItems', [48 * i],
    );
    const lastElementOnPage = await exist$(elementSelector);
    if (isSmoothScroll) {
      await lastElementOnPage.smoothScrollToElement();
      await browser.execute('window.scrollBy(0, 300)');
    } else {
      await lastElementOnPage.scrollIntoView({ block: 'center' });
      await browser.execute('window.scrollBy(0, 100)');
    }
  }
  const elementSelector = await services.pageObject.getSelector(
    'Experience.PlpProducts.ProductGridItems', [itemIndex],
  );
  const elementToScroll = await exist$(elementSelector);
  if (isSmoothScroll) {
    await elementToScroll.smoothScrollToElement();
  } else {
    await elementToScroll.scrollIntoView({ block: 'center' });
  }
});

When(/I( smoothly)? scroll down to unified PLP item ([^\s]+)/, async (scrollBehavior: string, itemIndex: string) => {
  itemIndex = await services.world.parse(itemIndex.toString());
  const isSmoothScroll = !!scrollBehavior;
  const elementSelector = await services.pageObject.getSelector(
    'Experience.PlpProducts.ListingItems', [itemIndex],
  );
  const elementToScroll = await exist$(elementSelector);
  if (isSmoothScroll) {
    await elementToScroll.smoothScrollToElement();
  } else {
    await elementToScroll.scrollIntoView({ block: 'center' });
  }
});

When(/in unified PLP I extract (\d+)(?:st|nd|rd|th|) (product style colour partnumber|product style partnumber) saved as (#[A-Za-z0-9]+)/, async (index: number, type: string, key: string) => {
  const selector = await services.pageObject.getSelector(
    'Experience.PlpProducts.ProductListItems', [index],
  );
  const ele = await exist$(selector);
  const styleColourPartNumber = await ele.getAttribute('href');
  let result: string;
  if (type === 'product style colour partnumber') {
    result = styleColourPartNumber.split('-').pop().toUpperCase();
  } else {
    result = styleColourPartNumber.split('-').pop().slice(0, -3).toUpperCase();
  }
  services.world.store(key, result);
});

When(/I navigate to the plp page with page number ([^\s]+)/, async (pageNumberOrKey: string) => {
  const currentUrl = await browser.getUrl();
  let pageIndex = '1';
  if (pageNumberOrKey.includes('#')) {
    pageIndex = services.world.parse(pageNumberOrKey);
  } else {
    pageIndex = pageNumberOrKey;
  }
  const paginatedUrl = `${currentUrl}?page=${pageIndex}`;

  await browser.navigateTo(paginatedUrl);
  await browser.waitForPageLoaded();
});
