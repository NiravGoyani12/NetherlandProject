Feature: Unified Tracking - Page - View

@FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @CET1 @P1 @tms:UTR-6848 @issue:EESK-4837 @FixedEvent
  Scenario Outline: plp - Guest or registered user with empty wishlist - validation of the modules user, site, page, wishlist and product
      Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 10 and 99999
      And I am on category <categoryId> page of locale <locale> of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I wait until page Experience.PlpProducts is loaded
      When I validate digital data site module with report key #report
      And I validate unified digital data <user> plp user module with report key #report
      And I validate unified digital data page module on plp with following data with report key #report
      """
      {
        "pageAlias": "category"
      }
      """
      And I validate digital data version module with report key #report
      Then I execute all digital data validation with report key #report
  
  @ExcludeTH
    Examples:
      | locale | langCode | userType  | user       | categoryId |
      | ee     | default  | logged in | registered |MEN_CLOTHES_T-SHIRTS |
      | ee     | default  | guest     | guest      |MEN_CLOTHES_T-SHIRTS |
  
  @ExcludeCK
    Examples:
      | locale | langCode | userType  | user       | categoryId |
      | ee     | default  | logged in | registered |th_women_clothing_jeans |
      | ee     | default  | guest     | guest      |th_women_clothing_jeans |

#@FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @CET1 @P1 @tms:UTR-6848 @FixedEvent
  Scenario Outline: plp - Guest or registered user with wishlist item selected - validation of the modules user, site, page, wishlist, cart and product
      Given There is 1 discounted product item of locale <locale> with inventory between 10 and 99999
      And I am on category <categoryId> page of locale <locale> of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> wish list page for product style product1#styleColourPartNumber
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
      And I see Experience.Wishlist.DisabledAddToBagButton is displayed
      And in unified wishlist page I select size based on product item #skuPartNumber
      And I click on Experience.Wishlist.EnabledAddToBagButton
      And I am on category <categoryId> page of locale <locale> of langCode <langCode>
      And I wait until page Experience.PlpProducts is loaded
      When I validate digital data site module with report key #report
      And I validate unified digital data <user> plp user module with report key #report
      And I validate unified digital data page module on plp with following data with report key #report
      """
      {
        "pageAlias": "category"
      }
      """
      And I validate digital data version module with report key #report
      And I validate digital data cart module with following data with allowed unknown attributes with report key #report
      """
      {}
      """
      Then I execute all digital data validation with report key #report
  
  @ExcludeTH
    Examples:
      | locale | langCode | userType  | user       | categoryId |
      | ee     | default  | logged in | registered |women_clothes_t-shirts |
      | ee     | default  | guest     | guest      |women_clothes_t-shirts |
  
  @ExcludeCK
    Examples:
      | locale | langCode | userType  | user       | categoryId |
      | ee     | default  | logged in | registered |th_women_clothing_jeans |
      | ee     | default  | guest     | guest      |th_women_clothing_jeans |
