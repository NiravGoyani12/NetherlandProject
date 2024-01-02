Feature: Unified Checkout - Payment Methods - Credit Card

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @P3
  Scenario Outline: Credit card - As guest or user I see logo of card type entered and I can complete payment
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
      And I store the cartId
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | cvv        | <cvv>      |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | Automation |
      | lastName   | QA         |
    Then I see Checkout.PaymentPage.CreditDebitCardNumberLogo with args <type> is displayed
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10416 @Mobile
    Examples:
      | locale  | langCode | userType | card                | cvv | type |
      | default | default  | guest    | 4000 0200 0000 0000 | 737 | visa |

    # @tms:UTR-10420
    # Examples:
    #   | locale  | langCode | userType  | card               | cvv  | type |
    #   | default | default  | logged in | 3700 0000 0100 018 | 7373 | amex |

    @tms:UTR-10560
    Examples:
      | locale           | langCode         | userType | card                | cvv | type |
      | multiLangDefault | multiLangDefault | guest    | 5100 2900 2900 2909 | 737 | mc   |

    @tms:UTR-10561 @Mobile
    Examples:
      | locale           | langCode         | userType  | card                | cvv | type |
      | multiLangDefault | multiLangDefault | logged in | 4111 1111 1111 1111 | 737 | visa |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @HappyFlow
  Scenario Outline: Credit card - As guest or user I can pay with credit card if I enter a different billing address
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
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
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10424 @Mobile
    Examples:
      | locale  | langCode | userType | card                | cvv |
      | default | default  | guest    | 5100 2900 2900 2909 | 737 |

    # @tms:UTR-10431
    # Examples:
    #   | locale  | langCode | userType  | card               | cvv  |
    #   | default | default  | logged in | 3700 0000 0100 018 | 7373 |

    # @tms:UTR-10562
    # Examples:
    #   | locale           | langCode         | userType | card                | cvv |
    #   | multiLangDefault | multiLangDefault | guest    | 5100 2900 2900 2909 | 737 |

    @tms:UTR-10563
    Examples:
      | locale           | langCode         | userType  | card                | cvv |
      | multiLangDefault | multiLangDefault | logged in | 5100 2900 2900 2909 | 737 |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @Negative @P2
  Scenario Outline: Credit Card - As guest or user using invalid card details will show error messages
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I get translation for "CreditCardErrorMessage" and store it with key #creditCardErrorMessage
      And I get translation for "ExpiryDateErrorMessage" and store it with key #expiryDateErrorMessage
      And I get translation for "CvvErrorErrorMessage" and store it with key #cvvErrorErrorMessage
      And I get translation for "HolderNameErrorMessage" and store it with key #holderNameErrorMessage
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value |
      | cardNumber | 1234  |
      | firstName  |       |
      | lastName   |       |
      | cvv        | 1     |
      | year       | 1     |
      | month      | 1     |
      And I scroll to the element Checkout.PaymentPage.PlaceOrderButton
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.PaymentPage.CreditCardErrorMessage with text #creditCardErrorMessage is displayed
      And I see Checkout.PaymentPage.ExpiryDateErrorMessage with text #expiryDateErrorMessage is displayed
      And I see Checkout.PaymentPage.CvvErrorErrorMessage with text #cvvErrorErrorMessage is displayed
      And I see Checkout.PaymentPage.HolderNameErrorMessage with text #holderNameErrorMessage is displayed
      And I see Checkout.PaymentPage.TermsAndConditionsCheckboxError is displayed in 10 seconds is displayed

    @tms:UTR-10425
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-10426 @Mobile
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  # @tms:UTR-10564
  # Examples:
  #   | locale | langCode | userType | Error1                            | Error2                               | Error3                             | Error4                                        |
  #   | be     | FR       | guest    | Entrez le numéro de carte complet | Entrez la date d'expiration complète | Entrez le code de sécurité complet | Entrez le nom tel qu'il apparaît sur la carte |

  # @tms:UTR-10565
  # Examples:
  #   | locale           | langCode | userType  | Error1                            | Error2                               | Error3                             | Error4                                        |
  #   | multiLangDefault | FR       | logged in | Entrez le numéro de carte complet | Entrez la date d'expiration complète | Entrez le code de sécurité complet | Entrez le nom tel qu'il apparaît sur la carte |

  # @tms:UTR-10564 @Mobile
  # Examples:
  #   | locale           | langCode | userType | Error1                                             | Error2                                             | Error3                                              | Error4                                   |
  #   | multiLangDefault | IT       | guest    | La lunghezza del numero della carta non è corretta | La lunghezza del numero della carta non è corretta | La lunghezza del codice di sicurezza non è corretta | Nome del titolare della carta non valido |

  # @tms:UTR-10565
  # Examples:
  #   | locale           | langCode | userType  | Error1                                             | Error2                                             | Error3                                              | Error4                                   |
  #   | multiLangDefault | IT       | logged in | La lunghezza del numero della carta non è corretta | La lunghezza del numero della carta non è corretta | La lunghezza del codice di sicurezza non è corretta | Nome del titolare della carta non valido |


  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @Negative @P2
  Scenario Outline: Credit card - As guest or user I can pay with credit card and use back functionality
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
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
    When I navigate back in the browser
    Then URL should contain "/checkout/shipping" within 15 seconds
      And I see Checkout.ShippingPage.PLDItem with args product1#skuPartNumber is displayed
    When I click on Checkout.ShippingPage.ProceedToPayment
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
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10430
    Examples:
      | locale  | langCode | userType | card                |
      | default | default  | guest    | 4000 0200 0000 0000 |

    # @tms:UTR-10422 @Mobile
    # Examples:
    #   | locale  | langCode | userType  | card                |
    #   | default | default  | logged in | 5100 2900 2900 2909 |

    # @tms:UTR-10567 @Mobile
    # Examples:
    #   | locale           | langCode         | userType | card                |
    #   | multiLangDefault | multiLangDefault | guest    | 4000 0200 0000 0000 |

    @tms:UTR-10568 @Mobile
    Examples:
      | locale           | langCode         | userType  | card                |
      | multiLangDefault | multiLangDefault | logged in | 5100 2900 2900 2909 |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @HappyFlow
  Scenario Outline: Credit card - As guest or user I can pay with credit card after adding promo code
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
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
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10423 @Mobile
    Examples:
      | locale  | langCode | userType | card                |
      | default | default  | guest    | 4000 0200 0000 0000 |

    # @tms:UTR-10429 @P2
    # Examples:
    #   | locale  | langCode | userType  | card                |
    #   | default | default  | logged in | 5100 2900 2900 2909 |

    # @tms:UTR-10570 @P2
    # Examples:
    #   | locale           | langCode         | userType | card                |
    #   | multiLangDefault | multiLangDefault | guest    | 4000 0200 0000 0000 |

    @tms:UTR-10571
    Examples:
      | locale           | langCode         | userType  | card                |
      | multiLangDefault | multiLangDefault | logged in | 5100 2900 2900 2909 |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @Negative @P2
  Scenario Outline: Credit card - As guest I can't pay with credit card if the amount is above the payment limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 200 and 5000 and inventory between 100 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 40 units for product items product1#skuPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as guest to shipping page
      And as a guest I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 4000 0200 0000 0000 |
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

    @tms:UTR-10415 @Mobile
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10572
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @Negative @P2
  Scenario Outline: Credit card - As user I can't pay with credit card if the amount is above the payment limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 200 and 5000 and inventory between 100 and 9999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I am on locale <locale> shopping bag page of langCode <langCode> with 40 units for product items product1#skuPartNumber
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a logged in I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
    When I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 5100 2900 2900 2909 |
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

    @tms:UTR-10418
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10573 @Mobile
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @Negative @P2
  Scenario Outline: Credit card - As guest or user I get and error and I can't pay with credit card if the card is not supported
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value         |
      | cardNumber | <card>        |
      | cvv        | 737           |
      | year       | 2030          |
      | month      | 03            |
      | firstName  | NOT_SUPPORTED |
      | lastName   |               |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I get translation from lokalise for "UnsupportedCreditCardError" and store it with key #UnsupportedCard
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#UnsupportedCard"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed

    @tms:UTR-10428
    Examples:
      | locale  | langCode | userType | card              |
      | default | default  | guest    | 3607 0500 0010 20 |

    @tms:UTR-10574 @Mobile
    Examples:
      | locale           | langCode         | userType  | card              |
      | multiLangDefault | multiLangDefault | logged in | 3607 0500 0010 20 |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @Negative @P2
  Scenario Outline: Credit card - As guest or user I get and error and I can't pay with credit card if the card details are wrong
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
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
      And I get translation from lokalise for "TechnicalError" and store it with key #TechnicalError
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#TechnicalError"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed

    # @tms:UTR-10421
    # Examples:
    #   | locale  | langCode | userType | card                | cvv | year |
    #   | default | default  | guest    | 4000 0200 0000 0000 | 348 | 2030 |

    @tms:UTR-10419 @Mobile
    Examples:
      | locale  | langCode | userType  | card                | cvv | year |
      | default | default  | logged in | 5100 2900 2900 2909 | 737 | 2025 |

    @tms:UTR-10575 @Mobile
    Examples:
      | locale           | langCode         | userType | card                | cvv | year |
      | multiLangDefault | multiLangDefault | guest    | 4000 0200 0000 0000 | 348 | 2030 |

  # @tms:UTR-10576
  # Examples:
  #   | locale           | langCode         | userType  | card                | cvv | year |
  #   | multiLangDefault | multiLangDefault | logged in | 5100 2900 2900 2909 | 737 | 2025 |


  @FullRegression
  @Desktop
  @Chrome @FireFox @Translation
  @UnifiedCheckout @PaymentPage @CreditCard
  Scenario Outline: Credit Card Component Labels - I can see credit card labels are shown
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until the current page is loaded
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And I get translation for "CardNumberLabel" and store it with key #cardNumberLabel
      And I get translation for "ExpiryDateLabel" and store it with key #expiryDateLabel
      And I get translation for "SecurityCodeLabel" and store it with key #securityCodeLabel
      And I get translation for "CardNameLabel" and store it with key #cardNameLabel
    Then I see Payments.CreditCardPage.CardNumberFieldLabel contains text "#cardNumberLabel"
    Then I see Payments.CreditCardPage.ExpiryDateFieldLabel contains text "#expiryDateLabel"
    Then I see Payments.CreditCardPage.SecurityCodeFieldLabel contains text "#securityCodeLabel"
    Then I see Payments.CreditCardPage.CardNameFieldLabel contains text "#cardNameLabel"

    @tms:UTR-13443
    Examples:
      | locale  | langCode | userType | cardNumber  | expiryDate  | securityCode | cardName     |
      | default | default  | guest    | Card number | Expiry date | CVC / CVV    | Name on card |

    # @tms:UTR-14385
    # Examples:
    #   | locale | langCode | userType  | cardNumber  | expiryDate  | securityCode | cardName      |
    #   | nl     | default  | logged in | Kaartnummer | Vervaldatum | CVC / CVV    | Naam op kaart |

    # @tms:UTR-14386
    # Examples:
    #   | locale | langCode | userType | cardNumber   | expiryDate  | securityCode | cardName           |
    #   | de     | default  | guest    | Kartennummer | ablaufdatum | CVC / CVV    | Name auf der Karte |

    @tms:UTR-14831
    Examples:
      | locale           | langCode         | userType | cardNumber  | expiryDate  | securityCode | cardName     |
      | multiLangDefault | multiLangDefault | guest    | Card number | Expiry date | CVC / CVV    | Name on card |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @P3
  Scenario Outline: Credit card - As guest or user I can't place an order due to Fraud Error
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value           |
      | cardNumber | <card>          |
      | cvv        | <cvv>           |
      | year       | 2030            |
      | month      | 03              |
      | firstName  | FRAUD_CANCELLED |
      | lastName   |                 |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I get translation from lokalise for "FraudError" and store it with key #FraudError
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#FraudError"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed

    @tms:UTR-13547 @Mobile
    Examples:
      | locale  | langCode | userType | card                | cvv |
      | default | default  | guest    | 4000 0200 0000 0000 | 737 |

    # @tms:UTR-13548
    # Examples:
    #   | locale           | langCode         | userType  | card                | cvv |
    #   | multiLangDefault | multiLangDefault | logged in | 4111 1111 1111 1111 | 737 |
