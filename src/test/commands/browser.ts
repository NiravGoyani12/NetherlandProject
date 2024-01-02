import setCookieParser from 'set-cookie-parser';
import services from '../../core/services';
import { GetTestLogger } from '../../core/logger/test.logger';
import wcs from '../../core/wcs';

export interface ChromeCookie extends WebDriver.Cookie {
}

export async function waitForPageLoaded() {
  await browser.waitUntil(async () => {
    const isLoaded = await browser.execute('return document.readyState;');
    return isLoaded === 'complete';
  },
  {
    timeout: services.env.DriverConfig.timeout.pageLoad,
    timeoutMsg: 'Page is still not loaded!',
    interval: 1000,
  });
}

/**
 * This function only works when we enable the browser logs.
 * @param type Type
 */
export async function getBadNetworkRequestCount(type?: 'XHR' | 'Image' | 'Script' | 'Document' | 'Font' | 'Other') {
  let reqs = (await browser.getLogs('performance'))
    .filter((m: any) => m.message.indexOf('Network.responseReceived') > 0);
  reqs = reqs
    .map((c: any) => JSON.parse(c.message))
    .filter((c: any) => {
      const r = c.message.params
        && c.message.params.response
        && c.message.params.response.status >= 400;
      if (type) {
        return r && c.message.params.type === type;
      }
      return r;
    });
  return reqs.length;
}

export async function setInitCookiesAndNavigate(this: WebdriverIO.BrowserObject, url: string) {
  const path = services.site.langCode && services.env.Brand === 'th' ? `/${services.site.langCode}` : undefined;
  await Promise.all([
    this.setCookies({ name: 'PVH_COOKIES_GDPR', value: 'Accept' }),
    this.setCookies({ name: 'PVH_COOKIES_GDPR_ANALYTICS', value: 'Accept' }),
    this.setCookies({ name: 'PVH_COOKIES_GDPR_SOCIALMEDIA', value: 'Accept' }),
    this.setCookies({ name: 'newsletterSeen', value: 'true', path }),
    this.setCookies({ name: 'HEADER_BANNER_SEEN', value: 'true', path }),
    this.setCookies({ name: 'pvh_exclude_ab', value: 'true' }),
    // this.setCookies({ name: 'CSPopupSeen', value: 'true' }),
  ]);
  await browser.url(url);
}

export async function setOnlyFunctionalCookiesAndNavigate(this: WebdriverIO.BrowserObject,
  url: string) {
  const path = services.site.langCode && services.env.Brand === 'th' ? `/${services.site.langCode}` : undefined;
  await Promise.all([
    this.setCookies({ name: 'PVH_COOKIES_GDPR', value: 'Accept' }),
    this.setCookies({ name: 'PVH_COOKIES_GDPR_ANALYTICS', value: 'Reject' }),
    this.setCookies({ name: 'PVH_COOKIES_GDPR_SOCIALMEDIA', value: 'Reject' }),
    this.setCookies({ name: 'newsletterSeen', value: 'true', path }),
    this.setCookies({ name: 'HEADER_BANNER_SEEN', value: 'true', path }),
    this.setCookies({ name: 'pvh_exclude_ab', value: 'true' }),
    // this.setCookies({ name: 'CSPopupSeen', value: 'true' }),
  ]);
  await browser.url(url);
}

/**
 * Set init local storage
 * Now it only applied for TH, but not CK
 * @param this
 */
export async function setInitStorage(this: WebdriverIO.BrowserObject) {
  if (services.world.parse('#EnableCountrySwitchPop') !== 'true') {
    await this.execute(() => sessionStorage.setItem('CSPopupSeen', 'true'));
  }
}

export async function setInitCookiesAndRefresh(this: WebdriverIO.BrowserObject) {
  await Promise.all([
    this.setCookies({ name: 'PVH_COOKIES_GDPR', value: 'Accept' }),
    this.setCookies({ name: 'PVH_COOKIES_GDPR_ANALYTICS', value: 'Accept' }),
    this.setCookies({ name: 'PVH_COOKIES_GDPR_SOCIALMEDIA', value: 'Accept' }),
    this.setCookies({ name: 'newsletterSeen', value: 'true' }),
    this.setCookies({ name: 'HEADER_BANNER_SEEN', value: 'true' }),
    this.setCookies({ name: 'pvh_exclude_ab', value: 'true' }),
    // this.setCookies({ name: 'CSPopupSeen', value: 'true' }),
    this.setCookies({ name: 'optimizelyUserId', value: 'size_selector_variation_2' }), // will be removed once AB testing is done in CK
  ]);
  await browser.refresh();
}

export async function setPaginationCookiesAndRefresh(this: WebdriverIO.BrowserObject) {
  await this.setCookies({ name: 'optimizelyUserId', value: 'variation_3' });
  await browser.refresh();
}

export async function getPvhCookiesState(
  this: WebdriverIO.BrowserObject,
  functionalOnly: boolean = false,
) {
  try {
    const gdprSet = (await (this.getNamedCookie('PVH_COOKIES_GDPR'))).value === 'Accept';
    const analyticsSet = (await (this.getNamedCookie('PVH_COOKIES_GDPR_ANALYTICS'))).value === 'Accept';
    const socialMediaSet = (await (this.getNamedCookie('PVH_COOKIES_GDPR_SOCIALMEDIA'))).value === 'Accept';
    const cookiesSet = functionalOnly ? gdprSet : gdprSet && analyticsSet && socialMediaSet;
    return cookiesSet;
  } catch (e) {
    return false;
  }
}

export async function getGenderCookiesState(this: WebdriverIO.BrowserObject) {
  try {
    const genderUrlCookieValue = (await this.getNamedCookie('PVH_GLP_GENDER_URL')).value;
    return !!genderUrlCookieValue;
  } catch {
    return false;
  }
}

export async function getOlapicCookiesState(this: WebdriverIO.BrowserObject) {
  try {
    const olapicCookieValue = (await this.getNamedCookie('__olapicU')).value;
    return !!olapicCookieValue;
  } catch {
    return false;
  }
}

export async function deleteAuthenticationCookies(this: WebdriverIO.BrowserObject) {
  const allCookies = await this.getCookies();
  const authCookies = allCookies.filter((cookie) => cookie.name.startsWith('WC_AUTHENTICATION'));
  await this.deleteCookies(authCookies.map((c) => c.name));
}

export async function deleteUserActivityCookies(this: WebdriverIO.BrowserObject) {
  const allCookies = await this.getCookies();
  const userActivityCookie = allCookies.filter((cookie) => cookie.name.startsWith('WC_USERACTIVITY'));
  await this.deleteCookies(userActivityCookie.map((c) => c.name));
}

export async function deletePersistentCookies(this: WebdriverIO.BrowserObject) {
  const allCookies = await this.getCookies();
  const persistentCookie = allCookies.filter((cookie) => cookie.name.startsWith('WC_PERSISTENT'));
  await this.deleteCookies(persistentCookie.map((c) => c.name));
}

export async function deleteGDPRCookies(this: WebdriverIO.BrowserObject) {
  await this.deleteCookies([
    'PVH_COOKIES_GDPR',
    'PVH_COOKIES_GDPR_ANALYTICS',
    'PVH_COOKIES_GDPR_SOCIALMEDIA',
  ]);
}

export async function deleteGenderCookies(this: WebdriverIO.BrowserObject) {
  await this.deleteCookies([
    'PVH_GLP_GENDER_URL',
    'PVH_GLP_REDIRECT',
  ]);
}

export async function deleteNewsletterCookies(this: WebdriverIO.BrowserObject) {
  await this.deleteCookies(['newsletterSeen']);
}

export async function safeDeleteAllCookies(this: WebdriverIO.BrowserObject) {
  try {
    await this.deleteAllCookies();
  } catch {
    GetTestLogger().info('Browser was unable to delete cookies');
  }
}

export async function deleteAllStorage(this: WebdriverIO.BrowserObject) {
  try {
    await this.execute(() => {
      sessionStorage.clear();
      localStorage.clear();
    });
  } catch (e) {
    GetTestLogger().warn(`Delete storage failed: ${e}`);
  }
}

// TODO: We use it for sign in/sign up without UI,
// but it has issues still(not sure what's exact issue)
export async function resetAuthCookies(
  this: WebdriverIO.BrowserObject, cookies: WebDriver.Cookie[],
) {
  const list = [
    this.setCookies({ name: 'PVH_COOKIES_GDPR', value: 'Accept' }),
    this.setCookies({ name: 'PVH_COOKIES_GDPR_ANALYTICS', value: 'Accept' }),
    this.setCookies({ name: 'PVH_COOKIES_GDPR_SOCIALMEDIA', value: 'Accept' }),
    this.setCookies({ name: 'newsletterSeen', value: 'true' }),
    // this.setCookies({ name: 'CSPopupSeen', value: 'true' }),
  ];
  const existCookies = await browser.getAllCookies() as Array<WebDriver.Cookie>;
  const wcCookies = existCookies.filter((c) => c.name.startsWith('WC')).map((c) => c.name);
  if (wcCookies && wcCookies.length > 0) {
    await browser.deleteCookies(wcCookies);
  }

  cookies.forEach((c) => list.push(this.setCookies(c)));
  await Promise.all(list);
}

export async function setCookiesAndRefresh(
  this: WebdriverIO.BrowserObject, cookies: WebDriver.Cookie[],
) {
  const list = [];
  cookies.forEach((c) => list.push(this.setCookies(c)));
  await Promise.all(list);
  await browser.refresh();
}

