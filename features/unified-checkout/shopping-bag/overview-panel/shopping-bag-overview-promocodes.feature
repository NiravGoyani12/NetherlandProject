Feature: Unified Shopping Bag - Promotion

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Promocode @ShoppingBag @OverviewPanel @UnifiedCheckout @P2
  @feature:CET1-3307
  Scenario Outline: Promocodes - Using invalid Promocodes throws error on shopping bag page
    Given I am on locale <locale> shopping bag page with 1 unit of any product with forced accepted cookies
    When I type "<promoCode>" in the field Experience.ShoppingBag.PromoCodeField
      And I click on Experience.ShoppingBag.PromoCodeApplyButton
    Then I see Experience.ShoppingBag.PromoCodeErrorMsg is displayed

    @tms:UTR-2192
    Examples:
      | locale  | promoCode |
      | default |           |

    @tms:UTR-15728
    Examples:
      | locale           | promoCode |
      | multiLangDefault | ASD       |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Promocode @ShoppingBag @OverviewPanel @UnifiedCheckout
  @feature:CET1-3307
  Scenario Outline: Promocodes - Using Promocodes with valid data on the shopping bag page
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product with forced accepted cookies
    When I store the numeric value of Experience.ShoppingBag.TotalPriceInfo with key #totalPrice
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I type "#Promo" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Experience.ShoppingBag.PromoCodeApplyButton
    Then I see Experience.ShoppingBag.PromoCodeRemoveButton is displayed
      And I see Experience.ShoppingBag.PromoCodeDiscountInfo is displayed
      And the numeric value of Experience.ShoppingBag.PromoCodeDiscountInfo is greater than 0
    When I store the numeric value of Experience.ShoppingBag.PromoCodeDiscountInfo with key #discount
      And I subtract #discount from #totalPrice and save to #updatedTotalPrice
    Then the numeric value of Experience.ShoppingBag.TotalPriceInfo is equal to #updatedTotalPrice

    @tms:UTR-2193 @P1
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16424
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Promocode @ShoppingBag @OverviewPanel @UnifiedCheckout @P2
  @feature:CET1-3307
  Scenario Outline: Promocodes - Removing a valid promocode on the shopping bag page
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product with forced accepted cookies
    When I store the numeric value of Experience.ShoppingBag.TotalPriceInfo with key #totalPrice
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I type "#Promo" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Experience.ShoppingBag.PromoCodeApplyButton
    Then I see Experience.ShoppingBag.PromoCodeRemoveButton is displayed
    When I click on Experience.ShoppingBag.PromoCodeRemoveButton
    Then I see Experience.ShoppingBag.PromoCodeDiscountInfo is not displayed in 5 seconds
      And I see Experience.ShoppingBag.PromoCodeField is displayed
      And the numeric value of Experience.ShoppingBag.TotalPriceInfo is equal to #totalPrice

    @tms:UTR-2194
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16425
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @P2
  @Promocode @ShoppingBag @OverviewPanel @UnifiedCheckout
  @feature:CET1-3307
  Scenario Outline: Promocodes - Adding a valid promocode and editing quantity will show correct pricing on the shopping bag page
    Given There is 1 normal size product items of locale <locale> with inventory between 11 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I see Experience.Header.ShoppingBagCounter contains text "1"
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I type "#Promo" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Experience.ShoppingBag.PromoCodeApplyButton
      And I wait until Experience.ShoppingBag.PromoCodeRemoveButton is displayed
      And I store the numeric value of Experience.ShoppingBag.TotalPriceInfo with key #totalPriceInfo
      And I store the numeric value of Experience.ShoppingBag.PromoCodeDiscountInfoTotal with key #promocodeDiscount
      And I scroll to and click on Experience.ShoppingBag.EditProductButton with args product1#skuPartNumber
      And in page Experience.ShoppingBag edit quantity dropdown of product item product1#skuPartNumber I select the highest instock quantity saved as #quantity
      And I click on Experience.ShoppingBag.EditSaveButton with args product1#skuPartNumber
      And I wait until Experience.ShoppingBag.ItemLoader is not displayed
    Then the numeric value of Experience.ShoppingBag.TotalPriceInfo is greater than #totalPriceInfo
      And the numeric value of Experience.ShoppingBag.PromoCodeDiscountInfoTotal is greater than #promocodeDiscount

    @tms:UTR-2195
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16425
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @Promocode @OverviewPanel @UnifiedCheckout @P3
  @feature:CET1-3305
  Scenario Outline: Shopping bag checkout - Going back from PayPal Express will not break promocodes on shopping bag page
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product with forced accepted cookies
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I type "#Promo" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Experience.ShoppingBag.PromoCodeApplyButton
      And I wait until Experience.ShoppingBag.PromoCodeRemoveButton is displayed
    When I click on Experience.ShoppingBag.CheckoutWithPaypalButton
      And I set the checkbox Experience.ShoppingBag.PaypalTermsAndConditionCheckBox status to true if exist
      And I click on Experience.ShoppingBag.PaypalTermsAndConditionCheckoutButton if displayed
      And URL should contain "paypal.com" in 15 seconds
      And I navigate back in the browser
    Then I see Experience.ShoppingBag.PromoCodeRemoveButton is displayed
      And I see Experience.ShoppingBag.StartCheckoutButton is displayed
      And the count of elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.OverviewSection is displayed

    @tms:UTR-2240
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-15640
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |
