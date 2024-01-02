Feature: Unified Checkout - Delivery Method - PostNL Pickup Point

  # @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @Payment @Creditcard @PostNL @DeliveryPage @HappyFlow
  Scenario Outline: PostNL Pickup Point - As a guest I can complete an order with PostNL as my delivery method
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
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

    @tms:UTR-11308 @Mobile
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |

    @tms:UTR-11309
    Examples:
      | locale | langCode | userType  |
      | nl     | default  | logged in |

  # @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @Payment @PostNL
  Scenario Outline: PostNL Pickup Point - As a guest/user I can use PostNL as my delivery method then go switch to another delivery method and complete purchase
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
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

    @tms:UTR-11310
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |

    @tms:UTR-11311 @Mobile
    Examples:
      | locale | langCode | userType  |
      | nl     | default  | logged in |

  # @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @Payment @PostNL
  Scenario Outline: PostNL Pickup Point - As a guest/user I can use PostNL as my delivery after switching from another delivery method and complete purchase
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.DeliveryTabButton
      And I click on Checkout.ShippingPage.StandardRadioButton
      And I wait for 2 seconds
      And as a <userType> I add first delivery details
      And I wait for 3 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I navigate back in the browser
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.PostNLRadioButton
      And I wait until Checkout.ShippingPage.PostNLSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.PostNLSearchField
      And I click on Checkout.ShippingPage.PostNLFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I wait for 3 seconds
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

    @tms:UTR-17972 @Mobile
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |

    @tms:UTR-17973
    Examples:
      | locale | langCode | userType  |
      | nl     | default  | logged in |

  # @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @ShippingPage @PostNL @P2
  Scenario Outline: PostNL Pickup Point - As a guest or user I can see PostNL delivery method, the map, drop pin, opening hours and when I select a store I see the details of the store and change store button
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.PostNLRadioButton
      And I wait until Checkout.ShippingPage.PostNLSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.PostNLSearchField
      And I click on Checkout.ShippingPage.PostNLFindStoreButton
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
      And I see Checkout.ShippingPage.PostNLChangeStoreButton is displayed

    @tms:UTR-11312
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |

    @tms:UTR-11313 @Mobile
    Examples:
      | locale | langCode | userType  |
      | nl     | default  | logged in |

  # @FullRegression
  @Desktop
  @Chrome @Safari @Firefox @Translation @Lokalise
  @UnifiedCheckout @DeliveryMethods @ShippingPage @PostNL @P2
  Scenario Outline: PostNL Pickup Point - As a guest or user I get an error if I leave the search field empty or enter incorrect data
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.PostNLRadioButton
      And I wait until Checkout.ShippingPage.PostNLSearchField is displayed
    When I type "" in the field Checkout.ShippingPage.PostNLSearchField
      And I click on Checkout.ShippingPage.PostNLFindStoreButton
      And I get translation from lokalise for "PuPEmptySearch" and store it with key #EmptySearch
    Then I see Checkout.ShippingPage.PostNLSearchFieldError contains text "#EmptySearch"

    @tms:UTR-11314 @Mobile
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |

    @tms:UTR-11315
    Examples:
      | locale | langCode | userType  |
      | nl     | default  | logged in |

  # @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @UnifiedCheckout @DeliveryMethods @ShippingPage @PostNL @P2
  Scenario Outline: PostNL Pickup Point - As a guest or user I can select a farther pick-up point using PostNL
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.PostNLRadioButton is displayed
      And I click on Checkout.ShippingPage.PostNLRadioButton
      And I wait until Checkout.ShippingPage.PostNLSearchField is displayed
    When I type "<location>" in the field Checkout.ShippingPage.PostNLSearchField
      And I click on Checkout.ShippingPage.PostNLFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResult is greater than 1
      And I store the number of displayed elements Checkout.ShippingPage.PUPSearchResult with key #StoreCount
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I store the numeric value of Checkout.ShippingPage.PUPDistanceToStore with index 1 with key #FirstStoreDistance
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I wait for 2 seconds
    Then I see Checkout.ShippingPage.PUPChoosenStoreInfo is displayed
    When I click on Checkout.ShippingPage.PostNLChangeStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is equal to #StoreCount
    When I click on Checkout.ShippingPage.PUPSearchResult by index 3
    Then I see the numeric value of Checkout.ShippingPage.PUPDistanceToStore with index 3 is greater than #FirstStoreDistance

    @tms:UTR-11316
    Examples:
      | locale | langCode | userType | location  |
      | nl     | default  | guest    | Amsterdam |

    @tms:UTR-11317 @Mobile
    Examples:
      | locale | langCode | userType  | location |
      | nl     | EN       | logged in | 1014 ZB  |

  # @FullRegression
  @Desktop
  @Chrome @Safari @Firefox @Translation @Lokalise
  @UnifiedCheckout @DeliveryMethods @ShippingPage @PostNL @P2
  Scenario Outline: PostNL Pickup Point - As a guest or user I get an error if I leave the search field empty or enter incorrect data in the modal window
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.PostNLRadioButton
      And I wait until Checkout.ShippingPage.PostNLSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.PostNLSearchField
      And I click on Checkout.ShippingPage.PostNLFindStoreButton
    When I type "<NewText>" in the empty field Checkout.ShippingPage.PUPModalPostCodeField
      And I click on Checkout.ShippingPage.PUPInStoreModalFindStoreButton
      And I get translation from lokalise for "PuPIncorrectSearch" and store it with key #IncorrectSearch
    Then I see Checkout.ShippingPage.PostNLModalSearchFieldError contains text "#IncorrectSearch"

    @tms:UTR-11318 @Mobile
    Examples:
      | locale | langCode | userType | NewText |
      | nl     | default  | guest    | XX      |

    @tms:UTR-11319
    Examples:
      | locale | langCode | userType  | NewText |
      | nl     | EN       | logged in | XX      |

  # @FullRegression
  @Desktop
  @Chrome @Firefox @Safari @Translation @Lokalise
  @UnifiedCheckout @DeliveryMethods @ShippingPage @PostNL @P2
  Scenario Outline: PostNL Pickup Point - As a guest or user I cannot proceed to payment with PostNL shipping method but no store selected
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.PostNLRadioButton
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
    Then I see Checkout.ShippingPage.PostNLSearchFieldError contains text "#NoStore"

    @tms:UTR-11320 @Mobile
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |

    @tms:UTR-11321
    Examples:
      | locale | langCode | userType  |
      | nl     | EN       | logged in |

  # @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @ShippingPage @PostNL @P2
  Scenario Outline: PostNL Pickup Point - As a guest or user I will be redirected back to shipping page when I change the URL to payment with PostNL shipping method but no store selected
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.PostNLRadioButton
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      | Checkout.ShippingPage.PhoneInput     | #PHONE                      |
      And I am on locale <locale> of url /checkout/shipping
      And I wait for 2 seconds
    Then URL should contain "/shipping"

    @tms:UTR-11322
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |

    @tms:UTR-11323 @Mobile
    Examples:
      | locale | langCode | userType  |
      | nl     | EN       | logged in |

  # @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @PaymentPage @PostNL @P2
  Scenario Outline: PostNL Pickup Point - As a guest or user there is no same as shipping checkbox and billing form is displayed on payment page
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
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
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I add other billing details
      And I see Checkout.PaymentPage.SameAsShippingCheckbox is not displayed

    @tms:UTR-11324 @Mobile
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |

    @tms:UTR-11325
    Examples:
      | locale | langCode | userType  |
      | nl     | EN       | logged in |

  # @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @ShippingPage @PostNL @P2
  Scenario Outline: PostNL Pickup Point - As a guest or user 'Checkout with PayPal' button should not be displayed when PostNL is selected as a delivery method
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.PostNLRadioButton is displayed
      And I click on Checkout.ShippingPage.PostNLRadioButton
      And I wait until Checkout.ShippingPage.PostNLSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.PostNLSearchField
      And I click on Checkout.ShippingPage.PostNLFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
    When I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I wait for 2 seconds
      And I am on locale <locale> of url /checkout/shipping
    Then I see Checkout.SignInPage.DisabledPaypalExpressButton is displayed in 5 seconds

    @tms:UTR-11326
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |

    @tms:UTR-11327 @Mobile
    Examples:
      | locale | langCode | userType  |
      | nl     | EN       | logged in |

  # @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari @Translation @Lokalise
  @UnifiedCheckout @DeliveryMethods @ShippingPage @PostNL @P2
  Scenario Outline: PostNL Pickup Point - As guest I can verify the shipping threshold for PostNL (Above)
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And in DB I extract the shipping promo threshold save to #ShipingPromoThreshold
      And There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between #ShipingPromoThreshold and 99999 and inventory between 1 and 9999
      And I wait for 2 seconds
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the count of elements Experience.ShoppingBag.Item is equal to 1
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I click on Checkout.ShippingPage.PickupTabButton
    When I wait until Checkout.ShippingPage.PostNLRadioButton is displayed
      And I get translation from lokalise for "FreeCosts" and store it with key #freeCosts
    Then I see Checkout.ShippingPage.PostNLRadioButtonText contains text "#freeCosts"

    @tms:UTR-11328
    Examples:
      | locale | langCode |
      | nl     | default  |

    @tms:UTR-18028
    Examples:
      | locale | langCode |
      | nl     | EN       |

  # @FullRegression
  @Desktop @Mobile
  @Chrome
  @UnifiedCheckout @DeliveryMethods @ShippingPage @PostNL @P2
  Scenario Outline: PostNL Pickup Point - As guest I can verify the shipping threshold for PostNL (under)
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And in DB I extract the shipping promo threshold save to #ShipingPromoThreshold
      And There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 1 and #ShipingPromoThreshold and inventory between 1 and 9999
      And I wait for 2 seconds
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I am on locale <locale> of url shopping-bag of langCode <langCode>
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until Checkout.ShippingPage.PickupTabButton is displayed
      And I click on Checkout.ShippingPage.PickupTabButton
      And I see Checkout.ShippingPage.PostNLRadioButtonText contains text "€ 2,95"

    @tms:UTR-11329
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |