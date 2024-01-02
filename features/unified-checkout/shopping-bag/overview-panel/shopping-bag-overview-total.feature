Feature: Unified Shopping Bag - Total

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @ShoppingBag @Promocode @OverviewPanel @UnifiedCheckout @P2
  @feature:CET1-3307
  Scenario Outline: Shopping Bag Overview Desktop - Verify total price calculation with promocode and not free delivery
    Given There is 1 product item with 0% discount of locale <locale> with price between 10 and 20 and inventory between 2 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I see Experience.Header.ShoppingBagCounter contains text "1"
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I type "#Promo" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Experience.ShoppingBag.PromoCodeApplyButton
      And I see Experience.ShoppingBag.PromoCodeDiscountInfo is displayed
      And I store the numeric value of Experience.ShoppingBag.SubTotalPriceInfo with key #subtotal
      And I store the numeric value of Experience.ShoppingBag.ShippingChargeAmount with key #shippingFee
      And I store the numeric value of Experience.ShoppingBag.PromoCodeDiscountInfo with key #promocodeDiscount
      And I add #subtotal to #shippingFee and save to #priceNoDiscount
      And I subtract #promocodeDiscount from #priceNoDiscount and save to #totalPrice
    Then the numeric value of Experience.ShoppingBag.TotalPriceInfo is equal to #totalPrice
      And I see Experience.ShoppingBag.TotalPriceLabel contains text "1"

    @tms:UTR-5620
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16429
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Mobile
  @Chrome @Safari
  @ShoppingBag @OverviewPanel @Promocode @UnifiedCheckout
  @feature:CET1-3307 @P2
  Scenario Outline: Shopping Bag Overview Mobile - Verify total price calculation with promocode and not free delivery
    Given There is 1 product item with 0% discount of locale <locale> with price between 10 and 20 and inventory between 2 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I see Experience.Header.ShoppingBagCounter contains text "1"
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I type "#Promo" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Experience.ShoppingBag.PromoCodeApplyButton
      And I see Experience.ShoppingBag.PromoCodeDiscountInfo is displayed
      And I store the numeric value of Experience.ShoppingBag.SubTotalPriceInfo with key #subtotal
      And I store the numeric value of Experience.ShoppingBag.ShippingChargeAmount with key #shippingFee
      And I store the numeric value of Experience.ShoppingBag.PromoCodeDiscountInfo with key #promocodeDiscount
      And I add #subtotal to #shippingFee and save to #priceNoDiscount
      And I subtract #promocodeDiscount from #priceNoDiscount and save to #totalPrice
    Then the numeric value of Experience.ShoppingBag.TotalPriceInfo is equal to #totalPrice
      And I see Experience.ShoppingBag.TotalPriceLabel contains text "1"
      And the numeric value of Experience.ShoppingBag.MobileTotalPriceInfo is equal to #totalPrice

    @tms:UTR-5622
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16430
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @ShoppingBag @OverviewPanel @UnifiedCheckout
  @feature:CET1-3307 @P2
  Scenario Outline: Shopping Bag Overview Desktop - Verify total price calculation without promocode and free delivery
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 products with value below shipping threshold on shopping bag page
    When I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.Header.ShoppingBagCounter contains text "1"
      And I store the numeric value of Experience.ShoppingBag.SubTotalPriceInfo with key #subtotalPrice
      And I store the numeric value of Experience.ShoppingBag.ShippingChargeAmount with key #shippingCharge
      And I add #subtotalPrice from #shippingCharge and save to #subtotal
    Then the numeric value of Experience.ShoppingBag.TotalPriceInfo is equal to #subtotal
      And I see Experience.ShoppingBag.TotalPriceLabel contains text "1"

    @tms:UTR-5624
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @ShoppingBag @OverviewPanel @UnifiedCheckout
  @feature:CET1-3307 @P2
  Scenario Outline: Shopping Bag Overview Desktop - Verify total price calculation without promocode and free delivery
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 products with value above shipping threshold on shopping bag page
    When I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.Header.ShoppingBagCounter contains text "1"
      And I get translation from lokalise for "FreeCosts" and store it with key #freeShipping
      And I wait until Experience.ShoppingBag.ShippingChargeAmount is displayed
      And I see Experience.ShoppingBag.ShippingChargeAmount contains text "#freeShipping"
      And I store the numeric value of Experience.ShoppingBag.SubTotalPriceInfo with key #subtotal
    Then the numeric value of Experience.ShoppingBag.TotalPriceInfo is equal to #subtotal
      And I see Experience.ShoppingBag.TotalPriceLabel contains text "1"

    @tms:UTR-16431
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Mobile
  @Chrome @Safari
  @ShoppingBag @OverviewPanel @UnifiedCheckout
  @feature:CET1-3307 @P2
  Scenario Outline: Shopping Bag Overview Mobile - Verify total price calculation without promocode and free delivery
    Given There is 1 product item with 0% discount of locale <locale> with price between 70 and 500 and inventory between 2 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I see Experience.Header.ShoppingBagCounter contains text "1"
      And I store the numeric value of Experience.ShoppingBag.SubTotalPriceInfo with key #subtotal
    Then the numeric value of Experience.ShoppingBag.TotalPriceInfo is equal to #subtotal
      And I see Experience.ShoppingBag.TotalPriceLabel contains text "1"
      And the numeric value of Experience.ShoppingBag.MobileTotalPriceInfo is equal to #subtotal

    @tms:UTR-5621
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16432
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending @P2
  @ShoppingBag @OverviewPanel @Promocode @UnifiedCheckout
  @feature:CET1-3307
  Scenario Outline: Shopping Bag Overview Desktop - Verify total price calculation with promocode for multiple products
    Given There are 4 product items with 0% discount of locale <locale> with price between 50 and 500 and inventory between 2 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber,product2#skuPartNumber,product3#skuPartNumber,product4#skuPartNumber with forced accepted cookies
      And I see Experience.Header.ShoppingBagCounter contains text "4"
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I type "#Promo" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Experience.ShoppingBag.PromoCodeApplyButton
    When I wait until Experience.ShoppingBag.PromoCodeRemoveButton is displayed
    Then I see Experience.ShoppingBag.PromoCodeDiscountInfo is displayed
      And I store the numeric value of Experience.ShoppingBag.SubTotalPriceInfo with key #subtotal
      And I store the numeric value of Experience.ShoppingBag.PromoCodeDiscountInfo with key #promocodeDiscount
    When I subtract #promocodeDiscount from #subtotal and save to #totalPrice
    Then the numeric value of Experience.ShoppingBag.TotalPriceInfo is equal to #totalPrice
      And I see Experience.ShoppingBag.TotalPriceLabel contains text "4"

    @tms:UTR-5623
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16433
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Mobile
  @Chrome @SafariPending @P2
  @ShoppingBag @OverviewPanel @Promocode @UnifiedCheckout
  @feature:CET1-3307
  Scenario Outline: Shopping Bag Overview Mobile - Verify total price calculation with promocode for multiple products
    Given There are 4 product items with 0% discount of locale <locale> with price between 50 and 500 and inventory between 2 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber,product2#skuPartNumber,product3#skuPartNumber,product4#skuPartNumber with forced accepted cookies
      And I see Experience.Header.ShoppingBagCounter contains text "4"
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I type "#Promo" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Experience.ShoppingBag.PromoCodeApplyButton
      And I see Experience.ShoppingBag.PromoCodeDiscountInfo is displayed
      And I store the numeric value of Experience.ShoppingBag.SubTotalPriceInfo with key #subtotal
      And I store the numeric value of Experience.ShoppingBag.PromoCodeDiscountInfo with key #promocodeDiscount
      And I subtract #promocodeDiscount from #subtotal and save to #totalPrice
    Then the numeric value of Experience.ShoppingBag.TotalPriceInfo is equal to #totalPrice
      And I see Experience.ShoppingBag.TotalPriceLabel contains text "4"
      And the numeric value of Experience.ShoppingBag.MobileTotalPriceInfo is equal to #totalPrice

    @tms:UTR-5626
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16434
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending @P2
  @ShoppingBag @OverviewPanel @UnifiedCheckout
  @feature:CET1-3307
  Scenario Outline: Shopping Bag Overview Desktop - Verify total price calculation without promocode for multiple products
    Given There is 1 product item with 0% discount of locale <locale> with price between 50 and 500 and inventory between 5 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> with 4 units for product item product1#skuPartNumber with forced accepted cookies
      And I see Experience.Header.ShoppingBagCounter contains text "4"
      And I store the numeric value of Experience.ShoppingBag.SubTotalPriceInfo with key #subtotal
    Then the numeric value of Experience.ShoppingBag.TotalPriceInfo is equal to #subtotal
      And I see Experience.ShoppingBag.TotalPriceLabel contains text "4"

    @tms:UTR-5627
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16436
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Mobile
  @Chrome @SafariPending @P2
  @ShoppingBag @OverviewPanel @UnifiedCheckout
  @feature:CET1-3307
  Scenario Outline: Shopping Bag Overview Mobile - Verify total price calculation without promocode for multiple products
    Given There is 1 product item with 0% discount of locale <locale> with price between 50 and 500 and inventory between 5 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> with 4 units for product item product1#skuPartNumber with forced accepted cookies
      And I see Experience.Header.ShoppingBagCounter contains text "4"
      And I store the numeric value of Experience.ShoppingBag.SubTotalPriceInfo with key #subtotal
    Then the numeric value of Experience.ShoppingBag.TotalPriceInfo is equal to #subtotal
      And I see Experience.ShoppingBag.TotalPriceLabel contains text "4"
      And the numeric value of Experience.ShoppingBag.MobileTotalPriceInfo is equal to #subtotal

    @tms:UTR-5625
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16440
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |
