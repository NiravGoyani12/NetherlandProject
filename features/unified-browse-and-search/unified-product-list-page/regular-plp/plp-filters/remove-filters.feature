Feature: Unified PLP Filters - Remove Filters

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience
  @PLP @Filter @TEX @P2 @FilterRemove
  @tms:UTR-15777
  Scenario Outline: Unified PLP Filters Remove - Active filter can be removed by clicking on active filter checkbox on PLP
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until the current page is loaded
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

    @ExcludeTH
    Examples:
      | locale | filterType | filterOption | categoryId             |
      | uk     | Size       | M            | women_clothes_t-shirts |
      | uk     | Colour     | Blue         | kids_clothes           |

    @ExcludeCK
    Examples:
      | locale | filterType | filterOption | categoryId              |
      | uk     | Size       | M            | th_women_clothing_jeans |
      | uk     | Size       | M            | th_kids_girls_jeans     |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience
  @PLP @Filter @TEX @P2 @FilterRemove
  @tms:UTR-15778
  Scenario Outline: Unified PLP Filters Remove Desktop - Active filter can be removed by clicking on active filter label on PLP
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until the current page is loaded
      And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
      And in unified filter panel I wait until filter type <filterType> with filter <filterOption> is active
      And I store the numeric value of Experience.PlpHeader.ProductCount with key #productCount
    When I scroll to the element Experience.PlpFilters.ActiveFilterRegion
      And I click on Experience.PlpFilters.ActiveFilterLabels
    Then the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #productCount
      And the count of elements Experience.PlpFilters.ActiveFilterLabels is equal to 0 in 2 seconds
      And the count of elements Experience.PlpFilters.ActiveFilterRegion is equal to 0 in 2 seconds

    @ExcludeTH
    Examples:
      | locale | filterType | filterOption | categoryId             |
      | uk     | Colour     | Blue         | women_clothes_t-shirts |
      | uk     | Colour     | Blue         | men_bestsellers        |

    @ExcludeCK
    Examples:
      | locale | filterType | filterOption | categoryId                   |
      | uk     | Colour     | Black        | TH_MEN_CLOTHING_COATSJACKETS |
      | uk     | Colour     | Black        | th_women_collections         |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience
  @PLP @Filter @TEX @P2 @FilterRemove
  @tms:UTR-15779
  Scenario Outline: Unified PLP Filters Remove Desktop - Only 1 filter is removed by clicking on active filter label on PLP
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until the current page is loaded
      And in unified filter panel I open filter type Size and select M as filter option
      And in unified filter panel I open filter type Colour and select Black as filter option
      And in unified filter panel I wait until filter type Colour with filter Black is active
      And I store the numeric value of Experience.PlpHeader.ProductCount with key #productCount
      And I click on Experience.PlpFilters.ActiveFilterLabels
    Then the count of elements Experience.PlpFilters.ActiveFilterLabels is equal to 1
      And the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #productCount

    @ExcludeTH
    Examples:
      | locale | categoryId             |
      | uk     | women_clothes_t-shirts |

    @ExcludeCK
    Examples:
      | locale | categoryId                   |
      | uk     | TH_MEN_CLOTHING_COATSJACKETS |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience
  @PLP @Filter @TEX @P2 @FilterRemove
  @tms:UTR-15780
  Scenario Outline: Unified PLP Filters Remove Desktop - Active filter can be removed from filter panel Reset button on PLP
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until the current page is loaded
      And I store the numeric value of Experience.PlpHeader.ProductCount with key #OriginalProductCount
      And in unified filter panel I open filter type Size and select M as filter option
      And in unified filter panel I open filter type Colour and select Black as filter option
      And in unified filter panel I wait until filter type Colour with filter Black is active
      And I store the numeric value of Experience.PlpHeader.ProductCount with key #FilteredProductCount
    When I scroll to the element Experience.PlpFilters.ActiveFilterRegion
      And I click on Experience.PlpFilters.FilterResetAll
    Then the count of elements Experience.PlpFilters.ActiveFilterLabels is equal to 0 in 2 seconds
      And the count of elements Experience.PlpFilters.ActiveFilterRegion is equal to 0 in 2 seconds
      And the numeric value of Experience.PlpHeader.ProductCount should be equal to the stored value with key #OriginalProductCount
      And the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #FilteredProductCount

    @ExcludeTH
    Examples:
      | locale | categoryId             |
      | uk     | women_clothes_t-shirts |

    @ExcludeCK
    Examples:
      | locale | categoryId                   |
      | uk     | TH_MEN_CLOTHING_COATSJACKETS |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience
  @PLP @Filter @TEX @P2 @FilterRemove
  @tms:UTR-15781
  Scenario Outline: Unified PLP Filters Remove Mobile - Active filter can be removed from filter panel Reset button on PLP
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until the current page is loaded
      And I store the numeric value of Experience.PlpHeader.ProductCount with key #OriginalProductCount
      And in unified filter panel I open filter type Size and select <size> as filter option
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

    @ExcludeTH
    Examples:
      | locale | categoryId                 | size |
      | uk     | women_clothes_t-shirts     | M    |
      | uk     | kids_boys_clothes_t-shirts | 4    |

    @ExcludeCK
    Examples:
      | locale | categoryId                       | size |
      | uk     | TH_MEN_CLOTHING_COATSJACKETS     | L    |
      | uk     | th_kids_boys_sweatshirts&hoodies | 8    |

