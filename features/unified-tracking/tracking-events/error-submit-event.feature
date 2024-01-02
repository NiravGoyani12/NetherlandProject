Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @PaymentPage @UnifiedCheckout @P1
  @tms:UTR-1413
  Scenario Outline: Error submit - The event is fired when the credit card number is invalid
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I inject utag event listener
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | element    | value               |
      | cardNumber | 4111 1111 1111 1110 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | QA                  |
      | lastName   | Automation          |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll to and click on Checkout.PaymentPage.PlaceOrderButton by js
    Then utag event error_submit is fired saved to key #event
      And utag event #event should contain attr form_name with value "payment_method_creditcard"
      And utag event #event should contain attr error_message with value "enter a valid card number"
      And utag event #event should contain attr error_type with value "cardnumber_invalid"
      And utag event #event should contain attr event_name with value "error_submit"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "frontend form error"
      And utag event #event should contain attr eventLabel with value "checkout - payment|checkout>billing"
      # And utag event #event should contain attr errorText with value "4111 1111 1111 1110"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale  | langCode | userType  |
      | default | default  | guest     |
      | default | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @PaymentPage @UnifiedCheckout @P1
  @tms:UTR-1414
  Scenario Outline: Error submit - The event is fired when the credit card expiry date is invalid
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I inject utag event listener
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | element    | value               |
      | cardNumber | 4111 1111 1111 1111 |
      | cvv        | 737                 |
      | year       | 2006                |
      | month      | 03                  |
      | firstName  | QA                  |
      | lastName   | Automation          |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll to and click on Checkout.PaymentPage.PlaceOrderButton by js
    Then utag event error_submit is fired saved to key #event
      And utag event #event should contain attr form_name with value "payment_method_creditcard"
      And utag event #event should contain attr error_message with value "enter a valid expiry date"
      And utag event #event should contain attr error_type with value "expirydate_invalid"
      And utag event #event should contain attr event_name with value "error_submit"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "frontend form error"
      And utag event #event should contain attr eventLabel with value "checkout - payment|checkout>billing"
      # And utag event #event should contain attr errorText with value "03/06"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale  | langCode | userType  |
      | default | default  | guest     |
      | default | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @PaymentPage @UnifiedCheckout @P1
  @tms:UTR-1415
  Scenario Outline: Error submit - The event is fired when the credit card cvc code is invalid
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I inject utag event listener
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | element    | value               |
      | cardNumber | 4111 1111 1111 1111 |
      | cvv        | 73                  |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | QA                  |
      | lastName   | Automation          |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll to and click on Checkout.PaymentPage.PlaceOrderButton by js
    Then utag event error_submit is fired saved to key #event
      And utag event #event should contain attr form_name with value "payment_method_creditcard"
      And utag event #event should contain attr error_message with value "enter the complete security code"
      And utag event #event should contain attr error_type with value "cvccode_invalid"
      And utag event #event should contain attr event_name with value "error_submit"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "frontend form error"
      And utag event #event should contain attr eventLabel with value "checkout - payment|checkout>billing"
      # And utag event #event should contain attr errorText with value "73"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale  | langCode | userType  |
      | default | default  | guest     |
      | default | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @PaymentPage @UnifiedCheckout @P1
  @tms:UTR-1416
  Scenario Outline: Error submit - The event is fired when the credit card name is invalid
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I inject utag event listener
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | element    | value               |
      | cardNumber | 4111 1111 1111 1111 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  |                     |
      | lastName   |                     |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll to and click on Checkout.PaymentPage.PlaceOrderButton by js
    Then utag event error_submit is fired saved to key #event
      And utag event #event should contain attr form_name with value "payment_method_creditcard"
      And utag event #event should contain attr error_message with value "enter name as shown on card"
      And utag event #event should contain attr error_type with value "cardname_invalid"
      And utag event #event should contain attr event_name with value "error_submit"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "frontend form error"
      And utag event #event should contain attr eventLabel with value "checkout - payment|checkout>billing"
      # And utag event #event should contain attr errorText with value ""
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale  | langCode | userType  |
      | default | default  | guest     |
      | default | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @PaymentPage @UnifiedCheckout @P1
  @tms:UTR-5700
  Scenario Outline: Error submit - The event is fired when the Klarna terms and conditions are not checked
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.Klarna is clickable
      And I click on Checkout.PaymentPage.Klarna
    When I inject utag event listener
      And I scroll to and click on Checkout.PaymentPage.PlaceOrderButton by js
    Then utag event error_submit is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "frontend form error"
      And utag event #event should contain attr eventLabel with value "checkout - payment|checkout>billing"
      And utag event #event should contain attr error_type with value "termsandconditions_unchecked"
      And utag event #event should contain attr form_name with value "payment_method_klarna"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | userType  |
      | be     | default  | guest     |
      | be     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @PaymentPage @UnifiedCheckout @P1
  @tms:UTR-8197 @issue:EED-12011
  Scenario Outline: Error submit - The event is fired when the Ratepay DOB is incorrect
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.RatepayButton is clickable
      And I click on Checkout.PaymentPage.RatepayButton
      And I set attribute type of element Checkout.PaymentPage.BirthdayDayDate to "text"
      And I type to following inputs
      | element                               | value      |
      | Checkout.PaymentPage.PhoneNumberInput | 7865321321 |
      | Checkout.PaymentPage.BirthdayDayDate  | 090        |
      And I wait for 1 seconds
    When I inject utag event listener
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll to and click on Checkout.PaymentPage.PlaceOrderButton by js
    Then utag event error_submit is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "frontend form error"
      And utag event #event should contain attr eventLabel with value "checkout - payment|checkout>billing"
      And utag event #event should contain attr error_type with value "DOB_invalid"
      And utag event #event should contain non-empty attr error_message
      And utag event #event should contain attr form_name with value "payment_method_ratepay"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | userType  |
      | de     | default  | guest     |
      | de     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @PaymentPage @UnifiedCheckout @P1
  @tms:UTR-8196 @issue:EED-12011
  Scenario Outline: Error submit - The event is fired when the Ratepay phone number is incorrect
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.RatepayButton is clickable
      And I click on Checkout.PaymentPage.RatepayButton
      And I set attribute type of element Checkout.PaymentPage.BirthdayDayDate to "text"
      And I type to following inputs
      | element                               | value    |
      | Checkout.PaymentPage.PhoneNumberInput | 786      |
      | Checkout.PaymentPage.BirthdayDayDate  | 01011980 |
      And I wait for 5 seconds
    When I inject utag event listener
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll to and click on Checkout.PaymentPage.PlaceOrderButton by js
    Then utag event error_submit is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "frontend form error"
      And utag event #event should contain attr eventLabel with value "checkout - payment|checkout>billing"
      And utag event #event should contain attr error_type with value "phonenumber_invalid"
      And utag event #event should contain non-empty attr error_message
      And utag event #event should contain attr form_name with value "payment_method_ratepay"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | userType  |
      | at     | default  | guest     |
      | at     | default  | logged in |

  @FullRegression
  @Desktop
  @Chrome
  @Analytics @Unification @DataLayerEvent @PaymentPage @UnifiedCheckout @P1
  @tms:UTR-8198
  Scenario Outline: Error submit - The event is fired when the Paypal terms and conditions are not checked on desktop
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
    When I inject utag event listener
      And I click on Checkout.PaymentPage.PaypalButton
      And I wait until Checkout.PaymentPage.PayWithPayPal is clickable
      And I scroll to and click on Checkout.PaymentPage.PayWithPayPal
      And I wait for 5 seconds
    Then utag event error_submit is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "frontend form error"
      And utag event #event should contain attr eventLabel with value "checkout - payment|checkout>billing"
      And utag event #event should contain attr error_type with value "termsandconditions_unchecked"
      And utag event #event should contain attr form_name with value "payment_method_paypal"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:ß
      | locale | langCode | userType  |
      | uk     | default  | guest     |
      | uk     | default  | logged in |

  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1
  @ShoppingBag @CET1
  @tms:UTR-9988
  Scenario Outline: Error submit - The event is fired when the promocode is incorrect on ShoppingBag page
    Given I am on locale <locale> shopping bag page with 1 unit of any product with forced accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter contains text "1"
    When I inject utag event listener
      And I scroll to and click on Experience.ShoppingBag.PromoCodeButton
      And I type "<promoCode>" in the field Experience.ShoppingBag.PromoCodeField
      And I click on Experience.ShoppingBag.PromoCodeApplyButton
      And I wait until Experience.ShoppingBag.PromoCodeErrorMsg is displayed
    Then utag event error_submit is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "frontend form error"
      And utag event #event should contain attr eventLabel with value "cart|checkout>cart"
      And utag event #event should contain attr error_type with value "promocode_invalid"
      And utag event #event should contain attr form_name with value "promocode"
      And utag event #event should contain attr error_message with value "<errorMessage>"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | promoCode | errorMessage                      |
      | ee     | ASD       | oops! that promo code isn't right |
      | ee     |           | please enter a promotion code     |

@FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @P1
  @SignIn @tms:UTR-13314
  Scenario Outline: Login - The error_submit event is fired when I login from Checkout
    Given I am on locale <locale> of langCode <langCode> with 2 products on shipping page
      And I wait until the current page is loaded
      And I wait until checkout.SignInPage.CheckoutSignInButton is displayed
    When I inject utag event listener
      And I continue as invalid user with remember checkbox as true to shipping page
    Then utag event error_submit is fired saved to key #event
      And utag event #event should contain attr form_name with value "sign_in_myaccount"
       And utag event #event should contain non-empty attr error_message
      And utag event #event should contain attr error_type with value "invalid email/password combination"
      And utag event #event should contain attr event_name with value "error_submit"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "backend form error"
      And utag event #event should contain attr eventLabel with value "checkout-shipping"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event
    Examples:
      | locale | langCode | error_message                                                       |
      | nl     | default  | Je gebruikersnaam en wachtwoord matchen niet. Probeer het nog eens. |
      | uk     | default  | Looks like your username and password don't match. Please try again. |

@FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @P1
  @SignIn @tms:UTR-13315
  Scenario Outline: Login - The error_submit event is triggered when I try to login from Checkout with incorrect credentials
    Given I am on locale <locale> of langCode <langCode> with 2 products on shipping page
    And I wait until the current page is loaded
      And I wait until checkout.SignInPage.CheckoutSignInButton is displayed
    When I inject utag event listener
      And I log in with user <email> and password <password> with remember checkbox as true on shipping page
    Then utag event error_submit is fired saved to key #event
      And utag event #event should contain attr form_name with value "sign_in_myaccount"
      And utag event #event should contain attr error_message with value <error_message>
      And utag event #event should contain attr error_type with value "validation error"
      And utag event #event should contain attr event_name with value "error_submit"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "frontend form error"
      And utag event #event should contain attr eventLabel with value "checkout-shipping"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | email     | password | error_message                                           |
      | uk     | default  | testemail | test1234 | "email\|Sorry, that doesn't look like an email address" |
      # | uk     | default  |  testemail@test.com  | abc      | "password\|Your password needs to be between 10 and 25 characters long" |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1
  @CET1
  @tms:UTR-18017 @AnalyticsGiftcard
  Scenario Outline: Error submit - The event is fired when giftcard number is invalid
     Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 40 and 100 and inventory between 200 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product items product1#skuPartNumber with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a guest I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.GiftCardButton is clickable in 10 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.GiftCardButton
      When I inject utag event listener
      And in payment page I fill in the gift card details
      | element    | value               |
      | cardNumber | 000                 |
      | pin        | 1234                |
      And I click on Payments.GiftCardPage.ApplyGiftCardButton is clickable
    Then utag event error_submit is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "frontend form error"
      And utag event #event should contain attr eventLabel with value "checkout - payment|checkout>billing"
      And utag event #event should contain attr error_type with value "cardnumber_invalid"
      And utag event #event should contain attr form_name with value "payment_method_giftcard"
      And utag event #event should contain attr error_message with value "<errorMessage>"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode |  userType |errorMessage                      |
      | fi     |  default |  guest    |enter the complete card number     |

@FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1
  @CET1
  @tms:UTR-18018 @AnalyticsGiftcard
  Scenario Outline: Error submit - The event is fired when giftcard pin is invalid
     Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 40 and 100 and inventory between 200 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product items product1#skuPartNumber with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a guest I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.GiftCardButton is clickable in 10 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.GiftCardButton
      When I inject utag event listener
      And in payment page I fill in the gift card details
      | element    | value               |
      | cardNumber | 6036280000000000000 |
      | pin        |  12                 |
      And I click on Payments.GiftCardPage.ApplyGiftCardButton is clickable
    Then utag event error_submit is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "frontend form error"
      And utag event #event should contain attr eventLabel with value "checkout - payment|checkout>billing"
      And utag event #event should contain attr error_type with value "pinnumber_invalid"
      And utag event #event should contain attr form_name with value "payment_method_giftcard"
      And utag event #event should contain attr error_message with value "<errorMessage>"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode |  userType |errorMessage                      |
      | fi     |  default |  guest    |enter the complete security code     |

@FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1
  @CET1
  @tms:UTR-18019 @AnalyticsGiftcard
  Scenario Outline: Error submit - The event is fired when enter incorrect giftcard details
     Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 40 and 100 and inventory between 200 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product items product1#skuPartNumber with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a guest I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.GiftCardButton is clickable in 10 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.GiftCardButton
      When I inject utag event listener
      And in payment page I fill in the gift card details
      | element    | value                   |
      | cardNumber | 11112800000000000001111 |
      | pin        |  1234                   |
      And I click on Payments.GiftCardPage.ApplyGiftCardButton is clickable
    Then utag event error_submit is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "frontend form error"
      And utag event #event should contain attr eventLabel with value "checkout - payment|checkout>billing"
      And utag event #event should contain attr error_type with value "giftcard_balance_check_error"
      And utag event #event should contain attr form_name with value "payment_method_giftcard"
      And utag event #event should contain attr error_message with value "<errorMessage>"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode |  userType |errorMessage                      |
      | fi     |  default |  guest    |gift card balance check failed. please try again later.   |