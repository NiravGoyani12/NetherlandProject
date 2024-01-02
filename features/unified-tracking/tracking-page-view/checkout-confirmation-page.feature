Feature: Unified Tracking - Page - View

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @UnifiedCheckout @P1
  @tms:UTR-866 
  Scenario Outline: checkout - confirmation - validation of the modules version, user, site, page and transaction for Credit Card
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
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    When I validate digital data site module with report key #report
      And I validate unified digital data <type> order confirmation user module with report key #report
      And I validate unified digital data page module on checkout - confirmation with following data with report key #report
      """
      {
        "pagePath": "/ordershippingbillingconfirmationview",
        "pageName": "checkout - confirmation|checkout>thankyoupage",
        "pageAlias": "transaction",
        "pageGender": "not applicable",
        "primaryCategory": "checkout - confirmation",
        "primaryCategoryId": "checkout - confirmation"
      }
      """
      And I validate digital data transaction module with following data with report key #report
      """
      {
        "paymentMethod": "adyenvisa",
        "paymentType": "credit card",
        "shippingCountry": "LT",
        "shippingMethod": "ups",
        "cartShippingOption": "standard"
      }
      """
      And I validate digital data 1st transaction item module of style colour partnumber product1#styleColourPartNumber with following data with report key #report
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report
    
    Examples:
      | locale | langCode | userType  | type       |
      | lt     | default  | guest     | guest      |
      | lt     | default  | logged in | registered |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @UnifiedCheckout @P1
  @tms:UTR-2199 
  Scenario Outline: checkout - confirmation - validation of the modules version, user, site, page and transaction for Paypal
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
      And I click on Checkout.PaymentPage.PaypalButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I wait until Checkout.PaymentPage.PayWithPayPal is clickable
      And I set T&C checkbox to true if XCOMREG is enabled
      And I wait until Checkout.PaymentPage.PayWithPayPal is displayed
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    When I validate digital data site module with report key #report
      And I validate unified digital data <type> order confirmation user module with report key #report
      And I validate unified digital data page module on checkout - confirmation with following data with report key #report
      """
      {
        "pagePath": "/ordershippingbillingconfirmationview",
        "pageName": "checkout - confirmation|checkout>thankyoupage",
        "pageAlias": "transaction",
        "pageGender": "not applicable",
        "primaryCategory": "checkout - confirmation",
        "primaryCategoryId": "checkout - confirmation"
      }
      """
      And I validate digital data transaction module with following data with report key #report
      """
      {
        "paymentMethod": "adyenpaypal",
        "paymentType": "paypal",
        "shippingCountry": "EE",
        "shippingMethod": "ups",
        "cartShippingOption": "standard"
      }
      """
      And I validate digital data 1st transaction item module of style colour partnumber product1#styleColourPartNumber with following data with report key #report
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale | langCode | userType  | type       | address |
      | ee     | default  | guest     | guest      | first   |
      | ee     | default  | logged in | registered | other   |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @UnifiedCheckout @P1
  @tms:UTR-5451 
  Scenario Outline: checkout - confirmation - validation of the modules version, user, site, page and transaction for PayPalExpress from sign-in page
    Given There is 1 product items with 0% discount of locale <locale> with price between 10 and 500 and inventory between 99 and 9999
      And I am on locale <locale> shopping bag page for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until Checkout.SignInPage.PaypalExpressButton is clickable
      And I click on Checkout.SignInPage.PaypalExpressButton
      And I wait until Checkout.SignInPage.PaypalExpressTermsModal is displayed
      And I set the checkbox Checkout.SignInPage.PaypalExpressTermsCheckbox status to true
      And I click on Checkout.SignInPage.PayWithPaypalExpressButton
      And in paypal I complete payment
      And I switch to 1st browser tab
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds
    When I validate digital data site module with report key #report
      And I validate unified digital data guest order confirmation user module with report key #report
      And I validate unified digital data page module on checkout - confirmation with following data with report key #report
      """
      {
        "pagePath": "/ordershippingbillingconfirmationview",
        "pageName": "checkout - confirmation|checkout>thankyoupage",
        "pageAlias": "transaction",
        "pageGender": "not applicable",
        "primaryCategory": "checkout - confirmation",
        "primaryCategoryId": "checkout - confirmation"
      }
      """
      And I validate digital data transaction module with following data with report key #report
      """
      {
        "paymentMethod": "adyenpaypalexpress",
        "paymentType": "paypalexpress",
        "shippingCountry": "EE",
        "shippingMethod": "ups",
        "cartShippingOption": "standard"
      }
      """
      And I validate digital data 1st transaction item module of style colour partnumber product1#styleColourPartNumber with following data with report key #report
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale |
      | ee     |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @UnifiedCheckout @P1
  @tms:UTR-5705 
  Scenario Outline: checkout - confirmation - validation of the modules version, user, site, page and transaction for Klarna
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.Klarna is clickable
      And I click on Checkout.PaymentPage.Klarna
      And I wait for 1 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 10 seconds
      And in klarna I complete payment for scenario Positive
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    When I validate digital data site module with report key #report
      And I validate unified digital data <type> order confirmation user module with allowed unknown attributes with report key #report
      And I validate unified digital data page module on checkout - confirmation with following data with report key #report
      """
      {
        "pagePath": "/ordershippingbillingconfirmationview",
        "pageName": "checkout - confirmation|checkout>thankyoupage",
        "pageAlias": "transaction",
        "pageGender": "not applicable",
        "primaryCategory": "checkout - confirmation",
        "primaryCategoryId": "checkout - confirmation"
      }
      """
      And I validate digital data transaction module with following data with report key #report
      """
      {
        "paymentMethod": "adyenklarnapaylater",
        "paymentType": "payment on invoice",
        "cartShippingOption": "standard"
      }
      """
      And I validate digital data 1st transaction item module of style colour partnumber product1#styleColourPartNumber with following data with report key #report
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale | langCode | userType  | type       |
      | pl     | default  | guest     | guest      |
      | pl     | default  | logged in | registered |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @UnifiedCheckout @P1
  @tms:UTR-5706 @FixedEvent 
  Scenario Outline: checkout - confirmation - validation of the modules version, user, site, page and transaction for Klarna over time
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is clickable
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 1 seconds
      # And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And in klarna I complete payment for scenario Instalments
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    When I validate digital data site module with report key #report
      And I validate unified digital data <type> order confirmation user module with allowed unknown attributes with report key #report
      And I validate unified digital data page module on checkout - confirmation with following data with report key #report
      """
      {
        "pagePath": "/ordershippingbillingconfirmationview",
        "pageName": "checkout - confirmation|checkout>thankyoupage",
        "pageAlias": "transaction",
        "pageGender": "not applicable",
        "primaryCategory": "checkout - confirmation",
        "primaryCategoryId": "checkout - confirmation"
      }
      """
      And I validate digital data transaction module with following data with report key #report
      """
      {
        "paymentMethod": "adyenklarnapayovertime",
        "paymentType": "payment on invoice",
        "cartShippingOption": "standard"
      }
      """
      And I validate digital data 1st transaction item module of style colour partnumber product1#styleColourPartNumber with following data with report key #report
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale | langCode | userType  | type       |
      | nl     | default  | guest     | guest      |
      | nl     | default  | logged in | registered |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @UnifiedCheckout @P1
  @tms:UTR-8709 
  Scenario Outline: checkout - confirmation - validation of the modules user, site, page and transaction for Ratepay
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I click on Checkout.PaymentPage.RatepayButton
      And I set attribute type of element Checkout.PaymentPage.BirthdayDayDate to "text"
      And I type to following inputs
      | element                               | value      |
      | Checkout.PaymentPage.PhoneNumberInput | 7865321321 |
      | Checkout.PaymentPage.BirthdayDayDate  | 09092000   |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    When I validate digital data site module with report key #report
      And I validate unified digital data <type> order confirmation user module with allowed unknown attributes with report key #report
      And I validate unified digital data page module on checkout - confirmation with following data with report key #report
      """
      {
        "pagePath": "/ordershippingbillingconfirmationview",
        "pageName": "checkout - confirmation|checkout>thankyoupage",
        "pageAlias": "transaction",
        "pageGender": "not applicable",
        "primaryCategory": "checkout - confirmation",
        "primaryCategoryId": "checkout - confirmation"
      }
      """
      And I validate digital data transaction module with following data with report key #report
      """
      {
        "paymentMethod": "adyenratepay",
        "paymentType": "payment on invoice",
        "cartShippingOption": "standard"
      }
      """
      And I validate digital data 1st transaction item module of style colour partnumber product1#styleColourPartNumber with following data with report key #report
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale | langCode | userType  | type       |
      | de     | default  | guest     | guest      |
      | de     | default  | logged in | registered |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @UnifiedCheckout @P1
  @tms:UTR-8790 
  Scenario Outline: checkout - confirmation - validation of the modules user, site, page and transaction for bancontact
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.BancontactButton is clickable
      And I click on Checkout.PaymentPage.BancontactButton
      And in payment page I fill in the Bancontact details
      | name       | value  |
      | cardNumber | <card> |
      | year       | 2030   |
      | month      | 03     |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And URL should contain "validate" within 15 seconds
      And with user "user" and password "password" I complete 3DS1 payment
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    When I validate digital data site module with report key #report
      And I validate unified digital data <type> order confirmation user module with allowed unknown attributes with report key #report
      And I validate unified digital data page module on checkout - confirmation with following data with report key #report
      """
      {
        "pagePath": "/ordershippingbillingconfirmationview",
        "pageName": "checkout - confirmation|checkout>thankyoupage",
        "pageAlias": "transaction",
        "pageGender": "not applicable",
        "primaryCategory": "checkout - confirmation",
        "primaryCategoryId": "checkout - confirmation"
      }
      """
      And I validate digital data transaction module with following data with report key #report
      """
      {
        "paymentMethod": "adyenbancontact",
        "paymentType": "credit card",
        "cartShippingOption": "standard"
      }
      """
      And I validate digital data 1st transaction item module of style colour partnumber product1#styleColourPartNumber with following data with report key #report
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale | langCode | userType  | type       | card                |
      | be     | default  | guest     | guest      | 6703 4444 4444 4449 |
      | be     | default  | logged in | registered | 6703 4444 4444 4449 |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @UnifiedCheckout @P1
  @tms:UTR-8791 
  Scenario Outline: checkout - confirmation - validation of the modules user, site, page and transaction for dotpay
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.P24Button is clickable
      And I click on Checkout.PaymentPage.P24Button
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Banki Spółdzielcze"
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And in Przelewy24 I complete payment
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    When I validate digital data site module with report key #report
      And I validate unified digital data <type> order confirmation user module with allowed unknown attributes with report key #report
      And I validate unified digital data page module on checkout - confirmation with following data with report key #report
      """
      {
        "pagePath": "/ordershippingbillingconfirmationview",
        "pageName": "checkout - confirmation|checkout>thankyoupage",
        "pageAlias": "transaction",
        "pageGender": "not applicable",
        "primaryCategory": "checkout - confirmation",
        "primaryCategoryId": "checkout - confirmation"
      }
      """
      And I validate digital data transaction module with following data with report key #report
      """
      {
        "paymentMethod": "adyenprzelewy24",
        "paymentType": "bank transfer",
        "cartShippingOption": "standard"
      }
      """
      And I validate digital data 1st transaction item module of style colour partnumber product1#styleColourPartNumber with following data with report key #report
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    Examples:
      | locale | langCode | userType  | type       |
      | pl     | default  | guest     | guest      |
      | pl     | default  | logged in | registered |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @UnifiedCheckout @P1
  @tms:UTR-8791 @AnalyticsGiftcard 
  Scenario Outline: checkout - confirmation - validation of the giftcard on the checkout confirmation page
       Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page giftcard-pdp
      And I am a <userType> user
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a guest I add first personal details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
      And I add giftCardFirst billing details
      And I set T&C checkbox to true if XCOMREG is enabled
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
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I validate digital data giftcard module with following data with report key #report
      """
      {
        "paymentMethod": "adyenvisa",
        "paymentType": "credit card"
      }
      """
      Then I execute all digital data validation with report key #report
 
    Examples:
      | locale | langCode | userType  | type       |
      | fi     | default  | guest     | guest      |
      | fi     | default  | logged in | registered |