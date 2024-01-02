import { When, Then } from '@pvhqa/cucumber';
import { expect } from 'chai';
import services from '../../core/services';
import { DropdownSelector } from '../../core/constents';
import { exist$, exist$$ } from '../general';
import { ProductStyleDetail, ProductItemDetail } from '../../core/db/product-model';
import { getProductDropdownOptions, getProductDropdownSelectedOptionText } from '../helper/product-drop-down.helper';
import Checkout from '../pages/checkout';
import { sleep } from '../helper/utils.helper';

/**
 * Get current selected colour of the product or return an original colour if
 * product has no colour variants
 * @param pagePath
 * @param skuPartNumber
 * @param stylePartNumber
 * @param styleColourPartNumber
 */
async function getCurrentSelectedColourDetail(pagePath: string,
  skuPartNumber: string,
  stylePartNumber: string,
  styleColourPartNumber: string): Promise<ProductStyleDetail> {
  const detail = await services.product.product.getDetail(stylePartNumber);
  // Get current colour from dropbox
  const colourDropdownSelector = await services.pageObject.getSelector(
    `${pagePath}.EditColourDropdownSelector`,
    [skuPartNumber, undefined],
  ) as DropdownSelector;

  let currentSelectedColourName = await getProductDropdownSelectedOptionText(
    colourDropdownSelector,
  );

  // find colourName of current item
  let originalItemDetail: ProductItemDetail;
  if (!currentSelectedColourName) {
    // if where is no ColourDropDown we use colour info from original item (not from variants)
    originalItemDetail = detail.PRODUCT_STYLE_DICT.get(styleColourPartNumber)
      // first get styleColourPartNumber of the original item
      .PRODUCT_ITEM_DICT.get(skuPartNumber); // and then get a skuPartNumber of it
    currentSelectedColourName = originalItemDetail.COLOUR_NAME; // use original colour as selected
  }
  const currentColourDetail = services.product.product.extractStyleColourByColourName(
    detail, currentSelectedColourName,
  );
  if (!currentColourDetail) {
    throw new Error(`Cannot find colour ${currentSelectedColourName} from product ${stylePartNumber}`);
  }
  return currentColourDetail;
}

/**
 * Get current selected product item (with style_partnumber, sku_partnumber etc) based on what is
 * currently displayed in shopping bag. Get selected colour, selected size from dropdowns on FE.
 * Get sku from product item from FE directly can't be used as before you save changes,
 * sku_partnumber on FE stays the same. Different size/colour - different sku_partnumber.
 * @param pagePath
 * @param skuPartNumber of originally selected item
 * @param detail
 * @param itemDetail
 * @param currentSelectedColourName
 */
// TODO improve if no colour/size dropdown as currently it's waiting
// for colourdropdown to be displayed and after it makes query
async function getCurrentSelectedProductItem(
  pagePath: string,
  skuPartNumber: string,
  stylePartNumber: string,
  styleColourPartNumber: string,
): Promise<ProductItemDetail> {
  // Get current selected colour, or original if product has no colour variant
  const currentColourDetail = await getCurrentSelectedColourDetail(
    pagePath, skuPartNumber, stylePartNumber, styleColourPartNumber,
  );

  const detail = await services.product.product.getDetail(stylePartNumber);
  const originalItemDetail = detail.PRODUCT_STYLE_DICT.get(styleColourPartNumber)
    .PRODUCT_ITEM_DICT.get(skuPartNumber);
  // Filter out what's the current product item based on selected colour and size
  const anyProductItem = services.product.productStyle.extractFirstProductItem(currentColourDetail);
  let currentSelectedProductItem: ProductItemDetail = null;
  if (anyProductItem.SIZE_NAME) {
    // Get selected Product Item from FE when it's one size or normal size
    const sizeDropdownSelector = await services.pageObject.getSelector(
      `${pagePath}.EditSizeDropdownSelector`,
      [skuPartNumber, undefined],
    ) as DropdownSelector;
    const sizeName = await getProductDropdownSelectedOptionText(sizeDropdownSelector);
    if (!sizeName) { // no size product
      currentSelectedProductItem = services.product.productStyle
        .extractProductItems(currentColourDetail).values().next().value as ProductItemDetail;
    } else { // one size product
      currentSelectedProductItem = services.product.productStyle
        .extractProductItems(currentColourDetail)
        .find((i) => (i.SIZE_NAME
          ? i.SIZE_NAME.toLowerCase() === sizeName.toLowerCase()
          : originalItemDetail.SIZE_NAME === sizeName.toLowerCase())); // use original item colour
    }
  } else if (anyProductItem.WIDTH_NAME && !anyProductItem.LENGTH_NAME) {
    // Get selected Product Item when it's width-only product
    const widthOnlyDropdownSelector = await services.pageObject.getSelector(
      `${pagePath}.EditWidthDropdownSelector`,
      [skuPartNumber, undefined],
    ) as DropdownSelector;
    const sizeName = await getProductDropdownSelectedOptionText(widthOnlyDropdownSelector);
    currentSelectedProductItem = services.product.productStyle
      .extractProductItems(currentColourDetail)
      .find((i) => i.WIDTH_NAME.toLowerCase() === sizeName.toLowerCase());
  } else if (anyProductItem.WIDTH_NAME && anyProductItem.LENGTH_NAME) {
    // Get selected Product Item when it's width-length product
    const widthLengthDropdownSelector = await services.pageObject.getSelector(
      `${pagePath}.EditSizeDropdownSelector`,
      [skuPartNumber, undefined],
    ) as DropdownSelector;
    const widthLengthName = await getProductDropdownSelectedOptionText(widthLengthDropdownSelector);
    const split = widthLengthName.indexOf('x');
    const widthName = widthLengthName.substring(0, split - 1);
    const lengthName = widthLengthName.substring(split + 2);
    currentSelectedProductItem = services.product.productStyle
      .extractProductItems(currentColourDetail)
      .find((i) => i.WIDTH_NAME.toLowerCase() === widthName.toLowerCase()
        && i.LENGTH_NAME.toLowerCase() === lengthName.toLowerCase());
  }
  if (!currentSelectedProductItem) {
    throw new Error(`Cannot understand what is current selected product item for skuPartNumber=${skuPartNumber}`);
  }
  return currentSelectedProductItem;
}


When(/^in page ([^\s]+) edit colour dropdown of product item ([^\s]+) I select a (instock|out of stock) colour saved as (#[A-Za-z0-9]+)$/, async (pagePath: string, skuPartNumber: string, optionType: string, key: string) => {
  const elementPath = `${pagePath}.EditColourDropdownSelector`;
  let stylePartNumber = '';
  if (skuPartNumber.indexOf('#') === 0) {
    skuPartNumber = services.world.parse(skuPartNumber);
    const itemDetail = await services.product.productItem.getDetail(skuPartNumber);
    stylePartNumber = itemDetail.STYLE_PARTNUMBER;
  } else {
    stylePartNumber = skuPartNumber.replace('skuPartNumber', 'stylePartNumber');
    skuPartNumber = services.product.parse(skuPartNumber);
    stylePartNumber = services.product.parse(stylePartNumber);
  }

  const detail = await services.product.product.getDetail(stylePartNumber);
  const colours = optionType === 'instock'
    ? services.product.product.extractInStockStyleColours(detail)
    : services.product.product.extractOutOfStockStyleColours(detail);
  if (!colours && colours.length <= 0) {
    throw new Error(`There is no ${optionType} colour for product ${stylePartNumber}`);
  }

  // Try to find a colour which matches the colour option AND different with current selected colour
  let newSelectedColour: ProductStyleDetail;
  if (colours.length > 1) {
    // Get current selected colour name
    const selector = await services.pageObject.getSelector(
      elementPath,
      [skuPartNumber, undefined],
    ) as DropdownSelector;
    const currentSelectedColourName = await getProductDropdownSelectedOptionText(selector);
    newSelectedColour = colours.find(
      (c) => c.COLOUR_NAME.toLocaleLowerCase() !== currentSelectedColourName.toLocaleLowerCase(),
    );
    if (!newSelectedColour) {
      [newSelectedColour] = colours;
    } else {
      // Select new colour only if the new colour is different with current selected colour
      const newColourSelector = await services.pageObject.getSelector(
        elementPath,
        [skuPartNumber, newSelectedColour.COLOUR_NAME],
      ) as DropdownSelector;
      const dropdownEle = await exist$(newColourSelector);
      await dropdownEle.selectDropdown(newColourSelector.optionSelector);
    }
  } else {
    [newSelectedColour] = colours;
  }

  services.world.store(key, newSelectedColour.COLOUR_NAME);
});

