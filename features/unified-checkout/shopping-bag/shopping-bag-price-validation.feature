Feature: Unified Shopping Bag - Price Validation

  @FullRegression
  @Desktop @Mobile @Safari
  @Chrome @FireFox
  @ShoppingBag @UnifiedCheckout @Price @P2
  Scenario Outline: Price Validation - I see correct price info when add same price product without discount
    Given There is 1 product style with same current price of locale <locale>
    When I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
      And I am a <userType> user
      And I wait for 2 seconds
      And I extract product style detail by style colour part number product1#styleColourPartNumber
      And I extract a product item from product style product1#styleColourPartNumber which has lowest price saved as #skuPartNumber
      And I wait until the current page is PDP
    When in unified PDP I select size by sku part number #skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
    When I click on ProductDetailPage.Header.ShoppingBagButton
    Then in unified shopping bag page I see product item #skuPartNumber has correct price info

    @tms:UTR-13259
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-16349 @issue:EESCK-10758
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop @Mobile @Safari
  @Chrome @FireFox
  @ShoppingBag @UnifiedCheckout @Price @P2
  Scenario Outline: Price Validation - I see correct price info when add same price product with discount
    Given There is 1 discounted product style with same current price of locale <locale>
    When I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I wait for 2 seconds
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I extract product style detail by style colour part number product1#styleColourPartNumber
      And I wait for 2 seconds
      And I extract a product item from product style product1#styleColourPartNumber which has lowest price saved as #skuPartNumber
      And I wait for 2 seconds
      And in unified PDP I select size by sku part number #skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
    When I click on ProductDetailPage.Header.ShoppingBagButton
      And I wait until the current page is loaded
    Then in unified shopping bag page I see product item #skuPartNumber has correct price info

    @tms:UTR-13260
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-16534
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop @Mobile @Safari
  @Chrome @FireFox
  @ShoppingBag @UnifiedCheckout @Price @P2
  Scenario Outline: Price Validation - I see correct price info when add product with different current price
    Given There is 2 product style with different current price of locale <locale>
    When I am on locale <locale> pdp page of langCode <langCode> for product style product2#styleColourPartNumber with forced accepted cookies
      And I extract product style detail by style colour part number product2#styleColourPartNumber
      And I extract a product item from product style product2#styleColourPartNumber which has lowest price saved as #skuPartNumber
    When I wait until page ProductDetailPage.Pdp is loaded
    When in unified PDP I select size by sku part number #skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
    When I click on ProductDetailPage.Header.ShoppingBagButton
      And I wait until the current page is loaded
    Then in unified shopping bag page I see product item #skuPartNumber has correct price info

    @tms:UTR-13258
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16535 @issue:EESCK-10758
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |
