Feature: Unified Checkout - Promocodes on payment page

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @PaymentPage @Promocode @HappyFlow @Promotion
  Scenario Outline: Promocodes - As guest I can place order with Promocodes with valid data on the payment page
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
      And I get checkout search data for "PromoCode" and store it with key #Promo
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed in 7 seconds
    When I apply promocode "#Promo" in the overview panel and store the discounted amount with key #DiscountedAmount
    Then I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | element    | value               |
      | cardNumber | 4111 1111 1111 1111 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | QA                  |
      | lastName   | Automation          |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10457 @Mobile
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-10458
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Translation @Lokalise
  @UnifiedCheckout @PaymentPage @Promocode @P2 @Promotion
  Scenario: Promocodes - Adding Promocodes with valid data on the payment page and checking costs
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And in DB I extract the shipping promo threshold save to #ShipingPromoThreshold
      And There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between #ShipingPromoThreshold and 99999 and inventory between 1 and 9999
      And I wait for 2 seconds
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I am on locale <locale> of url shopping-bag of langCode <langCode>
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a <userType> I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I get checkout search data for "PromoCode" and store it with key #Promo
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed in 7 seconds
    When I apply promocode "#Promo" in the overview panel and store the discounted amount with key #DiscountedAmount
      And I get translation from lokalise for "PromotionApplied" and store it with key #AppliedPromo
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
    Then I see Checkout.ShippingPage.PLDAppliedPromo with args product1#skuPartNumber contains text "#AppliedPromo"
    When I store the numeric value of Checkout.OverviewPanel.SubTotalPriceInfo with key #SubtotalAmount
      And I subtract #DiscountedAmount from #SubtotalAmount and save to #TotalPriceWithPromoCode
    Then the numeric value of Checkout.OverviewPanel.TotalPriceInfo is equal to #TotalPriceWithPromoCode

    @tms:UTR-10459
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-10462
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @PaymentPage @Promocode @P2 @Promotion
  Scenario: Promocodes - Removing Promocodes with valid data on the payment page
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed in 7 seconds
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I apply promocode "#Promo" in the overview panel and store the discounted amount with key #DiscountedAmount
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
      And I click on Checkout.OverviewPanel.PromoCodeRemoveButton
      And I see Checkout.OverviewPanel.EnterPromoCodeButton is clickable

    @tms:UTR-10463 @Mobile
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    # @tms:UTR-10466
    # Examples:
    #   | locale  | langCode | userType  |
    #   | default | default  | logged in |

    # @tms:UTR-10464
    # Examples:
    #   | locale           | langCode         | userType |
    #   | multiLangDefault | multiLangDefault | guest    |

    @tms:UTR-10465 @Mobile
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ItemOnSale @PaymentPage @Promotion @P2
  Scenario Outline: Item on sale - As guest or user I can see product on sale on Payment page
    Given There is 1 discounted product item of locale <locale> and langCode <langCode> with inventory between 1 and 9999
    Then I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And as a <userType> I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
    Then I see Checkout.ShippingPage.PLDItemWasPrice is displayed
      And I see Checkout.ShippingPage.PLDItemCurrentPrice is displayed

    @tms:UTR-10467 @Mobile
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    # @tms:UTR-10468
    # Examples:
    #   | locale  | langCode | userType  |
    #   | default | default  | logged in |

    # @tms:UTR-10470
    # Examples:
    #   | locale           | langCode         | userType |
    #   | multiLangDefault | multiLangDefault | guest    |

    @tms:UTR-10469 @Mobile
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Translation
  @UnifiedCheckout @PaymentPage @Promocode @P2 @Promotion
  Scenario Outline: Shipping promotion - As guest I can see shipping promotion on payment page even after adding a promocode
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And in DB I extract the shipping promo threshold save to #ShipingPromoThreshold
      And I add "15" to numeric store value #ShipingPromoThreshold save to #SuperiorMargin
      And There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between #ShipingPromoThreshold and #SuperiorMargin and inventory between 1 and 9999
      And I wait for 2 seconds
    When I am a <userType> user
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber
      And I am on locale <locale> of url shopping-bag of langCode <langCode>
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until the current page is loaded
      And I continue as <userType> to shipping page
      And I wait for 2 seconds
      And as a <userType> I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I get translation from lokalise for "FreeCosts" and store it with key #FreeShippingCosts
    Then I see Checkout.OverviewPanel.ShippingPrice contains text "#FreeShippingCosts"
      And I store the value of Checkout.OverviewPanel.ShippingPrice with key #ShippingPrice
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I apply promocode "#Promo" in the overview panel and store the discounted amount with key #DiscountedAmount
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
      And the values of displayed elements Checkout.OverviewPanel.ShippingPrice should be equal to the stored values with key #ShippingPrice

    @tms:UTR-10471 @Mobile
    Examples:
      | locale  | userType | langCode |
      | default | guest    | default  |

    @tms:UTR-10472
    Examples:
      | locale           | userType | langCode         |
      | multiLangDefault | guest    | multiLangDefault |
