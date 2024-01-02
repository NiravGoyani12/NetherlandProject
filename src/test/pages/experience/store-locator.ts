/* eslint-disable max-len */
import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class UXStoreLocator extends Page {
  // #region Store search
  public readonly StoreCount = () => this.derived({
    Desktop: '//p[@data-testid="typography-p"]',
  });

  public readonly SearchField = () => this.derived({
    Desktop: '#storeLocatorSearch',
  });

  public readonly SearchButton = () => this.derived({
    Desktop: '//button[@data-testid="store-locator-search-pvh-button"]',
  });

  public readonly InputError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-store-locator-search"]',
  });

  public readonly UseMyLocationButton = () => this.derived({
    Desktop: '//button[contains(@class, "UseMyLocationWithStoresFound")]',
  });
  // #endregion

  // #region Map
  public readonly StoresOnMap = (index?: number) => this.derived({
    Desktop: `(//button[contains(@class, "Marker_mapMarker")])${index ? `[${index}]` : ''}`,
  });
  // #endregion

  // #region Store list
  public readonly AvailableStores = (index?: number | string) => this.derived({
    Desktop: `(//div[contains(@class, "LocationList")]//div[@data-testid="pvh-selectionItem"])${index ? `[${index}]` : ''}`,
  });

  public readonly StoreTitle = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="locatorName"])${index ? `[${index}]` : ''}`,
  });

  public readonly StoreDistance = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="locatorDistance"])${index ? `[${index}]` : ''}`,
  });

  public readonly StoreAddress = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="Address-component"])${index ? `[${index}]` : ''}`,
  });

  public readonly StoreOpeningHoursList = () => this.derived({
    Desktop: '//h6[contains(@data-testid, "locatorOpeningHoursTitle")]/../ul',
  });

  public readonly StoreServices = () => this.derived({
    Desktop: '//div[contains(@data-testid, "locatorCapabilitiesComponent")]',
  });

  public readonly StoreProducts = () => this.derived({
    Desktop: '//div[contains(@data-testid, "locatorProducts")]',
  });

  public readonly ViewLessInfoLink = (text?: string) => this.derived({
    Desktop: `//div[contains(@class,"LocationDetails")]//a[contains(text(), "${text || ''}")]`,
  });

  public readonly ViewDirectionsLink = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="trigger-side-content"])${index ? `[${index}]` : ''}`,
  });

  public readonly StoreContactNumber = () => this.derived({
    Desktop: '//div[@data-testid="address-line"][3]',
  });

  public readonly StoreOpeningHours = () => this.derived({
    Desktop: '//*[@data-testid="pvh-AttributeListItem"]//span[contains(@class, "attributeListItemValue")]',
  });

  public readonly StoreServiceAvailableUsingStoreID = (storeId: string) => this.derived({
    Desktop: `//label[@data-testid="labelFor-${storeId}"]//div[contains(@data-testid, "service-pvh-Status-success")][1]//div[contains(@data-testid, "service-StatusIcon")]`,
  });

  public readonly MoreInfoLinkForStoreDetails = (storeId: string) => this.derived({
    Desktop: `//label[@data-testid="labelFor-${storeId}"]//div[contains(@class,"LocationDetails_TriggerWrapper__Y4HsJ")]//a[contains(@class,"Link_Link__H_TIr")]`,
  });
  // #endregion
}
