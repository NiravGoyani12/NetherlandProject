Feature: Unified Mini Shopping Bag

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @Header @ProductPrices @MiniShoppingBag @UnifiedCheckout @P2
  @feature:CET1-2613
  Scenario Outline: Unified Mini Shopping Bag - Verify price format with decimals
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product with accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I navigate to page <page>
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I get price format for current locale and store it with key #priceFormat
      And I get currency code for current locale and store it with key #expectedCurrency
    When I hover over Experience.Header.ShoppingBagButton
    Then the value of Experience.MiniShoppingBag.ProductPriceSelling should match regex pattern "#priceFormat"
      And the value of Experience.MiniShoppingBag.TotalPrice should match regex pattern "#priceFormat"
    When I fetch currency of product item product1#skuPartNumber saved as #currency
    Then I see the stored value with key #currency is equal to "#expectedCurrency"

    @tms:UTR-11859
    Examples:
      | locale  | page | langCode |
      | default | wlp  | default  |

    @tms:UTR-16416 @issue:EESCK-10758
    Examples:
      | locale           | page          | langCode         |
      | multiLangDefault | store-locator | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @Header @ProductPrices @MiniShoppingBag @UnifiedCheckout @P2
  @feature:CET1-2613
  Scenario Outline: Unified Mini Shopping Bag - Verify markdown price format with decimals
    Given There is 1 discounted product item of locale <locale> with inventory between 10 and 99999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I navigate to page <page>
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I get price format for current locale and store it with key #priceFormat
      And I get currency code for current locale and store it with key #expectedCurrency
      And I hover over Experience.Header.ShoppingBagButton
    Then the value of Experience.MiniShoppingBag.ProductPriceSelling should match regex pattern "#priceFormat"
      And the value of Experience.MiniShoppingBag.ProductPriceWas should match regex pattern "#priceFormat"
      And the value of Experience.MiniShoppingBag.TotalPrice should match regex pattern "#priceFormat"
    When I fetch currency of product item product1#skuPartNumber saved as #currency
    Then I see the stored value with key #currency is equal to "#expectedCurrency"

    @tms:UTR-11858
    Examples:
      | locale  | langCode | page |
      | default | default  | wlp  |

    @tms:UTR-16417 @issue:EESCK-10758
    Examples:
      | locale           | langCode         | page          |
      | multiLangDefault | multiLangDefault | store-locator |