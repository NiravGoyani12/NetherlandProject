import { Then } from '@pvhqa/cucumber';
import { expect } from 'chai';
import services from '../../core/services';
import Recommendations from '../pages/experience/recommendations';
import { exist$, maybeDisplayed$, p$ } from '../general';
import { DropdownSelector } from '../../core/constents';

const recommendations = p$(Recommendations);

Then(/I store xo-widget-id for recommendation type (TRENDING_ON|RECENTLY_VIEWED|MATCHING_ITEMS|NO_SEARCH|BASKET) to key (#[A-Za-z0-9]+)/, async (recommendationType: string, keyName: string) => {
  await services.site.extractSiteInfo();
  const storeId = services.site.siteInfo.STORE_ID.toString();
  const xoWidgetId = await services.xowidget.getWidgetId(recommendationType, storeId);

  services.world.store(keyName, xoWidgetId);
});

Then(/I force the url with a xo-widget-id (.*)/, async (xoWidgetId: string) => {
  const currentUrl = await browser.getUrl();
  let forceWidgetUrl;
  if (currentUrl.includes('?')) {
    forceWidgetUrl = `${currentUrl}&force-widget=${xoWidgetId}`;
  } else {
    forceWidgetUrl = `${currentUrl}?force-widget=${xoWidgetId}`;
  }
  await browser.url(forceWidgetUrl);
  await browser.waitForPageLoaded();
});

Then(/I force xo-widget-id (.*) with position (matchingItems|trendingOn|recentlyViewed|noSearch|basket)( and force toggle on)?/, async (xoWidgetId: string, position: string, forceToggle?: string) => {
  const currentUrl = await browser.getUrl();
  let forceWidgetUrl;
  if (forceToggle === null) {
    forceToggle = '';
  }

  if (currentUrl.includes('?')) {
    forceWidgetUrl = `${currentUrl}&force-widget=${xoWidgetId}&position=${position}`;
  } else {
    forceWidgetUrl = `${currentUrl}?force-widget=${xoWidgetId}&position=${position}`;
  }

  if (forceToggle.indexOf('force') >= 0) {
    forceWidgetUrl = `${forceWidgetUrl}&force-earlybird=Y`;
  }

  await browser.url(forceWidgetUrl);
  await browser.waitForPageLoaded();
});

Then(/I see xo variable "(.*)" should( not)? be present in xo (uri|api)/, async (expectedValue: string, notPresent: string, xoCall?: string) => {
  expectedValue = services.world.parse(expectedValue).toString();
  expectedValue = services.account.parse(expectedValue).toString();
  let xoCallResult;
  let xoCallResultEncoded;
  if (xoCall === 'uri') {
    xoCallResult = (await browser.execute('return document.referrer')).toString();
  }
  if (xoCall === 'api') {
    xoCallResultEncoded = await browser.getNetworkRequest(
      'fetch',
      'api.early-birds.fr',
    );
    xoCallResult = decodeURIComponent(xoCallResultEncoded);
  }

  expect((xoCallResult.includes(expectedValue)) === !notPresent,
    `Stored value with the key should${notPresent || ''} contain "${expectedValue}", actual value was: "${xoCallResult}"`)
    .to.be.true;
});


Then(/from unified XO recommendation with (.*) I add product in bag by selecting dropdown option by (?:value|text|index|data-qa) "(.*)"( if displayed)?/, async (styleColourPartNumber: string, value: string, ifDisplayedCheck: string) => {
  value = services.world.parse(value);
  const countryInfo = services.checkoutaddress.getCountryDetails(services.site.locale);
  if (value === '#POSTCODE') {
    value = countryInfo.postcode;
  }
  if (value === '#NEWPOSTCODE') {
    value = countryInfo.newpostcode;
  }
  if (value === '#PHONE') {
    value = countryInfo.phone;
  }
  if (value === '#STATE') {
    value = countryInfo.province;
  }

  if (!value.toLowerCase().includes('one')) {
    // eslint-disable-next-line max-len
    const dropdown = recommendations.EditSizeDropdown(styleColourPartNumber, value) as DropdownSelector;
    const element = ifDisplayedCheck
      ? await maybeDisplayed$(recommendations.EditSizeDropdown(styleColourPartNumber, value))
      : await exist$(recommendations.EditSizeDropdown(styleColourPartNumber, value));
    if (element) {
      await element.selectDropdown(dropdown.optionSelector);
    }
  }
  const addButon = await exist$(
    recommendations.RecoShoppingBasketAddToBagBtn(styleColourPartNumber),
  );
  await addButon.safeClick();
});

Then(/from unified XO recommendation (product style colour partnumber|product style partnumber) with (.*) saved as (#[A-Za-z0-9]+)/, async (type:string, styleColourPartNumber: string, key: string) => {
  let result: string;
  if (type === 'product style colour partnumber') {
    result = styleColourPartNumber;
  } else {
    result = styleColourPartNumber.split('-').pop().slice(0, -3).toUpperCase();
  }
  services.world.store(key, result);
});
