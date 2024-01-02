/* eslint-disable no-lonely-if */
/* eslint-disable max-len */
import { Then, When } from '@pvhqa/cucumber';
import { expect } from 'chai';
import services from '../../../core/services';
import * as PaymentLimits from '../../helper/payment-limit.helper';
import { ProductListAttribute } from '../../../core/db/product-model';
import Checkout from '../../pages/checkout';
import { getExpressShippingCosts, getStandardShippingCosts } from '../../helper/shipping-costs.helper';
import { exist$ } from '../../general';
import { XCOMREG } from '../../../core/constents';
import { sleep } from '../../helper/utils.helper';

When(/I get (standard|express) shipping costs for current locale and store it with key (#[^\s]+)/, async (shippingType: string, keyToStore: string) => {
  let shippingCosts;

  if (shippingType === 'standard') {
    shippingCosts = getStandardShippingCosts(services.site.locale);
  } else if (shippingType === 'express') {
    shippingCosts = getExpressShippingCosts(services.site.locale);
  }

  services.world.store(keyToStore, shippingCosts);
});

When(/I get (credit card|paypal|klarna|klarnaInst|minklarna|dotpay|ratepay|minratepay|ideal) payment limit for current locale and store it with key (#[^\s]+)/, async (paymentMethod: string, keyToStore: string) => {
  let paymentLimit;

  if (paymentMethod === 'credit card') {
    paymentLimit = PaymentLimits.getCreditCardPaymentLimit(services.site.locale);
  } else if (paymentMethod === 'paypal') {
    paymentLimit = PaymentLimits.getPaypalPaymentLimit(services.site.locale);
  } else if (paymentMethod === 'klarna') {
    paymentLimit = PaymentLimits.getKlarnaPaymentLimit(services.site.locale);
  } else if (paymentMethod === 'klarnaInst') {
    paymentLimit = PaymentLimits.getKlarnaInstalmentsLimit(services.site.locale);
  } else if (paymentMethod === 'minklarna') {
    paymentLimit = PaymentLimits.getKlarnaMinimumLimit(services.site.locale);
  } else if (paymentMethod === 'dotpay') {
    paymentLimit = PaymentLimits.getDotpayLimit();
  } else if (paymentMethod === 'ratepay') {
    paymentLimit = PaymentLimits.getRatepayLimit(services.site.locale);
  } else if (paymentMethod === 'ideal') {
    paymentLimit = PaymentLimits.getiDealLimit();
  } else if (paymentMethod === 'minratepay') {
    paymentLimit = PaymentLimits.getRatepayMinimumLimit(services.site.locale);
  }

  services.world.store(keyToStore, paymentLimit);
});

// Unified checkout steps
When(/I get (mandatory|invalid) fields number for current locale as (guest|logged in) and store it with key (#[^\s]+)/, async (errorType: string, userType: string, keyToStore: string) => {
  const errorCount = services.checkoutaddress
    .getCountryErrorCount(services.site.locale, errorType, userType);
  services.world.store(keyToStore, errorCount);
});

When(/as a (guest|sap_guest|sap_user logged in|logged in) I add (first|other) (delivery|personal) details?( and cancel)?$/, async (userType: string, deliveryType: string, addressType: string, isCanceled: boolean) => {
  const loadedPageType = await browser.waitUntilResult(async () => {
    const result = await browser.execute('return digitalData.page.category.pageType');
    return result;
  }, 'The pageType does not exist', 10000, 1000);

  if ((userType === 'guest' || userType === 'sap_guest') && loadedPageType === 'checkout - address shipment' && deliveryType === 'first') {
    const addressAutocomplete = await services.othersDB.GetXComReg(XCOMREG.ToggleAddressAutocomplete);

    if (addressAutocomplete.toLowerCase() === 'true') {
      const addAddressManually = await exist$('Checkout.ShippingPage.AddAddressManually', 10000);
      const isDisplayed = await addAddressManually.waitForClickable({
        timeout: 12000,
        interval: 500,
      }).catch(() => false);

      if (isDisplayed) {
        await addAddressManually.safeClick();
        await sleep(1000);
        await addAddressManually.safeClick();
      } else {
        throw new Error(`Add address manually is not displayed. ENABLE_ADDRESS_AUTOCOMPLETE toggle is ${addressAutocomplete}`);
      }
    }
  }

  if (addressType === 'delivery') {
    if (deliveryType === 'first') {
      await Checkout.Shipping.FirstDeliveryAddress(userType);
    } else if (isCanceled) {
      await Checkout.Shipping.NewDeliveryAddress('add', true);
    } else {
      await Checkout.Shipping.NewDeliveryAddress('add', false);
    }
  } else if (addressType === 'personal') {
    await Checkout.Shipping.FirstPersonalAddress(userType);
  }
});

