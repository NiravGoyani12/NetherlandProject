Feature: Unified Checkout - Billing Address

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @BillingAddress @DeliveryAddress @P2
  Scenario Outline: Billing Address - As a registered user my pre-selected billing address is default shipping address
    Given I am guest on locale <locale> of langCode <langCode> on the shipping page
      And as a guest I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    Then I check that my delivery details have been saved
    When as a guest I add other delivery details
      And I wait until Checkout.PaymentPage.DeliveryAddressDropdown is displayed
    Then I check that my billing details with index "1" have been saved

    @tms:UTR-10499
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10500 @Mobile
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @BillingAddress @P2
  Scenario Outline: Billing Address - As a guest I want to add a billing address on payment page
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
    When I add first billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PaypalButton
      And I select paypal payment and go to paypal layover
      And in paypal I cancel payment
      And I switch to 1st browser tab
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed in 20 seconds
    When I scroll to the element Checkout.PaymentPage.NewBillingAddressButton
    Then I check that my billing details have been saved

    @tms:UTR-10501 @Mobile
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10502
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @BillingAddress @P2
  Scenario Outline: Billing Address - As a user I want to add multiple billing addresses
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
    When I add first billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PaypalButton
      And I select paypal payment and go to paypal layover
      And in paypal I cancel payment
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed in 20 seconds
      And I check that my billing details have been saved
      And I wait until Checkout.PaymentPage.NewBillingAddressButton is clickable
    When I add new billing details
      And in dropdown Checkout.PaymentPage.BillingAddressDropdown I select the option by index "2"
    Then I check that my billing details with index "2" have been saved

    @tms:UTR-10503
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10504 @Mobile
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @BillingAddress @Negative @P2
  Scenario Outline: Billing Address - As guest I want to verify mandatory field validation for billing form
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.PaypalButton is displayed
      And I set the checkbox Checkout.PaymentPage.SameAsShippingCheckbox status to false
      And I wait until Checkout.PaymentPage.FirstNameInput is clickable
      And I clear text field of element Checkout.PaymentPage.FirstNameInput
      And I clear text field of element Checkout.PaymentPage.FirstNameInput
      And I clear text field of element Checkout.PaymentPage.LastNameInput
      And I clear text field of element Checkout.PaymentPage.LastNameInput
      And I click on Checkout.PaymentPage.PaypalButton
      And I wait until Checkout.PaymentPage.PayWithPayPal is clickable
    When I click on Checkout.PaymentPage.PayWithPayPal
      And I wait for 2 seconds
      And I get mandatory fields number for current locale as logged in and store it with key #ErrorAmount
      And the count of elements Checkout.PaymentPage.InputError is equal to #ErrorAmount
    Then as a logged in user I check that mandatory field errors are correct

    @tms:UTR-13233 @Mobile
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-13237
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @BillingAddress @Negative @P2
  Scenario Outline: Billing Address - As guest I want to verify invalid field validation for billing form
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.PaypalButton is displayed
      And I click on Checkout.PaymentPage.PaypalButton
      And I set the checkbox Checkout.PaymentPage.SameAsShippingCheckbox status to false
      And I wait until Checkout.PaymentPage.FirstNameInput is clickable
      # And I clear text field of element Checkout.PaymentPage.FirstNameInput
      # And I clear text field of element Checkout.PaymentPage.LastNameInput
      And as a logged in I add first invalid billing details
    When I click on Checkout.PaymentPage.PayWithPayPal
      And I get invalid fields number for current locale as logged in and store it with key #ErrorAmount
      And the count of elements Checkout.PaymentPage.InputError is equal to #ErrorAmount
    Then as a logged in user I check that invalid field errors are correct

    @tms:UTR-13238 @Mobile
    Examples:
      | locale | langCode | userType |
      | dk     | default  | guest    |

    @tms:UTR-13242
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @BillingAddress @HappyFlow
  Scenario Outline: Billing Address - As a user I want to place an order with a billing address from a different country
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
      And I click on Checkout.PaymentPage.PaypalButton
      And I set T&C checkbox to true if XCOMREG is enabled
    When I select "<BillingCountry>" as my billing country
      And I wait for 2 seconds
      And I add first billing details for different country "<BillingLocale>"
      And I select paypal payment and go to paypal layover
      And in paypal I cancel payment
      And I switch to 1st browser tab
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed in 20 seconds
    When I scroll to the element Checkout.PaymentPage.NewBillingAddressButton
    Then I check that my billing details have been saved for country "<BillingLocale>"
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 4000 0200 0000 0000 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
    When I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds
    Then I see Order Confirmation Page with my delivery details with index "1"

    @tms:UTR-10505 @Mobile
    Examples:
      | locale | langCode | userType | BillingCountry | BillingLocale |
      | uk     | default  | guest    | Netherlands    | NL            |

    @tms:UTR-10511
    Examples:
      | locale | langCode | userType  | BillingCountry | BillingLocale |
      | de     | EN       | logged in | Netherlands    | NL            |

    @tms:UTR-10508 @Mobile
    Examples:
      | locale | langCode | userType | BillingCountry | BillingLocale |
      | nl     | EN       | guest    | United Kingdom | UK            |



  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @BillingAddress @P2
  Scenario Outline: Billing Address -  Post code based on locale should be formatted automatically w.r.t to hyphen, spaces.
    Given I am logged in on locale <locale> of langCode <langCode> on the payment page
    When I set the checkbox Checkout.PaymentPage.SameAsShippingCheckbox status to false
      And I type "<postcodeInput>" in the empty field Checkout.PaymentPage.PostcodeInput
      And I store the value of attribute value of element Checkout.PaymentPage.PostcodeInput with key #formattedPostCode
    Then I see the length of key #formattedPostCode is equal to <formattedPostCodeLength>
      And I see Checkout.PaymentPage.PostcodeInput with text <formattedPostcode> is displayed

    @tms:UTR-12446
    Examples:
      | locale | langCode | postcodeInput | formattedPostcode | formattedPostCodeLength |
      | pt     | default  | 1000005       | 1000-005          | 8                       |

    @tms:UTR-12447 @Mobile
    Examples:
      | locale | langCode | postcodeInput | formattedPostcode | formattedPostCodeLength |
      | pl     | default  | 01424         | 01-424            | 6                       |

    @tms:UTR-12449
    Examples:
      | locale | langCode | postcodeInput | formattedPostcode | formattedPostCodeLength |
      | se     | default  | 41252         | 412 52            | 6                       |

    @tms:UTR-12451 @Mobile
    Examples:
      | locale | langCode | postcodeInput | formattedPostcode | formattedPostCodeLength |
      | nl     | default  | 1011NC        | 1011 NC           | 7                       |

    @tms:UTR-12452
    Examples:
      | locale | langCode | postcodeInput | formattedPostcode | formattedPostCodeLength |
      | uk     | default  | DD106TY       | DD10 6TY          | 8                       |