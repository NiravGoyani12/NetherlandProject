Feature: Unified Tracking - Page - View

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData
  @ShoppingBag @CET1 @P1
  @tms:UTR-9990 @issue:EESCK-12667
  Scenario Outline: cart - filled - Guest or registered user - validation of the modules user, site, page, version and  cart
    Given I am on locale <locale> home page with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> shopping bag page with 1 unit of any product
      And I wait until Experience.Header.ShoppingBagCounter contains text "1"
      And I wait until the current page is loaded
    When I validate digital data site module with report key #report
      And I validate unified digital data <user> user module with report key #report
      And I validate unified digital data page module on cart with following data with report key #report
      """
      {
        "pagePath": "/shopping-bag",
        "pageName": "cart|checkout>cart",
        "pageAlias": "cart",
        "pageGender": "not applicable",
        "primaryCategory": "checkout",
        "primaryCategoryId": "checkout"
      }
      """
      And I validate unified digital data version module with report key #report
      And I validate digital data cart module with following data with allowed unknown attributes with report key #report
      """
      {
        "checkoutStep": "1"
      }
      """
      And I validate digital data 1st cart item module of style colour partnumber product1#styleColourPartNumber with following data with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale | userType  | user       |
      | be     | guest     | guest      |
      | be     | logged in | registered |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData
  @ShoppingBag @CET1
  @tms:UTR-4332 @P1
  Scenario Outline: cart - empty - Guest or registered user - validation of the modules user, site, page and cart
    Given I am on locale <locale> home page with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> of url shopping-bag of langCode default
      And I wait until the current page is loaded
    When I validate digital data site module with report key #report
      And I validate unified digital data <user> user module with report key #report
      And I validate unified digital data page module on cart with following data with report key #reportßß
      """
      {
        "pagePath": "/shopping-bag",
        "pageName": "cart|checkout>cart",
        "pageAlias": "cart",
        "pageGender": "not applicable",
        "primaryCategory": "checkout",
        "primaryCategoryId": "checkout"
      }
      """
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale | userType  | user       |
      | be     | guest     | guest      |
      | be     | logged in | registered |
