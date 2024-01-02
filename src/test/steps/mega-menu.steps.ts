/* eslint-disable no-await-in-loop */
/* eslint-disable import/prefer-default-export */
import { Then, When } from '@pvhqa/cucumber';
import services from '../../core/services';
import {
  exist$,
  exist$$,
  maybeDisplayed$, maybeDisplayed$$, maybeExist$, maybeExist$$,
} from '../general';
import { getPageType, sleep } from '../helper/utils.helper';
// import { stepNavigateToGlpByDeepLink } from './deep-link.steps';
import { OpenUnifiedMegaMenuOnMobile } from '../helper/mega-menu.helper';


export const stepSelectCategoryInMegaMenuViaText = async (
  megaMenuLink: string, megaMenuCategory: string, gender: boolean) => {
  await OpenUnifiedMegaMenuOnMobile();
  await services.site.extractSiteInfo();
  let categorySelector; let
    linkSelector;
  const currentLanguage = services.site.siteInfo.LOCALENAME.toLowerCase();
  const translatedCategoryText = services.translation
    .get(currentLanguage, megaMenuCategory);

  // TODO: Temporary workaround for coreless media testing shiz
  const womensLinkSelector = await services.pageObject.getSelector('Experience.Header.MegaMenuFirstLevelItems', [0]);
  if (gender) {
    categorySelector = await services.pageObject.getSelector('Experience.Header.MegaMenuSecondLevelItems', [translatedCategoryText]);
  } else { categorySelector = await services.pageObject.getSelector('Experience.Header.MegaMenuSecondLevelItemNonGender', [translatedCategoryText]); }

  // TODO: Temporary workaround for coreless media testing shiz
  if (services.env.IsMobile) {
    const womensLink = (await maybeDisplayed$$(womensLinkSelector))[0];
    await womensLink.jsClick();
  }
  const categoryLink = (await maybeDisplayed$$(categorySelector))[0];

  if (services.env.IsDesktop) {
    await categoryLink.hover();
  } else if (services.env.IsMobile) {
    await categoryLink.swipeToElementMobile();
    await categoryLink.jsClick();
    await sleep(500);
  }

  const translatedLinkText = services.translation.get(currentLanguage, megaMenuLink);
  if (gender) {
    linkSelector = await services.pageObject.getSelector('Experience.Header.MegaMenuSecondLevelContentLinks', [translatedLinkText]);
  } else { linkSelector = await services.pageObject.getSelector('Experience.Header.MegaMenuSecondLevelNonGenderContentLinks', [translatedLinkText]); }

  const translatedLink = (await maybeExist$(linkSelector));

  if (!translatedLink) {
    throw new Error(`No links found in mega menu category ${megaMenuCategory} | ${megaMenuLink}`);
  }

  if (services.env.IsMobile) {
    await translatedLink.swipeToElementMobile();
  }
  await translatedLink.safeClick();
  // TODO when PLP is unified
  // if (services.env.IsDesktop) {
  //   (await exist$('Experience.Header.Logo')).hover();
  //   await browser.mouseMove(0, 0);
  // }
};

export const stepSelectCategoryInMegaMenuViaIndex = async (
  secondLevelIndex: number, thirdLevelIndex: number, gender: boolean) => {
  await OpenUnifiedMegaMenuOnMobile();
  await services.site.extractSiteInfo();
  let categorySelector;

  if (gender) {
    categorySelector = await services.pageObject.getSelector('Experience.Header.MegaMenuSecondLevelItemsByIndex', [secondLevelIndex]);
  } else { categorySelector = await services.pageObject.getSelector('Experience.Header.MegaMenuSecondLevelItemNonGenderByIndex', [secondLevelIndex]); }

  const categoryLink = (await maybeDisplayed$$(categorySelector))[0];
  if (services.env.IsDesktop) {
    await categoryLink.hover();
  } if (services.env.IsMobile) {
    await categoryLink.swipeToElementMobile();
    await categoryLink.jsClick();
    await sleep(500);
  }
  const linkSelector = await services.pageObject.getSelector('Experience.Header.MegaMenuThirdLevelItemsByIndex', [secondLevelIndex, thirdLevelIndex]);
  const finalLink = (await maybeDisplayed$(linkSelector));

  await sleep(500);

  if (services.env.IsMobile) {
    await finalLink.jsClick();
  }
  await finalLink.safeClick();
};

When(/I ensure unified mega menu is interactable/, async () => {
  await OpenUnifiedMegaMenuOnMobile();
});

When(/in unified megamenu I select (1st|2nd) level item with index (\d+)/, async (level: string, index: number) => {
  const levelSelector = level === '1st' ? 'Experience.Header.MegaMenuFirstLevelItems' : 'Experience.Header.MegaMenuSecondLevelItemsByIndex';
  const selector = await services.pageObject.getSelector(levelSelector, [index]);
  const megamenuItem = await maybeDisplayed$(selector);
  await megamenuItem.safeClick();
  if (services.env.IsDesktop) {
    await browser.waitUntil(
      async () => {
        const loadedPageType = await getPageType();
        return (loadedPageType.toLowerCase() === 'glp' || loadedPageType.toLowerCase() === 'glppage');
      },
      {
        timeout: 15000,
        timeoutMsg: 'GLP was not loaded',
      },
    );
  }
});

