Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1
  @WLP @CET1
  @tms:UTR-5755 @issue:CET1-4027
  Scenario Outline: Add to cart - The event is fired when I add a product from WLP
    Given There is 1 normal size product style of locale <locale> with inventory between 100 and 9999
      And I am on locale <locale> wish list page for product style product1#styleColourPartNumber with forced accepted cookies
    When I inject utag event listener
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
      And I see Experience.Wishlist.DisabledAddToBagButton is displayed
      And in unified wishlist page I select size based on product item #skuPartNumber
      And I click on Experience.Wishlist.EnabledAddToBagButton
    Then utag event add_to_cart is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "add to cart"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_list with value "wishlist"
      And utag event #event should contain attr product_ean with value "#skuPartNumber"
      And utag event #event should contain attr product_colour with value of colour of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_low_price with value of product low price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_price with value of product price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_size
      And utag event #event should contain attr stock_product_in_full_stock with value of colour based full stock of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_id with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_gender with value of gender of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_division with value of division of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_style with value "product1#stylePartNumber" in lower case
      And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
      And utag event #event should contain non-empty attr product_brand
      And utag event #event should contain attr product_sku with value "#skuPartNumber"
      And utag event #event should contain attr product_quantity with value "1"
      And utag event #event should optionally contain non-empty attr product_category
      And utag event #event should optionally contain non-empty attr product_category_alias
      And utag event #event should contain attr product_base_price with value of product base price of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_tax
      And utag event #event should contain attr product_discount with value of discount of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_out_of_stock_sizes with value of out of stock sizes of product style product1#styleColourPartNumber
      And utag event #event should contain attr originEntry with value "wishlist"
      And utag event #event should contain non-empty attr productCatentryId
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode |
      | ee     | default  |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1
  @WLP @CET1
  @tms:UTR-7284 @issue:CET1-4027
  Scenario Outline: Add to cart - The event is fired when I add a discounted product from WLP
    Given There is 1 discounted product item of locale <locale> with inventory between 100 and 9999
      And I am on locale <locale> wish list page for product style product1#styleColourPartNumber with forced accepted cookies
    When I inject utag event listener
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
      #  If there is one size then DisabledAddToBagButton will not display
      # And I see Experience.Wishlist.DisabledAddToBagButton is displayed
      And in unified wishlist page I select size based on product item #skuPartNumber
      And I click on Experience.Wishlist.EnabledAddToBagButton
    Then utag event add_to_cart is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "add to cart"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_list with value "wishlist"
      And utag event #event should contain attr product_ean with value "#skuPartNumber"
      And utag event #event should contain attr product_colour with value of colour of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_low_price with value of product low price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_price with value of product price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_size
      And utag event #event should contain attr stock_product_in_full_stock with value of colour based full stock of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_id with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_gender with value of gender of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_division with value of division of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_style with value "product1#stylePartNumber" in lower case
      And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
      And utag event #event should contain non-empty attr product_brand
      And utag event #event should contain attr product_sku with value "#skuPartNumber"
      And utag event #event should contain attr product_quantity with value "1"
      And utag event #event should optionally contain non-empty attr product_category
      And utag event #event should optionally contain non-empty attr product_category_alias
      And utag event #event should contain attr product_base_price with value of product base price of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_tax
      And utag event #event should contain attr product_discount with value of discount of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_out_of_stock_sizes with value of out of stock sizes of product style product1#styleColourPartNumber
      And utag event #event should contain attr originEntry with value "wishlist"
      And utag event #event should contain non-empty attr productCatentryId
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode |
      | ee     | default  |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedPdp @P1
  @TEE @PDP
  @tms:UTR-10531
  Scenario Outline: Add to cart - The event is fired when I add a product from PDP
    Given There is 1 normal size product item of locale <locale> with inventory between 50 and 9999
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until page ProductDetailPage.Pdp is loaded
    When I inject utag event listener
      And in unified PDP I select size by sku part number product1#skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
    Then utag event add_to_cart is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "add to cart"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      # change to list value pmce PAN-2206 is fixed
      And utag event #event should contain non-empty attr product_list with value of list of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_ean with value "product1#skuPartNumber"
      And utag event #event should contain attr product_colour with value of colour of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_low_price with value of product low price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_price with value of product price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_size
      And utag event #event should contain attr stock_product_in_full_stock with value of colour based full stock of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_id with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_gender with value of gender of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_division with value of division of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_style with value "product1#stylePartNumber" in lower case
      And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
      And utag event #event should contain non-empty attr product_brand
      And utag event #event should contain attr product_sku with value "product1#skuPartNumber"
      And utag event #event should contain attr product_quantity with value "1"
      And utag event #event should contain non-empty attr product_category
      And utag event #event should contain non-empty attr product_category_alias
      And utag event #event should contain attr product_base_price with value of product base price of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_tax
      And utag event #event should contain attr product_discount with value of discount of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_out_of_stock_sizes with value of out of stock sizes of product style product1#styleColourPartNumber
      And utag event #event should contain attr originEntry with value "maincta"
      And utag event #event should contain non-empty attr productCatentryId
      And utag event #event should contain non-empty attr product_promo_flag
      And I execute all datalayer event validation with report key #event
    Examples:
      | locale | langCode |
      | nl     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedXo @TEX @P1
  @ExcludeProdStag @Unification @Analytics 
  @tms:UTR-17817
  Scenario Outline: Add to cart - The event is fired when I add a product to the cart from PDP XO Recommendations
      Given There is 1 normal size product item of locale <locale> and langCode <langCode> with inventory between 100 and 9999
      And I am on unified locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
      And I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I scroll to the element <recommendationSection>
      And from unified XO recommendation product style colour partnumber with <styleColourPartNumber> saved as #styleColourPartNumber
      And from unified XO recommendation product style partnumber with <styleColourPartNumber> saved as #stylePartNumber
      When I inject utag event listener
      And I click on Experience.Recommendations.AddToCartButtonByStyleColour with args <injectionId>,<styleColourPartNumber>
      Then utag event add_to_cart is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "add to cart"
      And utag event #event should contain attr eventLabel with value "#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_list with value "recommendations"
      And utag event #event should contain attr product_colour with value of colour of product style #styleColourPartNumber
      And utag event #event should contain attr product_low_price with value of product price of product style #styleColourPartNumber
      And utag event #event should contain attr product_price with value of product price of product style #styleColourPartNumber
      And utag event #event should contain attr product_name with value of name of product style #styleColourPartNumber
      And utag event #event should contain non-empty attr product_size
      And utag event #event should contain attr stock_product_in_full_stock with value of colour based full stock of product style #styleColourPartNumber
      And utag event #event should contain attr product_id with value "#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_gender with value of gender of product style #styleColourPartNumber
      And utag event #event should contain attr product_division with value of division of product style #styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product style #styleColourPartNumber
      And utag event #event should contain attr product_style with value "#stylePartNumber" in lower case
      And utag event #event should contain attr product_combi with value "#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "#styleColourPartNumber" in upper case
      And utag event #event should contain non-empty attr product_brand
      And utag event #event should contain attr product_quantity with value "1"
      And utag event #event should optionally contain non-empty attr product_category
      And utag event #event should optionally contain non-empty attr product_category_alias
      And utag event #event should contain attr product_base_price with value of product base price of product style #styleColourPartNumber
      And utag event #event should contain non-empty attr product_tax
      And utag event #event should contain attr product_discount with value of discount of product style #styleColourPartNumber
      And utag event #event should contain attr product_out_of_stock_sizes with value of out of stock sizes of product style #styleColourPartNumber
      And utag event #event should contain attr originEntry with value "recommendations"
      And utag event #event should contain non-empty attr xo_source_id
      And utag event #event should contain non-empty attr xo_widget_id
      And utag event #event should contain non-empty attr productCatentryId
      And utag event #event should contain attr recommendation_container with value "pdp_rec_injection2"
      And utag event #event should contain attr recommendation_source with value "true"
      And utag event #event should at least contain attr recommendation_population with value "population 1"
      And I execute all datalayer event validation with report key #event

    @ExcludeCK
    Examples:
      | locale    | langCode | styleColourPartNumber | xoWidgetId               | sizeType | recommendationSection                        | injectionId |
      | xoDefault | default  | MWF1782456000         | 63b41dbd355034a2ffc911a8 | one      | Experience.Recommendations.RecoForYouSection | injection2  |

    @ExcludeTH
    Examples:
      | locale    | langCode | styleColourPartNumber | xoWidgetId               | sizeType | recommendationSection                        | injectionId |
      | xoDefault | default  | K50K502533001         | 63b598289a767ed180664d78 | one      | Experience.Recommendations.RecoForYouSection | injection2  |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1
  @tms:UTR-17553 
  Scenario Outline: Add to cart - The event is fired when I edit a product from shopping bag page
      Given There is 1 normal size product items of locale <locale> with inventory between 800 and 99999
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I click on Experience.ShoppingBag.EditProductButton with args product1#skuPartNumber
      When I inject utag event listener
      And in page Experience.ShoppingBag edit quantity dropdown of product item product1#skuPartNumber I select the highest instock quantity saved as #quantity
      And I click on Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber
      Then utag event add_to_cart is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "add to cart"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain non-empty attr product_list with value of list of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_ean with value "product1#skuPartNumber"
      And utag event #event should contain attr product_colour with value of colour of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_low_price with value of product low price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_price with value of product price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_size
      And utag event #event should contain attr stock_product_in_full_stock with value of colour based full stock of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_id with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_gender with value of gender of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_division with value of division of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_style with value "product1#stylePartNumber" in lower case
      And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
      And utag event #event should contain non-empty attr product_brand
      And utag event #event should contain attr product_sku with value "product1#skuPartNumber"
      And utag event #event should contain non-empty attr product_quantity
      And utag event #event should contain non-empty attr product_category
      And utag event #event should contain non-empty attr product_category_alias
      And utag event #event should contain attr product_base_price with value of product base price of product style product1#styleColourPartNumber
      And utag event #event should contain non-empty attr product_tax
      And utag event #event should contain attr product_discount with value of discount of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_out_of_stock_sizes with value of out of stock sizes of product style product1#styleColourPartNumber
      And utag event #event should contain attr originEntry with value "editShoppingbag"
      And utag event #event should contain non-empty attr productCatentryId
      And utag event #event should contain non-empty attr product_promo_flag
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode |
      | nl     | default  |

  @FullRegression
  @Desktop @Mobile @Safari
  @Chrome @FireFox
  @UnifiedExperience @UnifiedXo @P2
  @ExcludeProdStag @Unification @Analytics @tms:UTR-17554
  Scenario Outline: Add to cart - The event is fired when I add a product from shopping bag XO Recommendations
      Given I am on locale <locale> of url shopping-bag of langCode <langCode> with accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
      And I smoothly scroll to the element Experience.Footer.MainBlock
      And I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I wait until Experience.Recommendations.RecoShoppingBasketSection is displayed in 30 seconds
      And I scroll to the element Experience.Recommendations.RecoShoppingBasketSection
      And I wait until Experience.Recommendations.RecoShoppingBasketSection is displayed in 5 seconds
      And from unified XO recommendation product style colour partnumber with <styleColourPartNumber> saved as #styleColourPartNumber
      And from unified XO recommendation product style partnumber with <styleColourPartNumber> saved as #stylePartNumber
      When I inject utag event listener
      And I click on Experience.Recommendations.RecoShoppingBasketAddToBagBtn with args <styleColourPartNumber>
      Then utag event add_to_cart is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "add to cart"
      And utag event #event should contain attr eventLabel with value "#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_list with value "matching items"
      And utag event #event should contain attr product_colour with value of colour of product style #styleColourPartNumber
      And utag event #event should contain attr product_low_price with value of product price of product style #styleColourPartNumber
      And utag event #event should contain attr product_price with value of product price of product style #styleColourPartNumber
      And utag event #event should contain attr product_name with value of name of product style #styleColourPartNumber
      And utag event #event should contain non-empty attr product_size
      And utag event #event should contain attr stock_product_in_full_stock with value of colour based full stock of product style #styleColourPartNumber
      And utag event #event should contain attr product_id with value "#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_gender with value of gender of product style #styleColourPartNumber
      And utag event #event should contain attr product_division with value of division of product style #styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product style #styleColourPartNumber
      And utag event #event should contain attr product_style with value "#stylePartNumber" in lower case
      And utag event #event should contain attr product_combi with value "#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "#styleColourPartNumber" in upper case
      And utag event #event should contain non-empty attr product_brand
      And utag event #event should contain attr product_quantity with value "1"
      And utag event #event should optionally contain non-empty attr product_category
      And utag event #event should optionally contain non-empty attr product_category_alias
      And utag event #event should contain attr product_base_price with value of product base price of product style #styleColourPartNumber
      And utag event #event should contain non-empty attr product_tax
      And utag event #event should contain attr product_discount with value of discount of product style #styleColourPartNumber
      And utag event #event should contain attr product_out_of_stock_sizes with value of out of stock sizes of product style #styleColourPartNumber
      And utag event #event should contain attr originEntry with value "recommendations"
      And utag event #event should contain non-empty attr xo_source_id
      And utag event #event should contain non-empty attr xo_widget_id
      And utag event #event should contain non-empty attr productCatentryId
      And utag event #event should contain attr recommendation_container with value "cart_rec_injection1"
      And utag event #event should contain attr recommendation_source with value "true"
      And I execute all datalayer event validation with report key #event

    @ExcludeCK
    Examples:
      | locale | langCode | styleColourPartNumber | xoWidgetId               | sizeType |
      | be     | default  | MWF1782456000         | 63b41dbd355034a2ffc911a8 | one      |

    @ExcludeTH
    Examples:
      | locale | langCode | styleColourPartNumber | xoWidgetId               | sizeType |
      | be     | default  | K50K502533001         | 63b598289a767ed180664d78 | one      |