When(/^in page ([^\s]+) edit size dropdown of product item ([^\s]+) I select a (high stock|low stock|instock) size saved as (#[A-Za-z0-9]+) into product item (#[A-Za-z0-9]+)$/, async (pagePath: string, skuPartNumber: string, optionType: string, key: string, productItemKey: string) => {
  // to select a new size, first it fetch colour variants info, then find size to select
  let stylePartNumber;
  let styleColourPartNumber;
  let skipSelectSize = false;
  if (skuPartNumber.startsWith('#')) {
    skuPartNumber = services.world.parse(skuPartNumber);
    const itemDetail = await services.product.productItem.getDetail(skuPartNumber);
    styleColourPartNumber = itemDetail.STYLECOLOUR_PARTNUMBER;
    stylePartNumber = itemDetail.STYLE_PARTNUMBER;
  } else {
    stylePartNumber = skuPartNumber.replace('skuPartNumber', 'stylePartNumber');
    styleColourPartNumber = skuPartNumber.replace('skuPartNumber', 'styleColourPartNumber');
    skuPartNumber = services.product.parse(skuPartNumber);
    styleColourPartNumber = services.product.parse(styleColourPartNumber);
    stylePartNumber = services.product.parse(stylePartNumber);
  }

  // Get current selected color, to decide what's the avaiable sizes
  // eslint-disable-next-line @typescript-eslint/no-use-before-define
  const currentColourDetail = await getCurrentSelectedColourDetail(
    pagePath, skuPartNumber, stylePartNumber, styleColourPartNumber,
  );

  // Filter all sizes based on size option
  let sizes: ProductItemDetail[];
  if (optionType === 'high stock') {
    sizes = services.product.productStyle.extractProductItemListWithInventory(
      currentColourDetail, 10,
    );
  } else if (optionType === 'low stock') {
    sizes = services.product.productStyle.extractProductItemListWithInventory(
      currentColourDetail, 1, 9,
    );
  } else {
    sizes = services.product.productStyle.extractProductItemListWithInventory(
      currentColourDetail, 1,
    );
  }

  if (!sizes || sizes.length <= 0) {
    throw new Error(`Cannot find ${optionType} size based on colour ${currentColourDetail} of product ${stylePartNumber}`);
  }

  // Try to find a size which matches the size option AND different with current selected colour
  let selectedSize: ProductItemDetail;
  if (sizes.length >= 1) {
    if (sizes[0].SIZE_NAME) {
      const selector = await services.pageObject.getSelector(
        `${pagePath}.EditSizeDropdownSelector`,
        [skuPartNumber, undefined],
      ) as DropdownSelector;
      const currentSelectedSizeName = await getProductDropdownSelectedOptionText(selector);
      selectedSize = sizes.find(
        (s) => s.SIZE_NAME.toLowerCase() !== currentSelectedSizeName.toLowerCase(),
      );
      if (!selectedSize) {
        [selectedSize] = sizes;
        skipSelectSize = true;
      }
    } else if (sizes[0].WIDTH_NAME && !sizes[0].LENGTH_NAME) {
      const selector = await services.pageObject.getSelector(
        `${pagePath}.EditWidthDropdownSelector`,
        [skuPartNumber, undefined],
      ) as DropdownSelector;
      const currentSelectedWidthName = await getProductDropdownSelectedOptionText(selector);
      selectedSize = sizes.find(
        (s) => s.WIDTH_NAME !== currentSelectedWidthName,
      );
      if (!selectedSize) {
        [selectedSize] = sizes;
        skipSelectSize = true;
      }
    } else if (sizes[0].WIDTH_NAME && sizes[0].LENGTH_NAME) {
      const widthSelector = await services.pageObject.getSelector(
        `${pagePath}.EditWidthDropdownSelector`,
        [skuPartNumber, undefined],
      ) as DropdownSelector;
      const currentSelectedWidthName = await getProductDropdownSelectedOptionText(widthSelector);

      const lengthSelector = await services.pageObject.getSelector(
        `${pagePath}.EditLengthDropdown`,
        [skuPartNumber, undefined],
      ) as DropdownSelector;
      const currentSelectedLengthName = await getProductDropdownSelectedOptionText(lengthSelector);
      selectedSize = sizes.find(
        (s) => s.WIDTH_NAME.toLowerCase() !== currentSelectedWidthName.toLowerCase()
          && s.LENGTH_NAME.toLowerCase() !== currentSelectedLengthName.toLowerCase(),
      );
      if (!selectedSize) {
        [selectedSize] = sizes;
        skipSelectSize = true;
      }
    } else {
      throw new Error(`This is invalid product with incorrect size: ${sizes[0].SKU_PARTNUMBER}`);
    }
  } else {
    [selectedSize] = sizes;
    skipSelectSize = true;
  }

  // Select different types of size
  let sizeSelector: DropdownSelector;
  if (selectedSize.SIZE_NAME && !skipSelectSize) {
    // Normal size & One Size product
    sizeSelector = await services.pageObject.getSelector(
      `${pagePath}.EditSizeDropdownSelector`,
      [skuPartNumber, selectedSize.SIZE_NAME],
    ) as DropdownSelector;
    const sizeDropdownEle = await exist$(sizeSelector);
    await sizeDropdownEle.selectDropdown(sizeSelector.optionSelector);
    services.world.store(key, selectedSize.SIZE_NAME);
  } else if (selectedSize.WIDTH_NAME && !selectedSize.LENGTH_NAME && !skipSelectSize) {
    // Width-Only product
    sizeSelector = await services.pageObject.getSelector(
      `${pagePath}.EditWidthDropdownSelector`,
      [skuPartNumber, selectedSize.WIDTH_NAME],
    ) as DropdownSelector;
    const sizeDropdownEle = await exist$(sizeSelector);
    await sizeDropdownEle.selectDropdown(sizeSelector.optionSelector);
    services.world.store(key, selectedSize.WIDTH_NAME);
  } else if (selectedSize.WIDTH_NAME && selectedSize.LENGTH_NAME && !skipSelectSize) {
    // Width & Length product
    const widthLenghtSelector = await services.pageObject.getSelector(
      `${pagePath}.EditLengthDropdown`,
      [skuPartNumber, `${selectedSize.WIDTH_NAME} x ${selectedSize.LENGTH_NAME}`],
    ) as DropdownSelector;
    const widthDropdownEle = await exist$(widthLenghtSelector);
    await widthDropdownEle.selectDropdown(widthLenghtSelector.optionSelector);
    services.world.store(key, `${selectedSize.WIDTH_NAME},${selectedSize.LENGTH_NAME}`);
  }
  services.world.store(productItemKey, selectedSize.SKU_PARTNUMBER);
  services.world.store(key, selectedSize.SIZE_NAME);
});

