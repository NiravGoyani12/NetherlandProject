Feature: Unified Checkout - Delivery Method - Collect in store

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @CreditCard @CollectInStore @DeliveryMethods @Payment @HappyFlow
  Scenario Outline: Collect in store - As a guest/user I can complete an order with collect in store as my delivery method
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I wait until Checkout.ShippingPage.CollectInStoreSearchField is displayed
    When I type "<searchText>" in the field Checkout.ShippingPage.CollectInStoreSearchField
      And I click on Checkout.ShippingPage.CollectInStoreFindStoreButton
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

    @tms:UTR-11330 @ExcludeCK
    Examples:
      | locale | langCode | userType | searchText |
      | be     | default  | guest    | Gent       |

    @tms:UTR-11331 @Mobile
    Examples:
      | locale | langCode | userType | searchText |
      | de     | default  | guest    | Berlin     |

    @tms:UTR-11333
    Examples:
      | locale | langCode | userType  | searchText |
      | de     | EN       | logged in | 65326      |

    # @tms:UTR-11332
    # Examples:
    #   | locale | langCode | userType | searchText |
    #   | pl     | default  | guest    | Warsaw     |

    # @tms:UTR-11334 @ExcludeCK
    # Examples:
    #   | locale | langCode | userType  | searchText |
    #   | ie     | default  | logged in | Dublin     |

    @tms:UTR-11335 @Mobile
    Examples:
      | locale | langCode | userType  | searchText |
      | uk     | default  | logged in | M178BL     |

  # @tms:UTR-13344
  # Examples:
  #   | locale | langCode | userType | searchText |
  #   | at     | default  | guest    | Vienna     |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @CreditCard @CollectInStore @DeliveryMethods @Payment @P2
  Scenario Outline: Collect in store - As a guest/user I can select collect in store as my delivery method then go switch to another delivery method and complete purchase
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I wait until Checkout.ShippingPage.CollectInStoreSearchField is displayed
    When I type "<searchText>" in the field Checkout.ShippingPage.CollectInStoreSearchField
      And I click on Checkout.ShippingPage.CollectInStoreFindStoreButton
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
    Then I see Order Confirmation Page with my delivery details

    @tms:UTR-11336 @ExcludeCK
    Examples:
      | locale | langCode | userType | searchText |
      | be     | default  | guest    | 8500       |

    @tms:UTR-11339 @Mobile @ExcludeCK
    Examples:
      | locale | langCode | userType  | searchText |
      | be     | FR       | logged in | Gent       |

    @tms:UTR-11340 @Mobile
    Examples:
      | locale | langCode | userType  | searchText |
      | de     | EN       | logged in | Berlin     |

    # @tms:UTR-11337
    # Examples:
    #   | locale | langCode | userType | searchText |
    #   | uk     | default  | guest    | London     |

    @tms:UTR-11341
    Examples:
      | locale | langCode | userType  | searchText |
      | pl     | default  | logged in | 40-101     |

  # @tms:UTR-11338 @ExcludeCK
  # Examples:
  #   | locale | langCode | userType | searchText |
  #   | ie     | default  | guest    | Dublin     |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari @Translation @Lokalise
  @UnifiedCheckout @DeliveryMethods @CollectInStore @ShippingPage @P2
  Scenario Outline: Collect in store - As a guest or user I can see collect in store delivery method, the map, drop pin, opening hours and when I select a store I see the details of the store and change store button
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I wait until Checkout.ShippingPage.CollectInStoreSearchField is displayed
    When I get translation from lokalise for "FreeCosts" and store it with key #deliveryCosts
    Then I see Checkout.ShippingPage.CollectInStoreRadioButtonText contains text "#deliveryCosts"
    When I type "<zipCode>" in the field Checkout.ShippingPage.CollectInStoreSearchField
      And I click on Checkout.ShippingPage.CollectInStoreFindStoreButton
    Then I see the attribute value of element Checkout.ShippingPage.PUPModalSearchField containing "<zipCode>"
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
      And I see Checkout.ShippingPage.CiSChangeStoreButton is displayed

    # @tms:UTR-11342 @ExcludeCK
    # Examples:
    #   | locale | langCode | userType | zipCode |
    #   | be     | default  | guest    | Gent    |

    @tms:UTR-11345
    Examples:
      | locale | langCode | userType  | zipCode |
      | de     | EN       | logged in | Berlin  |

    @tms:UTR-11343 @Mobile
    Examples:
      | locale | langCode | userType | zipCode |
      | de     | default  | guest    | 10117   |

    # @tms:UTR-11346 @ExcludeCK
    # Examples:
    #   | locale | langCode | userType  | deliveryCost | zipCode |
    #   | ie     | default  | logged in | Free         | Dublin  |

    # @tms:UTR-11344
    # Examples:
    #   | locale | langCode | userType | deliveryCost | zipCode |
    #   | uk     | default  | guest    | Free         | London  |

    @tms:UTR-11347 @Mobile @ExcludeCK
    Examples:
      | locale | langCode | userType  | zipCode |
      | pl     | default  | logged in | Warsaw  |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @CollectInStore @ShippingPage @P2
  Scenario Outline: Collect in store - As a guest or user I get an error if I leave the search field empty or enter incorrect data
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I wait until Checkout.ShippingPage.CollectInStoreSearchField is displayed
    When I type "<zipCode>" in the field Checkout.ShippingPage.CollectInStoreSearchField
      And I click on Checkout.ShippingPage.CollectInStoreFindStoreButton
    Then I see Checkout.ShippingPage.CollectInstoreSearchFieldError contains text "<error>"

    # @tms:UTR-11348
    # Examples:
    #   | locale | userType | langCode | zipCode | error                                                |
    #   | pl     | guest    | default  |         | Ups! To nie jest prawidłowy kod pocztowy lub miasto. |

    @tms:UTR-11349 @Mobile
    Examples:
      | locale | userType | langCode | zipCode | error                                                             |
      | de     | guest    | default  |         | Oops! Dies ist keine gültige Postleitzahl oder kein gültiger Ort. |

    @tms:UTR-11357 @ExcludeCK
    Examples:
      | locale | userType  | langCode | zipCode | error                                     |
      | de     | logged in | EN       | W!@     | Oops this isn't a valid postcode or place |

    # @tms:UTR-11350
    # Examples:
    #   | locale | userType | langCode | zipCode | error                                     |
    #   | uk     | guest    | default  | W!@     | Oops this isn't a valid postcode or place |

    # @tms:UTR-11351 @ExcludeCK @Mobile
    # Examples:
    #   | locale | userType | langCode | zipCode | error                                        |
    #   | be     | guest    | default  |         | Oeps! Dat is geen geldige postcode of plaats |

    # @tms:UTR-11355 @ExcludeCK
    # Examples:
    #   | locale | userType  | langCode | zipCode | error                                   |
    #   | be     | logged in | default  | W!@     | Oeps, deze postcode of stad is ongeldig |

    @tms:UTR-11354 @ExcludeCK
    Examples:
      | locale | userType  | langCode | zipCode | error                                          |
      | be     | logged in | FR       |         | oups ! le code postal ou la ville est invalide |

    @tms:UTR-11353 @ExcludeCK
    Examples:
      | locale | userType | langCode | zipCode | error                                                 |
      | be     | guest    | FR       | W!@     | Oups ! Ce code postal ou cette ville n'est pas valide |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @CollectInStore @ShippingPage @P2
  Scenario Outline: Collect in store - As a guest or user I can select a farther pick-up point using Collect in Store
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I wait until Checkout.ShippingPage.CollectInStoreSearchField is displayed
    When I type "<zipCode>" in the field Checkout.ShippingPage.CollectInStoreSearchField
      And I click on Checkout.ShippingPage.CollectInStoreFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 1
      And I store the number of displayed elements Checkout.ShippingPage.PUPSearchResults with key #StoreCount
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I store the numeric value of Checkout.ShippingPage.PUPDistanceToStore with index 1 with key #FirstStoreDistance
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I wait for 2 seconds
    Then I see Checkout.ShippingPage.PUPChoosenStoreInfo is displayed
    When I click on Checkout.ShippingPage.CiSChangeStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is equal to #StoreCount
    When I click on Checkout.ShippingPage.PUPSearchResult by index 3
    Then I see the numeric value of Checkout.ShippingPage.PUPDistanceToStore with index 3 is greater than #FirstStoreDistance

    @tms:UTR-11359 @Mobile
    Examples:
      | locale | langCode | userType  | zipCode |
      | de     | EN       | logged in | 10719   |

    @tms:UTR-11360
    Examples:
      | locale | langCode | userType | zipCode |
      | de     | default  | guest    | Berlin  |

    @tms:UTR-11361 @ExcludeCK
    Examples:
      | locale | langCode | userType | zipCode |
      | be     | default  | guest    | 8400    |

    @tms:UTR-11362 @ExcludeCK @Mobile
    Examples:
      | locale | langCode | userType  | zipCode |
      | be     | FR       | logged in | 8400    |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @CollectInStore @Negative @ShippingPage @P2
  Scenario Outline: Collect in store - As a guest or user I get an error if I enter incorrect data in the modal window
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I wait until Checkout.ShippingPage.CollectInStoreSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.CollectInStoreSearchField
      And I click on Checkout.ShippingPage.CollectInStoreFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalPostCodeField is displayed
    When I type "W!@" in the empty field Checkout.ShippingPage.PUPModalPostCodeField
      And I click on Checkout.ShippingPage.PUPInStoreModalFindStoreButton
    Then I see Checkout.ShippingPage.PUPSearchModalFieldError contains text "<error>"

    # @tms:UTR-11370 @ExcludeCK
    # Examples:
    #   | locale | userType  | langCode | error                                     |
    #   | ie     | logged in | default  | Oops this isn't a valid postcode or place |

    @tms:UTR-11365
    Examples:
      | locale | userType | langCode | error                                               |
      | de     | guest    | default  | Ups, die Postleitzahl oder der Ort ist nicht gültig |

    @tms:UTR-11366 @Mobile
    Examples:
      | locale | userType  | langCode | error                                     |
      | de     | logged in | EN       | Oops this isn't a valid postcode or place |

    @tms:UTR-11372 @ExcludeCK
    Examples:
      | locale | userType  | langCode | error                                   |
      | be     | logged in | default  | Oeps, deze postcode of stad is ongeldig |

    @tms:UTR-11368 @ExcludeCK @Mobile
    Examples:
      | locale | userType | langCode | error                                                 |
      | be     | guest    | FR       | Oups ! Ce code postal ou cette ville n'est pas valide |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @CollectInStore @Negative @ShippingPage @P2
  Scenario Outline:  Collect in store - As a guest or user I get an error if I leave the search field in the modal empty
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I wait until Checkout.ShippingPage.CollectInStoreSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.CollectInStoreSearchField
      And I click on Checkout.ShippingPage.CollectInStoreFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalPostCodeField is displayed
    When I clear text field of element Checkout.ShippingPage.PUPModalPostCodeField
      And I click on Checkout.ShippingPage.PUPInStoreModalFindStoreButton
    Then I see Checkout.ShippingPage.PUPSearchModalFieldError contains text "<error>"

    @tms:UTR-11364
    Examples:
      | locale | userType | langCode | zipCode | error                                                             |
      | de     | guest    | default  |         | Oops! Dies ist keine gültige Postleitzahl oder kein gültiger Ort. |

    @tms:UTR-11367 @ExcludeCK
    Examples:
      | locale | userType | langCode | zipCode | error                                        |
      | be     | guest    | default  |         | oeps! dat is geen geldige postcode of plaats |

    @tms:UTR-11373
    Examples:
      | locale | userType  | langCode | zipCode | error                                      |
      | de     | logged in | EN       |         | Oops! That isn't a valid postcode or city. |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @CollectInStore @ShippingPage @P2
  Scenario Outline: Collect in store - As a guest or user I cannot proceed to payment with CiS shipping method but no store selected
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I wait for 3 seconds
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
    Then I see Checkout.ShippingPage.CollectInstoreSearchFieldError contains text "<error>"

    # @tms:UTR-11388
    # Examples:
    #   | locale | langCode | userType | error                                         |
    #   | pl     | default  | guest    | Wybierz sklep, w którym chcesz odebrać zakupy |

    # @tms:UTR-11391 @ExcludeCK
    # Examples:
    #   | locale | langCode | userType  | error                                          |
    #   | ie     | default  | logged in | Please select a store to collect your purchase |

    @tms:UTR-11389 @Mobile
    Examples:
      | locale | langCode | userType | error                                                             |
      | de     | default  | guest    | Bitte einen Store auswählen, um Ihre bestellten Artikel abzuholen |

    @tms:UTR-11392
    Examples:
      | locale | langCode | userType  | error                                          |
      | de     | EN       | logged in | Please select a store to collect your purchase |

    @tms:UTR-11390 @ExcludeCK
    Examples:
      | locale | langCode | userType | error                                          |
      | be     | default  | guest    | Selecteer een winkel om je aankoop op te halen |

    @tms:UTR-11393 @ExcludeCK
    Examples:
      | locale | langCode | userType  | error                                                         |
      | be     | FR       | logged in | veuillez sélectionner une boutique pour récupérer votre achat |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @CollectInStore @ShippingPage @P2
  Scenario Outline: Collect in store - As a guest or user I will be redirected back to shipping page when I change the URL to payment with CiS shipping method but no store selected
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      And I am on locale <locale> of url /checkout/shipping
      And I wait for 2 seconds
    Then URL should contain "/shipping"

    # @tms:UTR-11374 @ExcludeCK
    # Examples:
    #   | locale | langCode | userType |
    #   | ie     | default  | guest    |

    # @tms:UTR-11377 @ExcludeTH
    # Examples:
    #   | locale | langCode | userType  |
    #   | pl     | default  | logged in |

    @tms:UTR-11375
    Examples:
      | locale | langCode | userType |
      | de     | default  | guest    |

    @tms:UTR-11378 @Mobile
    Examples:
      | locale | langCode | userType  |
      | de     | EN       | logged in |

    @tms:UTR-11376 @ExcludeCK
    Examples:
      | locale | langCode | userType |
      | be     | default  | guest    |

    @tms:UTR-11379 @ExcludeCK @Mobile
    Examples:
      | locale | langCode | userType  |
      | be     | FR       | logged in |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @CollectInStore @PaymentPage @P2
  Scenario Outline: Collect in store - As a guest or user there is no same as shipping checkbox and billing form is displayed on payment page
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
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
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I add other billing details
      And I see Checkout.PaymentPage.SameAsShippingCheckbox is not displayed

    # @tms:UTR-11385 @ExcludeTH
    # Examples:
    #   | locale | langCode | userType  | searchText |
    #   | pl     | default  | logged in | Warsaw     |

    @tms:UTR-11382 @Mobile
    Examples:
      | locale | langCode | userType | searchText |
      | de     | default  | guest    | 10719      |

    # @tms:UTR-11386 @ExcludeCK
    # Examples:
    #   | locale | langCode | userType  | searchText |
    #   | ie     | default  | logged in | Dublin     |

    @tms:UTR-11383 @Mobile
    Examples:
      | locale | langCode | userType  | searchText |
      | de     | EN       | logged in | 10719      |

    @tms:UTR-11384 @ExcludeCK
    Examples:
      | locale | langCode | userType | searchText |
      | be     | default  | guest    | Gent       |

    @tms:UTR-11387 @ExcludeCK
    Examples:
      | locale | langCode | userType  | searchText |
      | be     | FR       | logged in | 8500       |

  #TODO: need to see how can I check the grayed out state
  # @FullRegression
  @Desktop @Mobile
  @Chrome
  @UnifiedCheckout @DeliveryMethods @CollectInStore @ShippingPage @P2
  Scenario Outline: Collect in store - As a guest or user 'Checkout with PayPal' button should not be displayed when CIS is selected as a delivery method
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I wait until Checkout.ShippingPage.CollectInStoreSearchField is displayed
    When I type "<searchText>" in the field Checkout.ShippingPage.CollectInStoreSearchField
      And I click on Checkout.ShippingPage.CollectInStoreFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I wait for 2 seconds
      And I am on locale <locale> of url /checkout/shipping
      And I wait for 2 seconds
      And I see Checkout.SignInPage.PaypalExpressButton is disabled

    # @tms:UTR-11394 @ExcludeTH
    # Examples:
    #   | locale | langCode | userType  | searchText |
    #   | pl     | default  | logged in | Warsaw     |

    @tms:UTR-11399
    Examples:
      | locale | langCode | userType | searchText |
      | de     | default  | guest    | 10719      |

    # @tms:UTR-11395 @ExcludeCK
    # Examples:
    #   | locale | langCode | userType  | searchText |
    #   | ie     | default  | logged in | Dublin     |

    @tms:UTR-11398
    Examples:
      | locale | langCode | userType  | searchText |
      | de     | EN       | logged in | 10719      |

    @tms:UTR-11397 @ExcludeCK
    Examples:
      | locale | langCode | userType | searchText |
      | be     | default  | guest    | Gent       |

    @tms:UTR-11396 @ExcludeCK
    Examples:
      | locale | langCode | userType  | searchText |
      | be     | FR       | logged in | 8500       |
