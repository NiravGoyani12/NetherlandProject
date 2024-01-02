Feature: Sap Products Orders

  #SAP Products : locale : Payment Type : Shipping Method => Order creation

  @Desktop
  @Chrome
  @UnifiedCheckout @Payment @DeliveryMethods @SAP @Bancontact @PaymentPage @HappyFlow
  Scenario Outline: Bancontact - As guest I can pay with bancontact with SAP items using standard delivery
    Given I am on locale <locale> shopping bag page with 1 units for product item <EanNumber> with forced accepted cookies
      And I store the cartId
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And as a <userType> I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.BancontactButton is clickable
      And I click on Checkout.PaymentPage.BancontactButton
      And I wait for 2 seconds
      And in payment page I fill in the Bancontact details
      | name       | value  |
      | cardNumber | <card> |
      | year       | 2030   |
      | month      | 03     |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then URL should contain "validate" within 15 seconds
    When with user "user" and password "password" I complete 3DS1 payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @ExcludeCK @ToggleON
    Examples:
      | locale | langCode | card                | userType  | EanNumber                   |
      | be     | default  | 6703 4444 4444 4449 | sap_guest | 8719254142726,8719702614324 |

    @ExcludeTH @ToggleON
    Examples:
      | locale | langCode | card                | userType  | EanNumber                   |
      | be     | FR       | 6703 4444 4444 4449 | sap_guest | 5052722319545,8719114074648 |

  @Desktop
  @Chrome
  @UnifiedCheckout @Payment @SAP @DeliveryMethods @Bancontact @PaymentPage @HappyFlow
  Scenario Outline: Bancontact - As user I can pay with bancontact with SAP Items using express delivery
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product item <EanNumber> with forced accepted cookies
      And I store the cartId
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And as a <userType> I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.BancontactButton is clickable
      And I click on Checkout.PaymentPage.BancontactButton
      And I wait for 2 seconds
      And in payment page I fill in the Bancontact details
      | name       | value  |
      | cardNumber | <card> |
      | year       | 2030   |
      | month      | 03     |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then URL should contain "validate" within 15 seconds
    When with user "user" and password "password" I complete 3DS1 payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @ExcludeCK @ToggleON
    Examples:
      | locale | langCode | userType  | card                | EanNumber                   |
      | be     | default  | sap_guest | 4871 0499 9999 9910 | 8718941982614,8719702614324 |

    @ExcludeTH @ToggleON
    Examples:
      | locale | langCode | userType  | card                | EanNumber                   |
      | be     | FR       | sap_guest | 4871 0499 9999 9910 | 8718571438864,8719114074648 |

  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @SAP @CreditCard @3DS2 @HappyFlow
  Scenario Outline: Credit card - As guest I see logo of 3ds2 card type entered and I can complete payment for SAP items
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product item <EanNumber> with forced accepted cookies
      And I store the cartId
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait until Checkout.ShippingPage.UPSAccesPointSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.UPSAccesPointSearchField
      And I click on Checkout.ShippingPage.UPSAccesPointFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I type to following inputs
      | element                              | value                    |
      | Checkout.ShippingPage.EmailInput     | pvh.sap_user@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | pvhSapFirstName          |
      | Checkout.ShippingPage.LastNameInput  | pvhSapLastName           |
      | Checkout.ShippingPage.PhoneInput     | #PHONE                   |
      And I wait until Checkout.ShippingPage.ProceedToPayment is enabled
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | cvv        | <cvv>      |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | Automation |
      | lastName   | QA         |
    Then I see Checkout.PaymentPage.CreditDebitCardNumberLogo with args <type> is displayed
    When I set the checkbox Checkout.PaymentPage.TermsAndConditionsCheckbox status to true
      And I add other billing details
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @ExcludeCK
    Examples:
      | locale | langCode | userType  | card               | cvv  | type | EanNumber     |
      | fr     | default  | sap_guest | 3714 4963 5398 431 | 7373 | amex | 8718772986799 |

    @ExcludeTH
    Examples:
      | locale | langCode | userType  | card               | cvv  | type | EanNumber     |
      | fr     | default  | sap_guest | 3700 0000 0000 002 | 7373 | amex | 8718571438734 |

  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @SAP @CreditCard @3DS2 @HappyFlow
  Scenario Outline: Credit card - As user I see logo of 3ds2 card type entered and I can complete payment for SAP items
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product item <EanNumber> with forced accepted cookies
      And I store the cartId
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | cvv        | <cvv>      |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | Automation |
      | lastName   | QA         |
    Then I see Checkout.PaymentPage.CreditDebitCardNumberLogo with args <type> is displayed
    When I set the checkbox Checkout.PaymentPage.TermsAndConditionsCheckbox status to true
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And in 3DS2 pop-up I fill in the Adyen password "password"
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @ExcludeTH @ToggleON
    Examples:
      | locale | langCode | userType           | card                | cvv | type | EanNumber                                                                                                       |
      | at     | default  | sap_user logged in | 4917 6100 0000 0000 | 737 | visa | 8719114074648,8718935916540,8719114077151,8720107868830,8719856810283,5052722296136,8718935916588,5052722296143 |

    @ExcludeCK @ToggleON
    Examples:
      | locale | langCode | userType           | card                | cvv | type | EanNumber                                                                                         |
      | pt     | default  | sap_user logged in | 4917 6100 0000 0000 | 737 | visa | 8718941982614,8720245449953,8720642495324,8713537926577,8718661696228,8719107568505,2S87905539416 |


    @ExcludeTH @ToggleOFF
    Examples:
      | locale  | langCode | userType           | card                | cvv | type | EanNumber                                                                                                       |
      | default | default  | sap_user logged in | 4917 6100 0000 0000 | 737 | visa | 8719114074648,8718935916540,8719114077151,8720107868830,8719856810283,5052722296136,8718935916588,5052722296143 |

    @ExcludeCK @ToggleOFF
    Examples:
      | locale  | langCode | userType           | card                | cvv | type | EanNumber                                                                                         |
      | default | default  | sap_user logged in | 4917 6100 0000 0000 | 737 | visa | 8718941982614,8720245449953,8720642495324,8713537926577,8718661696228,8719107568505,2S87905539416 |


  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @SAP @iDeal @HappyFlow
  Scenario: iDeal - As a NL guest user with SAP Items I can pay order with iDeal
    Given I am on locale <locale> shopping bag page with 1 units for product item <EanNumber> with forced accepted cookies
      And I store the cartId
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.PostNLRadioButton
      And I wait until Checkout.ShippingPage.PostNLSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.PostNLSearchField
      And I click on Checkout.ShippingPage.PostNLFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I type to following inputs
      | element                              | value                    |
      | Checkout.ShippingPage.EmailInput     | pvh.sap_user@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | pvhSapFirstName          |
      | Checkout.ShippingPage.LastNameInput  | pvhSapLastName           |
      | Checkout.ShippingPage.PhoneInput     | #PHONE                   |
      And I see Checkout.ShippingPage.ProceedToPayment is enabled
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.IdealButton is clickable
      And I click on Checkout.PaymentPage.IdealButton
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Test Issuer 6"
      And I add other billing details
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 1 seconds
      And in ideal I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @ExcludeTH @ToggleON
    Examples:
      | locale | userType  | EanNumber                   |
      | nl     | sap_guest | 8719114077151,8718571438734 |

    @ExcludeCK @ToggleON
    Examples:
      | locale | userType  | EanNumber                   |
      | nl     | sap_guest | 8718661696228,8719702614324 |


  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @SAP @iDeal @HappyFlow
  Scenario: iDeal - As a NL user with SAP Items I can pay order with iDeal
    Given I am on locale <locale> shopping bag page with 1 units for product item <EanNumber> with forced accepted cookies
      And I store the cartId
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
      And I wait for 2 seconds
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.IdealButton is clickable
      And I click on Checkout.PaymentPage.IdealButton
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Test Issuer 6"
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 1 seconds
      And in ideal I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @ExcludeTH @ToggleON
    Examples:
      | locale | userType           | EanNumber                   |
      | nl     | sap_user logged in | 8719114077151,5051145189247 |

    @ExcludeCK @ToggleON
    Examples:
      | locale | userType           | EanNumber                   |
      | nl     | sap_user logged in | 8718661696228,8719702614324 |


  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @SAP @KlarnaInstalments @HappyFlow
  Scenario Outline: Klarna - As guest I can place order with Klarna pay later with SAP Items using express shipping
    Given I am on locale <locale> shopping bag page with 1 units for product item <EanNumber> with forced accepted cookies
      And I store the cartId
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And I get express shipping costs for current locale and store it with key #shippingCosts
      And I click on Checkout.ShippingPage.ExpressRadioButton
    Then I see Checkout.OverviewPanel.ShippingPrice contains text "#shippingCosts"
      And as a <userType> I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is clickable
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 1 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And in klarna I complete payment for scenario Instalments
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    # @ExcludeTH @ToggleON
    # Examples:
    #   | locale | userType  | langCode | EanNumber                   |
    #   | be     | sap_guest | default  | 8718934300821,8718571438734 |

    @ExcludeTH
    Examples:
      | locale | userType  | langCode | EanNumber                   |
      | it     | sap_guest | default  | 8718934300821,8718571438734 |

    @ExcludeCK @ToggleON
    Examples:
      | locale | userType  | langCode | EanNumber                   |
      | fi     | sap_guest | default  | 8718824089638,8719702614324 |

    @ExcludeCK
    Examples:
      | locale | userType  | langCode | EanNumber                   |
      | it     | sap_guest | default  | 8718824089638,8719702614324 |

  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @SAP @Klarna @HappyFlow
  Scenario Outline: Klarna - As a user I can place order with Klarna pay later with SAP Items using collect in store shipping
    Given I am on locale <locale> shopping bag page for product item <EanNumber> with forced accepted cookies
      And I store the cartId
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I wait until Checkout.ShippingPage.CollectInStoreSearchField is displayed
    When I type "<searchText>" in the field Checkout.ShippingPage.CollectInStoreSearchField
      And I click on Checkout.ShippingPage.CollectInStoreFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is clickable
      And I wait until Checkout.ShippingPage.PUPModalSearchField is in viewport
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I type to following inputs
      | element                              | value                    |
      | Checkout.ShippingPage.EmailInput     | pvh.sap_user@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | pvhSapFirstName          |
      | Checkout.ShippingPage.LastNameInput  | pvhSapLastName           |
      And I wait until Checkout.ShippingPage.ProceedToPayment is enabled
      And I click on Checkout.ShippingPage.ProceedToPayment
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.Klarna is clickable
      And I wait until Checkout.PaymentPage.Klarna is in viewport
      And I click on Checkout.PaymentPage.Klarna
      And I wait for 1 seconds
      And I add other billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 10 seconds
      And in klarna I complete payment for scenario Positive
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @ExcludeTH
    Examples:
      | locale | userType  | langCode | EanNumber     | searchText |
      | pl     | sap_guest | default  | 5052722296143 | Warsaw     |

    @ExcludeTH @ToggleON
    Examples:
      | locale | userType  | langCode | EanNumber                   | searchText |
      | at     | sap_guest | default  | 5051145283365,5051145189247 | viena      |

    @ExcludeTH
    Examples:
      | locale | userType  | langCode | EanNumber                   | searchText |
      | de     | sap_guest | default  | 5051145283365,5051145189247 | berlin     |

    @ExcludeCK
    Examples:
      | locale | userType  | langCode | EanNumber     | searchText |
      | pl     | sap_guest | default  | 8719254142726 | Warsaw     |

    @ExcludeCK @ToggleON
    Examples:
      | locale | userType  | langCode | EanNumber     | searchText |
      | at     | sap_guest | default  | 8718661696228 | viena      |

    @ExcludeCK
    Examples:
      | locale | userType  | langCode | EanNumber     | searchText |
      | de     | sap_guest | default  | 8718661696228 | berlin     |

  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @SAP @KlarnaInstalments @HappyFlow
  Scenario Outline: Klarna Pay Overtime - As guest I can place order with Klarna pay in instalments with SAP Items using express shipping
    Given I am on locale <locale> shopping bag page with 1 units for product item <EanNumber> with forced accepted cookies
      And I store the cartId
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And as a <userType> I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is clickable
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 1 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And in klarna I complete payment for scenario Instalments
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @ExcludeCK @ToggleOFF
    Examples:
      | locale | userType  | EanNumber                   |
      | fr     | sap_guest | 8718661696228,8719702614324 |

    @ExcludeTH @ToggleOFF
    Examples:
      | locale | userType  | EanNumber                   |
      | fr     | sap_guest | 5051145283365,5051145189247 |

    @ExcludeCK @ToggleON
    Examples:
      | locale | userType  | EanNumber                   |
      | es     | sap_guest | 8718661696228,8719702614324 |

  # @ExcludeTH @ToggleON
  # Examples:
  #   | locale | userType  | EanNumber                   |
  #   | be     | sap_guest | 5051145283365,5051145189247 |


  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @SAP @KlarnaInstalments @HappyFlow
  Scenario Outline: Klarna Pay Overtime - As a user I can place order with Klarna pay in instalments with SAP Items using express shipping
    Given I am on locale <locale> shopping bag page with 1 units for product item <EanNumber> with forced accepted cookies
      And I store the cartId
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And as a <userType> I add other delivery details
      And I wait until Checkout.ShippingPage.ProceedToPayment is clickable
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is clickable
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 1 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And in klarna I complete payment for scenario Instalments
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @ExcludeCK @ToggleOFF
    Examples:
      | locale | userType           | EanNumber                   |
      | fr     | sap_user logged in | 8713537481922,8719702614324 |

    @ExcludeTH @ToggleOFF
    Examples:
      | locale | userType           | EanNumber                   |
      | pt     | sap_user logged in | 5051145283365,5051145189247 |

    @ExcludeCK @ToggleON
    Examples:
      | locale | userType           | EanNumber                   |
      | es     | sap_user logged in | 8713537481922,8719702614324 |

  # @ExcludeTH @ToggleON
  # Examples:
  #   | locale | userType           | EanNumber                   |
  #   | be     | sap_user logged in | 5051145283365,5051145189247 |

  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @SAP @PayPalExpress @Negative @P2
  Scenario Outline: Paypal - I am returned to shopping bag page with no error when I navigate back from paypal express and I can place the order when trying again
    Given I am on locale <locale> shopping bag page with 2 units for product item <EanNumber> with forced accepted cookies
      And I store the cartId
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I select paypal express and get to paypal login
      And in paypal I complete payment for locale fr
      And I use paypal payment to compelte payment for SAP orders
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @ExcludeCK @ToggleON
    Examples:
      | locale | EanNumber                   |
      | fr     | 8719254141729,8719254142726 |

    @ExcludeTH @ToggleON
    Examples:
      | locale | EanNumber                   |
      | fr     | 8718935916687,5052722319545 |


    @ExcludeCK @ToggleOFF
    Examples:
      | locale | EanNumber                   |
      | ch     | 8719254141729,8719254142726 |

    @ExcludeTH @ToggleOFF
    Examples:
      | locale | EanNumber                   |
      | es     | 8718935916687,5052722319545 |

  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @SAP @Ratepay @HappyFlow
  Scenario Outline: Ratepay - As guest I can pay by payment on invoice (Ratepay) with SAP Items using express delivery
    Given I am on locale <locale> shopping bag page with 1 units for product item <EanNumber> with forced accepted cookies
      And I store the cartId
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And as a <userType> I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I click on Checkout.PaymentPage.RatepayButton
      And I set attribute type of element Checkout.PaymentPage.BirthdayDayDate to "text"
      And I type to following inputs
      | element                               | value      |
      | Checkout.PaymentPage.PhoneNumberInput | 7865321321 |
      | Checkout.PaymentPage.BirthdayDayDate  | 09092000   |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @ExcludeCK @ToggleON
    Examples:
      | locale | userType  | EanNumber                   |
      | de     | sap_guest | 8713537477772,8719702614324 |

    @ExcludeTH @ToggleON
    Examples:
      | locale | userType  | EanNumber                   |
      | de     | sap_guest | 8718571438895,5051145189247 |

    @ExcludeCK @ToggleOFF
    Examples:
      | locale | userType  | EanNumber                   |
      | ch     | sap_guest | 8713537477772,8719702614324 |

    @ExcludeTH @ToggleOFF
    Examples:
      | locale | userType  | EanNumber                   |
      | ch     | sap_guest | 8718571438895,5051145189247 |


  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @SAP @Przelewy24 @HappyFlow
  Scenario Outline: Przelewy24 - As a PL guest or user I can place order with Przelewy24 with SAP Items using standard delivery
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product item <EanNumber> with forced accepted cookies
      And I store the cartId
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait until Checkout.ShippingPage.UPSAccesPointSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.UPSAccesPointSearchField
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.UPSAccesPointFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I type to following inputs
      | element                              | value                    |
      | Checkout.ShippingPage.EmailInput     | pvh.sap_user@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | pvhSapFirstName          |
      | Checkout.ShippingPage.LastNameInput  | pvhSapLastName           |
      | Checkout.ShippingPage.PhoneInput     | #PHONE                   |
      And I wait until Checkout.ShippingPage.ProceedToPayment is enabled
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.P24Button is clickable
      And I click on Checkout.PaymentPage.P24Button
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Banki Spółdzielcze"
      And I set T&C checkbox to true if XCOMREG is enabled
      And I add other billing details
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And in Przelewy24 I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @ExcludeCK
    Examples:
      | locale | langCode | userType  | EanNumber                   |
      | pl     | default  | sap_guest | 8713537477772,8719702614324 |

    @ExcludeTH
    Examples:
      | locale | langCode | userType  | EanNumber                   |
      | pl     | default  | sap_guest | 5051145189247,5051145283365 |

    @ExcludeCK @ToggleOFF
    Examples:
      | locale | langCode | userType  | EanNumber                   |
      | sk     | default  | sap_guest | 8713537477772,8719702614324 |

    @ExcludeTH @ToggleOFF
    Examples:
      | locale | langCode | userType  | EanNumber                   |
      | sk     | default  | sap_guest | 5051145189247,5051145283365 |

  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @SAP @PayPal @IFrame @MultipleTabs @Promocode @HappyFlow
  Scenario Outline: Paypal - As guest I can pay with paypal even after I add a promo code on payment page for SAP Items
    Given I am on locale <locale> shopping bag page for product item <EanNumber> with forced accepted cookies
      And I store the cartId
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.DHLPackstationRadioButton is clickable
      And I wait until Checkout.ShippingPage.DHLPackstationRadioButton is in viewport
      And I wait until Checkout.ShippingPage.DHLPackstationRadioButton is displayed
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I wait for 1 seconds
    When I type to following inputs
      | element                                        | value                    |
      | Checkout.ShippingPage.EmailInput               | pvh.sap_user@outlook.com |
      | Checkout.ShippingPage.FirstNameInput           | pvhSapFirstName          |
      | Checkout.ShippingPage.LastNameInput            | pvhSapLastName           |
      | Checkout.ShippingPage.DHLPackstationPostnumber | 10179                    |
      | Checkout.ShippingPage.DHLPackstationNumber     | 181                      |
      | Checkout.ShippingPage.PostcodeInput            | 12345                    |
      | Checkout.ShippingPage.CityInput                | Berlin                   |
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
    When I click on Checkout.OverviewPanel.EnterPromoCodeButton
      And I wait until Checkout.OverviewPanel.PromoCodeField is clickable
      And I wait until Checkout.OverviewPanel.PromoCodeField is in viewport
      And I type "<promoCode>" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Checkout.OverviewPanel.PromoCodeApplyButton
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
      And I wait until Checkout.ShippingPage.ProceedToPayment is enabled
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
      And I wait until Checkout.PaymentPage.PaypalButton is in viewport
      And I scroll to and click on Checkout.PaymentPage.PaypalButton
      And I wait until Checkout.PaymentPage.PayWithPayPal is clickable
      And I set T&C checkbox to true if XCOMREG is enabled
      And I add other billing details
      And I select paypal payment and go to paypal layover
      And I use paypal payment to compelte payment for SAP orders
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @ExcludeCK
    Examples:
      | locale | langCode | userType  | EanNumber     | promoCode    |
      | de     | default  | sap_guest | 8719256689724 | THAUTOMATION |

    @ExcludeTH
    Examples:
      | locale | langCode | userType  | EanNumber     | promoCode    |
      | de     | default  | sap_guest | 8719852242217 | CKAUTOMATION |

  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @GiftCards @Payment @PaymentPage @HappyFlow @GiftCardPurchase @CreditCard @3DS2
  Scenario Outline: Credit card - As guest/user I can create SAP Items order using 3DS2 dankort visa payment
    Given I am on locale <locale> shopping bag page with 1 units for product item <EanNumber> with forced accepted cookies
      And I store the cartId
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And as a <userType> I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
    When I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | cvv        | <cvv>      |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | Automation |
      | lastName   | QA         |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And in 3DS2 pop-up I fill in the Adyen password "password"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @ExcludeCK @ToggleON
    Examples:
      | locale | langCode | userType | card                | cvv | EanNumber     |
      | dk     | default  | guest    | 5019 5555 4444 5555 | 737 | 8713537477772 |

    @ExcludeCK @ToggleON
    Examples:
      | locale | langCode | userType | card                | cvv | EanNumber     |
      | dk     | default  | guest    | 5019 5555 4444 5555 | 737 | 8718571438895 |


  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @SAP @Payment @GiftCard @HappyFlow @GiftCardRedemption
  Scenario Outline: GiftCard - As guest/user I can redim my giftcard along with creditcard as a split payments for SAP Items
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product item <EanNumber> with forced accepted cookies
      And I store the cartId
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait for 2 seconds
      And as a <userType> I add first delivery details
      And I continue as <userType> to shipping page
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.GiftCardButton is clickable in 10 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
    When I click on Checkout.PaymentPage.GiftCardButton
    Then in payment page I fill in the gift card details
      | element    | value               |
      | cardNumber | 6036280000000000000 |
      | pin        | 1234                |
      And I click on Payments.GiftCardPage.ApplyGiftCardButton is clickable
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value      |
      | cardNumber | <card>     |
      | cvv        | <cvv>      |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | Automation |
      | lastName   | QA         |
    When I set the checkbox Checkout.PaymentPage.TermsAndConditionsCheckbox status to true
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And in 3DS2 pop-up I fill in the Adyen password "password"
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @ExcludeCK
    Examples:
      | locale | langCode | userType  | card                | cvv | EanNumber     |
      | fi     | default  | sap_guest | 4917 6100 0000 0000 | 737 | 8719254145482 |

    @ExcludeTH
    Examples:
      | locale | langCode | userType           | card                | cvv | EanNumber     |
      | fi     | default  | sap_user logged in | 4917 6100 0000 0000 | 737 | 8719852766508 |


  # GC redemptions flows

  @Desktop @Mobile
  @Chrome @FireFox @Safari @tms:UTR-18785
  @UnifiedCheckout @SAP @GiftCards @Payment @HappyFlow @GiftCardReedemption
  Scenario Outline: Gift-Card Redemption - As guest I purchase gift-card and I can redeem it for gift-card and credit card as split payments
    Given I am on locale <locale> of url /geschenkgutscheine of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      And I type to following inputs
      | element                              | value                         |
      | Checkout.ShippingPage.EmailInput     | pvh.nl.automation@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                       |
      | Checkout.ShippingPage.LastNameInput  | Testovich                     |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
      And I add giftCardFirst billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
      And I click on Checkout.PaymentPage.PaypalButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 2 units for product item <EanNumber> with forced accepted cookies
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a guest I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.GiftCardButton is clickable in 10 seconds
    When I click on Checkout.OverviewPanel.EnterPromoCodeButton
      And I wait until Checkout.OverviewPanel.PromoCodeField is clickable
      And I wait until Checkout.OverviewPanel.PromoCodeField is in viewport
      And I type "<promoCode>" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Checkout.OverviewPanel.PromoCodeApplyButton
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I fetch an gift-card number and pin from email <giftCardEmailSubject> using gift-card order as #orderNumber to redeem it
      And I click on Payments.GiftCardPage.ApplyGiftCardButton
      And I wait for 2 seconds
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | element    | value               |
      | cardNumber | 5454 5454 5454 5454 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | QA                  |
      | lastName   | Automation          |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
    When in 3DS2 pop-up I fill in the Adyen password "password"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @ExcludeCK
    Examples:
      | locale | langCode | userType | EanNumber     | giftCardEmailSubject               | promoCode    |
      | at     | default  | guest    | 8719254142726 | Tommy Hilfiger Geschenkgutschein - | THAUTOMATION |

    @ExcludeTH
    Examples:
      | locale | langCode | userType | EanNumber     | giftCardEmailSubject   | promoCode    |
      | at     | default  | guest    | 5052722296143 | CK Geschenkgutschein - | CKAUTOMATION |

  @Desktop
  @Chrome @FireFox @Safari @tms:UTR-18785
  @UnifiedCheckout @SAP @Payment @GiftCard @HappyFlow @GiftCardReedemption
  Scenario Outline: Gift-Card Redemption - As guest I purchase gift-card and I can redeem it for gift-card only order
    Given I am on locale <locale> of url /geschenkgutscheine of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      And I type to following inputs
      | element                              | value                         |
      | Checkout.ShippingPage.EmailInput     | pvh.nl.automation@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                       |
      | Checkout.ShippingPage.LastNameInput  | Testovich                     |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
      And I add giftCardFirst billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
      And I click on Checkout.PaymentPage.PaypalButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product item <EanNumber> with forced accepted cookies
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a guest I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.GiftCardButton is clickable in 10 seconds
    When I click on Checkout.OverviewPanel.EnterPromoCodeButton
      And I wait until Checkout.OverviewPanel.PromoCodeField is clickable
      And I wait until Checkout.OverviewPanel.PromoCodeField is in viewport
      And I type "<promoCode>" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Checkout.OverviewPanel.PromoCodeApplyButton
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I fetch an gift-card number and pin from email <giftCardEmailSubject> using gift-card order as #orderNumber to redeem it
      And I click on Payments.GiftCardPage.ApplyGiftCardButton
      And I wait for 2 seconds
      And I wait until Checkout.PaymentPage.PlaceOrderButton is clickable
    When I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @ExcludeCK
    Examples:
      | locale | langCode | userType | EanNumber     | giftCardEmailSubject               | promoCode    |
      | at     | default  | guest    | 8719254142726 | Tommy Hilfiger Geschenkgutschein - | THAUTOMATION |

    @ExcludeTH
    Examples:
      | locale | langCode | userType | EanNumber     | giftCardEmailSubject   | promoCode    |
      | at     | default  | guest    | 5052722296143 | CK Geschenkgutschein - | CKAUTOMATION |