When(/^in page ([^\s]+) edit quantity dropdown of product item ([^\s]+) I select the (lowest|highest) (instock|available) quantity saved as (#[A-Za-z0-9]+)$/, async (pagePath: string, skuPartNumber: string, optionType: string, quantityType: string, key: string) => {
  let stylePartNumber = '';
  let styleColourPartNumber = '';
  if (skuPartNumber.indexOf('#') === 0) {
    skuPartNumber = services.world.parse(skuPartNumber);
    const itemDetail = await services.product.productItem.getDetail(skuPartNumber);
    stylePartNumber = itemDetail.STYLE_PARTNUMBER;
    styleColourPartNumber = itemDetail.STYLECOLOUR_PARTNUMBER;
  } else {
    stylePartNumber = skuPartNumber.replace('skuPartNumber', 'stylePartNumber');
    styleColourPartNumber = skuPartNumber.replace('skuPartNumber', 'styleColourPartNumber');
    skuPartNumber = services.product.parse(skuPartNumber);
    styleColourPartNumber = services.product.parse(styleColourPartNumber);
    stylePartNumber = services.product.parse(stylePartNumber);
  }

  // get current selected product item based on current selected colour and size
  const currentSelectedProductItem = await getCurrentSelectedProductItem(
    pagePath, skuPartNumber, stylePartNumber, styleColourPartNumber,
  );

  // decide the quantity which will be selected
  let newSelectQuantity = 1;
  if (quantityType === 'instock') {
    // select quantity by real stock
    newSelectQuantity = optionType === 'highest'
      ? Math.min(10, currentSelectedProductItem.QUANTITY)
      : 1;
  } else {
    // select quantity by available options
    const selector = await services.pageObject.getSelector(
      `${pagePath}.EditQuantityDropdownSelector`,
      [skuPartNumber, undefined],
    ) as DropdownSelector;
    await (await exist$(selector)).safeClick();
    const options = await exist$$(selector.pureSelectOptionSelector || selector.optionSelector);
    newSelectQuantity = optionType === 'highest'
      ? options.length
      : 1;
    await (await exist$(selector)).safeClick();
  }

  // Select drop down only if the current quantity not equal to new quantity
  const selector = await services.pageObject.getSelector(
    `${pagePath}.EditQuantityDropdownSelector`,
    [skuPartNumber, newSelectQuantity],
  ) as DropdownSelector;
  const currentSelectedQuantity = await getProductDropdownSelectedOptionText(selector);
  if (parseInt(currentSelectedQuantity, 10) !== newSelectQuantity) {
    const dropdownEle = await exist$(selector);
    await dropdownEle.selectDropdown(selector.optionSelector);
  }

  services.world.store(key, newSelectQuantity);
});

