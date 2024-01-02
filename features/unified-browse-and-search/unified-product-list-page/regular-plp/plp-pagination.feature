Feature: Unified PLP - Pagination

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @PLP @UnifiedPLP @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4297
  @tms:UTR-15335
  Scenario Outline: Unified PLP Pagination - Verify page navigation elements are displayed for categories with more than 48 products
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
      And I save page lastPageNumber for category <categoryId> for locale <locale> as key #pageCount
      And I save page totalItemCount for category <categoryId> for locale <locale> as key #totalItemCount
      And I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpPagination.PreviousButton is displayed
      And I see Experience.PlpPagination.PreviousButton is not clickable
      And I see Experience.PlpPagination.NextButton is displayed
      And I see Experience.PlpPagination.NextButton is clickable

    @ExcludeTH
    Examples:
      | locale  | categoryId           |
      | default | MEN_CLOTHES_T-SHIRTS |

    @ExcludeCK
    Examples:
      | locale  | categoryId              |
      | default | th_women_clothing_jeans |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @PLP @UnifiedPLP @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4297
  @tms:UTR-15336
  Scenario Outline: Unified PLP Pagination - Verify page navigation elements are displayed on second page for categories with more than 48 products
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
      And I save page lastPageNumber for category <categoryId> for locale <locale> as key #pageCount
      And I save page totalItemCount for category <categoryId> for locale <locale> as key #totalItemCount
      And I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    When in unified PLP I click next page button 1 times
    Then I see Experience.PlpPagination.PreviousButton is displayed
      And I see Experience.PlpPagination.PreviousButton is clickable
      And I see Experience.PlpPagination.NextButton is displayed

    @ExcludeTH
    Examples:
      | locale  | categoryId           |
      | default | MEN_CLOTHES_T-SHIRTS |

    @ExcludeCK
    Examples:
      | locale  | categoryId              |
      | default | th_women_clothing_jeans |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @PLP @UnifiedPLP @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4297
  @feature:EESK-4298
  @tms:UTR-15337
  Scenario Outline: Unified PLP Pagination - Verify page numbers displayed are correct for all pages
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
      And I save page lastPageNumber for category <categoryId> for locale <locale> as key #pageCount
      And I save page totalItemCount for category <categoryId> for locale <locale> as key #totalItemCount
    When I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    Then in unified category <categoryId> PLP for locale <locale> I verify page numbers and navigate to last page using buttons

    @ExcludeTH
    Examples:
      | locale  | categoryId           |
      | default | MEN_CLOTHES_T-SHIRTS |

    @ExcludeCK
    Examples:
      | locale  | categoryId              |
      | default | th_women_clothing_jeans |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @PLP @UnifiedPLP @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4297
  @feature:EESK-4298
  @tms:UTR-15338
  Scenario Outline: Unified PLP Pagination - Verify user is able to navigate from last page to first page via buttons
    Given I am on category <categoryId> unified page last of locale <locale> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    Then in unified category <categoryId> PLP for locale <locale> I verify page numbers and navigate to first page using buttons

    @ExcludeTH
    Examples:
      | locale  | categoryId           |
      | default | MEN_CLOTHES_T-SHIRTS |

    @ExcludeCK
    Examples:
      | locale  | categoryId              |
      | default | th_women_clothing_jeans |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @PLP @UnifiedPLP @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4299
  @tms:UTR-15340
  Scenario Outline: Unified PLP Pagination - Verify page count is displayed on first page for categories with more than 36 products
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
      And I save page lastPageNumber for category <categoryId> for locale <locale> as key #pageCount
      And I save page totalItemCount for category <categoryId> for locale <locale> as key #totalItemCount
      And I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpPagination.CurrentPageNumber is displayed
      And I see Experience.PlpPagination.CurrentPageNumber contains text "1"
      And I see Experience.PlpPagination.ViewedOfItems contains text "You've viewed"
      And I see Experience.PlpPagination.ViewedOfItems contains text "items"

    @ExcludeTH
    Examples:
      | locale  | categoryId           |
      | default | MEN_CLOTHES_T-SHIRTS |

    @ExcludeCK
    Examples:
      | locale  | categoryId              |
      | default | th_women_clothing_jeans |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @PLP @UnifiedPLP @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4299
  @tms:UTR-15341
  Scenario Outline: Unified PLP Pagination - Verify page count is displayed on second page for categories with more than 48 products
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
      And I save page lastPageNumber for category <categoryId> for locale <locale> as key #pageCount
      And I save page totalItemCount for category <categoryId> for locale <locale> as key #totalItemCount
      And I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    When in unified PLP I click next page button 1 times
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpPagination.CurrentPageNumber is displayed
      And I see Experience.PlpPagination.CurrentPageNumber contains text "2"
      And I see Experience.PlpPagination.ViewedOfItems contains text "You've viewed"
      And I see Experience.PlpPagination.ViewedOfItems contains text "of"
      And I see Experience.PlpPagination.ViewedOfItems contains text "#totalItemCount"
      And I see Experience.PlpPagination.ViewedOfItems contains text "items"

    @ExcludeTH
    Examples:
      | locale  | categoryId           |
      | default | MEN_CLOTHES_T-SHIRTS |

    @ExcludeCK
    Examples:
      | locale  | categoryId              |
      | default | th_women_clothing_jeans |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @PLP @UnifiedPLP @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4299
  @tms:UTR-15342
  Scenario Outline: Unified PLP Pagination - Verify page count displayed are correct for all pages from first page
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
      And I save page lastPageNumber for category <categoryId> for locale <locale> as key #pageCount
      And I save page totalItemCount for category <categoryId> for locale <locale> as key #totalItemCount
    When I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    Then in unified category <categoryId> PLP for locale <locale> I verify item count and navigate to last page using buttons

    @ExcludeTH
    Examples:
      | locale  | categoryId           |
      | default | MEN_CLOTHES_T-SHIRTS |

    @ExcludeCK
    Examples:
      | locale  | categoryId              |
      | default | th_women_clothing_jeans |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @PLP @UnifiedPLP @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4299
  @tms:UTR-15343
  Scenario Outline: Unified PLP Pagination - Verify page count displayed are correct for all pages from last page
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
      And I save page lastPageNumber for category <categoryId> for locale <locale> as key #pageCount
      And I save page totalItemCount for category <categoryId> for locale <locale> as key #totalItemCount
    When I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    When I navigate to the plp page with page number #pageCount
      And in unified category <categoryId> PLP for locale <locale> I verify item count and navigate to first page using buttons

    @ExcludeCK
    Examples:
      | locale  | categoryId              |
      | default | th_women_clothing_jeans |

    @ExcludeTH
    Examples:
      | locale  | categoryId           |
      | default | MEN_CLOTHES_T-SHIRTS |