When(/as a (guest|logged in) I add (first|other) invalid (delivery|billing) details?( and cancel)?$/, async (userType: string, deliveryType: string, addressType: string, isCanceled: boolean) => {
  if (addressType === 'delivery') {
    if (deliveryType === 'first') {
      await Checkout.Shipping.InvalidFirstDeliveryAddress(userType);
    } else if (isCanceled) {
      await Checkout.Shipping.InvalidNewDeliveryAddress('add', true);
    } else {
      await Checkout.Shipping.InvalidNewDeliveryAddress('add', false);
    }
  } else {
    if (deliveryType === 'first') {
      await Checkout.Payment.InvalidFirstBillingAddress();
    } else if (isCanceled) {
      await Checkout.Payment.InvalidNewBillingAddress('add', true);
    } else {
      await Checkout.Payment.InvalidNewBillingAddress('add', false);
    }
  }
});

When(/I edit my delivery details?/, async () => {
  await Checkout.Shipping.NewDeliveryAddress('edit', false);
});

When(/I apply promocode "(.*)" in the overview panel(:? on shopping bag page)? and store the discounted amount with key (#[^\s]+)/, async (promoCode: string, shopBagPage: string, key: string) => {
  const code = services.world.parse(promoCode);
  let skipButton = false;

  if (shopBagPage !== null) {
    skipButton = true;
  }
  await Checkout.Overview.ApplyPromoCode(code, key, skipButton);
});

Then(/I check that my delivery details(:? with index "(.*)")? have been saved/, async (index?: number) => {
  await Checkout.OrderConfirmation.CheckAddressDetails('shipping', index);
});

Then(/I check that my PuP details(:? with index "(.*)")? have been saved/, async (index?: number) => {
  await Checkout.Shipping.CheckPuPDetails(index);
});

Then(/as a (guest|logged in) user I check that (mandatory|invalid) field errors are correct/, async (userType: string, errorType: string) => {
  await Checkout.Shipping.CheckAddressErrors(userType, errorType);
});

Then(/^I check if product item details for part number (.*) are correctly displayed from DB$/, async (skuPartNumber: string) => {
  skuPartNumber = services.world.parse(skuPartNumber);
  skuPartNumber = services.product.parse(skuPartNumber);
  let productListAttributes: ProductListAttribute;
  let size;

  const productDetails = await services.product.productItem.getDetail(skuPartNumber);
  // eslint-disable-next-line max-len
  const productStyle = await services.product.productStyle.getDetail(productDetails.STYLECOLOUR_PARTNUMBER);

  if (productDetails.LENGTH_NAME && productDetails.WIDTH_NAME) {
    size = `${productDetails.WIDTH_NAME}/${productDetails.LENGTH_NAME}`;
  } else {
    size = productDetails.SIZE_NAME;
  }

  // eslint-disable-next-line prefer-const
  productListAttributes = {
    SKU_PARTNUMBER: productDetails.SKU_PARTNUMBER.trim(),
    NAME: productStyle.NAME.trim(),
    CURRENT_PRICE: productDetails.CURRENTPRICE,
    WASPRICE: productDetails.WASPRICE,
    MAIN_COLOUR: productDetails.COLOUR_NAME.trim(),
    SIZE: size.trim(),
  };
  // eslint-disable-next-line max-len
  const displayedProduct = await Checkout.Shipping.GetDisplayedProductDetails(skuPartNumber, productListAttributes.WASPRICE);

  expect(productListAttributes.SKU_PARTNUMBER, `Sku part number of the displayed product should have matched the DB sku part number ${productListAttributes.SKU_PARTNUMBER}`).to.equal(displayedProduct.SKU_PARTNUMBER);
  expect(productListAttributes.NAME.toLowerCase(), `The name of the displayed product should have matched the DB name ${productListAttributes.NAME}`).to.contain(displayedProduct.NAME.toLowerCase());
  expect(productListAttributes.CURRENT_PRICE, `The price of the displayed product should have matched the DB price ${productListAttributes.CURRENT_PRICE}`).to.equal(displayedProduct.CURRENT_PRICE);
  expect(productListAttributes.WASPRICE, `The non discounted price of the displayed product should have matched the DB discounted price ${productListAttributes.WASPRICE}`).to.equal(displayedProduct.WASPRICE);
  expect(productListAttributes.MAIN_COLOUR.toLowerCase(), `The color of the displayed product should have matched the DB color ${productListAttributes.SIZE}`).to.equal(displayedProduct.MAIN_COLOUR.toLowerCase());
  expect(productListAttributes.SIZE.toLowerCase(), `The size of the displayed product should have matched the DB size ${productListAttributes.SIZE}`).to.equal(displayedProduct.SIZE.toLowerCase());
});
