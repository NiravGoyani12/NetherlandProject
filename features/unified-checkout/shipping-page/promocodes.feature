Feature: Unified Checkout - Promocodes on shipping page

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Promocodes @OverviewPanel @Payment @P2
  Scenario Outline: Promocodes - As a guest/user I want to successfully place an order with a promocode applied on Shipping page
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I apply promocode "#Promo" in the overview panel and store the discounted amount with key #DiscountedAmount
    Then I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
      And as a guest I add first delivery details
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed in 7 seconds
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

    @tms:UTR-11102 @Mobile
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-11103
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShippingPage @Promocode @OverviewPanel @Payment @P2
  Scenario: Promocodes - Adding Promocodes with valid data on the Shipping page
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And in DB I extract the shipping promo threshold save to #ShipingPromoThreshold
      And There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between #ShipingPromoThreshold and 10000 and inventory between 1 and 9999
      And I wait for 2 seconds
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I am on locale <locale> of url shopping-bag of langCode <langCode>
      And I clear shopping bag for the registered user of this locale
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I apply promocode "#Promo" in the overview panel and store the discounted amount with key #DiscountedAmount
    When I store the numeric value of Checkout.OverviewPanel.SubTotalPriceInfo with key #SubtotalAmount
      And I subtract #DiscountedAmount from #SubtotalAmount and save to #TotalPriceWithPromoCode
    Then the numeric value of Checkout.OverviewPanel.TotalPriceInfo is equal to #TotalPriceWithPromoCode
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds

    @tms:UTR-11106
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-11109
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShippingPage @Promocode @OverviewPanel @P2
  Scenario: Promocodes - Removing Promocodes with valid data on the Shipping page
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I apply promocode "#Promo" in the overview panel and store the discounted amount with key #DiscountedAmount
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
      And I click on Checkout.OverviewPanel.PromoCodeRemoveButton
      And I see Checkout.OverviewPanel.EnterPromoCodeButton is clickable

    @tms:UTR-11110
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-11113
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @UnifiedCheckout @ItemOnSale @ShippingPage @P2
  Scenario Outline: Item on sale - As guest or user I can see product on sale on Shipping page
    Given There is 1 discounted product item of locale <locale> and langCode <langCode> with inventory between 1 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until the current page is loaded
      And I continue as <userType> to shipping page
      And I wait until the current page is loaded
    Then I see Checkout.ShippingPage.PLDItemWasPrice is displayed
      And I see Checkout.ShippingPage.PLDItemCurrentPrice is displayed

    @tms:UTR-11114
    Examples:
      | locale  | langCode | userType  |
      | default | default  | logged in |

    @tms:UTR-11117
    Examples:
      | locale           | langCode         | userType |
      | multiLangDefault | multiLangDefault | guest    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @Promocode @ShippingPage @P2
  Scenario Outline: Shipping promotion - As guest I can see shipping promotion on shipping page even after adding a promocode
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And in DB I extract the shipping promo threshold save to #ShipingPromoThreshold
      And I add "15" to numeric store value #ShipingPromoThreshold save to #SuperiorMargin
      And There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between #ShipingPromoThreshold and #SuperiorMargin and inventory between 1 and 9999
      And I wait for 2 seconds
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I am on locale <locale> of url shopping-bag of langCode <langCode>
      And I clear shopping bag for the registered user of this locale
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And I get translation from lokalise for "FreeCosts" and store it with key #FreeShippingCosts
    Then I see Checkout.OverviewPanel.ShippingPrice contains text "#FreeShippingCosts"
      And I store the value of Checkout.OverviewPanel.ShippingPrice with key #ShippingPrice
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I apply promocode "#Promo" in the overview panel and store the discounted amount with key #DiscountedAmount
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
      And the values of displayed elements Checkout.OverviewPanel.ShippingPrice should be equal to the stored values with key #ShippingPrice

    @tms:UTR-11118
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-11119 @Mobile
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Promocodes @OverviewPanel @Payment @P2
  Scenario Outline: Promocodes - As a guest/user I want to add a promocode that expires, add a new one and finish payment
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I get checkout search data for "ExpiryPromoCode" and store it with key #ExpiryPromo
    When I apply promocode "#ExpiryPromo" in the overview panel and store the discounted amount with key #DiscountedAmount
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
    Then I see Checkout.OverviewPanel.DiscountLabel is displayed
      And as a <userType> I add first delivery details
    When I deactivate promocode "#ExpiryPromo" in the DB
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed in 7 seconds
    Then I see Checkout.OverviewPanel.DiscountLabel is not displayed
      And I see Checkout.OverviewPanel.EnterPromoCodeButton is displayed
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I apply promocode "#Promo" in the overview panel and store the discounted amount with key #DiscountedAmount
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
    Then I see Checkout.OverviewPanel.DiscountLabel is displayed
    When I click on Checkout.PaymentPage.CreditCardButton
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
    When I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Then I see Checkout.OverviewPanel.DiscountLabel is displayed
      And I activate promocode "#ExpiryPromo" in the DB

    @tms:UTR-18033 @Mobile
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-18034
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @Promocodes @OverviewPanel @PaymentPage @Payment @P2
  Scenario Outline: Promocodes - As a guest/user I want to check if I can't pay for an order with an expired promo
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I wait until the current page is shipping page
      And as a <userType> I add first delivery details
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed in 7 seconds
      And I get checkout search data for "ExpiryPromoCode" and store it with key #ExpiryPromo
    When I apply promocode "#ExpiryPromo" in the overview panel and store the discounted amount with key #DiscountedAmount
    Then I see Checkout.OverviewPanel.DiscountLabel is displayed
    When I deactivate promocode "#ExpiryPromo" in the DB
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
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed
      And I get translation from lokalise for "InvalidPromoCode" and store it with key #invalidPromo
      And I see the current page is payment page
      And I wait until Checkout.ShippingPage.ErrorNotification is displayed
    Then I see Checkout.ShippingPage.ErrorNotification contains text "#invalidPromo"
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed
      And I activate promocode "#ExpiryPromo" in the DB

    @tms:UTR-18035 @Mobile
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-18036
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |