Feature: Unified Checkout - Payment Methods - iDeal

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @CrossSitePayment @iDeal @HappyFlow
  Scenario: iDeal - As a NL user I can pay order with iDeal
    Given I am cross site user on locale <locale> of langCode default on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.IdealButton is clickable
      And I click on Checkout.PaymentPage.IdealButton
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Test Issuer 6"
      And I see Checkout.PaymentPage.TermsAndConditionsCheckbox is not displayed
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 1 seconds
      And in ideal I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10577 
    Examples:
      | locale |
      | nl     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @CrossSitePayment @iDeal @HappyFlow
  Scenario: iDeal - As a NL guest I can pay order with iDeal
    Given I am guest on locale <locale> of langCode default on the payment page
      And I store the cartId
      And I click on Checkout.PaymentPage.IdealButton
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Test Issuer 6"
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 1 seconds
      And in ideal I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10578
    Examples:
      | locale |
      | nl     |

  # @P1 This should have been under P1 list , at the moment it's gonna be disabled to analyse live issue
  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @iDeal @HappyFlow
  Scenario: iDeal - As a NL guest or user I can pay order with iDeal
    Given I am <userType> on locale <locale> of langCode <langCode> with <delivery> delivery method on the payment page
      And I store the cartId
      And I click on Checkout.PaymentPage.IdealButton
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Test Issuer 6"
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 1 seconds
      And in ideal I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-13124 @Mobile
    Examples:
      | locale | langCode | userType | delivery |
      | nl     | default  | guest    | express  |

    @tms:UTR-13125
    Examples:
      | locale | langCode | userType  | delivery |
      | nl     | EN       | logged in | standard |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @iDeal @PostNL @HappyFlow
  Scenario: iDeal - As a NL guest or user I can pay order with iDeal using PostNL
    Given I am <userType> on locale <locale> of langCode default on the shipping page
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
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I click on Checkout.PaymentPage.IdealButton
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Test Issuer 6"
      And I add other billing details
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 1 seconds
      And in ideal I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-13126
    Examples:
      | locale | userType |
      | nl     | guest    |

    @tms:UTR-13127 @Mobile
    Examples:
      | locale | userType  |
      | nl     | logged in |

  # @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @CrossSitePayment @iDeal @CollectInStore @HappyFlow
  Scenario: iDeal - As a NL guest or user I can pay order with iDeal using Collect in Store
    Given I am <userType> on locale <locale> of langCode default on the shipping page
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
      And I click on Checkout.PaymentPage.IdealButton
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Test Issuer 6"
      And I add other billing details
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 1 seconds
      And in ideal I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-13130 @Mobile
    Examples:
      | locale | userType |
      | nl     | guest    |

    @tms:UTR-13128
    Examples:
      | locale | userType  |
      | nl     | logged in |

  # @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @CrossSitePayment @iDeal @UPSAP @HappyFlow
  Scenario: iDeal - As a NL guest or user I can pay order with iDeal using UPS Access point
    Given I am <userType> on locale <locale> of langCode default on the shipping page
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
      And I click on Checkout.PaymentPage.IdealButton
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Test Issuer 6"
      And I add other billing details
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 1 seconds
      And in ideal I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-13132
    Examples:
      | locale | userType |
      | nl     | guest    |

    @tms:UTR-13131 @Mobile
    Examples:
      | locale | userType  |
      | nl     | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @Negative @iDeal @P3 @PaymentPage
  Scenario Outline: iDeal - As a guest or registered user I pay with IDeal - Pending scenario
    Given I am <userType> on locale <locale> of langCode default on the payment page
      And I click on Checkout.PaymentPage.IdealButton
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Test Issuer Pending"
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 1 seconds
      And in ideal I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I see Checkout.OrderConfirmationPage.ConfirmationDetailsMessage contains text "Zodra uw bestelling is bevestigd, ontvangt u bericht via e-mail."

    @tms:UTR-10579 @Mobile
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |

    @tms:UTR-10580
    Examples:
      | locale | langCode | userType  |
      | nl     | default  | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @Negative @iDeal @P3 @PaymentPage
  Scenario Outline: iDeal - As a guest or registered user I see error message when order gets cancelled
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I click on Checkout.PaymentPage.IdealButton
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Test Issuer Cancelled"
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 1 seconds
      And in ideal I complete payment
    Then I see Checkout.PaymentPage.PaymentErrorMessage contains text "Oeps! Het lijkt erop dat je iDEAL-bestelling niet is verzonden. Probeer het opnieuw of kies een alternatieve betaalmethode."

    @tms:UTR-10581 
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |

    @tms:UTR-10582 @Mobile
    Examples:
      | locale | langCode | userType  |
      | nl     | default  | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @Negative @iDeal @P3 @PaymentPage
  Scenario Outline: iDeal - As a guest or registered user I see error message when order gets refused
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I click on Checkout.PaymentPage.IdealButton
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Test Issuer Refused"
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 1 seconds
      And in ideal I complete payment
    Then I see Checkout.PaymentPage.PaymentErrorMessage contains text "Je bestelling is niet ingediend vanwege een technische fout van de bank. Probeer het over een paar minuten nog een keer of kies een andere betalingsmethode. Bedankt voor je medewerking."

    @tms:UTR-10583
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |

    @tms:UTR-10584
    Examples:
      | locale | langCode | userType  |
      | nl     | default  | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @iDeal @Negative @P3 @PaymentPage
  Scenario Outline: iDeal - As a guest I can't pay with iDeal when total price is more than the limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 200 and 5000 and inventory between 100 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 40 units for product items product1#skuPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a guest I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I click on Checkout.PaymentPage.IdealButton
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Test Issuer 6"
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I get ideal payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 3 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#PaymentLimit"

    @tms:UTR-10585 @Mobile
    Examples:
      | locale | langCode |
      | nl     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @CrossSitePayment @iDeal @P2
  Scenario: iDeal - As a NL guest I can use browser back once in the iDeal window and return to the payment page
    Given I am guest on locale <locale> of langCode default on the payment page
      And I click on Checkout.PaymentPage.IdealButton
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Test Issuer 6"
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 1 seconds
    When I navigate back in the browser
      And I wait for 1 seconds
    Then URL should contain "/payment"
      And I see Checkout.PaymentPage.IdealButton is clickable

    @tms:UTR-10586 @Mobile
    Examples:
      | locale |
      | nl     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @PaymentPage @GiftCard @iDeal @HappyFlow @ExcludeUat
  Scenario: iDeal - As a NL user I can purchase giftcard and pay order with iDeal
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page gift-cards
      And I wait until the current page is loaded
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      And I wait until Checkout.SignInPage.PaypalExpressButton is clickable
      And I type to following inputs
      | element                              | value                    |
      | Checkout.ShippingPage.EmailInput     | pvh.sap_user@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                  |
      | Checkout.ShippingPage.LastNameInput  | Testovich                |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is not displayed
    Then I wait until Checkout.PaymentPage.Klarna is not displayed
    When I click on Checkout.PaymentPage.IdealButton
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Test Issuer 6"
      And I see Checkout.PaymentPage.TermsAndConditionsCheckbox is not displayed
      And I add giftCardFirst billing details
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 1 seconds
      And in ideal I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber

    @tms:UTR-17253 @ExcludeCK @Mobile
    Examples:
      | locale | langCode |
      | nl     | default  |
