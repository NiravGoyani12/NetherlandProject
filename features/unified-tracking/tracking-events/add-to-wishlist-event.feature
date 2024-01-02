Feature: Unified Tracking - Events

  @FullRegression
  @Desktop
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedPdp @P1
  @TEE @PDP
  @tms:UTR-10533
  Scenario Outline: Add to wishlist - The event is fired when I add a product to wishlist from PDP on Desktop
    Given There is 1 normal size product item of locale <locale> with inventory between 50 and 9999
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
      And I wait until page ProductDetailPage.Pdp is loaded
    When I inject utag event listener
      And I click on ProductDetailPage.Pdp.WishListIcon
      And I wait until ProductDetailPage.Pdp.ActiveWishListIcon is displayed in 2 seconds
    Then utag event add_to_wishlist is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "add to wishlist"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
      # change to list value pmce PAN-2206 is fixed
      And utag event #event should contain non-empty attr product_list with value of list of product style product1#styleColourPartNumber
      And utag event #event should contain attr event_value with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_low_price with value of product low price of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr stock_product_in_full_stock
      And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_colour with value of colour of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_style with value "product1#stylePartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
      And utag event #event should contain attr product_base_price with value of product base price of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_category
      And utag event #event should contain non-empty attr product_category_alias
      And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_gender with value of gender of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_id with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_price with value of product price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_quantity with value "1"
      And utag event #event should contain attr product_division with value of division of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount with value of discount of product style product1#styleColourPartNumber
      And utag event #event should contain attr recommendation_source with value "false"
      And utag event #event should contain attr originEntry with value "maincta"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale |
      | ee     |

  @FullRegression
  @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedPdp @P1
  @TEE @PDP
  @tms:UTR-10532
  Scenario Outline: Add to wishlist - The event is fired when I add a product to wishlist from PDP Image on Mobile
    Given There is 1 normal size product item of locale <locale> with inventory between 50 and 9999
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
      And I wait until page ProductDetailPage.Pdp is loaded
    When I inject utag event listener
      And I click on ProductDetailPage.Pdp.WishListIcon
      And I wait until ProductDetailPage.Pdp.ActiveWishListIcon is displayed in 2 seconds
    Then utag event add_to_wishlist is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "add to wishlist"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
      # change to list value pmce PAN-2206 is fixed
      And utag event #event should contain non-empty attr product_list with value of list of product style product1#styleColourPartNumber
      And utag event #event should contain attr event_value with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_low_price with value of product low price of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr stock_product_in_full_stock
      And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_colour with value of colour of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_style with value "product1#stylePartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
      And utag event #event should contain attr product_base_price with value of product base price of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_category
      And utag event #event should contain non-empty attr product_category_alias
      And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_gender with value of gender of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_id with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_price with value of product price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_quantity with value "1"
      And utag event #event should contain attr product_division with value of division of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount with value of discount of product style product1#styleColourPartNumber
      And utag event #event should contain attr recommendation_source with value "false"
      And utag event #event should contain attr originEntry with value "image"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale |
      | ee     |