/* eslint-disable no-await-in-loop */
/** CSR specific steps. Tested only on Desktop, Chrome.
 */
import { Then, When } from '@pvhqa/cucumber';
import { expect } from 'chai';
import { maybeDisplayed$, maybeExist$ } from '../general';
import services from '../../core/services';

/** Type date in the date picker.
 * This has been tested only for new CSR tool, only DT, Chrome
 * as there're no other places with this element.
 * @param date
 * @param DatePickerPath
 */
When(/in datepicker ([^\s]+) I type date "(.*)"/, async (DatePickerPath: string, date: string) => {
  date = services.world.parse(date);
  date = date.replace(/\D/g, '');
  const keyCodeBackspace = '\uE003';
  // set focus
  const element = await services.pageObject.getSelector(DatePickerPath);
  const datePickerElement = await maybeDisplayed$(element);
  await datePickerElement.safeClick();
  // clean up input field
  await browser.keys(keyCodeBackspace);
  await browser.keys(keyCodeBackspace);
  await browser.keys(keyCodeBackspace);
  await browser.keys(keyCodeBackspace);
  await browser.keys(keyCodeBackspace);
  await browser.keys(keyCodeBackspace);
  // type date
  await datePickerElement.safeType(date);
});

Then(/^I check the displayed (order ids|emails) "(.*)" are in the same order as in the search field$/, async (dataToCheck: string, data: string) => {
  const parsedData = services.world.parse(data);
  const displayedData = parsedData.split(', ');
  const timeout = 5000;
  let selector;

  for (let i = 0; i <= displayedData.length; i += 1) {
    if (dataToCheck === 'order ids') {
      selector = await services.pageObject.getSelector('Csr.SearchPage.SearchResultTableOrderIDColumn', [displayedData[i]]);
    } else if (dataToCheck === 'emails') {
      selector = await services.pageObject.getSelector('Csr.SearchPage.SearchResultTableEmailColumn', [displayedData[i]]);
    }

    const element = await maybeExist$(selector, timeout);
    expect(element, `The ${data} "${displayedData[i]}" is not displayed`).not.to.be.null;
  }
});
