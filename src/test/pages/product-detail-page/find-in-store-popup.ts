import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class FindInStorePopup extends Page {
  public readonly FindInStoreButton = () => this.derived({
    Desktop: '[data-testid="clickAndReserve-pvh-button"]',
  });

  public readonly FindInStoreModal = () => this.derived({
    Desktop: '[data-testid="findInStoreLocatore-Modal-component"]',
  });

  public readonly FindInStoreModalCloseButton = () => this.derived({
    Desktop: '//button[contains(@class, "Modal_CloseButton")]',
  });

  public readonly SearchLocation = () => this.derived({
    Desktop: 'input[data-testid="FISL_Input-inputField"]',
  });

  public readonly SubmitAddress = () => this.derived({
    Desktop: 'button[data-testid="FISL_Search-pvh-button"]',
  });

  public readonly SearchResultsList = () => this.derived({
    Desktop: 'div[data-testid="FISL-list"]',
  });

  public readonly FindInStoreLocations = (index: number) => this.derived({
    Desktop: `//div[@data-testid="pvh-selectionItem"][${index}]`,
  });

  public readonly StoreLocationName = (index: number) => this.derived({
    Desktop: `//div[@data-testid="FISL_locatorName"][${index}]`,
  });

  public readonly StoreLocationAddress = (index: number) => this.derived({
    Desktop: `//div[@data-testid="Address-component"][${index}]`,
  });

  public readonly StoreLocationDetailsMoreInfo = (index: number) => this.derived({
    Desktop: `(//div[@data-testid="location-details"]//div[@data-testid="collapse-trigger"]//a)[${index}]`,
  });

  public readonly StoreOpenHours = () => this.derived({
    Desktop: '//h6[contains(@data-testid,"locatorOpeningHours")]',
  });

  public readonly ShowDirections = (index: number) => this.derived({
    Desktop: `(//a[@data-testid="get-directions-link"])[${index}]`,
  });

  public readonly StorePinsOnMap = () => this.derived({
    Desktop: '//button[contains(@class, "Marker_mapMarker")]',
  });

  public readonly GoogleMaps = () => this.derived({
    Desktop: '//div[@data-testid="google-map"]//div[@data-status="loaded"]',
  });

  public readonly UseMyLocationButton = () => this.derived({
    Desktop: '//button[@data-testid="FISL_useMyLoc"]//span',
  });

  public readonly SearchResultCount = () => this.derived({
    Desktop: '//div[contains(@class, "UseMyLocationWithStoresFound")]/p',
  });

  public readonly SelectedSize = (size: number) => this.derived({
    Desktop: `//span[contains(@class,"find_in_store_locator_fisl_currentSize") and contains(text(), "${size}")]`,
  });

  public readonly ChangeSize = () => this.derived({
    Desktop: 'button[data-testid="FISL_ChangeSize"]',
  });

  public readonly PreviouslyNotSelectedSizeButton = () => this.derived({
    Desktop: '//div[@data-testid="findInStoreLocatore-Modal-component"]//div[@data-testid="ProductSize-component" and not(contains(@class, "SizeSelected"))]/button',
  });

  public readonly StoreSearchError = (text: string) => this.derived({
    Desktop: `//div[@data-testid="alert-error-FISL_Input" and contains(text(), "${text}")]`,
  });

  public readonly StoresWithStockFilter = () => this.derived({
    Desktop: 'div[data-testid="storesWithStock-Checkbox-Component-content"]',
  });

  public readonly locationDetailsInfo = (index: number) => this.derived({
    Desktop: `(//div[contains(@class,'LocationDetails_TriggerWrapper')]/a)[${index}]`,
  });
}
