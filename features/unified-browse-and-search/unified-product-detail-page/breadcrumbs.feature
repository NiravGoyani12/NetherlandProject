Feature: Unified PDP - Breadcrumbs

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5128
  Scenario Outline: Breadcrumbs - Verify clicking on breadcrumb items redirect to correct pages
    Given There are 5 normal size product style of locale <locale> and langCode <langCode> with inventory between 50 and 9999
    When I am on locale <locale> pdp page for product style product3#styleColourPartNumber with accepted cookies
      And I click on ProductDetailPage.Header.BreadcrumbsItem with index <index>
    Then I see the current page is <page>

    Examples:
      | locale  | langCode | index | page |
      | default | default  | 3     | PLP  |
      | default | default  | 2     | PLP  |
      | default | default  | 1     | GLP  |

    Examples:
      | locale           | langCode | index | page |
      | multiLangDefault | default  | 3     | PLP  |
      | multiLangDefault | default  | 2     | PLP  |
      | multiLangDefault | default  | 1     | GLP  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5130
  Scenario Outline: Breadcrumbs - Verify clicking on breadcrumb items for a special PDP direct to correct pages
    Given I am on locale <locale> pdp page for product style UW0UW03804C7H/000QF5149E001 with accepted cookies
    When I scroll to and click on ProductDetailPage.Header.BreadcrumbsItem with index <index>
    Then I see the current page is <page>

    Examples:
      | locale  | index | page |
      | default | 4     | PLP  |
      | default | 3     | PLP  |
      | default | 2     | PLP  |
      | default | 1     | GLP  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5127
  Scenario Outline: Breadcrumbs - Verify clicking on breadcrumb items direct to GLP with gender cookie
    Given There are 3 normal size product style of locale <locale> with inventory between 50 and 99999
      And I am on locale <locale> pdp page for product style product3#styleColourPartNumber with accepted cookies
    When I scroll to and click on ProductDetailPage.Header.BreadcrumbsItem with index 3
      And I navigate back in the browser
      And gender cookies should be set
      And I click on ProductDetailPage.Header.BreadcrumbsItem with index 1
    Then I see the current page is <page>

    Examples:
      | locale  | page |
      | default | GLP  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5126
  Scenario Outline: Breadcrumbs - Verify breadcrumbs items redirect to correct pages and can navigate back to correct PDP
    Given There are 3 multi colour product with at least 3 colours of locale <locale> with inventory between 1 and 1000 filtered by FH
      And I extract product style from product product2#stylePartNumber with index 0 saved as #styleColourPartNumber1
    When I am on locale <locale> pdp page for product style #styleColourPartNumber1 with forced accepted cookies
      And I save current url as key #pdpUrl
      And I click on ProductDetailPage.Header.BreadcrumbsItem with index <index>
    Then I see the current page is <page>
    When I navigate back in the browser
    Then URL should contain "#pdpUrl"
      And I see ProductDetailPage.Pdp.Content is displayed

    Examples:
      | locale  | index | page |
      | default | 3     | PLP  |
      | default | 2     | PLP  |
      | default | 1     | GLP  |
