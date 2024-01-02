Feature: Unified Tracking - Events

  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedPdp @P1
  @TEE @PDP
  @tms:UTR-10538
  Scenario Outline: Notify me again - The event is fired when I click on the Notify Me Again button when a product is OOS again
    Given There is 1 normal size product style of locale <locale> where 1 size is out of stock with inventory between 5 and 99999
      And I am on unified locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      # Navigate to a product which is out of stock again 
      # And I navigate to current url with suffix ?backInStockSku={0} with args product1#skuPartNumber
    When I inject utag event listener
      And I wait until the current page is loaded
      # And I click on the Notify Me Again button
    Then utag event notify_me_again is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "notify_me_again"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
      And utag event #event should contain attr product_ean with value "product1#skuPartNumber"
      And utag event #event should contain attr product_list with value of list of product style product1#styleColourPartNumber
      And utag event #event should contain attr event_value with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_low_price with value of product low price of product item product1#skuPartNumber
      And utag event #event should contain attr stock_product_in_full_stock with value of full stock of product product1#stylePartNumber
      And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_colour with value of colour of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_style with value "product1#stylePartNumber" in lower case
      And utag event #event should not contain attr userEmailEncrypted
      And utag event #event should contain attr product_price with value of product price of product item product1#skuPartNumber
      And utag event #event should contain attr product_size with value of size of product item product1#skuPartNumber
      And utag event #event should contain attr product_id with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_gender with value of digitalData.product[0].productInfo.productGender
      And utag event #event should contain attr product_division with value of division of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product item product1#skuPartNumber
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale |
      | ee     |