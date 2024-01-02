Feature: Unified Tracking - Events

  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P2
  @ShoppingBag @CET1
  @tms:UTR-9989 
  Scenario Outline: Edit cart product - The event is fired when I edit a product
    Given There is 1 normal size product item of locale <locale> and langCode <langCode> with inventory between 50 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter contains text "1"
    When I inject utag event listener
      And I click on Experience.ShoppingBag.EditProductButton
    Then utag event edit_cart_product is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "edit cart product"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_list with value of list of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_ean with value "product1#skuPartNumber"
      And utag event #event should contain attr product_colour with value of colour of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_low_price with value of product low price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_price with value of product price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_size with value of size of product item product1#skuPartNumber
      And utag event #event should contain attr stock_product_in_full_stock with value of colour based full stock of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_id with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_gender with value of gender of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_division with value of division of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_style with value "product1#stylePartNumber" in lower case
      And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
      And utag event #event should contain attr product_category with value of gbpc of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_category_alias with value of gbpc of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_brand
      And utag event #event should contain attr product_quantity with value "1"
      And utag event #event should contain attr product_discount with value of discount of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_base_price with value of product base price of product style product1#styleColourPartNumber
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode |
      | be     | default  |
