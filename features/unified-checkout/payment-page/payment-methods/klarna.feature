Feature: Unified Checkout - Payment Methods - Klarna pay later

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @Klarna @HappyFlow
  Scenario Outline: Klarna - As guest I can place order with Klarna pay later with express shipping
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 80 and 100 and inventory between 1 and 9999
      And I am on locale <locale> home page with forced accepted cookies
      And I am a guest user
      And I am on locale <locale> shopping bag page with 1 units for product items product1#skuPartNumber
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I store the cartId
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.ExpressRadioButton is clickable
      And I click on Checkout.ShippingPage.ExpressRadioButton
      And as a guest I add first delivery details
      And I wait for 5 seconds
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.Klarna is clickable
    When I click on Checkout.PaymentPage.Klarna
      And I wait for 1 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And in klarna I complete payment for scenario Positive
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    # @tms:UTR-10684
    # Examples:
    #   | locale | langCode |
    #   | pl     | default  |

    # @tms:UTR-10685
    # Examples:
    #   | locale | langCode |
    #   | dk     | default  |

    # @tms:UTR-10686
    # Examples:
    #   | locale | langCode |
    #   | se     | default  |

    # @tms:UTR-10687
    # Examples:
    #   | locale | langCode |
    #   | fi     | default  |

    # @tms:UTR-10688 @Mobile
    # Examples:
    #   | locale | langCode |
    #   | nl     | default  |

    @tms:UTR-10689
    Examples:
      | locale | langCode |
      | be     | default  |

    @tms:UTR-10690 @Mobile
    Examples:
      | locale | langCode |
      | be     | FR       |

  # @tms:UTR-13417
  # Examples:
  #   | locale | langCode |
  #   | at     | default  |

  # @tms:UTR-13416
  # Examples:
  #   | locale | langCode |
  #   | de     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @Klarna @PostNL @HappyFlow
  Scenario Outline: Klarna - As guest or user I can place order with Klarna with PostNL
    Given There is 1 product item with 0% discount of locale <locale> with price between 80 and 100 and inventory between 1 and 9999
      And I am on locale <locale> home page with forced accepted cookies
      And I am on locale <locale> shopping bag page with 1 units for product items product1#skuPartNumber
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I store the cartId
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
      And I am a <userType> user
      And I wait for 2 seconds
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.Klarna is clickable
      And I add other billing details
      And I click on Checkout.PaymentPage.Klarna
      And I wait for 2 seconds
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And in klarna I complete payment for scenario Positive
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-13141 @Mobile
    Examples:
      | locale | userType |
      | nl     | guest    |

  # @tms:UTR-13142
  # Examples:
  #   | locale | userType  |
  #   | nl     | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @Klarna @UPSAP @HappyFlow
  Scenario Outline: Klarna - As guest or user I can place order with Klarna with UPS
    Given There is 1 product item with 0% discount of locale <locale> and langCode default with price between 80 and 100 and inventory between 1 and 9999
      And I am on locale <locale> home page of langCode default with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> shopping bag page of langCode default with 1 units for product items product1#skuPartNumber
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I store the cartId
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
      And I wait for 3 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait for 2 seconds
      And I wait until Checkout.PaymentPage.Klarna is clickable
      And I add other billing details
      And I click on Checkout.PaymentPage.Klarna
      And I wait for 1 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And in klarna I complete payment for scenario Positive
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-13143 @P1
    Examples:
      | locale | userType | searchText |
      | be     | guest    | Antwerp    |

    # @tms:UTR-13144 @Mobile
    # Examples:
    #   | locale | userType  | searchText |
    #   | nl     | logged in | 1104 EA    |

    # @tms:UTR-13145
    # Examples:
    #   | locale | userType | searchText  |
    #   | dk     | guest    | Coppenhagen |

    @tms:UTR-13146
    Examples:
      | locale | userType  | searchText |
      | de     | logged in | 10435      |

  # @tms:UTR-13147
  # Examples:
  #   | locale | userType | searchText |
  #   | fi     | guest    | Helsinki   |

  # @tms:UTR-13148
  # Examples:
  #   | locale | userType  | searchText |
  #   | pl     | logged in | Warsaw     |

  # @tms:UTR-13419
  # Examples:
  #   | locale | userType | searchText |
  #   | at     | guest    | Vienna     |

  # @tms:UTR-13418
  # Examples:
  #   | locale | userType  | searchText |
  #   | de     | logged in | Berlin     |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @Klarna @CollectInStore @HappyFlow
  Scenario Outline: Klarna - As user I can place order with Klarna with collect in store
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 80 and 100 and inventory between 1 and 9999
      And I am on locale <locale> home page of langCode default with forced accepted cookies
      And I am a logged in user
      And I am on locale <locale> shopping bag page of langCode default with 1 units for product items product1#skuPartNumber
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I store the cartId
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
      | Checkout.ShippingPage.PhoneInput     | #PHONE                      |
      And I wait for 2 seconds
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I scroll to the element Checkout.PaymentPage.PlaceOrderButton
      And I add other billing details
      And I wait until Checkout.PaymentPage.Klarna is clickable
      And I click on Checkout.PaymentPage.Klarna
      And I wait for 1 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 10 seconds
      And in klarna I complete payment for scenario Positive
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    # @tms:UTR-10691
    # Examples:
    #   | locale | searchText | langCode |
    #   | pl     | Warsaw     | default  |

    @tms:UTR-10692 @Mobile
    Examples:
      | locale | searchText | langCode |
      | uk     | London     | default  |

    # @tms:UTR-10693 @ExcludeCK
    # Examples:
    #   | locale | searchText | langCode |
    #   | se     | 111 52     | default  |

    # @tms:UTR-10694 @ExcludeCK
    # Examples:
    #   | locale | searchText | langCode |
    #   | dk     | Copenhagen | default  |

    @tms:UTR-10695 @Mobile
    Examples:
      | locale | searchText | langCode |
      | nl     | 1104 EA    | EN       |

    @tms:UTR-10696 @ExcludeCK
    Examples:
      | locale | searchText | langCode |
      | be     | Bruxelles  | default  |

    @tms:UTR-10706
    Examples:
      | locale | searchText | langCode |
      | de     | Berlin     | EN       |

    # @tms:UTR-13420 @ExcludeCK
    # Examples:
    #   | locale | searchText | langCode |
    #   | at     | Vienna     | default  |

    @tms:UTR-13421
    Examples:
      | locale | searchText | langCode |
      | de     | Munich     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Klarna @P3 @PaymentPage
  Scenario Outline: Klarna - As guest I can't pay with Klarna when total price is more than the limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 200 and 5000 and inventory between 100 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 40 units for product items product1#skuPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And I continue as guest to shipping page
      And as a guest I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.Klarna is clickable
    When I click on Checkout.PaymentPage.Klarna
      And I wait for 1 second
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I get klarna payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 3 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#PaymentLimit"

    # @tms:UTR-10385
    # Examples:
    #   | locale | langCode |
    #   | pl     | default  |

    # @tms:UTR-10681 @Mobile
    # Examples:
    #   | locale | langCode |
    #   | nl     | default  |

    # @tms:UTR-10682
    # Examples:
    #   | locale | langCode |
    #   | be     | default  |

    @tms:UTR-10683 @Mobile
    Examples:
      | locale | langCode |
      | be     | FR       |

    # @tms:UTR-13445
    # Examples:
    #   | locale | langCode |
    #   | de     | default  |

    @tms:UTR-14832
    Examples:
      | locale | langCode |
      | de     | EN       |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Klarna @P3 @PaymentPage
  Scenario Outline: Klarna - As user I can't pay with Klarna when total price is more than the limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 200 and 5000 and inventory between 100 and 9999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I am on locale <locale> shopping bag page of langCode <langCode> with 40 units for product items product1#skuPartNumber
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And as a logged in I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I wait for 2 seconds
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.Klarna is clickable
    When I click on Checkout.PaymentPage.Klarna
      And I wait for 1 second
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I get klarna payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 3 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#PaymentLimit"

    # @tms:UTR-10384
    # Examples:
    #   | locale | langCode |
    #   | pl     | default  |

    # @tms:UTR-11075
    # Examples:
    #   | locale | langCode |
    #   | be     | default  |

    @tms:UTR-11076 @Mobile
    Examples:
      | locale | langCode |
      | be     | FR       |

    @tms:UTR-13444
    Examples:
      | locale | langCode |
      | de     | EN       |

  # @tms:UTR-13446
  # Examples:
  #   | locale | langCode |
  #   | ch     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Klarna @P3 @PaymentPage
  Scenario Outline: Klarna - As guest or user I want to check if T&C are displayed and if links work and also the text on the Pay with Klarna button
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.Klarna is clickable
      And I click on Checkout.PaymentPage.Klarna
      And I see Checkout.PaymentPage.KlarnaText is displayed
      And I see Checkout.PaymentPage.KlarnaText contains text "<payLaterDuration>"
    When I click on Checkout.PaymentPage.KlarnaPOTTandCLinks with index 1
      And I switch to 2nd browser tab
    Then URL should contain "<text1>"
      And I switch to 1st browser tab
    When I click on Checkout.PaymentPage.KlarnaPOTTandCLinks with index 2
      And I switch to 3rd browser tab
    Then URL should contain "<text2>"
      And I switch to 1st browser tab
    When I click on Checkout.PaymentPage.KlarnaPOTTandCLinks with index 3
      And I switch to 4th browser tab
    Then URL should contain "privacy"
      And I switch to 1st browser tab
    Then I scroll to the element Checkout.PaymentPage.PlaceOrderButton
      And I see Checkout.PaymentPage.PlaceOrderButton contains text "<payWithKlarnaText>"

    @tms:UTR-10381 @Mobile
    Examples:
      | locale | langCode | payLaterDuration         | payWithKlarnaText       | text1 | text2   |
      | pl     | default  | zapłać później za 30 dni | Zapłać za pomocą Klarna | user  | invoice |

    # @tms:UTR-11077 @Mobile
    # Examples:
    #   | locale | langCode | payWithKlarnaText | text1 | text2   | payLaterDuration      |
    #   | nl     | default  | Betaal met Klarna | user  | invoice | pay later in 30 dagen |

    # @tms:UTR-13447
    # Examples:
    #   | locale | langCode | payWithKlarnaText   | text1 | text2   | payLaterDuration     |
    #   | at     | default  | Mit Klarna bezahlen | user  | invoice | Bezahlen in 30 Tagen |

    @tms:UTR-13448
    Examples:
      | locale | langCode | payWithKlarnaText   | text1 | text2   | payLaterDuration     |
      | de     | default  | Mit Klarna bezahlen | user  | invoice | Bezahlen in 30 Tagen |

    # @tms:UTR-13449
    # Examples:
    #   | locale | langCode | payWithKlarnaText   | text1 | text2   | payLaterDuration     |
    #   | ch     | default  | Mit Klarna bezahlen | user  | invoice | Bezahlen in 30 Tagen |

    @tms:UTR-14833
    Examples:
      | locale | langCode | payWithKlarnaText | text1 | text2   | payLaterDuration     |
      | de     | EN       | Pay with Klarna   | user  | invoice | Pay later in 30 days |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @Klarna @PaymentPage
  Scenario Outline: Klarna - As guest or user I want to verify shipping & billing address country is the same when placing order
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.Klarna is clickable
    When I click on Checkout.PaymentPage.Klarna
      And I wait for 1 second
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 10 second
      And in klarna I complete payment for scenario Positive
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10379 @Mobile
    Examples:
      | locale | langCode | userType |
      | de     | default  | guest    |

    # @tms:UTR-13450
    # Examples:
    #   | locale | langCode | userType |
    #   | at     | default  | guest    |

    @tms:UTR-13451
    Examples:
      | locale | langCode | userType |
      | de     | EN       | guest    |

  # @tms:UTR-13452
  # Examples:
  #   | locale | langCode | userType |
  #   | ch     | default  | guest    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @issue:EED-15097
  @UnifiedCheckout @Negative @Klarna @P2 @PaymentPage
  Scenario Outline: Klarna - As guest or user if I cancel in Klarna portal I get an error in Payment Page
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I get translation from lokalise for "KlarnaCancelOrder" and store it with key #KlarnaCancelOrder
      And I wait until Checkout.PaymentPage.Klarna is clickable
    When I click on Checkout.PaymentPage.Klarna
      And I wait for 1 second
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 10 seconds
      And in klarna I cancel payment
      And I wait for 2 seconds
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#KlarnaCancelOrder"
      Then URL should contain "checkout/payment"

    # @tms:UTR-10380
    # Examples:
    #   | locale | langCode | userType |
    #   | pl     | default  | guest    |

    @tms:UTR-11078 @Mobile
    Examples:
      | locale | langCode | userType |
      | de     | default  | guest    |

    # @tms:UTR-11079
    # Examples:
    #   | locale | langCode | userType  |
    #   | be     | default  | logged in |

    # @tms:UTR-11080 @Mobile
    # Examples:
    #   | locale | langCode | userType  |
    #   | be     | FR       | logged in |

    # @tms:UTR-13453
    # Examples:
    #   | locale | langCode | userType |
    #   | at     | default  | guest    |

    @tms:UTR-13454
    Examples:
      | locale | langCode | userType |
      | de     | EN       | guest    |

  # @tms:UTR-13455
  # Examples:
  #   | locale | langCode | userType |
  #   | ch     | default  | guest    |

  # @tms:UTR-14834
  # Examples:
  #   | locale | langCode | userType |
  #   | de     | EN       | guest    |

  #TODO: Check why this throws error in automated runs
  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Negative @Klarna @P3 @PaymentPage @issue:EED-15069
  Scenario Outline: Klarna - As guest I can use the back function in Klarna portal, and I am redirected to payment page
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.Klarna
      And I wait for 1 second
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
    When I navigate back in the browser
      And I wait for 1 seconds
      And I see Checkout.PaymentPage.Klarna is clickable
    Then I see Checkout.PaymentPage.PaymentErrorMessage is not displayed

    # @tms:UTR-10383
    # Examples:
    #   | locale | langCode |
    #   | pl     | default  |

    # @tms:UTR-13263 @Mobile
    # Examples:
    #   | locale | langCode |
    #   | nl     | default  |

    # @tms:UTR-13456
    # Examples:
    #   | locale | langCode |
    #   | at     | default  |

    @tms:UTR-13457
    Examples:
      | locale | langCode |
      | de     | EN       |

  # @tms:UTR-13458
  # Examples:
  #   | locale | langCode |
  #   | ch     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Negative @Klarna @P2 @PaymentPage
  Scenario Outline: Klarna - As guest or user I can't pay with Klarna if the information is wrong
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.Klarna
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And in klarna I complete payment for scenario Negative

    # @tms:UTR-10382
    # Examples:
    #   | locale | langCode |
    #   | pl     | default  |

    # @tms:UTR-11081 @Mobile
    # Examples:
    #   | locale | langCode |
    #   | nl     | default  |

    # @tms:UTR-13459
    # Examples:
    #   | locale | langCode |
    #   | at     | default  |

    @tms:UTR-13460 
    Examples:
      | locale | langCode |
      | de     | EN       |

  # @tms:UTR-13461
  # Examples:
  #   | locale | langCode |
  #   | ch     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Klarna @P2 @PaymentPage
  Scenario Outline: Klarna - As guest or user once Klarna is selected as a payment method, then the customer cannot change the country of the billing address
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 150 and 9999 and inventory between 1 and 9999
      And I am on locale <locale> home page of langCode default with forced accepted cookies
      And I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product items product1#skuPartNumber
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And I continue as <userType> to shipping page
      And as a <userType> I add <which> delivery details
      And I wait for 2 seconds
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I set the checkbox Checkout.PaymentPage.SameAsShippingCheckbox status to false
      And I scroll to the element Checkout.PaymentPage.SameAsShippingCheckbox
    When in dropdown Checkout.PaymentPage.BillingAddressCountryDropdown I select the option by text "<DifferentCountry>"
      And I wait for 1 second
      And I click on Checkout.PaymentPage.Klarna
      And I wait for 1 second
    Then I see Checkout.PaymentPage.BillingCountry with text "<Country>" is displayed
      And I click on Checkout.PaymentPage.CreditCardButton
    Then I see Checkout.PaymentPage.BillingCountry with text "<DifferentCountry>" is displayed

    @tms:UTR-10386
    Examples:
      | locale | langCode | userType | which | Country        | DifferentCountry |
      | uk     | default  | guest    | first | United Kingdom | Portugal         |

    @tms:UTR-14835
    Examples:
      | locale | langCode | userType  | which | Country | DifferentCountry |
      | de     | EN       | logged in | other | Germany | Spain            |

  #@FullRegression
  #Min limit for Klarna pay later has been reduced to 1 currency from Klarna side
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Klarna @P2 @PaymentPage
  Scenario Outline: Klarna - As guest or user I can't pay with Klarna when total price is less than the limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 1 and <limit> and inventory between 1 and 9999
      And I am <userType> on locale <locale> of langCode <langCode> for product items product1#skuPartNumber on delivery page
      And I wait until page Checkout.DeliveryPage is loaded
      And as a <userType> I add first delivery details
      And I click on Checkout.DeliveryPage.ContinueToPaymentButton
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until page Checkout.PaymentPage is loaded
    When I click on Checkout.PaymentPage.KlarnaButton
      And I wait for 1 second
      And I set the checkbox Checkout.PaymentPage.KlarnaConfirmCheckbox status to true if exist
      And I click on Checkout.PaymentPage.PayWithKlarna
      And I wait for 1 second
      And I get minklarna payment limit for current locale and store it with key #MinLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 3 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#MinLimit"

    @tms:EED-9878
    Examples:
      | locale | langCode | userType | limit |
      | pl     | default  | guest    | 110   |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @PaymentPage @Klarna @DHL @Payment @HappyFlow
  Scenario Outline: Klarna - As guest I can complete an order with DHL pack station as my delivery method and pay with Klarna
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I wait until Checkout.ShippingPage.PickupTabButton is clickable
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
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I smoothly scroll to the element Checkout.PaymentPage.Klarna
      And I wait until Checkout.PaymentPage.Klarna is clickable
      And I click on Checkout.PaymentPage.Klarna
      And I add other billing details
      And I wait for 1 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 10 seconds
      And in klarna I complete payment for scenario Positive
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-13422 @Mobile
    Examples:
      | locale | langCode | userType |
      | de     | EN       | guest    |

  # @tms:UTR-14836
  # Examples:
  #   | locale | langCode | userType |
  #   | de     | EN       | guest    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @klarna @HappyFlow
  Scenario Outline: Klarna - As user I can complete payment using northern ireland postcode
    Given I am guest on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      | Checkout.ShippingPage.Address1Input  | test address                |
      | Checkout.ShippingPage.CityInput      | Liverpool                   |
      | Checkout.ShippingPage.PostcodeInput  | BT1 1BG                     |
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.Klarna is clickable
      And I click on Checkout.PaymentPage.Klarna
      And I wait for 1 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And in klarna I complete payment for scenario Positive
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-14933
    Examples:
      | locale | langCode |
      | uk     | default  |