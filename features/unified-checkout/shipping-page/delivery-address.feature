Feature: Unified Checkout - Shipping Page - Delivery Address

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShippingPage @DeliveryAddress @P2
  Scenario Outline: Delivery Address - As user with no saved address I want to see my email address prepopulated
    Given I am logged in on locale <locale> of langCode <langCode> with 1 units of any product on details page
      And I see Checkout.ShippingPage.EmailInput is displayed in 2 seconds
      And I see the attribute value of element Checkout.ShippingPage.EmailInput containing "user1#email"
      And I see Checkout.ShippingPage.SelectedDeliveryAddress is not displayed

    @tms:UTR-11274 @Mobile
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-11275
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShippingPage @DeliveryAddress @feature:EESCK-5309
  Scenario Outline: Delivery Address - Verify that user can create more than one delivery address on shipping page
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.NewAddressSection is clickable
      And as a <userType> I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait for 2 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
    When I navigate back in the browser
      And I wait until Checkout.ShippingPage.NewAddressButton is clickable
    Then I check that my delivery details have been saved
      And as a <userType> I add other delivery details
      And I wait until Checkout.ShippingPage.DeliveryAddressDropdown is displayed
    Then I check that my delivery details have been saved
      And in dropdown Checkout.ShippingPage.DeliveryAddressDropdown I select the option by js by index "2"
    Then I check that my delivery details with index "1" have been saved

    @tms:UTR-11276 @Mobile @P1
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-11278 @P2
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |


  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @DeliveryAddress
  Scenario Outline: Delivery Address - As a logged in user I want to add another delivery address from payment page and place an order
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
      And as a guest I add other delivery details
      And I wait for 2 seconds
    Then I check that my delivery details have been saved
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 5100 2900 2900 2909 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
      And I set T&C checkbox to true if XCOMREG is enabled
    When I click on Checkout.PaymentPage.PlaceOrderButton
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Then I see Order Confirmation Page with my delivery details with index "2"

    @tms:UTR-11306 @Mobile @P1
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-11307
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |


  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShippingPage @DeliveryAddress @P2 @feature:EESCK-5098
  Scenario Outline: Delivery Address - Verify that user can edit the delivery address on checkout
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.NewAddressSection is displayed
      And as a <userType> I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I navigate back in the browser
      And I wait for 3 seconds
      And I wait until Checkout.ShippingPage.SavedDeliveryAddress is displayed
    Then I check that my delivery details have been saved
    When I edit my delivery details
      And I wait for 5 seconds
    Then I check that my delivery details have been saved

    @tms:UTR-11280 @Mobile @P1
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-14295
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShippingPage @DeliveryAddress @P2
  Scenario Outline: Delivery Address - Verify that user cannot save edited delivery details using invalid postcode
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And as a <userType> I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I navigate back in the browser
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.EditAddressButton
      And I wait until Checkout.ShippingPage.PostcodeInput is clickable
      And I type "1" in the empty field Checkout.ShippingPage.PostcodeInput
      And I click on Checkout.ShippingPage.ModalSaveAddress
    Then the count of elements Checkout.ShippingPage.InputError is equal to 1

    @tms:UTR-11282 @Mobile
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-13250
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @P2
  @UnifiedCheckout @ShippingPage @DeliveryAddress @Negative @feature:EESCK-5019
  Scenario Outline: Delivery Address - As guest I want to verify mandatory field validation for standard form
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.EmailInput is displayed
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I get mandatory fields number for current locale as <userType> and store it with key #ErrorAmount
      And the count of elements Checkout.ShippingPage.InputError is equal to #ErrorAmount
    Then as a <userType> user I check that mandatory field errors are correct

    @tms:UTR-11284
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-11286
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShippingPage @DeliveryAddress @ExpressDelivery @Negative @P2 @feature:EESCK-5019
  Scenario Outline: Delivery Address - As guest/user I want to verify mandatory field validation for express form
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.EmailInput is displayed
      And I click on Checkout.ShippingPage.ExpressRadioButton
      And I wait for 3 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I get mandatory fields number for current locale as <userType> and store it with key #ErrorAmount
      And the count of elements Checkout.ShippingPage.InputError is equal to #ErrorAmount
    Then as a <userType> user I check that mandatory field errors are correct

    @tms:UTR-11288 @Mobile
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |

    @tms:UTR-11289
    Examples:
      | locale | langCode | userType |
      | nl     | EN       | guest    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShippingPage @DeliveryAddress @Negative @feature:EESCK-5019
  Scenario Outline: Delivery Address - As guest I want to verify invalid field validation for standard form
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.EmailInput is displayed
      And as a <userType> I add first invalid delivery details
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I get invalid fields number for current locale as <userType> and store it with key #ErrorAmount
      And the count of elements Checkout.ShippingPage.InputError is equal to #ErrorAmount
    Then as a <userType> user I check that invalid field errors are correct

    @tms:UTR-11292 @Mobile
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-11294
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShippingPage @DeliveryAddress @ExpressDelivery @Negative @P2
  Scenario Outline: Delivery Address - As guest I want to verify invalid field validation for express field
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.EmailInput is displayed
      And I click on Checkout.ShippingPage.ExpressRadioButton
      And I wait for 3 seconds
      And as a <userType> I add first invalid delivery details
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I get invalid fields number for current locale as <userType> and store it with key #ErrorAmount
      And the count of elements Checkout.ShippingPage.InputError is equal to #ErrorAmount
    Then as a <userType> user I check that invalid field errors are correct

    @tms:UTR-11297 @Mobile
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |

    @tms:UTR-11298
    Examples:
      | locale | langCode | userType  |
      | nl     | EN       | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShippingPage @DeliveryAddress @Negative @P2 @feature:EESCK-5027
  Scenario Outline: Delivery Address - As guest I want to verify postcode field validation
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.EmailInput is displayed
      And as a <userType> I add first delivery details
      And I type "$#@" in the empty field Checkout.ShippingPage.PostcodeInput
      And I type "$#@" in the empty field Checkout.ShippingPage.PostcodeInput
      And I wait for 3 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
    Then the count of elements Checkout.ShippingPage.InputError is equal to 1

    @tms:UTR-11300 @Mobile
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-11302
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShippingPage @DeliveryAddress @Negative @P3 @feature:EESCK-5309
  Scenario Outline: Delivery Address - New address will not be saved if user cancels in the modal
    Given I am on locale <locale> of langCode <langCode> with 1 products on shipping page
      And I continue as guest to shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And as a guest I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait for 5 seconds
    When I navigate back in the browser
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
    Then I check that my delivery details have been saved
      And as a guest I add other delivery details and cancel
    Then I see the attribute value of element Checkout.ShippingPage.SelectedDeliveryAddress not containing "AutomationAddress"

    @tms:UTR-11304 @Mobile
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-11305
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShippingPage @DeliveryAddress @P2
  Scenario Outline: Shipping page postcode formatting - Post code based on locale should be formatted automatically w.r.t to hyphen, spaces.
    Given I am logged in on locale <locale> of langCode <langCode> on the shipping page
      And I type "<postcodeInput>" in the empty field Checkout.ShippingPage.PostcodeInput
      And I store the value of attribute value of element Checkout.ShippingPage.PostcodeInput with key #formattedPostCode
    Then I see the length of key #formattedPostCode is equal to <formattedPostCodeLength>
      And I see Checkout.ShippingPage.PostcodeInput with text <formattedPostcode> is displayed

    @tms:UTR-12453
    Examples:
      | locale | langCode | postcodeInput | formattedPostcode | formattedPostCodeLength |
      | cz     | default  | 11000         | 110 00            | 6                       |

    @tms:UTR-12455 @Mobile
    Examples:
      | locale | langCode | postcodeInput | formattedPostcode | formattedPostCodeLength |
      | pt     | default  | 1000005       | 1000-005          | 8                       |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShippingPage @DeliveryAddress @P2
  Scenario Outline: Address added as a guest user should be overriden after User logs in at shipping page
    Given I am guest on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And as a guest I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.ShippingPage.SavedDeliveryAddress is displayed
      And I navigate back in the browser
      And I wait for 3 seconds
    When I continue as logged in to shipping page
      And I wait until Checkout.ShippingPage.DeliveryAddressDropdown is displayed
      And I wait for 2 seconds
    Then I check that my delivery details have been saved

    @tms:UTR-13476 @Mobile
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-14462
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShippingPage @DeliveryAddress @P3
  Scenario Outline: Navigating back to details of shipping from payment page, should keep the address and delivery method intact
    Given I am guest on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And as a guest I add first delivery details
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I store the value of Checkout.ShippingPage.DeliveryAddressLine with index 4 with key #postcodeOnPaymentPage
      And I wait for 2 seconds
      And I wait until Checkout.ShippingPage.DetailsForShippingLink is displayed
      And I wait until Checkout.ShippingPage.DetailsForShippingLink is clickable
      And I click on Checkout.ShippingPage.DetailsForShippingLink
    Then URL should contain "shipping"
      And I store the value of Checkout.ShippingPage.DeliveryAddressLine with index 4 with key #postcodeOnShippingPage
      And I see Checkout.ShippingPage.StandardRadioButton is displayed
      And I see the stored value with key #postcodeOnPaymentPage is equal to "#postcodeOnShippingPage"

    @tms:UTR-13477
    Examples:
      | locale | langCode |
      | be     | FR       |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @ShippingPage @DeliveryAddress @Mobile @P2
  Scenario Outline: Selected address should be displayed on the payment page in case of multiple shipping billing addresses
    Given I am on my account addresses page on locale <locale> of langCode <langCode> with forced accepted cookies
      # And I wait until MyAccount.AccountFlyout.AccountAddressesLink is clickable
      And I wait until MyAccount.AddressPage.AddAddressButton is clickable
    # And I click on MyAccount.AccountFlyout.AccountAddressesLink
    When I click on MyAccount.AddressPage.AddAddressButton
      And I get translation from lokalise for "SuccessfullyAddedNewAddress" and store it with key #NewAddressMessage
      And I add a new address as Other
      And I wait for 2 seconds
      And in dropdown MyAccount.AddressPage.AddressTypeDropdown I select the option by index "<addressTypeIndex>"
      And I click on MyAccount.AddressPage.SaveAddressButton
      And I click on MyAccount.AddressPage.AddAddressButton
      And I add a new address as Mr
      And I wait for 2 seconds
      And in dropdown MyAccount.AddressPage.AddressTypeDropdown I select the option by index "<addressTypeIndex>"
      And I click on MyAccount.AddressPage.SaveAddressButton
    Then I wait until the count of displayed elements MyAccount.AddressPage.AddressCard is equal to 2
    When I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait for 2 seconds
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
    Then I check that my delivery details have been saved
      And in dropdown Checkout.ShippingPage.DeliveryAddressDropdown I select the option by js by index "2"
    Then I check that my delivery details with index "1" have been saved
      And I store the value of Checkout.ShippingPage.SavedDeliveryAddress with index 1 with key #addressOnShippingPage
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait for 3 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    Then I check that my delivery details with index "1" have been saved

    @tms:UTR-14101
    Examples:
      | locale  | langCode | addressTypeIndex |
      | default | default  | 3                |

    @tms:UTR-18092
    Examples:
      | locale           | langCode         | addressTypeIndex |
      | multiLangDefault | multiLangDefault | 3                |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @ShippingPage @DeliveryAddress @Payment @Negative @P2
  Scenario Outline: Delivery Address - As a guest user I cannot place an order if address types mismatch between PuP & Standard
    Given I am guest on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.PickupTabButton is clickable
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.UPSAccesPointRadioButton is clickable
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait for 2 seconds
      And I wait until Checkout.ShippingPage.UPSAccesPointSearchField is clickable
    When I type "#POSTCODE" in the field Checkout.ShippingPage.UPSAccesPointSearchField
      And I click on Checkout.ShippingPage.UPSAccesPointFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
    Then I wait until Checkout.PaymentPage.DeliveryAddressOverview is displayed
      And I navigate back in the browser
      And I wait until Checkout.ShippingPage.UPSAccessPointChangeStoreButton is displayed in 5 seconds
      And I click on Checkout.ShippingPage.DeliveryTabButton
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And I click on Checkout.ShippingPage.StandardRadioButton
      And I navigate to page checkout-payment
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
      And I scroll to the element Checkout.PaymentPage.PlaceOrderButton
      And I add other billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    When I see Checkout.PaymentPage.ErrorNotification is displayed in 20 seconds
      And I get translation from lokalise for "InvalidShippingAddress" and store it with key #invalidShipmode
    Then I see Checkout.PaymentPage.ErrorNotification contains text "#invalidShipmode"

    @tms:UTR-18703 @Mobile
    Examples:
      | locale | langCode |
      | de     | default  |

    @tms:UTR-18704
    Examples:
      | locale | langCode |
      | it     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @ShippingPage @DeliveryAddress @Payment @Negative @P2
  Scenario Outline: Delivery Address - As a guest user I cannot place an order if address types mismatch between Standard & PuP
    Given I am guest on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And I click on Checkout.ShippingPage.StandardRadioButton
      And as a guest I add first delivery details
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.DeliveryAddressOverview is displayed
      And I navigate back in the browser
      And I wait until Checkout.ShippingPage.PickupTabButton is clickable
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.UPSAccesPointRadioButton is clickable
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait for 2 seconds
      And I wait until Checkout.ShippingPage.UPSAccesPointSearchField is clickable
      And I navigate to page checkout-payment
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
      And I scroll to the element Checkout.PaymentPage.PlaceOrderButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    When I see Checkout.PaymentPage.ErrorNotification is displayed in 20 seconds
      And I get translation from lokalise for "InvalidShippingAddress" and store it with key #invalidShipmode
    Then I see Checkout.PaymentPage.ErrorNotification contains text "#invalidShipmode"

    @tms:UTR-18705 @Mobile
    Examples:
      | locale | langCode |
      | de     | default  |

    @tms:UTR-18706
    Examples:
      | locale | langCode |
      | it     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShippingPage @DeliveryAddress @P2
  Scenario Outline: Delivery Address - As a reg user I want e-mail/firstname/lastname to be pre-filled in the PuP pers details form
    Given I am on my account addresses page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.AddressPage.AddAddressButton
      And I add a new address as Mr
      And in dropdown MyAccount.AddressPage.AddressTypeDropdown I select the option by index "3"
      And I click on MyAccount.AddressPage.SaveAddressButton
      And I wait for 2 seconds
    Then the count of displayed elements MyAccount.AddressPage.AddressCard is equal to 1
    When I am on locale <locale> shopping bag page with 1 unit of any product
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until Checkout.ShippingPage.PickupTabButton is clickable
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on <button>
      And I wait until Checkout.ShippingPage.PVHFormBuilder is displayed
    Then I check that my PuP details have been saved

    @tms:UTR-18780
    Examples:
      | locale | langCode | button                                          |
      | it     | default  | Checkout.ShippingPage.CollectInStoreRadioButton |

    @tms:UTR-18781 @Mobile
    Examples:
      | locale | langCode | button                                          |
      | de     | EN       | Checkout.ShippingPage.DHLPackstationRadioButton |

    @tms:UTR-18782
    Examples:
      | locale | langCode | button                                         |
      | nl     | default  | Checkout.ShippingPage.UPSAccesPointRadioButton |
