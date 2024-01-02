Feature: Unified Tracking - Events
#This feature is only available for TH, So excluding for CK

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P3 @ExcludeCK @tms:UTR-17376 
  Scenario Outline: Find in store - The event is fired when I click on check store availability from PDP
    Given There is 1 normal size product item with find in store option of locale <locale>
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
    And I extract product item detail by sku part number product1#skuPartNumber
    And I wait until the current page is loaded
    When I inject utag event listener
    And I click on ProductDetailPage.FindInStorePopup.FindInStoreButton
    Then utag event find_in_store_interaction is fired saved to key #event
    And utag event #event should contain attr eventCategory with value "engagement"
    And utag event #event should contain attr eventAction with value "find_in_store_interaction"
    And utag event #event should contain attr eventLabel with value "check in store availability"
    And utag event #event should optionally contain non-empty attr product_category
    And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
    And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
    And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
    And utag event #event should contain attr product_list with value of list of product style product1#styleColourPartNumber
    And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
    And utag event #event should optionally contain non-empty attr product_style
    And utag event #event should contain attr stock_product_in_full_stock with value of colour based full stock of product style product1#styleColourPartNumber
    And I execute all datalayer event validation with report key #event
   
   Examples:
      | locale | 
      | uk     | 


  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P3 @ExcludeCK @tms:UTR-17377 
  Scenario Outline: Find in store - The event is fired when I click on search location from PDP
    Given There is 1 normal size product item with find in store option of locale <locale>
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
    And I extract product item detail by sku part number product1#skuPartNumber
    And I wait until the current page is loaded
    And in unified PDP I select size by sku part number product1#skuPartNumber
    And I click on ProductDetailPage.FindInStorePopup.FindInStoreButton
    Then I see ProductDetailPage.FindInStorePopup.FindInStoreModal is displayed
    When I inject utag event listener
    And I type "<findStoreLocation>" in the field ProductDetailPage.FindInStorePopup.SearchLocation
    And I click on ProductDetailPage.FindInStorePopup.SubmitAddress
    Then utag event find_in_store_interaction is fired saved to key #event
    And utag event #event should contain attr eventCategory with value "engagement"
    And utag event #event should contain attr eventAction with value "find_in_store_interaction"
    And utag event #event should contain attr eventLabel with value "search"
    And utag event #event should optionally contain non-empty attr product_category
    And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
    And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
    And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
    And utag event #event should contain attr product_list with value of list of product style product1#styleColourPartNumber
    And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
    And utag event #event should contain attr product_size with value of size of product item product1#skuPartNumber
    And utag event #event should optionally contain non-empty attr product_style
    And utag event #event should contain attr stock_product_in_full_stock with value of colour based full stock of product style product1#styleColourPartNumber
    And I execute all datalayer event validation with report key #event
   
   Examples:
      | locale | findStoreLocation |
      | uk     | London            |


  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P3 @ExcludeCK @tms:UTR-17378 
  Scenario Outline: Find in store - The event is fired when I click on use my location from PDP
    Given There is 1 normal size product item with find in store option of locale <locale>
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
    And I extract product item detail by sku part number product1#skuPartNumber
    And I wait until the current page is loaded
    And in unified PDP I select size by sku part number product1#skuPartNumber
    And I click on ProductDetailPage.FindInStorePopup.FindInStoreButton
    Then I see ProductDetailPage.FindInStorePopup.FindInStoreModal is displayed
    When I inject utag event listener
    And I click on ProductDetailPage.FindInStorePopup.UseMyLocationButton 
    Then utag event find_in_store_interaction is fired saved to key #event
    And utag event #event should contain attr eventCategory with value "engagement"
    And utag event #event should contain attr eventAction with value "find_in_store_interaction"
    And utag event #event should contain attr eventLabel with value "use my location"
    And utag event #event should optionally contain non-empty attr product_category
    And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
    And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
    And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
    And utag event #event should contain attr product_list with value of list of product style product1#styleColourPartNumber
    And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
    And utag event #event should contain attr product_size with value of size of product item product1#skuPartNumber
    And utag event #event should optionally contain non-empty attr product_style
    And utag event #event should contain attr stock_product_in_full_stock with value of colour based full stock of product style product1#styleColourPartNumber
    And I execute all datalayer event validation with report key #event
   
   Examples:
      | locale | 
      | uk     | 


  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P3 @ExcludeCK @tms:UTR-17379 
  Scenario Outline: Find in store - The event is fired when I click on change size from PDP
    Given There is 1 normal size product item with find in store option of locale <locale>
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
    And I extract product item detail by sku part number product1#skuPartNumber
    And I wait until the current page is loaded
    And in unified PDP I select size by sku part number product1#skuPartNumber
    And I click on ProductDetailPage.FindInStorePopup.FindInStoreButton
    Then I see ProductDetailPage.FindInStorePopup.FindInStoreModal is displayed
    And I type "<findStoreLocation>" in the field ProductDetailPage.FindInStorePopup.SearchLocation
    And I click on ProductDetailPage.FindInStorePopup.SubmitAddress
    When I inject utag event listener
    And I click on ProductDetailPage.FindInStorePopup.ChangeSize
    Then utag event find_in_store_interaction is fired saved to key #event
    And utag event #event should contain attr eventCategory with value "engagement"
    And utag event #event should contain attr eventAction with value "find_in_store_interaction"
    And utag event #event should contain attr eventLabel with value "change size"
    And utag event #event should optionally contain non-empty attr product_category
    And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
    And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
    And utag event #event should contain attr product_size with value of size of product item product1#skuPartNumber
    And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
    And utag event #event should contain attr product_list with value of list of product style product1#styleColourPartNumber
    And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
    And utag event #event should optionally contain non-empty attr product_style
    And utag event #event should contain attr stock_product_in_full_stock with value of colour based full stock of product style product1#styleColourPartNumber
    And I execute all datalayer event validation with report key #event
   
   Examples:
      | locale | findStoreLocation |
      | uk     | London            |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P3 @ExcludeCK @tms:UTR-17380 
  Scenario Outline: Find in store - The event is fired when I click on only show stores with stock from PDP
    Given There is 1 normal size product item with find in store option of locale <locale>
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
    And I extract product item detail by sku part number product1#skuPartNumber
    And I wait until the current page is loaded
    And in unified PDP I select size by sku part number product1#skuPartNumber
    And I click on ProductDetailPage.FindInStorePopup.FindInStoreButton
    Then I see ProductDetailPage.FindInStorePopup.FindInStoreModal is displayed
    And I type "<findStoreLocation>" in the field ProductDetailPage.FindInStorePopup.SearchLocation
    And I click on ProductDetailPage.FindInStorePopup.SubmitAddress 
    When I inject utag event listener
    And I click on ProductDetailPage.FindInStorePopup.StoresWithStockFilter
    Then utag event find_in_store_interaction is fired saved to key #event
    And utag event #event should contain attr eventCategory with value "engagement"
    And utag event #event should contain attr eventAction with value "find_in_store_interaction"
    And utag event #event should contain attr eventLabel with value "checkbox in-store stock"
    And utag event #event should optionally contain non-empty attr product_category
    And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
    And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
    And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
    And utag event #event should contain attr product_list with value of list of product style product1#styleColourPartNumber
    And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
    And utag event #event should contain attr product_size with value of size of product item product1#skuPartNumber
    And utag event #event should optionally contain non-empty attr product_style
    And utag event #event should contain attr stock_product_in_full_stock with value of colour based full stock of product style product1#styleColourPartNumber
    And I execute all datalayer event validation with report key #event
   
   Examples:
      | locale | findStoreLocation |
      | uk     | London            |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P3 @ExcludeCK @tms:UTR-17381 
  Scenario Outline: Find in store - The event is fired when I click on only store location info from PDP
    Given There is 1 normal size product item with find in store option of locale <locale>
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
    And I extract product item detail by sku part number product1#skuPartNumber
    And I wait until the current page is loaded
    And in unified PDP I select size by sku part number product1#skuPartNumber
    And I click on ProductDetailPage.FindInStorePopup.FindInStoreButton
    Then I see ProductDetailPage.FindInStorePopup.FindInStoreModal is displayed
    And I type "<findStoreLocation>" in the field ProductDetailPage.FindInStorePopup.SearchLocation
    And I click on ProductDetailPage.FindInStorePopup.SubmitAddress 
    When I inject utag event listener
    And I click on ProductDetailPage.FindInStorePopup.locationDetailsInfo with index 1
    Then utag event find_in_store_interaction is fired saved to key #event
    And utag event #event should contain attr eventCategory with value "engagement"
    And utag event #event should contain attr eventAction with value "find_in_store_interaction"
    And utag event #event should contain attr eventLabel with value "select store"
    And utag event #event should optionally contain non-empty attr product_category
    And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
    And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
    And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
    And utag event #event should contain attr product_list with value of list of product style product1#styleColourPartNumber
    And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
    And utag event #event should contain attr product_size with value of size of product item product1#skuPartNumber
    And utag event #event should optionally contain non-empty attr fis_pick_up_location
    And utag event #event should optionally contain non-empty attr fis_stock_availability
    And utag event #event should optionally contain non-empty attr fis_store_position
    And utag event #event should optionally contain non-empty attr product_style
    And utag event #event should contain attr stock_product_in_full_stock with value of colour based full stock of product style product1#styleColourPartNumber
    And I execute all datalayer event validation with report key #event

   Examples:
      | locale | findStoreLocation |
      | uk     | London            |