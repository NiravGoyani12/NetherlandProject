import { maybeExist$$, exist$, maybeExist$ } from '../general';
import { sleep } from './utils.helper';
import { DropdownSelector } from '../../core/constents';

/* eslint-disable import/prefer-default-export */
/**
 * Get enabled and disabled options form dropdown
 * @param dropdownContainerSelector
 * @param enabledOptionSelector
 * @param enabledLength
 * @param disabledOptionList
 * @param disabledLength
 * @param getFromUI open DropDownContainer and get available sizes from visible dropdown list
 * Doulbe check you have all page objects and they're correct.
 */
export const getProductDropdownOptions = async (
  dropdownContainerSelector: string,
  enabledOptionSelector: string,
  enabledLength: number,
  disabledOptionSelector: string,
  disabledLength: number,
  getFromUI: boolean,
) => {
  const defaultCheckTimeout = 1000;
  if (getFromUI) {
    const dropdownContainer = await exist$(dropdownContainerSelector);
    await dropdownContainer.safeClick();
    await sleep(500);
  }
  const [enabledOptionList, disabledOptionList] = await Promise.all([
    maybeExist$$(
      enabledOptionSelector, enabledLength, defaultCheckTimeout,
    ),
    maybeExist$$(
      disabledOptionSelector, disabledLength, defaultCheckTimeout,
    ),
  ]);
  const enabledOptionTextList = await Promise.all(
    enabledOptionList.map((i) => (getFromUI ? i.getText() : i.getTextByJs())),
  );
  const disabledOptionTextList = await Promise.all(
    disabledOptionList.map((i) => (getFromUI ? i.getText() : i.getTextByJs())),
  );
  if (getFromUI) {
    const dropdownContainer = await exist$(dropdownContainerSelector);
    await dropdownContainer.safeClick();
    await sleep(500);
  }
  return {
    enabled: enabledOptionTextList,
    disabled: disabledOptionTextList,
  };
};

/**
 * Get current selected option text
 * @param selectedOptionSelector You have specified selected option selector
 */
export const getProductDropdownSelectedOptionText = async (
  dropdown: DropdownSelector,
): Promise<string> => {
  if (dropdown.selectedValueSelector) {
    const ele = await maybeExist$(dropdown.selectedValueSelector);
    if (!ele) {
      return null;
    }
    const textList = await Promise.all([ele.getText(), ele.getValue()]);
    return textList[0] || textList[1];
  }
  if (dropdown.dropdownSelector && dropdown.dropdownSelector.indexOf('//select') >= 0) {
    const ele = await maybeExist$(dropdown.dropdownSelector);
    if (!ele) {
      return null;
    }
    const text = await browser.execute('return arguments[0].selectedOptions[0].text', ele);
    return text as string;
  }
  throw new Error('Cannot get product dropdown selected option text, check you defined selectedValueSelector or your dropdownSelector is a pure select element');
};
