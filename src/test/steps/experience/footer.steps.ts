import { Then, When } from '@pvhqa/cucumber';
import { expect } from 'chai';
import {
  exist$, exist$$,
} from '../../general';
import services from '../../../core/services';
import { DropdownSelector } from '../../../core/constents';

When(/in unified footer I ensure ([^\s]+) is interactable/, async (elementPath: string) => {
  if (services.env.IsMobile || services.env.IsTablet) {
    const tab = await exist$(`${elementPath}Open`);
    await tab.scrollIntoView();
    await tab.safeClick();
  }
});

Then(/in unified footer I see country option list is ordered alphabetically/, async () => {
  const countryDropdown = await services.pageObject.getSelector('Experience.Footer.CountryDropdown') as DropdownSelector;
  const countryOptions = await exist$$(countryDropdown.optionSelector);
  let i = 0;
  const countryListText = [];
  while (i < countryOptions.length) {
    // eslint-disable-next-line no-await-in-loop
    countryListText.push(await countryOptions[i].getTextByJs());
    i += 1;
  }
  const orderedCountryListText = (countryListText.slice(0)).sort(Intl.Collator().compare);
  expect(countryListText).to.deep.equal(orderedCountryListText, 'Country list is not ordered alphabetically');
});

Then(/in unified footer I see country option (.*) contains text ([^\s]+)/, async (countryOption: string, text: string) => {
  const countryDropdown = await services.pageObject.getSelector('Experience.Footer.CountryDropdown', [countryOption]) as DropdownSelector;
  const countryOptionElement = await exist$(countryDropdown.optionSelector);
  const textList = await Promise.all(
    [countryOptionElement.getText(), countryOptionElement.getTextByJs()],
  );
  const actualText = textList[0] || textList[1];
  const countryOptionText = actualText.toString().toLowerCase();
  expect(countryOptionText.includes(text.toLowerCase()), `Country option ${countryOption} should contain ${text}. Actual was: ${countryOptionText}.`).to.be.true;
});
