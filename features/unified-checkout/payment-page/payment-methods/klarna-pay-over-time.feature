Feature: Unified Checkout - Payment Methods - Klarna pay over time

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @KlarnaInstalments @HappyFlow
  Scenario Outline: Klarna Pay Overtime - As guest I can place order with Klarna pay in instalments with express shipping
    Given There is 1 product item with 0% discount of locale <locale> with price between 80 and 100 and inventory between 1 and 9999
      And I am on locale <locale> home page with forced accepted cookies
      And I am on locale <locale> shopping bag page with 1 units for product items product1#skuPartNumber
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I store the cartId
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.ExpressRadioButton is clickable
      And I click on Checkout.ShippingPage.ExpressRadioButton
      And I wait for 2 seconds
      And as a guest I add first delivery details
      And I wait for 3 seconds
      And I wait until Checkout.ShippingPage.ProceedToPayment is clickable
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is clickable
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I set the checkbox Checkout.PaymentPage.TermsAndConditionsCheckbox status to true
      And I wait for 1 seconds
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And in klarna I complete payment for scenario Instalments
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-11089
    Examples:
      | locale |
      | pt     |

    @tms:UTR-11090 @Mobile
    Examples:
      | locale |
      | it     |

  # @tms:UTR-11091 @ExcludeTH  // Express is not enabled on ro locale
  # Examples:
  #   | locale |
  #   | ro     |

  # @tms:UTR-11092
  # Examples:
  #   | locale |
  #   | fr     |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @KlarnaInstalments @HappyFlow
  Scenario Outline: Klarna Pay Overtime - As guest I can place order with Klarna pay in instalments with express shipping on nl locale
    Given There is 1 product item with 0% discount of locale <locale> with price between 80 and 100 and inventory between 1 and 9999
      And I am on locale <locale> home page with forced accepted cookies
      And I am on locale <locale> shopping bag page with 1 units for product items product1#skuPartNumber
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I store the cartId
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.ExpressRadioButton is clickable
      And I click on Checkout.ShippingPage.ExpressRadioButton
      And I wait for 2 seconds
      And as a guest I add first delivery details
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is clickable
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 1 seconds
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And in klarna I complete payment for scenario Instalments
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-11093 @Mobile
    Examples:
      | locale |
      | nl     |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @KlarnaInstalments @HappyFlow
  Scenario Outline: Klarna Pay Overtime - As guest I can place order with Klarna pay in instalments with collect in store
    Given There is 1 product item with 0% discount of locale <locale> with price between 80 and 100 and inventory between 1 and 9999
      And I am on locale <locale> home page with forced accepted cookies
      And I am on locale <locale> shopping bag page with 1 units for product items product1#skuPartNumber
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I store the cartId
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.PickupTabButton is clickable
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I wait until Checkout.ShippingPage.CollectInStoreSearchField is displayed
    When I type "<searchText>" in the field Checkout.ShippingPage.CollectInStoreSearchField
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
      And I wait until Checkout.ShippingPage.ProceedToPayment is enabled
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is clickable
      And I add other billing details
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 1 seconds
      And I set the checkbox Checkout.PaymentPage.TermsAndConditionsCheckbox status to true
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 10 seconds
      And in klarna I complete payment for scenario Instalments
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-13133 @Mobile
    Examples:
      | locale | searchText |
      | uk     | London     |

  # @tms:UTR-11094 @ExcludeCK
  # Examples:
  #   | locale | searchText |
  #   | ie     | Dublin     |

  # @tms:UTR-11096
  # Examples:
  #   | locale | searchText |
  #   | fr     | 75004      |

  # @tms:UTR-11095 @ExcludeTH
  # Examples:
  #   | locale | searchText |
  #   | it     | Rome       |

  # @FullRegression // since CIS has been disabled on nl locale
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @KlarnaInstalments @HappyFlow
  Scenario Outline: Klarna Pay Overtime - As guest I can place order with Klarna pay in instalments with collect in store
    Given There is 1 product item with 0% discount of locale <locale> with price between 80 and 100 and inventory between 1 and 9999
      And I am on locale <locale> home page with forced accepted cookies
      And I am on locale <locale> shopping bag page with 1 units for product items product1#skuPartNumber
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I store the cartId
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.PickupTabButton is clickable
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I wait until Checkout.ShippingPage.CollectInStoreSearchField is displayed
    When I type "<searchText>" in the field Checkout.ShippingPage.CollectInStoreSearchField
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
      And I wait until Checkout.ShippingPage.ProceedToPayment is enabled
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is clickable
      And I add other billing details
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 1 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 10 seconds
      And in klarna I complete payment for scenario Instalments
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-11097 @Mobile
    Examples:
      | locale | searchText |
      | nl     | 1104 EA    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @KlarnaInstalments @PostNL @HappyFlow
  Scenario Outline: Klarna Pay Overtime - As guest or user I can place order with Klarna pay in instalments with PostNL
    Given There is 1 product item with 0% discount of locale <locale> with price between 80 and 100 and inventory between 1 and 9999
      And I am on locale <locale> home page with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> shopping bag page with 1 units for product items product1#skuPartNumber
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I store the cartId
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.PickupTabButton is clickable
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
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      | Checkout.ShippingPage.PhoneInput     | #PHONE                      |
      And I wait until Checkout.ShippingPage.ProceedToPayment is enabled
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is clickable
      And I add other billing details
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 1 seconds
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And in klarna I complete payment for scenario Instalments
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-13134
    Examples:
      | locale | userType |
      | nl     | guest    |

    @tms:UTR-13135 @Mobile
    Examples:
      | locale | userType  |
      | nl     | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @KlarnaInstalments @UPSAP @HappyFlow
  Scenario Outline: Klarna Pay Overtime - As guest or user I can place order with Klarna pay in instalments with UPS
    Given There is 1 product item with 0% discount of locale <locale> with price between 80 and 100 and inventory between 1 and 9999
      And I am on locale <locale> home page with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> shopping bag page with 1 units for product items product1#skuPartNumber
      And I wait until the count of elements Experience.ShoppingBag.Item is equal to 1
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I store the cartId
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.PickupTabButton is clickable
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait until Checkout.ShippingPage.UPSAccesPointSearchField is displayed
    When I type "<searchText>" in the field Checkout.ShippingPage.UPSAccesPointSearchField
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
      And I wait until Checkout.ShippingPage.ProceedToPayment is enabled
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is clickable
      And I add other billing details
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 1 seconds
      And I set the checkbox Checkout.PaymentPage.TermsAndConditionsCheckbox status to true
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And in klarna I complete payment for scenario Instalments
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    # @tms:UTR-13136
    # Examples:
    #   | locale | searchText | userType |
    #   | es     | Madrid     | guest    |

    @tms:UTR-13138 @Mobile
    Examples:
      | locale | searchText | userType |
      | fr     | Paris      | guest    |

  # @tms:UTR-13139
  # Examples:
  #   | locale | searchText | userType |
  #   | it     | Rome       | guest    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @KlarnaInstalments @UPSAP @HappyFlow
  Scenario Outline: Klarna Pay Overtime - As guest or user I can place order with Klarna pay in instalments with UPS on nl locale
    Given There is 1 product item with 0% discount of locale <locale> with price between 80 and 100 and inventory between 1 and 9999
      And I am on locale <locale> home page with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> shopping bag page with 1 units for product items product1#skuPartNumber
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I store the cartId
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.PickupTabButton is clickable
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait until Checkout.ShippingPage.UPSAccesPointSearchField is displayed
    When I type "<searchText>" in the field Checkout.ShippingPage.UPSAccesPointSearchField
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
      And I wait until Checkout.ShippingPage.ProceedToPayment is enabled
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is clickable
      And I add other billing details
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 1 seconds
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And in klarna I complete payment for scenario Instalments
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-13140
    Examples:
      | locale | searchText | userType  |
      | nl     | 1104 EA    | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @KlarnaInstalments @P3 @PaymentPage
  Scenario Outline: Klarna Pay Overtime - As guest I can't pay with Klarna pay in instalments when total price is more than the limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between <min> and <max> and inventory between 100 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with <units> units for product items product1#skuPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And as a guest I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 1 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I get klarnaInst payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 3 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#PaymentLimit"

    @tms:UTR-10370 @Mobile
    Examples:
      | locale | langCode | min | max | units |
      | ie     | default  | 80  | 500 | 25    |

    @tms:UTR-xxxx
    Examples:
      | locale | langCode | min | max | units |
      | pt     | default  | 50  | 70  | 22    |

    @tms:UTR-xxxx @ExcludeTH
    Examples:
      | locale | langCode | min | max | units |
      | ro     | default  | 50  | 200 | 1     |

    @tms:UTR-xxxx
    Examples:
      | locale | langCode | min | max | units |
      | cz     | default  | 300 | 500 | 65    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @KlarnaInstalments @P3 @PaymentPage
  Scenario Outline: Klarna Pay Overtime - As user I can't pay with Klarna pay in instalments when total price is more than the limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 200 and 5000 and inventory between 100 and 9999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I am on locale <locale> shopping bag page of langCode <langCode> with 40 units for product items product1#skuPartNumber
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And as a logged in I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait for 2 seconds
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 2 second
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I get klarnaInst payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 3 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#PaymentLimit"

    # @tms:UTR-10375
    # Examples:
    #   | locale | langCode |
    #   | ie     | default  |

    @tms:UTR-11083 @Mobile
    Examples:
      | locale | langCode |
      | nl     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @KlarnaInstalments @P2 @PaymentPage
  Scenario Outline: Klarna Pay Overtime - As guest I can't pay with Klarna pay in instalments when total price is less than the limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode default with price between <min> and <max> and inventory between 1 and 9999
      And I am on locale <locale> home page of langCode default with forced accepted cookies
      And I am on locale <locale> shopping bag page of langCode default with 1 units for product items product1#skuPartNumber
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And I continue as guest to shipping page
      And as a guest I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 1 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I get minklarna payment limit for current locale and store it with key #MinLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 3 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#MinLimit"

    @tms:UTR-10372
    Examples:
      | locale | min | max |
      | ie     | 1   | 30  |

    @tms:UTR-xxxx
    Examples:
      | locale | min | max |
      | pt     | 1   | 30  |

    @tms:UTR-xxxx @ExcludeTH
    Examples:
      | locale | min | max |
      | ro     | 20  | 30  |

    @tms:UTR-xxxx
    Examples:
      | locale | min | max |
      | cz     | 500 | 650 |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @KlarnaInstalments @P2 @PaymentPage
  Scenario Outline: Klarna Pay Overtime - As user I can't pay with Klarna pay in instalments when total price is less than the limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 1 and 30 and inventory between 1 and 9999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product items product1#skuPartNumber
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And as a logged in I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 1 seconds
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I get minklarna payment limit for current locale and store it with key #MinLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 3 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#MinLimit"

    # @tms:UTR-10378
    # Examples:
    #   | locale | langCode |
    #   | ie     | default  |

    @tms:UTR-11084 @Mobile
    Examples:
      | locale | langCode |
      | nl     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @Negative @KlarnaInstalments @P2 @PaymentPage
  Scenario Outline: Klarna Pay Overtime - As guest or user if I click the back button in Klarna pay in instalments portal, I get an error
    Given There is 1 product item with 0% discount of locale <locale> and langCode default with price between 150 and 560 and inventory between 1 and 9999
      And I am on locale <locale> home page of langCode default with forced accepted cookies
      And I am on locale <locale> shopping bag page of langCode default with 1 units for product items product1#skuPartNumber
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And I continue as <userType> to shipping page
      And as a <userType> I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 1 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And in klarna I cancel payment
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#KlarnaCancelOrder"

    @tms:UTR-10377 @Mobile
    Examples:
      | locale | userType |
      | ie     | guest    |

  # @tms:UTR-11085
  # Examples:
  #   | locale | userType  |
  #   | nl     | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Negative @KlarnaInstalments @P2 @PaymentPage
  Scenario Outline: Klarna Pay Overtime - As guest or user I can use the back function in Klarna pay in instalments portal, and I am redirected to payment page
    Given There is 1 product item with 0% discount of locale <locale> and langCode default with price between 150 and 560 and inventory between 1 and 9999
      And I am on locale <locale> home page of langCode default with forced accepted cookies
      And I am on locale <locale> shopping bag page of langCode default with 1 units for product items product1#skuPartNumber
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And I wait for 2 seconds
      And I continue as <userType> to shipping page
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is displayed
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 2 seconds
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
    When I navigate back in the browser
    Then I see Checkout.PaymentPage.PaymentErrorMessage is not displayed in 5 seconds
      And I see Checkout.PaymentPage.KlarnaPayInstallments is clickable

    # @tms:UTR-10376
    # Examples:
    #   | locale | userType  |
    #   | ie     | guest     |

    @tms:UTR-11086 @Mobile
    Examples:
      | locale | userType  |
      | nl     | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Negative @KlarnaInstalments @P2 @PaymentPage
  Scenario Outline: Klarna Pay Overtime - As guest verify refused message is displayed for Klarna if provided information is incorrect
    Given There is 1 product item with 0% discount of locale <locale> and langCode default with price between 150 and 560 and inventory between 1 and 9999
      And I am on locale <locale> home page of langCode default with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> shopping bag page of langCode default with 1 units for product items product1#skuPartNumber
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And  I wait for 2 seconds
      And I continue as <userType> to shipping page
      And as a <userType> I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 2 seconds
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And in klarna I complete payment for scenario NoInstalments

    @tms:UTR-10371 @Mobile
    Examples:
      | locale | userType |
      | nl     | guest    |

  # @tms:UTR-11087
  # Examples:
  #   | locale | userType |
  #   | ie     | guest    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @KlarnaInstalments @PaymentPage @P3
  Scenario Outline: Klarna Pay Overtime - As guest or user I want to check if T&C are displayed and if links work and also the text on the Pay with Klarna button
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 150 and 560 and inventory between 1 and 9999
      And I am on locale <locale> home page of langCode default with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> shopping bag page of langCode default with 1 units for product items product1#skuPartNumber
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And I continue as <userType> to shipping page
      And as a <userType> I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I see Checkout.PaymentPage.KlarnaTextTC is displayed
      And I see Checkout.PaymentPage.KlarnaTextTC contains text "<payOverTimeText>"
    When I click on Checkout.PaymentPage.<Klarna option> with index 1
      And I switch to 2nd browser tab
    Then URL should contain "<text1>"
      And I switch to 1st browser tab
    When I click on Checkout.PaymentPage.<Klarna option> with index 2
      And I switch to 3rd browser tab
    Then URL should contain "<text2>"
      And I switch to 1st browser tab
    When I click on Checkout.PaymentPage.<Klarna option> with index 3
      And I switch to 4th browser tab
    Then URL should contain "privacy"
      And I switch to 1st browser tab
    Then I scroll to the element Checkout.PaymentPage.PlaceOrderButton
      And I see Checkout.PaymentPage.PlaceOrderButton contains text "<payWithKlarnaText>"

    # @tms:UTR-10374
    # Examples:
    #   | locale | langCode | userType | Klarna option               | payWithKlarnaText | text1    | text2       | payOverTimeText                                   |
    #   | ie     | default  | guest    | KlarnaPayOverTimeTandCLinks | Pay with Klarna   | checkout | paylaterin3 | Split your purchase into 3 interest free payments |

    @tms:UTR-11088 @Mobile
    Examples:
      | locale | langCode | userType | Klarna option               | payWithKlarnaText | text1 | text2       | payOverTimeText                               |
      | nl     | default  | guest    | KlarnaPayOverTimeTandCLinks | Betaal met Klarna | user  | paylaterin3 | verdeel je aankoop in 3 rentevrije betalingen |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @KlarnaInstalments @P2 @PaymentPage
  Scenario Outline: Klarna Pay Overtime - As guest or user once Klarna is selected as a payment method, then the customer cannot change the country of the billing address
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 150 and 560 and inventory between 1 and 9999
      And I am on locale <locale> home page of langCode default with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> shopping bag page of langCode default with 1 units for product items product1#skuPartNumber
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And I continue as <userType> to shipping page
      And as a <userType> I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I set the checkbox Checkout.PaymentPage.SameAsShippingCheckbox status to false
      And I set the checkbox Checkout.PaymentPage.TermsAndConditionsCheckbox status to true
      And I scroll to the element Checkout.PaymentPage.SameAsShippingCheckbox
    When in dropdown Checkout.PaymentPage.BillingAddressCountryDropdown I select the option by text "<DifferentCountry>"
      And I wait for 1 second
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait for 1 second
    Then I see Checkout.PaymentPage.BillingCountry with text "<Country>" is displayed
      And I click on Checkout.PaymentPage.CreditCardButton
    Then I see Checkout.PaymentPage.BillingCountry with text "<DifferentCountry>" is displayed

    @tms:UTR-10373
    Examples:
      | locale | langCode | userType | Country | DifferentCountry |
      | ie     | default  | guest    | Ireland | Belgium          |

    @tms:UTR-xxxx
    Examples:
      | locale | langCode | userType | Country | DifferentCountry |
      | pt     | default  | guest    | Poland  | Belgium          |

    @tms:UTR-xxxx @ExcludeTH
    Examples:
      | locale | langCode | userType | Country | DifferentCountry |
      | ro     | default  | guest    | Romania | Belgium          |

    @tms:UTR-xxxx
    Examples:
      | locale | langCode | userType | Country        | DifferentCountry |
      | cz     | default  | guest    | Czech republic | Belgium          |