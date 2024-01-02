Feature: Unified Shopping Bag - Guest session expiry

  #TODO: to reactivate once root cause for failure to update in the DB is found
  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @CET1 @UnifiedCheckout
  @sessionExpiry
  Scenario: Unified Shopping Bag - Verify that the guest user is able to retain the shopping bag and edit items after guest session expiry with ManagementCentre
    Given There is 1 normal size product items of locale <locale> with inventory between 800 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I refresh page
    Then the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.ItemAtrribute with text Colour is displayed
      And I see Experience.ShoppingBag.ItemAtrribute with text Size is displayed
      And I see Experience.ShoppingBag.ItemAtrribute with text Quantity is displayed
      And I see Experience.ShoppingBag.RemoveButton is displayed
      And I see Experience.ShoppingBag.EditProductButton is displayed
    When I get the callerId from cookie WC_AUTHENTICATION paramater and stored with #callerId key
    Then In DB there should be 1 entry for #callerId in CTXMGMT table
      And In DB I update the last access time by reducing it by 1 day for #callerId in CTXMGMT table
      And I wait for 5 seconds
      And I open a new browser tab
      And I switch to 2nd browser tab
    Then I login in to management centre with username "wcsadmin", password "wcsadm3n" and run job "ActivityCleanUp" in system admin task "Scheduler"
    Then I wait until ManagementCentre.successMessageBar is displayed in 5 seconds
      And I wait for 5 seconds
    Then In DB there should be 0 entry for #callerId in CTXMGMT table
      And I switch to 1st browser tab
      And I refresh page
    Then the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.ItemAtrribute with text Colour is displayed
      And I see Experience.ShoppingBag.ItemAtrribute with text Size is displayed
      And I see Experience.ShoppingBag.ItemAtrribute with text Quantity is displayed
      And I see Experience.ShoppingBag.RemoveButton is displayed
      And I see Experience.ShoppingBag.EditProductButton is displayed
      And I navigate to page wlp
      And I navigate back in the browser
      And I see Experience.ShoppingBag.ItemAtrribute with text Colour is displayed
      And I see Experience.ShoppingBag.ItemAtrribute with text Size is displayed
    When I click on Experience.ShoppingBag.EditProductButton with args product1#skuPartNumber
    Then in page Experience.ShoppingBag edit size dropdown of product item product1#skuPartNumber has correct default value
      And in page Experience.ShoppingBag edit size dropdown of product item product1#skuPartNumber I select a instock size saved as #size into product item #newSku
      And in page Experience.ShoppingBag edit quantity dropdown of product item product1#skuPartNumber I select the highest instock quantity saved as #quantity
      And in page Experience.ShoppingBag edit size dropdown of product item product1#skuPartNumber has correct sizes
    When I click on Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber
    Then I see Experience.ShoppingBag.EditProductButton with args #newSku is displayed
      And I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 2 contains text "#size"
      And I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 3 contains text "#quantity"
      And I click on Experience.ShoppingBag.StartCheckoutButton
    Then URL should contain "checkout/shipping" in 15 seconds

    @tms:UTR-13302
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16445
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @CET1 @UnifiedCheckout
  @sessionExpiry
  Scenario: Unified Shopping Bag - Verify that the guest user is able to retain the shopping bag and edit items after guest session expiry without ManagementCentre
    Given There is 1 normal size product items of locale <locale> with inventory between 800 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I refresh page
    Then the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.ItemAtrribute with text Colour is displayed
      And I see Experience.ShoppingBag.ItemAtrribute with text Size is displayed
      And I see Experience.ShoppingBag.ItemAtrribute with text Quantity is displayed
      And I see Experience.ShoppingBag.RemoveButton is displayed
      And I see Experience.ShoppingBag.EditProductButton is displayed
    When I get the callerId from cookie WC_AUTHENTICATION paramater and stored with #callerId key
    Then In DB there should be 1 entry for #callerId in CTXMGMT table
      And In DB I update the last access time by reducing it by 1 day for #callerId in CTXMGMT table
      And I wait for 5 seconds
      And In DB I delete the entry for #callerId in CTXMGMT table
      And I wait for 5 seconds
    Then In DB there should be 0 entry for #callerId in CTXMGMT table
      And I switch to 1st browser tab
      And I refresh page
    Then the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.ItemAtrribute with text Colour is displayed
      And I see Experience.ShoppingBag.ItemAtrribute with text Size is displayed
      And I see Experience.ShoppingBag.ItemAtrribute with text Quantity is displayed
      And I see Experience.ShoppingBag.RemoveButton is displayed
      And I see Experience.ShoppingBag.EditProductButton is displayed
      And I navigate to page wlp
      And I navigate back in the browser
      And I see Experience.ShoppingBag.ItemAtrribute with text Colour is displayed
      And I see Experience.ShoppingBag.ItemAtrribute with text Size is displayed
    When I click on Experience.ShoppingBag.EditProductButton with args product1#skuPartNumber
    Then in page Experience.ShoppingBag edit size dropdown of product item product1#skuPartNumber has correct default value
      And in page Experience.ShoppingBag edit size dropdown of product item product1#skuPartNumber I select a instock size saved as #size into product item #newSku
      And in page Experience.ShoppingBag edit quantity dropdown of product item product1#skuPartNumber I select the highest instock quantity saved as #quantity
      And in page Experience.ShoppingBag edit size dropdown of product item product1#skuPartNumber has correct sizes
    When I click on Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber
    Then I see Experience.ShoppingBag.EditProductButton with args #newSku is displayed
      And I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 2 contains text "#size"
      And I see Experience.ShoppingBag.ItemDetailsValueByIndex with index 3 contains text "#quantity"
      And I click on Experience.ShoppingBag.StartCheckoutButton
    Then URL should contain "checkout/shipping" in 15 seconds

    @tms:UTR-16444
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16446
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @CET1 @UnifiedCheckout @sessionExpiry 
  Scenario Outline: Unified PDP - registered user with remembered me - should be able to stay on PDP after session expiry
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 10 and 99999 filtered by FH
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page pdp
    When I sign in with email testExpiry@test.com and password Test@12345
    Then I check on remember me checkbox
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
      # Given There is 1 normal size product items of locale <locale> with inventory between 800 and 9999
      #   And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      #   And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      #   And I wait until Experience.Header.ShoppingBagCounter is displayed
      # When I sign in with email testExpiry@test.com and password Test@12345
      # Then I check on remember me checkbox
      #   And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
      And I get the callerId from cookie WC_AUTHENTICATION paramater and stored with #callerId key
      And In DB I update the status to 'T' for #callerId in CTXMGMT table
      And I delete authentication cookies
      And I delete userActivity cookies
      And I wait for 20 seconds
      And I refresh page
      And In session expiry pop up i sign in with email testExpiry@test.com and password Test@12345 and set rememberme to true
    Then URL should contain "sopping-bag" in 15 seconds

    Examples:
      | locale | langCode |
      | ee     | default  |