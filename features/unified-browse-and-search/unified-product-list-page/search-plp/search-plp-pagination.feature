Feature: Unified Search PLP - Pagination
  # TODO:
  # Verify images loaded for PLP with less than 48 products
  # Verify images loaded for PLP first page
  # Verify images loaded for PLP last page with less than 48 products

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @PlpPagination @EESK @P2
  @tms:UTR-15743
  Scenario Outline: Unified Search PLP Pagination - Verify page navigation elements are displayed for search results with more than 48 products
    Given I save page lastPageNumber for search <searchTerm> for locale <locale> as key #pageCount
      And I save page totalItemCount for search <searchTerm> for locale <locale> as key #totalItemCount
    When I am on locale <locale> search page with search term "<searchTerm>" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpPagination.ViewedOfItems is displayed
      And I see Experience.PlpPagination.ViewedOfItems contains text "48"
    Then I see Experience.PlpPagination.PreviousButton is displayed
      And I see Experience.PlpPagination.PreviousButton is not clickable
    Then I see Experience.PlpPagination.NextButton is displayed
      And I see Experience.PlpPagination.NextButton is clickable
    Then I see Experience.PlpPagination.CurrentPageNumber is displayed
      And I see Experience.PlpPagination.CurrentPageNumber contains text "1"
    Then I see Experience.PlpPagination.TotalPageCount is displayed

    Examples:
      | locale  | searchTerm |
      | default | jeans      |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @PlpPagination @EESK @P2
  @tms:UTR-15744
  Scenario Outline: Unified Search PLP Pagination - Verify product list count is correct per page
    Given I am on locale <locale> search page with search term "<searchTerm>" with accepted cookies
    When I wait until page Experience.PlpProducts is loaded
    Then in unified search <searchTerm> PLP for locale <locale> I verify item count and navigate to last page using buttons

    Examples:
      | locale | searchTerm |
      | uk     | belts      |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @PlpPagination @EESK @P2
  @tms:UTR-15744
  Scenario Outline: Unified Search PLP Pagination - Verify page numbers displayed are correct for all pages
    Given I am on locale <locale> search page with search term "<searchTerm>" with accepted cookies
    When I wait until page Experience.PlpProducts is loaded
    Then in unified search <searchTerm> PLP for locale <locale> I verify page numbers and navigate to last page using buttons

    Examples:
      | locale | searchTerm |
      | uk     | belts      |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @PlpPagination @EESK @P2
  @tms:UTR-15747
  Scenario Outline: Unified Search PLP Pagination - Verify page navigation elements are not displayed for category with less than 48 products
    Given I am on locale <locale> search page with search term "<searchTerm>" with accepted cookies
    When I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpPagination.ViewedOfItems is not displayed
      And I see Experience.PlpPagination.PreviousButton is not displayed
      And I see Experience.PlpPagination.NextButton is not displayed
      And I see Experience.PlpPagination.CurrentPageNumber is not displayed
      And I see Experience.PlpPagination.ViewedOfItems is not displayed

    Examples:
      | locale | searchTerm |
      | uk     | perfumes   |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @PlpPagination @EESK @P2
  @tms:UTR-15749
  Scenario Outline: Unified Search PLP Pagination - Verify user is able to navigate from last page to first page via buttons
    Given I am on search <searchTerm> unified page last of locale <locale> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    Then in unified search <searchTerm> PLP for locale <locale> I verify page numbers and navigate to first page using buttons

    Examples:
      | locale | searchTerm |
      | uk     | belts      |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @PlpPagination @Filter @EESK @P2
  @tms:UTR-15772
  Scenario Outline: Unified Search PLP Pagination - Verify page navigation elements are not displayed for filtered search results with less than 48 products
    Given I am on locale <locale> of url <plpUrl> with forced accepted cookies
    When I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpPagination.ViewedOfItems is not displayed
      And I see Experience.PlpPagination.PreviousButton is not displayed
      And I see Experience.PlpPagination.NextButton is not displayed
      And I see Experience.PlpPagination.CurrentPageNumber is not displayed
      And I see Experience.PlpPagination.TotalPageCount is not displayed

    @ExcludeTH
    Examples:
      | locale | plpUrl                                                          |
      | uk     | /search?searchTerm=shirts#size_facet_ee=s.100693_2xl__big_tall_ |

    @ExcludeCK
    Examples:
      | locale | plpUrl                                                       |
      | uk     | /search?searchTerm=shirts#size_ee=s.size_5xlt_ee;size_5xl_ee |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @PlpPagination @Viewport @Filter @EESK @P2
  @tms:UTR-15773
  Scenario Outline: Unified Search PLP Pagination - Verify the viewport to be retained upon a back click from PDP to PLP when on first PLP page
    Given I am on locale <locale> search page with search term "<searchTerm>" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    When in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
      And I hover over Experience.PlpProducts.ListingItems with index <itemIndex>
      And I click on Experience.PlpProducts.ListingItems with index <itemIndex> until ProductDetailPage.Pdp.Content is displayed
      And I wait until ProductDetailPage.Pdp.Content is displayed
      And I navigate back in the browser
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpProducts.ListingItems with index <itemIndex> is in viewport in 10 seconds

    @ExcludeTH
    Examples:
      | locale | itemIndex | searchTerm | filterType | filterOption |
      | uk     | last()    | shirts     | FIT        | Regular      |

    @ExcludeCK
    Examples:
      | locale | itemIndex | searchTerm | filterType | filterOption |
      | uk     | last()    | shirts     | Category   | Shirts       |


  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @PlpPagination @Viewport @Filter @EESK @P2
  @RCTest @tms:UTR-15826
  Scenario Outline: Unified Search PLP Pagination - Verify the viewport to be retained upon a back click from PDP to PLP on PLP when on PLP page 2 - onwards (except last page)
    Given I am on locale <locale> search page with search term "<searchTerm>" with accepted cookies
    When I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
      And in unified PLP I click next page button
      And I hover over Experience.PlpProducts.ListingItems with index <itemIndex>
      And I click on Experience.PlpProducts.ListingItems with index <itemIndex> until ProductDetailPage.Pdp.Content is displayed
      And I wait until ProductDetailPage.Pdp.Content is displayed
      And I navigate back in the browser
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpProducts.ListingItems with index <itemIndex> is in viewport in 10 seconds

    @ExcludeTH
    Examples:
      | locale | itemIndex | searchTerm | filterType | filterOption |
      | uk     | last()    | shirts     | FIT        | Regular      |

    @ExcludeCK
    Examples:
      | locale | itemIndex | searchTerm | filterType | filterOption |
      | uk     | last()    | shirts     | Category   | Shirts       |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @PlpPagination @Viewport @EESK @P2
  @RCTest @tms:UTR-15827
  Scenario Outline: Unified Search PLP Pagination - Verify the viewport to be retained upon a back click from PDP to PLP when on PLP last page
    Given I am on search <searchTerm> page last of locale <locale> of langCode default with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I store the number of elements Experience.PlpProducts.ListingItems with key #itemIndex
    When I scroll down to unified PLP item #itemIndex
      And I click on Experience.PlpProducts.ListingItems with index #itemIndex until ProductDetailPage.Pdp.Content is displayed
      And I wait until ProductDetailPage.Pdp.Content is displayed
      And I navigate back in the browser
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpProducts.ListingItems with index #itemIndex is in viewport in 10 seconds

    Examples:
      | locale | searchTerm |
      | uk     | shirts     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @PlpPagination @Viewport @EESK @P2
  @RCTest
  @tms:UTR-15774
  Scenario Outline: Unified Search PLP Pagination - Verify scroll to top button is displayed when on first PLP page
    Given I am on locale <locale> search page with search term "<searchTerm>" with accepted cookies
    When I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpProducts.BackToTopButton is not in viewport in 3 seconds
    When in unified PLP I scroll down to the 5 listing item
    Then I see Experience.PlpProducts.BackToTopButton is in viewport
    When in unified PLP I scroll down to the 48 listing item
    Then I see Experience.PlpProducts.BackToTopButton is in viewport

    Examples:
      | locale | searchTerm |
      | uk     | shirts     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @PlpPagination @Viewport @EESK @P2
  @tms:UTR-15825
  Scenario Outline: Unified Search PLP Pagination - Verify scroll to top button is displayed when on PLP page 2 - onwards (except last page)
    Given I am on locale <locale> search page with search term "<searchTerm>" with accepted cookies
    When I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
      And in unified PLP I click next page button
    Then I wait until page Experience.PlpProducts is loaded
      And I see Experience.PlpProducts.BackToTopButton is not in viewport in 3 seconds
    When in unified PLP I scroll down to the 5 listing item
    Then I see Experience.PlpProducts.BackToTopButton is in viewport
    When in unified PLP I scroll down to the 48 listing item
    Then I see Experience.PlpProducts.BackToTopButton is in viewport

    @ExcludeTH
    Examples:
      | locale | searchTerm | filterType | filterOption |
      | uk     | shirts     | FIT        | Regular      |

    @ExcludeCK
    Examples:
      | locale | searchTerm | filterType | filterOption |
      | uk     | shirts     | Category   | Shirts       |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @PlpPagination @Viewport @EESK @P2
  @tms:UTR-15775
  Scenario Outline: Unified Search PLP Pagination - Verify scroll to top button is displayed when on last PLP page
    Given I am on search <searchTerm> page last of locale <locale> of langCode default with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I store the number of elements Experience.PlpProducts.ListingItems with key #itemIndex
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpProducts.BackToTopButton is not in viewport in 3 seconds
    When in unified PLP I scroll down to the 5 listing item
    Then I see Experience.PlpProducts.BackToTopButton is in viewport
    When I scroll down to unified PLP item #itemIndex
    Then I see Experience.PlpProducts.BackToTopButton is in viewport

    Examples:
      | locale | searchTerm |
      | uk     | shirts     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @PlpPagination @Viewport @EESK @P2
  @tms:UTR-15776
  Scenario Outline: Unified Search PLP Pagination - Validate scroll to top button jumps to the top of the page when on first page
    Given I am on locale <locale> search page with search term "<searchTerm>" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    When in unified PLP I scroll down to the 5 listing item
      And I see Experience.PlpProducts.BackToTopButton is in viewport
      And I click on Experience.PlpProducts.BackToTopButton
      And I wait until Experience.PlpHeader.PageHeader is in viewport
    Then I see Experience.PlpProducts.ListingItems with index 1 is in viewport
      And in unified PLP I scroll down to the 48 listing item
      And I see Experience.PlpProducts.BackToTopButton is in viewport
    When I click on Experience.PlpProducts.BackToTopButton
      And I wait until Experience.PlpHeader.PageHeader is in viewport
    Then I see Experience.PlpProducts.ListingItems with index 1 is in viewport

    Examples:
      | locale | searchTerm |
      | uk     | shirts     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @PlpPagination @Viewport @EESK @P2
  @tms:UTR-15824
  Scenario Outline: Unified Search PLP Pagination - Validate scroll to top button jumps to the top of the page when on last page
    Given I am on search <searchTerm> page last of locale <locale> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I store the number of elements Experience.PlpProducts.ListingItems with key #itemIndex
    When in unified PLP I scroll down to the 5 listing item
      And I see Experience.PlpProducts.BackToTopButton is in viewport
      And I click on Experience.PlpProducts.BackToTopButton
      And I wait until Experience.PlpHeader.PageHeader is in viewport
    Then I see Experience.PlpProducts.ListingItems with index 1 is in viewport
    When I scroll down to unified PLP item #itemIndex
    Then I see Experience.PlpProducts.BackToTopButton is in viewport
      And I click on Experience.PlpProducts.BackToTopButton
      And I wait until Experience.PlpHeader.PageHeader is in viewport
      And I see Experience.PlpProducts.ListingItems with index 1 is in viewport

    Examples:
      | locale | searchTerm |
      | uk     | shirts     |