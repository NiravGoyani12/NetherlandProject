Feature:Unified PLP - Scrolling

  @FullRegression
  @Mobile
  @Chrome @FireFox @UnifiedTEX
  @PlpPagination @Viewport @UnifiedPLP @UnifiedExperience @TEX @P2
  @feature:TEX-13528
  @tms:UTR-13478 @issue:EESK-5545
  Scenario Outline: Unified PLP - Verify that the Filters / Sort by sticky buttons are present while scrolling in Mobile
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
      And I save page lastPageNumber for category <categoryId> for locale <locale> as key #pageCount
      And I save page totalItemCount for category <categoryId> for locale <locale> as key #totalItemCount
      And I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I see Experience.PlpFilters.MobileFilterByButton is displayed
    When in unified PLP I scroll down to the <itemIndex> listing item
    Then I see Experience.PlpFilters.MobileFilterByButton is displayed
      And I see Experience.PlpFilters.MobileSortByButton is displayed
    When I move to the bottom of the page
    Then I see Experience.PlpFilters.MobileFilterByButton is displayed
      And I see Experience.PlpFilters.MobileSortByButton is displayed
    When I move to the top of the page
    Then I see Experience.PlpFilters.MobileFilterByButton is displayed
      And I see Experience.PlpFilters.MobileSortByButton is displayed

    @ExcludeCK
    Examples:
      | locale | itemIndex | categoryId              |
      | uk     | 17        | th_women_clothing_jeans |

    @ExcludeTH
    Examples:
      | locale | itemIndex | categoryId           |
      | uk     | 17        | MEN_CLOTHES_T-SHIRTS |


  @FullRegression
  @Mobile
  @Chrome @FireFox @UnifiedTEX
  @PlpPagination @Viewport @UnifiedPLP @UnifiedExperience @TEX @P2
  @feature:TEX-13529 @ExcludeCK
  @tms:UTR-13484
  Scenario Outline: Unified PLP - Verify that for TH, search bar is exposed while scrolling to the top in Mobile
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
      And I save page lastPageNumber for category <categoryId> for locale <locale> as key #pageCount
      And I save page totalItemCount for category <categoryId> for locale <locale> as key #totalItemCount
      And I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpPagination.MobileExposedSearchBar is displayed
      And I see Experience.PlpPagination.MobileBurgerMenuWithoutSearchIcon is displayed
      And I see Experience.PlpPagination.MobileBurgerMenuWithSearchIcon is not displayed
    When in unified PLP I scroll down to the <itemIndex> listing item
    Then I see Experience.PlpPagination.MobileExposedSearchBar is not displayed
      And I see Experience.PlpPagination.MobileBurgerMenuWithoutSearchIcon is not displayed
      And I see Experience.PlpPagination.MobileBurgerMenuWithSearchIcon is displayed
    When I move to the bottom of the page
    Then I see Experience.PlpPagination.MobileExposedSearchBar is not displayed
      And I see Experience.PlpPagination.MobileBurgerMenuWithoutSearchIcon is not displayed
      And I see Experience.PlpPagination.MobileBurgerMenuWithSearchIcon is displayed
    When I move to the top of the page
    Then I see Experience.PlpPagination.MobileExposedSearchBar is displayed
      And I see Experience.PlpPagination.MobileBurgerMenuWithoutSearchIcon is displayed
      And I see Experience.PlpPagination.MobileBurgerMenuWithSearchIcon is not displayed

    Examples:
      | locale | itemIndex | categoryId              |
      | uk     | 20        | th_women_clothing_jeans |

  #TODO
  # @FullRegression
  # @Desktop
  # @Chrome @FireFox
  # @PlpPagination @Viewport @TEX @P2
  # @tms:UTR-781
  # Scenario Outline: Verify the viewport to be retained upon a back click from PDP to PLP when changing columngrid
  #   Given I am on locale <locale> home page with accepted cookies
  #   Then I set pagination cookie
  #   When in mega menu I click 1st main menu => 3rd category menu => 1st subdivision menu
  #     And I click on Plp.ProductList.<columnGrid>
  #     And in PLP I scroll down to the <itemIndex> listing item
  #     And I click on Plp.ProductList.ItemByIndex with index <itemIndex>
  #     And I wait until page ProductDetailPage.Pdp is loaded
  #     And I navigate back in the browser
  #     And I wait until page Plp is loaded
  #   Then I see Plp.ProductList.ItemByIndex with index <itemInVewport> is in viewport

  #   Examples:
  #     | locale     | itemIndex | itemInVewport | columnGrid              |
  #     | spaDefault | 47        | 47            | DisplayTwoColumnButton  |
  #     | spaDefault | 47        | 47            | DisplayFourColumnButton |

  @FullRegression
  @Mobile @Desktop
  @Chrome @FireFox @EESK
  @PlpPagination @Viewport @UnifiedPLP @UnifiedExperience @EESK @P2
  @feature:EESK-4509 @feature:EESK-4458
  @tms:UTR-17050
  Scenario Outline: Unified PLP - Verify scroll position is retained after coming back from PDP to PLP
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
      And I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    When in unified PLP I scroll down to the <itemIndex> listing item
      And I click on Experience.PlpProducts.ListingItems with index <itemIndex> until ProductDetailPage.Pdp.Content is displayed
      And I wait until ProductDetailPage.Pdp.Content is displayed
      And I navigate back in the browser
      And I wait until page Experience.PlpProducts is loaded
      And I see Experience.PlpProducts.ListingItems with index <itemIndex> is in viewport

    @ExcludeTH
    Examples:
      | locale | itemIndex | categoryId           |
      | uk     | 35        | MEN_CLOTHES_T-SHIRTS |

    @ExcludeCK
    Examples:
      | locale | itemIndex | categoryId              |
      | uk     | 35        | th_women_clothing_jeans |