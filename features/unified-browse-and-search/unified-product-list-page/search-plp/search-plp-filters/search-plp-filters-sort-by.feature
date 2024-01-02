Feature: Unified Search PLP Filters - Sorting

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP
  @PLP @Filter @Sorting @TEX @P2 @Translation
  @tms:UTR-16038
  Scenario Outline: Unified Search PLP Filters Desktop - Sort By filter has 5 options and 1 selected on PLP
    Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I wait until the current page is loaded
      And I get translation for "RecommendedOption" and store it with key #recommendedOptionText
      And I get translation for "BestSellersOption" and store it with key #bestSellersOptionText
      And I get translation for "NewArrivalsOption" and store it with key #newArrivalsOptionText
      And I get translation for "PriceHighToLow" and store it with key #priceHighToLowText
      And I get translation for "PriceLowToHigh" and store it with key #priceLowToHighText
    Then the count of displayed elements Experience.PlpFilters.SortByActiveFilterOption is equal to 1
    When in unified filter panel I open filter type <filter>
    Then I see Experience.PlpFilters.SortByOption with text #recommendedOptionText is displayed
      And I see Experience.PlpFilters.SortByOption with text #bestSellersOptionText is displayed
      And I see Experience.PlpFilters.SortByOption with text #newArrivalsOptionText is displayed
      And I see Experience.PlpFilters.SortByOption with text #priceHighToLowText is displayed
      And I see Experience.PlpFilters.SortByOption with text #priceLowToHighText is displayed
      And the count of elements Experience.PlpFilters.ActiveFilterLabels is equal to 0 in 2 seconds

    Examples:
      | locale | langCode | filter               |
      | uk     | default  | SortByNewTranslation |

  @FullRegression
  @Mobile
  @Chrome @SafariPending @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP
  @PLP @Filter @Sorting @TEX @P2 @Translation
  @tms:UTR-16039
  Scenario Outline: Unified Search PLP Filters Mobile - Sort By filter has 5 options and 1 selected on PLP
    Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I wait until the current page is loaded
      And I get translation for "RecommendedOption" and store it with key #recommendedOptionText
      And I get translation for "BestSellersOption" and store it with key #bestSellersOptionText
      And I get translation for "NewArrivalsOption" and store it with key #newArrivalsOptionText
      And I get translation for "PriceHighToLow" and store it with key #priceHighToLowText
      And I get translation for "PriceLowToHigh" and store it with key #priceLowToHighText
      And I click on Experience.PlpFilters.MobileSortByButton
    Then I see Experience.PlpFilters.SortByOption with text #recommendedOptionText is existing
      And I see Experience.PlpFilters.SortByOption with text #bestSellersOptionText is existing
      And I see Experience.PlpFilters.SortByOption with text #newArrivalsOptionText is existing
      And I see Experience.PlpFilters.SortByOption with text #priceHighToLowText is existing
      And I see Experience.PlpFilters.SortByOption with text #priceLowToHighText is existing

    Examples:
      | locale | langCode | filter               |
      | uk     | default  | SortByNewTranslation |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP
  @PLP @Filter @Sorting @TEX @P2 @Translation
  @tms:UTR-16040
  Scenario Outline: Unified Search PLP Filters Desktop - Sort by price filter works on PLP
    Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I wait until the current page is loaded
      And I get translation for "<sortByPrice>" and store it with key #sortText
      And in unified filter panel I open sorting option <filter> and select <sortByPrice> as sort by option
      And I store the numeric value of Experience.PlpProducts.ProductsPrice with index 1 with key #priceItem1
      And in unified PLP I scroll down to the 48th listing item
    Then the numeric value of Experience.PlpProducts.ProductsPrice with index 45 is <compareResult> #priceItem1
      And URL should contain "<urlPrefix>"
      And in unified filter panel I close filter type <filter>
      And the count of elements Experience.PlpFilters.ActiveFilterLabels is equal to 0 in 2 seconds
      And I see Experience.PlpFilters.SortByActiveFilterOption contains text "#sortText"
      And the values of displayed elements Experience.PlpFilters.SortByActiveFilterOption should be equal to the stored values with key #sortText

    @ExcludeTH
    Examples:
      | locale | langCode | filter               | sortByPrice       | urlPrefix | compareResult |
      | uk     | default  | SortByNewTranslation | PriceHighToLowUni | _sort_=ph | less than     |
      | uk     | default  | SortByNewTranslation | PriceLowToHighUni | _sort_=pl | greater than  |

    @ExcludeCK
    Examples:
      | locale | langCode | filter               | sortByPrice    | urlPrefix | compareResult |
      | uk     | default  | SortByNewTranslation | PriceHighToLow | _sort_=ph | less than     |
      | uk     | default  | SortByNewTranslation | PriceLowToHigh | _sort_=pl | greater than  |