Then(/^in page ([^\s]+) edit colour dropdown of product item ([^\s]+) has correct colours$/, async (pagePath: string, skuPartNumber: string) => {
  let stylePartNumber = '';
  if (skuPartNumber.indexOf('#') === 0) {
    skuPartNumber = services.world.parse(skuPartNumber);
    const itemDetail = await services.product.productItem.getDetail(skuPartNumber);
    stylePartNumber = itemDetail.STYLE_PARTNUMBER;
  } else {
    stylePartNumber = skuPartNumber.replace('skuPartNumber', 'stylePartNumber');
    skuPartNumber = services.product.parse(skuPartNumber);
    stylePartNumber = services.product.parse(stylePartNumber);
  }
  const detail = await services.product.product.getDetail(stylePartNumber);

  const elementPath = `${pagePath}.EditColourDropdownSelector`;
  const selector = await services.pageObject.getSelector(
    elementPath, [skuPartNumber, undefined],
  ) as DropdownSelector;

  const instockColours = services.product.product.extractInStockStyleColours(detail);
  const outOfStockColours = services.product.product.extractOutOfStockStyleColours(detail);

  // get enabled and disabled options
  const options = await getProductDropdownOptions(
    selector.dropdownSelector,
    selector.pureSelectEnabledOptionSelector || selector.selectEnableOptionSelector,
    instockColours.length,
    selector.pureSelectDisabledOptionSelector || selector.selectDisabledOptionSelector,
    outOfStockColours.length,
    !selector.pureSelectEnabledOptionSelector,
  );

  if (!options) {
    throw new Error(`There is no any colour options when edit product item ${skuPartNumber}`);
  }

  // Checking enabled colours
  if (options.enabled.length > 0) {
    expect(
      options.enabled.map((c) => c.toLocaleLowerCase()).sort(),
      'Enabled colors is not matched',
    ).to.have.members(
      instockColours.map((c) => c.COLOUR_NAME.toLocaleLowerCase()),
    );
  }

  // Checking disabled colours
  if (options.disabled.length > 0) {
    expect(
      options.disabled.map((c) => c.toLocaleLowerCase()).sort(),
      'disabled colors is not matched',
    ).to.have.members(
      outOfStockColours.map((c) => c.COLOUR_NAME.toLocaleLowerCase()),
    );
  }
});

