/* eslint-disable no-await-in-loop */
import { Then, When } from '@pvhqa/cucumber';
import { expect } from 'chai';
import services from '../../../core/services';
import {
  exist$, exist$$, maybeDisplayed$, p$,
} from '../../general';
import { formatCurrency } from '../../helper/currency.helper';
import { getBrandProductNumber, navigateToDeepLink } from '../../helper/deep-link.helper';
import { sleep } from '../../helper/utils.helper';
import UPPdp from '../../pages/product-detail-page/pdp';
import { clickElement } from '../browser.steps';
import { stepISeeTextOfInputIs } from '../element-validation.steps';

const pdp = p$(UPPdp);

When(/^I am on unified locale (default|[^\s]+) pdp page(?: of langCode (default|[^\s]+))? for product style ([^\s]+)( with accepted cookies| with forced accepted cookies|)$/, async (
  locale: string, langCode: string, styleColourPartNumber: string, withAcceptedCookies: string,
) => {
  services.site.initilizeSize(locale, langCode);
  await services.site.extractSiteInfo();
  // Sequence is: TH/CK. use for example: AM0AM10454XM6/000QF5149E001
  if (styleColourPartNumber.includes('/')) {
    styleColourPartNumber = await getBrandProductNumber(styleColourPartNumber);
  }
  styleColourPartNumber = services.world.parse(styleColourPartNumber);
  styleColourPartNumber = services.product.parse(styleColourPartNumber);
  const seoUrl = await services.product.productStyle.GetSEOUrl(
    styleColourPartNumber, services.site.siteInfo.LOCALENAME,
  );
  const url = `${services.site.baseUrl}/${seoUrl}`;
  await navigateToDeepLink(url, withAcceptedCookies);
  await sleep(1000);
});

Then(/in unified PDP I see product info is matched to product style by style colour number (.*)/, async (styleColourPartNumber: string) => {
  styleColourPartNumber = services.world.parse(styleColourPartNumber);
  styleColourPartNumber = services.product.parse(styleColourPartNumber);
  const productStyleDetail = await services.product.productStyle.getDetail(styleColourPartNumber);
  const commands = [
    maybeDisplayed$(
      pdp.VatInfo(),
    ),
  ];
  const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
  const currentPrice = formatCurrency(priceInfo.minCurrentPrice, priceInfo.currency);
  if (priceInfo.minCurrentPrice < priceInfo.maxCurrentPrice) {
    // Show From;
    commands.push(
      maybeDisplayed$(
        pdp.FromCurrentPrice(currentPrice),
      ),
    );
  } else {
    commands.push(
      maybeDisplayed$(
        pdp.CurrentPrice(currentPrice),
      ),
    );
  }
  if (priceInfo.minWasPrice
    && priceInfo.minWasPrice !== Number.MAX_VALUE
    && priceInfo.minWasPrice !== priceInfo.minCurrentPrice
  ) {
    const wasPrice = formatCurrency(priceInfo.minWasPrice, priceInfo.currency);
    if (priceInfo.minWasPrice < priceInfo.maxWasPrice) {
      // Show From;
      commands.push(
        maybeDisplayed$(
          pdp.FromWasPrice(wasPrice),
        ),
      );
    } else {
      commands.push(
        maybeDisplayed$(
          pdp.WasPrice(wasPrice),
        ),
      );
    }
  }
  const results = await Promise.all(commands);
  results.forEach((r) => {
    expect(r, 'some elements are not displayed in Product Info').not.to.be.null;
  });
});

Then(/in unified PDP I see product name is matched to product style colour part number (.*)/, async (styleColourPartNumber: string) => {
  styleColourPartNumber = services.product.parse(styleColourPartNumber);
  const detail = await services.product.productStyle.getDetail(styleColourPartNumber);
  const selector = pdp.ProductName(detail.NAME);
  const ele = await exist$(selector);
  await ele.waitForDisplayed({ timeoutMsg: `The product name ${detail.NAME} is not displayed` });
});

When(/I extract the colour name of ([^\s]+) and store it with key (#[A-Za-z0-9]+)/, async (elementPath: string, key: string) => {
  elementPath = await services.pageObject.getSelector(elementPath) as string;
  const ele = await exist$(elementPath);
  const text = await ele.getText();
  services.world.store(key, text);
});

Then(/^I see benefits section is expanded when no sustainable section is displayed$/, async () => {
  const sustainableSectionDisplayed = await maybeDisplayed$('ProductDetailPage.Pdp.SustainableStyleSection', 1000);
  if (sustainableSectionDisplayed !== null) {
    const expandedSustainableSection = await exist$('ProductDetailPage.Pdp.ExpandedSustainableDetailsSection');
    await expandedSustainableSection.waitForDisplayed({ timeoutMsg: 'The Sustainable section is not expanded' });
  } else {
    const expandedBenefitsSection = await exist$('ProductDetailPage.Pdp.ExpandedBenefitsSection');
    await expandedBenefitsSection.waitForDisplayed({ timeoutMsg: 'The Benefits section is not expanded' });
  }
});

