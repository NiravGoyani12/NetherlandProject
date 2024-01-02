Feature: Unified Checkout - Payment Methods - PayPal

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @PayPal @IFrame @MultipleTabs @Promocode @HappyFlow @P2
  Scenario Outline: Paypal - As guest or user I can pay with paypal even after I add a promo code on payment page
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
    When I click on Checkout.OverviewPanel.EnterPromoCodeButton
      And I get checkout search data for "promocode" and store it with key #Promo
      And I type "#Promo" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Checkout.OverviewPanel.PromoCodeApplyButton
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
      And I click on Checkout.PaymentPage.PaypalButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @tms:UTR-10396 @Mobile
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    # @tms:UTR-10528
    # Examples:
    #   | locale  | langCode | userType  |
    #   | default | default  | logged in |

    # @tms:UTR-10527
    # Examples:
    #   | locale           | langCode         | userType |
    #   | multiLangDefault | multiLangDefault | guest    |

    @tms:UTR-10529 @Mobile
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @Payment @PayPal @UPSAP @HappyFlow
  Scenario Outline: Paypal - As a guest or user I can complete an order with UPS Access Point as my delivery method using PayPal
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
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
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I add other billing details
      And I click on Checkout.PaymentPage.PaypalButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @tms:UTR-13153
    Examples:
      | locale | langCode | userType | searchText |
      | de     | default  | guest    | Berlin     |

    @tms:UTR-13154 @Mobile
    Examples:
      | locale | langCode | userType  | searchText |
      | be     | FR       | logged in | 8500       |

    # @tms:UTR-13155
    # Examples:
    #   | locale | langCode | userType | searchText |
    #   | pl     | default  | guest    | Warsaw     |

    @tms:UTR-13158
    Examples:
      | locale | langCode | userType | searchText |
      | fr     | default  | guest    | Paris      |

    @tms:UTR-13159
    Examples:
      | locale | langCode | userType | searchText |
      | it     | default  | guest    | Rome       |

    @tms:UTR-13160
    Examples:
      | locale | langCode | userType  | searchText |
      | at     | default  | logged in | Vienna     |

    @tms:UTR-13161
    Examples:
      | locale | langCode | userType | searchText |
      | se     | default  | guest    | 111 52     |

    @tms:UTR-13162
    Examples:
      | locale | langCode | userType  | searchText |
      | dk     | default  | logged in | Copenhagen |

    # @tms:UTR-13163 @Mobile
    # Examples:
    #   | locale | langCode | userType | searchText |
    #   | nl     | default  | guest    | 1104 EA    |

    @tms:UTR-13164 @issue:EESCK-11092
    Examples:
      | locale | langCode | userType  | searchText |
      | lu     | default  | logged in | Luxembourg |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @Payment @PayPal @CollectInStore @HappyFlow
  Scenario Outline: Paypal - As a guest or user I can complete an order with Collect in Store as my delivery method using PayPal
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
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
      And I wait until Checkout.ShippingPage.ProceedToPayment is enabled
      And I click on Checkout.ShippingPage.ProceedToPayment
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I add other billing details
      And I click on Checkout.PaymentPage.PaypalButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @tms:UTR-13165
    Examples:
      | locale | langCode | userType | searchText |
      | de     | default  | guest    | Berlin     |

    @tms:UTR-13166 @ExcludeCK @Mobile
    Examples:
      | locale | langCode | userType  | searchText |
      | be     | FR       | logged in | 8500       |

    # @tms:UTR-13167
    # Examples:
    #   | locale | langCode | userType | searchText |
    #   | pl     | default  | guest    | Warsaw     |

    @tms:UTR-13168 @ExcludeCK
    Examples:
      | locale | langCode | userType  | searchText |
      | ie     | default  | logged in | Dublin     |

    @tms:UTR-13169 @Mobile
    Examples:
      | locale | langCode | userType  | searchText |
      | uk     | default  | logged in | B11RE      |

    # @tms:UTR-13170
    # Examples:
    #   | locale | langCode | userType | searchText |
    #   | fr     | default  | guest    | Paris      |

    @tms:UTR-13171
    Examples:
      | locale | langCode | userType | searchText |
      | it     | default  | guest    | Rome       |

    @tms:UTR-13172 @ExcludeCK
    Examples:
      | locale | langCode | userType  | searchText |
      | at     | default  | logged in | Vienna     |

    @tms:UTR-13173 @ExcludeCK
    Examples:
      | locale | langCode | userType | searchText |
      | se     | default  | guest    | Stockholm  |

    @tms:UTR-13174 @ExcludeCK
    Examples:
      | locale | langCode | userType  | searchText |
      | dk     | default  | logged in | Copenhagen |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @Payment @PayPal @CollectInStore @HappyFlow
  Scenario Outline: Paypal - As a guest or user I can complete an order with Collect in Store as my delivery method using PayPal
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
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
      And I wait until Checkout.ShippingPage.ProceedToPayment is enabled
      And I click on Checkout.ShippingPage.ProceedToPayment
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I add other billing details
      And I click on Checkout.PaymentPage.PaypalButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @tms:UTR-13175 @Mobile
    Examples:
      | locale | langCode | userType | searchText |
      | nl     | default  | guest    | Amsterdam  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @DeliveryMethods @PayPal @PostNL @HappyFlow
  Scenario: Paypal - As a guest or user I can place order using PostNL as delivery method with PayPal
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
      And I wait until Checkout.ShippingPage.ProceedToPayment is enabled
      And I click on Checkout.ShippingPage.ProceedToPayment
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I add other billing details
      And I click on Checkout.PaymentPage.PaypalButton
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @tms:UTR-13151
    Examples:
      | locale | userType |
      | nl     | guest    |

    @tms:UTR-13152 @Mobile
    Examples:
      | locale | userType  |
      | nl     | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @DeliveryMethods @PayPal @DHL @HappyFlow @P2
  Scenario: Paypal - As a guest or user I can place order using DHL as delivery method with PayPal
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.DHLPackstationRadioButton is displayed
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I wait for 2 seconds
    When I type to following inputs
      | element                                        | value                       |
      | Checkout.ShippingPage.EmailInput               | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput           | Testing                     |
      | Checkout.ShippingPage.LastNameInput            | Testovich                   |
      | Checkout.ShippingPage.DHLPackstationPostnumber | 10179                       |
      | Checkout.ShippingPage.DHLPackstationNumber     | 181                         |
      | Checkout.ShippingPage.PostcodeInput            | 12345                       |
      | Checkout.ShippingPage.CityInput                | Berlin                      |
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
      And I wait until Checkout.ShippingPage.ProceedToPayment is enabled
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I add other billing details
      And I click on Checkout.PaymentPage.PaypalButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @tms:UTR-13149 @Mobile
    Examples:
      | locale | langCode | userType |
      | de     | default  | guest    |

    @tms:UTR-13150
    Examples:
      | locale | langCode | userType  |
      | de     | EN       | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @PayPal @IFrame @MultipleTabs @BillingAddress @P2
  Scenario Outline: Paypal - As guest or user I can pay with paypal after I add a new billing address on payment page
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
    When I add first billing details
      And I click on Checkout.PaymentPage.PaypalButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @tms:UTR-10397
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    # @tms:UTR-10546 @Mobile
    # Examples:
    #   | locale  | langCode | userType  |
    #   | default | default  | logged in |

    # @tms:UTR-10544 @Mobile
    # Examples:
    #   | locale           | langCode         | userType |
    #   | multiLangDefault | multiLangDefault | guest    |

    @tms:UTR-10545
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @PaymentMethods @PayPal @IFrame @Negative @P3
  Scenario Outline: Paypal - As guest I can't pay with paypal when total price is more than the locale maximum limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 200 and 5000 and inventory between 100 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 40 units for product items product1#skuPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as guest to shipping page
      And as a guest I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until the current page is loaded
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
    When I scroll in mobile view and click on to Checkout.PaymentPage.PaypalButton
      And I wait until the current page is loaded
      And I set T&C checkbox to true if XCOMREG is enabled
      And I wait for 2 seconds
      And I click on Checkout.PaymentPage.PayWithPayPal
      And I get paypal payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#PaymentLimit"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed

    @tms:UTR-10547 @Mobile
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10548
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @PaymentMethods @PayPal @IFrame @Negative @P3
  Scenario Outline: Paypal - As user I can't pay with paypal when total price is more than the locale maximum limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 200 and 5000 and inventory between 100 and 9999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I am on locale <locale> shopping bag page of langCode <langCode> with 40 units for product items product1#skuPartNumber
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a logged in I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
    When I click on Checkout.PaymentPage.PaypalButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll to the element Checkout.PaymentPage.PayWithPayPal
      And I wait for 2 seconds
      And I click on Checkout.PaymentPage.PayWithPayPal
      And I get paypal payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 10 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#PaymentLimit"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed

    @tms:UTR-10549
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10550 @Mobile
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @PaymentMethods @PayPal @IFrame @Negative @P2
  Scenario Outline: Paypal - As a user I want to cancel a Paypal payment while in the portal
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
      And I click on Checkout.PaymentPage.PaypalButton
      And I wait until Checkout.PaymentPage.PayWithPayPal is clickable
      And I set T&C checkbox to true if XCOMREG is enabled
      And I select paypal payment and go to paypal layover
    When in paypal I cancel payment
      And I switch to 1st browser tab
    Then I see Checkout.PaymentPage.PaymentErrorMessage is not displayed in 10 seconds
      And URL should contain "/checkout/payment"

    @tms:UTR-10553
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    # @tms:UTR-10551 @Mobile
    # Examples:
    #   | locale  | langCode | userType  |
    #   | default | default  | logged in |

    # @tms:UTR-10554
    # Examples:
    #   | locale           | langCode         | userType |
    #   | multiLangDefault | multiLangDefault | guest    |

    @tms:UTR-10552 @Mobile
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @PayPal @Negative @P2 @ExcludeCK
  Scenario Outline: Paypal - As guest or user I can pay with paypal for different error flows and receive payment error message
    Given I am on locale <locale> shopping bag page for product item <EanNumber> with forced accepted cookies
      And I wait until Experience.ShoppingBag.StartCheckoutButton is clickable
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And as a <userType> I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
    When I click on Checkout.OverviewPanel.EnterPromoCodeButton
      And I type "<promoCodeType>" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Checkout.OverviewPanel.PromoCodeApplyButton
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
      And I click on Checkout.PaymentPage.PaypalButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
    Then I see Checkout.PaymentPage.PaymentErrorMessage is not displayed in 10 seconds
      And URL should contain "/checkout/payment"

    @tms:UTR-13481
    Examples:
      | locale | userType | promoCodeType | EanNumber     |
      | pt     | guest    | PENDING       | 8718941982669 |

    @tms:UTR-14374
    Examples:
      | locale | userType | promoCodeType | EanNumber     |
      | pt     | guest    | REFUSED       | 8718941982669 |

    @tms:UTR-14375
    Examples:
      | locale | userType | promoCodeType | EanNumber     |
      | pt     | guest    | ERROR         | 8718941982669 |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PayPal @HappyFlow
  Scenario Outline: PayPal - As user I can complete payment using northern ireland postcode
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      | Checkout.ShippingPage.Address1Input  | test address                |
      | Checkout.ShippingPage.CityInput      | Liverpool                   |
      | Checkout.ShippingPage.PostcodeInput  | BT1 1BG                     |
      And I wait until Checkout.ShippingPage.ProceedToPayment is enabled
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I see Checkout.PaymentPage.PaypalButton is not displayed
    #   And I set T&C checkbox to true if XCOMREG is enabled
    #   And I select paypal payment and go to paypal layover
    #   And in paypal I complete payment
    #   And I switch to 1st browser tab
    # Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @tms:UTR-14932
    Examples:
      | locale | langCode | userType  |
      | uk     | default  | logged in |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @GiftCard @Payment @PaymentPage @HappyFlow @GiftCardPurchase @CreditCard @3DS2 @ExcludeUat
  Scenario Outline: Paypal - As user I can purchase multiple giftcards using Paypal
    Given I am on locale <locale> of url /gift-cards of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 2
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 3
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 3 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      And I wait until Checkout.SignInPage.SignInButton is clickable
      And I click on Checkout.SignInPage.SignInButton
      And I sign in with user "pvh.sap_user@outlook.com" and password "AutoNation2023"
      And I type to following inputs
      | element                              | value     |
      | Checkout.ShippingPage.FirstNameInput | Testing   |
      | Checkout.ShippingPage.LastNameInput  | Testovich |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      # And I store the cartId
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
      And I click on Checkout.PaymentPage.PaypalButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber

    @tms:UTR-18032 @ExcludeTH @Mobile
    Examples:
      | locale | langCode |
      | dk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @GiftCard @Payment @PaymentPage @HappyFlow @GiftCardPurchase @CreditCard @3DS2 @ExcludeUat
  Scenario Outline: Paypal - As guest I can purchase single giftcard using Paypal
    Given I am on locale <locale> of url /gift-cards of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      And I wait until Checkout.SignInPage.SignInButton is clickable
      And I type to following inputs
      | element                              | value                    |
      | Checkout.ShippingPage.EmailInput     | pvh.sap_user@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                  |
      | Checkout.ShippingPage.LastNameInput  | Testovich                |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      # And I store the cartId
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
      And I click on Checkout.PaymentPage.PaypalButton
      And I add giftCardFirst billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber

    @tms:UTR-18032 @ExcludeTH @Mobile 
    Examples:
      | locale | langCode |
      | se     | default  |