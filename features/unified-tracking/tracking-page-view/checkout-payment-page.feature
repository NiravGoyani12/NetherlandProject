Feature: Unified Tracking - Page - View

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @PaymentPage @UnifiedCheckout @P1
  @tms:UTR-867
  Scenario Outline: checkout - payment - validation of the modules version, user, site, page and cart
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I validate digital data site module with report key #report
      And I validate unified digital data <type> user module with report key #report
      And I validate unified digital data page module on checkout - payment with following data with report key #report
      """
      {
        "pagePath": "/orderpaymentdetailsview",
        "pageName": "checkout - payment|checkout>billing",
        "pageAlias": "billing",
        "pageGender": "not applicable",
        "primaryCategory": "checkout - payment",
        "primaryCategoryId": "checkout - payment"
      }
      """
      And I validate digital data cart module with following data with allowed unknown attributes with report key #report
      """
      {
        "checkoutStep": "4"
      }
      """
      And I validate digital data 1st cart item module of style colour partnumber product1#styleColourPartNumber with following data with report key #report
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale | langCode | userType  | type       | address |
      | ee     | default  | guest     | guest      | first   |
      | ee     | default  | logged in | registered | other   |