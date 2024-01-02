Feature: Unified Tracking - Page - View

  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @EER
  @tms:UTR-9832
  Scenario Outline: customerservice - FAQ page - Guest or registered user - validation of the modules user, site, page and version
    Given I am on locale <locale> of url /faqs with accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
    When I validate digital data site module with report key #report
      And I validate unified digital data <user> user module with allowed unknown attributes with report key #report
      And I validate unified digital data page module on customerservice with following data with report key #report
      """
      {
        "pageName": "customerservice|>faqs",
        "pageAlias": "customerservice",
        "pageGender": "not applicable",
        "primaryCategory": "faqs",
        "primaryCategoryId": "faqs"
      }
      """
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale | langCode | userType  | user       |
      | ee     | default  | guest     | guest      |
      | ee     | default  | logged in | registered |