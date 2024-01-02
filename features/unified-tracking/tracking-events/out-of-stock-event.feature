Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedPdp @P1
  @TEE @PDP
  @tms:UTR-10539
  Scenario Outline: Out of stock - The event is fired when I click on size sold out link
    Given There is 1 normal size product style of locale <locale> where 1 size is out of stock with inventory between 5 and 9999
      And I am on unified locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
    When I inject utag event listener
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #sku1
      And I click on ProductDetailPage.Pdp.SizeSoldOutButton by js
    Then utag event out_of_stock is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "out of stock"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
      And utag event #event should contain non-empty attr product_ean
      And utag event #event should contain attr product_list with value of list of product style product1#styleColourPartNumber
      And utag event #event should contain attr event_value with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_low_price with value of product low price of product style product1#styleColourPartNumber
      And utag event #event should contain attr stock_product_in_full_stock with value "0"
      And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_colour with value of colour of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_style with value "product1#stylePartNumber" in lower case
      And utag event #event should not contain attr userEmailEncrypted
      And utag event #event should contain attr product_price with value of product price of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_size
      And utag event #event should contain attr product_gender with value of gender of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_id with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_division with value of division of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product item #sku1
      And utag event #event should contain non-empty attr product_category
      And utag event #event should contain non-empty attr product_category_alias
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale |
      | ee     |