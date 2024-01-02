/* eslint-disable import/prefer-default-export */
import joi from '@hapi/joi';
import services from '../../core/services';
import {
  getPagePath, getPageTitle, getPageName, getPageGender,
  getPrimaryCategory, getPrimaryCategoryId, getSubCategory1, getSubCategory1Id,
  getSubCategory2, getSubCategory2Id, getSubCategory3, getSubCategory3Id, getSubCategory4,
  getSubCategory4Id, getProductStructureGroupId, getPageAlias,
  getOnsiteHeaderSearchTerm, getOnsiteSearchTerm,
  // getCurrentPostcode,
} from './digital-data.helper';
import { ProductStyleDetail } from '../../core/db/product-model';
import { GetTestLogger } from '../../core/logger/test.logger';
import { getPageType } from './utils.helper';

interface pageModuleSchemaData {
  pagePath?: string
  pageName?: string
  pageAlias?: string
  pageGender?: string
  pageId?: string
  primaryCategory?: string
  primaryCategoryId?: string
  productStructureGroupId?: string
  subCategory1?: string
  subCategory1Id?: string
  subCategory2?: string
  subCategory2Id?: string
  subCategory3?: string
  subCategory3Id: string
  subCategory4?: string
  subCategory4Id: string
  pageError: string
  onsiteHeaderSearchTerm?: string
  onsiteSearchResults?: string
  onsiteSearchType?: string
  onsiteSearchTerm?: string;
}

interface cartModuleSchema {
  checkoutStep?: string;
}

interface transactionModuleSchema {
  paymentMethod: string
  paymentType: string
  recipientZipCode?: string
  cartShippingOption: string
  shippingCountry?: string
  shippingMethod?: string;
}

interface giftcardModuleSchema {
  paymentMethod: string
  paymentType: string
}

interface pageModulePlpSchemaUnified {
  attributes: {
    pageError: string;
  };
  category: {
    pageType: string;
    primaryCategory: string;
    primaryCategoryId: string;
    productStructureGroupId: string;
    subCategory1: string;
    subCategory1Id: string;
    subCategory2: string;
    subCategory2Id: string;
    subCategory3: string;
    subCategory3Id: string;
    subCategory4: string;
    subCategory4Id: string;
  };
  pageInfo: {
    breadcrumb: string[];
    destinationURL: string;
    pageAlias: string;
    pageName: string;
    pageGender: string;
    pagePath: string;
    pageTitle: string;
    previousPageType: string;
    referringURL: string;
  };
}
// unified schemas
export const versionModuleSchemaUnified = () => joi.object({
  version: joi.string().equal('3.0').required(),
});

export const siteModuleSchema = () => joi.object({
  site: {
    attributes: {
      storeBrand: joi.string()
        .equal(services.env.Brand === 'th' ? 'tommy hilfiger' : 'calvin klein')
        .required(),
      storeLanguage: services.env.Brand === 'th' ? (joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) storeLanguage is not present');
        }
      }).lowercase().required()) : joi.string().min(1).lowercase().required(),
      storeCountry: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) storeCountry is not present');
        }
      }).lowercase().required(),
      storeCurrency: joi.string().equal(services.site.siteInfo.SETCCURR).uppercase(),
      storeVAT: joi.string().min(1).required(),
      siteDeviceVersion: joi.string().custom((value: string) => {
        const expectedValue = (services.env.Platform).toLocaleLowerCase();
        if (value !== expectedValue) {
          throw new Error(`(High priority) expected value: siteDeviceVersion:"${expectedValue}" 
          Actual value: siteDeviceVersion:"${value}"`);
        }
      }).lowercase().required(),
      siteVersion: joi.string().allow(''),
      siteEnvironment: joi.string().min(1).lowercase().required(),
    },
  },
});

export const guestUserModuleSchemaUnified = () => joi.object({
  user: {
    profile: {
      profileId: joi.string().min(1).optional(),
      userLoggedIn: joi.string().equal('0').required(),
      userType: joi.string().custom((value: string) => {
        if (value !== 'guest') {
          let isRequired = '';
          services.env.Brand === 'ck' ? (isRequired = '(High priority) ') : isRequired = '';
          throw new Error(`${isRequired}expected value: userType: "guest" 
          Actual value: userType: "${value}"`);
        }
      }).required(),
      // TO DO: find out how to test gender correctly
      userBehaviourGender: joi.string().min(1).lowercase().required(),
      userNewsletterSignup: joi.string().min(1).required(),
      userAcceptAnalytics: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userAcceptAnalytics is not present');
        }
      }).required(),
      userAcceptSocial: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userAcceptSocial is not present');
        }
      }).required(),
      guestUserEmailEncrypted: joi.string().allow('').optional().disallow('@'),
      userEmailEncrypted: joi.string().allow('').optional().disallow('@'),
      hasWishlist: joi.string().min(1).valid('1', '0').optional(),
    },
    profileInfo: {
      userId: joi.string().optional(),
      contactId: joi.string().min(1).optional(),
      hasPurchased: joi.string().min(1).valid('1', '0').optional(),
      hasReturnedOrder: joi.string().min(1).valid('1', '0').optional(),
      attraqtid: joi.string().regex(/^[a-f\d]{8}-[a-f\d]{4}-4[a-f\d]{3}-[89aAbB][a-f\d]{3}-[a-f\d]{12}$/i).required(),
      userReturnRate: joi.string().min(1).optional(),
    },
  },
});

export const guestUserOrderConfirmationModuleSchemaUnified = () => joi.object({
  user: {
    profile: {
      profileId: joi.string().min(1).optional(),
      userLoggedIn: joi.string().equal('0').required(),
      userType: joi.string().custom((value: string) => {
        if (value !== 'guest') {
          let isRequired = '';
          services.env.Brand === 'ck' ? (isRequired = '(High priority) ') : isRequired = '';
          throw new Error(`${isRequired}expected value: userType: "guest" 
          Actual value: userType: "${value}"`);
        }
      }).required(),
      // TO DO: find out how to test gender correctly
      userBehaviourGender: joi.string().min(1).lowercase().required(),
      userNewsletterSignup: joi.string().min(1).required(),
      userAcceptAnalytics: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userAcceptAnalytics is not present');
        }
      }).required(),
      userAcceptSocial: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userAcceptSocial is not present');
        }
      }).required(),
      guestUserEmailEncrypted: joi.string().allow('').required().disallow('@'),
      userEmailEncrypted: joi.string().allow('').optional().disallow('@'),
      hasWishlist: joi.string().min(1).valid('1', '0').optional(),
    },
    profileInfo: {
      userId: joi.string().optional(),
      contactId: joi.string().min(1).optional(),
      hasPurchased: joi.string().min(1).valid('1', '0').optional(),
      hasReturnedOrder: joi.string().min(1).valid('1', '0').optional(),
      attraqtid: joi.string().regex(/^[a-f\d]{8}-[a-f\d]{4}-4[a-f\d]{3}-[89aAbB][a-f\d]{3}-[a-f\d]{12}$/i).required(),
      userReturnRate: joi.string().min(1).optional(),
    },
  },
});

export const registeredUserModuleSchemaUnified = () => joi.object({
  user: {
    profile: {
      profileId: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) profileId is not present');
        }
      }),
      userLoggedIn: joi.string().equal('1').required(),
      userType: joi.string().custom((value: string) => {
        if (!value) {
          let isRequired = '';
          services.env.Brand === 'ck' ? (isRequired = '(High priority) ') : isRequired = '';
          throw new Error(`${isRequired}Expected value: userType: "registered" 
          Actual value: userType :"${value}"`);
        }
      }).required(),
      // TO DO: find out how to test gender correctly
      userBehaviourGender: joi.string().min(1).required(),
      userNewsletterSignup: joi.string().equal('0').required(),
      userAcceptAnalytics: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userAcceptAnalytics is not present');
        }
      }).required(),
      userAcceptSocial: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userAcceptSocial is not present');
        }
      }).required(),
      userEmailEncrypted: joi.string().custom((value: string) => {
        if (!value || value.includes('@')) {
          throw new Error('(High priority) userEmailEncrypted is not present');
        }
      }).required(),
      userEmailEncryptedGoogle: joi.string().custom((value: string) => {
        if (!value || value.includes('@')) {
          throw new Error('(High priority) userEmailEncryptedGoogle is not present');
        }
      }).required(),
    },
    profileInfo: {
      userId: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userId is not present');
        }
      }),
      // ContactId is not assigned when user is not opted for newsletter subscription(PPL-2123)
      contactId: joi.string().custom(async () => {
        const expectedResult = await browser.waitUntilResult(
          async () => {
            const result = (await browser.execute('return window.digitalData.user.profileInfo.contactId;')).toString();
            return result;
          }, '(High priority) contactId is not present', 30000,
        );
        return expectedResult;
      }).optional(),
      hasPurchased: joi.string().min(1).valid('1', '0').required(),
      hasReturnedOrder: joi.string().min(1).valid('1', '0').required(),
      userReturnRate: joi.string().min(1).required(),
      attraqtid: joi.string().regex(/^[a-f\d]{8}-[a-f\d]{4}-4[a-f\d]{3}-[89aAbB][a-f\d]{3}-[a-f\d]{12}$/i).required(),
      hasWishlist: joi.string().min(1).valid('1', '0').optional(),

    },
  },
});

export const guestUserModulePlpSchemaUnified = () => joi.object({
  user: {
    profile: {
      profileId: joi.string().optional(),
      userLoggedIn: joi.string().equal('0').required(),
      userType: joi.string().custom((value: string) => {
        if (value !== 'guest') {
          let isRequired = '';
          services.env.Brand === 'ck' ? (isRequired = '(High priority) ') : isRequired = '';
          throw new Error(`${isRequired}expected value: userType: "guest" 
          Actual value: userType: "${value}"`);
        }
      }).required(),
      // TO DO: find out how to test gender correctly
      userBehaviourGender: joi.string().min(1).lowercase().required(),
      userNewsletterSignup: joi.string().min(1).required(),
      userAcceptAnalytics: joi.string().min(1).custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userAcceptAnalytics is not present');
        }
      }).required(),
      userAcceptSocial: joi.string().min(1).custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userAcceptSocial is not present');
        }
      }).required(),
    },
    profileInfo: {
      userId: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userId is not present');
        }
      }).optional(),
    },
  },
});

export const registeredUserModulePlpSchemaUnified = () => joi.object({
  user: {
    profile: {
      profileId: joi.string().optional(),
      userLoggedIn: joi.string().equal('1').required(),
      userType: joi.string().custom((value: string) => {
        if (!value) {
          let isRequired = '';
          services.env.Brand === 'ck' ? (isRequired = '(High priority) ') : isRequired = '';
          throw new Error(`${isRequired}Expected value: userType: "registered" 
          Actual value: userType :"${value}"`);
        }
      }).required(),
      // TO DO: find out how to test gender correctly
      userBehaviourGender: joi.string().min(1).required(),
      userNewsletterSignup: joi.string().equal('0').required(),
      userAcceptAnalytics: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userAcceptAnalytics is not present');
        }
      }).required(),
      userAcceptSocial: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userAcceptSocial is not present');
        }
      }).required(),
      userEmailEncrypted: joi.string().custom((value: string) => {
        if (!value || value.includes('@')) {
          throw new Error('(High priority) userEmailEncrypted is not present');
        }
      }).required(),
      userEmailEncryptedGoogle: joi.string().custom((value: string) => {
        if (!value || value.includes('@')) {
          throw new Error('(High priority) userEmailEncryptedGoogle is not present');
        }
      }).required(),
    },
    profileInfo: {
      userId: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userId is not present');
        }
      }),
      contactId: joi.string().custom(async () => {
        const expectedResult = await browser.waitUntilResult(
          async () => {
            const result = (await browser.execute('return window.digitalData.user.profileInfo.contactId;')).toString();
            return result;
          }, '(High priority) contactId is not present', 30000,
        );
        return expectedResult;
      }).optional(),
      hasPurchased: joi.string().min(1).valid('1', '0').required(),
      hasReturnedOrder: joi.string().min(1).valid('1', '0').required(),
      userReturnRate: joi.string().min(1).required(),
      attraqtid: joi.string().regex(/^[a-f\d]{8}-[a-f\d]{4}-4[a-f\d]{3}-[89aAbB][a-f\d]{3}-[a-f\d]{12}$/i).optional(),
      hasWishlist: joi.string().min(1).valid('1', '0').optional(),
      firstPurchaseDate: joi.string().min(1).optional(),
    },
  },
});

/* eslint-disable prefer-destructuring */
export const pageModulePlpSchemaUnified = async (data: pageModulePlpSchemaUnified) => {
  const pagePath = data.pageInfo.pagePath;
  const pageName = data.pageInfo.pageName;
  const pageGender = data.pageInfo.pageGender;
  const pageTitle = await getPageTitle();
  // const pageAlias = pageData.pageAlias;
  const pageAlias = data.pageInfo.pageAlias;
  const hasBreadCrumb = !data.pageInfo.breadcrumb;
  const primaryCategory = data.category.primaryCategory;
  const primaryCategoryId = data.category.primaryCategoryId;
  const subCategory1 = data.category.subCategory1;
  const subCategory1Id = data.category.subCategory1Id;
  const subCategory2 = data.category.subCategory2;
  const subCategory2Id = data.category.subCategory2Id;
  const subCategory3 = data.category.subCategory3;
  const subCategory3Id = data.category.subCategory3Id;
  const subCategory4 = data.category.subCategory4;
  const subCategory4Id = data.category.subCategory4Id;
  const productStructureGroupId = data.category.productStructureGroupId;
  return joi.object({
    page: {
      pageInfo: {
        // TODO: create page related validation for pageFhSourceId when EESK-2590 is done
        pageFhSourceId: joi.string().optional(),
        pagePath: joi.string().custom((value: string) => {
          if (value !== pagePath.toLocaleLowerCase()) {
            throw new Error(`expected pagePath is ${pagePath.toLocaleLowerCase()} but current value is ${value}`);
          }
          return value;
        }).required(),
        pageTitle: joi.string().custom((value: string) => {
          if (value !== pageTitle.toLocaleLowerCase()) {
            throw new Error(`expected pageTitle is ${pageTitle.toLocaleLowerCase()} but current value is ${value}`);
          }
          return value;
        }).required(),
        pageName: joi.string().custom((value: string) => {
          if (value !== pageName.toLocaleLowerCase()) {
            throw new Error(`(High priority) Expected value: pageName:"${pageName.toLocaleLowerCase()}",
            Actual value: pageName:"${value}"`);
          }
          return value;
        }).optional(),
        pageAlias: joi.string().custom((value: string) => {
          if (value !== pageAlias.toLocaleLowerCase()) {
            throw new Error(`expected pageAlias is ${pageAlias.toLocaleLowerCase()} but current value is ${value}`);
          }
          return value;
        }).required(),
        pageGender: pageGender
          ? joi.string().custom((value: string) => {
            if (value !== pageGender.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: pageGender:"${pageGender.toLocaleLowerCase()}",
              Actual value: pageGender:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().lowercase().optional(),
        breadcrumb: hasBreadCrumb ? joi.array().items(joi.string().lowercase()).min(1).required()
          : joi.array().items(joi.string().lowercase()).optional(),
        destinationURL: joi.string().equal((await browser.getUrl()).toLocaleLowerCase()).required(),
        previousPageType: (joi.string().custom((value: string) => {
          if (!value) {
            throw new Error('(High priority) Value is not present');
          }
        }).optional()),
        referringURL: joi.string().lowercase().optional(),
      },
      category: {
        pageType: joi.string().equal('plp'.toLocaleLowerCase()).required(),
        primaryCategory: primaryCategory
          ? joi.string().custom((value: string) => {
            if (value !== primaryCategory.toLocaleLowerCase()) {
              throw new Error(`Expected value: primaryCategory:"${primaryCategory.toLocaleLowerCase()}",
              Actual value: primaryCategory:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        primaryCategoryId: primaryCategoryId
          ? joi.string().custom((value: string) => {
            if (value !== primaryCategoryId.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: primaryCategoryId:"${primaryCategoryId.toLocaleLowerCase()}"
              Actual value: primaryCategoryId:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        productStructureGroupId: productStructureGroupId
          ? joi.string().custom((value: string) => {
            if (value !== productStructureGroupId.toLocaleLowerCase()) {
              throw new Error(`Expected value: productStructureGroupId:"${productStructureGroupId.toLocaleLowerCase()}",
              Actual value: productStructureGroupId"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory1: subCategory1
          ? joi.string().custom((value: string) => {
            if (value !== subCategory1.toLocaleLowerCase()) {
              throw new Error(`Expected subCategory1:"${subCategory1.toLocaleLowerCase()}", 
              Actual value: subCategory1:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory1Id: subCategory1Id
          ? joi.string().custom((value: string) => {
            if (value !== subCategory1Id.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: subCategory1Id:"${subCategory1Id.toLocaleLowerCase()}",
              Actual value: subCategory1Id:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory2: subCategory2
          ? joi.string().custom((value: string) => {
            if (value !== subCategory2.toLocaleLowerCase()) {
              throw new Error(`Expected value: subCategory2:"${subCategory2.toLocaleLowerCase()}",
              Actual value: subCategory2:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory2Id: subCategory2Id
          ? joi.string().custom((value: string) => {
            if (value !== subCategory2Id.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: subCategory2Id:"${subCategory2Id.toLocaleLowerCase()}",
              Actual value: subCategory2Id:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory3: subCategory3
          ? joi.string().custom((value: string) => {
            if (value !== subCategory3.toLocaleLowerCase()) {
              throw new Error(`Expected value: subCategory3:"${subCategory3.toLocaleLowerCase()}",
              Actual value: subCategory3:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory3Id: subCategory3Id
          ? joi.string().custom((value: string) => {
            if (value !== subCategory3Id.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: subCategory3Id:"${subCategory3Id.toLocaleLowerCase()}",
              Actual value: subCategory3Id:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory4: subCategory4
          ? joi.string().custom((value: string) => {
            if (value !== subCategory4.toLocaleLowerCase()) {
              throw new Error(`Expected value: subCategory4:"${subCategory4.toLocaleLowerCase()}",
              Actual value: subCategory4:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory4Id: subCategory4Id
          ? joi.string().custom((value: string) => {
            if (value !== subCategory4Id.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: subCategory4Id:"${subCategory4Id.toLocaleLowerCase()}",
              Actual value: subCategory4Id:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
      },
      attributes: {
        pageError: joi.string().valid('0', '1').required(),
      },
    },
  });
};

export const pageModuleSchemaUnified = async (pageType: string, data: pageModuleSchemaData) => {
  const currentUrl = (await browser.getUrl()).toLocaleLowerCase();
  if (currentUrl.includes('performance')) {
    pageType = 'glp performance';
  }
  const pagePath = pageType === 'glp' || pageType === 'plp' || pageType === 'pdp' || pageType === 'return center' || pageType === 'customerservice' ? await getPagePath() : data.pagePath;
  const pageName = pageType === 'glp' || pageType === 'plp' || pageType === 'pdp' ? await getPageName(pageType) : data.pageName;
  const pageGender = pageType === 'glp' || pageType === 'plp' || pageType === 'pdp' ? await getPageGender() : data.pageGender;
  const pageTitle = await getPageTitle();
  const pageAlias = pageType === 'pdp' || pageType === 'plp' || pageType === 'search results page' ? await getPageAlias() : data.pageAlias;
  const hasBreadCrumb = !!(pageType === 'glp' || pageType === 'plp' || pageType === 'pdp');
  const primaryCategory = pageType === 'glp' || pageType === 'plp' || pageType === 'pdp' ? await getPrimaryCategory() : data.primaryCategory;
  const primaryCategoryId = pageType === 'glp' || pageType === 'plp' || pageType === 'pdp' ? await getPrimaryCategoryId() : data.primaryCategoryId;
  const subCategory1 = pageType === 'plp' || pageType === 'pdp' ? await getSubCategory1() : data.subCategory1;
  const subCategory1Id = pageType === 'plp' || pageType === 'pdp' ? await getSubCategory1Id() : data.subCategory1Id;
  const subCategory2 = pageType === 'plp' || pageType === 'pdp' ? await getSubCategory2() : data.subCategory2;
  const subCategory2Id = pageType === 'plp' || pageType === 'pdp' ? await getSubCategory2Id() : data.subCategory2Id;
  const subCategory3 = pageType === 'plp' || pageType === 'pdp' ? await getSubCategory3() : data.subCategory3;
  const subCategory3Id = pageType === 'plp' || pageType === 'pdp' ? await getSubCategory3Id() : data.subCategory3Id;
  const subCategory4 = pageType === 'plp' || pageType === 'pdp' ? await getSubCategory4() : data.subCategory4;
  const subCategory4Id = pageType === 'plp' || pageType === 'pdp' ? await getSubCategory4Id() : data.subCategory4Id;
  const productStructureGroupId = pageType === 'glp' || pageType === 'plp' || pageType === 'pdp' ? await getProductStructureGroupId() : data.productStructureGroupId;
  const onsiteSearchTerm = pageType === 'search results page' ? await getOnsiteSearchTerm() : data.onsiteSearchTerm;

  return joi.object({
    page: {
      pageInfo: {
        // TODO: create page related validation for pageFhSourceId when EESK-2590 is done
        pageFhSourceId: joi.string().optional(),
        pagePath: joi.string().custom((value: string) => {
          if (value !== pagePath.toLocaleLowerCase()) {
            throw new Error(`expected pagePath is ${pagePath.toLocaleLowerCase()} but current value is ${value}`);
          }
          return value;
        }).required(),
        pageTitle: joi.string().custom((value: string) => {
          if (value !== pageTitle.toLocaleLowerCase()) {
            throw new Error(`expected pageTitle is ${pageTitle.toLocaleLowerCase()} but current value is ${value}`);
          }
          return value;
        }).required(),
        pageName: joi.string().custom((value: string) => {
          if (value !== pageName.toLocaleLowerCase()) {
            throw new Error(`(High priority) Expected value: pageName:"${pageName.toLocaleLowerCase()}",
            Actual value: pageName:"${value}"`);
          }
          return value;
        }).required(),
        pageAlias: joi.string().custom((value: string) => {
          if (value !== pageAlias.toLocaleLowerCase()) {
            throw new Error(`expected pageAlias is ${pageAlias.toLocaleLowerCase()} but current value is ${value}`);
          }
          return value;
        }).required(),
        pageGender: pageGender
          ? joi.string().custom((value: string) => {
            if (value !== pageGender.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: pageGender:"${pageGender.toLocaleLowerCase()}",
              Actual value: pageGender:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().lowercase().optional(),
        breadcrumb: hasBreadCrumb ? joi.array().items(joi.string().lowercase()).min(1).required()
          : joi.array().items(joi.string().lowercase()).optional(),
        destinationURL: joi.string().equal((await browser.getUrl()).toLocaleLowerCase()).required(),
        previousPageType: pageType !== 'homepage' && pageType !== 'plp' ? (joi.string().custom((value: string) => {
          if (!value) {
            throw new Error('(High priority) Value is not present');
          }
        }).required()) : joi.string().optional(),
        referringURL: pageType === 'homepage' || pageType === 'plp' ? joi.string().lowercase().optional() : joi.string().lowercase().required(),
      },
      category: {
        pageType: pageType === 'glp performance'
          ? joi.string().equal((pageType.split(' ')[0]).toLocaleLowerCase()).required()
          : joi.string().equal(pageType.toLocaleLowerCase()).required(),
        primaryCategory: primaryCategory
          ? joi.string().custom((value: string) => {
            if (value !== primaryCategory.toLocaleLowerCase()) {
              throw new Error(`Expected value: primaryCategory:"${primaryCategory.toLocaleLowerCase()}",
              Actual value: primaryCategory:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        primaryCategoryId: primaryCategoryId
          ? joi.string().custom((value: string) => {
            if (value !== primaryCategoryId.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: primaryCategoryId:"${primaryCategoryId.toLocaleLowerCase()}"
              Actual value: primaryCategoryId:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        productStructureGroupId: productStructureGroupId
          ? joi.string().custom((value: string) => {
            if (value !== productStructureGroupId.toLocaleLowerCase()) {
              throw new Error(`Expected value: productStructureGroupId:"${productStructureGroupId.toLocaleLowerCase()}",
              Actual value: productStructureGroupId"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory1: subCategory1
          ? joi.string().custom((value: string) => {
            if (value !== subCategory1.toLocaleLowerCase()) {
              throw new Error(`Expected subCategory1:"${subCategory1.toLocaleLowerCase()}", 
              Actual value: subCategory1:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory1Id: subCategory1Id
          ? joi.string().custom((value: string) => {
            if (value !== subCategory1Id.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: subCategory1Id:"${subCategory1Id.toLocaleLowerCase()}",
              Actual value: subCategory1Id:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory2: subCategory2
          ? joi.string().custom((value: string) => {
            if (value !== subCategory2.toLocaleLowerCase()) {
              throw new Error(`Expected value: subCategory2:"${subCategory2.toLocaleLowerCase()}",
              Actual value: subCategory2:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory2Id: subCategory2Id
          ? joi.string().custom((value: string) => {
            if (value !== subCategory2Id.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: subCategory2Id:"${subCategory2Id.toLocaleLowerCase()}",
              Actual value: subCategory2Id:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory3: subCategory3
          ? joi.string().custom((value: string) => {
            if (value !== subCategory3.toLocaleLowerCase()) {
              throw new Error(`Expected value: subCategory3:"${subCategory3.toLocaleLowerCase()}",
              Actual value: subCategory3:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory3Id: subCategory3Id
          ? joi.string().custom((value: string) => {
            if (value !== subCategory3Id.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: subCategory3Id:"${subCategory3Id.toLocaleLowerCase()}",
              Actual value: subCategory3Id:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory4: subCategory4
          ? joi.string().custom((value: string) => {
            if (value !== subCategory4.toLocaleLowerCase()) {
              throw new Error(`Expected value: subCategory4:"${subCategory4.toLocaleLowerCase()}",
              Actual value: subCategory4:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory4Id: subCategory4Id
          ? joi.string().custom((value: string) => {
            if (value !== subCategory4Id.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: subCategory4Id:"${subCategory4Id.toLocaleLowerCase()}",
              Actual value: subCategory4Id:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
      },
      attributes: {
        pageError: joi.string().valid('0', '1').required(),
      },
      search: {
        onsiteSearchResults: pageType === 'search results page' ? joi.string().min(1).required() : joi.string().min(1).optional(),
        onsiteSearchTerm: pageType === 'search results page'
          ? joi.string().equal(onsiteSearchTerm).required()
          : joi.string().lowercase().optional(),
        onsiteSearchType: joi.string().equal('search').optional(),
      },
    },
  });
};

export const pdpProductModuleSchemaUnified = async (productStyleDetail: ProductStyleDetail) => {
  let getProductAvailabilityPercentage = '';
  const allSizes = await services.product.productStyle
    .extractProductItems(productStyleDetail).length;
  const inStockSizes = (allSizes - (services.product.productStyle
    .extractProductItemListWithInventory(productStyleDetail, 0, 0).length));
  getProductAvailabilityPercentage = ((inStockSizes / allSizes) * 100).toFixed(2).toString();

  return joi.object({
    product: joi.array().items(joi.object({
      productInfo: {
        productName: joi.string().custom((value: string) => {
          if (value !== productStyleDetail.ANALYTICS_NAME.toLocaleLowerCase().trim()) {
            throw new Error(`(High priority) Expected value: productName:"${productStyleDetail.ANALYTICS_NAME.toLocaleLowerCase().trim()}", 
            Actual value: productName:"${value}"`);
          }
          return value;
        }).required(),
        productId: joi.string()
          .equal(productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase()).required(),
        productStyle: joi.string().custom((value: string) => {
          if (value !== productStyleDetail.STYLE_PARTNUMBER.toLocaleLowerCase()) {
            throw new Error(`(High priority) Expected value: productStyle:"${productStyleDetail.STYLE_PARTNUMBER.toLocaleLowerCase()}",
            Actual value: productStyle:"${value}"`);
          }
        }).required(),
        productCombi: joi.string().custom((value: string) => {
          if (value !== productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase()) {
            throw new Error(`(High priority) Expected value: productCombi:"${productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase().trim()}",
            Actual value: productCombi:"${value}"`);
          }
          return value;
        }).required(),
        // TODO: check with CND to see if uppercases are required
        productCombiUppercase: joi.string().custom((value: string) => {
          if (value !== productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleUpperCase()) {
            throw new Error(`(High priority) Expected value: productCombiUppercase:"${productStyleDetail.STYLECOLOUR_PARTNUMBER.toUpperCase().trim()}",
            Actual value: productCombiUppercase:"${value}"`);
          }
          return value;
        }).optional(),
        productColour: joi.string().custom((value: string) => {
          if (value !== productStyleDetail.ANALYTICS_MAIN_COLOUR.toLocaleLowerCase()) {
            throw new Error(`(High priority) Expected value: productColour:"${productStyleDetail.ANALYTICS_MAIN_COLOUR.toLocaleLowerCase().trim()}",
            Actual value: productColour:"${value}"`);
          }
        }).required(),
        productCategory: joi.string().custom(async (value: string) => {
          if (services.env.Brand === 'ck') {
            const productGBPC = await browser.execute('return window.__NEXT_DATA__.props.initialState.productPage.data.productGbpc').toString().toLocaleLowerCase();
            if (value !== productGBPC) {
              throw new Error(`(High priority) Expected value: productCategory:"${productGBPC}",
              Actual value: productCategory:"${value}"`);
            }
          } else {
            joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).required();
          }
          return value;
        }),
        productCategoryAlias: joi.string().custom(async (value: string) => {
          if (services.env.Brand === 'ck') {
            const productGBPC = await browser.execute('return window.__NEXT_DATA__.props.initialState.productPage.data.productGbpc').toString().toLocaleLowerCase();
            if (value !== productGBPC) {
              throw new Error(`expected productCategory is ${productGBPC} but current value is ${value}`);
            }
          } else {
            joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).required();
          }
          return value;
        }),
        productGBPC: joi.string().custom(async (value: string) => {
          if (services.env.Brand === 'ck') {
            const productGBPC = await browser.execute('return window.__NEXT_DATA__.props.initialState.productPage.data.productGbpc').toString().toLocaleLowerCase();
            if (value !== productGBPC) {
              throw new Error(`(High priority) Expected value: productGBPC:"${productGBPC}",
              Actual value: productCategory:"${value}"`);
            }
          } else {
            joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).required();
          }
          return value;
        }).optional(),
        productBrand: joi.string().custom((value: string) => {
          if (!value) {
            throw new Error('(High priority) productBrand is not present');
          }
        }).required(),
        productMerchHierarchy: joi.string().min(1).required(),
        productDivision: joi.string().custom((value: string) => {
          if (value !== productStyleDetail.DIVISION.toLocaleLowerCase()) {
            throw new Error(`(High priority) Expected value: productDivision:"${productStyleDetail.DIVISION.toLocaleLowerCase().trim()}",
            Actual value: productDivision:"${value}"`);
          }
          return value;
        }).required(),
        productGender: joi.string().min(1).lowercase().required(),
        productBasePrice: joi.string().custom((value: string) => {
          const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
          const expectedValue = priceInfo.minWasPrice
            && priceInfo.minWasPrice !== Number.MAX_VALUE
            && priceInfo.minWasPrice !== priceInfo.minCurrentPrice
            ? priceInfo.minWasPrice
            : priceInfo.minCurrentPrice;
          if (value !== expectedValue.toFixed(2)) {
            throw new Error(`(High priority) Expected value: productBasePrice:"${expectedValue}",
          Actual value: productBasePrice:"${value}"`);
          }
          return value;
        }).required(),
        productLowPrice: joi.string().custom((value: string) => {
          const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
          const expectedValue = priceInfo.minCurrentPrice.toFixed(2);
          if (value !== expectedValue) {
            throw new Error(`(High priority) Expected value: productLowPrice:"${expectedValue}", 
          Actual value: productLowPrice:"${value}"`);
          }
          return value;
        }).required(),
        productPrice: joi.string().custom((value: string) => {
          const expectedValue = services.product.productStyle
            .extractMinMaxPrice(productStyleDetail);
          if (value !== expectedValue.minCurrentPrice.toFixed(2)) {
            throw new Error(`expected productPrice is ${expectedValue} but current value is ${value}`);
          }
          return value;
        }).required(),
        productTax: joi.string().min(1).required(),
        productDiscount: joi.string().custom((value: string) => {
          const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
          const basePrice = priceInfo.minWasPrice;
          const discount = basePrice - priceInfo.minCurrentPrice;
          if (value !== '0') {
            value = discount.toFixed(2);
          } else {
            value = '0';
          }
          return value;
        }).required(),
        productDiscountStatus: joi.string().custom((value: string) => {
          const expectedValue = services.product.productStyle
            .extractMinMaxPrice(productStyleDetail);
          if (value !== (expectedValue.minWasPrice && expectedValue.minWasPrice !== Number.MAX_VALUE && expectedValue.minWasPrice !== expectedValue.minCurrentPrice ? 'discounted' : 'full')) {
            let isRequired = '';
            services.env.Brand === 'th' ? (isRequired = '(High priority) ') : isRequired = '';
            throw new Error(`${isRequired}Expected value: productDiscountStatus:"${expectedValue}",
            Actual value: productDiscountStatus:"${value}"`);
          }
          return value;
        }).required(),
        productEANOutOfStock: joi.string().min(1).required(),
        ranking: joi.string().valid('0', '1', '2').required(),
        promoActivity: joi.string().valid('0', '1').required(),
        productPromoFlag: joi.string().min(1).optional(),
      },
      stock: {
        productAvailabilityPercentage: joi.string().custom(async (value: string) => {
          if (value !== getProductAvailabilityPercentage) {
            throw new Error(`expected productAvailabilityPercentage is ${getProductAvailabilityPercentage} but current value is ${value}`);
          }
        }).required(),
        productInFullStock: joi.string().custom(async (value: string) => {
          const stylePartNumber = productStyleDetail.STYLE_PARTNUMBER;
          const detail = await services.product.product.getDetail(stylePartNumber);
          const expectedValue = services.product.product
            .extractOutOfStockProductItems(detail);
          if (value !== (expectedValue.length > 0 ? '0' : '1')) {
            throw new Error(`(High priority) Expected value: productInFullStock:"${expectedValue}",
            Actual value: productInFullStock:"${value}"`);
          }
          return value;
        }).required(),
        productOutOfStockSizes: joi.string().custom((value: string) => {
          const outOfStockItems = services.product.productStyle
            .extractProductItemListWithInventory(productStyleDetail, 0, 0);
          if (outOfStockItems && outOfStockItems.length > 0) {
            const actualValue = value.split(',').map((v) => v.trim()).sort().join(',');
            let expectedValue = '';
            if (outOfStockItems[0].SIZE_NAME) {
              if (outOfStockItems[0].SIZE_NAME.toLowerCase() === 'one size' || outOfStockItems[0].SIZE_NAME.toLowerCase() === 'os') {
                expectedValue = 'one_size';
              } else {
                expectedValue = outOfStockItems.map((p) => p.SIZE_NAME.toLocaleLowerCase()).sort().join(',');
              }
            } else if (outOfStockItems[0].WIDTH_NAME && !outOfStockItems[0].LENGTH_NAME) {
              expectedValue = outOfStockItems.map((p) => p.WIDTH_NAME.toLocaleLowerCase()).sort().join(',');
            } else if (outOfStockItems[0].WIDTH_NAME && outOfStockItems[0].LENGTH_NAME) {
              expectedValue = outOfStockItems.map((p) => `${p.WIDTH_NAME.toLocaleLowerCase()}-${p.LENGTH_NAME.toLocaleLowerCase()}`).sort().join(',');
              if (expectedValue.includes('eu')) {
                expectedValue = expectedValue.replace('eu', '');
              }
            } else {
              throw new Error(`cannot identify the sizes for product style: ${productStyleDetail}`);
            }
            if (expectedValue !== actualValue) {
              let isRequired = '';
              services.env.Brand === 'th' ? (isRequired = '(High priority) ') : isRequired = '';
              throw new Error(`${isRequired}Expected value: productOutOfStockSizes:"${expectedValue}",
              Actual value: productOutOfStockSizes:"${actualValue}"`);
            }
          } else if (value && value !== '') {
            throw new Error(`Expected empty productOutOfStockSizes but actual value: productOutOfStockSizes:"${value}"`);
          }
          return value;
        }, 'product out of stock validator'),
      },
    })).length(1),
  });
};

export const wishlistModuleSchemaUnified = (productStyleDetail: ProductStyleDetail) => joi.object({
  wishlist: {
    size: joi.string().equal('1').required(),
    wishlistId: joi.string().min(1).required(),
    item: joi.array().items(joi.object({
      productId: joi.string()
        .equal(productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase()).required(),
      productMerchHierarchy: joi.string().min(1).required(),
      productBrand: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) productBrand is not present');
        }
      }).required(),
      productStyle: services.env.Brand === 'ck' ? (joi.string().custom((value: string) => {
        if (value !== productStyleDetail.STYLE_PARTNUMBER.toLocaleLowerCase()) {
          throw new Error(`(High priority) Expected value:
      productStyle:"${productStyleDetail.STYLE_PARTNUMBER.toLocaleLowerCase().trim()}",
          Actual value: productStyle:"${value}"`);
        }
        return value;
      }).required()) : joi.string().optional(),
      productDivision: services.env.Brand === 'ck' ? (joi.string().custom((value: string) => {
        if (value !== productStyleDetail.DIVISION.toLocaleLowerCase()) {
          throw new Error(`(High priority) Expected value:
      productDivision:"${productStyleDetail.DIVISION.toLocaleLowerCase().trim()}",
        Actual value: productDivision:"${value}"`);
        }
        return value;
      }).required()) : joi.string().optional(),
      productCombi: joi.string().custom((value: string) => {
        if (value !== productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase()) {
          throw new Error(`(High priority) Expected value: productCombi:"${productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase().trim()}",
          Actual value: productCombi:"${value}"`);
        }
        return value;
      }).required(),
      // TODO: check with CND if uppercase is required
      productCombiUppercase: joi.string().custom((value: string) => {
        if (value !== productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleUpperCase()) {
          throw new Error(`(High priority) Expected value: productCombiUppercase:"${productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleUpperCase().trim()}",
          Actual value: productCombiUppercase:"${value}"`);
        }
        return value;
      }).required(),
      productLowPrice: joi.string().custom((value: string) => {
        const priceInfo = services.product.productStyle
          .extractMinMaxPrice(productStyleDetail);
        const expectedValue = priceInfo.minCurrentPrice.toFixed(2);
        if (value !== expectedValue) {
          throw new Error(`(High priority) Expected value: productLowPrice:"${expectedValue}",
          Actual value: productLowPrice:"${value}"`);
        }
        return value;
      }).required(),
      productName: joi.string().custom((value: string) => {
        if (value !== productStyleDetail.ANALYTICS_NAME.toLocaleLowerCase().trim()) {
          throw new Error(`(High priority) Expected value: productName:"${productStyleDetail.ANALYTICS_NAME.toLocaleLowerCase().trim()}",
          Actual value: productName:"${value}"`);
        }
        return value;
      }).required(),
      productColour: joi.string().custom((value: string) => {
        if (value !== productStyleDetail.ANALYTICS_MAIN_COLOUR.toLocaleLowerCase()) {
          throw new Error(`(High priority) Expected value: productColour:"${productStyleDetail.ANALYTICS_NAME.toLocaleLowerCase().trim()}",
          Actual value: productColour:"${value}"`);
        }
      }).required(),
      productBasePrice: joi.string().custom((value: string) => {
        const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
        const expectedValue = priceInfo.minWasPrice
          && priceInfo.minWasPrice !== Number.MAX_VALUE
          && priceInfo.minWasPrice !== priceInfo.minCurrentPrice
          ? priceInfo.minWasPrice
          : priceInfo.minCurrentPrice;
        if (value !== expectedValue.toFixed(2)) {
          throw new Error(`(High priority) Expected value: productBasePrice:"${expectedValue}",
          Actual value: productBasePrice:"${value}"`);
        }
        return value;
      }).required(),
      productCategory: joi.string().custom((value: string) => {
        if (services.env.Brand === 'ck') {
          joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).optional();
        } else {
          joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).required();
        }
        return value;
      }),
      productCategoryAlias: joi.string().custom((value: string) => {
        if (services.env.Brand === 'ck') {
          joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).optional();
        } else {
          joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).required();
        }
        return value;
      }),
      productDiscount: joi.string().custom((value: string) => {
        const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
        const basePrice = priceInfo.minWasPrice;
        const discount = basePrice - priceInfo.minCurrentPrice;
        if (value !== '0') {
          value = discount.toFixed(2);
        } else {
          value = '0';
        }
        return value;
      }).required(),
      productDiscountStatus: joi.string().custom((value: string) => {
        const priceInfo = services.product.productStyle
          .extractMinMaxPrice(productStyleDetail);
        const expectedValue = priceInfo.minWasPrice && priceInfo.minWasPrice !== Number.MAX_VALUE && priceInfo.minWasPrice !== priceInfo.minCurrentPrice ? 'discounted' : 'full';
        if (value !== expectedValue) {
          let isRequired = '';
          services.env.Brand === 'ck' ? (isRequired = '(High priority) ') : isRequired = '';
          throw new Error(`${isRequired}Expected value: productDiscountStatus:"${expectedValue}",
          Actual value: productDiscountStatus:"${value}"`);
        }
        return value;
      }).required(),
      productGender: joi.string().min(1).lowercase().required(),
      productPrice: joi.string().custom((value: string) => {
        const priceInfo = services.product.productStyle
          .extractMinMaxPrice(productStyleDetail);
        const expectedValue = priceInfo.minCurrentPrice.toFixed(2);
        if (value !== expectedValue) {
          throw new Error(`expected productPrice is ${expectedValue} but current value is ${value}`);
        }
        return value;
      }).required(),
      stock: {
        productInFullStock: joi.string().custom(async (value: string) => {
          const stylePartNumber = productStyleDetail.STYLE_PARTNUMBER;
          const detail = await services.product.product.getDetail(stylePartNumber);
          const productInfo = services.product.product
            .extractOutOfStockProductItems(detail);
          const expectedValue = productInfo.length > 0 ? '0' : '1';
          if (value !== expectedValue) {
            throw new Error(`(High priority) Expected value: productInFullStock:"${expectedValue}",
            Actual value: productInFullStock:"${value}"`);
          }
          return value;
        }).required(),
        productOutOfStockSizes: joi.string().custom((value: string) => {
          const outOfStockItems = services.product.productStyle
            .extractProductItemListWithInventory(productStyleDetail, 0, 0);
          if (outOfStockItems && outOfStockItems.length > 0) {
            const actualValue = value.split(',').map((v) => v.trim()).sort().join(',');
            let expectedValue = '';
            if (outOfStockItems[0].SIZE_NAME) {
              expectedValue = outOfStockItems.map((p) => p.SIZE_NAME.toLocaleLowerCase()).sort().join(',');
            } else if (outOfStockItems[0].WIDTH_NAME && !outOfStockItems[0].LENGTH_NAME) {
              expectedValue = outOfStockItems.map((p) => p.WIDTH_NAME.toLocaleLowerCase()).sort().join(',');
            } else if (outOfStockItems[0].WIDTH_NAME && outOfStockItems[0].LENGTH_NAME) {
              expectedValue = outOfStockItems.map((p) => `${p.WIDTH_NAME.toLocaleLowerCase()}-${p.LENGTH_NAME.toLocaleLowerCase()}`).sort().join(',');
            } else {
              throw new Error(`(High priority) cannot identify the sizes for product style: ${productStyleDetail}`);
            }
            if (expectedValue !== actualValue) {
              throw new Error(`(High priority) Expected value: productOutOfStockSizes:"${expectedValue}", 
              Actual value productOutOfStockSizes"${actualValue}"`);
            }
          } else if (value && value !== '') {
            throw new Error(`(High priority) Expected empty productOutOfStockSizes but current value is "${value}"`);
          }
          return value;
        }, 'product out of stock validator'),
      },
    })),
  },
});

// common schemas
export const emptyWishlistSchema = () => joi.object({
  wishlist: {
    size: joi.string().equal('0').required(),
  },
});

export const cartItemModuleSchema = (productStyleDetail: ProductStyleDetail) => joi.object({
  productBasePrice: joi.string().custom((value: string) => {
    const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
    const expectedValue = priceInfo.minWasPrice
      && priceInfo.minWasPrice !== Number.MAX_VALUE
      && priceInfo.minWasPrice !== priceInfo.minCurrentPrice
      ? priceInfo.minWasPrice
      : priceInfo.minCurrentPrice;
    if (value !== expectedValue.toFixed(2)) {
      throw new Error(`(High priority) Expected value: productBasePrice:"${expectedValue}",
          Actual value: productBasePrice:"${value}"`);
    }
    return value;
  }).required(),
  productBrand: joi.string().custom((value: string) => {
    if (!value) {
      throw new Error('(High priority) productBrand is not present');
    }
  }).required(),
  productCategory: joi.string().custom((value: string) => {
    if (services.env.Brand === 'ck') {
      joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).optional();
    } else {
      joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).required();
    }
    return value;
  }),
  productCategoryAlias: joi.string().custom((value: string) => {
    if (services.env.Brand === 'ck') {
      joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).optional();
    } else {
      joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).required();
    }
    return value;
  }),
  productColour: joi.string()
    .equal(productStyleDetail.ANALYTICS_MAIN_COLOUR.toLocaleLowerCase()).required(),
  productCombi: joi.string().custom((value: string) => {
    if (value !== productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase()) {
      throw new Error(`(High priority) Expected value: productCombi:"${productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase().trim()}",
          Actual value: productCombi:"${value}"`);
    }
    return value;
  }).required(),
  // TODO: check with CND to see if uppercases are required
  productCombiUppercase: joi.string().custom((value: string) => {
    if (value !== productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleUpperCase()) {
      throw new Error(`(High priority) Expected value: productCombiUppercase:"${productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleUpperCase().trim()}",
          Actual value: productCombiUppercase:"${value}"`);
    }
    return value;
  }).optional(),
  // TODO: check if this variable is required for unification
  productCombiId: joi.string().required(),
  productDiscount: joi.string().custom((value: string) => {
    const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
    const basePrice = priceInfo.minWasPrice;
    const discount = basePrice - priceInfo.minCurrentPrice;
    if (value !== '0') {
      value = discount.toFixed(2);
    } else {
      value = '0';
    }
    return value;
  }).required(),
  productDiscountStatus: joi.string().custom((value: string) => {
    const priceInfo = services.product.productStyle
      .extractMinMaxPrice(productStyleDetail);
    const expectedValue = priceInfo.minWasPrice && priceInfo.minWasPrice !== Number.MAX_VALUE && priceInfo.minWasPrice !== priceInfo.minCurrentPrice ? 'discounted' : 'full';
    if (value !== expectedValue) {
      throw new Error(`(High priority) Expected value: productDiscountStatus:"${expectedValue}",
          Actual value: productDiscountStatus:"${value}"`);
    }
    return value;
  }).required(),
  productDivision: joi.string().custom((value: string) => {
    if (value !== productStyleDetail.DIVISION.toLocaleLowerCase()) {
      throw new Error(`(High priority) Expected value: productDivision:"${productStyleDetail.DIVISION.toLocaleLowerCase().trim()}",
          Actual value: productDivision:"${value}"`);
    }
    return value;
  }).required(),
  productGender: joi.string().min(1).lowercase().required(),
  productEAN: joi.string().custom((value: string) => {
    if (!value) {
      throw new Error('(High priority) productEAN is not present');
    }
  }).required(),
  // TODO: check if this variable is required for unification
  productEANOutOfStock: joi.string().optional(),
  productGBPC: joi.string().custom((value: string) => {
    if (services.env.Brand === 'ck') {
      joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).optional();
    } else {
      joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).required();
    }
    return value;
  }),
  productId: joi.string()
    .equal(productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase()).required(),
  productLowPrice: joi.string().custom((value: string) => {
    const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
    const expectedValue = priceInfo.minCurrentPrice.toFixed(2);
    if (value !== expectedValue) {
      throw new Error(`(High priority) Expected value: productLowPrice:"${expectedValue}", 
          Actual value: productLowPrice:"${value}"`);
    }
    return value;
  }).required(),
  productName: joi.string().custom((value: string) => {
    if (value !== productStyleDetail.ANALYTICS_NAME.toLocaleLowerCase().trim()) {
      throw new Error(`(High priority) Expected value: productName:"${productStyleDetail.ANALYTICS_NAME.toLocaleLowerCase().trim()}",
          Actual value: productName:"${value}"`);
    }
    return value;
  }).required(),
  productMerchHierarchy: joi.string().min(1).required(),
  productPrice: joi.string().custom((value: string) => {
    const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
    const expectedValue = priceInfo.minCurrentPrice.toFixed(2);
    if (value !== expectedValue) {
      throw new Error(`expected productPrice is ${expectedValue} but current value is ${value}`);
    }
    return value;
  }).required(),
  productQuantity: joi.string().custom((value: string) => {
    if (!value) {
      throw new Error('(High priority) productQuantity is not present');
    }
  }).required(),
  productSize: joi.string().custom((value: string) => {
    if (!value) {
      throw new Error('(High priority) productSize is not present');
    }
  }).required(),
  productSku: joi.string().custom((value: string) => {
    if (!value) {
      let isRequired = '';
      services.env.Brand === 'ck' ? (isRequired = '(High priority) ') : isRequired = '';
      throw new Error(`${isRequired}productSku is not present`);
    }
  }).required(),
  productStyle: joi.string().custom((value: string) => {
    if (!value) {
      let isRequired = '';
      services.env.Brand === 'ck' ? (isRequired = '(High priority) ') : isRequired = '';
      throw new Error(`${isRequired}Expected value: productStyle:"${productStyleDetail.STYLE_PARTNUMBER.toLocaleLowerCase()}",
            Actual value: productStyle:"${value}"`);
    }
    return value;
  }).required(),
  productTax: joi.string().min(1).required(),
});

export const cartModuleSchema = (data: cartModuleSchema) => joi.object({
  cart: {
    cartId: joi.string().min(1).optional(),
    checkoutStep: (data.checkoutStep
      ? (joi.string().custom((value: string) => {
        const expectedValue = data.checkoutStep;
        if (value !== expectedValue) {
          throw new Error(`(High priority) Expected value: checkoutStep:"${expectedValue}",
          Actual value: checkoutStep:"${value}"`);
        }
        return value;
      }).required()) : joi.string().optional()),
    total: {
      cartBasePrice: joi.string().min(1).required(),
      cartLowPrice: joi.string().min(1).required(),
      cartPrice: joi.string().min(1).required(),
      cartQuantity: joi.string().min(1).required(),
      cartRevenue: joi.string().min(1).required(),
      cartShipping: joi.string().min(1).required(),
      cartShippingOption: joi.string().min(1).required(),
      cartTax: joi.string().min(1).required(),
      cartTotal: joi.string().min(1).required(),
      cartValue: joi.string().min(1).required(),
      cartVoucherUsed: joi.string().min(1).required(),
    },
    voucher: {
      totalAppliedOnItems: joi.string().min(1).required(),
      totalAppliedOnOrder: joi.string().min(1).required(),
      voucherName: joi.string().min(1).required(),
      voucherTotal: joi.string().min(1).required(),
    },
  },
});

export const transactionItemModuleSchema = (productStyleDetail: ProductStyleDetail) => joi.object({
  productBasePrice: joi.string().custom((value: string) => {
    const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
    const expectedValue = priceInfo.minWasPrice
      && priceInfo.minWasPrice !== Number.MAX_VALUE
      && priceInfo.minWasPrice !== priceInfo.minCurrentPrice
      ? priceInfo.minWasPrice
      : priceInfo.minCurrentPrice;
    if (value !== expectedValue.toFixed(2)) {
      throw new Error(`(High priority) Expected value: productBasePrice:"${expectedValue.toFixed(2)}",
    Actual value: productBasePrice:"${value}"`);
    }
    return value;
  }).required(),
  productBrand: joi.string().custom((value: string) => {
    if (!value) {
      throw new Error('(High priority) productBrand is not present');
    }
  }).required(),
  productCategory: productStyleDetail.GBPC === null ? (joi.string().optional())
    : (joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).required()),
  productCategoryAlias: productStyleDetail.GBPC === null ? (joi.string().optional())
    : (joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).required()),
  productColour: joi.string().custom((value: string) => {
    if (value !== productStyleDetail.ANALYTICS_MAIN_COLOUR.toLocaleLowerCase()) {
      throw new Error(`(High priority) Expected value: productColour:"${productStyleDetail.ANALYTICS_MAIN_COLOUR.toLocaleLowerCase().trim()}",
      Actual value: productColour:"${value}"`);
    }
  }).required(),
  productCombi: joi.string().custom((value: string) => {
    if (value !== productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase()) {
      throw new Error(`(High priority) Expected value: productCombi:"${productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase().trim()}",
    Actual value: productCombi:"${value}"`);
    }
    return value;
  }).required(),
  productCombiUppercase: joi.string().custom((value: string) => {
    if (value !== productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleUpperCase()) {
      throw new Error(`(High priority) Expected value: productCombiUppercase:"${productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleUpperCase().trim()}",
    Actual value: productCombiUppercase:"${value}"`);
    }
    return value;
  }).required(),
  productCombiId: joi.string().required(),
  productDiscount: joi.string().custom((value: string) => {
    const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
    const basePrice = priceInfo.minWasPrice;
    const discount = basePrice - priceInfo.minCurrentPrice;
    if (value !== '0') {
      value = discount.toFixed(2);
    } else {
      value = '0';
    }
    return value;
  }).required(),
  productDiscountStatus: joi.string().custom((value: string) => {
    const priceInfo = services.product.productStyle
      .extractMinMaxPrice(productStyleDetail);
    const expectedValue = priceInfo.minWasPrice && priceInfo.minWasPrice !== Number.MAX_VALUE && priceInfo.minWasPrice !== priceInfo.minCurrentPrice ? 'discounted' : 'full';
    if (value !== expectedValue) {
      throw new Error(`(High priority) Expected value: productDiscountStatus:"${expectedValue}",
    Actual value: productDiscountStatus:"${value}"`);
    }
    return value;
  }).required(),
  productEAN: joi.string().custom((value: string) => {
    if (!value) {
      throw new Error('(High priority) productEAN is not present');
    }
  }).required(),
  productEANOutOfStock: joi.string().optional(),
  productGBPC: joi.string().custom((value: string) => {
    if (productStyleDetail.GBPC === null) {
      joi.string().optional();
    } else if (productStyleDetail.GBPC) {
      joi.string().custom((expectedValue: string) => {
        if (expectedValue !== productStyleDetail.GBPC.toLocaleLowerCase()) {
          throw new Error(`expected value: productGBPC:"${productStyleDetail.GBPC.toLocaleLowerCase()}" 
        Actual value: productGBPC:"${expectedValue}"`);
        }
      }).required();
    }
    return value;
  }),
  productGender: joi.string().min(1).required(),
  productId: joi.string()
    .equal(productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase()).required(),
  productLowPrice: joi.string().custom((value: string) => {
    const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
    const expectedValue = priceInfo.minCurrentPrice.toFixed(2);
    if (value !== expectedValue) {
      throw new Error(`(High priority) Expected value: productLowPrice:"${expectedValue}", 
    Actual value: productLowPrice:"${value}"`);
    }
    return value;
  }).required(),
  productName: joi.string().custom((value: string) => {
    if (value !== productStyleDetail.ANALYTICS_NAME.toLocaleLowerCase().trim()) {
      throw new Error(`(High priority) Expected value: productName:"${productStyleDetail.ANALYTICS_NAME.toLocaleLowerCase().trim()}",
    Actual value: productName:"${value}"`);
    }
    return value;
  }).required(),
  productPrice: joi.string().custom((value: string) => {
    const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
    const expectedValue = priceInfo.minCurrentPrice.toFixed(2);
    if (value !== expectedValue) {
      throw new Error(`expected productPrice is ${expectedValue} but current value is ${value}`);
    }
    return value;
  }).required(),
  productQuantity: joi.string().min(1).required(),
  productSize: joi.string().custom((value: string) => {
    if (!value) {
      throw new Error('(High priority) productSize is not present');
    }
  }).required(),
  productSku: joi.string().custom((value: string) => {
    if (!value) {
      let isRequired = '';
      services.env.Brand === 'ck' ? (isRequired = '(High priority) ') : isRequired = '';
      throw new Error(`${isRequired}Expected productSku is not present`);
    }
  }).required(),
  productStyle:
    joi.string().custom((value: string) => {
      if (!value) {
        let isRequired = '';
        services.env.Brand === 'ck' ? (isRequired = '(High priority) ') : isRequired = '';
        throw new Error(`${isRequired}Expected value: productStyle:"${productStyleDetail.STYLE_PARTNUMBER.toLocaleLowerCase()}",
      Actual value: productStyle:"${value}"`);
      }
      return value;
    }).required(),
  productTax: joi.string().min(1).required(),
  productMerchHierarchy: joi.string().min(1).required(),
  productDivision: joi.string().custom((value: string) => {
    if (value !== productStyleDetail.DIVISION.toLocaleLowerCase()) {
      throw new Error(`(High priority) Expected value: productDivision:"${productStyleDetail.DIVISION.toLocaleLowerCase().trim()}",
    Actual value: productDivision:"${value}"`);
    }
    return value;
  }).required(),
});

export const transactionModuleSchema = async (data: transactionModuleSchema, cartData) => {
  const cartTotal = cartData.total.cartTotal;
  return joi.object({
    transaction: {
      // TODO: find out how to extract order number
      transactionId: joi.string().min(1).required(),
      total: {
        paymentMethod: joi.string().custom((value: string) => {
          if (value !== data.paymentMethod) {
            throw new Error(`(High priority) Expected value: paymentMethod:"${data.paymentMethod}",
          Actual value: paymentMethod:"${value}`);
          }
        }).required(),
        paymentType: joi.string().custom((value: string) => {
          if (value !== data.paymentType) {
            throw new Error(`(High priority) Expected value: paymentType:"${data.paymentType}",
          Actual value: paymentType:"${value}`);
          }
        }).required(),
        recipientZipCode: joi.string().min(1).required(),
        shippingCountry: data.shippingCountry ? joi.string().equal(data.shippingCountry)
          : joi.string().min(1).required(),
        shippingMethod: data.shippingMethod ? (joi.string().custom((value: string) => {
          if (value !== data.shippingMethod) {
            throw new Error(`(High priority) Expected value: shippingMethod:"${data.shippingMethod}",
          Actual value: shippingMethod:"${value}`);
          }
        }).required())
          : joi.string().min(1).required(),
        cartBasePrice: joi.string().custom((value: string) => {
          if (!value) {
            throw new Error('(High priority) cartBasePrice is not present');
          }
        }).required(),
        cartLowPrice: joi.string().custom((value: string) => {
          if (!value) {
            throw new Error('(High priority) cartLowPrice is not present');
          }
        }).required(),
        cartPrice: joi.string().min(1).required(),
        cartQuantity: joi.string().min(1).required(),
        cartRevenue: joi.string().custom((value: string) => {
          if (!value) {
            throw new Error('(High priority) cartRevenue is not present');
          }
        }).required(),
        cartShipping: joi.string().min(1).required(),
        cartShippingOption: joi.string().custom((value: string) => {
          if (value !== data.cartShippingOption) {
            throw new Error(`(High priority) Expected value: cartShippingOption:"${data.cartShippingOption}",
          Actual value: cartShippingOption:"${value}"`);
          }
        }).required(),
        cartTax: joi.string().min(1).required(),
        cartTotal: joi.string().custom((value: string) => {
          if (value !== cartTotal) {
            throw new Error(`expected pageAlias is ${cartTotal} but current value is ${value}`);
          }
          return value;
        }).required(),
        cartValue: joi.string().min(1).required(),
        cartVoucherUsed: joi.string().min(1).required(),
      },
      voucher: {
        totalAppliedOnItems: joi.string().min(1).required(),
        totalAppliedOnOrder: joi.string().custom((value: string) => {
          if (!value) {
            throw new Error('(High priority) totalAppliedOnOrder is not present');
          }
        }).required(),
        voucherName: joi.string().custom((value: string) => {
          if (!value) {
            throw new Error('(High priority) voucherName is not present');
          }
        }).required(),
        voucherTotal: joi.string().min(1).required(),
      },
    },
  });
};

export const giftcardModuleSchema = async (data: giftcardModuleSchema) => joi.object({
  giftcard: {
    giftcardOrderQuantity: joi.string().min(1).required(),
    item: joi.array().min(1).required(),
    total: {
      giftcardOrderId: joi.string().min(1).required(),
      giftcardTotalOrderValue: joi.string().min(1).required(),
      paymentMethod: joi.string().custom((value: string) => {
        if (value !== data.paymentMethod) {
          throw new Error(`(High priority) Expected value: paymentMethod:"${data.paymentMethod}",
          Actual value: paymentMethod:"${value}`);
        }
      }).required(),
      paymentType: joi.string().custom((value: string) => {
        if (value !== data.paymentType) {
          throw new Error(`(High priority) Expected value: paymentType:"${data.paymentType}",
          Actual value: paymentType:"${value}`);
        }
      }).required(),
    },
  },
});


export const variable = (digitalDataKey, digitalDataValue) => joi.object({
  digitalDataKey: joi.string().custom((value: string) => {
    if (digitalDataValue !== value) {
      throw new Error(`Expected value is ${digitalDataValue} but actual value is ${value}`);
    }
  }).required(),
});

export const digitalDataModules = async () => {
  const currentPageType = await getPageType();

  return joi.object({
    digitalData: joi.any().required().error(() => {
      throw new Error(`digital Data is not present on ${currentPageType}`);
    }),
  });
};

export const pageVariablesSchema = async () => {
  const pageTitle = await getPageTitle();
  return joi.object({
    page: {
      pageInfo: {
        pageTitle: joi.string().custom((value: string) => {
          if (value !== pageTitle.toLocaleLowerCase()) {
            throw new Error(`expected pageTitle is ${pageTitle.toLocaleLowerCase()} but current value is ${value}`);
          }
          return value;
        }).required(),
        destinationURL: joi.string().equal((await browser.getUrl()).toLocaleLowerCase()).required(),
      },
    },
  });
};

// SPA schemas
export const versionModuleSchema = () => joi.object({
  version: joi.string().valid('1.0', '2.0', '3.0').required(),
});

export const guestUserModuleSchema = () => joi.object({
  user: {
    profile: {
      profileId: joi.string().min(1).optional(),
      userLoggedIn: joi.string().equal('0').required(),
      userType: joi.string().custom((value: string) => {
        if (!value) {
          let isRequired = '';
          services.env.Brand === 'ck' ? (isRequired = '(High priority) ') : isRequired = '';
          throw new Error(`${isRequired}expected value: userType:"guest" 
          Actual value: userType:"${value}"`);
        }
      }).required(),
      // TO DO: find out how to test gender correctly
      user_behaviour_gender: joi.string().min(1).lowercase().required(),
      userNewsletterSignup: joi.string().min(1).required(),
      userAcceptAnalytics: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userAcceptAnalytics is not present');
        }
      }).required(),
      userAcceptSocial: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userAcceptSocial is not present');
        }
      }).required(),
      userEmailEncrypted: joi.string().allow('').optional().disallow('@'),
      hasWishlist: joi.number().optional(),
    },
    profileInfo: {
      userId: joi.string().optional(),
      contactId: joi.string().min(1).optional(),
      userGender: joi.string().allow('').optional(),
      hasPurchased: joi.string().min(1).optional(),
      hasReturnedOrder: joi.string().min(1).optional(),
      userReturnRate: joi.string().min(1).optional(),
    },
  },
});

export const registeredUserModuleSchema = () => joi.object({
  user: {
    profile: {
      profileId: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) profileId is not present');
        }
      }),
      userLoggedIn: joi.string().equal('1').required(),
      userType: joi.string().custom((value: string) => {
        if (!value) {
          let isRequired = '';
          services.env.Brand === 'ck' ? (isRequired = '(High priority) ') : isRequired = '';
          throw new Error(`${isRequired}Expected value: userType:"registered" 
          Actual value: userType:"${value}"`);
        }
      }).required(),
      // TO DO: find out how to test gender correctly
      user_behaviour_gender: joi.string().min(1).required(),
      userNewsletterSignup: joi.string().equal('0').required(),
      userAcceptAnalytics: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userAcceptAnalytics is not present');
        }
      }).required(),
      userAcceptSocial: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userAcceptSocial is not present');
        }
      }).required(),
      userEmailEncrypted: joi.string().custom((value: string) => {
        if (!value || value.includes('@')) {
          throw new Error('(High priority) userEmailEncrypted is not present');
        }
      }).required(),
      hasWishlist: joi.number().optional(),
    },
    profileInfo: {
      userId: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) userId is not present');
        }
      }),
      contactId: joi.string().custom(async () => {
        const expectedResult = await browser.waitUntilResult(
          async () => {
            const result = (await browser.execute('return window.digitalData.user.profileInfo.contactId;')).toString();
            return result;
          }, '(High priority) contactId is not present', 30000,
        );
        return expectedResult;
      }).required(),
      userGender: joi.string().allow('').optional(),
      hasPurchased: joi.string().min(1).required(),
      hasReturnedOrder: joi.string().min(1).required(),
      userReturnRate: joi.string().min(1).required(),
    },
  },
});

export const pageModuleSchema = async (pageType: string, data: pageModuleSchemaData) => {
  const currentUrl = (await browser.getUrl()).toLocaleLowerCase();
  if (currentUrl.includes('performance')) {
    pageType = 'glp performance';
  }
  const pagePath = pageType === 'glp' || pageType === 'plp' || pageType === 'pdp' || pageType === 'return center' || pageType === 'customerservice' ? await getPagePath() : data.pagePath;
  const pageName = pageType === 'glp' || pageType === 'plp' || pageType === 'pdp' ? await getPageName(pageType) : data.pageName;
  const pageGender = pageType === 'glp' || pageType === 'plp' || pageType === 'pdp' ? await getPageGender() : data.pageGender;
  const pageTitle = await getPageTitle();
  const pageAlias = pageType === 'pdp' || pageType === 'plp' || pageType === 'search results page' ? await getPageAlias() : data.pageAlias;
  const hasBreadCrumb = !!(pageType === 'glp' || pageType === 'plp' || pageType === 'pdp');
  const primaryCategory = pageType === 'glp' || pageType === 'plp' || pageType === 'pdp' ? await getPrimaryCategory() : data.primaryCategory;
  const primaryCategoryId = pageType === 'glp' || pageType === 'plp' || pageType === 'pdp' ? await getPrimaryCategoryId() : data.primaryCategoryId;
  const subCategory1 = pageType === 'plp' || pageType === 'pdp' ? await getSubCategory1() : data.subCategory1;
  const subCategory1Id = pageType === 'plp' || pageType === 'pdp' ? await getSubCategory1Id() : data.subCategory1Id;
  const subCategory2 = pageType === 'plp' || pageType === 'pdp' ? await getSubCategory2() : data.subCategory2;
  const subCategory2Id = pageType === 'plp' || pageType === 'pdp' ? await getSubCategory2Id() : data.subCategory2Id;
  const subCategory3 = pageType === 'plp' || pageType === 'pdp' ? await getSubCategory3() : data.subCategory3;
  const subCategory3Id = pageType === 'plp' || pageType === 'pdp' ? await getSubCategory3Id() : data.subCategory3Id;
  const subCategory4 = pageType === 'plp' || pageType === 'pdp' ? await getSubCategory4() : data.subCategory4;
  const subCategory4Id = pageType === 'plp' || pageType === 'pdp' ? await getSubCategory4Id() : data.subCategory4Id;
  const productStructureGroupId = pageType === 'glp' || pageType === 'plp' || pageType === 'pdp' ? await getProductStructureGroupId() : data.productStructureGroupId;
  const onsiteHeaderSearchTerm = pageType === 'search results page' ? await getOnsiteHeaderSearchTerm() : data.onsiteHeaderSearchTerm;
  const onsiteSearchTerm = pageType === 'search results page' ? await getOnsiteSearchTerm() : data.onsiteSearchTerm;

  return joi.object({
    page: {
      pageInfo: {
        // TODO: create page related validation for pageFhSourceId when EESK-2590 is done
        pageFhSourceId: joi.string().optional(),
        pagePath: joi.string().custom((value: string) => {
          if (value !== pagePath.toLocaleLowerCase()) {
            throw new Error(`expected pagePath is ${pagePath.toLocaleLowerCase()} but current value is ${value}`);
          }
          return value;
        }).required(),
        pageTitle: joi.string().custom((value: string) => {
          if (value !== pageTitle.toLocaleLowerCase()) {
            throw new Error(`expected pageTitle is ${pageTitle.toLocaleLowerCase()} but current value is ${value}`);
          }
          return value;
        }).required(),
        pageName: joi.string().custom((value: string) => {
          if (value !== pageName.toLocaleLowerCase()) {
            throw new Error(`(High priority) Expected value: pageName:"${pageName.toLocaleLowerCase()}",
            Actual value: pageName:"${value}"`);
          }
          return value;
        }).required(),
        pageAlias: joi.string().custom((value: string) => {
          if (value !== pageAlias.toLocaleLowerCase()) {
            throw new Error(`expected pageAlias is ${pageAlias.toLocaleLowerCase()} but current value is ${value}`);
          }
          return value;
        }).required(),
        pageGender: pageGender
          ? joi.string().custom((value: string) => {
            if (value !== pageGender.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: pageGender:"${pageGender.toLocaleLowerCase()}",
              Actual value: pageGender:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().lowercase().optional(),
        // TODO: remove once all pages are unified
        pageId: data.pageId ? joi.string().equal(data.pageId).optional() : joi.string().optional(),
        breadcrumb: hasBreadCrumb ? joi.array().items(joi.string().lowercase()).min(1).required()
          : joi.array().items(joi.string().lowercase()).optional(),
        destinationURL: joi.string().lowercase().required(),
        previousPageType: pageType === 'homepage' ? joi.string().lowercase().optional() : joi.string().custom((value: string) => {
          if (!value) {
            throw new Error('(High priority) Value is not present');
          }
        }),
        referringURL: (pageType === 'homepage' || pageType === 'cart empty') ? joi.string().lowercase().optional()
          : (joi.string().custom(async () => {
            const expectedResult = await browser.waitUntilResult(
              async () => {
                const result = (await browser.execute('return window.digitalData.page.pageInfo.referringURL;')).toString();
                return result;
              }, 'referringURL is not present', 20000,
            );
            return expectedResult;
          }).required()),
        wishListResultId: (services.env.Brand === 'ck' && pageType === 'wishlistpage') ? joi.string().required() : joi.string().forbidden(),
      },
      category: {
        pageType: (pageType === 'glp performance' || pageType === 'cart empty')
          ? joi.string().equal((pageType.split(' ')[0]).toLocaleLowerCase()).required()
          : joi.string().equal(pageType.toLocaleLowerCase()).required(),
        primaryCategory: primaryCategory
          ? joi.string().custom((value: string) => {
            if (value !== primaryCategory.toLocaleLowerCase()) {
              throw new Error(`Expected value: primaryCategory:"${primaryCategory.toLocaleLowerCase()}",
              Actual value: primaryCategory:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        primaryCategoryId: primaryCategoryId
          ? joi.string().custom((value: string) => {
            if (value !== primaryCategoryId.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: primaryCategoryId:"${primaryCategoryId.toLocaleLowerCase()}"
              Actual value: primaryCategoryId:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        productStructureGroupId: productStructureGroupId
          ? joi.string().custom((value: string) => {
            if (value !== productStructureGroupId.toLocaleLowerCase()) {
              throw new Error(`Expected value: productStructureGroupId:"${productStructureGroupId.toLocaleLowerCase()}",
              Actual value: productStructureGroupId"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory1: subCategory1
          ? joi.string().custom((value: string) => {
            if (value !== subCategory1.toLocaleLowerCase()) {
              throw new Error(`Expected subCategory1:"${subCategory1.toLocaleLowerCase()}", 
              Actual value: subCategory1:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory1Id: subCategory1Id
          ? joi.string().custom((value: string) => {
            if (value !== subCategory1Id.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: subCategory1Id:"${subCategory1Id.toLocaleLowerCase()}",
              Actual value: subCategory1Id:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory2: subCategory2
          ? joi.string().custom((value: string) => {
            if (value !== subCategory2.toLocaleLowerCase()) {
              throw new Error(`Expected value: subCategory2:"${subCategory2.toLocaleLowerCase()}",
              Actual value: subCategory2:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory2Id: subCategory2Id
          ? joi.string().custom((value: string) => {
            if (value !== subCategory2Id.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: subCategory2Id:"${subCategory2Id.toLocaleLowerCase()}",
              Actual value: subCategory2Id:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory3: subCategory3
          ? joi.string().custom((value: string) => {
            if (value !== subCategory3.toLocaleLowerCase()) {
              throw new Error(`Expected value: subCategory3:"${subCategory3.toLocaleLowerCase()}",
              Actual value: subCategory3:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory3Id: subCategory3Id
          ? joi.string().custom((value: string) => {
            if (value !== subCategory3Id.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: subCategory3Id:"${subCategory3Id.toLocaleLowerCase()}",
              Actual value: subCategory3Id:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory4: subCategory4
          ? joi.string().custom((value: string) => {
            if (value !== subCategory4.toLocaleLowerCase()) {
              throw new Error(`Expected value: subCategory4:"${subCategory4.toLocaleLowerCase()}",
              Actual value: subCategory4:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
        subCategory4Id: subCategory4Id
          ? joi.string().custom((value: string) => {
            if (value !== subCategory4Id.toLocaleLowerCase()) {
              throw new Error(`(High priority) Expected value: subCategory4Id:"${subCategory4Id.toLocaleLowerCase()}",
              Actual value: subCategory4Id:"${value}"`);
            }
            return value;
          }).required()
          : joi.string().allow('').lowercase().optional(),
      },
      attributes: {
        pageError: joi.string().valid('0', '1').required(),
      },
      search: {
        onsiteHeaderSearchTerm: onsiteHeaderSearchTerm
          ? joi.string().equal(onsiteHeaderSearchTerm).optional()
          : joi.string().optional(),
        onsiteSearchResults: pageType === 'search results page' ? joi.string().min(1).required() : joi.string().min(1).optional(),
        onsiteSearchTerm: pageType === 'search results page'
          ? joi.string().equal(onsiteSearchTerm).required()
          : joi.string().lowercase().optional(),
        onsiteSearchType: joi.string().equal('search').optional(),
      },
    },
  });
};

export const wishlistModuleSchema = (productStyleDetail: ProductStyleDetail) => joi.object({
  wishlist: {
    size: joi.string().equal('1').required(),
    wishlistId: joi.string().min(1).required(),
    item: joi.array().items(joi.object({
      productBrand: joi.string().custom((value: string) => {
        if (!value) {
          throw new Error('(High priority) productBrand is not present');
        }
      }).required(),
      productStyle: services.env.Brand === 'ck' ? (joi.string().custom((value: string) => {
        if (value !== productStyleDetail.STYLE_PARTNUMBER.toLocaleLowerCase()) {
          throw new Error(`(High priority) Expected value:
      productStyle:"${productStyleDetail.STYLE_PARTNUMBER.toLocaleLowerCase().trim()}",
          Actual value: productStyle:"${value}"`);
        }
        return value;
      }).required()) : joi.string().optional(),
      productDivision: services.env.Brand === 'ck' ? (joi.string().custom((value: string) => {
        if (value !== productStyleDetail.DIVISION.toLocaleLowerCase()) {
          throw new Error(`(High priority) Expected value:
      productDivision:"${productStyleDetail.DIVISION.toLocaleLowerCase().trim()}",
        Actual value: productDivision:"${value}"`);
        }
        return value;
      }).required()) : joi.string().optional(),
      productCombi: joi.string().custom((value: string) => {
        if (value !== productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase()) {
          throw new Error(`(High priority) Expected value: productCombi:"${productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase().trim()}",
          Actual value: productCombi:"${value}"`);
        }
        return value;
      }).required(),
      // TODO: check with CND if uppercase is required
      productCombiUppercase: joi.string().custom((value: string) => {
        if (value !== productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleUpperCase()) {
          throw new Error(`(High priority) Expected value: productCombiUppercase:"${productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleUpperCase().trim()}",
          Actual value: productCombiUppercase:"${value}"`);
        }
        return value;
      }).optional(),
      productLowPrice: joi.string().custom((value: string) => {
        const priceInfo = services.product.productStyle
          .extractMinMaxPrice(productStyleDetail);
        const expectedValue = priceInfo.minCurrentPrice.toFixed(2);
        if (value !== expectedValue) {
          throw new Error(`(High priority) Expected value: productLowPrice:"${expectedValue}",
          Actual value: productLowPrice:"${value}"`);
        }
        return value;
      }).required(),
      productName: joi.string().custom((value: string) => {
        if (value !== productStyleDetail.ANALYTICS_NAME.toLocaleLowerCase().trim()) {
          throw new Error(`(High priority) Expected value: productName:"${productStyleDetail.ANALYTICS_NAME.toLocaleLowerCase().trim()}",
          Actual value: productName:"${value}"`);
        }
        return value;
      }).required(),
      productColour: joi.string().custom((value: string) => {
        if (value !== productStyleDetail.ANALYTICS_MAIN_COLOUR.toLocaleLowerCase()) {
          throw new Error(`(High priority) Expected value: productColour:"${productStyleDetail.ANALYTICS_NAME.toLocaleLowerCase().trim()}",
          Actual value: productColour:"${value}"`);
        }
      }).required(),
      productBasePrice: joi.string().custom((value: string) => {
        const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
        const expectedValue = priceInfo.minWasPrice
          && priceInfo.minWasPrice !== Number.MAX_VALUE
          && priceInfo.minWasPrice !== priceInfo.minCurrentPrice
          ? priceInfo.minWasPrice
          : priceInfo.minCurrentPrice;
        if (value !== expectedValue.toFixed(2)) {
          throw new Error(`(High priority) Expected value: productBasePrice:"${expectedValue}",
          Actual value: productBasePrice:"${value}"`);
        }
        return value;
      }).required(),
      productCategory: joi.string().custom((value: string) => {
        if (services.env.Brand === 'ck') {
          joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).optional();
        } else {
          joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).required();
        }
        return value;
      }),
      productCategoryAlias: joi.string().custom((value: string) => {
        if (services.env.Brand === 'ck') {
          joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).optional();
        } else {
          joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).required();
        }
        return value;
      }),
      productDiscountStatus: joi.string().custom((value: string) => {
        const priceInfo = services.product.productStyle
          .extractMinMaxPrice(productStyleDetail);
        const expectedValue = priceInfo.minWasPrice && priceInfo.minWasPrice !== Number.MAX_VALUE && priceInfo.minWasPrice !== priceInfo.minCurrentPrice ? 'discounted' : 'full';
        if (value !== expectedValue) {
          let isRequired = '';
          services.env.Brand === 'ck' ? (isRequired = '(High priority) ') : isRequired = '';
          throw new Error(`${isRequired}Expected value: productDiscountStatus:"${expectedValue}",
          Actual value: productDiscountStatus:"${value}"`);
        }
        return value;
      }).required(),
      productGender: joi.string().min(1).lowercase().required(),
      productPrice: joi.string().custom((value: string) => {
        const priceInfo = services.product.productStyle
          .extractMinMaxPrice(productStyleDetail);
        const expectedValue = priceInfo.minCurrentPrice.toFixed(2);
        if (value !== expectedValue) {
          throw new Error(`expected productPrice is ${expectedValue} but current value is ${value}`);
        }
        return value;
      }).required(),
      stock: {
        productInFullStock: joi.string().custom(async (value: string) => {
          const stylePartNumber = productStyleDetail.STYLE_PARTNUMBER;
          const detail = await services.product.product.getDetail(stylePartNumber);
          const productInfo = services.product.product
            .extractOutOfStockProductItems(detail);
          const expectedValue = productInfo.length > 0 ? '0' : '1';
          if (value !== expectedValue) {
            throw new Error(`(High priority) Expected value: productInFullStock:"${expectedValue}",
            Actual value: productInFullStock:"${value}"`);
          }
          return value;
        }).required(),
        productOutOfStockSizes: joi.string().custom((value: string) => {
          const outOfStockItems = services.product.productStyle
            .extractProductItemListWithInventory(productStyleDetail, 0, 0);
          if (outOfStockItems && outOfStockItems.length > 0) {
            const actualValue = value.split(',').map((v) => v.trim()).sort().join(',');
            let expectedValue = '';
            if (outOfStockItems[0].SIZE_NAME) {
              expectedValue = outOfStockItems.map((p) => p.SIZE_NAME.toLocaleLowerCase()).sort().join(',');
            } else if (outOfStockItems[0].WIDTH_NAME && !outOfStockItems[0].LENGTH_NAME) {
              expectedValue = outOfStockItems.map((p) => p.WIDTH_NAME.toLocaleLowerCase()).sort().join(',');
            } else if (outOfStockItems[0].WIDTH_NAME && outOfStockItems[0].LENGTH_NAME) {
              expectedValue = outOfStockItems.map((p) => `${p.WIDTH_NAME.toLocaleLowerCase()}-${p.LENGTH_NAME.toLocaleLowerCase()}`).sort().join(',');
            } else {
              throw new Error(`(High priority) cannot identify the sizes for product style: ${productStyleDetail}`);
            }
            if (expectedValue !== actualValue) {
              throw new Error(`(High priority) Expected value: productOutOfStockSizes:"${expectedValue}", 
              Actual value productOutOfStockSizes"${actualValue}"`);
            }
          } else if (value && value !== '') {
            throw new Error(`(High priority) Expected empty productOutOfStockSizes but current value is "${value}"`);
          }
          return value;
        }, 'product out of stock validator'),
      },
    })),
  },
});

export const plpProductModuleSchema = (productStyleDetail: ProductStyleDetail,
  index) => joi.object({
  productInfo: {
    ranking: services.env.Brand === 'th' ? joi.string().equal('0', '1').required() : joi.string().forbidden(),
    productName: joi.string().custom((value: string) => {
      if (value !== productStyleDetail.ANALYTICS_NAME.toLocaleLowerCase().trim()) {
        throw new Error(`(High priority) Expected value: productName:"${productStyleDetail.ANALYTICS_NAME.toLocaleLowerCase().trim()}",
        Actual value: productName:"${value}"`);
      }
      return value;
    }).required(),
    productId: joi.string()
      .equal(productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase()).required(),
    productStyle: joi.string().custom((value: string) => {
      if (value !== productStyleDetail.STYLE_PARTNUMBER.toLocaleLowerCase()) {
        throw new Error(`(High priority) Expected value: productStyle:"${productStyleDetail.STYLE_PARTNUMBER.toLocaleLowerCase()}",
        Actual value: productStyle:"${value}"`);
      }
    }).required(),
    productCategory: joi.string().custom(async (value: string) => {
      if (services.env.Brand === 'ck') {
        const productGBPC = await browser.execute('return window.__NEXT_DATA__.props.initialState.productList.data[0].productGbpc').toString().toLocaleLowerCase();
        if (value !== productGBPC) {
          throw new Error(`(High priority) Expected value: productCategory:"productCategory${productGBPC},
          Actual value: productCategory:"${value}"`);
        }
      } else {
        joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).required();
      }
      return value;
    }),
    productCategoryAlias: joi.string().custom(async (value: string) => {
      if (services.env.Brand === 'ck') {
        const productGBPC = await browser.execute('return window.__NEXT_DATA__.props.initialState.productList.data[0].productGbpc').toString().toLocaleLowerCase();
        if (value !== productGBPC) {
          throw new Error(`Expected value: productCategory:"${productGBPC}",
          Actual value: productCategoryAlias:"${value}"`);
        }
      } else {
        joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).required();
      }
      return value;
    }),
    productCombi: joi.string().custom((value: string) => {
      if (value !== productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase()) {
        throw new Error(`(High priority) Expected value: productCombi:"${productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase().trim()}",
        Actual value: productCombi:"${value}"`);
      }
      return value;
    }).required(),
    // TODO: check with CND to see if uppercases are required
    productCombiUppercase: joi.string().custom((value: string) => {
      if (value !== productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleUpperCase()) {
        throw new Error(`(High priority) Expected value: productCombiUppercase:"${productStyleDetail.STYLECOLOUR_PARTNUMBER.toUpperCase().trim()}",
        Actual value: productCombiUppercase:"${value}"`);
      }
      return value;
    }).optional(),
    productColour: joi.string().custom((value: string) => {
      if (value !== productStyleDetail.ANALYTICS_MAIN_COLOUR.toLocaleLowerCase()) {
        throw new Error(`(High priority) Expected value: productColour:"${productStyleDetail.ANALYTICS_MAIN_COLOUR.toLocaleLowerCase().trim()}",
        Actual value: productColour:"${value}"`);
      }
    }).required(),
    productGender: joi.string().min(1).lowercase().required(),
    // TBD if productBrand should be available on Unified PLP
    productBrand: joi.string().custom((value: string) => {
      if (!value) {
        throw new Error('(High priority) productBrand is not present');
      }
    }).optional(),
    productDivision: joi.string().custom((value: string) => {
      if (value !== productStyleDetail.DIVISION.toLocaleLowerCase()) {
        throw new Error(`(High priority) Expected value: productDivision:"${productStyleDetail.DIVISION.toLocaleLowerCase().trim()}",
        Actual value: productDivision:"${value}"`);
      }
      return value;
    }).required(),
    productBasePrice: joi.string().custom((value: string) => {
      const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
      const expectedValue = priceInfo.minWasPrice
        && priceInfo.minWasPrice !== Number.MAX_VALUE
        && priceInfo.minWasPrice !== priceInfo.minCurrentPrice
        ? priceInfo.minWasPrice
        : priceInfo.minCurrentPrice;
      if (value !== expectedValue.toFixed(2)) {
        throw new Error(`(High priority) Expected value: productBasePrice:"${expectedValue}",
      Actual value: productBasePrice:"${value}"`);
      }
      return value;
    }).required(),
    productLowPrice: joi.string().custom((value: string) => {
      const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
      const expectedValue = priceInfo.minCurrentPrice.toFixed(2);
      if (value !== expectedValue) {
        throw new Error(`(High priority) Expected value: productLowPrice:"${expectedValue}", 
      Actual value: productLowPrice:"${value}"`);
      }
      return value;
    }).required(),
    productPrice: joi.string().custom((value: string) => {
      const priceInfo = services.product.productStyle
        .extractMinMaxPrice(productStyleDetail);
      const expectedValue = priceInfo.minCurrentPrice.toFixed(2);
      if (value !== expectedValue) {
        throw new Error(`expected productPrice is ${expectedValue} but current value is ${value}`);
      }
      return value;
    }).required(),
    productDiscount: joi.string().custom((value: string) => {
      const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
      const basePrice = priceInfo.minWasPrice;
      const discount = basePrice - priceInfo.minCurrentPrice;
      if (value !== '0') {
        value = discount.toFixed(2);
      } else {
        value = '0';
      }
      return value;
    }).required(),
    productDiscountStatus: joi.string().custom((value: string) => {
      const priceInfo = services.product.productStyle
        .extractMinMaxPrice(productStyleDetail);
      const expectedValue = priceInfo.minWasPrice && priceInfo.minWasPrice !== Number.MAX_VALUE && priceInfo.minWasPrice !== priceInfo.minCurrentPrice ? 'discounted' : 'full';
      if (value !== expectedValue) {
        let isRequired = '';
        services.env.Brand === 'th' ? (isRequired = '(High priority) ') : isRequired = '';
        throw new Error(`${isRequired}Expected value: productDiscountStatus:"${expectedValue}",
        Actual value: productDiscountStatus:"${value}"`);
      }
      return value;
    }).required(),
    productPosition: joi.string().custom((value: string) => {
      if (value !== index.toString()) {
        throw new Error(`High priority - Expected value: productPosition:"${index}", 
      Actual value: productPosition:"${value}"`);
      }
    }).required(),
    productMerchHierarchy: joi.string().optional(),
    productList: joi.string().optional(),
  },
});

export const pdpProductModuleSchema = async (productStyleDetail: ProductStyleDetail) => {
  let getProductAvailabilityPercentage = '';
  const allSizes = await services.product.productStyle
    .extractProductItems(productStyleDetail).length;
  const inStockSizes = (allSizes - (services.product.productStyle
    .extractProductItemListWithInventory(productStyleDetail, 0, 0).length));
  getProductAvailabilityPercentage = ((inStockSizes / allSizes) * 100).toFixed(2).toString();

  return joi.object({
    product: joi.array().items(joi.object({
      productInfo: {
        ranking: services.env.Brand === 'th' ? joi.string().equal('0', '1').required() : joi.string().forbidden(),
        productName: joi.string().custom((value: string) => {
          if (value !== productStyleDetail.ANALYTICS_NAME.toLocaleLowerCase().trim()) {
            throw new Error(`(High priority) Expected value: productName:"${productStyleDetail.ANALYTICS_NAME.toLocaleLowerCase().trim()}", 
            Actual value: productName:"${value}"`);
          }
          return value;
        }).required(),
        productId: joi.string()
          .equal(productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase()).required(),
        productSku: joi.string().custom((value: string) => {
          const item = services.product.productStyle.extractFirstProductItem(productStyleDetail);
          GetTestLogger().info(`Extract ${item.SKU_PARTNUMBER} from style ${item.STYLECOLOUR_PARTNUMBER}`);
          const expectedValue = item.SKU_PARTNUMBER;
          if (value !== expectedValue) {
            throw new Error(`expected productSku is ${expectedValue} but current value is ${value}`);
          }
          return value;
        }).optional(),
        productStyle: joi.string().custom((value: string) => {
          if (value !== productStyleDetail.STYLE_PARTNUMBER.toLocaleLowerCase()) {
            throw new Error(`(High priority) Expected value: productStyle:"${productStyleDetail.STYLE_PARTNUMBER.toLocaleLowerCase()}",
            Actual value: productStyle:"${value}"`);
          }
        }).required(),
        productEAN: joi.string().custom((value: string) => {
          const item = services.product.productStyle.extractFirstProductItem(productStyleDetail);
          GetTestLogger().info(`Extract ${item.SKU_PARTNUMBER} from style ${item.STYLECOLOUR_PARTNUMBER}`);
          const expectedValue = item.SKU_PARTNUMBER;
          if (value !== expectedValue) {
            throw new Error(`expected productEAN is ${expectedValue} but current value is ${value}`);
          }
          return value;
        }).optional(),
        productCombi: joi.string().custom((value: string) => {
          if (value !== productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase()) {
            throw new Error(`(High priority) Expected value: productCombi:"${productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleLowerCase().trim()}",
            Actual value: productCombi:"${value}"`);
          }
          return value;
        }).required(),
        // TODO: check with CND to see if uppercases are required
        productCombiUppercase: joi.string().custom((value: string) => {
          if (value !== productStyleDetail.STYLECOLOUR_PARTNUMBER.toLocaleUpperCase()) {
            throw new Error(`(High priority) Expected value: productCombiUppercase:"${productStyleDetail.STYLECOLOUR_PARTNUMBER.toUpperCase().trim()}",
            Actual value: productCombiUppercase:"${value}"`);
          }
          return value;
        }).optional(),
        productColour: joi.string().custom((value: string) => {
          if (value !== productStyleDetail.ANALYTICS_MAIN_COLOUR.toLocaleLowerCase()) {
            throw new Error(`(High priority) Expected value: productColour:"${productStyleDetail.ANALYTICS_MAIN_COLOUR.toLocaleLowerCase().trim()}",
            Actual value: productColour:"${value}"`);
          }
        }).required(),
        productCategory: joi.string().custom(async (value: string) => {
          if (services.env.Brand === 'ck') {
            const productGBPC = await browser.execute('return window.__NEXT_DATA__.props.initialState.productPage.data.productGbpc').toString().toLocaleLowerCase();
            if (value !== productGBPC) {
              throw new Error(`(High priority) Expected value: productCategory:"${productGBPC}",
              Actual value: productCategory:"${value}"`);
            }
          } else {
            joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).required();
          }
          return value;
        }),
        productCategoryAlias: joi.string().custom(async (value: string) => {
          if (services.env.Brand === 'ck') {
            const productGBPC = await browser.execute('return window.__NEXT_DATA__.props.initialState.productPage.data.productGbpc').toString().toLocaleLowerCase();
            if (value !== productGBPC) {
              throw new Error(`expected productCategory is ${productGBPC} but current value is ${value}`);
            }
          } else {
            joi.string().equal(productStyleDetail.GBPC.toLocaleLowerCase()).required();
          }
          return value;
        }),
        productBrand: joi.string().custom((value: string) => {
          if (!value) {
            throw new Error('(High priority) productBrand is not present');
          }
        }).required(),
        productMerchHierarchy: joi.string().min(1).required(),
        productDivision: joi.string().custom((value: string) => {
          if (value !== productStyleDetail.DIVISION.toLocaleLowerCase()) {
            throw new Error(`(High priority) Expected value: productDivision:"${productStyleDetail.DIVISION.toLocaleLowerCase().trim()}",
            Actual value: productDivision:"${value}"`);
          }
          return value;
        }).required(),
        productGender: joi.string().min(1).lowercase().required(),
        productBasePrice: joi.string().custom((value: string) => {
          const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
          const expectedValue = priceInfo.minWasPrice
            && priceInfo.minWasPrice !== Number.MAX_VALUE
            && priceInfo.minWasPrice !== priceInfo.minCurrentPrice
            ? priceInfo.minWasPrice
            : priceInfo.minCurrentPrice;
          if (value !== expectedValue.toFixed(2)) {
            throw new Error(`(High priority) Expected value: productBasePrice:"${expectedValue}",
          Actual value: productBasePrice:"${value}"`);
          }
          return value;
        }).required(),
        productLowPrice: joi.string().custom((value: string) => {
          const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
          const expectedValue = priceInfo.minCurrentPrice.toFixed(2);
          if (value !== expectedValue) {
            throw new Error(`(High priority) Expected value: productLowPrice:"${expectedValue}", 
          Actual value: productLowPrice:"${value}"`);
          }
          return value;
        }).required(),
        productPrice: joi.string().custom((value: string) => {
          const expectedValue = services.product.productStyle
            .extractMinMaxPrice(productStyleDetail);
          if (value !== expectedValue.minCurrentPrice.toFixed(2)) {
            throw new Error(`expected productPrice is ${expectedValue} but current value is ${value}`);
          }
          return value;
        }).required(),
        productDiscount: joi.string().custom((value: string) => {
          const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
          const basePrice = priceInfo.minWasPrice;
          const discount = basePrice - priceInfo.minCurrentPrice;
          if (value !== '0') {
            value = discount.toFixed(2);
          } else {
            value = '0';
          }
          return value;
        }).required(),
        productDiscountStatus: joi.string().custom((value: string) => {
          const expectedValue = services.product.productStyle
            .extractMinMaxPrice(productStyleDetail);
          if (value !== (expectedValue.minWasPrice && expectedValue.minWasPrice !== Number.MAX_VALUE && expectedValue.minWasPrice !== expectedValue.minCurrentPrice ? 'discounted' : 'full')) {
            let isRequired = '';
            services.env.Brand === 'th' ? (isRequired = '(High priority) ') : isRequired = '';
            throw new Error(`${isRequired}Expected value: productDiscountStatus:"${expectedValue}",
            Actual value: productDiscountStatus:"${value}"`);
          }
          return value;
        }).required(),
        productEANOutOfStock: joi.string().min(1).optional(),
      },
      stock: {
        productAvailabilityPercentage: joi.string().custom(async (value: string) => {
          if (value !== getProductAvailabilityPercentage) {
            throw new Error(`expected productAvailabilityPercentage is ${getProductAvailabilityPercentage} but current value is ${value}`);
          }
        }).required(),
        productInFullStock: joi.string().custom(async (value: string) => {
          const stylePartNumber = productStyleDetail.STYLE_PARTNUMBER;
          const detail = await services.product.product.getDetail(stylePartNumber);
          const expectedValue = services.product.product
            .extractOutOfStockProductItems(detail);
          if (value !== (expectedValue.length > 0 ? '0' : '1')) {
            throw new Error(`(High priority) Expected value: productInFullStock:"${expectedValue}",
            Actual value: productInFullStock:"${value}"`);
          }
          return value;
        }).required(),
        productOutOfStockSizes: joi.string().custom((value: string) => {
          const outOfStockItems = services.product.productStyle
            .extractProductItemListWithInventory(productStyleDetail, 0, 0);
          if (outOfStockItems && outOfStockItems.length > 0) {
            const actualValue = value.split(',').map((v) => v.trim()).sort().join(',');
            let expectedValue = '';
            if (outOfStockItems[0].SIZE_NAME) {
              if (outOfStockItems[0].SIZE_NAME.toLowerCase() === 'one size' || outOfStockItems[0].SIZE_NAME.toLowerCase() === 'os') {
                expectedValue = 'one_size';
              } else {
                expectedValue = outOfStockItems.map((p) => p.SIZE_NAME.toLocaleLowerCase()).sort().join(',');
              }
            } else if (outOfStockItems[0].WIDTH_NAME && !outOfStockItems[0].LENGTH_NAME) {
              expectedValue = outOfStockItems.map((p) => p.WIDTH_NAME.toLocaleLowerCase()).sort().join(',');
            } else if (outOfStockItems[0].WIDTH_NAME && outOfStockItems[0].LENGTH_NAME) {
              expectedValue = outOfStockItems.map((p) => `${p.WIDTH_NAME.toLocaleLowerCase()}-${p.LENGTH_NAME.toLocaleLowerCase()}`).sort().join(',');
              if (expectedValue.includes('eu')) {
                expectedValue = expectedValue.replace('eu', '');
              }
            } else {
              throw new Error(`cannot identify the sizes for product style: ${productStyleDetail}`);
            }
            if (expectedValue !== actualValue) {
              let isRequired = '';
              services.env.Brand === 'th' ? (isRequired = '(High priority) ') : isRequired = '';
              throw new Error(`${isRequired}Expected value: productOutOfStockSizes:"${expectedValue}",
              Actual value: productOutOfStockSizes:"${actualValue}"`);
            }
          } else if (value && value !== '') {
            throw new Error(`Expected empty productOutOfStockSizes but actual value: productOutOfStockSizes:"${value}"`);
          }
          return value;
        }, 'product out of stock validator'),
      },
    })).length(1),
  });
};
