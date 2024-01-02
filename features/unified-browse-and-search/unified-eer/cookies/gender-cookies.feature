Feature: Unified Experience - Gender Cookies

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @Cookies @EER
  @feature:CET1-2612 @UnifiedExperience
  @tms:UTR-13320
  Scenario Outline: Gender cookies - Verify landing on GLP with gender cookies set
    Given I am on locale <locale> <gender> glp page of langCode <langCode> with accepted cookies
    When I navigate to page <page>
      And I am a <userType> user
      And I wait until the current page is loaded
      And I click on Experience.Header.Logo
    Then I see the current page is GLP
      And gender cookies should be set
      And cookie PVH_GLP_GENDER_URL should have parameter secure set to true
      And cookie PVH_GLP_GENDER_URL should have parameter sameSite set to Lax

    @RCTest
    Examples:
      | locale  | langCode | gender | page         | userType  |
      | default | default  | women  | home-page    | logged in |
      | default | default  | men    | shopping-bag | guest     |

    Examples:
      | locale           | langCode         | gender | page          | userType  |
      | multiLangDefault | multiLangDefault | women  | pdp           | logged in |
      | multiLangDefault | multiLangDefault | men    | store-locator | guest     |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Cookies @EER @UnifiedExperience @P2
  @tms:UTR-13321
  Scenario Outline: Gender Cookies - Kids GLP set gender cookies
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
    When I navigate to page <page>
      And I click on Experience.Header.MegaMenuSecondLevelItemsByIndex with index 3
    Then I see the current page is GLP
      And gender cookies <status> set
    When I navigate to page <page>
      And I click on Experience.Header.Logo
    Then I see the current page is <currentPage>
      And gender cookies <status> set

    Examples:
      | locale  | langCode | page | status    | currentPage |
      | default | default  | wlp  | should be | GLP         |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Cookies @EER @UnifiedExperience @P2
  @tms:UTR-13322 @ExcludeTH
  Scenario Outline: Gender Cookies - Verify landing on the GLP after visiting kids GLP with gender cookies set
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
    When I navigate to page <page>
      And in unified megamenu I select 2nd level item with index <index>
    Then I see the current page is GLP
      And I save current url as key #initialGlpUrl
    When I navigate to page <page>
      And in unified megamenu I select 1st level item with index <index>
    Then I wait until the current page is loaded
      And I navigate to page <page>
      And I click on Experience.Header.Logo
    Then I see the current page is GLP
      And gender cookies should be set
      And URL should contain "#initialGlpUrl"

    Examples:
      | locale           | langCode         | index | page         |
      | default          | default          | 1     | wlp          |
      | multiLangDefault | multiLangDefault | 2     | shopping-bag |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Cookies @EER @UnifiedExperience @UnifiedPdp @P2
  @tms:UTR-18802
  Scenario Outline: Gender Cookies - Verify landing on the GLP after visiting PDP from search-plp when gender cookies set
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I wait until page Experience.PlpProducts is loaded
    When I click on Experience.PlpProducts.ProductGridItems with index 1
      And I wait until the current page is loaded
      And I store the value of ProductDetailPage.Header.BreadcrumbsItem with index 1 with key #gender
      And I click on Experience.Header.Logo
    Then I see the current page is GLP
      And gender cookies should be set
      And  URL should contain "#gender"

    Examples:
      | locale  | langCode | page       |
      | default | default  | search-plp |