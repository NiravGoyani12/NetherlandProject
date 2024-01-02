Feature: Unified Tracking - Page - View

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @PDP @TEE @P1
  @tms:UTR-8265
  Scenario Outline: pdp - Guest or registered user - validation of the modules version, user, site, product and page
    Given There is 1 normal size product item of locale <locale> with inventory between 50 and 9999 filtered by FH
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I am a <userType> user
      And I wait until page ProductDetailPage.Pdp is loaded
      And I extract product style detail by style colour part number product1#styleColourPartNumber
    When I validate digital data site module with report key #report
      And I validate unified digital data <user> user module with allowed unknown attributes with report key #report
      And I validate unified digital data pdp product module of style colour partnumber product1#styleColourPartNumber with report key #report
      # TODO: can be included once breadcrumb object path is updated
      # And I validate unified digital data page module on pdp with following data with report key #report
      # """
      # {}
      # """
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale | langCode | userType  | user       |
      | nl     | default  | guest     | guest      |
      | nl     | default  | logged in | registered |