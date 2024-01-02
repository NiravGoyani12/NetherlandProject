Feature: Unified Tracking - Page - View

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @UnifiedCheckout @P3
  @SignIn
  @tms:UTR-740
  Scenario Outline: checkout - sign in - Validation of the modules version, user, site, page and cart
    Given I am on locale <locale> of langCode <langCode> with 1 products on shipping page
      And I wait until Checkout.SignInPage.ProceedAsGuestButton is displayed in 10 seconds
    When I validate digital data site module with report key #report
      And I validate unified digital data guest user module with allowed unknown attributes with report key #report
      And I validate unified digital data page module on checkout - sign in with following data with report key #report
      """
      {
        "pagePath": "/checkoutsigninview",
        "pageName": "checkout - sign in|checkout>login",
        "pageAlias": "login",
        "pageGender": "not applicable",
        "primaryCategory": "checkout - sign in",
        "primaryCategoryId": "checkout - sign in"
      }
      """
      And I validate digital data cart module with following data with allowed unknown attributes with report key #report
      """
      {
        "checkoutStep": "2"
      }
      """
      And I validate digital data 1st cart item module of style colour partnumber product1#styleColourPartNumber with following data with report key #report
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale | langCode |
      | ie     | default  |