Then(/^in page ([^\s]+) edit size dropdown of product item ([^\s]+) has correct sizes$/, async (pagePath: string, skuPartNumber: string) => {
  let stylePartNumber = '';
  let styleColourPartNumber = '';
  if (skuPartNumber.indexOf('#') === 0) {
    skuPartNumber = services.world.parse(skuPartNumber);
    const itemDetail = await services.product.productItem.getDetail(skuPartNumber);
    stylePartNumber = itemDetail.STYLE_PARTNUMBER;
    styleColourPartNumber = itemDetail.STYLECOLOUR_PARTNUMBER;
  } else {
    stylePartNumber = skuPartNumber.replace('skuPartNumber', 'stylePartNumber');
    styleColourPartNumber = skuPartNumber.replace('skuPartNumber', 'styleColourPartNumber');
    skuPartNumber = services.product.parse(skuPartNumber);
    styleColourPartNumber = services.product.parse(styleColourPartNumber);
    stylePartNumber = services.product.parse(stylePartNumber);
  }

  const currentColourDetail = await getCurrentSelectedColourDetail(
    pagePath, skuPartNumber, stylePartNumber, styleColourPartNumber,
  );

  const allSizes = services.product.productStyle.extractProductItems(currentColourDetail);
  const inStockSizes = services.product.productStyle.extractProductItemListWithInventory(
    currentColourDetail, 1,
  );
  const outOfStockSizes = services.product.productStyle.extractProductItemListWithInventory(
    currentColourDetail, 0, 0,
  );

  if (!allSizes) {
    throw new Error(`No any sizes for current colour ${currentColourDetail}`);
  }

  if (allSizes[0].SIZE_NAME) {
    // Check for normal size product
    const selector = await services.pageObject.getSelector(
      `${pagePath}.EditSizeDropdownSelector`, [skuPartNumber, undefined],
    ) as DropdownSelector;

    // get enabled and disabled  options from UI
    const options = await getProductDropdownOptions(
      selector.dropdownSelector,
      selector.pureSelectEnabledOptionSelector || selector.selectEnableOptionSelector,
      inStockSizes.length,
      selector.pureSelectDisabledOptionSelector || selector.selectDisabledOptionSelector,
      outOfStockSizes.length,
      !selector.pureSelectEnabledOptionSelector,
    );

    if (!options) {
      throw new Error(`There is no any size options when edit product item ${skuPartNumber}`);
    }

    // Checking enabled sizes
    // TODO this will fail if size have an additiion like 'one left in stock'
    // TODO CET2-133
    if (options.enabled.length > 0) {
      expect(
        options.enabled.map((s) => s.toLocaleLowerCase()).sort(),
        'Enabled sizes are not matched',
      ).to.have.members(
        inStockSizes.map((s) => s.SIZE_NAME.toLocaleLowerCase()),
      );
    }

    // Checking disabled sizes
    if (options.disabled.length > 0) {
      expect(
        options.disabled.map((s) => s.toLocaleLowerCase()).sort(),
        'disabled sizes are not matched',
      ).to.have.members(
        outOfStockSizes.map((s) => s.SIZE_NAME.toLocaleLowerCase()),
      );
    }
  } else if (allSizes[0].WIDTH_NAME && !allSizes[0].LENGTH_NAME) {
    // Check for width size product
    const widthSelector = await services.pageObject.getSelector(
      `${pagePath}.EditWidthDropdownSelector`, [skuPartNumber, undefined],
    ) as DropdownSelector;

    // get enabled and disabled options
    const options = await getProductDropdownOptions(
      widthSelector.dropdownSelector,
      widthSelector.pureSelectEnabledOptionSelector || widthSelector.selectEnableOptionSelector,
      inStockSizes.length,
      widthSelector.pureSelectDisabledOptionSelector || widthSelector.selectDisabledOptionSelector,
      outOfStockSizes.length,
      !widthSelector.pureSelectEnabledOptionSelector,
    );

    // Checking enabled sizes
    if (options.enabled.length > 0) {
      expect(
        options.enabled.map((s) => s.toLocaleLowerCase()).sort(),
        'Enabled width are not matched',
      ).to.have.members(
        inStockSizes.map((s) => s.WIDTH_NAME.toLocaleLowerCase()),
      );
    }

    // Checking disabled sizes
    if (options.disabled.length > 0) {
      expect(
        options.disabled.map((s) => s.toLocaleLowerCase()).sort(),
        'disabled width are not matched',
      ).to.have.members(
        outOfStockSizes.map((s) => s.WIDTH_NAME.toLocaleLowerCase()),
      );
    }
  } else if (allSizes[0].WIDTH_NAME && allSizes[0].LENGTH_NAME) {
    // TODO: Fix the logic for width-length product
  }
});

