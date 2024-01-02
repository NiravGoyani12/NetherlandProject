Feature: Unified Checkout - Payment Methods - Credit Card 3DS2

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @3DS2 @P3
  Scenario Outline: Credit card - As guest or user I see logo of 3ds2 card type entered and I can complete payment
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
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

    # @tms:UTR-10412
    # Examples:
    #   | locale  | langCode | userType | card               | cvv  | type |
    #   | default | default  | guest    | 3714 4963 5398 431 | 7373 | amex |

    @tms:UTR-10407 @Mobile
    Examples:
      | locale  | langCode | userType  | card                | cvv | type |
      | default | default  | logged in | 4917 6100 0000 0000 | 737 | visa |

    @tms:UTR-10665
    Examples:
      | locale           | langCode         | userType | card                | cvv  | type |
      | multiLangDefault | multiLangDefault | guest    | 5454 5454 5454 5454 | 7373 | mc   |

  # @tms:UTR-10666 @Mobile
  # Examples:
  #   | locale           | langCode         | userType  | card                | cvv | type |
  #   | multiLangDefault | multiLangDefault | logged in | 4917 6100 0000 0000 | 737 | visa |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @3DS2 @HappyFlow
  Scenario Outline: Credit card - As guest or user I can pay with 3DS2 frictionless
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | firstName  | Automation |
      | lastName   | QA         |
      | cvv        | 737        |
      | year       | 2030       |
      | month      | 03         |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10404 @Mobile
    Examples:
      | locale  | langCode | userType | card                |
      | default | default  | guest    | 5201 2815 0512 9736 |

    # @tms:UTR-10400
    # Examples:
    #   | locale  | langCode | userType  | card                |
    #   | default | default  | logged in | 5201 2815 0512 9736 |

    # @tms:UTR-10667
    # Examples:
    #   | locale           | langCode         | userType | card                |
    #   | multiLangDefault | multiLangDefault | guest    | 5201 2815 0512 9736 |

    @tms:UTR-10668 @Mobile
    Examples:
      | locale           | langCode         | userType  | card                |
      | multiLangDefault | multiLangDefault | logged in | 5201 2815 0512 9736 |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @3DS2 @HappyFlow
  Scenario Outline: Credit card - As guest or user I can pay with credit card 3ds2 if I enter a different billing address
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
      And I see Checkout.PaymentPage.VisaCardTypeIcon with data-testid "scheme-container" is enabled
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And in 3DS2 pop-up I fill in the Adyen password "password"
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10409 @Mobile
    Examples:
      | locale  | langCode | userType | card                | cvv |
      | default | default  | guest    | 4917 6100 0000 0000 | 737 |

    # @tms:UTR-10401
    # Examples:
    #   | locale  | langCode | userType  | card               | cvv  |
    #   | default | default  | logged in | 3714 4963 5398 431 | 7373 |

    # @tms:UTR-10669
    # Examples:
    #   | locale           | langCode         | userType | card                | cvv |
    #   | multiLangDefault | multiLangDefault | guest    | 4917 6100 0000 0000 | 737 |

    @tms:UTR-10670
    Examples:
      | locale           | langCode         | userType  | card                | cvv |
      | multiLangDefault | multiLangDefault | logged in | 4917 6100 0000 0000 | 737 |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @3DS2 @Negative @P2
  Scenario Outline: Credit card - As guest or user I can pay with credit card 3DS2 and use back functionality
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
      And I wait until Payment.CreditCard.AdyenPasswordIframe with index 1 is displayed
    When I navigate back in the browser
      And I wait for 5 seconds
      And I navigate back in the browser
      And I navigate back in the browser
    Then URL should contain "/checkout/payment" within 15 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I see Checkout.ShippingPage.PLDItem with args product1#skuPartNumber is displayed
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
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And in 3DS2 pop-up I fill in the Adyen password "password"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10671
    Examples:
      | locale  | langCode | userType | card                |
      | default | default  | guest    | 5454 5454 5454 5454 |

    @tms:UTR-10672 @Mobile
    Examples:
      | locale           | langCode         | userType  | card                |
      | multiLangDefault | multiLangDefault | logged in | 4917 6100 0000 0000 |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @3DS2 @Negative @P2
  Scenario Outline: Credit card - As guest or user I can pay with credit card 3DS2 and use back functionality
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
      And I wait for 4 seconds
    When I navigate back in the browser
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
    Then URL should contain "/checkout/payment" within 15 seconds
      And I see Checkout.ShippingPage.PLDItem with args product1#skuPartNumber is displayed
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
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And in 3DS2 pop-up I fill in the Adyen password "password"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10408
    Examples:
      | locale  | langCode | userType | card                |
      | default | default  | guest    | 5454 5454 5454 5454 |

    @tms:UTR-10398
    Examples:
      | locale           | langCode         | userType  | card                |
      | multiLangDefault | multiLangDefault | logged in | 4917 6100 0000 0000 |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @3DS2 @HappyFlow
  Scenario Outline: Credit card - As guest or user I can pay with credit card 3DS2 after adding promo code
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I click on Checkout.OverviewPanel.EnterPromoCodeButton
      And I get checkout search data for "promocode" and store it with key #Promo
      And I type "#Promo" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Checkout.OverviewPanel.PromoCodeApplyButton
      And I wait until Checkout.OverviewPanel.PromoCodeRemoveButton is clickable
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 4871 0499 9999 9910 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
      And I see Checkout.PaymentPage.VisaCardTypeIcon with data-testid "scheme-container" is enabled
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10411 @Mobile
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    # @tms:UTR-10403
    # Examples:
    #   | locale  | langCode | userType  |
    #   | default | default  | logged in |

    # @tms:UTR-10673
    # Examples:
    #   | locale           | langCode         | userType |
    #   | multiLangDefault | multiLangDefault | guest    |

    @tms:UTR-10674
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @3DS2 @Negative @P2
  Scenario Outline: Credit card - As guest I can't pay with credit card 3DS2 if the amount is above the payment limit
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
      | cardNumber | 4917 6100 0000 0000 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I get credit card payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#PaymentLimit"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed

    @tms:UTR-10405
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10675 @Mobile
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @3DS2 @Negative @P2
  Scenario Outline: Credit card - As user I can't pay with credit card 3DS2 if the amount is above the payment limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 200 and 5000 and inventory between 100 and 9999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I am on locale <locale> shopping bag page of langCode <langCode> with 40 units for product items product1#skuPartNumber
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a logged in I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 4917 6100 0000 0000 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I get credit card payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#PaymentLimit"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed

    @tms:UTR-10413 @Mobile
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10676
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @3DS2 @Negative @P2
  Scenario Outline: Credit card - As guest or user I get and error and I can't pay with 3DS2 if the card details are wrong
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 4917 6100 0000 0000 |
      | cvv        | <cvv>               |
      | year       | <year>              |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And in 3DS2 pop-up I fill in the Adyen password "password"
      And I get translation from lokalise for "TechnicalError" and store it with key #TechnicalError
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#TechnicalError"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed

    @tms:UTR-10410 @Mobile
    Examples:
      | locale  | langCode | userType | cvv | year |
      | default | default  | guest    | 348 | 2030 |

    # @tms:UTR-10399
    # Examples:
    #   | locale  | langCode | userType  | cvv | year |
    #   | default | default  | logged in | 737 | 2045 |

    # @tms:UTR-10677
    # Examples:
    #   | locale           | langCode         | userType | cvv | year |
    #   | multiLangDefault | multiLangDefault | guest    | 348 | 2030 |

    @tms:UTR-10678
    Examples:
      | locale           | langCode         | userType  | cvv | year |
      | multiLangDefault | multiLangDefault | logged in | 737 | 2045 |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @3DS2 @Negative @P2 @issue:EED-15070
  Scenario Outline: Credit card - As guest or user I get and error and I can't pay with credit card 3ds2 if the password is wrong
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 4917 6100 0000 0000 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
      And I see Checkout.PaymentPage.VisaCardTypeIcon with data-testid "scheme-container" is enabled
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 2 seconds
      And in 3DS2 pop-up I fill in the Adyen password "somethingWrong"
      And I get translation from lokalise for "AuthenticationError" and store it with key #AuthentificationError
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#AuthentificationError"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed

    @tms:UTR-10414 @Mobile
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    # @tms:UTR-10402
    # Examples:
    #   | locale  | langCode | userType  |
    #   | default | default  | logged in |

    # @tms:UTR-10679
    # Examples:
    #   | locale           | langCode         | userType |
    #   | multiLangDefault | multiLangDefault | guest    |

    @tms:UTR-10680
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation
  @UnifiedCheckout @PaymentPage @Payment @CreditCard @3DS2 @P3
  Scenario Outline: Credit card - As guest or user I can't place an order due to Fraud Error
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
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
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And in 3DS2 pop-up I fill in the Adyen password "password"
      And I get translation from lokalise for "FraudError" and store it with key #FraudError
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#FraudError"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed

    @tms:UTR-13549
    Examples:
      | locale  | langCode | userType | card                | cvv |
      | default | default  | guest    | 4917 6100 0000 0000 | 737 |

    @tms:UTR-13550 @Mobile
    Examples:
      | locale           | langCode         | userType | card                | cvv |
      | multiLangDefault | multiLangDefault | guest    | 5454 5454 5454 5454 | 737 |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CreditCard @3DS2 @HappyFlow
  Scenario Outline: Credit card - As user I can complete 3ds2 payment using northern ireland postcode
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      | Checkout.ShippingPage.Address1Input  | test address                |
      | Checkout.ShippingPage.CityInput      | Liverpool                   |
      | Checkout.ShippingPage.PostcodeInput  | BT1 1BG                     |
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | cvv        | <cvv>      |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | Automation |
      | lastName   | QA         |
      And I see Checkout.PaymentPage.VisaCardTypeIcon with data-testid "scheme-container" is enabled
    Then I see Checkout.PaymentPage.CreditDebitCardNumberLogo with args <type> is displayed
    When I set the checkbox Checkout.PaymentPage.TermsAndConditionsCheckbox status to true
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And in 3DS2 pop-up I fill in the Adyen password "password"
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-14931
    Examples:
      | locale | langCode | userType | card                | cvv | type |
      | uk     | default  | guest    | 4917 6100 0000 0000 | 737 | visa |

  # @FullRegression
  # @Desktop
  # @Chrome @FireFox @Safari
  # @UnifiedCheckout @PaymentPage @Payment @CreditCard @3DS2 @HappyFlow @feature:EED-14963
  # Scenario Outline: Credit card - As guest or user I can now use co branded card and do bcmc payment
  #   Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
  #     And I store the cartId
  #     And I wait until Checkout.PaymentPage.CreditCardButton is displayed
  #     And I click on Checkout.PaymentPage.CreditCardButton
  #     And in payment page I fill in the credit card details
  #     | name       | value  |
  #     | cardNumber | <card> |
  #     | year       | 2030   |
  #     | month      | 03     |
  #     And I see Checkout.PaymentPage.VisaCardTypeIcon with data-testid "scheme-container" is displayed
  #     And I see Checkout.PaymentPage.BcmcCardTypeIconNotSelected with data-testid "scheme-container" is displayed
  #     And I click on Checkout.PaymentPage.BcmcCardTypeIconNotSelected with data-testid "scheme-container"
  #     And I see Checkout.PaymentPage.BcmcCardTypeIcon with data-testid "scheme-container" is displayed
  #     And I see Checkout.PaymentPage.VisaCardTypeIconNotSelected with data-testid "scheme-container" is displayed
  #     And I set T&C checkbox to true if XCOMREG is enabled
  #     And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
  #   Then URL should contain "validate" within 15 seconds
  #   When with user "user" and password "password" I complete 3DS1 payment
  #   Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

  #   @tms:UTR-15550 @Mobile
  #   Examples:
  #     | locale | langCode | userType | card                |
  #     | be     | default  | guest    | 4871 0499 9999 9910 |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @GiftCard @Payment @PaymentPage @HappyFlow @GiftCardPurchase @CreditCard @3DS2 @ExcludeUat
  Scenario Outline: Credit card - As user I can purchase multiple giftcards by 3DS2 credicard payment
    Given I am on locale <locale> of url /<giftCardUrl> of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 2
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 3
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 3 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
    When I click on Experience.ShoppingBag.StartCheckoutButton
      # And I store the cartId
      And I wait until Checkout.SignInPage.SignInButton is clickable
      And I click on Checkout.SignInPage.SignInButton
      And I sign in with user "pvh.sap_user@outlook.com" and password "AutoNation2023"
      And I type to following inputs
      | element                              | value     |
      | Checkout.ShippingPage.FirstNameInput | Testing   |
      | Checkout.ShippingPage.LastNameInput  | Testovich |
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
    When I click on Checkout.PaymentPage.CreditCardButton
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
      And I wait for 5 seconds
      And in 3DS2 pop-up I fill in the Adyen password "password"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber

    @ExcludeCK @tms:UTR-17249 @Mobile
    Examples:
      | locale | langCode | card                | cvv | giftCardUrl        |
      | at     | default  | 4917 6100 0000 0000 | 737 | geschenkgutscheine |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @GiftCard @Payment @PaymentPage @HappyFlow @GiftCardPurchase @CreditCard @3DS2 @ExcludeUat
  Scenario Outline: Credit card - As guest I can purchase single giftcards using 3DS2 mastercard/amex payment
    Given I am on locale <locale> of url /<giftCardUrl> of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      # And I store the cartId
      And I type to following inputs
      | element                              | value                    |
      | Checkout.ShippingPage.EmailInput     | pvh.sap_user@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                  |
      | Checkout.ShippingPage.LastNameInput  | Testovich                |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
    When I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | cvv        | <cvv>      |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | Automation |
      | lastName   | QA         |
      And I add giftCardFirst billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber

    @ExcludeTH @tms:UTR-17251
    Examples:
      | locale | langCode | card                | cvv | giftCardUrl     |
      | es     | default  | 4035 5010 0000 0008 | 737 | tarjetas-regalo |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @GiftCard @Payment @PaymentPage @HappyFlow @GiftCardPurchase @CreditCard @3DS2 @ExcludeUat
  Scenario Outline: Credit card - As user I can purchase single giftcard using 3DS2 amex payment
    Given I am on locale <locale> of url /<giftCardUrl> of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 2
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 2 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      # And I store the cartId
      And I wait until Checkout.SignInPage.SignInButton is clickable
      And I type to following inputs
      | element                              | value                    |
      | Checkout.ShippingPage.EmailInput     | pvh.sap_user@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                  |
      | Checkout.ShippingPage.LastNameInput  | Testovich                |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
    When I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | cvv        | <cvv>      |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | Automation |
      | lastName   | QA         |
      And I add giftCardFirst billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber

    @ExcludeTH @tms:UTR-17252 @Mobile
    Examples:
      | locale | langCode | card               | cvv  | giftCardUrl |
      | fi     | EN       | 3700 0000 0100 018 | 7373 | gift-cards  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @GiftCard @Payment @PaymentPage @HappyFlow @GiftCardPurchase @CreditCard @3DS2 @ExcludeUat
  Scenario Outline: Credit card - As user I can purchase multiple giftcards using 3DS2 amex payment
    Given I am on locale <locale> of url /<giftCardUrl> of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      # And I store the cartId
      And I wait until Checkout.SignInPage.SignInButton is clickable
      And I click on Checkout.SignInPage.SignInButton
      And I sign in with user "pvh.sap_user@outlook.com" and password "AutoNation2023"
      And I wait for 2 seconds
      And I type to following inputs
      | element                              | value     |
      | Checkout.ShippingPage.FirstNameInput | Testing   |
      | Checkout.ShippingPage.LastNameInput  | Testovich |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
    When I click on Checkout.PaymentPage.CreditCardButton
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
      And I wait for 5 seconds
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber

    @ExcludeTH @tms:UTR-17252 @Mobile
    Examples:
      | locale | langCode | card               | cvv  | giftCardUrl |
      | ie     | EN       | 3700 0000 0100 018 | 7373 | gift-cards  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @GiftCard @Payment @PaymentPage @HappyFlow @GiftCardPurchase @CreditCard @3DS2 @ExcludeUat
  Scenario Outline: Credit card - As guest I can purchase single giftcard by 3DS2 dankort visa payment
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page gift-cards
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      # And I store the cartId
      And I type to following inputs
      | element                              | value                    |
      | Checkout.ShippingPage.EmailInput     | pvh.sap_user@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                  |
      | Checkout.ShippingPage.LastNameInput  | Testovich                |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
    When I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | cvv        | <cvv>      |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | Automation |
      | lastName   | QA         |
      And I add giftCardFirst billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber

    @ExcludeCK @tms:UTR-17256
    Examples:
      | locale | langCode | card                | cvv |
      | dk     | EN       | 4571 0000 0000 0001 | 737 |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @GiftCard @Payment @PaymentPage @HappyFlow @GiftCardPurchase @CreditCard @3DS2 @ExcludeUat
  Scenario Outline: Credit card - As guest I can purchase single giftcard by 3DS2 mastercard payment
    Given I am on locale <locale> of url /cartes-cadeaux of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
    When I click on Checkout.ShoppingBagPage.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      And I wait until Checkout.SignInPage.SignInButton is clickable
      And I click on Checkout.SignInPage.SignInButton
      And I sign in with user "pvh.sap_user@outlook.com" and password "AutoNation2023"
      And I wait for 2 seconds
      # And I store the cartId
      And I type to following inputs
      | element                              | value     |
      | Checkout.ShippingPage.FirstNameInput | Testing   |
      | Checkout.ShippingPage.LastNameInput  | Testovich |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
    When I click on Checkout.PaymentPage.CreditCardButton
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
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber

    @ExcludeCK
    Examples:
      | locale | langCode | card                | cvv |
      | fr     | default  | 5555 3412 4444 1115 | 737 |

