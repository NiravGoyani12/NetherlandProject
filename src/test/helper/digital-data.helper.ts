/* eslint-disable prefer-template */
/* eslint-disable import/prefer-default-export */

import services from '../../core/services';
import { getPageType } from './utils.helper';

const getBreadCrumbObjectPath = async () => {
  const pageType = await getPageType();
  if (services.env.Brand === 'th') {
    return 'return window.__NEXT_DATA__.props.initialState.breadcrumb.trail';
  } if (services.env.Brand === 'ck') {
    let value = '';
    switch (pageType) {
      case 'plp':
        value = 'return window.__NEXT_DATA__.props.initialState.productList.meta.breadcrumb';
        break;
      case 'pdp':
        value = 'return window.__NEXT_DATA__.props.initialState.productPage.meta.breadcrumb';
        break;
      case 'glp':
        value = 'return window.__NEXT_DATA__.props.initialState.breadcrumb.data';
        break;
      default:
        return value;
    }
    return value;
  }
  return 'return window.app.breadcrumb.trail';
};

export const getPagePath = async () => {
  const pageType = await browser.waitUntilResult(async () => {
    const result = await browser.execute('return digitalData.page.category.pageType');
    return result;
  }, 'pageType does not exist', services.env.DriverConfig.timeout.pageLoad);

  let value = '';
  if (pageType === 'glp') {
    const path1 = await browser.waitUntilResult(async () => {
      const result = await browser.execute(`${await getBreadCrumbObjectPath()}[0].url`);
      return result;
    }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
    value = path1;
  } else if (pageType === 'return center') {
    const currentLocale = services.site.locale;
    switch (currentLocale) {
      case 'be':
        value = '/klantenservice-retouren';
        break;
      case 'ru':
        value = '/обслуживание-клиентов-возвратb';
        break;
      case 'uk':
        value = '/customer-service-returns';
        break;
      default:
        return value;
    }
  } else if (pageType === 'customerservice') {
    const currentLocale = services.site.locale;
    const pageCategory = await browser.execute('return digitalData.page.category.primaryCategory');
    if (pageCategory === 'cs_contactform') {
      value = '/customerservice-contactus';
    } else if (pageCategory === 'faqs') {
      value = '/faqs';
    } else {
      switch (currentLocale) {
        case 'be':
          value = '/klantenservice';
          break;
        case 'de':
          value = '/kundenservice';
          break;
        case 'ru':
          value = '/обслуживание';
          break;
        case 'uk':
          value = '/customer-service';
          break;
        default:
          return value;
      }
    }
  } else {
    const breadcrumb = await browser.waitUntilResult(async () => {
      const result = await browser.execute(`${await getBreadCrumbObjectPath()}`);
      return result;
    }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
    const path1 = await browser.waitUntilResult(async () => {
      const result = await browser.execute(`${await getBreadCrumbObjectPath()}[0].url`);
      return result;
    }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
    const path2 = await browser.waitUntilResult(async () => {
      const result = await browser.execute(`${await getBreadCrumbObjectPath()}[1].url`);
      return result;
    }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
    value = path1 + path2;
    if ((breadcrumb as any).length === 3) {
      const path3 = await browser.waitUntilResult(async () => {
        const result = await browser.execute(`${await getBreadCrumbObjectPath()}[2].url`);
        return result;
      }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
      value = path1 + path2 + path3;
    }
    if ((breadcrumb as any).length === 4) {
      const path3 = await browser.waitUntilResult(async () => {
        const result = await browser.execute(`${await getBreadCrumbObjectPath()}[2].url`);
        return result;
      }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
      const path4 = await browser.waitUntilResult(async () => {
        const result = await browser.execute(`${await getBreadCrumbObjectPath()}[3].url`);
        return result;
      }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
      value = path1 + path2 + path3 + path4;
    } else if ((breadcrumb as any).length === 5) {
      const path3 = await browser.waitUntilResult(async () => {
        const result = await browser.execute(`${await getBreadCrumbObjectPath()}[2].url`);
        return result;
      }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
      const path4 = await browser.waitUntilResult(async () => {
        const result = await browser.execute(`${await getBreadCrumbObjectPath()}[3].url`);
        return result;
      }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
      const path5 = await browser.waitUntilResult(async () => {
        const result = await browser.execute(`${await getBreadCrumbObjectPath()}[4].url`);
        return result;
      }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
      value = path1 + path2 + path3 + path4 + path5;
    }
  }
  return value;
};

export const getPageTitle = async () => {
  const pageTitle = await (await browser.getTitle());
  return pageTitle;
};

export const getPageName = async (pageType: string) => {
  pageType = await browser.waitUntilResult(async () => {
    const result = await browser.execute('return digitalData.page.category.pageType');
    return result;
  }, 'pageType does not exist', services.env.DriverConfig.timeout.pageLoad);
  let type1 = await browser.execute(`${await getBreadCrumbObjectPath()}[0].identifier`) as string;
  if (type1 === null) {
    type1 = (await browser.execute(`${await getBreadCrumbObjectPath()}[0].id`)) as string;
  }
  let value = '';
  const breadcrumb = await browser.waitUntilResult(async () => {
    const result = await browser.execute(`${await getBreadCrumbObjectPath()}`);
    return result;
  }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
  if (pageType === 'glp') {
    value = pageType + '|>' + type1;
  } else if (pageType === 'plp' && ((breadcrumb as any).length === 2)) {
    let type2 = (await browser.execute(`${await getBreadCrumbObjectPath()}[1].identifier`)) as string;
    if (type2 === null) {
      type2 = (await browser.execute(`${await getBreadCrumbObjectPath()}[1].id`)) as string;
    }
    value = pageType + '|' + type1 + '>' + type2 + '>';
  } else if (pageType === 'plp' && ((breadcrumb as any).length === 3)) {
    let type2 = (await browser.execute(`${await getBreadCrumbObjectPath()}[1].identifier`)) as string;
    if (type2 === null) {
      type2 = (await browser.execute(`${await getBreadCrumbObjectPath()}[1].id`)) as string;
    }
    let type3 = (await browser.execute(`${await getBreadCrumbObjectPath()}[2].identifier`)) as string;
    if (type3 === null) {
      type3 = (await browser.execute(`${await getBreadCrumbObjectPath()}[2].id`)) as string;
    }
    value = pageType + '|' + type1 + '>' + type2 + '>' + type3;
  } else if (pageType === 'pdp') {
    let type2 = (await browser.execute(`${await getBreadCrumbObjectPath()}[1].identifier`)) as string;
    if (type2 === null) {
      type2 = (await browser.execute(`${await getBreadCrumbObjectPath()}[1].id`)) as string;
    }
    let type3 = (await browser.execute(`${await getBreadCrumbObjectPath()}[2].identifier`)) as string;
    if (type3 === null) {
      type3 = (await browser.execute(`${await getBreadCrumbObjectPath()}[2].id`)) as string;
    }
    const type4 = (await browser.execute('return digitalData.product[0].productInfo.productCombi')) as string;
    value = pageType + '|' + type1 + '>' + type2 + '>' + type3 + '>' + type4;
  }
  const currentLocale = services.site.locale.toString().toLocaleLowerCase();
  let currentLangCode = services.site.langCode;
  currentLangCode ? currentLangCode = currentLangCode.toString().toLocaleLowerCase() : undefined;
  if ((value.toLowerCase().includes(currentLocale)) && value.toLowerCase().includes('uki')) {
    value = value.toLowerCase().replace(new RegExp(`_${currentLocale}i`, 'g'), '');
  } else if (value.toLowerCase().includes(currentLocale)) {
    value = value.toLowerCase().replace(new RegExp(`_${currentLocale}`, 'g'), '');
  } else if (value.toLocaleLowerCase().includes(currentLangCode)) {
    value = value.toLowerCase().replace(new RegExp(`_${currentLangCode}`, 'g'), '');
  }
  return value;
};

export const getPageAlias = async () => {
  const pageType = await browser.waitUntilResult(async () => {
    const result = await browser.execute('return digitalData.page.category.pageType');
    return result;
  }, 'pageType does not exist', services.env.DriverConfig.timeout.pageLoad);
  let value = '';
  if (pageType === 'plp') {
    const breadcrumb = await browser.waitUntilResult(async () => {
      const result = await browser.execute(`${await getBreadCrumbObjectPath()}`);
      return result;
    }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
    if ((breadcrumb as any).length === 2) {
      value = (await browser.execute(`${await getBreadCrumbObjectPath()}[1].label`)) as string;
    } else if ((breadcrumb as any).length === 3) {
      value = (await browser.execute(`${await getBreadCrumbObjectPath()}[2].label`)) as string;
    } else if ((breadcrumb as any).length === 4) {
      value = (await browser.execute(`${await getBreadCrumbObjectPath()}[3].label`)) as string;
    }
  } else if (pageType === 'pdp') {
    if (services.env.Brand === 'th') {
      value = (await browser.execute('return window.app.product?.name || window.__NEXT_DATA__?.props?.initialState?.pdp?.name') as string);
    } else {
      try {
        value = (await browser.execute('return window.app.product?.name') as string);
      } catch {
        value = (await browser.execute('return window.__NEXT_DATA__?.props?.initialState?.productPage?.data?.name') as string);
      }
    }
  } else if (pageType === 'search results page') {
    value = (await browser.getTitle()).split('-')[1].trim();
  }
  return value;
};

export const getPageGender = async () => {
  let value = (await browser.execute(`${await getBreadCrumbObjectPath()}[0].identifier`)) as string;
  if (value === null) {
    value = (await browser.execute(`${await getBreadCrumbObjectPath()}[0].id`)) as string;
    value = value.indexOf('_') >= 0 ? value.split('_')[0] : value;
  } else {
    value = value.indexOf('_') >= 0 ? value.split('_')[1] : value;
  }
  return value;
};

export const getPrimaryCategory = async () => {
  const locale = services.site.locale.toString().toLocaleLowerCase();
  let { langCode } = services.site;
  langCode ? langCode = langCode.toString().toLocaleLowerCase() : undefined;
  let value = (await browser.execute(`${await getBreadCrumbObjectPath()}[0].label`)) as string;
  if (value.toLowerCase().includes(locale)
    || value.toLowerCase().includes(langCode)) {
    let removePart = value.split('_');
    removePart = removePart.splice(0, removePart.length - 1);
    value = removePart.join();
    value = removePart.join().replace(/[,]/g, '_');
  }
  return value;
};

export const getPrimaryCategoryId = async () => {
  const locale = services.site.locale.toString().toLocaleLowerCase();
  let { langCode } = services.site;
  langCode ? langCode = langCode.toString().toLocaleLowerCase() : undefined;
  let value = (await browser.execute(`${await getBreadCrumbObjectPath()}[0].identifier`)) as string;
  if (value === null) {
    value = (await browser.execute(`${await getBreadCrumbObjectPath()}[0].id`)) as string;
  }
  if (value.toLowerCase().includes(locale)
    || value.toLowerCase().includes(langCode)) {
    let removePart = value.split('_');
    removePart = removePart.splice(0, removePart.length - 1);
    value = removePart.join();
    value = removePart.join().replace(/[,]/g, '_');
  }
  return value;
};

export const getSubCategory1 = async () => {
  const locale = services.site.locale.toString().toLocaleLowerCase();
  let { langCode } = services.site;
  langCode ? langCode = langCode.toString().toLocaleLowerCase() : undefined;
  let value = (await browser.execute(`${await getBreadCrumbObjectPath()}[1].label`)) as string;
  if (value.toLowerCase().includes(locale)
    || value.toLowerCase().includes(langCode)) {
    let removePart = value.split('_');
    removePart = removePart.splice(0, removePart.length - 1);
    value = removePart.join().replace(/[,]/g, '_');
  }
  return value;
};

export const getSubCategory1Id = async () => {
  const locale = services.site.locale.toString().toLocaleLowerCase();
  let { langCode } = services.site;
  langCode ? langCode = langCode.toString().toLocaleLowerCase() : undefined;
  let value = (await browser.execute(`${await getBreadCrumbObjectPath()}[1].identifier`)) as string;
  if (value === null) {
    value = (await browser.execute(`${await getBreadCrumbObjectPath()}[1].id`)) as string;
  }
  if (value.toLowerCase().includes(locale)
    || value.toLowerCase().includes(langCode)) {
    let removePart = value.split('_');
    removePart = removePart.splice(0, removePart.length - 1);
    value = removePart.join().replace(/[,]/g, '_');
  }
  return value;
};

export const getSubCategory2 = async () => {
  const breadcrumb = await browser.waitUntilResult(async () => {
    const result = await browser.execute(`${await getBreadCrumbObjectPath()}`);
    return result;
  }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
  if ((breadcrumb as any).length === '3') {
    const locale = services.site.locale.toString().toLocaleLowerCase();
    let { langCode } = services.site;
    langCode ? langCode = langCode.toString().toLocaleLowerCase() : undefined;
    let value = (await browser.execute(`${await getBreadCrumbObjectPath()}[2].label`)) as string;
    if (value.toLowerCase().includes(locale)
      || value.toLowerCase().includes(langCode)) {
      let removePart = value.split('_');
      removePart = removePart.splice(0, removePart.length - 1);
      value = removePart.join().replace(/[,]/g, '_');
    }
    return value;
  }
  return null;
};

export const getSubCategory2Id = async () => {
  const breadcrumb = await browser.waitUntilResult(async () => {
    const result = await browser.execute(`${await getBreadCrumbObjectPath()}`);
    return result;
  }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
  if ((breadcrumb as any).length === '3') {
    const locale = services.site.locale.toString().toLocaleLowerCase();
    let { langCode } = services.site;
    langCode ? langCode = langCode.toString().toLocaleLowerCase() : undefined;
    let value = (await browser.execute(`${await getBreadCrumbObjectPath()}[2].identifier`)) as string;
    if (value === null) {
      value = (await browser.execute(`${await getBreadCrumbObjectPath()}[2].id`)) as string;
    }
    if (value.toLowerCase().includes(locale)
      || value.toLowerCase().includes(langCode)) {
      let removePart = value.split('_');
      removePart = removePart.splice(0, removePart.length - 1);
      value = removePart.join().replace(/[,]/g, '_');
    }
    return value;
  }
  return null;
};

export const getSubCategory3 = async () => {
  const breadcrumb = await browser.waitUntilResult(async () => {
    const result = await browser.execute(`${await getBreadCrumbObjectPath()}`);
    return result;
  }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
  if ((breadcrumb as any).length === '4') {
    const locale = services.site.locale.toString().toLocaleLowerCase();
    let { langCode } = services.site;
    langCode ? langCode = langCode.toString().toLocaleLowerCase() : undefined;
    let value = (await browser.execute(`${await getBreadCrumbObjectPath()}[3].label`)) as string;
    if (value.toLowerCase().includes(locale)
      || value.toLowerCase().includes(langCode)) {
      let removePart = value.split('_');
      removePart = removePart.splice(0, removePart.length - 1);
      value = removePart.join().replace(/[,]/g, '_');
    }
    return value;
  }
  return null;
};

export const getSubCategory3Id = async () => {
  const breadcrumb = await browser.waitUntilResult(async () => {
    const result = await browser.execute(`${await getBreadCrumbObjectPath()}`);
    return result;
  }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
  if ((breadcrumb as any).length === '4') {
    const locale = services.site.locale.toString().toLocaleLowerCase();
    let { langCode } = services.site;
    langCode ? langCode = langCode.toString().toLocaleLowerCase() : undefined;
    let value = (await browser.execute(`${await getBreadCrumbObjectPath()}[3].identifier`)) as string;
    if (value === null) {
      value = (await browser.execute(`${await getBreadCrumbObjectPath()}[3].id`)) as string;
    }
    if (value.toLowerCase().includes(locale)
      || value.toLowerCase().includes(langCode)) {
      let removePart = value.split('_');
      removePart = removePart.splice(0, removePart.length - 1);
      value = removePart.join().replace(/[,]/g, '_');
    }
    return value;
  }
  return null;
};

export const getSubCategory4 = async () => {
  const breadcrumb = await browser.waitUntilResult(async () => {
    const result = await browser.execute(`${await getBreadCrumbObjectPath()}`);
    return result;
  }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
  if ((breadcrumb as any).length === '5') {
    const locale = services.site.locale.toString().toLocaleLowerCase();
    let { langCode } = services.site;
    langCode ? langCode = langCode.toString().toLocaleLowerCase() : undefined;
    let value = (await browser.execute(`${await getBreadCrumbObjectPath()}[4].label`)) as string;
    if (value.toLowerCase().includes(locale)
      || value.toLowerCase().includes(langCode)) {
      let removePart = value.split('_');
      removePart = removePart.splice(0, removePart.length - 1);
      value = removePart.join().replace(/[,]/g, '_');
    }
    return value;
  }
  return null;
};

export const getSubCategory4Id = async () => {
  const breadcrumb = await browser.waitUntilResult(async () => {
    const result = await browser.execute(`${await getBreadCrumbObjectPath()}`);
    return result;
  }, 'breadcrumb does not exist', services.env.DriverConfig.timeout.pageLoad);
  if ((breadcrumb as any).length === '5') {
    const locale = services.site.locale.toString().toLocaleLowerCase();
    let { langCode } = services.site;
    langCode ? langCode = langCode.toString().toLocaleLowerCase() : undefined;
    let value = (await browser.execute(`${await getBreadCrumbObjectPath()}[4].identifier`)) as string;
    if (value === null) {
      value = (await browser.execute(`${await getBreadCrumbObjectPath()}[4].id`)) as string;
    }
    if (value.toLowerCase().includes(locale)
      || value.toLocaleLowerCase().includes(langCode)) {
      let removePart = value.split('_');
      removePart = removePart.splice(0, removePart.length - 1);
      value = removePart.join().replace(/[,]/g, '_');
    }
    return value;
  }
  return null;
};

export const getProductStructureGroupId = async () => {
  const locale = services.site.locale.toString().toLocaleLowerCase();
  let { langCode } = services.site;
  langCode ? langCode = langCode.toString().toLocaleLowerCase() : undefined;
  const pageType = (await browser.execute('return digitalData.page.category.pageType')) as string;
  const breadcrumb = (await browser.execute(`${await getBreadCrumbObjectPath()}`));
  let value = '';
  if (pageType === 'glp') {
    value = (await browser.execute(`${await getBreadCrumbObjectPath()}[0].identifier`)) as string;
    if (value === null) {
      value = (await browser.execute(`${await getBreadCrumbObjectPath()}[0].id`)) as string;
    }
  } else if (pageType === 'pdp' || pageType === 'plp') {
    if ((breadcrumb as any).length === 4) {
      value = (await browser.execute(`${await getBreadCrumbObjectPath()}[3].identifier`)) as string;
      if (value === null) {
        value = (await browser.execute(`${await getBreadCrumbObjectPath()}[3].id`)) as string;
      }
    } else if ((breadcrumb as any).length === 3) {
      value = (await browser.execute(`${await getBreadCrumbObjectPath()}[2].identifier`)) as string;
      if (value === null) {
        value = (await browser.execute(`${await getBreadCrumbObjectPath()}[2].id`)) as string;
      }
    }
  }
  if (value.toLowerCase().includes(locale)
    || value.toLocaleLowerCase().includes(langCode)) {
    let removePart = value.split('_');
    removePart = removePart.splice(0, removePart.length - 1);
    value = removePart.join().replace(/[,]/g, '_');
  }
  return value;
};

export const getOnsiteHeaderSearchTerm = async () => {
  const value = (await browser.getTitle()).split('-')[1].trim();
  return value;
};

export const getOnsiteSearchTerm = async () => {
  const value = (await browser.getTitle()).split('-')[1].trim();
  return value;
};

export const getCurrentPostcode = async () => {
  const countryInfo = services.checkoutaddress.getCountryDetails(services.site.locale);
  const value = countryInfo.postcode;
  return value;
};
