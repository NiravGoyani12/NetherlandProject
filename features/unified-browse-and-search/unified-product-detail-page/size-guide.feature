Feature: Unified PDP - Size guide

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @SizeGuide @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13055
  Scenario Outline: SizeGuide - I should see size guide button on product PDP
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I wait for 3 seconds
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "<searchTerm>" in the field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.PlpProducts.ProductGridItems with index 1
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.SizeGuideButton is displayed

    Examples:
      | locale  | langCode | searchTerm   |
      | default | default  | JEANS SHORTS |
      | default | default  | t-shirt      |
      | default | default  | Jeans Skinny |
      | default | default  | Shirt Logo   |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @SizeGuide @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13056 @ExcludeCK
  Scenario Outline: SizeGuide - I should see clicking on size guide button redirects to the gender related size guide page in new tab
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.PlpProducts.ProductGridItems with index 1
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.SizeGuideButton is displayed
    When I click on ProductDetailPage.Pdp.SizeGuideButton
      And I switch to 2nd browser tab
    Then I see URL should contain "<urlValue>"
      And I see ProductDetailPage.Pdp.SizeGuidePageTitle with text "<pageTitle>" is displayed

    Examples:
      | locale | langCode | categoryId                 | urlValue                  | pageTitle |
      | fr     | default  | th_women_clothing_t-shirts | femmes-guide-des-tailles  | FEMMES    |
      | fr     | default  | th_men_shoes               | hommes-guide-des-tailles  | HOMME     |
      | fr     | default  | th_kids_boys_trousers      | enfants-guide-des-tailles | ENFANT    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @SizeGuide @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13056 @ExcludeTH
  Scenario Outline: SizeGuide - I should see clicking on size guide button redirects to the gender related size guide page in new tab
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.PlpProducts.ProductGridItems with index 1 until ProductDetailPage.Pdp.Content is displayed
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.SizeGuideButton is displayed
    When I click on ProductDetailPage.Pdp.SizeGuideButton
      And I switch to 2nd browser tab
    Then I see URL should contain "<urlValue>"
      And I see ProductDetailPage.Pdp.SizeGuidePageTitle with text "<pageTitle>" is displayed

    Examples:
      | locale | langCode | categoryId  | urlValue                  | pageTitle |
      | fr     | default  | women_shoes | femmes-guide-des-tailles  | Femmes    |
      | fr     | default  | kids_shoes  | guide-des-tailles-enfants | Enfants   |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @SizeGuide @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13057 @ExcludeTH
  Scenario Outline: SizeGuide - I should see clicking on size guide button opens a modal with sizeguide for the given gender and category
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.PlpProducts.ProductGridItems with index 1 until ProductDetailPage.Pdp.Content is displayed
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.SizeGuideButton is displayed
    When I click on ProductDetailPage.Pdp.SizeGuideButton
    Then I see ProductDetailPage.Pdp.SizeGuideTableModal is displayed in 5 seconds
      And I see ProductDetailPage.Pdp.SizeGuidePageTitle with text "<pageTitle>" is displayed

    Examples:
      | locale | langCode | categoryId          | pageTitle  |
      | fr     | default  | men_shoes           | Chaussures |
      | fr     | default  | women_clothes_jeans | Jeans      |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @SizeGuide @PDP @TEE @UnifiedPdp @UnifiedExperience @P3
  @tms:UTR-13212
  Scenario Outline: SizeGuide - Verify size guide is not displayed on one size PDP
    Given There is 1 one size product item of locale <locale> with inventory between 10 and 99999
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.SizeGuideButton is not displayed in 5 seconds

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @SizeGuide @PDP @TEE @UnifiedPdp @UnifiedExperience @P3
  @tms:UTR-15092 @ExcludeTH
  Scenario Outline: SizeGuide - Verify images are displayed on how to measure myself section on size guide page
    Given I extract seo url of women_clothes_jeans for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.PlpProducts.ProductGridItems with index 1 until ProductDetailPage.Pdp.Content is displayed
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.SizeGuideButton is displayed in 5 seconds
    When I click on ProductDetailPage.Pdp.SizeGuideButton
    Then I see ProductDetailPage.Pdp.SizeGuideTableModal is displayed in 5 seconds
    When I click on ProductDetailPage.Pdp.HowToMeasureMyselfLink
    Then I see ProductDetailPage.Pdp.HowToContentSection is displayed
      And I see the attribute src of element ProductDetailPage.Pdp.HowToContentSectionImage with value metadata containing "https://eu-images.contentstack.com"

    Examples:
      | locale | langCode |
      | fr     | default  |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari
  @SizeGuide @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-18581 @ExcludeTH
  Scenario Outline: SizeGuide - Verify Product can be added to cart from the size guide modal on CK mobile
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.PlpProducts.ProductGridItems with index 1 until ProductDetailPage.Pdp.Content is displayed
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.SizeGuideButton is displayed
    When I click on ProductDetailPage.Pdp.SizeGuideButton
    Then I see ProductDetailPage.Pdp.SizeGuideTableModal is displayed in 5 seconds
    When in dropdown ProductDetailPage.Pdp.SizeGuideSizeSelectorDropdown I select the option by index "2"
      And I click on ProductDetailPage.Pdp.SizeGuideAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I see ProductDetailPage.Pdp.SizeGuideButton is displayed

    Examples:
      | locale | langCode | categoryId |
      | fr     | default  | men_shoes  |
