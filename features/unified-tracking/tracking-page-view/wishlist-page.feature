Feature: Unified Tracking - Page - View

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @CET1
  @tms:UTR-4436 @issue:CET1-3754
  Scenario Outline: wishlistpage - full - guest or registered user - validation of the modules user, site, page and wishlist
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 10 and 99999 filtered by FH
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> wish list page of langCode <langCode> for product styles product1#styleColourPartNumber
      And I wait until Experience.Wishlist.ProductTileComponent is displayed
    When I validate unified digital data <user> user module with report key #report
      And I validate unified digital data page module on wishlistpage with following data with report key #report
      """
      {
        "pagePath": "/wishlist",
        "pageName": "wishlistpage",
        "pageAlias": "wishlistpage",
        "pageGender": "not applicable",
        "primaryCategory": "wishlistpage",
        "primaryCategoryId": "wishlistpage"
      }
      """
      And I validate unified digital data wishlist module of style colour partnumber product1#styleColourPartNumber with report key #report
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale | langCode | userType  | user       |
      | ee     | default  | logged in | registered |
      | ee     | default  | guest     | guest      |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @CET1
  @tms:UTR-7279 @issue:CET1-3754
  Scenario Outline: wishlistpage - empty - guest or registered user - validation of the modules user, site, page and wishlist
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> wish list page of langCode <langCode>
    When I validate unified digital data <user> user module with report key #report
      And I validate unified digital data page module on wishlistpage with following data with report key #report
      """
      {
        "pagePath": "/wishlist",
        "pageName": "wishlistpage",
        "pageAlias": "wishlistpage",
        "pageGender": "not applicable",
        "primaryCategory": "wishlistpage",
        "primaryCategoryId": "wishlistpage"
      }
      """
      And I validate empty digital data wishlist module with report key #report
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale | langCode | userType  | user       |
      | ee     | default  | logged in | registered |
      | ee     | default  | guest     | guest      |