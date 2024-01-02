export type Selector = string;
export type SelectorTag = string;
export const REVERSE_CHECK = true;

export interface DropdownSelector {
  dropdownSelector: Selector
  optionSelector: Selector
  selectedValueSelector?: Selector
  selectEnableOptionSelector?: Selector
  selectDisabledOptionSelector?: Selector
  pureSelectOptionSelector?: Selector
  pureSelectEnabledOptionSelector?: Selector
  pureSelectDisabledOptionSelector?: Selector
}

export const isDropDownSelector = (object: any) : object is DropdownSelector => {
  const myInterface = object as DropdownSelector;
  return myInterface.dropdownSelector !== undefined && myInterface.optionSelector !== undefined;
};

export const XCOMREG = {
  FHTrackerAppID: 'FH_TRACKER_APP_ID',
  ToggleEnablAuthPopup: 'NEW_SIGNIN_FLOW',
  ToggleEnabledUnifiedCheckout: 'ENABLE_UNIFIED_CHECKOUT',
  ToggleEnabledUnifiedPdp: 'ENABLE_UNIFIED_PDP',
  ToggleEnabledUnifiedStoreLocator: 'ENABLE_UNIFIED_STORE_LOCATOR',
  ToggleEnabledUnifiedXO: 'pdp_rec_injection1',
  ToggleEnabledOnePageCheckout: 'ENABLE_ONE_PAGE_CHECKOUT',
  ToggleImplicitTermsCheckbox: 'ENABLE_TERMS_CONDITIONS_WITH_NO_CHECKBOX',
  ToggleAddressAutocomplete: 'ENABLE_ADDRESS_AUTOCOMPLETE',
};
