Feature: Unified Tracking - Page - View

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @EER
  @tms:UTR-9738
  Scenario Outline: contactuspage - Guest or registered user - validation of the modules user, site, page and version
    Given I am on locale <locale> of url contactus of langCode <langCode> with accepted cookies
      And I wait until the current page is loaded
      And I am a <userType> user
    When I validate digital data site module with report key #report
      And I validate unified digital data <user> user module with allowed unknown attributes with report key #report
      And I validate unified digital data page module on contactuspage with following data with report key #report
      """
      {
        "pagePath": "/contactus",
        "pageName": "customerservice|customerservice",
        "pageAlias": "customer service",
        "pageGender": "not applicable",
        "primaryCategory": "cs_contactform",
        "primaryCategoryId": "cs_contactform"
      }
      """
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale | langCode | userType  | user       |
      | ee     | default  | guest     | guest      |
      | ee     | default  | logged in | registered |
      