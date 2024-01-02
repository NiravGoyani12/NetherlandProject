Feature: Unified Tracking - Page - View

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @ShippingPage @UnifiedCheckout @P1
  @tms:UTR-741
  Scenario Outline: checkout - address shipment - validation of the modules user, site, page and cart
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
    When I validate digital data site module with report key #report
      And I validate unified digital data <type> user module with allowed unknown attributes with report key #report
      And I validate unified digital data page module on checkout - address shipment with following data with report key #report
      """
      {
        "pagePath": "/ordershippingbillingview",
        "pageName": "checkout - address shipment|checkout>shipping",
        "pageAlias": "shipping",
        "pageGender": "not applicable",
        "primaryCategory": "checkout - address shipment",
        "primaryCategoryId": "checkout - address shipment"
      }
      """
      And I validate digital data cart module with following data with allowed unknown attributes with report key #report
      """
      {
        "checkoutStep": "3"
      }
      """
      And I validate digital data 1st cart item module of style colour partnumber product1#styleColourPartNumber with following data with report key #report
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale | langCode | userType  | type       |
      | hr     | default  | guest     | guest      |
      | hr     | default  | logged in | registered |