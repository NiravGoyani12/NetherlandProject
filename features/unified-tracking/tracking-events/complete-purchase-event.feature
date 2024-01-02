Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedCheckout @P2
  @tms:UTR-1399
  Scenario Outline: Complete purchase - The event is fired when I pay with credit card
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
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
    When I inject utag event listener
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Then utag event complete_purchase is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "complete_purchase"
      And utag event #event should contain attr eventLabel with value "complete_purchase_credit_debit"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | userType  |
      | lt     | default  | guest     |
      | lt     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedCheckout @P2
  @tms:UTR-6060
  Scenario Outline: Complete purchase - The event is fired when I pay with credit card (3ds1)
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 4212 3456 7890 1237 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
      And I set T&C checkbox to true if XCOMREG is enabled
    When I inject utag event listener
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And URL should contain "validate" within 15 seconds
      And with user "user" and password "password" I complete 3DS1 payment
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Then utag event complete_purchase is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "complete_purchase"
      And utag event #event should contain attr eventLabel with value "complete_purchase_credit_debit"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | userType  |
      | si     | default  | guest     |
      | si     | default  | logged in |

  #@FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedCheckout @P2
  @tms:UTR-6061
  Scenario Outline: Complete purchase - The event is fired when I pay with credit card (3ds2)
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 4917 6100 0000 0000 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
      And I set T&C checkbox to true if XCOMREG is enabled
    When I inject utag event listener
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And in 3DS2 pop-up I fill in the Adyen password "password"
      And I wait until Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Then utag event complete_purchase is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "complete_purchase"
      And utag event #event should contain attr eventLabel with value "complete_purchase_credit_debit"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale  | langCode | userType  |
      | default | default  | guest     |
      | default | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedCheckout @P2
  @tms:UTR-1400
  Scenario Outline: Complete purchase - The event is fired when I pay with paypal
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
      And I click on Checkout.PaymentPage.PaypalButton
      And I wait until Checkout.PaymentPage.PayWithPayPal is clickable
      And I set T&C checkbox to true if XCOMREG is enabled
    When I inject utag event listener
      And I click on Checkout.PaymentPage.PayWithPayPal
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds
    Then utag event complete_purchase is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "complete_purchase"
      And utag event #event should contain attr eventLabel with value "complete_purchase_paypal"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | userType  |
      | sk     | default  | guest     |
      | sk     | default  | logged in |

  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedCheckout @P2
  @tms:UTR-6062
  Scenario Outline: Complete purchase - The event is fired when I pay with paypal express from sign in
    Given I am on locale <locale> of langCode default with 2 products on shipping page
      And I store the cartId
      And I wait until Checkout.SignInPage.PaypalExpressButton is clickable
      And I click on Checkout.SignInPage.PaypalExpressButton
      And I wait until Checkout.SignInPage.PaypalExpressTermsModal is displayed
      And I set the checkbox Checkout.SignInPage.PaypalExpressTermsCheckbox status to true
    When I inject utag event listener
      And I click on Checkout.SignInPage.PayWithPaypalExpressButton
      And in paypal I complete payment
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds
      And utag event complete_purchase is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "complete_purchase"
      And utag event #event should contain attr eventLabel with value "complete_purchase_paypal"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode |
      | ee     | default  |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedCheckout @P2
  @tms:UTR-6063
  Scenario Outline: Complete purchase - The event is fired when I pay with Przelewy24
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.P24Button is clickable
      And I click on Checkout.PaymentPage.P24Button
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Banki Spółdzielcze"
      And I set T&C checkbox to true if XCOMREG is enabled
    When I inject utag event listener
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And in Przelewy24 I complete payment
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Then utag event complete_purchase is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "complete_purchase"
      And utag event #event should contain attr eventLabel with value "complete_purchase_przelewy"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    @tms:UTR-5644
    Examples:
      | locale | langCode | userType  |
      | pl     | default  | guest     |
      | pl     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedCheckout @P2
  @tms:UTR-8705
  Scenario Outline: Complete purchase - The event is fired when I pay with Klarna
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.Klarna is clickable
      And I click on Checkout.PaymentPage.Klarna
      And I wait for 1 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
    When I inject utag event listener
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And in klarna I complete payment for scenario Positive
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Then utag event complete_purchase is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "complete_purchase"
      And utag event #event should contain attr eventLabel with value "complete_purchase_klarna"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | userType  |
      | pl     | default  | guest     |
      | pl     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedCheckout @P2
  @tms:UTR-8706
  Scenario Outline: Complete purchase - The event is fired when I pay with Klarna over time
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is clickable
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 1 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
    When I inject utag event listener
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And in klarna I complete payment for scenario Instalments
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Then utag event complete_purchase is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "complete_purchase"
      And utag event #event should contain attr eventLabel with value "complete_purchase_klarna_account"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | userType  |
      | ie     | default  | guest     |
      | ie     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedCheckout @P2
  @tms:UTR-8707
  Scenario Outline: Complete purchase - The event is fired when I pay with Ratepay
    Given I am guest on locale <locale> of langCode default on the payment page
      And I click on Checkout.PaymentPage.RatepayButton
      And I set attribute type of element Checkout.PaymentPage.BirthdayDayDate to "text"
      And I type to following inputs
      | element                               | value      |
      | Checkout.PaymentPage.PhoneNumberInput | 7865321321 |
      | Checkout.PaymentPage.BirthdayDayDate  | 09092000   |
      And I set T&C checkbox to true if XCOMREG is enabled
    When I inject utag event listener
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Then utag event complete_purchase is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "complete_purchase"
      And utag event #event should contain attr eventLabel with value "complete_purchase_ratepay"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | userType  |
      | de     | default  | guest     |
      | de     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedCheckout @P2
  @tms:UTR-8789
  Scenario Outline: Complete purchase - The event is fired when I pay with bancontact
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.BancontactButton is clickable
      And I click on Checkout.PaymentPage.BancontactButton
      And in payment page I fill in the Bancontact details
      | name       | value  |
      | cardNumber | <card> |
      | year       | 2030   |
      | month      | 03     |
      And I set T&C checkbox to true if XCOMREG is enabled
    When I inject utag event listener
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And URL should contain "validate" within 15 seconds
      And with user "user" and password "password" I complete 3DS1 payment
      And I wait until Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Then utag event complete_purchase is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "complete_purchase"
      And utag event #event should contain attr eventLabel with value "complete_purchase_bcmc"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | userType  | card                |
      | be     | default  | guest     | 6703 4444 4444 4449 |
      | be     | default  | logged in | 6703 4444 4444 4449 |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @DataLayerEvent @Payment @ideal @BankTransfer @UnifiedCheckout @P2
  @tms:UTR-8860
  Scenario Outline: Complete purchase - The event is fired when I pay with iDeal
    Given I am <userType> on locale <locale> of langCode default on the payment page
      And I wait until Checkout.PaymentPage.IdealButton is clickable
      And I click on Checkout.PaymentPage.IdealButton
    When I inject utag event listener
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Test Issuer 6"
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And in ideal I complete payment
      And I wait until Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds
    Then utag event complete_purchase is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "complete_purchase"
      And utag event #event should contain attr eventLabel with value "complete_purchase_ideal"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | userType  |
      | nl     | default  | guest     |
      | nl     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome @Unification
  @Analytics @DataLayerEvent @Payment @BankTransfer @UnifiedCheckout @P2 
  @tms:UTR-17385 @AnalyticsGiftcard
  Scenario Outline: Complete purchase - The event is fired when I pay with giftcard
      Given I am <userType> on locale <locale> of langCode default on the payment page
      And I wait until Checkout.PaymentPage.GiftCardButton is clickable
      And I click on Checkout.PaymentPage.GiftCardButton
      And in payment page I fill in the gift card details
      | element    | value               |
      | cardNumber | 6036280000000000000 |
      | pin        | 1234                |
      And I click on Payments.GiftCardPage.ApplyGiftCardButton is clickable
      And I set T&C checkbox to true if XCOMREG is enabled
      When I inject utag event listener
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait until Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds
      Then utag event complete_purchase is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "complete_purchase"
      And utag event #event should contain attr eventLabel with value "complete_purchase_giftcard"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | userType  |
      | fi     | default  | guest     |
      | fi     | default  | logged in |