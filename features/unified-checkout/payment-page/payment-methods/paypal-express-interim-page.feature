Feature: Unified Checkout - Payment Methods - PayPal Express - Interim Page

  @FullRegression
  @Desktop @feature:EED-15096
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @PPEXInterimPage @Payment @PayPalExpress @HappyFlow @P2
  Scenario Outline: PaypalExpress - As a guest when ppex address postcode is empty/invalid then I see interim page to update address for order creations
    Given I am on locale <locale> shopping bag page with 2 unit of any product with forced accepted cookies
      And I get translation from lokalise for "<PostCodeErrorType>" and store it with key #PostCodeError
      And I store the cartId
    When I set local storage "ppexAddressValidate" to <ppexAddressValidate>
      And I wait until the current page is loaded
      And I select paypal express and get to paypal login
      And in paypal I complete payment
      And I wait for 5 seconds
    Then I wait until Payments.PaypalExpressPage.PayPayExpressInterimAddressTitle is displayed
      And I wait until Payments.PaypalExpressPage.PayPayExpressInterimEditAddressForm is in viewport
      And I see MyAccount.AddressPage.PostCodeError contains text "#PostCodeError"
      And as a guest I add first invalid delivery details
      And I wait for 5 seconds
      And as a guest I add first delivery details
      And I wait for 5 seconds
      And I scroll in mobile view and click on to Payments.PaypalExpressPage.PayPayExpressAddressValidateButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @tms:UTR-15792 @Mobile
    Examples:
      | locale | langCode | ppexAddressValidate                                                                                                                                               | PostCodeErrorType   |
      | pt     | default  | {"deliveryAddress.street":"test address","deliveryAddress.city":"test city","deliveryAddress.stateOrProvince":"test province","deliveryAddress.postalCode":"123"} | PostCodeFormatError |

    @tms:UTR-16435
    Examples:
      | locale | langCode | ppexAddressValidate                                                                                                                                            | PostCodeErrorType |
      | pt     | default  | {"deliveryAddress.street":"test address","deliveryAddress.city":"test city","deliveryAddress.stateOrProvince":"test province","deliveryAddress.postalCode":""} | PostCodeRequired  |

  @FullRegression
  @Desktop @feature:EED-15096
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @PPEXInterimPage @Payment @PayPalExpress @P2
  Scenario Outline: PaypalExpress - As a guest when ppex address line 1 is empty then I see interim page to correct it
    Given I am on locale <locale> shopping bag page with 2 unit of any product with forced accepted cookies
      And I get translation from lokalise for "<addressErrorType>" and store it with key #AddressError
    When I set local storage "ppexAddressValidate" to <ppexAddressValidate>
      And I wait until the current page is loaded
      And I select paypal express and get to paypal login
      And in paypal I complete payment
      And I wait for 5 seconds
      And I wait until Payments.PaypalExpressPage.PayPayExpressInterimEditAddressForm is clickable
    Then I wait until Payments.PaypalExpressPage.PayPayExpressInterimEditAddressForm is in viewport
      And I see MyAccount.AddressPage.AddressError contains text "#AddressError"

    @tms:UTR-16437
    Examples:
      | locale | langCode | ppexAddressValidate                                                                                                                          | addressErrorType |
      | pt     | default  | {"deliveryAddress.street":"","deliveryAddress.city":"test","deliveryAddress.stateOrProvince":"test","deliveryAddress.postalCode":"1234-567"} | AddressRequired  |

  @FullRegression
  @Desktop @feature:EED-15096
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @PPEXInterimPage @Payment @PayPalExpress @Negative @P2
  Scenario Outline: PaypalExpress - As a guest when ppex address city is empty then I see interim page to correct it
    Given I am on locale <locale> shopping bag page with 2 unit of any product with forced accepted cookies
      And I get translation from lokalise for "<CityErrorType>" and store it with key #CityError
    When I set local storage "ppexAddressValidate" to <ppexAddressValidate>
      And I click on Experience.ShoppingBag.StartCheckoutButton
    Then I wait until the current page is loaded
      And I wait for 3 seconds
      And I wait until Checkout.OPCSignInPage.PayPalExpressButton is clickable
      And I click on Checkout.OPCSignInPage.PayPalExpressButton
      And I select paypal express and get to paypal login
      And in paypal I complete payment
      And I wait for 5 seconds
    Then I wait until Payments.PaypalExpressPage.PayPayExpressInterimEditAddressForm is displayed
      And I wait until Payments.PaypalExpressPage.PayPayExpressInterimCloseIcon is displayed
      And I wait until Payments.PaypalExpressPage.PayPayExpressInterimWarning is displayed
      And I wait until Payments.PaypalExpressPage.PayPayExpressInterimAddressTitle is displayed
      And I wait until Payments.PaypalExpressPage.PayPayExpressInterimEditAddressForm is in viewport
      And I see MyAccount.AddressPage.CityError contains text "#CityError"

    @tms:UTR-15794 @Mobile 
    Examples:
      | locale | langCode | ppexAddressValidate                                                                                                                                  | CityErrorType |
      | pt     | default  | {"deliveryAddress.street":"test address","deliveryAddress.city":"","deliveryAddress.stateOrProvince":"test","deliveryAddress.postalCode":"1234-567"} | CityRequired  |

  @FullRegression
  @Desktop @feature:EED-15096
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PPEXInterimPage @Payment @PayPalExpress @Negative @P2 @ExcludeCK
  Scenario Outline: Paypal - I should be able to process the order successfully without interim page along with Pending status from adyen
    Given I am on locale <locale> shopping bag page for product item 8718941982669 with forced accepted cookies
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
      And I set local storage "ppexAddressValidate" to <ppexAddressValidate>
      And I store the cartId
      And I click on Experience.ShoppingBag.StartCheckoutButton
    When I click on Checkout.OverviewPanel.EnterPromoCodeButton
      And I type "PENDING" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Checkout.OverviewPanel.PromoCodeApplyButton
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
    Then I wait until the current page is loaded
      And I wait until Checkout.OPCSignInPage.PayPalExpressButton is clickable
      And I click on Checkout.OPCSignInPage.PayPalExpressButton
      And I select paypal express and get to paypal login
      And in paypal I complete payment
      And I wait for 5 seconds
    Then I wait until Payments.PaypalExpressPage.PayPayExpressInterimEditAddressForm is not displayed
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds
      And I see Checkout.OrderConfirmationPage.ConfirmationDetailsMessage contains text "You will receive further communication via email once your order has been confirmed."

    @tms:UTR-16594 @Mobile
    Examples:
      | locale | langCode | ppexAddressValidate                                                                                                                                                                              |
      | pt     | default  | {"deliveryAddress.street":"LStreet1784LS784LS784LS784LS71,\\r\\n9909","deliveryAddress.city":"test city","deliveryAddress.stateOrProvince":"test state","deliveryAddress.postalCode":"1234-567"} |

    @tms:UTR-16595
    Examples:
      | locale | langCode | ppexAddressValidate                                                                                                                                                                    |
      | pt     | default  | {"deliveryAddress.street":"LStreet1784LS784LS784LS784LS71,\\r\\n9909","deliveryAddress.city":"test city","deliveryAddress.stateOrProvince":"","deliveryAddress.postalCode":"1234-567"} |

  @FullRegression
  @Desktop @feature:EED-15096
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PPEXInterimPage @Payment @PayPalExpress @Negative @P2
  Scenario Outline: Paypal - I should be seeing the interimpage when address line info is more than 35
    Given I am on locale <locale> shopping bag page with 2 unit of any product with forced accepted cookies
      And I set local storage "ppexAddressValidate" to <ppexAddressValidate>
      And I click on Experience.ShoppingBag.StartCheckoutButton
    Then I wait until the current page is loaded
      And I wait for 3 seconds
      And I wait until Checkout.OPCSignInPage.PayPalExpressButton is clickable
      And I click on Checkout.OPCSignInPage.PayPalExpressButton
      And I select paypal express and get to paypal login
      And in paypal I complete payment
      And I wait for 5 seconds
      And I wait until Payments.PaypalExpressPage.PayPayExpressInterimEditAddressForm is displayed
    Then I see MyAccount.AddressPage.AddressError contains text "address1 must be at most 35 characters."

    @tms:UTR-16439 @Mobile
    Examples:
      | locale | langCode | ppexAddressValidate                                                                                                                                                                            |
      | pt     | default  | {"deliveryAddress.street":"1234567890123456789012345,\\r\\n678901234567","deliveryAddress.city":"test","deliveryAddress.stateOrProvince":"test state","deliveryAddress.postalCode":"1234-567"} |

    @tms:UTR-16438
    Examples:
      | locale | langCode | ppexAddressValidate                                                                                                                                                                |
      | pt     | default  | {"deliveryAddress.street":"1234567890123456789012345678901234567","deliveryAddress.city":"test","deliveryAddress.stateOrProvince":"state","deliveryAddress.postalCode":"1234-567"} |

  @FullRegression
  @Desktop @feature:EED-15096
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PPEXInterimPage @Payment @PayPalExpress @Negative @P2
  Scenario Outline: Paypal - I should get an interim page when first name , last name and email field is empty
    Given I am on locale <locale> shopping bag page with 2 unit of any product with forced accepted cookies
      And I set local storage "ppexAddressValidate" to <ppexAddressValidate>
      And I click on Experience.ShoppingBag.StartCheckoutButton
    Then I wait until the current page is loaded
      And I wait until Checkout.OPCSignInPage.PayPalExpressButton is clickable
    When I click on Checkout.OPCSignInPage.PayPalExpressButton
      And I select paypal express and get to paypal login
      And in paypal I complete payment
      And I wait for 5 seconds
    Then I wait until Payments.PaypalExpressPage.PayPayExpressInterimEditAddressForm is displayed
      And I see MyAccount.AddressPage.FirstNameError contains text "First name is required."
      And I see MyAccount.AddressPage.LastNameError contains text "Last name is required."
      And I see MyAccount.AddressPage.EmailFieldError contains text "Email is required."
    When I click on Payments.PaypalExpressPage.PayPayExpressInterimCloseIcon
      And I wait for 2 seconds
      And I see URL should contain "/shipping"

    @tms:UTR-16625
    Examples:
      | locale | langCode | ppexAddressValidate                                                                                                                                                                                                                            |
      | pt     | default  | {"deliveryAddress.street":"LStreet1784LS784LS7,\\r\\n9099","deliveryAddress.city":"LSCity","deliveryAddress.stateOrProvince":"LSState","deliveryAddress.postalCode":"1225-815","shopperEmail":"","shopper.firstName":"","shopper.lastName":""} |
