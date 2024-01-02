Feature: Unified Search PLP - Breadcrumbs

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @Breadcrumbs @EESK @P2
  @feature:CET1-135
  @tms:UTR-15830
  Scenario Outline: Unified Search PLP - Verify breadcrumbs do not exist on unified search PLP
    Given I am on locale <locale> glp page of langCode <langCode> with accepted cookies
    When I navigate to page search-plp
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpProducts.BreadcrumbItems is not existing

    Examples:
      | locale     | langCode   |
      | ee         | default    |
