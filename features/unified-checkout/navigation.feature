Feature: Unified Checkout - Navigation

  @FullRegression
  @Desktop @Mobile
  @Chrome
  @UnifiedCheckout @Navigation
  Scenario Outline: Navigation - As guest I am taken back to shopping bag when I change the URL to sign in with no item in my basket
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am on locale <locale> of url checkout/login
      And I wait for 2 seconds
    Then URL should contain "/shopping-bag"

    @tms:UTR-10440
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10448
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome
  @UnifiedCheckout @Navigation
  Scenario Outline: Navigation - As guest I am taken back to shopping bag when I change the URL to shipping with no item in my basket
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am on locale <locale> of url /checkout/shipping
      And I wait for 2 seconds
    Then URL should contain "/shopping-bag"

    @tms:UTR-10437
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10449
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome
  @UnifiedCheckout @Navigation
  Scenario Outline: Navigation - As guest I am taken back to shopping bag when I change the URL to payment with no item in my basket
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am on locale <locale> of url /checkout/payment
      And I wait for 2 seconds
    Then URL should contain "/shopping-bag"

    @tms:UTR-10436
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10450
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome
  @UnifiedCheckout @Navigation
  Scenario Outline: Navigation - As guest I am taken back to shopping bag when I change the URL to order confirmation with no item in my basket
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am on locale <locale> of url /checkout/confirmation
      And I wait for 2 seconds
    Then URL should contain "/shopping-bag"

    @tms:UTR-10433
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10451
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome
  @UnifiedCheckout @Navigation
  Scenario Outline: Navigation - As guest I am able to go to shipping page by changing the URL, if I have item in my basket
    Given There is 1 any product item of locale <locale> and langCode <langCode> with inventory between 10 and 999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a guest user
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber
      And I am on locale <locale> of url /checkout/shipping
      And I wait for 2 seconds
    Then I see Checkout.OverviewPanel.TotalPriceInfo with args product1#skuPartNumber is displayed
      And I see Checkout.ShippingPage.EmailInput is displayed

    @tms:UTR-10432
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10452
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  # Not an Real time scenarios to keep in under regression

  @FullRegression
  @Desktop @Mobile
  @Chrome
  @UnifiedCheckout @Navigation
  Scenario Outline: Navigation - As guest or user I'm taken to shipping page when I change the URL to sign in page, if I have item in my basket
    Given There is 1 any product item of locale <locale> and langCode <langCode> with inventory between 10 and 999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber
      And I am on locale <locale> of url checkout/login
      And I wait for 2 seconds
    Then I see Checkout.OverviewPanel.TotalPriceInfo with args product1#skuPartNumber is displayed
      And I see Checkout.ShippingPage.EmailInput is displayed
    Then URL should contain "/checkout/shipping"

    @tms:UTR-10439 @issue:EESCK-11557
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-10455
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop @Mobile
  @Chrome
  @UnifiedCheckout @Navigation
  Scenario Outline: Navigation - As a registered user I am taken to shipping page when I change the URL to payment page, if I have item in my basket
    Given There is 1 any product item of locale <locale> and langCode <langCode> with inventory between 10 and 999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber
      And I am on locale <locale> of url /checkout/payment
      And I wait for 2 seconds
    Then URL should contain "/checkout/shipping"

    @tms:UTR-10438
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10456
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome
  @UnifiedCheckout @Navigation
  Scenario Outline: Navigation - As guest I am taken to shopping bag page when I change the URL to confirmation page, if I have item in my basket
    Given There is 1 any product item of locale <locale> and langCode <langCode> with inventory between 10 and 999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a guest user
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber
      And I am on locale <locale> of url /checkout/confirmation
      And I wait for 2 seconds
    Then URL should contain "/shopping-bag"

    @tms:UTR-10435
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10453
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome
  @UnifiedCheckout @Navigation @Payment @Creditcard @issue:EED-14824
  Scenario Outline: Navigation - As a logged in user I am not able to submit an order 2 times, I am redirected to shopping bag when I try
    Given I am logged in on locale <locale> of langCode default on the payment page
    When I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
    Then in payment page I fill in the credit card details
      | element    | value               |
      | cardNumber | 4111 1111 1111 1111 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | QA                  |
      | lastName   | Automation          |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll to and click on Checkout.PaymentPage.PaypalButton
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And I wait until Checkout.PaymentPage.PlaceOrderButton is clickable
      And I scroll to the element Checkout.PaymentPage.TermsAndConditionsCheckbox
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    When I navigate back in the browser
      And I wait for 2 seconds
    Then URL should contain "/shopping-bag"

    @tms:UTR-10434
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10454
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome
  @UnifiedCheckout @Navigation @Payment @Creditcard @issue:EED-14822
  Scenario Outline: Payment Component - verify data holding on payment method component when switching between the payment options
    Given I am logged in on locale <locale> of langCode default on the payment page
    When I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
    Then in payment page I fill in the credit card details
      | element    | value               |
      | cardNumber | 4111 1111 1111 1111 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | QA                  |
      | lastName   | Automation          |
      And I see Checkout.PaymentPage.TermsAndConditionsCheckbox is not displayed
      And I scroll to and click on Checkout.PaymentPage.PaypalButton
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And I switch to iframe Payments.CreditCardPage.AdyenIframeWithIndex1
      And I wait until Payments.CreditCardPage.CardNumberFieldValidated is displayed
      And I switch to default content
      And I scroll to and click on Checkout.PaymentPage.IdealButton
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And I wait until Payments.CreditCardPage.CardNumberFieldValidated is displayed

    @tms:UTR-13431 @ExcludeDB0
    Examples:
      | locale | langCode |
      | nl     | default  |