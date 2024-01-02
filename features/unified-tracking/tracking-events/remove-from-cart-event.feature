Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P2
  @ShoppingBag @CET1
  @tms:UTR-9985
  Scenario Outline: Remove from cart - The event is fired when I remove a product from Shoppingbag
    Given There is 1 normal size product item of locale <locale> and langCode <langCode> with inventory between 50 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter contains text "1"
    When I inject utag event listener
      And I click on Experience.ShoppingBag.RemoveButton by js
      And I click on Experience.ShoppingBag.RemoveConfirmButton
    Then utag event remove_from_cart is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "remove from cart"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_id with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_sku with value "product1#skuPartNumber"
      And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
      And utag event #event should contain attr product_style with value "product1#stylePartNumber" in lower case
      And utag event #event should contain attr product_size with value of size of product item product1#skuPartNumber
      And utag event #event should contain attr product_quantity with value "1"
      And utag event #event should contain non-empty attr product_category with value of gbpc of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_category_alias with value of gbpc of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_base_price with value of product base price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_low_price with value of product low price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_price with value of product price of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_tax
      And utag event #event should contain attr product_discount with value of discount of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_brand
      And utag event #event should contain attr product_colour with value of colour of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_ean with value "product1#skuPartNumber"
      And utag event #event should contain attr product_gender with value of gender of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_division with value of division of product style product1#styleColourPartNumber
      And utag event #event should contain attr stock_product_in_full_stock with value of colour based full stock of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_list with value of list of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_out_of_stock_sizes with value of out of stock sizes of product style product1#styleColourPartNumber
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode |
      | ee     | default  |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P2
  @ShoppingBag @CET1
  @tms:UTR-12971
  Scenario Outline: Remove from cart - The event is fired when I remove a product from Shoppingbag within the edit flow
    Given There is 1 normal size product item of locale <locale> and langCode <langCode> with inventory between 50 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter contains text "1"
      And I click on Experience.ShoppingBag.EditProductButton
      And in page Experience.ShoppingBag edit quantity dropdown of product item product1#skuPartNumber I select the highest instock quantity saved as #quantity
      And I click on Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber
    When I inject utag event listener
      And I click on Experience.ShoppingBag.EditProductButton
      And in page Experience.ShoppingBag edit quantity dropdown of product item product1#skuPartNumber I select the lowest instock quantity saved as #quantity
      And I click on Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber
    Then utag event remove_from_cart is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "remove from cart"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_id with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_sku with value "product1#skuPartNumber"
      And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
      And utag event #event should contain attr product_style with value "product1#stylePartNumber" in lower case
      And utag event #event should contain attr product_size with value of size of product item product1#skuPartNumber
      And utag event #event should contain attr product_quantity with value "9"
      And utag event #event should contain non-empty attr product_category with value of gbpc of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_category_alias with value of gbpc of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_base_price with value of product base price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_low_price with value of product low price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_price with value of product price of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_tax
      And utag event #event should contain attr product_discount with value of discount of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_brand
      And utag event #event should contain attr product_colour with value of colour of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_ean with value "product1#skuPartNumber"
      And utag event #event should contain attr product_gender with value of gender of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_division with value of division of product style product1#styleColourPartNumber
      And utag event #event should contain attr stock_product_in_full_stock with value of colour based full stock of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_list with value of list of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_out_of_stock_sizes with value of out of stock sizes of product style product1#styleColourPartNumber
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode |
      | ee     | default  |