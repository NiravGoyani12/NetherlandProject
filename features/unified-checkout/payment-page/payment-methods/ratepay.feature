Feature: Unified Checkout - Payment Methods - Ratepay

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @DeliveryMethods @Payment @Ratepay @HappyFlow
  Scenario Outline: Ratepay - As guest I can pay by payment on invoice (Ratepay) with standard delivery
    Given I am guest on locale <locale> of langCode default with standard delivery method on the payment page
      And I store the cartId
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I click on Checkout.PaymentPage.RatepayButton
      And I set attribute type of element Checkout.PaymentPage.BirthdayDayDate to "text"
      And I type to following inputs
      | element                               | value      |
      | Checkout.PaymentPage.PhoneNumberInput | 7865321321 |
      | Checkout.PaymentPage.BirthdayDayDate  | 09092000   |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10587 @Mobile
    Examples:
      | locale |
      | de     |

    @tms:UTR-10588
    Examples:
      | locale |
      | at     |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @Payment @UPSAP @Ratepay @HappyFlow
  Scenario Outline: Ratepay - As guest I can pay by payment on invoice (Ratepay) with UPS AP delivery method
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I wait until Checkout.ShippingPage.PickupTabButton is clickable
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
      And I click on Checkout.PaymentPage.RatepayButton
      And I set attribute type of element Checkout.PaymentPage.BirthdayDayDate to "text"
      And I type to following inputs
      | element                               | value      |
      | Checkout.PaymentPage.PhoneNumberInput | 7865321321 |
      | Checkout.PaymentPage.BirthdayDayDate  | 09092000   |
      And I add other billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10590
    Examples:
      | locale | langCode | userType |
      | at     | default  | guest    |

    # @tms:UTR-10589
    # Examples:
    #   | locale | langCode | userType  |
    #   | de     | default  | logged in |

    @tms:UTR-14838 @Mobile @P1
    Examples:
      | locale | langCode | userType  |
      | de     | EN       | logged in |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @DeliveryMethods @Payment @CollectInStore @Ratepay @HappyFlow
  Scenario Outline: Ratepay - As guest I can pay by payment on invoice (Ratepay) with Collect in Store delivery method
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I wait until Checkout.ShippingPage.PickupTabButton is clickable
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
      And I click on Checkout.PaymentPage.RatepayButton
      And I set attribute type of element Checkout.PaymentPage.BirthdayDayDate to "text"
      And I type to following inputs
      | element                               | value      |
      | Checkout.PaymentPage.PhoneNumberInput | 7865321321 |
      | Checkout.PaymentPage.BirthdayDayDate  | 09092000   |
      And I add other billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    # @tms:UTR-10591
    # Examples:
    #   | locale | langCode | userType |
    #   | de     | default  | guest    |

    @tms:UTR-10592 @Mobile
    Examples:
      | locale | langCode | userType  |
      | at     | default  | logged in |

    @tms:UTR-14839
    Examples:
      | locale | langCode | userType |
      | de     | EN       | guest    |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @Payment @PaymentPage @P2 @Ratepay
  Scenario Outline: Ratepay - As guest I get an error if the total amount is below payment limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 1 and 14 and inventory between 100 and 9999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a guest user
      And I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product items product1#skuPartNumber
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as guest to shipping page
      And as a guest I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
    When I click on Checkout.PaymentPage.RatepayButton
      And I set attribute type of element Checkout.PaymentPage.BirthdayDayDate to "text"
      And I type to following inputs
      | element                               | value      |
      | Checkout.PaymentPage.PhoneNumberInput | 7865321321 |
      | Checkout.PaymentPage.BirthdayDayDate  | 09092000   |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I get minratepay payment limit for current locale and store it with key #MinPaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#MinPaymentLimit"

    @tms:UTR-10593 @Mobile
    Examples:
      | locale | langCode |
      | de     | default  |

    # @tms:UTR-10594
    # Examples:
    #   | locale | langCode |
    #   | at     | default  |

    # @tms:UTR-10595
    # Examples:
    #   | locale | langCode |
    #   | ch     | default  |

    # @tms:UTR-10596
    # Examples:
    #   | locale | langCode |
    #   | ch     | FR       |

    # @tms:UTR-10597
    # Examples:
    #   | locale | langCode |
    #   | ch     | IT       |

    @tms:UTR-14840 @Mobile
    Examples:
      | locale | langCode |
      | de     | EN       |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @Payment @P2 @PaymentPage @Ratepay
  Scenario Outline: Ratepay - As guest I get an error if the total amount is above payment limit
    Given I am on locale <locale> shopping bag page with 80 units for product item <EanNumber> with forced accepted cookies
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as guest to shipping page
      And as a guest I add first delivery details
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
    When I click on Checkout.PaymentPage.RatepayButton
      And I set attribute type of element Checkout.PaymentPage.BirthdayDayDate to "text"
      And I type to following inputs
      | element                               | value      |
      | Checkout.PaymentPage.PhoneNumberInput | 7865321321 |
      | Checkout.PaymentPage.BirthdayDayDate  | 09092000   |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I get ratepay payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 3 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#PaymentLimit"

    @tms:UTR-10598 @ExcludeCK @Mobile
    Examples:
      | locale | langCode | EanNumber     |
      | de     | default  | 8718941982669 |

    @tms:UTR-10599 @ExcludeTH
    Examples:
      | locale | langCode | EanNumber     |
      | at     | default  | 8719114077151 |

    # @tms:UTR-10600
    # Examples:
    #   | locale | langCode |EanNumber     |
    #   | ch     | FR       |8718941982669|

    @tms:UTR-14841 @ExcludeTH
    Examples:
      | locale | langCode | EanNumber     |
      | de     | EN       | 8719114077151 |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @Payment @P2 @PaymentPage @Ratepay
  Scenario Outline: Ratepay - As a user I get an error if the total amount is above payment limit
    Given I am on locale <locale> shopping bag page with 80 units for product item <EanNumber> with forced accepted cookies
      And I am a logged in user
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a logged in I add first delivery details
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
    When I click on Checkout.PaymentPage.RatepayButton
      And I set attribute type of element Checkout.PaymentPage.BirthdayDayDate to "text"
      And I type to following inputs
      | element                               | value      |
      | Checkout.PaymentPage.PhoneNumberInput | 7865321321 |
      | Checkout.PaymentPage.BirthdayDayDate  | 09092000   |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I get ratepay payment limit for current locale and store it with key #PaymentLimit
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 3 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#PaymentLimit"

    @tms:UTR-10601 @ExcludeCK
    Examples:
      | locale | langCode | EanNumber     |
      | at     | default  | 8718941982669 |

    @tms:UTR-10602 @ExcludeTH @Mobile
    Examples:
      | locale | langCode | EanNumber     |
      | ch     | IT       | 8719114077151 |

  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @Payment @PaymentPage @Ratepay @P2
  Scenario Outline: Ratepay - As guest I get an error if the user is too young of age
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
      And I click on Checkout.PaymentPage.RatepayButton
      And I type "11112015" in the field Checkout.PaymentPage.BirthdayDayDate
      And I type "0123049538453" in the field Checkout.PaymentPage.PhoneNumberInput
      And I see Checkout.PaymentPage.BirthdateError contains text "<Error>"

    @tms:UTR-10603 @Mobile
    Examples:
      | locale | langCode | Error                                                                            |
      | de     | default  | Um dieses Zahlungsmittel nutzen zu können, musst du mindestens 18 Jahre alt sein |

    # @tms:UTR-10604
    # Examples:
    #   | locale | langCode | Error                                                                            |
    #   | at     | default  | Um dieses Zahlungsmittel nutzen zu können, musst du mindestens 18 Jahre alt sein |

    # @tms:UTR-10605
    # Examples:
    #   | locale | langCode | Error                                                                            |
    #   | ch     | default  | Um dieses Zahlungsmittel nutzen zu können, musst du mindestens 18 Jahre alt sein |

    @tms:UTR-10606 @Mobile
    Examples:
      | locale | langCode | Error                                                              |
      | ch     | FR       | Vous devez avoir au moins 18 ans pour utiliser ce mode de paiement |

    @tms:UTR-10607
    Examples:
      | locale | langCode | Error                                                               |
      | ch     | IT       | Devi avere almeno 18 anni per utilizzare questo metodo di pagamento |

    @tms:UTR-14842
    Examples:
      | locale | langCode | Error                                                        |
      | de     | EN       | You have to be 18 years or older to use this payment method. |


  @FullRegression
  @Desktop
  @Chrome @Safari @Firefox @Translation
  @UnifiedCheckout @Payment @Negative @Ratepay @PaymentPage @P2
  Scenario Outline: Ratepay - As guest I get an error when trying to place order within the specific scenario
    Given I am guest on locale <locale> of langCode <langCode> on the shipping page
      And I store the cartId
      And I type to following inputs
      | element                              | value       |
      | Checkout.ShippingPage.FirstNameInput | <FirstName> |
      | Checkout.ShippingPage.LastNameInput  | Ablehnung   |
      | Checkout.ShippingPage.Address1Input  | add1        |
      | Checkout.ShippingPage.CityInput      | Testhausen  |
      | Checkout.ShippingPage.PostcodeInput  | #POSTCODE   |
      | Checkout.ShippingPage.StateInput     | #STATE      |
      | Checkout.ShippingPage.EmailInput     | <Email>     |
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
    When I click on Checkout.PaymentPage.RatepayButton
      And I set attribute type of element Checkout.PaymentPage.BirthdayDayDate to "text"
      And I type to following inputs
      | element                               | value      |
      | Checkout.PaymentPage.PhoneNumberInput | 7865321321 |
      | Checkout.PaymentPage.BirthdayDayDate  | 09092000   |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I get translation for "<Error>" and store it with key #RatepayError
    Then I see Checkout.PaymentPage.PaymentErrorMessage is displayed in 3 seconds
      And I see Checkout.PaymentPage.PaymentErrorMessage contains text "#RatepayError"

    @tms:UTR-10608 @Mobile
    Examples:
      | locale | langCode | FirstName | Email                   | Error                |
      | de     | default  | Buyer     | BuyerIdentity@email.com | RatepayIdentityError |

    @tms:UTR-14843
    Examples:
      | locale | langCode | FirstName | Email                   | Error                |
      | de     | EN       | Buyer     | BuyerIdentity@email.com | RatepayIdentityError |

    @tms:UTR-10609
    Examples:
      | locale | langCode | FirstName | Email                      | Error                |
      | de     | default  | Payment   | PaymentAttribute@email.com | RatepayPurchaseError |

    # @tms:UTR-10610
    # Examples:
    #   | locale | langCode | FirstName | Email                     | Error                |
    #   | de     | EN       | Risk      | TransactionRisk@email.com | RatepayPurchaseError |

    @tms:UTR-10611
    Examples:
      | locale | langCode | FirstName | Email                          | Error                |
      | de     | EN       | Gabor     | RequestNotSuccessful@email.com | RatepayPurchaseError |

    @tms:UTR-10612
    Examples:
      | locale | langCode | FirstName | Email                   | Error                |
      | at     | default  | Buyer     | BuyerIdentity@email.com | RatepayIdentityError |

  # @tms:UTR-10613
  # Examples:
  #   | locale | langCode | FirstName | Email                      | Error                |
  #   | at     | default  | Payment   | PaymentAttribute@email.com | RatepayPurchaseError |

  # @tms:UTR-10614
  # Examples:
  #   | locale | langCode | FirstName | Email                     | Error                |
  #   | at     | default  | Risk      | TransactionRisk@email.com | RatepayPurchaseError |

  # @tms:UTR-10615
  # Examples:
  #   | locale | langCode | FirstName | Email                          | Error                |
  #   | at     | default  | Gabor     | RequestNotSuccessful@email.com | RatepayPurchaseError |

  # @tms:UTR-10616
  # Examples:
  #   | locale | langCode | FirstName | Email                   | Error                |
  #   | ch     | default  | Buyer     | BuyerIdentity@email.com | RatepayIdentityError |

  # @tms:UTR-10617
  # Examples:
  #   | locale | langCode | FirstName | Email                      | Error                |
  #   | ch     | default  | Payment   | PaymentAttribute@email.com | RatepayPurchaseError |

  # @tms:UTR-10618 @Mobile
  # Examples:
  #   | locale | langCode | FirstName | Email                     | Error                |
  #   | ch     | FR       | Risk      | TransactionRisk@email.com | RatepayPurchaseError |

  # @tms:UTR-10619
  # Examples:
  #   | locale | langCode | FirstName | Email                          | Error                |
  #   | ch     | IT       | Gabor     | RequestNotSuccessful@email.com | RatepayPurchaseError |


  @FullRegression
  @Desktop
  @Chrome
  @UnifiedCheckout @Payment @PaymentPage @Ratepay @P2
  Scenario Outline: Ratepay - As guest I get an error if the fields are invalid after correcting with valid data order placing should be possible
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
      And I wait until the current page is loaded
    Then I expect at least 1 network request named payments/methods of type fetch to be processed in 10 seconds
      And I wait until Checkout.PaymentPage.RatepayButton is clickable
      And I click on Checkout.PaymentPage.RatepayButton
      And I type "11112015" in the field Checkout.PaymentPage.BirthdayDayDate
      And I type "0123049538453" in the field Checkout.PaymentPage.PhoneNumberInput
      And I see Checkout.PaymentPage.BirthdateError contains text "<Error>"
      And I type "11112000" in the empty field Checkout.PaymentPage.BirthdayDayDate
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-13462 @Mobile
    Examples:
      | locale | langCode | Error                                                                            |
      | de     | default  | Um dieses Zahlungsmittel nutzen zu können, musst du mindestens 18 Jahre alt sein |

# @tms:UTR-13463
# Examples:
#   | locale | langCode | Error                                                                            |
#   | at     | default  | Um dieses Zahlungsmittel nutzen zu können, musst du mindestens 18 Jahre alt sein |