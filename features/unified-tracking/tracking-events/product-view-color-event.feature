Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedPdp
  @TEE @PDP
  @tms:UTR-10541
  Scenario Outline: Product view color - The event is fired when I choose another product colour on PDP
    Given There is 1 multi colour products with 2 colours of locale <locale> with inventory between 50 and 9999
      And I extract a product style from product product1#stylePartNumber saved as #styleColourPartNumber
      And I extract a product item from product style #styleColourPartNumber which has inventory saved as #sku
      And I am on locale <locale> pdp page for product style #styleColourPartNumber with forced accepted cookies
      And I wait until page ProductDetailPage.Pdp is loaded
      And I click on ProductDetailPage.Pdp.ColorSwatchButton with index 2
      And I wait until page ProductDetailPage.Pdp is loaded
    When I inject utag event listener
      And I click on ProductDetailPage.Pdp.ColorSwatchButton with index 1
      And I wait until page ProductDetailPage.Pdp is loaded
    Then utag event product_view_color is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "product_view_color"
      And utag event #event should contain attr eventLabel with value "#styleColourPartNumber" in lower case
      # change to list value pmce PAN-2206 is fixed
      And utag event #event should contain non-empty attr product_list with value of list of product style #styleColourPartNumber
      And utag event #event should contain attr product_colour with value of colour of product style #styleColourPartNumber
      And utag event #event should contain attr product_low_price with value of product low price of product style #styleColourPartNumber
      And utag event #event should contain attr product_price with value of product price of product style #styleColourPartNumber
      And utag event #event should contain attr product_name with value of name of product style #styleColourPartNumber
      And utag event #event should contain attr stock_product_in_full_stock with value of colour based full stock of product style #styleColourPartNumber
      And utag event #event should contain attr product_id with value "#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_gender with value of gender of product style #styleColourPartNumber
      And utag event #event should contain attr product_division with value of division of product style #styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product style #styleColourPartNumber
      And utag event #event should contain non-empty attr product_style
      And utag event #event should contain attr product_combi with value "#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "#styleColourPartNumber" in upper case
      And utag event #event should contain non-empty attr product_brand
      And utag event #event should contain non-empty attr product_category
      And utag event #event should contain non-empty attr product_category_alias
      And utag event #event should contain attr product_base_price with value of product base price of product style #styleColourPartNumber
      And utag event #event should contain non-empty attr product_tax
      And utag event #event should contain attr product_discount with value of discount of product style #styleColourPartNumber
      And utag event #event should contain attr product_out_of_stock_sizes with value of out of stock sizes of product style #styleColourPartNumber
      And utag event #event should contain attr productAvailabilityPercentage with value of availability percentage of product style #styleColourPartNumber
      And utag event #event should contain non-empty attr catentryId
      And utag event #event should contain non-empty attr fhSourceId
      And utag event #event should contain attr product_quantity with value "1"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale |
      | ee     |