import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class SearchSuggestionPanel extends Page {
  // #search product image
  public readonly Item = (index?: number) => this.derived({
    Desktop: `(//*[@data-testid="ProductSuggestions-item-GridItem"]/a)${index ? `[${index}]` : ''}`,
  });

  public readonly ItemCurrentPrice = (text?: string) => this.derived({
    Desktop: `//*[@data-testid="ProductSuggestions-item-GridItem"]//*[@data-testid="PriceText" ${text ? `and contains(text(),'${text}')` : ''}]`,
  });

  public readonly ItemWasPrice = (text?: string) => this.derived({
    Desktop: `//*[@data-testid="ProductSuggestions-item-GridItem"]//*[@data-testid="WasPriceText" ${text ? `and contains(text(),'${text}')` : ''}]`,
  });

  public readonly ItemImage = (index?: number) => this.derived({
    Desktop: `(//*[@data-testid="ProductTile-image-wrapper"]//img)${index ? `[${index}]` : ''}`,
  });
  // #endregion

  // #region Search suggestions
  public readonly SearchSuggestionsFlyout = () => this.derived({
    Desktop: '//div[@data-testid="SearchSuggestions-component"] | //div[@data-testid="SearchContentContainer"]',
  });

  public readonly SearchSuggestionLinks = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="SearchSuggestions-component"]//button[@data-testid="SearchSuggestions-keyword"])${index ? `[${index}]` : ''}`,
  });

  public readonly SearchSuggestionResultsButton = () => this.derived({
    Desktop: '//div[@data-testid="SearchSuggestions-component"]//button[@data-testid="SearchSuggestions-seeAllResults"]',
  });

  public readonly SearchSuggestionHighlightText = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="SearchSuggestions-component"]//span[@data-testid="SearchSuggestions-highlightSpan"])${index ? `[${index}]` : ''}`,
  });

  public readonly SearchOverlayActive = () => this.derived({
    Desktop: '//header[@data-testid="Header-component"]//div[contains(@class,"HeaderOverlayActive")]',
  });

  public readonly SearchSuggestionProductCount = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="SearchSuggestions-component"]//span[@data-testid="SearchSuggestions-count"])${index ? `[${index}]` : ''}`,
    Mobile: `(//div[@data-testid="SearchSuggestions-component"]//span[contains(@class, "SearchSuggestions_Count")])${index ? `[${index}]` : ''}`,
  });

  public readonly SearchInputFocussed = () => this.derived({
    Desktop: '//div[@data-testid="searchContainer" and contains(@class, "Search_SearchFieldFocused")]',
  });

  public readonly SearchSuggestionsList = () => this.derived({
    Desktop: '[data-testid="SearchSuggestions-contentPosition-list"]',
  });

  public readonly SearchSuggestionsSeeAllResults = () => this.derived({
    Desktop: '[data-testid="SearchSuggestions-seeAllResults"]',
  });

  public readonly SearchSuggestionsProductTiles = () => this.derived({
    Desktop: '//*[@data-testid="ProductSuggestions-item-GridItem"]',
  });

  public readonly SearchSuggestionsProductTileCurrentPrice = () => this.derived({
    Desktop: '//*[@data-testid="ProductSuggestions-item-GridItem"]//*[@data-testid="PriceText"]',
  });

  public readonly SearchSuggestionsProductTileWasPrice = () => this.derived({
    Desktop: '//*[@data-testid="ProductSuggestions-item-GridItem"]//*[@data-testid="WasPriceText"]',
  });

  public readonly SearchContentContainer = () => this.derived({
    Desktop: '//div[contains(@class,"Search_SearchContentContainer")]',
  });

  public readonly SearchContentContainerElements = () => this.derived({
    Desktop: '//div[contains(@class,"Search_SearchContentContainer")]/div[contains(@data-testid,"component")]',
  });

  // #endregion

  // #region Recent Searches
  public readonly RecentSearchSuggestionsFlyout = () => this.derived({
    Desktop: '//div[contains(@data-testid,"searchContainer")]//div[@data-testid="RecentSearches-component"]',
  });

  public readonly RecentSearchHeader = () => this.derived({
    Desktop: '//div[contains(@data-testid,"searchContainer")]//h5[contains(@class, "RecentSearchesTitle")]',
  });

  public readonly RecentSearchLinkByIndex = (index?: number) => this.derived({
    Desktop: `//div[contains(@data-testid,"searchContainer")]//li[contains(@class, "RecentSearchesItem")][${index || 1}]|//div[@data-testid="RecentSearchesList"]//button[contains(@class,'Link_Link')][${index}]`,
  });

  public readonly RecentSearchLinks = (text?: string) => this.derived({
    Desktop: `//div[contains(@data-testid,"searchContainer")]//li[contains(@class, "RecentSearchesItem")]/button${text ? `[contains(text(), "${text}")]` : ''}`,
  });

  public readonly OnBehalfText = () => this.derived({
    Desktop: '//div[@data-testid="CsrHeader-component"]/div[2]/span',
  });

  public readonly ReturnToCsr = () => this.derived({
    Desktop: '//div[@data-testid="CsrHeader-component"]/div/a',
  });
  // #endregion

  // #region Popular Searches

  public readonly PopularSearchFlyout = () => this.derived({
    Desktop: '//div[@data-testid="PopularSearches-component"]',
  });

  public readonly PopularSearchHeader = () => this.derived({
    Desktop: '//div[@data-testid="PopularSearches-component"]//h4[contains(@class,"popular_searches_title")]',
  });

  public readonly PopularSearchImages = () => this.derived({
    Desktop: '//div[@data-testid="PopularSearches-component"]//li[contains(@class,"popular_searches_item")]',
  });

  public readonly PopularSearchLinks = () => this.derived({
    Desktop: '//div[@data-testid="PopularSearches-component"]//li[contains(@class,"popular_searches_item")]',
  });

  public readonly PopularSearchHeaderKids = (text?: string) => this.derived({
    Desktop: `//div[@data-testid="Kids-PopularSearches-component"]/div[contains(@class,"popular_searches")]/h4[contains(text(),'${text}')]`,
  });

  public readonly PopularSearchKidsImagesGirls = () => this.derived({
    Desktop: '//div[@data-testid="PopularSearches-component"]//div[@data-testid="Girls-PopularSearches-container"]//li[contains(@class,"popular_searches_item")]',
  });

  public readonly PopularSearchKidsImagesBoys = () => this.derived({
    Desktop: '//div[@data-testid="PopularSearches-component"]//div[@data-testid="Boys-PopularSearches-container"]//li[contains(@class,"popular_searches_item")]',
  });

  public readonly PopularSearchLinksKidsGirls = () => this.derived({
    Desktop: '//div[@data-testid="PopularSearches-component"]//div[@data-testid="Girls-PopularSearches-container"]//li[contains(@class,"popular_searches_item")]',
  });

  public readonly PopularSearchLinksKidsBoys = () => this.derived({
    Desktop: '//div[@data-testid="PopularSearches-component"]//div[@data-testid="Boys-PopularSearches-container"]//li[contains(@class,"popular_searches_item")]',
  });
  // #endregion
}
