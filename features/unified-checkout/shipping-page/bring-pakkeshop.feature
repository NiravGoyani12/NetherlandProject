Feature: Unified Checkout - Delivery Method - BRING Pakkeshop

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @BRING @Payment @Creditcard @HappyFlow
  Scenario Outline: Bring Pakkeshop - As guest or user I can complete an order with Bring Pakkeshop as my delivery method
    Given I am <userType> on locale <locale> of langCode default on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.BRINGRadioButton is displayed
      And I click on Checkout.ShippingPage.BRINGRadioButton
      And I wait for 1 seconds
    When I type "<location>" in the field Checkout.ShippingPage.BringSearchField
      And I click on Checkout.ShippingPage.BringFindPUPButton
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I expect 1 network request named GeocodeService.Search of type script to be processed in 10 seconds
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                     |
      | Checkout.ShippingPage.LastNameInput  | Testovich                   |
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
      And I see Checkout.PaymentPage.SameAsShippingCheckbox is not displayed
      And I add other billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-13466 @Mobile
    Examples:
      | locale | location | userType |
      | dk     | 2450     | guest    |

    @tms:UTR-14420
    Examples:
      | locale | location  | userType  |
      | se     | Stockholm | logged in |

    @tms:UTR-14423 @Mobile
    Examples:
      | locale | location | userType  |
      | fi     | 00130    | logged in |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @Payment @BRING @P2
  Scenario Outline: Bring Pakkeshop - As a guest/user I can select BRING as my delivery method then go switch to another delivery method and complete purchase
    Given I am <userType> on locale <locale> of langCode default on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.BRINGRadioButton is clickable
      And I click on Checkout.ShippingPage.BRINGRadioButton
      And I wait until Checkout.ShippingPage.BringSearchField is displayed
    When I type "<location>" in the field Checkout.ShippingPage.BringSearchField
      And I click on Checkout.ShippingPage.BringFindPUPButton
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
      And I wait for 1 seconds
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

    @tms:UTR-14424 @Mobile
    Examples:
      | locale | userType | location |
      | dk     | guest    | 2450     |

    @tms:UTR-14426
    Examples:
      | locale | location  | userType  |
      | se     | Stockholm | logged in |


  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @Payment @BRING @P2
  Scenario Outline: Bring Pakkeshop - As a guest/user I can switch my delivery method to BRING and complete purchase
    Given I am guest on locale <locale> of langCode default on the shipping page
      And I store the cartId
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And I click on Checkout.ShippingPage.StandardRadioButton
      And I expect 0 network request named GeocodeService.Search of type script to be processed in 10 seconds
      And I wait until Checkout.ShippingPage.NewAddressSection is displayed
      And as a guest I add first delivery details
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I navigate back in the browser
      And I wait until Checkout.ShippingPage.PickupTabButton is clickable
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.BRINGRadioButton is clickable
      And I click on Checkout.ShippingPage.BRINGRadioButton
      And I wait until Checkout.ShippingPage.BringSearchField is displayed
    When I type "<location>" in the field Checkout.ShippingPage.BringSearchField
      And I click on Checkout.ShippingPage.BringFindPUPButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I expect 1 network request named GeocodeService.Search of type script to be processed in 10 seconds
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I wait for 3 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
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

    @tms:UTR-17928 @Mobile
    Examples:
      | locale | location |
      | dk     | 2450     |

    @tms:UTR-17929
    Examples:
      | locale | location |
      | fi     | Espoo    |


  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @ShippingPage @BRING @P2
  Scenario Outline: Bring pakkeshop - As a guest or user I can see BRING PUDO, the map, drop pin, opening hours and when I select a store I see the details of the store and change PuP button
    Given I am <userType> on locale <locale> of langCode default on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.BRINGRadioButton is clickable
      And I click on Checkout.ShippingPage.BRINGRadioButton
      And I wait until Checkout.ShippingPage.BringSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.BringSearchField
      And I click on Checkout.ShippingPage.BringFindPUPButton
    Then I see the attribute value of element Checkout.ShippingPage.PUPModalSearchField containing "#POSTCODE"
      And I store the number of displayed elements Checkout.ShippingPage.PUPSearchResult with key #StoreCount
      And the count of elements Checkout.ShippingPage.PUPMapMarker is equal to #StoreCount
      And the count of elements Checkout.ShippingPage.PUPDistanceToStore is equal to #StoreCount
    When I click on Checkout.ShippingPage.PUPSearchResult by index 3
      And I click on Checkout.ShippingPage.PUPOpeningHoursLink by index 3
    Then the count of elements Checkout.ShippingPage.PUPOpeningDays is equal to 7
      And the count of elements Checkout.ShippingPage.PUPOpeningHours is equal to 7
    When I click on Checkout.ShippingPage.PUPSearchResult by index 2
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I wait for 2 seconds
    Then I see Checkout.ShippingPage.PUPChoosenStoreInfo is displayed
      And I see Checkout.ShippingPage.BringChangePUPButton is displayed

    @tms:UTR-13469
    Examples:
      | locale | userType  |
      | dk     | logged in |

    @tms:UTR-13468 @Mobile
    Examples:
      | locale | userType |
      | se     | guest    |

    @tms:UTR-14427
    Examples:
      | locale | userType  |
      | fi     | logged in |

  @FullRegression
  @Desktop
  @Chrome @Safari @Firefox @Translation @Lokalise
  @UnifiedCheckout @DeliveryMethods @ShippingPage @BRING @P2
  Scenario Outline: Bring pakkeshop - As a guest or user I get an error if I leave the search field empty or enter incorrect data
    Given I am <userType> on locale <locale> of langCode default on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.BRINGRadioButton is clickable
      And I click on Checkout.ShippingPage.BRINGRadioButton
      And I wait until Checkout.ShippingPage.BringSearchField is displayed
    When I click on Checkout.ShippingPage.BringFindPUPButton
      And I get translation from lokalise for "PuPEmptySearch" and store it with key #EmptySearch
    Then I see Checkout.ShippingPage.BringSearchFieldError contains text "#EmptySearch"

    @tms:UTR-13470
    Examples:
      | locale | userType |
      | dk     | guest    |

    @tms:UTR-13471 @Mobile
    Examples:
      | locale | userType  |
      | se     | logged in |

    @tms:UTR-14428 @Mobile
    Examples:
      | locale | userType |
      | fi     | guest    |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @ShippingPage @BRING @P2
  Scenario Outline: Bring Pakkeshop - As a guest or user I can select a farther pick-up point
    Given I am <userType> on locale <locale> of langCode default on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.BRINGRadioButton is clickable
      And I click on Checkout.ShippingPage.BRINGRadioButton
      And I wait until Checkout.ShippingPage.BringSearchField is displayed
    When I type "<city>" in the field Checkout.ShippingPage.BringSearchField
      And I click on Checkout.ShippingPage.BringFindPUPButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 1
      And I store the number of displayed elements Checkout.ShippingPage.PUPSearchResults with key #StoreCount
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I store the numeric value of Checkout.ShippingPage.PUPDistanceToStore with index 1 with key #FirstStoreDistance
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I wait for 2 seconds
    Then I see Checkout.ShippingPage.PUPChoosenStoreInfo is displayed
    When I click on Checkout.ShippingPage.BringChangePUPButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is equal to #StoreCount
    When I click on Checkout.ShippingPage.PUPSearchResult by index 3
    Then I see the numeric value of Checkout.ShippingPage.PUPDistanceToStore with index 3 is greater than #FirstStoreDistance

    @tms:UTR-13472 @Mobile
    Examples:
      | locale | userType  | city    |
      | dk     | logged in | Aalborg |

    @tms:UTR-14431
    Examples:
      | locale | userType | city      |
      | se     | guest    | Stockholm |

    @tms:UTR-14432 @Mobile
    Examples:
      | locale | userType  | city  |
      | fi     | logged in | Espoo |

  @FullRegression
  @Desktop
  @Chrome @Safari @Firefox @Translation @Lokalise
  @UnifiedCheckout @DeliveryMethods @ShippingPage @BRING @P2
  Scenario Outline: Bring Pakkeshop - As a guest or user I get an error if I enter incorrect data in the modal window
    Given I am <userType> on locale <locale> of langCode default on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.BRINGRadioButton is clickable
      And I click on Checkout.ShippingPage.BRINGRadioButton
      And I wait until Checkout.ShippingPage.BringSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.BringSearchField
      And I click on Checkout.ShippingPage.BringFindPUPButton
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
    When I type "XX" in the empty field Checkout.ShippingPage.PUPModalPostCodeField
      And I click on Checkout.ShippingPage.PUPInStoreModalFindStoreButton
      And I get translation from lokalise for "PuPIncorrectSearch" and store it with key #IncorrectSearch
    Then I see Checkout.ShippingPage.PUPSearchModalFieldError contains text "#IncorrectSearch"

    @tms:UTR-14433
    Examples:
      | locale | userType |
      | dk     | guest    |

    @tms:UTR-14435 @Mobile
    Examples:
      | locale | userType  |
      | se     | logged in |

    @tms:UTR-14434
    Examples:
      | locale | userType |
      | fi     | guest    |

  @FullRegression
  @Desktop
  @Chrome @Safari @Firefox @Translation @Lokalise
  @UnifiedCheckout @DeliveryMethods @ShippingPage @BRING @P2
  Scenario Outline: Bring Pakkeshop - As a guest or user I cannot proceed to payment with no PuP selected
    Given I am <userType> on locale <locale> of langCode default on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.BRINGRadioButton is clickable
      And I click on Checkout.ShippingPage.BRINGRadioButton
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
    Then I see Checkout.ShippingPage.BringSearchFieldError contains text "#NoStore"

    @tms:UTR-14436 @Mobile
    Examples:
      | locale | userType  |
      | dk     | logged in |

    @tms:UTR-14438 @Mobile
    Examples:
      | locale | userType |
      | se     | guest    |

    @tms:UTR-14437
    Examples:
      | locale | userType  |
      | fi     | logged in |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @ShippingPage @BRING @P2
  Scenario Outline: Bring Pakkeshop - As a guest or user I will be redirected back to shipping page when I change the URL payment but no store selected
    Given I am <userType> on locale <locale> of langCode default on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.BRINGRadioButton is clickable
      And I click on Checkout.ShippingPage.BRINGRadioButton
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      | Checkout.ShippingPage.PhoneInput     | #PHONE                      |
      And I am on locale <locale> of url /checkout/shipping
      And I wait for 2 seconds
    Then URL should contain "/shipping"

    @tms:UTR-14439
    Examples:
      | locale | userType |
      | dk     | guest    |

    @tms:UTR-14440 @Mobile
    Examples:
      | locale | userType  |
      | se     | logged in |

    @tms:UTR-14441
    Examples:
      | locale | userType |
      | fi     | guest    |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @PaymentPage @BRING @P2
  Scenario Outline: Bring Pakkeshop - As a guest or user there is no same as shipping checkbox and billing form is displayed only on the main locale
    Given I am <userType> on locale <locale> of langCode default on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.BRINGRadioButton is clickable
      And I click on Checkout.ShippingPage.BRINGRadioButton
      And I wait until Checkout.ShippingPage.BringSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.BringSearchField
      And I click on Checkout.ShippingPage.BringFindPUPButton
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
    When I see Checkout.PaymentPage.SameAsShippingCheckbox is not displayed
    Then I see the attribute value of element Checkout.PaymentPage.CountryInput containing "<countryName>"

    @tms:UTR-13464
    Examples:
      | locale | userType | countryName |
      | dk     | guest    | Denmark     |

    @tms:UTR-13465 @Mobile
    Examples:
      | locale | userType  | countryName |
      | se     | logged in | Sweden      |

    @tms:UTR-14442
    Examples:
      | locale | userType | countryName |
      | fi     | guest    | Finland     |

  @FullRegression
  @Desktop
  @Chrome @Safari @Firefox @Translation @Lokalise
  @UnifiedCheckout @DeliveryMethods @ShippingPage @BRING @P2
  Scenario Outline: Bring Pakkeshop - As guest I can verify that Bring Pakkeshop is always free
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And in DB I extract the shipping promo threshold save to #ShipingPromoThreshold
      And There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between <minThreshold> and <maxThreshold> and inventory between 1 and 9999
      And I wait for 2 seconds
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I am on locale <locale> of url shopping-bag of langCode <langCode>
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.BRINGRadioButton is clickable
      And I click on Checkout.ShippingPage.BRINGRadioButton
      And I get translation from lokalise for "FreeCosts" and store it with key #FreeShippingCosts
    Then I see Checkout.ShippingPage.BringRadioButtonText contains text "#FreeShippingCosts"

    @tms:UTR-14445 @Mobile
    Examples:
      | locale | langCode | userType | minThreshold | maxThreshold           |
      | dk     | default  | guest    | 1            | #ShipingPromoThreshold |

    @tms:UTR-14446
    Examples:
      | locale | langCode | userType | minThreshold           | maxThreshold |
      | se     | default  | guest    | #ShipingPromoThreshold | 999999       |

    @tms:UTR-14447
    Examples:
      | locale | langCode | userType | minThreshold | maxThreshold           |
      | fi     | default  | guest    | 1            | #ShipingPromoThreshold |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @BRING @Payment @Creditcard @P3
  Scenario Outline: Bring Pakkeshop - As user I can see my e-mail address prepopulated in BRING details form
    Given I am logged in on locale <locale> of langCode default on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.BRINGRadioButton is clickable
      And I click on Checkout.ShippingPage.BRINGRadioButton
      And I wait until Checkout.ShippingPage.BringSearchField is displayed
    Then I see the attribute value of element Checkout.ShippingPage.EmailInput containing "user1#email"

    @tms:UTR-14453
    Examples:
      | locale |
      | dk     |

    @tms:UTR-14454
    Examples:
      | locale |
      | fi     |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @BRING @P2
  Scenario Outline: Bring Pakkeshop - Error is displayed if mandatory fields left empty for personal details form on shipping page
    Given I am <userType> on locale <locale> of langCode default on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.BRINGRadioButton is displayed
      And I click on Checkout.ShippingPage.BRINGRadioButton
      And I wait for 1 seconds
    When I type "<location>" in the field Checkout.ShippingPage.BringSearchField
      And I click on Checkout.ShippingPage.BringFindPUPButton
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I click on Checkout.ShippingPage.ProceedToPayment if exists
    Then I see Checkout.ShippingPage.InputErrorMessage with index 1 contains text "Email is required."
      And I see Checkout.ShippingPage.InputErrorMessage with index 2 contains text "First name is required."
      And I see Checkout.ShippingPage.InputErrorMessage with index 3 contains text "Last name is required."
      And I see Checkout.ShippingPage.InputErrorMessage with index 4 contains text "Phone number is required."

    @tms:UTR-13494
    Examples:
      | locale | location | userType |
      | dk     | 2450     | guest    |

    @tms:UTR-14455
    Examples:
      | locale | location | userType |
      | se     | 41116    | guest    |

    @tms:UTR-14456
    Examples:
      | locale | location | userType |
      | fi     | 00130    | guest    |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @BRING @P3
  Scenario Outline: Bring Pakkeshop - Error is displayed if user puts invalid entries for personal details form on shipping page
    Given I am <userType> on locale <locale> of langCode default on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.BRINGRadioButton is displayed
      And I click on Checkout.ShippingPage.BRINGRadioButton
      And I wait for 1 seconds
    When I type "<location>" in the field Checkout.ShippingPage.BringSearchField
      And I click on Checkout.ShippingPage.BringFindPUPButton
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I type to following inputs
      | element                              | value                      |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automationgmail.com |
      | Checkout.ShippingPage.FirstNameInput | Testing123                 |
      | Checkout.ShippingPage.LastNameInput  | Testovich123               |
      | Checkout.ShippingPage.PhoneInput     | #PHONEerer                 |
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
    Then I see Checkout.ShippingPage.InputErrorMessage with index 1 contains text "Sorry, that doesn't look like an email address"
      And I see Checkout.ShippingPage.InputErrorMessage with index 2 contains text "Please fill in your first name"
      And I see Checkout.ShippingPage.InputErrorMessage with index 3 contains text "Please fill in your last name"
      And I see Checkout.ShippingPage.InputErrorMessage with index 4 contains text "Sorry, that doesn't look like a phone number"

    @tms:UTR-13493
    Examples:
      | locale | location   | userType |
      | dk     | Copenhagen | guest    |

    @tms:UTR-14457
    Examples:
      | locale | location | userType |
      | se     | Goteborg | guest    |

    @tms:UTR-14458
    Examples:
      | locale | location | userType |
      | fi     | Helsinki | guest    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Translation @Lokalise
  @UnifiedCheckout @ShippingPage @DeliveryMethods @BRING @P2
  Scenario Outline: Bring Pakkeshop - On payment page only same country addresses are shown in the billing address section
    Given I am on my account addresses page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.AddressPage.AddAddressButton
      And I add a new address as Other
      And I wait for 2 seconds
      And in dropdown MyAccount.AddressPage.AddressTypeDropdown I select the option by index "3"
      And I click on MyAccount.AddressPage.SaveAddressButton
      And I click on MyAccount.AddressPage.AddAddressButton
      And I add a new address as Mr
      And in dropdown MyAccount.AddressPage.AddressTypeDropdown I select the option by index "3"
      And I click on MyAccount.AddressPage.SaveAddressButton
      And I click on MyAccount.AddressPage.AddAddressButton
      And in dropdown MyAccount.AddressPage.AddressTypeDropdown I select the option by index "2"
      And in dropdown MyAccount.AddressPage.CountryDropdown I select the option by text "Netherlands"
      And I click on MyAccount.AddressPage.OtherButton
      And I type "Automation" in the empty field MyAccount.AddressPage.FirstNameInput
      And I type "Tester" in the empty field MyAccount.AddressPage.LastNameInput
      And I type "Vodkalane" in the empty field MyAccount.AddressPage.AddressInput
      And I type "33" in the empty field MyAccount.AddressPage.AditionInput
      And I type "Snowland" in the empty field MyAccount.AddressPage.CityInput
      And I type "1014 ZB" in the empty field MyAccount.AddressPage.PostCodeInput
      And I wait for 1 seconds
      And I click on MyAccount.AddressPage.SaveAddressButton
      And I wait for 2 seconds
    Then the count of displayed elements MyAccount.AddressPage.AddressCard is equal to 3
    When I am on locale <locale> shopping bag page with 1 unit of any product
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.BRINGRadioButton is displayed
      And I click on Checkout.ShippingPage.BRINGRadioButton
      And I wait for 1 seconds
      And I type "<location>" in the field Checkout.ShippingPage.BringSearchField
      And I click on Checkout.ShippingPage.BringFindPUPButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
    When I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      | Checkout.ShippingPage.PhoneInput     | #PHONE                      |
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I see Checkout.ShippingPage.BillingAddressOnPaymentPage is displayed in 2 seconds
    When in dropdown Checkout.PaymentPage.BillingAddressDropdown I select the option by index "2"
      And I wait for 2 seconds
    Then I check that my billing details with index "1" have been saved
      And I see Checkout.ShippingPage.BillingAddressOnPaymentPage contains text "<country>"
    When in dropdown Checkout.PaymentPage.BillingAddressDropdown I select the option by index "1"
      And I wait for 1 seconds
    Then I check that my billing details with index "2" have been saved
      And I see Checkout.ShippingPage.BillingAddressOnPaymentPage contains text "<country>"

    @tms:UTR-13589 @issue:EESCK-12951
    Examples:
      | locale | langCode | location | country |
      | dk     | default  | 2450     | Denmark |

    @tms:UTR-13590 @issue:EESCK-12951
    Examples:
      | locale | langCode | location | country |
      | se     | default  | 41116    | Sweden  |

  @FullRegression
  @Desktop
  @Chrome @Safari @FireFox @Translation @Lokalise
  @UnifiedCheckout @ShippingPage @DeliveryMethods @BRING @P2
  Scenario Outline: Bring Pakkeshop - Invalid postcode on the pup search input field causes an error state and store list is seen correctly
    Given I am <userType> on locale <locale> of langCode default on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.PickupTabButton in 2 seconds
      And I wait until Checkout.ShippingPage.BRINGRadioButton is displayed
      And I click on Checkout.ShippingPage.BRINGRadioButton
      And I wait for 1 seconds
    When I type "<location>" in the field Checkout.ShippingPage.BringSearchField
      And I click on Checkout.ShippingPage.BringFindPUPButton
    Then the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.BringChangePUPButton in 1 seconds
      And I clear text field of element Checkout.ShippingPage.PUPModalSearchField
    When I type "<invalidLocation>" in the field Checkout.ShippingPage.PUPModalSearchField
      And I click on Checkout.ShippingPage.PUPInStoreModalFindStoreButton
      And I get translation from lokalise for "PuPIncorrectSearch" and store it with key #IncorrectSearch
    Then I see Checkout.ShippingPage.PUPSearchModalFieldError is displayed in 1 seconds
      And the count of elements Checkout.ShippingPage.PUPSearchModalFieldError is equal to 1
      And I see Checkout.ShippingPage.PUPSearchModalFieldError contains text "#IncorrectSearch"

    @tms:UTR-14094
    Examples:
      | locale | langCode | location | userType  | invalidLocation |
      | dk     | default  | 8600     | logged in | 3434343         |
