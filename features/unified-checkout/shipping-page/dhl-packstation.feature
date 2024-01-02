Feature: Unified Checkout - Delivery Method - DHL Packstation

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @DHL @Payment @Creditcard @HappyFlow
  Scenario Outline: DHL - As guest or user I can complete an order with DHL pack station as my delivery method
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.DHLPackstationRadioButton is displayed
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I wait for 1 seconds
    When I type to following inputs
      | element                                        | value                       |
      | Checkout.ShippingPage.EmailInput               | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput           | Testing                     |
      | Checkout.ShippingPage.LastNameInput            | Testovich                   |
      | Checkout.ShippingPage.DHLPackstationPostnumber | 10179                       |
      | Checkout.ShippingPage.DHLPackstationNumber     | 181                         |
      | Checkout.ShippingPage.PostcodeInput            | 12345                       |
      | Checkout.ShippingPage.CityInput                | Berlin                      |
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 5100 2900 2900 2909 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
      And I see Checkout.PaymentPage.SameAsShippingCheckbox is not displayed
      And I add other billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Then I see Checkout.OrderConfirmationPage.OCPCustomerDetails contains text "Testing Testovich"
      And I see Checkout.OrderConfirmationPage.OrderConfPageAddressLine with index 1 contains text "Postnummer: 10179"
      And I see Checkout.OrderConfirmationPage.OrderConfPageAddressLine with index 2 contains text "Packstation Nummer: 181"
      And I see Checkout.OrderConfirmationPage.OrderConfPageAddressLine with index 3 contains text "12345 Berlin"
      And I see Checkout.OrderConfirmationPage.OrderConfPageAddressLine with index 4 contains text "Deutschland"

    @tms:UTR-11263 @Mobile
    Examples:
      | locale | langCode | userType |
      | de     | default  | guest    |

    @tms:UTR-11264 @ExcludeTH
    Examples:
      | locale | langCode | userType  |
      | de     | default  | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @PaymentPage @DeliveryMethods @DHL @P2
  Scenario Outline: DHL - As guest or user I can select DHL as my delivery method and see my details on Payment Page
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.DHLPackstationRadioButton is displayed
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I wait for 1 seconds
    When I type to following inputs
      | element                                        | value                       |
      | Checkout.ShippingPage.PostcodeInput            | 12345                       |
      | Checkout.ShippingPage.EmailInput               | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput           | Testing                     |
      | Checkout.ShippingPage.LastNameInput            | Testovich                   |
      | Checkout.ShippingPage.DHLPackstationPostnumber | 10179                       |
      | Checkout.ShippingPage.DHLPackstationNumber     | 181                         |
      | Checkout.ShippingPage.CityInput                | Berlin                      |
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I click on Checkout.ShippingPage.ProceedToPayment if exists
    Then I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I see Checkout.ShippingPage.DeliveryAddressLine with index 1 contains text "<Post>"
      And I see Checkout.ShippingPage.DeliveryAddressLine with index 2 contains text "<Packstation>"
      And I see Checkout.ShippingPage.DeliveryAddressLine with index 3 contains text "<Details>"
      And I see Checkout.ShippingPage.DeliveryAddressLine with index 4 contains text "<Country>"
      And I see Checkout.ShippingPage.NewAddressButton is not displayed
      And I see Checkout.ShippingPage.EditAddressButton is not displayed

    @tms:UTR-11265 @Mobile
    Examples:
      | locale | langCode | userType | Post              | Packstation             | Details      | Country     |
      | de     | default  | guest    | Postnummer: 10179 | Packstation Nummer: 181 | 12345 Berlin | Deutschland |

    @tms:UTR-11266 @ExcludeTH
    Examples:
      | locale | langCode | userType  | Post              | Packstation             | Details      | Country     |
      | de     | default  | logged in | Postnummer: 10179 | Packstation Nummer: 181 | 12345 Berlin | Deutschland |

    @tms:UTR-14844
    Examples:
      | locale | langCode | userType | Post               | Packstation             | Details      | Country |
      | de     | EN       | guest    | Post Number: 10179 | Packstation number: 181 | 12345 Berlin | Germany |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @DHL @P3
  Scenario Outline: DHL - As guest or user I can go to DHL packstation website from link in shipping page form
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.DHLPackstationRadioButton is displayed
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I see Checkout.ShippingPage.DHLPaymentInfo contains text "<ErrorMessage>"
      And I click on Checkout.ShippingPage.DHLWebsiteLink
      And I switch to 2nd browser tab
    Then I see URL should contain "https://www.dhl.de/de/privatkunden/dhl-standorte-finden.html"

    @tms:UTR-11267 @Mobile
    Examples:
      | locale | langCode | userType | ErrorMessage                                                   |
      | de     | default  | guest    | Bei dieser Versandmethode ist Kauf auf Rechnung nicht möglich. |

    @tms:UTR-11268 @ExcludeTH
    Examples:
      | locale | langCode | userType  | ErrorMessage                                                   |
      | de     | default  | logged in | Bei dieser Versandmethode ist Kauf auf Rechnung nicht möglich. |

    @tms:UTR-14845
    Examples:
      | locale | langCode | userType | ErrorMessage                                                          |
      | de     | EN       | guest    | PAYMENT ON INVOICE IS NOT A PAYMENT OPTION WITH THIS SHIPPING METHOD. |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @DHL @Negative @P2
  Scenario Outline: DHL - As guest user I can see empty field errors in DHL form
    Given I am guest on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.DHLPackstationRadioButton is displayed
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I wait for 1 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
    Then I see Checkout.ShippingPage.InputErrorMessage with index 1 contains text "<Error1>"
      And I see Checkout.ShippingPage.InputErrorMessage with index 2 contains text "<Error2>"
      And I see Checkout.ShippingPage.InputErrorMessage with index 3 contains text "<Error3>"
      And I see Checkout.ShippingPage.InputErrorMessage with index 4 contains text "<Error4>"
      And I see Checkout.ShippingPage.InputErrorMessage with index 5 contains text "<Error5>"
      And I see Checkout.ShippingPage.InputErrorMessage with index 6 contains text "<Error6>"
      And I see Checkout.ShippingPage.InputErrorMessage with index 7 contains text "<Error7>"

    @tms:UTR-11269
    Examples:
      | locale | langCode | Error1                  | Error2                    | Error3                     | Error4                                      | Error5                                              | Error6                         | Error7                  |
      | de     | default  | E-Mail ist erforderlich | Vorname ist erforderlich. | Nachname ist erforderlich. | Die Angabe der Postnummer ist erforderlich. | Die Angabe der Packstation-Nummer ist erforderlich. | Postleitzahl ist erforderlich. | Stadt ist erforderlich. |

    @tms:UTR-14846
    Examples:
      | locale | langCode | Error1             | Error2                  | Error3                 | Error4                   | Error5                          | Error6                | Error7                 |
      | de     | EN       | Email is required. | First name is required. | Last name is required. | Post Number is required. | Packstation Number is required. | Postcode is required. | Town/City is required. |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @DHL @Negative @P2
  Scenario Outline: DHL - As guest user I can see empty field errors in DHL form
    Given I am logged in on locale <locale> of langCode default on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.DHLPackstationRadioButton is displayed
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I wait for 1 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
    Then I see Checkout.ShippingPage.InputErrorMessage with index 1 contains text "Vorname ist erforderlich."
      And I see Checkout.ShippingPage.InputErrorMessage with index 2 contains text "Nachname ist erforderlich."
      And I see Checkout.ShippingPage.InputErrorMessage with index 3 contains text "Die Angabe der Postnummer ist erforderlich."
      And I see Checkout.ShippingPage.InputErrorMessage with index 4 contains text "Die Angabe der Packstation-Nummer ist erforderlich."
      And I see Checkout.ShippingPage.InputErrorMessage with index 5 contains text "Postleitzahl ist erforderlich."
      And I see Checkout.ShippingPage.InputErrorMessage with index 6 contains text "Stadt ist erforderlich."

    @tms:UTR-11270 @ExcludeTH
    Examples:
      | locale |
      | de     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @DHL @Negative @P2
  Scenario Outline: DHL - As guest user I can see invalid field errors in DHL form
    Given I am guest on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.DHLPackstationRadioButton is displayed
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I wait for 2 seconds
    When I type to following inputs
      | element                                        | value |
      | Checkout.ShippingPage.EmailInput               | 1     |
      | Checkout.ShippingPage.FirstNameInput           | 2     |
      | Checkout.ShippingPage.LastNameInput            | 3     |
      | Checkout.ShippingPage.DHLPackstationPostnumber | a     |
      | Checkout.ShippingPage.DHLPackstationNumber     | b     |
      | Checkout.ShippingPage.PostcodeInput            | c     |
      | Checkout.ShippingPage.CityInput                | 4     |
    When I click on Checkout.ShippingPage.ProceedToPayment
    Then I see Checkout.ShippingPage.InputErrorMessage with index 1 contains text "<Error1>"
      And I see Checkout.ShippingPage.InputErrorMessage with index 2 contains text "<Error2>"
      And I see Checkout.ShippingPage.InputErrorMessage with index 3 contains text "<Error3>"
      And I see Checkout.ShippingPage.InputErrorMessage with index 4 contains text "<Error4>"
      And I see Checkout.ShippingPage.InputErrorMessage with index 5 contains text "<Error5>"
      And I see Checkout.ShippingPage.InputErrorMessage with index 6 contains text "<Error6>"
      And I see Checkout.ShippingPage.InputErrorMessage with index 7 contains text "<Error7>"

    @tms:UTR-11271
    Examples:
      | locale | langCode | Error1                                                         | Error2                        | Error3                         | Error4                       | Error5                               | Error6                                                      | Error7                    |
      | de     | default  | Sorry, leider scheint das keine gültige E-Mail-Adresse zu sein | Bitte gib Deinen Vornamen ein | Bitte gib Deinen Nachnamen ein | Die Postnummer ist ungültig. | Die Packstation-Nummer ist ungültig. | Bitte geben Sie eine gültige Postleitzahl ein (z. B. 12345) | Bitte gib Deine Stadt ein |

    @tms:UTR-14849
    Examples:
      | locale | langCode | Error1                                         | Error2                         | Error3                        | Error4                  | Error5                         | Error6                                        | Error7                        |
      | de     | EN       | Sorry, that doesn't look like an email address | Please fill in your first name | Please fill in your last name | Post Number is invalid. | Packstation Number is invalid. | Please enter a valid postcode (e.g. 12345) | Please fill in your town/city |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @DHL @Negative @P2
  Scenario Outline: DHL - As logged in user I can see empty/invalid field errors in DHL form
    Given I am logged in on locale <locale> of langCode default on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.DHLPackstationRadioButton is displayed
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
    When I type to following inputs
      | element                                        | value |
      | Checkout.ShippingPage.EmailInput               | 1     |
      | Checkout.ShippingPage.FirstNameInput           | 2     |
      | Checkout.ShippingPage.LastNameInput            | 3     |
      | Checkout.ShippingPage.DHLPackstationPostnumber | a     |
      | Checkout.ShippingPage.DHLPackstationNumber     | b     |
      | Checkout.ShippingPage.PostcodeInput            | c     |
      | Checkout.ShippingPage.CityInput                | 4     |
    When I click on Checkout.ShippingPage.ProceedToPayment
    Then I see Checkout.ShippingPage.InputErrorMessage with index 1 contains text "Bitte gib Deinen Vornamen ein"
      And I see Checkout.ShippingPage.InputErrorMessage with index 2 contains text "Bitte gib Deinen Nachnamen ein"
      And I see Checkout.ShippingPage.InputErrorMessage with index 3 contains text "Die Postnummer ist ungültig."
      And I see Checkout.ShippingPage.InputErrorMessage with index 4 contains text "Die Packstation-Nummer ist ungültig."
      And I see Checkout.ShippingPage.InputErrorMessage with index 5 contains text "Bitte geben Sie eine gültige Postleitzahl ein (z. B. 12345)"
      And I see Checkout.ShippingPage.InputErrorMessage with index 6 contains text "Bitte gib Deine Stadt ein"

    @tms:UTR-11272 @ExcludeTH
    Examples:
      | locale |
      | de     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox
  @UnifiedCheckout @PaymentPage @DeliveryMethods @DHL @Negative @P2
  Scenario Outline: DHL - As a guest user I want to check that Ratepay is not available after choosing DHL Packstation
    Given I am guest on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.DHLPackstationRadioButton is displayed
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I wait for 1 seconds
    When I type to following inputs
      | element                                        | value                       |
      | Checkout.ShippingPage.PostcodeInput            | 12345                       |
      | Checkout.ShippingPage.EmailInput               | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput           | Testing                     |
      | Checkout.ShippingPage.LastNameInput            | Testovich                   |
      | Checkout.ShippingPage.DHLPackstationPostnumber | 10179                       |
      | Checkout.ShippingPage.DHLPackstationNumber     | 181                         |
      | Checkout.ShippingPage.CityInput                | Berlin                      |
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    Then I see Checkout.PaymentPage.RatepayButton is not displayed

    @tms:UTR-11273
    Examples:
      | locale | langCode |
      | de     | default  |

    @tms:UTR-14850
    Examples:
      | locale | langCode |
      | de     | EN       |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @DHL
  @issue:EESCK-11564
  Scenario Outline: DHL - Packstation address should be displayed on the payment without any other text
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.DHLPackstationRadioButton is displayed
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I wait for 1 seconds
    When I type to following inputs
      | element                                        | value                       |
      | Checkout.ShippingPage.EmailInput               | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput           | Testing                     |
      | Checkout.ShippingPage.LastNameInput            | Testovich                   |
      | Checkout.ShippingPage.DHLPackstationPostnumber | 10179                       |
      | Checkout.ShippingPage.DHLPackstationNumber     | 181                         |
      | Checkout.ShippingPage.PostcodeInput            | 12345                       |
      | Checkout.ShippingPage.CityInput                | Berlin                      |
      And I see Checkout.ShippingPage.DeliveryMethodSubtitle is displayed
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    Then I see Checkout.ShippingPage.DeliveryMethodSubtitle is not displayed

    @tms:UTR-14255
    Examples:
      | locale | langCode | userType  |
      | de     | default  | logged in |

    @tms:UTR-14851
    Examples:
      | locale | langCode | userType |
      | de     | EN       | guest    |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @DHL
  @issue:EESCK-11564
  Scenario Outline: DHL - Packstation address should be displayed on the payment without any other text
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.DHLPackstationRadioButton is displayed
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I wait for 1 seconds
    When I type to following inputs
      | element                                        | value                       |
      | Checkout.ShippingPage.EmailInput               | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput           | Testing                     |
      | Checkout.ShippingPage.LastNameInput            | Testovich                   |
      | Checkout.ShippingPage.DHLPackstationPostnumber | 10179                       |
      | Checkout.ShippingPage.DHLPackstationNumber     | 181                         |
      | Checkout.ShippingPage.PostcodeInput            | 12345                       |
      | Checkout.ShippingPage.CityInput                | Berlin                      |
      And I see Checkout.ShippingPage.DeliveryMethodSubtitle is displayed
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    Then I see Checkout.ShippingPage.DeliveryMethodSubtitle is not displayed

    @tms:UTR-14255
    Examples:
      | locale | langCode | userType  |
      | de     | default  | logged in |

    @tms:UTR-14851
    Examples:
      | locale | langCode | userType |
      | de     | EN       | guest    |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @Payment @DHL @P2
  Scenario Outline: DHL Packstation - As a guest/user I can select then switch my delivery method to DHL and complete purchase
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And I click on Checkout.ShippingPage.StandardRadioButton
      And I wait until Checkout.ShippingPage.NewAddressSection is displayed
      And as a <userType> I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I navigate back in the browser
      And I wait until Checkout.ShippingPage.PickupTabButton is clickable
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.DHLPackstationRadioButton is displayed
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I wait for 2 seconds
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
    When I type to following empty inputs
      | element                                        | value  |
      | Checkout.ShippingPage.DHLPackstationPostnumber | 10179  |
      | Checkout.ShippingPage.DHLPackstationNumber     | 181    |
      | Checkout.ShippingPage.PostcodeInput            | 12345  |
      | Checkout.ShippingPage.CityInput                | Berlin |
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I click on Checkout.ShippingPage.ProceedToPayment if exists
    When I wait until Checkout.PaymentPage.NewBillingAddressButton is clickable
    Then I check that my billing details with index "1" have been saved
    When I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 5100 2900 2900 2909 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-17924 @Mobile
    Examples:
      | locale | langCode | userType |
      | de     | default  | guest    |

    @tms:UTR-17925
    Examples:
      | locale | langCode | userType  |
      | de     | EN       | logged in |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @HappyFlow @Payment @DHL @P2
  Scenario Outline: DHL Packstation - As a guest/user I can select DHL as my delivery method then go switch to another delivery method and complete purchase
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.DHLPackstationRadioButton is displayed
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I wait for 1 seconds
    When I type to following inputs
      | element                                        | value                       |
      | Checkout.ShippingPage.EmailInput               | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput           | Testing                     |
      | Checkout.ShippingPage.LastNameInput            | Testovich                   |
      | Checkout.ShippingPage.DHLPackstationPostnumber | 10179                       |
      | Checkout.ShippingPage.DHLPackstationNumber     | 181                         |
      | Checkout.ShippingPage.PostcodeInput            | 12345                       |
      | Checkout.ShippingPage.CityInput                | Berlin                      |
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I click on Checkout.ShippingPage.ProceedToPayment if exists
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I navigate back in the browser
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.DeliveryTabButton
      And I click on Checkout.ShippingPage.StandardRadioButton
      And as a <userType> I add first delivery details
      And I wait for 1 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I click on Checkout.ShippingPage.ProceedToPayment if exists
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 5100 2900 2900 2909 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    When I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Then I see Order Confirmation Page with my delivery details

    @tms:UTR-17926 @Mobile
    Examples:
      | locale | langCode | userType |
      | de     | default  | guest    |

    @tms:UTR-17927
    Examples:
      | locale | langCode | userType  |
      | de     | EN       | logged in |
