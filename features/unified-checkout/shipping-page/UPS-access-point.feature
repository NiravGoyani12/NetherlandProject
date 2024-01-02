Feature: Unified Checkout - Delivery Method - UPS Access Point

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @Payment @Creditcard @UPSAP @ShippingPage @HappyFlow
  Scenario Outline: UPS AP - As a guest/user I can complete an order with UPS Access Point as my delivery method
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait until Checkout.ShippingPage.UPSAccesPointSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.UPSAccesPointSearchField
      And I click on Checkout.ShippingPage.UPSAccesPointFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I expect 1 network request named GeocodeService.Search of type script to be processed in 10 seconds
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      | Checkout.ShippingPage.PhoneInput     | #PHONE                      |
      And I wait for 2 seconds
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
      And I add other billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-11406
    Examples:
      | locale | langCode | userType |
      | be     | default  | guest    |

    # @tms:UTR-11412
    # Examples:
    #   | locale | langCode | userType  |
    #   | be     | FR       | logged in |

    # @tms:UTR-11407 @Mobile
    # Examples:
    #   | locale | langCode | userType |
    #   | fr     | default  | guest    |

    # @tms:UTR-11413
    # Examples:
    #   | locale | langCode | userType  |
    #   | pl     | default  | logged in |

    @tms:UTR-11408 @Mobile
    Examples:
      | locale | langCode | userType |
      | de     | default  | guest    |

    @tms:UTR-11414
    Examples:
      | locale | langCode | userType  |
      | de     | EN       | logged in |

  # @tms:UTR-11409 @Mobile
  # Examples:
  #   | locale | langCode | userType |
  #   | it     | default  | guest    |

  # @tms:UTR-11415
  # Examples:
  #   | locale | langCode | userType  |
  #   | dk     | default  | logged in |

  # @tms:UTR-11410
  # Examples:
  #   | locale | langCode | userType |
  #   | fi     | default  | guest    |

  # @tms:UTR-11416
  # Examples:
  #   | locale | langCode | userType  |
  #   | se     | default  | logged in |

  # @tms:UTR-11411
  # Examples:
  #   | locale | langCode | userType |
  #   | lu     | default  | guest    |

  # @tms:UTR-11417 @Mobile
  # Examples:
  #   | locale | langCode | userType  |
  #   | lu     | DE       | logged in |

  # @tms:UTR-13345
  # Examples:
  #   | locale | langCode | userType |
  #   | at     | default  | guest    |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @Payment @UPSAP @P2
  Scenario Outline: UPS AP - As a guest/user I can select UPSAP as my delivery method then go switch to another delivery method and complete purchase
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait until Checkout.ShippingPage.UPSAccesPointSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.UPSAccesPointSearchField
      And I click on Checkout.ShippingPage.UPSAccesPointFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I expect 1 network request named GeocodeService.Search of type script to be processed in 10 seconds
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      | Checkout.ShippingPage.PhoneInput     | #PHONE                      |
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I navigate back in the browser
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.DeliveryTabButton
      And I click on Checkout.ShippingPage.StandardRadioButton
      And as a <userType> I add first delivery details
      And I wait for 2 seconds
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
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    When I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-11418
    Examples:
      | locale | langCode | userType |
      | be     | default  | guest    |

    @tms:UTR-11429 @Mobile
    Examples:
      | locale | langCode | userType  |
      | be     | FR       | logged in |

    # @tms:UTR-11419
    # Examples:
    #   | locale | langCode | userType |
    #   | fr     | default  | guest    |

    # @tms:UTR-11428
    # Examples:
    #   | locale | langCode | userType  |
    #   | pl     | default  | logged in |

    @tms:UTR-11420 @Mobile
    Examples:
      | locale | langCode | userType |
      | de     | default  | guest    |

    @tms:UTR-11427
    Examples:
      | locale | langCode | userType  |
      | de     | EN       | logged in |

  # @tms:UTR-11421
  # Examples:
  #   | locale | langCode | userType |
  #   | it     | default  | guest    |

  # @tms:UTR-11426
  # Examples:
  #   | locale | langCode | userType  |
  #   | dk     | default  | logged in |

  # @tms:UTR-11422
  # Examples:
  #   | locale | langCode | userType |
  #   | fi     | default  | guest    |

  # @tms:UTR-11425
  # Examples:
  #   | locale | langCode | userType  |
  #   | lu     | default  | logged in |

  # @tms:UTR-11423 @Mobile
  # Examples:
  #   | locale | langCode | userType |
  #   | lu     | DE       | guest    |

  # @tms:UTR-11424
  # Examples:
  #   | locale | langCode | userType  |
  #   | se     | default  | logged in |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @ShippingPage @UPSAP @P2
  Scenario Outline: UPS AP - As a guest or user I can see UPS AP delivery method, the map, drop pin, opening hours and when I select a store I see the details of the store and change store button
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait until Checkout.ShippingPage.UPSAccesPointSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.UPSAccesPointSearchField
      And I click on Checkout.ShippingPage.UPSAccesPointFindStoreButton
    Then I see the attribute value of element Checkout.ShippingPage.PUPModalSearchField containing "#POSTCODE"
      And I store the number of elements Checkout.ShippingPage.PUPSearchResults with key #StoreCount
      And the count of elements Checkout.ShippingPage.PUPMapMarker is equal to #StoreCount
      And the count of elements Checkout.ShippingPage.PUPDistanceToStore is equal to #StoreCount
    When I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPOpeningHoursLink by index 1
    Then the count of elements Checkout.ShippingPage.PUPOpeningDays is equal to 7
      And the count of elements Checkout.ShippingPage.PUPOpeningHours is equal to 7
    When I click on Checkout.ShippingPage.PUPSearchResult by index 2
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I wait for 2 seconds
    Then I see Checkout.ShippingPage.PUPChoosenStoreInfo is displayed
      And I see Checkout.ShippingPage.UPSAccessPointChangeStoreButton is displayed

    @tms:UTR-11430
    Examples:
      | locale | langCode | userType |
      | be     | default  | guest    |

    @tms:UTR-11441 @Mobile
    Examples:
      | locale | langCode | userType  |
      | be     | FR       | logged in |

    # @tms:UTR-11431
    # Examples:
    #   | locale | langCode | userType |
    #   | fr     | default  | guest    |

    # @tms:UTR-11440
    # Examples:
    #   | locale | langCode | userType  |
    #   | pl     | default  | logged in |

    @tms:UTR-11432 @Mobile
    Examples:
      | locale | langCode | userType |
      | de     | default  | guest    |

    @tms:UTR-11439
    Examples:
      | locale | langCode | userType  |
      | de     | EN       | logged in |

  # @tms:UTR-11433
  # Examples:
  #   | locale | langCode | userType |
  #   | it     | default  | guest    |

  # @tms:UTR-11438
  # Examples:
  #   | locale | langCode | userType  |
  #   | dk     | default  | logged in |

  # @tms:UTR-11434
  # Examples:
  #   | locale | langCode | userType |
  #   | fi     | default  | guest    |

  # @tms:UTR-11436
  # Examples:
  #   | locale | langCode | userType  |
  #   | lu     | default  | logged in |

  # @tms:UTR-11435
  # Examples:
  #   | locale | langCode | userType |
  #   | lu     | DE       | guest    |

  # @tms:UTR-11437
  # Examples:
  #   | locale | langCode | userType  |
  #   | se     | default  | logged in |

  @FullRegression
  @Desktop
  @Chrome @Safari @Firefox @Translation @Lokalise
  @UnifiedCheckout @DeliveryMethods @ShippingPage @UPSAP @P2
  Scenario Outline: UPS AP - As a guest or user I get an error if I leave the search field empty or enter incorrect data
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait until Checkout.ShippingPage.UPSAccesPointSearchField is displayed
    When I click on Checkout.ShippingPage.UPSAccesPointFindStoreButton
      And I get translation from lokalise for "PuPEmptySearch" and store it with key #EmptySearch
    Then I see Checkout.ShippingPage.UPSSearchFieldError contains text "#EmptySearch"

    @tms:UTR-11442
    Examples:
      | locale | langCode | userType |
      | be     | default  | guest    |

    @tms:UTR-11453 @Mobile
    Examples:
      | locale | langCode | userType  |
      | be     | FR       | logged in |

    # @tms:UTR-11443
    # Examples:
    #   | locale | langCode | userType |
    #   | fr     | default  | guest    |

    # @tms:UTR-11452
    # Examples:
    #   | locale | langCode | userType  |
    #   | pl     | default  | logged in |

    @tms:UTR-11444
    Examples:
      | locale | langCode | userType |
      | de     | default  | guest    |

    @tms:UTR-11451
    Examples:
      | locale | langCode | userType  |
      | de     | EN       | logged in |

  # @tms:UTR-11445 @Mobile
  # Examples:
  #   | locale | langCode | userType |
  #   | it     | default  | guest    |

  # @tms:UTR-11450
  # Examples:
  #   | locale | langCode | userType  |
  #   | dk     | default  | logged in |

  # @tms:UTR-11446
  # Examples:
  #   | locale | langCode | userType |
  #   | fi     | default  | guest    |

  # @tms:UTR-11449
  # Examples:
  #   | locale | langCode | userType  |
  #   | lu     | default  | logged in |

  # @tms:UTR-11447
  # Examples:
  #   | locale | langCode | userType |
  #   | lu     | DE       | guest    |

  # @tms:UTR-11448
  # Examples:
  #   | locale | langCode | userType  |
  #   | se     | default  | logged in |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @ShippingPage @UPSAP @P2
  Scenario Outline: UPS AP - As a guest or user I can select a farther pick-up point using UPS AP
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait until Checkout.ShippingPage.UPSAccesPointSearchField is displayed
    When I type "<location>" in the field Checkout.ShippingPage.UPSAccesPointSearchField
      And I click on Checkout.ShippingPage.UPSAccesPointFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 1
      And I store the number of displayed elements Checkout.ShippingPage.PUPSearchResults with key #StoreCount
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I store the numeric value of Checkout.ShippingPage.PUPDistanceToStore with index 1 with key #FirstStoreDistance
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I wait for 2 seconds
    Then I see Checkout.ShippingPage.PUPChoosenStoreInfo is displayed
    When I click on Checkout.ShippingPage.UPSAccessPointChangeStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is equal to #StoreCount
    When I click on Checkout.ShippingPage.PUPSearchResult by index 3
    Then I see the numeric value of Checkout.ShippingPage.PUPDistanceToStore with index 3 is greater than #FirstStoreDistance

    @tms:UTR-11454
    Examples:
      | locale | langCode | userType | location  |
      | be     | default  | guest    | Bruxelles |

    @tms:UTR-11470 @Mobile
    Examples:
      | locale | langCode | userType  | location |
      | be     | FR       | logged in | Gent     |

    # @tms:UTR-11455
    # Examples:
    #   | locale | langCode | userType | location |
    #   | fr     | default  | guest    | Paris    |

    # @tms:UTR-11469
    # Examples:
    #   | locale | langCode | userType  | location |
    #   | pl     | default  | logged in | Warsaw   |

    @tms:UTR-11456
    Examples:
      | locale | langCode | userType | location |
      | de     | default  | guest    | Berlin   |

    @tms:UTR-11468
    Examples:
      | locale | langCode | userType  | location |
      | de     | EN       | logged in | 10178    |

  # @tms:UTR-11457 @Mobile
  # Examples:
  #   | locale | langCode | userType | location |
  #   | it     | default  | guest    | Rome     |

  # @tms:UTR-11467
  # Examples:
  #   | locale | langCode | userType  | location   |
  #   | dk     | default  | logged in | Copenhagen |

  # @tms:UTR-11458
  # Examples:
  #   | locale | langCode | userType | location |
  #   | fi     | default  | guest    | Helsinki |

  # @tms:UTR-11465
  # Examples:
  #   | locale | langCode | userType  | location |
  #   | lu     | DE       | logged in | Mersch   |

  # @tms:UTR-11459
  # Examples:
  #   | locale | langCode | userType | location      |
  #   | lu     | default  | guest    | Lorentzweiler |

  # @tms:UTR-11464
  # Examples:
  #   | locale | langCode | userType  | location  |
  #   | se     | default  | logged in | Stockholm |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari @Translation @Lokalise
  @UnifiedCheckout @DeliveryMethods @ShippingPage @UPSAP @P2
  Scenario Outline: UPS AP - As a guest or user I get an error if I enter incorrect data in the modal window
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait until Checkout.ShippingPage.UPSAccesPointSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.UPSAccesPointSearchField
      And I click on Checkout.ShippingPage.UPSAccesPointFindStoreButton
    When I type "XX" in the empty field Checkout.ShippingPage.PUPModalPostCodeField
      And I click on Checkout.ShippingPage.PUPInStoreModalFindStoreButton
      And I get translation from lokalise for "PuPIncorrectSearch" and store it with key #IncorrectSearch
    Then I see Checkout.ShippingPage.PUPSearchModalFieldError contains text "#IncorrectSearch"

    # @tms:UTR-11473
    # Examples:
    #   | locale | langCode | userType |
    #   | be     | default  | guest    |

    # @tms:UTR-11484 @Mobile
    # Examples:
    #   | locale | langCode | userType  |
    #   | be     | FR       | logged in |

    # @tms:UTR-11474
    # Examples:
    #   | locale | langCode | userType |
    #   | fr     | default  | guest    |

    # @tms:UTR-11483 @Mobile
    # Examples:
    #   | locale | langCode | userType  |
    #   | pl     | default  | logged in |

    @tms:UTR-11475 @Mobile
    Examples:
      | locale | langCode | userType |
      | de     | default  | guest    |

    @tms:UTR-11482
    Examples:
      | locale | langCode | userType  |
      | de     | EN       | logged in |

  # @tms:UTR-11476
  # Examples:
  #   | locale | langCode | userType |
  #   | it     | default  | guest    |

  # @tms:UTR-11481
  # Examples:
  #   | locale | langCode | userType  |
  #   | dk     | default  | logged in |

  # @tms:UTR-11477
  # Examples:
  #   | locale | langCode | userType |
  #   | fi     | default  | guest    |

  # @tms:UTR-11478
  # Examples:
  #   | locale | langCode | userType |
  #   | lu     | default  | guest    |

  # @tms:UTR-11480
  # Examples:
  #   | locale | langCode | userType  |
  #   | lu     | DE       | logged in |

  # @tms:UTR-11479
  # Examples:
  #   | locale | langCode | userType  |
  #   | se     | default  | logged in |

  @FullRegression
  @Desktop
  @Chrome @Safari @Firefox @Translation @Lokalise
  @UnifiedCheckout @DeliveryMethods @ShippingPage @UPSAP @P2
  Scenario Outline: UPS AP - As a guest or user I cannot proceed to payment with UPSAP shipping method but no store selected
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait for 1 seconds
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      | Checkout.ShippingPage.PhoneInput     | #PHONE                      |
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I get translation from lokalise for "PuPNoStores" and store it with key #NoStore
    Then I see Checkout.ShippingPage.UPSSearchFieldError contains text "#NoStore"

    @tms:UTR-11485
    Examples:
      | locale | langCode | userType |
      | be     | FR       | guest    |

    @tms:UTR-11496
    Examples:
      | locale | langCode | userType  |
      | be     | default  | logged in |

    # @tms:UTR-11486 @Mobile
    # Examples:
    #   | locale | langCode | userType |
    #   | fr     | default  | guest    |

    # @tms:UTR-11495 @Mobile
    # Examples:
    #   | locale | langCode | userType  |
    #   | pl     | default  | logged in |

    @tms:UTR-11487 @Mobile
    Examples:
      | locale | langCode | userType |
      | de     | default  | guest    |

    @tms:UTR-11494
    Examples:
      | locale | langCode | userType  |
      | de     | EN       | logged in |

    # @tms:UTR-11488
    # Examples:
    #   | locale | langCode | userType |
    #   | it     | default  | guest    |

    # @tms:UTR-11493
    # Examples:
    #   | locale | langCode | userType  |
    #   | dk     | default  | logged in |

    @tms:UTR-11489
    Examples:
      | locale | langCode | userType |
      | lu     | default  | guest    |

    @tms:UTR-11492
    Examples:
      | locale | langCode | userType  |
      | lu     | DE       | logged in |

  # @tms:UTR-11490
  # Examples:
  #   | locale | langCode | userType |
  #   | fi     | default  | guest    |

  # @tms:UTR-11491
  # Examples:
  #   | locale | langCode | userType  |
  #   | se     | default  | logged in |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @ShippingPage @UPSAP @P2
  Scenario Outline: UPS AP - As a guest or user I will be redirected back to shipping page when I change the URL to payment with UPS AP shipping method but no store selected
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait for 1 seconds
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      | Checkout.ShippingPage.PhoneInput     | #PHONE                      |
      And I am on locale <locale> of url /checkout/shipping
      And I wait for 2 seconds
    Then URL should contain "/shipping"

    # @tms:UTR-11497
    # Examples:
    #   | locale | langCode | userType |
    #   | be     | default  | guest    |

    # @tms:UTR-11508
    # Examples:
    #   | locale | langCode | userType  |
    #   | be     | FR       | logged in |

    # @tms:UTR-11498 @Mobile
    # Examples:
    #   | locale | langCode | userType |
    #   | fr     | default  | guest    |

    # @tms:UTR-11507
    # Examples:
    #   | locale | langCode | userType  |
    #   | pl     | default  | logged in |

    @tms:UTR-11499 @Mobile
    Examples:
      | locale | langCode | userType |
      | de     | default  | guest    |

    @tms:UTR-11506
    Examples:
      | locale | langCode | userType  |
      | de     | EN       | logged in |

    # @tms:UTR-11500
    # Examples:
    #   | locale | langCode | userType |
    #   | it     | default  | guest    |

    # @tms:UTR-11505
    # Examples:
    #   | locale | langCode | userType  |
    #   | dk     | default  | logged in |

    @tms:UTR-11501
    Examples:
      | locale | langCode | userType |
      | lu     | default  | guest    |

    @tms:UTR-11504
    Examples:
      | locale | langCode | userType  |
      | lu     | DE       | logged in |

  # @tms:UTR-11502
  # Examples:
  #   | locale | langCode | userType |
  #   | fi     | default  | guest    |

  # @tms:UTR-11503
  # Examples:
  #   | locale | langCode | userType  |
  #   | se     | default  | logged in |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @PaymentPage @UPSAP @P2
  Scenario Outline: UPS AP - As a guest or user there is no same as shipping checkbox and billing form is displayed on payment page
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait until Checkout.ShippingPage.UPSAccesPointSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.UPSAccesPointSearchField
      And I click on Checkout.ShippingPage.UPSAccesPointFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
      And the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      | Checkout.ShippingPage.PhoneInput     | #PHONE                      |
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I add other billing details
    Then I see Checkout.PaymentPage.SameAsShippingCheckbox is not displayed

    # @tms:UTR-11509
    # Examples:
    #   | locale | langCode | userType |
    #   | be     | default  | guest    |

    # @tms:UTR-11520
    # Examples:
    #   | locale | langCode | userType  |
    #   | be     | FR       | logged in |

    # @tms:UTR-11510 @Mobile
    # Examples:
    #   | locale | langCode | userType |
    #   | fr     | default  | guest    |

    # @tms:UTR-11519
    # Examples:
    #   | locale | langCode | userType  |
    #   | pl     | default  | logged in |

    @tms:UTR-11511 @Mobile
    Examples:
      | locale | langCode | userType |
      | de     | default  | guest    |

    @tms:UTR-11518
    Examples:
      | locale | langCode | userType  |
      | de     | EN       | logged in |

    # @tms:UTR-11512
    # Examples:
    #   | locale | langCode | userType |
    #   | it     | default  | guest    |

    # @tms:UTR-11517
    # Examples:
    #   | locale | langCode | userType  |
    #   | dk     | default  | logged in |

    @tms:UTR-11513
    Examples:
      | locale | langCode | userType |
      | lu     | default  | guest    |

    @tms:UTR-11516
    Examples:
      | locale | langCode | userType  |
      | lu     | DE       | logged in |

  # @tms:UTR-11514
  # Examples:
  #   | locale | langCode | userType |
  #   | fi     | default  | guest    |

  # @tms:UTR-11515
  # Examples:
  #   | locale | langCode | userType  |
  #   | se     | default  | logged in |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @ShippingPage @UPSAP @P2
  Scenario Outline: UPS AP - As a guest or user 'Checkout with PayPal' button should not be displayed when UPS AP is selected as a delivery method
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait until Checkout.ShippingPage.UPSAccesPointSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.UPSAccesPointSearchField
      And I click on Checkout.ShippingPage.UPSAccesPointFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
      And the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I wait for 2 seconds
      And I am on locale <locale> of url /checkout/shipping-page
      And I wait for 2 seconds
    Then I see Checkout.SignInPage.PaypalExpressButton is not displayed

    # @tms:UTR-11521
    # Examples:
    #   | locale | langCode | userType |
    #   | be     | default  | guest    |

    # @tms:UTR-11533
    # Examples:
    #   | locale | langCode | userType  |
    #   | be     | FR       | logged in |

    # @tms:UTR-11523
    # Examples:
    #   | locale | langCode | userType |
    #   | fr     | default  | guest    |

    # @tms:UTR-11532 @Mobile
    # Examples:
    #   | locale | langCode | userType  |
    #   | pl     | default  | logged in |

    @tms:UTR-11524
    Examples:
      | locale | langCode | userType |
      | de     | default  | guest    |

    @tms:UTR-11531
    Examples:
      | locale | langCode | userType  |
      | de     | EN       | logged in |

    # @tms:UTR-11525
    # Examples:
    #   | locale | langCode | userType |
    #   | it     | default  | guest    |

    # @tms:UTR-11530
    # Examples:
    #   | locale | langCode | userType  |
    #   | dk     | default  | logged in |

    @tms:UTR-11526
    Examples:
      | locale | langCode | userType |
      | lu     | default  | guest    |

    @tms:UTR-11529 @Mobile
    Examples:
      | locale | langCode | userType  |
      | lu     | DE       | logged in |

  # @tms:UTR-11527
  # Examples:
  #   | locale | langCode | userType |
  #   | fi     | default  | guest    |

  # @tms:UTR-11528
  # Examples:
  #   | locale | langCode | userType  |
  #   | se     | default  | logged in |

  @FullRegression
  @Desktop
  @Chrome @Safari @Firefox @Translation @Lokalise
  @UnifiedCheckout @DeliveryMethods @ShippingPage @UPSAP @P2
  Scenario Outline: UPS AP - As guest I can verify the shipping threshold for UPS AP (Above)
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 products with value above shipping threshold on shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is displayed
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.UPSAccesPointRadioButton is clickable
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I get translation from lokalise for "FreeCosts" and store it with key #FreeShippingCosts
    Then I see Checkout.ShippingPage.UPSFreeShipping contains text "#FreeShippingCosts"

    # @tms:UTR-11534
    # Examples:
    #   | locale | langCode | userType |
    #   | be     | FR       | guest    |

    # @tms:UTR-11535
    # Examples:
    #   | locale | langCode | userType  |
    #   | be     | default  | logged in |

    @tms:UTR-11538 @Mobile
    Examples:
      | locale | langCode | userType  |
      | pl     | default  | logged in |

    # @tms:UTR-11542
    # Examples:
    #   | locale | langCode | userType  |
    #   | es     | default  | logged in |

    # @tms:UTR-11541
    # Examples:
    #   | locale | langCode | userType |
    #   | it     | default  | guest    |

    # @tms:UTR-11543
    # Examples:
    #   | locale | langCode | userType  |
    #   | dk     | default  | logged in |

    # @tms:UTR-11544 @Mobile
    # Examples:
    #   | locale | langCode | userType  |
    #   | dk     | default  | logged in |

    @tms:UTR-11547
    Examples:
      | locale | langCode | userType |
      | fi     | default  | guest    |

    # @tms:UTR-11545
    # Examples:
    #   | locale | langCode | userType  |
    #   | se     | default  | logged in |

    # @tms:UTR-11548
    # Examples:
    #   | locale | langCode | userType |
    #   | lu     | default  | guest    |

    @tms:UTR-11546
    Examples:
      | locale | langCode | userType  |
      | lu     | DE       | logged in |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @ShippingPage @UPSAP @P2
  Scenario Outline: UPS AP - As guest I can verify the shipping threshold for UPS AP (under)
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 products with value below shipping threshold on shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is displayed
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.UPSAccesPointRadioButton is clickable
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I get standard shipping costs for current locale and store it with key #shippingCosts
    Then I see Checkout.ShippingPage.UPSFreeShipping contains text "#shippingCosts"

    # @tms:UTR-11550 @ExcludeTH
    # Examples:
    #   | locale | langCode | userType |
    #   | fr     | default  | guest    |

    @tms:UTR-11562 @Mobile
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |

    # @tms:UTR-11552
    # Examples:
    #   | locale | langCode | userType |
    #   | be     | FR       | guest    |

    @tms:UTR-11561
    Examples:
      | locale | langCode | userType  |
      | pl     | default  | logged in |

    @tms:UTR-11553 @ExcludeTH
    Examples:
      | locale | langCode | userType |
      | de     | EN       | guest    |

    # @tms:UTR-11560 @Mobile
    # Examples:
    #   | locale | langCode | userType  |
    #   | es     | default  | logged in |

    # @tms:UTR-11554
    # Examples:
    #   | locale | langCode | userType |
    #   | it     | default  | guest    |

    # @tms:UTR-11559
    # Examples:
    #   | locale | langCode | userType  |
    #   | dk     | default  | logged in |

    # @tms:UTR-11555
    # Examples:
    #   | locale | langCode | userType |
    #   | lu     | default  | guest    |

    @tms:UTR-11558 @Mobile
    Examples:
      | locale | langCode | userType  |
      | lu     | DE       | logged in |

# @tms:UTR-11556
# Examples:
#   | locale | langCode | userType |
#   | fi     | default  | guest    |

# @tms:UTR-11557
# Examples:
#   | locale | langCode | userType  |
#   | se     | default  | logged in |