export async function setAuthCookies(email: string, password: string, newAccount?: boolean) {
  email = services.account.parse(email);
  password = services.account.parse(password);
  const baseUrl = services.site.baseUrl.split('/', 3).join('/');
  const response = newAccount
    ? await wcs.signUp(baseUrl, services.site.siteInfo.STORE_ID, email, password)
    : await wcs.signIn(baseUrl, services.site.siteInfo.STORE_ID, email, password);
  const cookies = setCookieParser.parse(response, { decodeValues: false });
  let cookieDomain;
  if (services.env.Site === 'localhost') {
    cookieDomain = '';
  } else {
    // eslint-disable-next-line prefer-destructuring
    cookieDomain = (services.site.baseUrl.replace('https://', '').replace('http://', '')).split('/')[0];
  }
  const webdriverCookies = cookies.map((c) => {
    const cookie: WebDriver.Cookie = {
      name: c.name,
      value: c.value,
      domain: cookieDomain,
      path: c.path,
      httpOnly: c.httpOnly || false,
      secure: c.secure || false,
    };
    // if (c.expires) {
    //  cookie.expiry = Math.round(c.expires.getTime() / 1000);
    // }
    return cookie;
  });
  await browser.resetAuthCookies(webdriverCookies);
}

export async function waitUntilResult<T>(
  this: WebdriverIO.BrowserObject,
  condition: () => Promise<T>,
  timeoutMsg?: string,
  timeout?: number,
  interval?: number,
) {
  await browser.waitUntil(async () => {
    const s = await condition();
    return s !== null && s !== undefined;
  },
  {
    timeout,
    timeoutMsg,
    interval,
  });
  return condition();
}

export async function scrollToWindowDirection(
  this: WebdriverIO.BrowserObject, position: 'bottom' | 'top',
) {
  await browser.execute(`
  position = arguments[0] === 'bottom' ? document.body.scrollHeight : 0;
  window.scrollTo(0, position);`, position);
}

export async function smoothScrollToWindowDirection(
  this: WebdriverIO.BrowserObject, position: 'bottom' | 'top',
) {
  await browser.execute(`
  function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));}
  async function scroll(scrollY, scrollHeight, scrollIteration, direction) {
   while (direction * (scrollY - scrollHeight) > scrollIteration) 
   {  
       window.scrollBy(0, direction * scrollIteration);
       await sleep(100);
       scrollHeight = window.pageYOffset;
   }
   remainingScroll = direction *(scrollY - scrollHeight);
   window.scrollBy(0, direction * remainingScroll);}
direction =  arguments[0] === 'bottom' ? 1 : -1;  
scrollY = arguments[0] === 'bottom' ? (document.body.scrollHeight - $(window).height()) : 0;
scrollHeight = window.pageYOffset;
scrollIteration = 100;
return scroll(scrollY, scrollHeight, scrollIteration, direction);`, position);
}

export async function getNetworkRequestNumber(
  this: WebdriverIO.BrowserObject,
  requestType: string,
  partialRequestName: string,
) {
  const requestNumber = await browser.execute(`
  performance = window.performance || window.mozPerformance || window.msPerformance || window.webkitPerformance || {}; 
  network = performance.getEntries() || {};
  type = arguments[0];
  name = arguments[1];
  requests = network.filter((n) => n.initiatorType && n.initiatorType === type && n.name && n.name.indexOf(name) >= 0);
  return requests.length;`, requestType, partialRequestName);
  return +requestNumber;
}

export async function getNetworkRequest(
  this: WebdriverIO.BrowserObject,
  requestType: string,
  partialRequestName: string,
) {
  const request = await browser.execute(`
  performance = window.performance || window.mozPerformance || window.msPerformance || window.webkitPerformance || {}; 
  network = performance.getEntries() || {};
  type = arguments[0];
  name = arguments[1];
  requests = network.filter((n) => n.initiatorType && n.initiatorType === type && n.name && n.name.indexOf(name) >= 0);
  return requests[0].name;`, requestType, partialRequestName);
  return request;
}

export async function safeTouch(this: WebdriverIO.BrowserObject, x: number, y: number) {
  await this.performActions([{
    type: 'pointer',
    id: 'action1',
    parameters: { pointerType: services.env.IsDesktop ? 'mouse' : 'touch' },
    actions: [
      {
        type: 'pointerMove',
        duration: 0,
        x,
        y,
      },
      {
        type: 'pointerDown',
        button: 0,
      },
      {
        type: 'pause',
        duration: 500,
      },
      {
        type: 'pointerUp',
        button: 0,
      },
    ],
  }]);
}

export async function mouseMove(this: WebdriverIO.BrowserObject, x: number, y: number) {
  await browser.performActions([{
    type: 'pointer',
    id: 'action1',
    parameters: { pointerType: 'mouse' },
    actions: [
      {
        type: 'pointerMove',
        duration: 0,
        x,
        y,
      },
      {
        type: 'pointerDown',
        button: 0,
      },
    ],
  }]);
}
