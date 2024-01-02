Feature: Unified Shopping Bag - Price Format

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ProductPrices @ShoppingBag @UnifiedCheckout @P2
  @feature:EECK-4923
  Scenario Outline: Unified Shopping Bag - Verify product price format
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product with accepted cookies
    When I wait until Experience.ShoppingBag.ItemCurrentPrice is displayed
      And I get price format for current locale and store it with key #priceFormat
      And I get currency code for current locale and store it with key #expectedCurrency
    Then the value of Experience.ShoppingBag.ItemCurrentPrice should match regex pattern "#priceFormat"
    When I fetch currency of product item product1#skuPartNumber saved as #currency
    Then I see the stored value with key #currency is equal to "#expectedCurrency"

    @tms:UTR-16528
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16529 @issue:EESCK-10758
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ProductPrices @ShoppingBag @UnifiedCheckout @P2
  @feature:EECK-4923
  Scenario Outline: Unified Shopping Bag - Verify products markdown price format
    Given There is 1 discounted product item of locale <locale> with inventory between 10 and 1000000
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with accepted cookies
      And I wait until Experience.ShoppingBag.ItemCurrentPrice is displayed
      And I get price format for current locale and store it with key #priceFormat
      And I get currency code for current locale and store it with key #expectedCurrency
    Then the value of Experience.ShoppingBag.ItemCurrentPrice should match regex pattern "#priceFormat"
      And the value of Experience.ShoppingBag.ItemWasPrice should match regex pattern "#priceFormat"
    When I fetch currency of product item product1#skuPartNumber saved as #currency
    Then I see the stored value with key #currency is equal to "#expectedCurrency"

    @tms:UTR-17124
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16531
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @promoIssue
  @ShoppingBag @OverviewPanel @ProductPrices @UnifiedCheckout @P2
  Scenario Outline: Unified Shopping Bag Overview Desktop - Verify overview panel price format
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 products with value below shipping threshold on shopping bag page
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I get price format for current locale and store it with key #priceFormat
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I type "#Promo" in the field Experience.ShoppingBag.PromoCodeField
      And I click on Experience.ShoppingBag.PromoCodeApplyButton
      And I see Experience.ShoppingBag.PromoCodeDiscountInfo is displayed
    Then the value of Experience.ShoppingBag.SubTotalPriceInfo should match regex pattern "#priceFormat"
      And the value of Experience.ShoppingBag.ShippingChargeAmount should match regex pattern "#priceFormat"
      And the value of Experience.ShoppingBag.PromoCodeDiscountInfo should match regex pattern "#priceFormat"
      And the value of Experience.ShoppingBag.TotalPriceInfo should match regex pattern "#priceFormat"

    @tms:UTR-2299
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-15651
    Examples:
      | locale | langCode | userType  |
      | be     | FR       | logged in |

  @FullRegression
  @Mobile
  @Chrome @Safari @promoIssue
  @ShoppingBag @OverviewPanel @ProductPrices @UnifiedCheckout
  Scenario Outline: Unified Shopping Bag Overview Mobile - Verify overview panel price format
    Given There is 1 product item with 0% discount of locale <locale> with price between 10 and 20 and inventory between 2 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I get price format for current locale and store it with key #priceFormat
      And I scroll to and click on Experience.ShoppingBag.PromoCodeButton
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I type "#Promo" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Experience.ShoppingBag.PromoCodeApplyButton
      And I see Experience.ShoppingBag.PromoCodeDiscountInfo is displayed
    Then the value of Experience.ShoppingBag.SubTotalPriceInfo should match regex pattern "#priceFormat"
      And the value of Experience.ShoppingBag.ShippingChargeAmount should match regex pattern "#priceFormat"
      And the value of Experience.ShoppingBag.PromoCodeDiscountInfo should match regex pattern "#priceFormat"
      And the value of Experience.ShoppingBag.TotalPriceInfo should match regex pattern "#priceFormat"
      And the value of Experience.ShoppingBag.MobileTotalPriceInfo should match regex pattern "#priceFormat"

    @tms:UTR-2299
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16532
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |
