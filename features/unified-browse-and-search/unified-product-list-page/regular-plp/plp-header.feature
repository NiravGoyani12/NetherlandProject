Feature: Unified PLP - Header

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @PLP @UnifiedPLP @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4295
  @tms:UTR-15350
  Scenario Outline: Unified PLP Header - Verify item count changes when filter is removed
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
      And I save page lastPageNumber for category <categoryId> for locale <locale> as key #pageCount
      And I save page totalItemCount for category <categoryId> for locale <locale> as key #totalItemCount
      And I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type Colour and select Black as filter option
    When in unified filter panel I open filter type Colour and deselect Black as filter option
    Then I see Experience.PlpHeader.ProductCount is displayed
      And I see Experience.PlpHeader.ProductCount contains text "#totalItemCount"
      And I see Experience.PlpHeader.ProductCount contains text "items"

    @ExcludeTH
    Examples:
      | locale  | categoryId           |
      | default | MEN_CLOTHES_T-SHIRTS |

    @ExcludeCK
    Examples:
      | locale  | categoryId                   |
      | default | TH_MEN_CLOTHING_COATSJACKETS |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @PLP @UnifiedPLP @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4295
  @tms:UTR-15347
  Scenario Outline: Unified PLP Header - Verify item count is displayed for categories with more than 48 products
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
      And I save page lastPageNumber for category <categoryId> for locale <locale> as key #pageCount
      And I save page totalItemCount for category <categoryId> for locale <locale> as key #totalItemCount
      And I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpHeader.ProductCount is displayed
      And I see Experience.PlpHeader.ProductCount contains text "#totalItemCount"
      And I see Experience.PlpHeader.ProductCount contains text "items"

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
  @PLP @UnifiedPLP @UnifiedExperience @EESK @UnifiedExperience @P1
  @feature:EESK-4295
  @tms:UTR-15348
  Scenario Outline: Unified PLP Header - Verify item count is displayed through different pages
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
      And I save page lastPageNumber for category <categoryId> for locale <locale> as key #pageCount
      And I save page totalItemCount for category <categoryId> for locale <locale> as key #totalItemCount
      And I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    When in unified PLP I click next page button 1 times
    Then I see Experience.PlpHeader.ProductCount is displayed
      And I see Experience.PlpHeader.ProductCount contains text "#totalItemCount"
      And I see Experience.PlpHeader.ProductCount contains text "items"

    @ExcludeTH
    Examples:
      | locale  | categoryId           |
      | default | MEN_CLOTHES_T-SHIRTS |

    @ExcludeCK
    Examples:
      | locale  | categoryId              |
      | default | th_women_clothing_jeans |