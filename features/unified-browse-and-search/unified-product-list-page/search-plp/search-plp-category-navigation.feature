Feature: Unified Search PLP - Category Navigation

  @FullRegression
  @UnifiedSearchPLP
  @Desktop
  @Chrome @FireFox @SafariPending
  @UnifiedPLP @UnifiedExperience @CategoryNavigation @EESK @P2
  @tms:UTR-15829
  Scenario Outline: Unified Search PLP Category Navigation Desktop - Verify category navigation not displayed on search plp
    Given I am on locale <locale> search page of langCode <langCode> with search term "<searchTerm>" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpHeader.CategoryNavigationBlock is not displayed in 3 seconds
      And the count of displayed elements Experience.PlpHeader.CategoryNavigationBlock is equal to 0

    Examples:
      | locale | langCode | searchTerm |
      | uk     | default  | Bras       |

  @FullRegression
  @UnifiedSearchPLP
  @Mobile
  @Chrome @FireFox @SafariPending
  @UnifiedPLP @UnifiedExperience @CategoryNavigation @EESK @P2
  @tms:UTR-15892
  Scenario Outline: Unified Search PLP Category Navigation Mobile - Verify category navigation not displayed on search plp
    Given I am on locale <locale> search page of langCode <langCode> with search term "<searchTerm>" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpFilters.BubbleFilter is not displayed in 3 seconds
      And the count of displayed elements Experience.PlpFilters.BubbleFilter is equal to 0

    @ExcludeTH
    Examples:
      | locale | langCode | searchTerm |
      | uk     | default  | Bras       |

    @ExcludeCK
    Examples:
      | locale | langCode | searchTerm |
      | uk     | default  | Bras       |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @CategoryNavigation @EESK @P2
  @tms:UTR-16319
  Scenario Outline: Unified PLP Category Navigation Desktop - Verify category navigation is displayed on Unified search PLP after navigating from category PLP
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
      And I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I see Experience.PlpHeader.CategoryNavigationBlock is displayed in 15 seconds
    When I am on locale <locale> search page of langCode <langCode> with search term "shoes"
      And I wait until page Experience.PlpProducts is loaded
    Then I wait until Experience.PlpHeader.CategoryNavigationBlock is displayed in 10 seconds
    When I see Experience.PlpHeader.PageHeader is displayed
    Then I see Experience.PlpHeader.ProductCount is displayed
      And the count of elements Experience.PlpProducts.ListingItems is greater than 1
      And the numeric value of Experience.PlpHeader.ProductCount is greater than 1
      And I see the count of Experience.PlpProducts.ProductsPrice is the same as the count of Experience.PlpProducts.ListingItems
      And I see the count of Experience.PlpProducts.ProductTitles is the same as the count of Experience.PlpProducts.ListingItems

    @ExcludeTH
    Examples:
      | locale | langCode | categoryId           |
      | uk     | default  | underwear_women_bras |

    @ExcludeCK
    Examples:
      | locale | langCode | categoryId              |
      | uk     | default  | th_women_clothing_jeans |