When(/in unified PDP I select size by sku part number (.*)/, async (skuPartNumber: string) => {
  skuPartNumber = services.world.parse(skuPartNumber);
  skuPartNumber = services.product.parse(skuPartNumber);
  const productItemDetail = await services.product.productItem.getDetail(skuPartNumber);
  if (productItemDetail.SIZE_NAME
    && (productItemDetail.SIZE_NAME.toLocaleLowerCase() === 'one size'
      || productItemDetail.SIZE_NAME.toLocaleLowerCase() === 'os')
  ) {
    return;
  }

  if (productItemDetail.SIZE_NAME) {
    const sizeButton = await exist$(pdp.SingleSizeButton(productItemDetail.SIZE_NAME));
    await sizeButton.safeClick();
    await sleep(500);
  } else if (productItemDetail.WIDTH_NAME && productItemDetail.LENGTH_NAME) {
    const widthButton = await exist$(pdp.WidthSizeButton(productItemDetail.WIDTH_NAME));
    await widthButton.safeClick();
    await sleep(500);
    if (productItemDetail.LENGTH_NAME.toLocaleLowerCase() !== 'r') {
      const lengthButton = await exist$(pdp.LengthSizeButton(productItemDetail.LENGTH_NAME));
      await lengthButton.scrollIntoView({ block: 'center' });
      await lengthButton.safeClick();
      await sleep(1000);
    }
  } else if (productItemDetail.WIDTH_NAME && !productItemDetail.LENGTH_NAME) {
    const widthButton = await exist$(pdp.WidthSizeButton(productItemDetail.WIDTH_NAME));
    await widthButton.safeClick();
    await sleep(500);
  } else {
    throw new Error(`This is an invalid product item : ${skuPartNumber}, ${JSON.stringify(productItemDetail)}`);
  }
});

When(/in unified PDP I select the oos (width and length|size) and save as (#[A-Za-z0-9]+)/, async (sizeType: string, keyToStore: string) => {
  let size = '';
  if (sizeType === 'width and length') {
    const widthSoldOutButton = await exist$(pdp.WidthSizeSoldOutButton());
    await widthSoldOutButton.safeClick();
    const lengthSoldOutButton = await exist$(pdp.LengthSizeSoldOutButton());
    await lengthSoldOutButton.scrollIntoView({ block: 'center' });
    await lengthSoldOutButton.safeClick();
    size = `${await widthSoldOutButton.getText()}/${await lengthSoldOutButton.getText()}`;
  } else if (sizeType === 'size') {
    const sizeSoldOutButton = await exist$(pdp.SizeSoldOutButton());
    await sizeSoldOutButton.safeClick();
    size = await sizeSoldOutButton.getText();
  } else {
    throw new Error(`No ${sizeType} sizes found`);
  }
  services.world.store(keyToStore, size);
});

When(/in unified PDP I select the oos size and subscribe to notification/, async () => {
  await clickElement('ProductDetailPage.Pdp.SizeSoldOutButton');
  await clickElement('ProductDetailPage.Pdp.NotifyMeButton');
  await stepISeeTextOfInputIs('ProductDetailPage.NotifyMePopup.EmailInput', 'user1#email');
  await clickElement('ProductDetailPage.NotifyMePopup.NotifyMeButton');
});

Then(/in unified PDP I see page title contains product name and brand name and product number of product style colour partnumber ([^\s]+)/, async (styleColourPartNumber: string) => {
  styleColourPartNumber = services.world.parse(styleColourPartNumber);
  styleColourPartNumber = services.product.parse(styleColourPartNumber);

  const detail = await services.product.productStyle.getDetail(styleColourPartNumber);
  const title = await browser.getTitle();

  const expectTitle = `${detail.NAME.trim()} Calvin Klein® | ${detail.STYLECOLOUR_PARTNUMBER.trim()}`;
  expect(title.toLocaleLowerCase()).equals(expectTitle.toLocaleLowerCase());
});

Then(/in PDP I see page title contains product name and colour name and brand of product style colour partnumber ([^\s]+)/, async (styleColourPartNumber: string) => {
  styleColourPartNumber = services.world.parse(styleColourPartNumber);
  styleColourPartNumber = services.product.parse(styleColourPartNumber);

  const detail = await services.product.productStyle.getDetail(styleColourPartNumber);
  const title = await browser.getTitle();

  const expectTitle = `${detail.NAME.trim()} | ${detail.MAIN_COLOUR.trim()} | Tommy Hilfiger`;
  expect(title.toLocaleLowerCase()).equals(expectTitle.toLocaleLowerCase());
});

Then(/in unified PDP I see lowest price of the available sizes are displayed/, async () => {
  const sizeElements = await exist$$('ProductDetailPage.Pdp.AvailableSize');
  const priceLocator = await exist$('ProductDetailPage.Pdp.CurrentPrice');
  const originalPrice = await priceLocator.getText();
  const prices = [];
  for (let i = 0; i < sizeElements.length; i += 1) {
    await sizeElements[i].click();
    const price = await priceLocator.getText();
    prices.push(Number(price.replace(/[^0-9.-]+/g, '')));
  }
  expect(Number(originalPrice.replace(/[^0-9.-]+/g, ''))).equals(Math.min(...prices));
});
