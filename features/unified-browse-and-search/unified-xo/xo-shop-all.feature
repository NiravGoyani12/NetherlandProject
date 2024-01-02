Feature: Unified XO - Shop All

  # The XO widget is configured with Shop all link
  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedExperience @UnifiedXo @TEX @XO @P2
  @feature:TEX-15219
  @tms:UTR-17919
  Scenario Outline: Unified XO - Shop All link - Verify that Shop all link is displayed for XO when link is configured
    Given I am on locale <locale> search page of langCode <langCode> with search term "nosearchresult" with forced accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I see Experience.Recommendations.XoShopAllLink is displayed in 5 seconds
    When I navigate to page pdp
      And I force the url with a xo-widget-id <xoWidgetId>
      And I wait until the current page is loaded
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I see Experience.Recommendations.XoShopAllLink is displayed in 5 seconds
    When I navigate to page shopping-bag
      And I force the url with a xo-widget-id <xoWidgetId>
      And I wait until the current page is loaded
      And I smoothly scroll to the element Experience.Footer.MainBlock
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I see Experience.Recommendations.XoShopAllLink is displayed in 5 seconds
    Then I click on Experience.Recommendations.XoShopAllLink is displayed in 5 seconds
      And I see the current page is PLP

    Examples:
      | locale  | langCode | xoWidgetId               |
      | default | default  | 639ada8b988356b0d5f4cfbf |