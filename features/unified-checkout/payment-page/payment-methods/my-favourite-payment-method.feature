Feature: Unified Checkout - Save Payment Methods

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @PaymentMethods @FavouritePayment @HappyFlow
  Scenario Outline: Save Card - As a user I can use my saved card to make payments
    Given I am cross site user on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I wait for 2 seconds
    When I click on Checkout.PaymentPage.StoredCardFrame
      And I wait for 2 seconds
      And in payment page I fill in the save card CVV details "737"
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-12291 
    Examples:
      | locale | langCode |
      | fr     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @PaymentMethods @FavouritePayment @P2
  Scenario Outline: Save Card - As a guest user I do not have the option to save card details for my payments
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I wait for 5 seconds
    When I click on Checkout.PaymentPage.CreditCardButton
    Then I see Checkout.PaymentPage.SaveForNextPaymentCheckbox is not displayed
      And I set T&C checkbox to true if XCOMREG is enabled
      And I see Checkout.PaymentPage.PlaceOrderButton is displayed

    @tms:UTR-12114
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @PaymentMethods @FavouritePayment @P2
  Scenario Outline: Save Card - As a user I have an option to save only 1 card details at a time for my payments
    Given I am logged in on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I wait for 2 seconds
    When I click on Checkout.PaymentPage.CreditCardButton
    Then I see Checkout.PaymentPage.SaveForNextPaymentCheckbox is displayed
      And I see Checkout.PaymentPage.CreditDebitCardForm is displayed
      And the count of elements Checkout.PaymentPage.CreditDebitCardForm is equal to 1
      And I see Checkout.PaymentPage.PlaceOrderButton is displayed

    @tms:UTR-12115
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @PaymentMethods @FavouritePayment @P2
  Scenario Outline: Save Card - As a user I should be able to perform a transaction with another unsaved card, when already a card was saved
    Given I am cross site user on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value              |
      | cardNumber | 3700 0000 0100 018 |
      | cvv        | 7373               |
      | year       | 2030               |
      | month      | 03                 |
      | firstName  | Automation         |
      | lastName   | QA                 |
    Then I see Checkout.PaymentPage.CreditDebitCardNumberLogo with args <type> is displayed
    When I set the checkbox Checkout.PaymentPage.TermsAndConditionsCheckbox status to true
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-12116
    Examples:
      | locale | langCode | type |
      | fr     | default  | amex |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @PaymentMethods @FavouritePayment @P2
  Scenario Outline: Save Card - As a user I should be able to remove saved card, add new card and complete payment
    Given I am cross site user on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
      And I click on Checkout.PaymentPage.StoredCardFrame
    When I click on Checkout.PaymentPage.RemoveStoredCard
      And I click on Checkout.PaymentPage.RemoveStoredCardConfirm
      And I wait for 2 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 4111 1111 1111 1111 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
    When I set the checkbox Checkout.PaymentPage.SaveForNextPaymentCheckbox status to true
      And I set T&C checkbox to true if XCOMREG is enabled
    Then I click on Checkout.PaymentPage.PlaceOrderButton
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-12292
    Examples:
      | locale | langCode |
      | uk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @PaymentMethods @FavouritePayment
  Scenario Outline: Save Card - As a user I should be able to use saved card, also in a new session
    Given I am cross site user on locale <locale> of langCode <langCode> on the payment page
      And I wait for 2 seconds
      And I click on Checkout.PaymentPage.StoredCardFrame
    When I click on Checkout.PaymentPage.RemoveStoredCard
      And I click on Checkout.PaymentPage.RemoveStoredCardConfirm
      And I wait for 2 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 4111 1111 1111 1111 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
    When I set the checkbox Checkout.PaymentPage.SaveForNextPaymentCheckbox status to true
      And I set T&C checkbox to true if XCOMREG is enabled
    Then I click on Checkout.PaymentPage.PlaceOrderButton
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Given I am cross site user on locale <locale> of langCode <langCode> on the payment page
    Then I see Checkout.PaymentPage.StoredCardFrame is displayed
      And I wait until Checkout.PaymentPage.StoredCardFrame is clickable
      And I click on Checkout.PaymentPage.StoredCardFrame
      And in payment page I fill in the save card CVV details "737"
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-12293
    Examples:
      | locale | langCode |
      | uk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @PaymentMethods @FavouritePayment @P3
  Scenario Outline: Save Card - As a user when i cancel my current transaction by using back navigation, card details should not be saved
    Given I am logged in on locale <locale> of langCode <langCode> on the payment page
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 5212 3456 7890 1234 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
    When I set the checkbox Checkout.PaymentPage.SaveForNextPaymentCheckbox status to true
      And I set T&C checkbox to true if XCOMREG is enabled
    Then I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 2 seconds
      And I navigate back in the browser
    Then URL should contain "/checkout/payment" within 15 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And I see the checkbox Checkout.PaymentPage.SaveForNextPaymentCheckbox is unchecked

    @tms:UTR-12294
    Examples:
      | locale | langCode |
      | es     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @PaymentMethods @FavouritePayment @P2
  Scenario Outline: Save Card - As a user when I cancel my remove card operation, payment page should be shown with saved card and transaction successful
    Given I am cross site user on locale <locale> of langCode <langCode> on the payment page
      And I click on Checkout.PaymentPage.StoredCardFrame
    When I click on Checkout.PaymentPage.RemoveStoredCard
      And I click on Checkout.PaymentPage.RemoveStoredCardCancel
      And I wait for 2 seconds
    Then I see Checkout.PaymentPage.StoredCardNumber is displayed
      And I click on Checkout.PaymentPage.StoredCardFrame
      And in payment page I fill in the save card CVV details "737"
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-12295
    Examples:
      | locale | langCode |
      | fr     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @PaymentMethods @FavouritePayment @P3
  Scenario Outline: Save Card - As a user when i cancel my current transaction by using back navigation, card details should not be saved
    Given I am logged in on locale <locale> of langCode <langCode> on the payment page
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 4917 6100 0000 0000 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
    When I set the checkbox Checkout.PaymentPage.SaveForNextPaymentCheckbox status to true
      And I wait for 2 seconds
      And in payment page I fill in the credit card details
      | name       | value         |
      | cardNumber | 6703 4444 444 |
      | cvv        |               |
      | year       |               |
      | month      |               |
      | firstName  |               |
      | lastName   |               |
      And I wait until Checkout.PaymentPage.PaymentPageNotificationInfo is clickable
      And I wait until the checkbox Checkout.PaymentPage.SaveForNextPaymentCheckbox is unchecked in 1 second
    Then I see Checkout.PaymentPage.PaymentPageNotificationInfo is in viewport

    @tms:UTR-13317
    Examples:
      | locale | langCode |
      | nl     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @P2
  @UnifiedCheckout @PaymentPage @PaymentMethods @FavouritePayment @HappyFlow
  Scenario Outline: Save Card - As a user I can use my saved card to make payments with collect in store option
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I wait until Checkout.ShippingPage.CollectInStoreSearchField is displayed
    When I type "<searchText>" in the field Checkout.ShippingPage.CollectInStoreSearchField
      And I click on Checkout.ShippingPage.CollectInStoreFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I wait for 2 seconds
    When I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 5100 2900 2900 2909 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
    When I set the checkbox Checkout.PaymentPage.SaveForNextPaymentCheckbox status to true
      And I wait for 2 seconds
      And I add other billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-13373
    Examples:
      | locale | langCode | searchText | userType  |
      | uk     | default  | M178BL     | logged in |