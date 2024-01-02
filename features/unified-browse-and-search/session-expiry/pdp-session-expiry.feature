Feature: Unified PDP - session expiry

  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @sessionExpiry @feature:CET1-3668 @P2
  @tms:temp 
  Scenario: Unified PDP - Verify that the guest user is able to stay on PDP after guest session expiry
    Given There is 1 <sizeType> size product item of locale <locale> and langCode <langCode> with inventory between 1 and 9999999 filtered by FH
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I am a guest user
      And I get translation from lokalise for "AddToBagText" and store it with key #AddToBag
    When I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.AddToBagButton with text #AddToBag is displayed
    When I get the callerId from cookie WC_AUTHENTICATION paramater and stored with #callerId key
    Then In DB there should be 1 entry for #callerId in CTXMGMT table
      And In DB I update the last access time by reducing it by 1 day for #callerId in CTXMGMT table
      And I wait for 5 seconds
      And In DB I delete the entry for #callerId in CTXMGMT table
      And I wait for 5 seconds
    Then In DB there should be 0 entry for #callerId in CTXMGMT table
      And I refresh page
    When in unified PDP I select size by sku part number product1#skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And the count of elements Experience.ShoppingBag.Item is equal to 1

    Examples:
      | locale  | langCode | sizeType |
      | default | default  | normal   |

  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience @P2
  @RegUserSessionExpiry @sessionExpiry
  @tms:temp
  Scenario Outline: Unified PDP - registered user with remembered me - should be able to stay on PDP after session expiry
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 10 and 99999 filtered by FH
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page pdp
    When I sign in with email testExpiry@test.com and password Test@12345
    Then I check on remember me checkbox
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
      And I get the callerId from cookie WC_AUTHENTICATION paramater and stored with #callerId key
      And In DB I update the status to 'T' for #callerId in CTXMGMT table
      And I delete authentication cookies
      And I delete userActivity cookies
      And I wait for 20 seconds
      And I refresh page
      And In session expiry pop up i sign in with email testExpiry@test.com and password Test@12345 and set rememberme to true
      And I see the current page is PDP page

    Examples:
      | locale | langCode |
      | ee     | default  |