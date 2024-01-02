Feature: Unified PLP - Category Navigation - More For You Link

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedPLP @UnifiedExperience @CategoryNavigation @EESK @P2
  @tms:UTR-16316
  Scenario Outline: Unified PLP Category Navigation Desktop - Verify category navigation elements and structure on Unified PLP
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I wait until Experience.PlpHeader.CategoryNavigationBlock is displayed in 15 seconds
      And I scroll to the element Experience.PlpHeader.CategoryNavigationBlock
      And I hover over Experience.Header.Logo
    Then the count of elements Experience.PlpHeader.CategoryNavigationItem is greater than 0

    @ExcludeTH
    Examples:
      | locale           | langCode         | categoryId               |
      | default          | default          | underwear_women_bras     |
      | multiLangDefault | multiLangDefault | men_clothes_jacketscoats |

    @ExcludeCK
    Examples:
      | locale           | langCode | categoryId                    |
      | default          | default  | th_women_collections          |
      | multiLangDefault | default  | th_women_bagsaccessories_bags |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox
  @UnifiedPLP @UnifiedExperience @CategoryNavigation @EESK @P2
  @tms:UTR-16317
  Scenario Outline: Unified PLP Category Navigation - User can navigate to different Unified PLP using more For you links
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I store the value of Experience.PlpHeader.PageHeader with key #initialPlpHeader
      And I wait until Experience.PlpHeader.CategoryNavigationBlock is displayed in 15 seconds
      And I scroll to the element Experience.PlpHeader.CategoryNavigationBlock
      And I hover over Experience.Header.Logo
      And I store the value of <itemToClick> with index <itemIndex> with key #newPlpHeader
      And I click on <itemToClick> with index <itemIndex>
      And I wait until page Experience.PlpProducts is loaded
    Then the value of Experience.PlpHeader.PageHeader should be equal to the stored value with key #newPlpHeader
      And the value of Experience.PlpHeader.PageHeader should not be equal to the stored value with key #initialPlpHeader

    @ExcludeTH
    Examples:
      | locale | langCode | itemToClick                                 | itemIndex | categoryId                        |
      | uk     | default  | Experience.PlpHeader.CategoryNavigationItem | 1         | men_clothes_jacketscoats          |
      | uk     | default  | Experience.PlpHeader.CategoryNavigationItem | last()    | kids_boys_clothes_trousers&shorts |

    @ExcludeCK
    Examples:
      | locale | langCode | itemToClick                                 | itemIndex | categoryId                    |
      | uk     | default  | Experience.PlpHeader.CategoryNavigationItem | 2         | th_women_bagsaccessories_bags |
      | uk     | default  | Experience.PlpHeader.CategoryNavigationItem | 1         | th_kids_girls_jeans           |

  @FullRegression
  @Mobile
  @Chrome @SafariPending
  @UnifiedPLP @UnifiedExperience @CategoryNavigation @EESK @P2
  @tms:UTR-16318
  Scenario Outline: Unified PLP Category Navigation Mobile - User can navigate to different Unified PLP
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I store the value of Experience.PlpHeader.PageHeader with key #initialPlpHeader
      And I store the value of Experience.PlpHeader.CategoryNavigationItem with index <itemIndex> with key #newPlpHeader
      And I click on Experience.PlpHeader.CategoryNavigationItem with index <itemIndex>
      And I wait until page Experience.PlpProducts is loaded
    Then the value of Experience.PlpHeader.PageHeader should be equal to the stored value with key #newPlpHeader
      And the value of Experience.PlpHeader.PageHeader should not be equal to the stored value with key #initialPlpHeader

    @ExcludeTH
    Examples:
      | locale | langCode | itemIndex | categoryId               |
      | uk     | default  | 1         | men_clothes_jacketscoats |

    @ExcludeCK
    Examples:
      | locale | langCode | itemIndex | categoryId                    |
      | uk     | default  | 1         | th_women_bagsaccessories_bags |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedPLP @UnifiedExperience @CategoryNavigation @EESK @P2
  @tms:UTR-16320
  Scenario Outline: Unified PLP Category Navigation Desktop - Verify category navigation changes when navigating to different PLP (via category navigation link)
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I store the value of Experience.PlpHeader.PageHeader with key #initialPlpHeader
      And I wait until Experience.PlpHeader.CategoryNavigationBlock is displayed in 10 seconds
      And I store the value of Experience.PlpHeader.CategoryNavigationBlock with key #categoryNavigationText
      And I scroll to the element Experience.PlpHeader.CategoryNavigationBlock
      And I hover over Experience.Header.Logo
      And I store the value of <itemToClick> with index 2 with key #newPlpHeader
      And I click on <itemToClick> with index 2
      And I wait until page Experience.PlpProducts is loaded
    Then the value of Experience.PlpHeader.PageHeader should be equal to the stored value with key #newPlpHeader
      And the value of Experience.PlpHeader.PageHeader should not be equal to the stored value with key #initialPlpHeader
      And the value of Experience.PlpHeader.CategoryNavigationBlock should not be equal to the stored value with key #categoryNavigationText

    @ExcludeTH
    Examples:
      | locale | langCode | itemToClick                                 | categoryId      |
      | uk     | default  | Experience.PlpHeader.CategoryNavigationItem | men_bestsellers |

    @ExcludeCK
    Examples:
      | locale | langCode | itemToClick                                 | categoryId              |
      | uk     | default  | Experience.PlpHeader.CategoryNavigationItem | th_women_clothing_jeans |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedPLP @UnifiedExperience @UnifiedCollectionsPLP @CategoryNavigation @EESK @P2
  @tms:UTR-16791
  Scenario Outline: Unified Collections PLP - Category Navigation Desktop - Verify category navigation changes when navigating to different PLP (via category navigation link)
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I store the value of Experience.PlpHeader.PageHeader with key #initialPlpHeader
      And I wait until Experience.PlpHeader.CategoryNavigationBlock is displayed in 10 seconds
      And I store the value of Experience.PlpHeader.CategoryNavigationBlock with key #categoryNavigationText
      And I scroll to the element Experience.PlpHeader.CategoryNavigationBlock
      And I hover over Experience.Header.Logo
      And I store the value of <itemToClick> with index 1 with key #newPlpHeader
      And I click on <itemToClick> with index 1
      And I wait until page Experience.PlpProducts is loaded
    Then the value of Experience.PlpHeader.PageHeader should be equal to the stored value with key #newPlpHeader
      And the value of Experience.PlpHeader.PageHeader should not be equal to the stored value with key #initialPlpHeader

    @ExcludeTH
    Examples:
      | locale | langCode | itemToClick                                 | categoryId      |
      | uk     | default  | Experience.PlpHeader.CategoryNavigationItem | men_bestsellers |

    @ExcludeCK
    Examples:
      | locale | langCode | categoryId                    | itemToClick                                 |
      | uk     | default  | th_women_bagsaccessories_bags | Experience.PlpHeader.CategoryNavigationItem |