import { When, Then } from '@pvhqa/cucumber';
import { expect } from 'chai';
import { p$, exist$, maybeDisplayed$ } from '../../general';
import SearchSuggestionPanel from '../../pages/experience/search-suggestion-panel';
import { GetTestLogger } from '../../../core/logger/test.logger';
import services from '../../../core/services';
import { formatCurrency } from '../../helper/currency.helper';

const searchSuggestion = p$(SearchSuggestionPanel);

When(/in unified search suggestion I extract style part number of (\d+)(?:st|nd|rd|th) suggestion that saved as (#[A-Za-z0-9]+)/, async (index: number, key: string) => {
  const item = await exist$(searchSuggestion.Item(index));
  const href = await item.getAttribute('href');
  const hrefParts = href.split('-');
  const styleColourPartNumber = hrefParts[hrefParts.length - 1].toUpperCase();
  GetTestLogger().info(`Extract ${index}th suggestion style colour part number: ${styleColourPartNumber}`);
  await services.product.productStyle.fetchProductStyleDetail(styleColourPartNumber);
  services.world.store(key, styleColourPartNumber);
});

Then(/in unified search suggestion I see the content of the (\d+)(?:st|nd|rd|th) suggestion is matched to product style ([^\s]+)/, async (itemIndex: number, styleColourPartNumber: string) => {
  styleColourPartNumber = services.world.parse(styleColourPartNumber);
  const productStyleDetail = await services.product.productStyle.getDetail(styleColourPartNumber);
  const commands = [];

  const priceInfo = services.product.productStyle.extractMinMaxPrice(productStyleDetail);
  const currentPrice = formatCurrency(
    priceInfo.minCurrentPrice,
    priceInfo.currency,
  );
  commands.push(
    maybeDisplayed$(
      searchSuggestion.ItemCurrentPrice(currentPrice),
    ),
  );
  // only when there is was Price && was price != current price
  if (priceInfo.minWasPrice
    && priceInfo.minWasPrice !== Number.MAX_VALUE
    && priceInfo.minWasPrice !== priceInfo.minCurrentPrice
  ) {
    const wasPrice = formatCurrency(
      priceInfo.minWasPrice,
      priceInfo.currency,
    );
    commands.push(
      maybeDisplayed$(
        searchSuggestion.ItemWasPrice(wasPrice),
      ),
    );
  }

  const results = await Promise.all(commands);
  results.forEach((r) => {
    expect(r, 'some elements are not displayed in recent search suggestion').not.to.be.null;
  });
});
