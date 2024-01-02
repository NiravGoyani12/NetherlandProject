Feature: Unified Tracking - Page - View

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @EER
  @tms:UTR-1854 @issue:EER-10603
  Scenario Outline: storelocatorpage - Guest or registered user - validation of modules user, site and page
    Given I am on locale <locale> of url store-locator of langCode <langCode> with accepted cookies
      And I am a <user> user
      And I wait until the current page is loaded
    When I validate digital data site module with report key #report
      And I validate unified digital data <userType> user module with allowed unknown attributes with report key #report
      And I validate unified digital data page module on store locator with following data with report key #report
      """
      {
        "pagePath": "/store-locator",
        "pageName": "storelocatorpage|>",
        "pageAlias": "store locator",
        "pageGender": "not applicable",
        "primaryCategory": "store locator",
        "primaryCategoryId": "store locator"
      }
      """
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale  | langCode | user      | userType   |
      | default | default  | guest     | guest      |
      | default | default  | logged in | registered |
      | ch      | FR       | guest     | guest      |
      | ch      | FR       | logged in | registered |