Then(/in unified megamenu every second level category has content/, async () => {
  const timeout = services.env.DriverConfig.timeout.elementDisplayed;
  const secondLevelLinksCount = (await maybeExist$$(
    'Header.MegaMenuSecondLevelItemWithNextLevel', undefined, 1000,
  )).length;
  let i = 0;
  while (i < secondLevelLinksCount) {
    const elementToHover = (await exist$$('Header.MegaMenuSecondLevelItemWithNextLevel', undefined, 1000))[i];
    if (services.env.IsDesktop) {
      await elementToHover.hover();
    } if (services.env.IsMobile) {
      await elementToHover.swipeToElementMobile();
      await elementToHover.jsClick();
    }
    await (await exist$('Header.MegaMenuOpenSecondLevel')).waitForDisplayed(
      {
        timeout,
        timeoutMsg: 'Header.MegaMenuOpenSecondLevel should be displayed',
      },
    );
    await browser.waitUntil(
      async () => (await maybeDisplayed$('Header.MegaMenuSecondLevelContentLinks', timeout) !== null),
      {
        timeout,
        timeoutMsg: 'Expected count of displayed Header.MegaMenuSecondLevelContentLinks should be more than 0',
      },
    );
    i += 1;
  }
});

Then(/in unified megamenu every second level category contains (.*)/, async (categoryText: string) => {
  const timeout = services.env.DriverConfig.timeout.elementDisplayed;
  const secondLevelItemsSelector = await services.pageObject.getSelector('Experience.Header.MegaMenuSecondLevelItemsWithThirdLevelItems');
  const secondLevelItems = (await maybeExist$$(secondLevelItemsSelector, undefined, 1000));

  for (let i = 0; i < secondLevelItems.length; i += 1) {
    const item = secondLevelItems[i];
    if (services.env.IsDesktop) {
      await item.hover();
    } if (services.env.IsMobile) {
      await item.swipeToElementMobile();
      await item.jsClick();
    }
    categoryText = categoryText.startsWith('#') ? services.world.parse(categoryText) : categoryText;
    const thirdLevelHeadingSelector = await services.pageObject.getSelector('Experience.Header.MegaMenuThirdLevelCategoryHeading', [categoryText]);
    const thirdLevelHeadingItem = await maybeExist$(thirdLevelHeadingSelector, timeout);
    await thirdLevelHeadingItem.swipeToElementMobile();
    await browser.waitUntil(
      async () => thirdLevelHeadingItem.isDisplayed(),
      {
        timeout,
        timeoutMsg: `MegaMenuThirdLevelCategory with text ${categoryText} is not dispalyed in opened Second level category : ${await item.getText()}`,
      },
    );
  }
});

When(/^In unified Megamenu I navigate to PLP using (index|text) with category ([^\s]+) and sub-category ([^\s]+)( with accepted cookies| with forced accepted cookies|)?$/, async (method: string, category: string, subCategory: string, withAcceptedCookies: string) => {
  if (method.trim().toLowerCase() === 'index') {
    await stepSelectCategoryInMegaMenuViaIndex(Number(subCategory), Number(category), true);
  } else if (method.trim().toLowerCase() === 'text') {
    await stepSelectCategoryInMegaMenuViaText(subCategory, category, true);
  } else {
    throw new Error(`Unknown method value provided: ${method}`);
  }

  if (withAcceptedCookies) {
    if (withAcceptedCookies.indexOf('forced') > 0) {
      await browser.deleteAllCookies();
      await browser.deleteAllStorage();
    }
    await browser.setInitCookiesAndRefresh();
  }
  await browser.waitForPageLoaded();
});

When(/^In unified Megamenu I hover on category using (index|text) ([^\s]+)?$/, async (method: string, category: string) => {
  await OpenUnifiedMegaMenuOnMobile();
  await services.site.extractSiteInfo();
  let categorySelector;

  if (method.trim().toLowerCase() === 'index') {
    categorySelector = await services.pageObject.getSelector('Experience.Header.MegaMenuSecondLevelItemsByIndex', [category]);
  }
  if (method.trim().toLowerCase() === 'text') {
    const currentLanguage = services.site.siteInfo.LOCALENAME.toLowerCase();
    const translatedCategoryText = services.translation
      .get(currentLanguage, category);
    categorySelector = await services.pageObject.getSelector('Experience.Header.MegaMenuSecondLevelItems', [translatedCategoryText]);
  }
  const categoryLink = (await maybeDisplayed$$(categorySelector))[0];
  if (services.env.IsDesktop) {
    await categoryLink.hover();
  } if (services.env.IsMobile) {
    await categoryLink.swipeToElementMobile();
    await categoryLink.jsClick();
    await sleep(500);
  }
});

When(/^In non gender unified Megamenu I navigate to PLP using (index|text) with category ([^\s]+) and sub-category ([^\s]+)( with accepted cookies| with forced accepted cookies|)?$/, async (method: string, category: string, subCategory: string, withAcceptedCookies: string) => {
  if (method.trim().toLowerCase() === 'index') {
    await stepSelectCategoryInMegaMenuViaIndex(Number(subCategory), Number(category), false);
  } else if (method.trim().toLowerCase() === 'text') {
    await stepSelectCategoryInMegaMenuViaText(subCategory, category, false);
  } else {
    throw new Error(`Unknown method value provided: ${method}`);
  }

  if (withAcceptedCookies) {
    if (withAcceptedCookies.indexOf('forced') > 0) {
      await browser.deleteAllCookies();
      await browser.deleteAllStorage();
    }
    await browser.setInitCookiesAndRefresh();
  }
  await browser.waitForPageLoaded();
});
