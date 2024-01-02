Feature: Unified Checkout - Payment Methods - Bancontact

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @Payment @DeliveryMethods @Bancontact @PaymentPage @HappyFlow
  Scenario Outline: Bancontact - As guest/logged in I can pay with bancontact
    Given I am <userType> on locale <locale> of langCode <langCode> with <deliveryMethod> delivery method on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.BancontactButton is clickable
      And I click on Checkout.PaymentPage.BancontactButton
      And in payment page I fill in the Bancontact details
      | name       | value  |
      | cardNumber | <card> |
      | year       | 2030   |
      | month      | 03     |
      And I see Checkout.PaymentPage.BcmcCardTypeIcon with data-testid "bcmc-container" is enabled
      # And I see Checkout.PaymentPage.BcmcCardTypeIconNotSelected with data-testid "bcmc-container" is not displayed
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
    Then URL should contain "validate" within 15 seconds
    When with user "user" and password "password" I complete 3DS1 payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10362
    Examples:
      | locale | userType | langCode | deliveryMethod | card                |
      | be     | guest    | default  | standard       | 6703 4444 4444 4449 |

    @tms:UTR-10516 @Mobile
    Examples:
      | locale | userType  | langCode | deliveryMethod | card                |
      | be     | logged in | FR       | express        | 6703 4444 4444 4449 |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @Payment @DeliveryMethods @Bancontact @P2 @PaymentPage @HappyFlow
  Scenario Outline: Bancontact - As user I can pay with bancontact with express delivery
    Given I am logged in on locale <locale> of langCode <langCode> with express delivery method on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.BancontactButton is clickable
      And I click on Checkout.PaymentPage.BancontactButton
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

    @tms:UTR-10361 @Mobile
    Examples:
      | locale | langCode | card                |
      | be     | default  | 4871 0499 9999 9910 |

    @tms:UTR-10517
    Examples:
      | locale | langCode | card                |
      | be     | FR       | 4871 0499 9999 9910 |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @Payment @DeliveryMethods @Bancontact @PaymentPage @HappyFlow
  Scenario Outline: Bancontact - As a guest I can complete an order with UPS Access Point as my delivery method
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait until Checkout.ShippingPage.UPSAccesPointSearchField is displayed
    When I type "Bruxelles" in the field Checkout.ShippingPage.UPSAccesPointSearchField
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
      And I wait until Checkout.PaymentPage.BancontactButton is clickable
      And I click on Checkout.PaymentPage.BancontactButton
      And in payment page I fill in the Bancontact details
      | name       | value               |
      | cardNumber | 4871 0499 9999 9910 |
      | year       | 2030                |
      | month      | 03                  |
      # And I see Checkout.PaymentPage.BcmcCardTypeIcon with data-testid "bcmc-container" is displayed
      # And I see Checkout.PaymentPage.VisaCardTypeIconNotSelected with data-testid "bcmc-container" is displayed
      # And I click on Checkout.PaymentPage.VisaCardTypeIconNotSelected with data-testid "bcmc-container"
      # And I see Checkout.PaymentPage.VisaCardTypeIcon with data-testid "bcmc-container" is enabled
      # And I see Checkout.PaymentPage.BcmcCardTypeIconNotSelected with data-testid "bcmc-container" is displayed
      # And in payment page I fill in the Bancontact details
      # | name       | value                         |
      # | cvv        | 737                           |
      # | cardName   | Test Name under bcmc for visa |
      # And I see Checkout.PaymentPage.BcmcCardTypeIconNotSelected with data-testid "bcmc-container" is displayed
      And I add other billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
    Then URL should contain "validate" within 15 seconds
    When with user "user" and password "password" I complete 3DS1 payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    # @tms:UTR-10523
    # Examples:
    #   | locale | userType | langCode |
    #   | be     | guest    | default  |

    @tms:UTR-10524 @Mobile
    Examples:
      | locale | userType | langCode |
      | be     | guest    | FR       |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @Bancontact @DeliveryMethods @Payment @PaymentPage @ExcludeCK @HappyFlow
  Scenario Outline: Bancontact - As a registered user I can complete an order with collect in store as my delivery method
    Given I am <userType> on locale <locale> of langCode default on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I wait until Checkout.ShippingPage.CollectInStoreSearchField is displayed
    When I type "Bruxelles" in the field Checkout.ShippingPage.CollectInStoreSearchField
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
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.BancontactButton is clickable
      And I click on Checkout.PaymentPage.BancontactButton
      And in payment page I fill in the Bancontact details
      | name       | value               |
      | cardNumber | 4871 0499 9999 9910 |
      | year       | 2030                |
      | month      | 03                  |
      # And I see Checkout.PaymentPage.BcmcCardTypeIcon with data-testid "bcmc-container" is displayed
      # And I see Checkout.PaymentPage.VisaCardTypeIconNotSelected with data-testid "bcmc-container" is displayed
      # And I click on Checkout.PaymentPage.VisaCardTypeIconNotSelected with data-testid "bcmc-container"
      # And I see Checkout.PaymentPage.VisaCardTypeIcon with data-testid "bcmc-container" is enabled
      # And I see Checkout.PaymentPage.BcmcCardTypeIconNotSelected with data-testid "bcmc-container" is displayed
      # And in payment page I fill in the Bancontact details
      # | name       | value                         |
      # | cvv        | 737                           |
      # | cardName   | Test Name under bcmc for visa |
      And I add other billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
    Then URL should contain "validate" within 15 seconds
    When with user "user" and password "password" I complete 3DS1 payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10525 @Mobile
    Examples:
      | locale | userType  | langCode |
      | be     | logged in | FR       |

  # @tms:UTR-10526
  # Examples:
  #   | locale | userType | langCode |
  #   | be     | guest    | FR       |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @Payment @Bancontact @Negative @P3 @PaymentPage
  Scenario Outline: Bancontact - As a guest I can't pay with Bancontact if the amount is above payment limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 200 and 5000 and inventory between 100 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 40 units for product items product1#skuPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as guest to shipping page
      And as a guest I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I wait for 2 seconds
      And I wait until Checkout.PaymentPage.BancontactButton is clickable
      And I click on Checkout.PaymentPage.BancontactButton
      And in payment page I fill in the Bancontact details
      | name       | value               |
      | cardNumber | 4871 0499 9999 9910 |
      | year       | 2030                |
      | month      | 03                  |
    When I set the checkbox Checkout.PaymentPage.TermsAndConditionsCheckbox status to true if exist
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And I get credit card payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#PaymentLimit"
      And URL should not contain "validate"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed

    @tms:UTR-10360
    Examples:
      | locale | langCode |
      | be     | default  |

    @tms:UTR-10518 @Mobile
    Examples:
      | locale | langCode |
      | be     | FR       |

  @FullRegression
  @Desktop
  @Chrome @Translation
  @UnifiedCheckout @Payment @Bancontact @Negative @P2 @PaymentPage
  Scenario Outline: Bancontact - As a user I get an error and I can't pay with Bancontact if I enter the wrong user or password
    Given I am logged in on locale <locale> of langCode <langCode> with express delivery method on the payment page
      And I wait until Checkout.PaymentPage.BancontactButton is clickable
      And I click on Checkout.PaymentPage.BancontactButton
      And in payment page I fill in the Bancontact details
      | name       | value  |
      | cardNumber | <card> |
      | year       | 2030   |
      | month      | 03     |
      And I see Checkout.PaymentPage.BcmcCardTypeIcon with data-testid "bcmc-container" is enabled
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then URL should contain "validate" within 15 seconds
    When with user "Micky" and password "Mouse" I complete 3DS1 payment
      And I get translation from lokalise for "AuthenticationError" and store it with key #CreditCardAuthError
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#CreditCardAuthError"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed in 10 seconds

    @tms:UTR-10359
    Examples:
      | locale | langCode | card                |
      | be     | default  | 6703 4444 4444 4449 |

    @tms:UTR-10519
    Examples:
      | locale | langCode | card                |
      | be     | FR       | 6703 4444 4444 4449 |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @Payment @Bancontact @P2 @PaymentPage
  Scenario Outline: Bancontact - As guest I can pay with Bancontact and use back functionality
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.BancontactButton is clickable
      And I click on Checkout.PaymentPage.BancontactButton
      And in payment page I fill in the Bancontact details
      | name       | value               |
      | cardNumber | 6703 4444 4444 4449 |
      | year       | 2030                |
      | month      | 03                  |
      And I see Checkout.PaymentPage.BcmcCardTypeIcon with data-testid "bcmc-container" is displayed
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
    Then URL should contain "validate" within 15 seconds
      And I navigate back in the browser
      And I wait for 3 seconds
    Then URL should contain "/checkout/payment" within 15 seconds
    Then I see Checkout.PaymentPage.PaymentErrorMessage is not displayed in 10 seconds
    When I click on Checkout.PaymentPage.BancontactButton
      And in payment page I fill in the Bancontact details
      | name       | value               |
      | cardNumber | 6703 4444 4444 4449 |
      | year       | 2030                |
      | month      | 03                  |
      # And I see Checkout.PaymentPage.BcmcCardTypeIcon with data-testid "bcmc-container" is displayed
      # And I click on Checkout.PaymentPage.MaestroCardTypeIconNotSelected with data-testid "bcmc-container"
      # And I see Checkout.PaymentPage.MaestroCardTypeIcon with data-testid "bcmc-container" is enabled
      # And I see Checkout.PaymentPage.BcmcCardTypeIconNotSelected with data-testid "bcmc-container" is displayed
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      And with user "user" and password "password" I complete 3DS1 payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 10 seconds

    @tms:UTR-10358 @Mobile
    Examples:
      | locale | langCode |
      | be     | default  |

    @tms:UTR-10520
    Examples:
      | locale | langCode |
      | be     | FR       |

  #Test is using CreditCard form with Bancontact card in order to trigger Cancelled response using the card name
  @FullRegression
  @Desktop
  @Chrome @Translation @Lokalise
  @UnifiedCheckout @Payment @Bancontact @Negative @P2 @PaymentPage
  Scenario Outline: Bancontact - As guest I can't pay with Bancontact if the details are wrong
    Given I am guest on locale <locale> of langCode <langCode> with express delivery method on the payment page
      And I wait until Checkout.PaymentPage.BancontactButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 4871 0499 9999 9910 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | CANCELLED           |
      | lastName   |                     |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll in mobile view and click on to Checkout.PaymentPage.PlaceOrderButton
      # And with user "user" and password "password" I complete 3DS1 payment
      And I get translation from lokalise for "TechnicalError" and store it with key #BanContactCancelledError
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#BanContactCancelledError"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed in 10 seconds

    @tms:UTR-10357
    Examples:
      | locale | langCode |
      | be     | default  |

    @tms:UTR-10521 @Mobile
    Examples:
      | locale | langCode |
      | be     | FR       |

  # @FullRegression
  # @Desktop
  # @Chrome
  # @UnifiedCheckout @Payment @Bancontact @Negative @P2 @PaymentPage
  # Scenario Outline: Bancontact - As guest I place order with Bancontact and receive Pending message
  #   Given I am guest on locale <locale> of langCode <langCode> with express delivery method on the payment page
  #     And I wait until Checkout.PaymentPage.BancontactButton is clickable
  #     And I click on Checkout.PaymentPage.CreditCardButton
  #     And in payment page I fill in the credit card details
  #     | name       | value               |
  #     | cardNumber | 4871 0499 9999 9910 |
  #     | cvv        | 737                 |
  #     | year       | 2030                |
  #     | month      | 03                  |
  #     | firstName  | PENDING             |
  #     | lastName   |                     |
  #     And I see Checkout.PaymentPage.VisaCardTypeIcon with data-testid "scheme-container" is enabled
  #     And I set T&C checkbox to true if XCOMREG is enabled
  #     And I click on Checkout.PaymentPage.PlaceOrderButton
  #   Then URL should contain "validate" within 15 seconds
  #     And with user "user" and password "password" I complete 3DS1 payment
  #     And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 10 seconds
  #     And I see Checkout.OrderConfirmationPage.ConfirmationDetailsMessage contains text "<Confirmation>"

  #   @tms:UTR-10356
  #   Examples:
  #     | locale | langCode | Confirmation                                                     |
  #     | be     | default  | Zodra uw bestelling is bevestigd, ontvangt u bericht via e-mail. |

  #   @tms:UTR-10522
  #   Examples:
  #     | locale | langCode | Confirmation                                               |
  #     | be     | FR       | Vous recevrez un e-mail une fois votre commande confirmée. |


  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @GiftCard @Payment @PaymentPage @HappyFlow @GiftCardPurchase @ExcludeUat
  Scenario Outline: Bancontact - As a guest I can purchase multiple giftcards using Bancontact
    Given I am on locale <locale> of url /<giftCardUrl> of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 2
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 3
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 3 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      And I wait until Checkout.SignInPage.PaypalExpressButton is clickable
      And I type to following inputs
      | element                              | value                    |
      | Checkout.ShippingPage.EmailInput     | pvh.sap_user@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                  |
      | Checkout.ShippingPage.LastNameInput  | Testovich                |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    # And I store the cartId
    When I click on Checkout.PaymentPage.BancontactButton
      And in payment page I fill in the Bancontact details
      | name       | value               |
      | cardNumber | 4871 0499 9999 9910 |
      | year       | 2030                |
      | month      | 03                  |
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
      And I add giftCardFirst billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And with user "user" and password "password" I complete 3DS1 payment
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber

    @ExcludeTH @tms:UTR-17247 @Mobile 
    Examples:
      | locale | langCode | giftCardUrl |
      | be     | default  | gift-cards  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @GiftCard @Payment @PaymentPage @HappyFlow @GiftCardPurchase @ExcludeUat
  Scenario Outline: Bancontact - As a user I can purchase multiple giftcards using Bancontact
    Given I am on locale <locale> of url /<giftCardUrl> of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 2
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 3
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 3 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      And I wait until Checkout.SignInPage.PaypalExpressButton is clickable
      And I wait until Checkout.SignInPage.SignInButton is clickable
      And I click on Checkout.SignInPage.SignInButton
      And I sign in with user "pvh.sap_user@outlook.com" and password "AutoNation2023"
      And I type to following inputs
      | element                              | value     |
      | Checkout.ShippingPage.FirstNameInput | Testing   |
      | Checkout.ShippingPage.LastNameInput  | Testovich |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    # And I store the cartId
    When I click on Checkout.PaymentPage.BancontactButton
      And in payment page I fill in the Bancontact details
      | name       | value               |
      | cardNumber | 4871 0499 9999 9910 |
      | year       | 2030                |
      | month      | 03                  |
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      And with user "user" and password "password" I complete 3DS1 payment
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber

    @ExcludeTH @tms:UTR-17248 
    Examples:
      | locale | langCode | giftCardUrl    |
      | be     | FR       | cartes-cadeaux |