Then(/^in page ([^\s]+) edit quantity dropdown of product item ([^\s]+) has highest instock quantity$/, async (pagePath: string, skuPartNumber: string) => {
  let stylePartNumber = '';
  let styleColourPartNumber = '';
  if (skuPartNumber.indexOf('#') === 0) {
    skuPartNumber = services.world.parse(skuPartNumber);
    const itemDetail = await services.product.productItem.getDetail(skuPartNumber);
    stylePartNumber = itemDetail.STYLE_PARTNUMBER;
    styleColourPartNumber = itemDetail.STYLECOLOUR_PARTNUMBER;
  } else {
    stylePartNumber = skuPartNumber.replace('skuPartNumber', 'stylePartNumber');
    styleColourPartNumber = skuPartNumber.replace('skuPartNumber', 'styleColourPartNumber');
    skuPartNumber = services.product.parse(skuPartNumber);
    styleColourPartNumber = services.product.parse(styleColourPartNumber);
    stylePartNumber = services.product.parse(stylePartNumber);
  }

  // get current selected product item based on current selected colour and size
  const currentSelectedProductItem = await getCurrentSelectedProductItem(
    pagePath, skuPartNumber, stylePartNumber, styleColourPartNumber,
  );

  const selector = await services.pageObject.getSelector(
    `${pagePath}.EditQuantityDropdownSelector`,
    [skuPartNumber, undefined],
  ) as DropdownSelector;

  // get available options from FE
  const options = await getProductDropdownOptions(
    selector.dropdownSelector,
    selector.pureSelectEnabledOptionSelector || selector.selectEnableOptionSelector,
    // if stock in DB >10, on FE it only 10 is displayed (max)
    currentSelectedProductItem.QUANTITY > 10 ? 10 : currentSelectedProductItem.QUANTITY,
    selector.pureSelectDisabledOptionSelector || selector.selectDisabledOptionSelector,
    0,
    !selector.pureSelectEnabledOptionSelector,
  );

  if (!options) {
    throw new Error(`There is no any quantity options when edit product item ${skuPartNumber}`);
  }

  expect(options.enabled.length, `The quantity dropdown shows incorrect quantity for product item ${currentSelectedProductItem.SKU_PARTNUMBER}`).to.equal(
    // if stock in DB > 10, on FE it only 10 is displayed (max)
    currentSelectedProductItem.QUANTITY > 10 ? 10 : currentSelectedProductItem.QUANTITY,
  );
});

Then(/^in page ([^\s]+) edit colour dropdown of product item ([^\s]+) has correct default value$/, async (pagePath: string, skuPartNumber: string) => {
  skuPartNumber = services.world.parse(skuPartNumber);
  skuPartNumber = services.product.parse(skuPartNumber);
  const detail = await services.product.productItem.getDetail(skuPartNumber);

  const selector = await services.pageObject.getSelector(
    `${pagePath}.EditColourDropdownSelector`, [skuPartNumber, undefined],
  ) as DropdownSelector;

  const text = await getProductDropdownSelectedOptionText(selector);
  if (!text) {
    throw new Error('Cannot get current selected colour text');
  }
  expect(text.toLocaleLowerCase(), `the default colour is incorrect for product item ${skuPartNumber}`).to.equal(detail.COLOUR_NAME.toLocaleLowerCase());
});

