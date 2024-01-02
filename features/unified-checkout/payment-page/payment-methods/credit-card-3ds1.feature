Feature: Unified Checkout - Payment Methods - Credit Card 3DS1

  #3DS1 cards are no longer supported
  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @CreditCard @3DS1
  Scenario Outline: Credit card - As guest or user I see logo of card type entered and I can complete payment
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | cvv        | <cvv>      |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | Automation |
      | lastName   | QA         |
    When I set the checkbox Checkout.PaymentPage.TermsAndConditionsCheckbox status to true
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then URL should contain "validate" within 15 seconds
    When with user "user" and password "password" I complete 3DS1 payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-5179
    Examples:
      | locale  | langCode | userType | card                | cvv | type |
      | default | default  | guest    | 4212 3456 7890 1237 | 737 | visa |

    @tms:UTR-5373
    Examples:
      | locale  | langCode | userType | card                | cvv | type |
      | default | default  | guest    | 5212 3456 7890 1234 | 737 | mc   |

    @tms:
    Examples:
      | locale           | langCode         | userType | card                | cvv | type |
      | multiLangDefault | multiLangDefault | guest    | 5212 3456 7890 1234 | 737 | mc   |

    @tms:
    Examples:
      | locale           | langCode         | userType  | card                | cvv | type    |
      | multiLangDefault | multiLangDefault | logged in | 6771 8309 9999 1239 | 737 | maestro |

  #3DS1 cards are no longer supported
  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @CreditCard @3DS1
  Scenario Outline: Credit card - As guest or user I can pay with credit card 3ds1 if I enter a different billing address
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I set the checkbox Checkout.PaymentPage.SameAsShippingCheckbox status to false
    When I add first billing details
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | cvv        | <cvv>      |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | Automation |
      | lastName   | QA         |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then URL should contain "validate" within 15 seconds
    When with user "user" and password "password" I complete 3DS1 payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-5347
    Examples:
      | locale  | langCode | userType | card                | cvv |
      | default | default  | guest    | 4212 3456 7890 1237 | 737 |

    @tms:UTR-5376
    Examples:
      | locale  | langCode | userType  | card               | cvv  |
      | default | default  | logged in | 3451 7792 5488 348 | 7373 |

    @tms:
    Examples:
      | locale           | langCode         | userType | card                | cvv |
      | multiLangDefault | multiLangDefault | guest    | 4212 3456 7890 1237 | 737 |

    @tms:
    Examples:
      | locale           | langCode         | userType  | card               | cvv  |
      | multiLangDefault | multiLangDefault | logged in | 3451 7792 5488 348 | 7373 |

  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @CreditCard @3DS1 @Negative
  Scenario Outline: Credit card - As guest or user I can pay with credit card 3ds1 and use back functionality
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | cvv        | 737        |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | Automation |
      | lastName   | QA         |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And URL should contain "validate" within 15 seconds
    When I navigate back in the browser
    Then URL should contain "/checkout/payment" within 15 seconds
      And I see Checkout.ShippingPage.PLDItem with args product1#skuPartNumber is displayed
    When I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | cvv        | 737        |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | Automation |
      | lastName   | QA         |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then URL should contain "validate" within 15 seconds
    When with user "user" and password "password" I complete 3DS1 payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-5343
    Examples:
      | locale  | langCode | userType | card                |
      | default | default  | guest    | 6771 8309 9999 1239 |

    @tms:UTR-5377
    Examples:
      | locale  | langCode | userType  | card                |
      | default | default  | logged in | 5212 3456 7890 1234 |

    @tms:
    Examples:
      | locale           | langCode         | userType | card                |
      | multiLangDefault | multiLangDefault | guest    | 6771 8309 9999 1239 |

    @tms:
    Examples:
      | locale           | langCode         | userType  | card                |
      | multiLangDefault | multiLangDefault | logged in | 5212 3456 7890 1234 |

  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @3DS1
  Scenario Outline: Credit card - As guest or user I can pay with credit card 3ds1 after adding promo code
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I click on Checkout.OverviewPanel.EnterPromoCodeButton
      And I get checkout search data for "promocode" and store it with key #Promo
      And I type "#Promo" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Checkout.OverviewPanel.PromoCodeApplyButton
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | cvv        | 737        |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | Automation |
      | lastName   | QA         |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then URL should contain "validate" within 15 seconds
    When with user "user" and password "password" I complete 3DS1 payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-5346
    Examples:
      | locale  | langCode | userType | card                |
      | default | default  | guest    | 4212 3456 7890 1237 |

    @tms:UTR-5378
    Examples:
      | locale  | langCode | userType  | card                |
      | default | default  | logged in | 5212 3456 7890 1234 |

    @tms:
    Examples:
      | locale           | langCode         | userType | card                |
      | multiLangDefault | multiLangDefault | guest    | 4212 3456 7890 1237 |

    @tms:
    Examples:
      | locale           | langCode         | userType  | card                |
      | multiLangDefault | multiLangDefault | logged in | 5212 3456 7890 1234 |

  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @PaymentMethods @CreditCard @3DS1 @Negative @P2
  @tms:UTR-5348
  Scenario Outline: Credit card - As guest I can't pay with credit card 3ds1 if the amount is above the payment limit
    Given There is 1 normal size product items of locale <locale> and langCode <langCode> with inventory between 800 and 9999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am on locale <locale> shopping bag page of langCode <langCode> with 800 units for product items product1#skuPartNumber
      And I am on locale <locale> of url shopping-bag of langCode <langCode>
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I click on Checkout.SignInPage.ProceedAsGuestButton
      And as a guest I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 6771 8309 9999 1239 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I get credit card payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#PaymentLimit"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed

    Examples:
      | locale | langCode |
      | at     | default  |

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @PaymentMethods @CreditCard @3DS1 @Negative @P2
  @tms:UTR-5344
  Scenario Outline: Credit card - As user I can't pay with credit card 3ds1 if the amount is above the payment limit
    Given There is 1 normal size product items of locale <locale> and langCode <langCode> with inventory between 800 and 9999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I am on locale <locale> shopping bag page of langCode <langCode> with 800 units for product items product1#skuPartNumber
      And I am on locale <locale> of url shopping-bag of langCode <langCode>
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a logged in I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 4212 3456 7890 1237 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I get credit card payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#PaymentLimit"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed

    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation
  @UnifiedCheckout @PaymentPage @PaymentMethods @CreditCard @3DS1 @Negative @P2
  Scenario Outline: Credit card - As guest or user I get and error and I can't pay with 3DS1 if the card details are wrong
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | cvv        | <cvv>      |
      | year       | <year>     |
      | month      | 03         |
      | firstName  | Automation |
      | lastName   | QA         |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then URL should contain "validate" within 15 seconds
    When with user "user" and password "password" I complete 3DS1 payment
      And I get translation from lokalise for "TechnicalError" and store it with key #TechnicalError
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#TechnicalError"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed

    @tms:UTR-5345
    Examples:
      | locale  | langCode | userType | card                | cvv | year |
      | default | default  | guest    | 4212 3456 7890 1237 | 348 | 2030 |

    @tms:UTR-5379
    Examples:
      | locale  | langCode | userType  | card                | cvv | year |
      | default | default  | logged in | 5212 3456 7890 1234 | 737 | 2045 |

    @tms:
    Examples:
      | locale           | langCode         | userType | card                | cvv | year |
      | multiLangDefault | multiLangDefault | guest    | 4212 3456 7890 1237 | 348 | 2030 |

    @tms:
    Examples:
      | locale           | langCode         | userType  | card                | cvv | year |
      | multiLangDefault | multiLangDefault | logged in | 5212 3456 7890 1234 | 737 | 2045 |

  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation
  @UnifiedCheckout @PaymentPage @PaymentMethods @CreditCard @3DS1 @Negative @P2
  Scenario Outline: Credit card - As guest or user I get and error and I can't pay with credit card 3ds1 if 3ds1 info is wrong
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | cvv        | 737        |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | Automation |
      | lastName   | QA         |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    When with user "<user>" and password "<password>" I complete 3DS1 payment
      And I get translation from lokalise for "AuthenticationError" and store it with key #AuthentificationError
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#AuthentificationError"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed

    @tms:UTR-5349
    Examples:
      | locale  | langCode | userType | card                | user    | password |
      | default | default  | guest    | 4212 3456 7890 1237 | Mohamed | password |

    @tms:UTR-5380
    Examples:
      | locale  | langCode | userType  | card                | user | password |
      | default | default  | logged in | 5212 3456 7890 1234 | user | Ali      |

    @tms:
    Examples:
      | locale           | langCode         | userType | card                | user    | password |
      | multiLangDefault | multiLangDefault | guest    | 4212 3456 7890 1237 | Mohamed | password |

    @tms:
    Examples:
      | locale           | langCode         | userType  | card                | user | password |
      | multiLangDefault | multiLangDefault | logged in | 5212 3456 7890 1234 | user | Ali      |