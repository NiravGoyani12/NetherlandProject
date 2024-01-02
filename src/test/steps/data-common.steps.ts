import { Given, When } from '@pvhqa/cucumber';
import services from '../../core/services';

Given(/There (?:is|are) (\d+) redirected seo urls?( with empty primary category url)? saved with prefix (#[A-Za-z0-9]+)/, async (resultCount: number, withEmptyPrimaryCategoryUrl: string, prefix: string) => {
  const seoUrlList = await services.othersDB.GetRedirectSEOURL(
    !!withEmptyPrimaryCategoryUrl,
    resultCount,
  );
  let index = 1;
  seoUrlList.forEach((url) => {
    services.world.store(`${prefix}${index}#url`, url.PRODUCTURL);
    services.world.store(`${prefix}${index}#primarycategoryurl`, url.PRIMARYCATEGORYURL);
    index += 1;
  });
});

/**
 * This step should be called when service.site has been initlized
 */
Given(/I extract xcomreg ([^\s]+) saved as (#[A-Za-z0-9]+)/, async (xcomregKey: string, key: string) => {
  const value = await services.othersDB.GetXComReg(xcomregKey);
  services.world.store(key, value);
});

When(/I get (csr|checkout) search data for "([^\s]+)" and store it with key (#[^\s]+)/, async (tool:string, searchData: string, keyToStore: string) => {
  let value;
  if (tool === 'csr') {
    value = services.csrsearchdata.getSearchData(
      services.env.Brand, searchData, services.env.DatabaseName,
    );
  } else if (tool === 'checkout') {
    value = services.checkoutdata.getData(services.env.Brand, searchData);
  }

  services.world.store(keyToStore, value);
});
