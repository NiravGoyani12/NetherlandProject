Feature: Unified Checkout - Payment Methods - PayPal Express

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @PayPalExpress @Negative @P3
  Scenario Outline: Paypal - I can't pay with paypal express when total price is more than the max limit
    Given I am on locale <locale> of langCode <langCode> with 50 products on shipping page
      And I store the cartId
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I select paypal express and get to paypal login
      And I get paypal payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.SignInPage.PaypalExpressErrorMessage is displayed in 5 seconds
      And I see Checkout.SignInPage.PaypalExpressErrorMessage contains text "#PaymentLimit"

    @tms:UTR-10366
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10557 @Mobile
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation
  @UnifiedCheckout @PaymentPage @Payment @PayPalExpress @Negative @P2
  Scenario Outline: Paypal - I am returned to sign in page with error when I chose a different country in paypal
    Given I am on locale <locale> of langCode <langCode> with 4 products on shipping page
      And I store the cartId
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I select paypal express and get to paypal login
      And in paypal I complete payment for locale nl
      And I switch to 1st browser tab
      And I get translation for "PaypalWrongAddressError" and store it with key #DifferentAddress
    Then I see Checkout.SignInPage.PaypalExpressErrorMessage is displayed in 10 seconds
      And I see Checkout.SignInPage.PaypalExpressErrorMessage contains text "#DifferentAddress"

    @tms:UTR-10364 @Mobile
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10558
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @PayPalExpress @Negative @P2
  Scenario Outline: Paypal - I am returned to sign in page with error when I cancel paypal express payment
    Given I am on locale <locale> of langCode <langCode> with 5 products on shipping page
      And I store the cartId
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I select paypal express and get to paypal login
    When in paypal I cancel payment
    Then I see Checkout.SignInPage.PaypalExpressErrorMessage is not displayed in 10 seconds
      And I see URL should contain "/checkout/shipping"

    @tms:UTR-10368 @Mobile
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10559
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @PayPalExpress @Negative @P2
  Scenario Outline: Paypal - I am returned to sign in page with no error when I close paypal express modal
    Given I am on locale <locale> of langCode <langCode> with 1 products on shipping page
      And I store the cartId
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I click on Checkout.SignInPage.PaypalExpressButton
    When I click on Checkout.SignInPage.PaypalExpressCloseButton in 5 seconds
    Then I see Checkout.SignInPage.PaypalExpressErrorMessage is not displayed in 5 seconds
      And I wait until Checkout.SignInPage.PaypalExpressButton is clickable

    @tms:UTR-10367 @Mobile
    Examples:
      | locale | langCode |
      | ch     | IT       |

    @tms:UTR-10555
    Examples:
      | locale | langCode |
      | es     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @PayPalExpress @Negative @P2
  Scenario Outline: Paypal - I am returned to sign in page with no error when I navigate back from paypal express modal
    Given I am on locale <locale> of langCode <langCode> with 1 products on shipping page
      And I store the cartId
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I select paypal express and get to paypal login
    When I navigate back in the browser
    Then I see Checkout.SignInPage.PaypalExpressErrorMessage is not displayed in 10 seconds
      And I wait until Checkout.SignInPage.PaypalExpressButton is clickable
    Then URL should contain "checkout/shipping"
    Then URL should contain "<langCode>"

    # @tms:UTR-10363 @Mobile
    # Examples:
    #   | locale | langCode |
    #   | sk     | default  |

    @tms:UTR-10556 @Mobile
    Examples:
      | locale | langCode |
      | be     | FR       |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShoppingBagPage @Payment @PayPalExpress @Negative @P2
  Scenario Outline: Paypal - I am unable to proceed further to Paypal if the checkbox is unchecked from Shopping Bag page
    Given I am guest on locale <locale> of langCode <langCode> with 1 unit of any product on shopping bag page
      And I store the cartId
    When I click on Experience.ShoppingBag.CheckoutWithPaypalButton
      And I see the checkbox Experience.ShoppingBag.PaypalTermsAndConditionCheckBox is unchecked
      And I click on Experience.ShoppingBag.PaypalTermsAndConditionCheckoutButton
    Then URL should not contain "paypal" in 10 seconds
      And I see Experience.ShoppingBag.PaypalTermsAndConditionCheckoutButton is clickable

    @tms:UTR-13399
    Examples:
      | locale | langCode |
      | pt     | default  |

    @tms:UTR-13400
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @SignInPage @Payment @PayPalExpress @Negative @P2
  Scenario Outline: Paypal - I am unable to proceed further to Paypal if the checkbox is unchecked from Shipping page
    Given I am guest on locale <locale> of langCode <langCode> with 1 unit of any product on shopping bag page
      And I store the cartId
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
    Then I wait until the current page is loaded
    Then I click on Checkout.OPCSignInPage.PayPalExpressButton
      And I see the checkbox Checkout.OPCSignInPage.PaypalExpressTermsCheckbox is unchecked
      And I see Payments.PaypalExpressPage.PaypalTermsConditionsComponentContent contains text "En cliquant sur « Payer avec PayPal », j’accepte les"
      And I click on Checkout.OPCSignInPage.PayWithPaypalExpressButton
    Then URL should not contain "paypal" in 10 seconds
      And I see Checkout.OPCSignInPage.PayWithPaypalExpressButton is clickable

    @tms:UTR-13411
    Examples:
      | locale | langCode |
      | fr     | default  |

    @tms:UTR-13412
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @SignInPage @Payment @PayPalExpress @Negative @P2
  Scenario Outline: Paypal - I am unable to proceed further to Paypal Express if selecting a pickup point due to it being grayed out
    Given I am guest on locale <locale> of langCode <langCode> with 1 unit of any product on shopping bag page
      And I store the cartId
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
    Then I wait until the current page is loaded
    When I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
    Then I click on Checkout.OPCSignInPage.PayPalExpressButton
      And I get translation from lokalise for "PaypalExpressUnavailable" and store it with key #PayPalMessage
      And I see Checkout.SignInPage.PaypalExpressUnavailable contains text "#PayPalMessage"
      And I click on Checkout.SignInPage.PaypalExpressErrorModalClose

    @tms:UTR-13479
    Examples:
      | locale  | langCode |
      | default | default  |

    # @tms:UTR-13480 CIS is disabled
    # Examples:
    #   | locale | langCode |
    #   | be     | FR       |

    @tms:UTR-14837
    Examples:
      | locale | langCode |
      | de     | EN       |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @GiftCard @Payment @PaymentPage @HappyFlow @GiftCardPurchase @CreditCard @3DS2 @ExcludeUat
  Scenario Outline: Paypal Express - As user I can purchase multiple giftcards using Paypal Express
    Given I am on locale <locale> of url /<giftCardUrl> of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 2
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 3
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 3 is displayed
      And I click on Experience.Header.SignInButton
      And I sign in with user "pvh.sap_user@outlook.com" and password "AutoNation2023"
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      # And I store the cartId
      And I wait until Checkout.SignInPage.PaypalExpressButton is clickable
      And I select paypal express and get to paypal login
      And in paypal I complete payment for locale <locale>
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber

    @ExcludeTH @tms:UTR-18029
    Examples:
      | locale | langCode | giftCardUrl    |
      | ch     | FR       | cartes-cadeaux |

  # @ExcludeTH @tms:UTR-18030 @Mobile
  # Examples:
  #   | locale | langCode | userType | giftCardUrl |
  #   | de     | EN       | guest    | gift-cards  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @GiftCard @Payment @PaymentPage @HappyFlow @GiftCardPurchase @CreditCard @3DS2 @ExcludeUat
  Scenario Outline: Paypal Express - As guest/user I can purchase multiple giftcards using Paypal express from mini shopping bag
    Given I am on locale <locale> of url /gift-cards of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on Experience.Header.SignInButton
      And I sign in with user "pvh.sap_user@outlook.com" and password "AutoNation2023"
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I hover over Experience.Header.ShoppingBagButton
      And I wait for 2 seconds
      # And I store the cartId
      And I scroll to the element Experience.MiniShoppingBag.MiniBagPaypalExpress
      And I wait until Experience.MiniShoppingBag.MiniBagPaypalExpress is in viewport
      And I select paypal express and get to paypal login
      And in paypal I complete payment for locale <locale>
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber

    @tms:UTR-18031 @ExcludeCK @Mobile
    Examples:
      | locale | langCode |
      | pt     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @GiftCard @Payment @PaymentPage @HappyFlow @GiftCardPurchase @CreditCard @3DS2 @ExcludeUat
  Scenario Outline: Credit card - As user I can purchase single giftcard by 3DS2 credicard payment
    Given I am on locale <locale> of url /<giftCardUrl> of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on Experience.Header.SignInButton
      And I sign in with user "pvh.sap_user@outlook.com" and password "AutoNation2023"
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
    When I click on Experience.ShoppingBag.StartCheckoutButton
      # And I store the cartId
      And I wait until Checkout.SignInPage.PaypalExpressButton is clickable
      And I select paypal express and get to paypal login
      And in paypal I complete payment for locale <locale>
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber

    @ExcludeCK @tms:UTR-17250
    Examples:
      | locale | langCode | card                | cvv | giftCardUrl        |
      | at     | default  | 4917 6100 0000 0000 | 737 | geschenkgutscheine |