# To be refactor for fast test screations : 
  # @Desktop
  # @Chrome @FireFox @Safari
  # @UnifiedCheckout @SAP
  # Scenario Outline: GiftCard - As guest/user I can redim my giftcard only for SAP Items
  #   Given I am on locale <locale> shopping bag page of langCode <langCode> with 2 units for product item <EanNumber> with forced accepted cookies
  #     And I wait until the current page is loaded
  #     And I click on Experience.ShoppingBag.StartCheckoutButton
  #     And I store the cartId
  #     And I choose delivery method as <deliveryType> for userType as <userType> based on current locale
  #     And I wait until Checkout.ShippingPage.ProceedToPayment is clickable
  #     And I click on Checkout.ShippingPage.ProceedToPayment
  #     And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
  #     And I choose payment method as <paymentType> with promo <promoCode>
  #   Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

  #   @ExcludeCK
  #   Examples:
  #     | locale  | langCode | userType  | EanNumber     | deliveryType | paymentType           | promoCode |
  #     | default | default  | sap_guest | 8719254146793 | standard     | creditCard,masterCard |           |

  #   @ExcludeTH
  #   Examples:
  #     | locale  | langCode | userType | EanNumber     | deliveryType | paymentType           | promoCode |
  #     | default | default  | guest    | 8719852766508 | cis          | creditCard,masterCard |           |

