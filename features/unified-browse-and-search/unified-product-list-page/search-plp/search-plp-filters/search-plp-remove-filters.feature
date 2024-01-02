Feature: Unified Search PLP Filters - Remove Filters

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP
  @PLP @Filter @TEX @P2 @FilterRemove
  @tms:UTR-16044
  Scenario Outline: Unified Search PLP Filters Remove - Active filter can be removed by clicking on active filter checkbox on PLP
    Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I store the numeric value of Experience.PlpHeader.ProductCount with key #OriginalProductCount
      And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
      And in unified filter panel I wait until filter type <filterType> with filter <filterOption> is active
    Then the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #OriginalProductCount
      And I store the numeric value of Experience.PlpHeader.ProductCount with key #FilteredProductCount
      And in unified filter panel I open filter type <filterType> and deselect <filterOption> as filter option
      And I wait until the current page is loaded
    Then I see Experience.PlpFilters.ActiveFilterRegion is not existing in 5 seconds
      And I see Experience.PlpFilters.ActiveFilterLabels is not existing in 5 seconds
      And the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #FilteredProductCount
      And the numeric value of Experience.PlpHeader.ProductCount should be equal to the stored value with key #OriginalProductCount

    Examples:
      | locale | langCode | filterType | filterOption |
      | uk     | default  | Colour     | Red          |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP
  @PLP @Filter @TEX @P2 @FilterRemove
  @tms:UTR-16045
  Scenario Outline: Unified Search PLP Filters Remove Desktop - Active filter can be removed by clicking on active filter label on PLP
    Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
      And in unified filter panel I wait until filter type <filterType> with filter <filterOption> is active
      And I store the numeric value of Experience.PlpHeader.ProductCount with key #productCount
    When I scroll to the element Experience.PlpFilters.ActiveFilterRegion
      And I click on Experience.PlpFilters.ActiveFilterLabels
    Then the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #productCount
      And the count of elements Experience.PlpFilters.ActiveFilterLabels is equal to 0 in 2 seconds
      And the count of elements Experience.PlpFilters.ActiveFilterRegion is equal to 0 in 2 seconds

    Examples:
      | locale | langCode | filterType | filterOption |
      | uk     | default  | Colour     | Blue         |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP
  @PLP @Filter @TEX @P2 @FilterRemove
  @tms:UTR-16046
  Scenario Outline: Unified Search PLP Filters Remove Desktop - Only 1 filter is removed by clicking on active filter label on PLP
    Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type Colour and select Blue as filter option
      And in unified filter panel I open filter type Colour and select Black as filter option
      And in unified filter panel I wait until filter type Colour with filter Black is active
      And I store the numeric value of Experience.PlpHeader.ProductCount with key #productCount
      And I click on Experience.PlpFilters.ActiveFilterLabels
    Then the count of elements Experience.PlpFilters.ActiveFilterLabels is equal to 1
      And the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #productCount

    Examples:
      | locale | langCode |
      | uk     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP
  @PLP @Filter @TEX @P2 @FilterRemove
  @tms:UTR-16047
  Scenario Outline: Unified Search PLP Filters Remove Desktop - Active filter can be removed from filter panel Reset button on PLP
    Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I store the numeric value of Experience.PlpHeader.ProductCount with key #OriginalProductCount
      And in unified filter panel I open filter type Colour and select Blue as filter option
      And in unified filter panel I open filter type Colour and select Black as filter option
      And in unified filter panel I wait until filter type Colour with filter Black is active
      And I store the numeric value of Experience.PlpHeader.ProductCount with key #FilteredProductCount
    When I scroll to the element Experience.PlpFilters.ActiveFilterRegion
      And I click on Experience.PlpFilters.FilterResetAll
    Then the count of elements Experience.PlpFilters.ActiveFilterLabels is equal to 0 in 2 seconds
      And the count of elements Experience.PlpFilters.ActiveFilterRegion is equal to 0 in 2 seconds
      And the numeric value of Experience.PlpHeader.ProductCount should be equal to the stored value with key #OriginalProductCount
      And the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #FilteredProductCount

    Examples:
      | locale | langCode |
      | uk     | default  |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP
  @PLP @Filter @TEX @P2 @FilterRemove
  @tms:UTR-16048
  Scenario Outline: Unified Search PLP Filters Remove Mobile - Active filter can be removed from filter panel Reset button on PLP
    Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I store the numeric value of Experience.PlpHeader.ProductCount with key #OriginalProductCount
      And in unified filter panel I open filter type Colour and select Blue as filter option
      And in unified filter panel I open filter type Colour and select Black as filter option
      And in unified filter panel I wait until filter type Colour with filter Black is active
      And I store the numeric value of Experience.PlpHeader.ProductCount with key #FilteredProductCount
    When I click on Experience.PlpFilters.FilterButton
      And I click on Experience.PlpFilters.FilterResetAll in 5 seconds
      And in unified PLP I ensure filter panel is closed
    Then the count of elements Experience.PlpFilters.ActiveFilterLabels is equal to 0 in 2 seconds
      And the count of elements Experience.PlpFilters.ActiveFilterRegion is equal to 0 in 2 seconds
      And the numeric value of Experience.PlpHeader.ProductCount should be equal to the stored value with key #OriginalProductCount
      And the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #FilteredProductCount

    Examples:
      | locale | langCode |
      | uk     | default  |

