Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1
  @WLP @CET1
  @tms:UTR-5748
  Scenario Outline: Product list click - The event is fired when I click on a product from WLP
    Given There is 1 normal size product style of locale <locale> with inventory between 100 and 9999
      And I am on locale <locale> home page with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> wish list page for product style product1#styleColourPartNumber
    When I inject utag event listener
      And I scroll to and click on Experience.Wishlist.ListingItems with index 1
    Then utag event product_list_click is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "product click"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_id with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
      And utag event #event should contain attr product_colour with value of colour of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_style with value "product1#stylePartNumber" in lower case
      And utag event #event should contain attr product_low_price with value of product low price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_price with value of product price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_position with value "1"
      And utag event #event should contain attr product_list with value "wishlist"
      And utag event #event should contain attr product_division with value of division of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount with value of discount of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_gender with value of gender of product style product1#styleColourPartNumber
      And utag event #event should optionally contain non-empty attr product_category
      And utag event #event should contain attr product_list with value "wishlist"
      And utag event #event should contain non-empty attr fhSourceId
      And utag event #event should contain attr recommendation_source with value "false"
      And utag event #event should optionally contain non-empty attr productCatentryId
      And I execute all datalayer event validation with report key #event
    Examples:
      | locale | langCode | userType  |
      | ee     | default  | logged in |
      | fr     | default  | guest     |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1
  @WLP @CET1
  @tms:UTR-7285
  Scenario Outline: Product list click - The event is fired when I click on a discounted product from WLP
    Given There is 1 discounted product item of locale <locale> with inventory between 100 and 9999
      And I am on locale <locale> home page with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> wish list page for product style product1#styleColourPartNumber
    When I inject utag event listener
      And I scroll to and click on Experience.Wishlist.ListingItems with index 1
    Then utag event product_list_click is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "product click"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_id with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
      And utag event #event should contain attr product_colour with value of colour of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_style with value "product1#stylePartNumber" in lower case
      And utag event #event should contain attr product_low_price with value of product low price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_price with value of product price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_position with value "1"
      And utag event #event should contain attr product_list with value "wishlist"
      And utag event #event should contain attr product_division with value of division of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount with value of discount of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_gender with value of gender of product style product1#styleColourPartNumber
      And utag event #event should optionally contain non-empty attr product_category
      And utag event #event should contain attr product_list with value "wishlist"
      And utag event #event should optionally contain non-empty attr productCatentryId
      And utag event #event should contain non-empty attr fhSourceId
      And utag event #event should contain attr recommendation_source with value "false"
      And I execute all datalayer event validation with report key #event
    
    Examples:
      | locale | langCode | userType  |
      | ee     | default  | logged in |
      | fr     | default  | guest     |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1
  @ShoppingBag @CET1
  @tms:UTR-9986
  Scenario Outline: Product list click - The event is fired when I click on a Shopping Bag Item
    Given There is 1 normal size product item of locale <locale> and langCode <langCode> with inventory between 50 and 999
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter contains text "1"
    When I inject utag event listener
      And I click on Experience.ShoppingBag.ItemImage
      And I wait until page ProductDetailPage.Pdp is loaded
    Then utag event product_list_click is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "product click"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_name with value of name of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_id with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "product1#styleColourPartNumber" in upper case
      And utag event #event should contain attr product_colour with value of colour of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_style with value "product1#stylePartNumber" in lower case
      And utag event #event should contain attr product_low_price with value of product low price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_price with value of product price of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_position with value "1"
      And utag event #event should contain attr product_division with value of division of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount with value of discount of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product style product1#styleColourPartNumber
      And utag event #event should contain attr product_gender with value of gender of product style product1#styleColourPartNumber
      And utag event #event should optionally contain non-empty attr product_category
      And utag event #event should contain attr product_list with in lower case value of digitalData.page.category.productStructureGroupId
      And utag event #event should optionally contain non-empty attr productCatentryId
      And utag event #event should contain attr recommendation_source with value "false"
      And I execute all datalayer event validation with report key #event
    
    Examples:
      | locale | langCode |
      | ee     | default  |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1
  @PLP @CET1 
  @tms:UTR-16598 @FixedEvent
  Scenario Outline: Product list click - The event is fired when I click on a product from PLP
     Given I am on category <categoryId> page of locale <locale> of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified PLP I extract 4th product style colour partnumber saved as #styleColourPartNumber
      And in unified PLP I extract 4th product style partnumber saved as #stylePartNumber
      When I inject utag event listener
      And in js extract digitalData.page.category.productStructureGroupId save to #productList
      And I scroll to and click on Experience.PlpProducts.ListingItems with index 4
      And I wait until ProductDetailPage.Pdp.Content is displayed
      Then utag event product_list_click is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "product click"
      And utag event #event should contain attr eventLabel with value "#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_name with value of name of product style #styleColourPartNumber
      And utag event #event should contain attr product_id with value "#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi with value "#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "#styleColourPartNumber" in upper case
      And utag event #event should contain attr product_colour with value of colour of product style #styleColourPartNumber
      And utag event #event should contain attr product_style with value "#stylePartNumber" in lower case
      And utag event #event should contain attr product_low_price with value of product low price of product style #styleColourPartNumber
      And utag event #event should contain attr product_price with value of product price of product style #styleColourPartNumber
      And utag event #event should contain attr product_position with value "4"
      And utag event #event should contain attr product_list with value "#productList"
      And utag event #event should contain non-empty attr fhSourceId
      And utag event #event should contain attr product_division with value of division of product style #styleColourPartNumber
      And utag event #event should contain attr product_discount with value of discount of product style #styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product style #styleColourPartNumber
      And utag event #event should contain attr product_gender with value of gender of product style #styleColourPartNumber
      And utag event #event should optionally contain non-empty attr product_category
      And utag event #event should optionally contain non-empty attr productCatentryId
       And utag event #event should contain attr recommendation_source with value "false"
      And I execute all datalayer event validation with report key #event
    
    @ExcludeCK
    Examples:
      | locale | langCode    | categoryId |
      | ee     | default     |th_women_clothing_jeans |

    @ExcludeTH
    Examples:
      | locale | langCode  | categoryId |
      | ee     | default   |MEN_CLOTHES_T-SHIRTS |


  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1
  @PLP @CET1 
  @tms:UTR-16601 @FixedEvent
  Scenario Outline: Product list click - The event is fired when I click on a product from Search PLP
      Given I am on locale <locale> search page with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      When I inject utag event listener
      And in unified PLP I extract 4th product style colour partnumber saved as #styleColourPartNumber
      And in unified PLP I extract 4th product style partnumber saved as #stylePartNumber
      And I scroll to and click on Experience.PlpProducts.ListingItems with index 4
      And I wait until ProductDetailPage.Pdp.Content is displayed
      Then utag event product_list_click is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "product click"
      And utag event #event should contain attr eventLabel with value "#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_name with value of name of product style #styleColourPartNumber
      And utag event #event should contain attr product_id with value "#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi with value "#styleColourPartNumber" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "#styleColourPartNumber" in upper case
      And utag event #event should contain attr product_colour with value of colour of product style #styleColourPartNumber
      And utag event #event should contain attr product_style with value "#stylePartNumber" in lower case
      And utag event #event should contain attr product_low_price with value of product low price of product style #styleColourPartNumber
      And utag event #event should contain attr product_price with value of product price of product style #styleColourPartNumber
      And utag event #event should contain attr product_position with value "4"
      And utag event #event should contain attr product_division with value of division of product style #styleColourPartNumber
      And utag event #event should contain attr product_discount with value of discount of product style #styleColourPartNumber
      And utag event #event should contain attr product_discount_status with value of discount status of product style #styleColourPartNumber
      And utag event #event should contain attr product_gender with value of gender of product style #styleColourPartNumber
      And utag event #event should contain attr product_list with value "search"
      And utag event #event should contain attr recommendation_source with value "false"
      And utag event #event should contain non-empty attr fhSourceId
      And utag event #event should optionally contain non-empty attr product_category
      And utag event #event should optionally contain non-empty attr productCatentryId
      And I execute all datalayer event validation with report key #event
   
   Examples:
      | locale | langCode |
      | ee     | default  |
