Feature: Unified PLP - Breadcrumbs

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @Breadcrumbs @EESK @P2
  @feature:EESK-5031
  @tms:UTR-15511
  Scenario Outline: Unified PLP - Verify clicking Home breadcrumb link keeps on chosen langCode in case of multilang
    Given I am on locale <locale> women glp page of langCode <langCode> with accepted cookies
    When  In unified Megamenu I navigate to PLP using text with category Clothes and sub-category Jeans
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.PlpProducts.BreadcrumbItems with text Home
    Then I wait until the current page is glp
      And URL should contain "<multilangUrl>"

    Examples:
      | locale | langCode | multilangUrl |
      | lu     | DE       | de           |
      | nl     | EN       | nl           |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @Breadcrumbs @EESK @P2
  @feature:CET1-135
  @tms:UTR-15950
  Scenario Outline: Unified PLP - Verify clicking 1st breadcrumb link re-directs to GLP
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.PlpProducts.BreadcrumbItems with text Home
    Then I wait until the current page is glp

    @ExcludeTH
    Examples:
      | locale | langCode | categoryId                   |
      | uk     | default  | underwear_women_bras         |
      | uk     | default  | kids_boys_clothes_t-shirts   |
      | uk     | default  | women_newin_onlineexclusives |

    @ExcludeCK
    Examples:
      | locale | langCode | categoryId              |
      | uk     | default  | th_women_clothing_jeans |
      | uk     | default  | th_kids_girls_jeans     |
      | uk     | default  | th_women_collections    |

  @FullRegression
  @Desktop @Mobile @UnifiedTEX
  @Chrome @FireFox @UnifiedPLP @UnifiedExperience
  @PLP @TEX @P2
  @tms:UTR-15432
  Scenario Outline: Unified PLP Navigation - breadcrumbs are displayed
    Given I am on locale <locale> glp page of langCode <langCode> with accepted cookies
      And I ensure unified mega menu is interactable
    When  In unified Megamenu I navigate to PLP using index with category 1 and sub-category 3
      And I see Experience.Breadcrumbs.BreadcrumbNavigationRegion is displayed
    Then I see Experience.Breadcrumbs.BreadcrumbsItem is displayed

    @RCTest
    Examples:
      | locale | langCode |
      | uk     | default  |

  @FullRegression
  @Desktop @Breadcrumbs
  @Chrome @FireFox @SafariPending
  @UnifiedPLP @UnifiedExperience @UnifiedCollectionsPLP @EESK @P2
  @tms:UTR-17145
  Scenario Outline: Unified Collections PLP - Pride - Verify Home breadcrumb takes user to home page from pride PLP
    Given I am on locale <locale> glp page of langCode <langCode> with forced accepted cookies
      And I ensure unified mega menu is interactable
      And In unified Megamenu I navigate to PLP using text with category <megamenuCategory> and sub-category <megamenuLink>
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.PlpProducts.BreadcrumbItems with text Home
    Then I wait until the current page is GLP

    @ExcludeTH
    Examples:
      | locale | langCode | megamenuCategory | megamenuLink |
      | uk     | default  | Collections      | Pride        |