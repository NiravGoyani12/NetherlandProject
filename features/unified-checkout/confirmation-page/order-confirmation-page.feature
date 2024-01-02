Feature: Unified Checkout - Order Confirmation Page

  @FullRegression
  @Desktop
  @Chrome @Safari @FireFox @Translation @Lokalise
  @UnifiedCheckout @Payment @Creditcard @Account @OrderConfirmationPage
  Scenario Outline: OCP - Guest/Registered user can see all elements on Order Confirmation Page
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
      And I click on Checkout.PaymentPage.PlaceOrderButton
    When I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get translation from lokalise for "OCPDeliveryMethod" and store it with key #orderDeliveryMethod
      And I get translation from lokalise for "OrderNumberMessage" and store it with key #orderNumberMessage
    Then I see Checkout.OrderConfirmationPage.OrderDeliveryMethodMessage contains text "#orderDeliveryMethod"
      And I see Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 1 contains text "#orderNumberMessage"

    @tms:UTR-17677 @Mobile
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-17680
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @Payment @Creditcard @Account @OrderConfirmationPage @ExcludeTH
  Scenario Outline: Account - Guest user can create account on order confirmation page
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
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
      And I wait until Checkout.OrderConfirmationPage.ContinueShoppingButton is clickable
    When I type "RegeleSalam1" in the field Checkout.OrderConfirmationPage.SignUpPasswordInput
      And I type "RegeleSalam1" in the field Checkout.OrderConfirmationPage.SignUpConfirmPasswordInput
      And I set the checkbox Checkout.OrderConfirmationPage.SignUpTermsAndConditionsCheckbox status to true
      And I click on Checkout.OrderConfirmationPage.SignUpButton
    Then URL should contain "/myaccount"

    @tms:UTR-10443 @Mobile
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-17171
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @Payment @Creditcard @Account @OrderConfirmationPage @P2 @ExcludeTH
  Scenario Outline: Account - Registered user can not see or create account on order confirmation page
    Given I am logged in on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And I wait for 1 seconds
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
      And I wait until Checkout.OrderConfirmationPage.ContinueShoppingButton is clickable
    Then I see Checkout.OrderConfirmationPage.SignUpPasswordInput is not displayed
      And I see Checkout.OrderConfirmationPage.SignUpConfirmPasswordInput is not displayed
      And I see Checkout.OrderConfirmationPage.SignUpTermsAndConditionsCheckbox is not displayed
      And I see Checkout.OrderConfirmationPage.SignUpButton is not displayed

    @tms:UTR-10442
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

    @Mobile @tms:UTR-17172
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop
  @Chrome @Safari @Firefox @Translation @Lokalise @Negative
  @UnifiedCheckout @Payment @Creditcard @Account @OrderConfirmationPage @P2 @ExcludeTH
  Scenario Outline: Account - A guest user cannot create an account on order confirmation page using an existing email
    Given I am guest on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.NewAddressSection is displayed
      And as a guest I add first delivery details
      And I type to following empty inputs
      | element                          | value                       |
      | Checkout.ShippingPage.EmailInput | pvh.qa.automation@gmail.com |
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And I wait for 1 seconds
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
    Then I see the attribute value of element Checkout.OrderConfirmationPage.SignUpEmailInput containing "pvh.qa.automation@gmail.com"
    When I type to following empty inputs
      | element                                                   | value              |
      | Checkout.OrderConfirmationPage.SignUpPasswordInput        | NewPassAutomation1 |
      | Checkout.OrderConfirmationPage.SignUpConfirmPasswordInput | NewPassAutomation1 |
      And I set the checkbox Checkout.OrderConfirmationPage.SignUpTermsAndConditionsCheckbox status to true
      And I click on Checkout.OrderConfirmationPage.SignUpButton
      And I wait until Checkout.OrderConfirmationPage.SignUpError is displayed
      And I get translation from lokalise for "EmailAlreadyExists" and store it with key #SignUpError
    Then I see Checkout.OrderConfirmationPage.SignUpError contains text "#SignUpError"

    @tms:UTR-18020
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

    @tms:UTR-18021 @Mobile
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome
  @UnifiedCheckout @Payment @Creditcard @Account @OrderConfirmationPage @P2 @ExcludeTH
  Scenario Outline: Account - Guest user can create account on order confirmation page and navigate back and doesn't see order creation section anymore
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
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
      And I wait until Checkout.OrderConfirmationPage.ContinueShoppingButton is clickable
    When I type "RegeleSalam1" in the field Checkout.OrderConfirmationPage.SignUpPasswordInput
      And I type "RegeleSalam1" in the field Checkout.OrderConfirmationPage.SignUpConfirmPasswordInput
      And I set the checkbox Checkout.OrderConfirmationPage.SignUpTermsAndConditionsCheckbox status to true
      And I click on Checkout.OrderConfirmationPage.SignUpButton
    Then URL should contain "/myaccount"
    When I navigate back in the browser
      And I wait until Checkout.OrderConfirmationPage.ContinueShoppingButton is clickable
    Then I see Checkout.OrderConfirmationPage.SignUpPasswordInput is not displayed
      And I see Checkout.OrderConfirmationPage.SignUpConfirmPasswordInput is not displayed
      And I see Checkout.OrderConfirmationPage.SignUpTermsAndConditionsCheckbox is not displayed
      And I see Checkout.OrderConfirmationPage.SignUpButton is not displayed

    @tms:UTR-10441
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-17173
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |