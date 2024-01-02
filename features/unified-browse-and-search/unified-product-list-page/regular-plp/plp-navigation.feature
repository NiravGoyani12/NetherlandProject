Feature: Unified PLP and Search PLP - Navigation

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @PlpNavigation @EESK @P2
  @feature:EESK-3964
  @tms:UTR-15344
  Scenario Outline: Unified PLP Navigation - Validate page number when navigating to Category PLP from E-mail URL re-direct
    Given I am on locale <locale> of url /mens-underwear?utm_source=Newsletter&utm_medium=email&utm_term=Omni_Newsletter_PanEuropean_en-GB_Platinum_ProductStory_Men_213560__&utm_campaign=FW22_20221003_CKU_Global_Casual_M_Romelu_&cmpid=ch:email|dp:Omni|so:Newsletter|pi:PanEuropean|cp:FW22_20221003_CKU_Global_Casual_M_Romelu_|lb:Platinum|ca:ProductStory|ts:Men|cr:|mt:213560|sl:&CIN=CK12689458&sid=287419718&sfmc_id=287419718 with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    When I scroll to the element Experience.PlpProducts.PlpCurrentPageNum
    Then the numeric value of Experience.PlpProducts.PlpCurrentPageNum is equal to 1

    Examples:
      | locale |
      | ee     |

    @ExcludeUat
    Examples:
      | locale |
      | uk     |

  @FullRegression @RCTest
  @Desktop @P2
  @Chrome @FireFox @Safari @UnifiedTEX
  @PLP @PlpNavigation @TEX @UnifiedPLP @UnifiedExperience
  @tms:UTR-15433
  Scenario Outline: Unified PLP Navigation - Megamenu - Validate page and url when navigating back from PDP to PLP
    Given I am on locale <locale> women glp page of langCode <langCode> with accepted cookies
    When I navigate to page plp
      And I wait until the current page is loaded
      And I save current url without trailing slash as key #firstPlpUrl
      And I ensure unified mega menu is interactable
    Then the count of displayed elements Experience.Header.MegaMenuFirstLevelItems is equal to 3
    When In unified Megamenu I navigate to PLP using index with category 3 and sub-category 4
      And I wait until the current page is loaded
    Then I see the current page is PLP
    Then I see Experience.Breadcrumbs.CatalogHead is displayed
      And I store the value of Experience.Breadcrumbs.CatalogHead with key #plpTitle
      And I save current url without trailing slash as key #secondPlpUrl
    When I click on Experience.PlpProducts.ListingItems with index 1
      And I wait until the current page is pdp
      And I navigate back in the browser
      And I wait until the current page is PLP
      And I wait until the current page is loaded
    Then URL should contain "#secondPlpUrl"
      And URL should not contain "#firstPlpUrl"
      And I see Experience.Breadcrumbs.CatalogHead contains text "#plpTitle"

    Examples:
      | locale | langCode |
      | uk     | default  |

  #TODO Need to set FH rule
  # @FullRegression
  # @Desktop @Mobile
  # @Chrome @FireFox @Safari
  # @PLP @TEX @P3
  # @tms:UTR-4068
  # Scenario Outline: I can see parent category if child category has no products in response [FH rule has been configured to get no result]
  #   Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
  #   When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
  #     And I wait until page Plp is loaded
  #   Then URL should contain "<parentCategory>"

  #   Examples:
  #     | locale           | langCode         | categoryId                               | parentCategory        |
  #     | default          | default          | th_men_bagsaccessories_tiespocketsquares | mens-bags-accessories |
  #     | multiLangDefault | multiLangDefault | th_men_bagsaccessories_tiespocketsquares | mens-bags-accessories |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @PlpNavigation @EESK @P2
  @tms:UTR-16837
  Scenario Outline: Unified PLP Navigation - Validate page number when navigating from Category PLP to Search PLP
    Given I am on category <categoryId> page of locale <locale> of langCode default with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type Size and select M as filter option
      And I wait until page Experience.PlpProducts is loaded
    When in unified PLP I click next page button
    Then I am on locale <locale> search page with search term "jeans"
      And I wait until page Experience.PlpProducts is loaded
      And I scroll to the element Experience.PlpProducts.PlpCurrentPageNum
      And I see Experience.PlpProducts.PlpCurrentPageNum contains text "1"
      And URL should not contain "scrollPage"
    When in unified PLP I click next page button
      And I wait until page Experience.PlpProducts is loaded
      And I scroll to the element Experience.PlpProducts.PlpCurrentPageNum
      And I see Experience.PlpProducts.PlpCurrentPageNum contains text "2"
      And URL should contain "page=2"

    @ExcludeTH
    Examples:
      | locale | categoryId             |
      | uk     | women_clothes_t-shirts |

    @ExcludeCK
    Examples:
      | locale | categoryId             |
      | uk     | th_men_clothing_shirts |

  # @FullRegression @RCTest
  # @Desktop
  # @Chrome @FireFox @Safari
  # @UnifiedPLP @UnifiedExperience @PlpNavigation @EESK @P2
  # @tms:UTR-16838
  # Scenario Outline: Unified PLP Navigation - Validate page number and URLs when navigating from Search PLP to Search PLP
  #   Given I am on locale <locale> search page with search term "shirts" with accepted cookies
  #     And I wait until page Experience.PlpProducts is loaded
  #   When in filter panel I open filter type Size and select M as filter option
  #     And I wait until page Experience.PlpProducts is loaded
  #   Then in unified PLP I click next page button
  #     And I ensure unified mega menu is interactable
  #     And I click on Experience.Header.UnifiedSearchContainer
  #     And I clear text field of element Experience.Header.UnifiedSearchField
  #     And I click on Experience.Header.UnifiedSearchContainer
  #     And I type "Jeans" in the field Experience.Header.UnifiedSearchField
  #   When I click on Experience.Header.SearchIcon
  #     And I wait until page Experience.PlpProducts is loaded
  #   Then I scroll to the element Experience.PlpProducts.PlpCurrentPageNum
  #     And I see Experience.PlpProducts.PlpCurrentPageNum contains text "1"
  #     And URL should not contain "scrollPage"
  #     And URL should contain "jeans"
  #     And URL should not contain "shirts"
  #   When in unified PLP I click next page button
  #     And I wait until page Experience.PlpProducts is loaded
  #   Then I scroll to the element Experience.PlpProducts.PlpCurrentPageNum
  #     And I see Experience.PlpProducts.PlpCurrentPageNum contains text "2"
  #     And URL should contain "scrollPage=2"
  #     And URL should contain "jeans"
  #     And URL should not contain "shirts"

  #   Examples:
  #     | locale |
  #     | ee     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedCollectionsPLP @PlpNavigation @EESK @P2
  @tms:UTR-16815
  Scenario Outline: Unified Collections and Kids PLP Navigation - Validate page number and URLs when navigating from Collections PLP to Category PLP
    Given I extract seo url of <categoryId1> for locale <locale> of langCode <langCode> saved as #categoryUrl1
      And I extract seo url of <categoryId2> for locale <locale> of langCode <langCode> saved as #categoryUrl2
    When I am on category <categoryId1> page of locale <locale> of langCode <langCode> with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
      And I wait until page Experience.PlpProducts is loaded
    When in unified PLP I click next page button
      And I ensure unified mega menu is interactable
    Then in unified megamenu I select 1st level item with index 1
      And In unified Megamenu I navigate to PLP using text with category <megamenuCategory> and sub-category <megamenuLink> with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I scroll to the element Experience.PlpProducts.PlpCurrentPageNum
      And I see Experience.PlpProducts.PlpCurrentPageNum contains text "1"
      And URL should not contain "scrollPage"
    When in unified PLP I click next page button
      And I wait until page Experience.PlpProducts is loaded
      And I scroll to the element Experience.PlpProducts.PlpCurrentPageNum
      And I see Experience.PlpProducts.PlpCurrentPageNum contains text "2"
      And URL should contain "page=2"

    @ExcludeTH
    Examples:
      | locale | langCode | categoryId1     | categoryId2          | megamenuLink | megamenuCategory | filterType | filterOption |
      | uk     | default  | kids_clothes    | underwear_women_bras | Bras         | Underwear        | Size       | 8            |

    @ExcludeCK
    Examples:
      | locale | langCode | categoryId1            | categoryId2             | megamenuLink | megamenuCategory | filterType | filterOption |
      | uk     | default  | th_men_clothing_shirts | th_women_clothing_jeans | Essentials   | Collections      | Colour     | Blue         | 