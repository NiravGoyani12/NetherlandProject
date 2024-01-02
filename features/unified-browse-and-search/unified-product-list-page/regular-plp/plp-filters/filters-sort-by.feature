Feature: Unified PLP Filters - Sorting

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending @UnifiedPLP @UnifiedExperience
  @PLP @Filter @Sorting @TEX @P2 @Translation
  @tms:UTR-15652
  Scenario Outline: Unified PLP Filters Desktop - Sort By filter has 5 options and 1 selected on PLP
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
      And I get translation for "RecommendedOption" and store it with key #recommendedOptionText
      And I get translation for "BestSellersOption" and store it with key #bestSellersOptionText
      And I get translation for "NewArrivalsOption" and store it with key #newArrivalsOptionText
      And I get translation for "PriceHighToLow" and store it with key #priceHighToLowText
      And I get translation for "PriceLowToHigh" and store it with key #priceLowToHighText
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    Then the count of displayed elements Experience.PlpFilters.SortByActiveFilterOption is equal to 1
    When in unified filter panel I open filter type <filter>
    Then I see Experience.PlpFilters.SortByOption with text #recommendedOptionText is displayed
      And I see Experience.PlpFilters.SortByOption with text #bestSellersOptionText is displayed
      And I see Experience.PlpFilters.SortByOption with text #newArrivalsOptionText is displayed
      And I see Experience.PlpFilters.SortByOption with text #priceHighToLowText is displayed
      And I see Experience.PlpFilters.SortByOption with text #priceLowToHighText is displayed
      And the count of elements Experience.PlpFilters.ActiveFilterLabels is equal to 0 in 2 seconds

    @ExcludeTH
    Examples:
      | locale  | langCode | filter               | categoryId             |
      | default | default  | SortByNewTranslation | women_clothes_t-shirts |

    @ExcludeCK
    Examples:
      | locale  | langCode | filter               | categoryId              |
      | default | default  | SortByNewTranslation | th_women_clothing_jeans |

  @FullRegression
  @Mobile
  @Chrome @SafariPending @UnifiedPLP @UnifiedExperience @Translation
  @PLP @Filter @Sorting @TEX @P2
  @tms:UTR-15653
  Scenario Outline: Unified PLP Filters Mobile - Sort By filter has 5 options and 1 selected on PLP
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
      And I get translation for "RecommendedOption" and store it with key #recommendedOptionText
      And I get translation for "BestSellersOption" and store it with key #bestSellersOptionText
      And I get translation for "NewArrivalsOption" and store it with key #newArrivalsOptionText
      And I get translation for "PriceHighToLow" and store it with key #priceHighToLowText
      And I get translation for "PriceLowToHigh" and store it with key #priceLowToHighText
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
      And I click on Experience.PlpFilters.MobileSortByButton
    Then I see Experience.PlpFilters.SortByOption with text #recommendedOptionText is existing
      And I see Experience.PlpFilters.SortByOption with text #bestSellersOptionText is existing
      And I see Experience.PlpFilters.SortByOption with text #newArrivalsOptionText is existing
      And I see Experience.PlpFilters.SortByOption with text #priceHighToLowText is existing
      And I see Experience.PlpFilters.SortByOption with text #priceLowToHighText is existing

    @ExcludeTH
    Examples:
      | locale  | langCode | filter               | categoryId                 |
      | default | default  | SortByNewTranslation | women_clothes_t-shirts     |
      | default | default  | SortByNewTranslation | kids_boys_clothes_t-shirts |
      | default | default  | SortByNewTranslation | men_bestsellers            |

    @ExcludeCK
    Examples:
      | locale  | langCode | filter               | categoryId              |
      | default | default  | SortByNewTranslation | th_women_clothing_jeans |
      | default | default  | SortByNewTranslation | th_women_collections    |
      | default | default  | SortByNewTranslation | th_kids_girls_jeans     |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience
  @PLP @Filter @Sorting @TEX @P2
  @tms:UTR-15654 @Translation
  Scenario Outline: Unified PLP Filters Desktop - Sort by price filter works on PLP
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I get translation for "<sortByPrice>" and store it with key #sortText
      And I wait until the current page is loaded
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
      | locale  | langCode | filter               | sortByPrice       | urlPrefix | compareResult | categoryId             |
      | default | default  | SortByNewTranslation | PriceHighToLowUni | _sort_=ph | less than     | women_clothes_t-shirts |
      | default | default  | SortByNewTranslation | PriceLowToHighUni | _sort_=pl | greater than  | women_clothes_t-shirts |

    @ExcludeCK
    Examples:
      | locale  | langCode | filter               | sortByPrice    | urlPrefix | compareResult | categoryId              |
      | default | default  | SortByNewTranslation | PriceHighToLow | _sort_=ph | less than     | th_women_clothing_jeans |
      | default | default  | SortByNewTranslation | PriceLowToHigh | _sort_=pl | greater than  | th_women_clothing_jeans |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @Translation
  @UnifiedPLP @UnifiedExperience @Filter @EESK @BasicFilterFlows @P2
  @tms:UTR-17170
  Scenario Outline: Unified PLP Filters - Verify Sort By filter can be applied after checkbox filter on unified PLP
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until the current page is loaded
      And I get translation for "<sortByPrice>" and store it with key #sortText
      And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
    Then in unified filter panel I see filter type <filterType> with filter <filterOption> is active
      And in unified filter panel I open sorting option <filter> and select <sortByPrice> as sort by option
      And URL should contain "<urlPrefix>"

    @ExcludeTH
    Examples:
      | locale  | categoryId             | filterType | filterOption | filter               | sortByPrice    | urlPrefix |
      | default | women_clothes_t-shirts | Colour     | Blue         | SortByNewTranslation | PriceLowToHigh | _sort_=pl |

    @ExcludeCK
    Examples:
      | locale  | categoryId                   | filterType | filterOption | filter               | sortByPrice    | urlPrefix |
      | default | TH_MEN_CLOTHING_COATSJACKETS | Colour     | Blue         | SortByNewTranslation | PriceHighToLow | _sort_=ph |