Then(/^in page ([^\s]+) edit size dropdown of product item ([^\s]+) has correct default value$/, async (pagePath: string, skuPartNumber: string) => {
  skuPartNumber = services.world.parse(skuPartNumber);
  skuPartNumber = services.product.parse(skuPartNumber);
  const detail = await services.product.productItem.getDetail(skuPartNumber);

  if (detail.SIZE_NAME) {
    const selector = await services.pageObject.getSelector(
      `${pagePath}.EditSizeDropdownSelector`, [skuPartNumber, undefined],
    ) as DropdownSelector;

    const text = await getProductDropdownSelectedOptionText(selector);
    expect(text.toLocaleLowerCase(), `the default size is incorrect for product item ${skuPartNumber}`).to.equal(detail.SIZE_NAME.toLocaleLowerCase());
  } else if (detail.WIDTH_NAME && !detail.LENGTH_NAME) {
    const widthSelector = await services.pageObject.getSelector(
      `${pagePath}.EditSizeDropdownSelector`, [skuPartNumber, undefined],
    ) as DropdownSelector;
    const width = await getProductDropdownSelectedOptionText(widthSelector);
    expect(width.toLocaleLowerCase(), `the default width is incorrect for product item ${skuPartNumber}`).to.equal(detail.WIDTH_NAME.toLocaleLowerCase());
  } else if (detail.LENGTH_NAME && !detail.WIDTH_NAME) {
    const lengthSelector = await services.pageObject.getSelector(
      `${pagePath}.EditLengthDropdown`, [skuPartNumber, undefined],
    ) as DropdownSelector;
    const length = await getProductDropdownSelectedOptionText(lengthSelector);
    expect(length.toLocaleLowerCase(), `the default length is incorrect for product item ${skuPartNumber}`).to.equal(detail.LENGTH_NAME.toLocaleLowerCase());
  } else if (detail.LENGTH_NAME && detail.WIDTH_NAME) {
    const widthSelector = await services.pageObject.getSelector(
      `${pagePath}.EditSizeDropdownSelector`, [skuPartNumber, undefined],
    ) as DropdownSelector;

    let widthNoCountryCode = detail.WIDTH_NAME;
    if (detail.WIDTH_NAME.search(/\d/) > 0) {
      widthNoCountryCode = detail.WIDTH_NAME.substring(detail.WIDTH_NAME.search(/\d/), 4);
    }

    const width = await getProductDropdownSelectedOptionText(widthSelector);
    const size = `${widthNoCountryCode} x ${detail.LENGTH_NAME}`;
    expect(width, `the default length is incorrect for product item ${skuPartNumber}`).to.equal(size);
  }
});

Then(/I choose delivery method as ([^\s]+) for userType as ([^\s]+) based on current locale?/, async (deliveryMethodType: string, userType: string) => {
  await Checkout.Shipping.chooseShipMode(deliveryMethodType);
  if (userType === 'guest' && (deliveryMethodType === 'ups' || deliveryMethodType === 'cis')) {
    await Checkout.Shipping.shortFirstDeliveryAddress(userType);
  } else if (userType === 'guest' || userType === 'sap_guest') {
    await Checkout.Shipping.FirstDeliveryAddress(userType);
  } else if (userType === 'loggedIn') {
    await Checkout.SignIn.signInFromShippingPage('pvh.sap_user@outlook.com', 'AutoNation2023', 'false');
    if (deliveryMethodType === 'ups' || deliveryMethodType === 'cis') {
      await Checkout.Shipping.shortFirstDeliveryAddress(userType);
    }
  }
  await sleep(1000);
  (await exist$(Checkout.Shipping.ProceedToPayment())).waitForClickable();
  await (await exist$(Checkout.Shipping.ProceedToPayment())).scrollIntoView();
  (await exist$(Checkout.Shipping.ProceedToPayment())).isDisplayedInViewport();
});

Then(/I choose payment method as ([^\s]+) with promo ([^\s]+)?/, async (paymentMethodType: string, promoCode: string) => {
  if (promoCode) {
    await Checkout.Overview.ApplyPromoCode(promoCode, 'promoCode', false);
  }
  await Checkout.Payment.choosePaymentMethod(paymentMethodType);
  await sleep(1000);
});
