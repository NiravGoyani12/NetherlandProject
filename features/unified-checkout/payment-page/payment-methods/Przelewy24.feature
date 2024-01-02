Feature: Unified Checkout - Payment Methods - Przelewy24

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @Przelewy24 @PaymentPage @HappyFlow
  Scenario Outline: Przelewy24 - As a PL guest or user I can place order with Przelewy24 with standard delivery
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.P24Button is clickable
      And I click on Checkout.PaymentPage.P24Button
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Banki Spółdzielcze"
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And in Przelewy24 I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10395
    Examples:
      | locale | langCode | userType |
      | pl     | default  | guest    |

  #@FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @Przelewy24 @PaymentPage @HappyFlow
  Scenario Outline: Przelewy24 - As a PL guest or user I can place order with Przelewy24 with express delivery
    Given I am logged in on locale <locale> of langCode default with express delivery method on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.P24Button is clickable
      And I click on Checkout.PaymentPage.P24Button
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Banki Spółdzielcze"
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And in Przelewy24 I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10393
    Examples:
      | locale | langCode | userType  |
      | pl     | default  | logged in |

  @FullRegression
  @Desktop @Mobile
  @Chrome
  @UnifiedCheckout @DeliveryMethods @Payment @Przelewy24 @UPSAP @ShippingPage @HappyFlow
  Scenario Outline: Przelewy24 - As PL guest I can complete an order with UPS Access Point as my delivery method
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
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
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      | Checkout.ShippingPage.PhoneInput     | #PHONE                      |
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

    @tms:UTR-13118 @P2
    Examples:
      | locale | langCode | userType |
      | pl     | default  | guest    |

  @FullRegression
  @Desktop @Mobile
  @Chrome
  @UnifiedCheckout @DeliveryMethods @Payment @Przelewy24 @UPSAP @ShippingPage @HappyFlow
  Scenario Outline: Przelewy24 - As PL user I can complete an order with Collect in Store as my delivery method
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I wait until Checkout.ShippingPage.CollectInStoreSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.CollectInStoreSearchField
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
      And I wait until Checkout.PaymentPage.P24Button is clickable
      And I click on Checkout.PaymentPage.P24Button
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Banki Spółdzielcze"
      And I set T&C checkbox to true if XCOMREG is enabled
      And I add other billing details
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And in Przelewy24 I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-13119 @P2
    Examples:
      | locale | langCode | userType  |
      | pl     | default  | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @Przelewy24 @Negative @P3 @PaymentPage
  Scenario Outline: Przelewy24 - As a PL guest I can't pay with Przelewy24 when total price is more than the limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 200 and 99999 and inventory between 50 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 50 units for product items product1#skuPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a guest I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.P24Button is clickable
      And I click on Checkout.PaymentPage.P24Button
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Banki Spółdzielcze"
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I get dotpay payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 3 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#PaymentLimit"

    @tms:UTR-10392
    Examples:
      | locale | langCode |
      | pl     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @Przelewy24 @Negative @P3 @PaymentPage
  Scenario Outline: Przelewy24 - As a PL user I can't pay with Przelewy24 when total price is more than the limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 200 and 99999 and inventory between 50 and 9999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I am on locale <locale> shopping bag page of langCode <langCode> with 50 units for product items product1#skuPartNumber
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a logged in I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.P24Button is clickable
      And I click on Checkout.PaymentPage.P24Button
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Banki Spółdzielcze"
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I get dotpay payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 3 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#PaymentLimit"

    @tms:UTR-10388
    Examples:
      | locale | langCode |
      | pl     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @Przelewy24 @P2 @PaymentPage
  Scenario Outline: Przelewy24 - As a PL guest or user I can't pay with Przelewy24 if T&C are not accepted or a bank is not selected, once I accept them I can place an order
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.P24Button is clickable
      And I click on Checkout.PaymentPage.P24Button
    When I set the checkbox Checkout.PaymentPage.TermsAndConditionsCheckbox status to true
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.PaymentPage.DotpayNoBank is displayed in 3 seconds
    When I set the checkbox Checkout.PaymentPage.TermsAndConditionsCheckbox status to false
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Banki Spółdzielcze"
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed in 5 seconds
    When I set the checkbox Checkout.PaymentPage.TermsAndConditionsCheckbox status to true
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And in Przelewy24 I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10391
    Examples:
      | locale | langCode | userType |
      | pl     | default  | guest    |

    @tms:UTR-10389
    Examples:
      | locale | langCode | userType  |
      | pl     | default  | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @Przelewy24 @P2 @PaymentPage
  Scenario Outline: Przelewy24 - As PL guest I can use the back function in Przelewy24 portal
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.P24Button is clickable
      And I click on Checkout.PaymentPage.P24Button
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Banki Spółdzielcze"
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 2 seconds
    When I navigate back in the browser
      And I wait for 5 seconds
      And I wait until Checkout.PaymentPage.P24Button is clickable
    Then I see Checkout.PaymentPage.PaymentErrorMessage is not displayed in 10 seconds

    @tms:UTR-10387 @Mobile
    Examples:
      | locale | langCode | userType |
      | pl     | default  | guest    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @Przelewy24 @Negative @P3 @PaymentPage
  Scenario Outline: Przelewy24 - As a PL user I can place order with Przelewy24 and receive Pending message
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.P24Button is clickable
      And I click on Checkout.PaymentPage.P24Button
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Banki Spółdzielcze"
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And in PendingPrzelewy24 I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I see Checkout.OrderConfirmationPage.ConfirmationDetailsMessage contains text "Kolejne informacje otrzymasz w wiadomości e-mail po potwierdzeniu zamówienia."

    @tms:UTR-10394
    Examples:
      | locale | langCode | userType  |
      | pl     | default  | logged in |
