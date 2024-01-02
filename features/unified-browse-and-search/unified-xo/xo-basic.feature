Feature: Unified XO - Basic

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @P2
  @UnifiedExperience @UnifiedXo @TEX
  @feature:TEX-15296
  @tms:UTR-14973
  Scenario Outline: Unified XO - Verify that non-default language PDP page is opened when clicking on XO recommendations on non-default language pages
    Given There is 2 <sizeType> size product item of locale <locale> and langCode <langCode> with inventory between 1 and 99999 filtered by FH
    When I am on unified locale <locale> pdp page of langCode <langCode> for product style product2#styleColourPartNumber with forced accepted cookies
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I click on Experience.Recommendations.RecoForYouItem with index 1
      And I see the current page is PDP
      And URL should contain "/<langCode>/"
    When I navigate to page shopping-bag
      And I wait until the current page is loaded
      And I smoothly scroll to the element Experience.Footer.MainBlock
    Then URL should contain "/<langCode>/"
      And I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 15 seconds
    When I scroll to and click on Experience.Recommendations.RecoShoppingBasketItemByIndex with index 1
    Then I see the current page is PDP
      And URL should contain "/<langCode>/"

    Examples:
      | locale | langCode | sizeType |
      | lu     | DE       | normal   |

    @EngTranslation
    Examples:
      | locale | langCode | sizeType |
      | de     | EN       | normal   |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedExperience @UnifiedXo @TEX @XO @P2
  @feature:TEX-15416
  @tms:UTR-17491
  Scenario Outline: Unified XO - Verify markdown discount flag is displayed on XO recommendations
    Given I am on locale <locale> search page of langCode <langCode> with search term "nosearchresult" with forced accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
      And I fetch size name of product item <skuPartNumber> saved as #sizeName
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I see Experience.Recommendations.RecoMakrdownFlag is displayed in 5 seconds
    When I navigate to page pdp
      And I force the url with a xo-widget-id <xoWidgetId>
      And I wait until the current page is loaded
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I see Experience.Recommendations.RecoMakrdownFlag is displayed in 5 seconds
    When I navigate to page shopping-bag
      And I force the url with a xo-widget-id <xoWidgetId>
      And I wait until the current page is loaded
      And I smoothly scroll to the element Experience.Footer.MainBlock
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I see Experience.Recommendations.RecoMakrdownFlag is displayed in 5 seconds

    @ExcludeTH
    Examples:
      | locale  | langCode | skuPartNumber | styleColourPartNumber | xoWidgetId               |
      | default | default  | 8720641066372 | 76J2532ADP670         | 63f6063ed8e91ecc2e348bb1 |

    @ExcludeCK
    Examples:
      | locale  | langCode | skuPartNumber | styleColourPartNumber | xoWidgetId               |
      | default | default  | 8718941982652 | WW0WW11860410         | 63b567c9c466f7573189c3ac |