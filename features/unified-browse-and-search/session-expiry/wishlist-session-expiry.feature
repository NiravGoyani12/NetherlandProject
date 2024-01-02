Feature: Unified WLP - session expiry

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @sessionExpiry @feature:CET1-3668 @P2
  @tms:UTR-13304
  Scenario: Unified Wishlist - Verify that the guest user is able to retain the wlp after guest session expiry
    Given I am on locale <locale> wish list page with 1 product with forced accepted cookies
      And I wait until Experience.Wishlist.ListingItems is displayed
    When I get the callerId from cookie WC_AUTHENTICATION paramater and stored with #callerId key
    Then In DB there should be 1 entry for #callerId in CTXMGMT table
      And In DB I update the last access time by reducing it by 1 day for #callerId in CTXMGMT table
      And I wait for 5 seconds
      And In DB I delete the entry for #callerId in CTXMGMT table
      And I wait for 5 seconds
    Then In DB there should be 0 entry for #callerId in CTXMGMT table
      And I refresh page
      And I wait for 5 seconds
    Then I see Experience.Wishlist.ListingItems is displayed
      And I navigate to page shopping-bag
      And I navigate back in the browser
    Then I see Experience.Wishlist.ListingItems is displayed
    Examples:
      | locale | langCode |
      | ee     | default  |
      | uk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience @P2
  @sessionExpiry @feature:CET1-3668
  @tms:UTR-13305
  Scenario Outline: Unified wishlist - Verfiy that the user is able to select available size from dropdown and able to add to bag and the item still persists after session expiry
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 10 and 99999 filtered by FH
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a guest user
      And I am on locale <locale> wish list page of langCode <langCode> for product styles product1#styleColourPartNumber
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
    When I fetch size name of product item #skuPartNumber saved as #sizeName
    Then I see Experience.Wishlist.DisabledAddToBagButton is displayed
      And in unified wishlist page I select size based on product item #skuPartNumber
    Then I click on Experience.Wishlist.EnabledAddToBagButton
      And I get the callerId from cookie WC_AUTHENTICATION paramater and stored with #callerId key
      And In DB there should be 1 entry for #callerId in CTXMGMT table
      And In DB I update the last access time by reducing it by 1 day for #callerId in CTXMGMT table
      And I wait for 5 seconds
      And In DB I delete the entry for #callerId in CTXMGMT table
      And I wait for 5 seconds
      And In DB there should be 0 entry for #callerId in CTXMGMT table
      And I wait until Experience.Wishlist.EmptyWishlistTitle is not displayed
      And I refresh page
    Then I see Experience.Wishlist.ListingItems is displayed
    When I navigate to page shopping-bag
      And I navigate back in the browser
    Then I see Experience.Wishlist.ListingItems is displayed
    Examples:
      | locale | langCode |
      | ee     | default  |
      | uk     | default  |


  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience @P2
  @RegUserSessionExpiry @sessionExpiry
  @tms:temp 
  Scenario Outline: Unified wishlist - registered user with remembered me - open second tab
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 10 and 99999 filtered by FH
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am on locale <locale> wish list page of langCode <langCode> for product styles product1#styleColourPartNumber
    When I sign in with email testExpiry@test.com and password Test@12345
    Then I check on remember me checkbox
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
    When I fetch size name of product item #skuPartNumber saved as #sizeName
    Then I see Experience.Wishlist.DisabledAddToBagButton is displayed
      And in unified wishlist page I select size based on product item #skuPartNumber
    Then I click on Experience.Wishlist.EnabledAddToBagButton
      And I get the callerId from cookie WC_AUTHENTICATION paramater and stored with #callerId key
      And In DB I update the status to 'T' for #callerId in CTXMGMT table
      And I delete authentication cookies
      And I delete userActivity cookies
      And I open a new browser tab
      And I switch to 2nd browser tab
      And I navigate to page wlp
      And I wait until the current page is loaded
      And In session expiry pop up i sign in with email testExpiry@test.com and password Test@12345 and set rememberme to true
      And I wait for 20 seconds
    Then I see Experience.Wishlist.ListingItems is displayed
    When I navigate to page shopping-bag
      And I navigate back in the browser
    Then I see Experience.Wishlist.ListingItems is displayed

    Examples:
      | locale | langCode |
      | ee     | default  |