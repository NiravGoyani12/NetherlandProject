Feature: Unified Checkout - Payment Methods - Gift Card - Redemption

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @GiftCard @HappyFlow @Negative @feature:EED-15223
  Scenario Outline: Payment Methods - As guest/user I can see for invalid gift card details shows errors
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 40 and 100 and inventory between 200 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product items product1#skuPartNumber with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I store the cartId
      And as a guest I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
    Then I wait until Checkout.PaymentPage.GiftCardButton is clickable in 10 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
    When I click on Checkout.PaymentPage.GiftCardButton
      And in payment page I fill in the gift card details
      | element    | value         |
      | cardNumber | <cardNumber>  |
      | pin        | <securityPin> |
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I see Checkout.PaymentPage.ErrorNotification is not displayed
      And I click on Payments.GiftCardPage.ApplyGiftCardButton
      And I wait until Payments.GiftCardPage.GiftCardNumberFieldError is clickable
    Then I see Payments.GiftCardPage.GiftCardNumberFieldError contains text "<GiftCardErrorMessage>"
      And I see Payments.GiftCardPage.GiftSecurityFieldError contains text "<SecurityPinErrorMessage>"

    @tms:UTR-16934 @ExcludeUat
    Examples:
      | locale | langCode | userType | cardNumber | securityPin | GiftCardErrorMessage           | SecurityPinErrorMessage           |
      | at     | default  | guest    |            |             | Geben Sie die Kartennummer ein | Geben Sie den Sicherheitscode ein |

    @tms:UTR-16935 @ExcludeUat
    Examples:
      | locale | langCode | userType  | cardNumber | securityPin | GiftCardErrorMessage                        | SecurityPinErrorMessage                         |
      | at     | default  | logged in | 123456     | 12          | Geben Sie die vollständige Kartennummer ein | Geben Sie den vollständigen Sicherheitscode ein |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @GiftCard @HappyFlow @feature:EED-15223
  Scenario Outline: Payment Methods - As guest/user I can see GC balance details after redeeming it as a only payment
    Given I am on locale <locale> of url /geschenkgutscheine of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 2
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      And I type to following inputs
      | element                              | value                         |
      | Checkout.ShippingPage.EmailInput     | pvh.nl.automation@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                       |
      | Checkout.ShippingPage.LastNameInput  | Testovich                     |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
      And I add giftCardFirst billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
      And I click on Checkout.PaymentPage.PaypalButton
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product item <EanNumber> with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a guest I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.GiftCardButton is clickable in 10 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I fetch an gift-card number and pin from email <giftCardEmailSubject> using gift-card order as #orderNumber to redeem it
      And I click on Payments.GiftCardPage.ApplyGiftCardButton
      And I wait for 2 seconds
      And I wait until Payments.GiftCardPage.GiftCardOnlyBalance with index 1 is clickable
      And I wait until Payments.GiftCardPage.KlarnaPaymentDisabled is displayed
      And I wait until Payments.GiftCardPage.PayPalPaymentDisabled is displayed
      And I wait until Payments.GiftCardPage.RemoveGiftCardButton is displayed
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    Then I see Payments.GiftCardPage.GiftCardOnlyBalance with index 1 contains text "Guthaben der Geschenkkarte"
      And I see Payments.GiftCardPage.GiftCardOnlyBalance with index 2 contains text "50,00 €"
      And I see Payments.GiftCardPage.GiftCardSufficientBalanceTitle contains text "Ihre Geschenkkarte wurde erfolgreich angewendet."
      And I see Payments.GiftCardPage.GiftCardRemainingBalance with index 2 contains text "<remaningBalance>"
      And I scroll to the element Checkout.PaymentPage.PlaceOrderButton contains text "Bezahlen Sie mit Geschenkkarte"

    @tms:UTR-16936 @ExcludeCK @ExcludeUat
    Examples:
      | locale | langCode | userType | card                | cvv | EanNumber     | remaningBalance | giftCardEmailSubject               |
      | at     | default  | guest    | 4917 6100 0000 0000 | 737 | 8719254145482 | 1,15 €          | Tommy Hilfiger Geschenkgutschein - |

    @tms:UTR-16937 @ExcludeTH @ExcludeUat
    Examples:
      | locale | langCode | userType | card                | cvv | EanNumber     | remaningBalance | giftCardEmailSubject   |
      | at     | default  | guest    | 4917 6100 0000 0000 | 737 | 5051145283365 | 2,15 €          | CK Geschenkgutschein - |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @GiftCard @HappyFlow @feature:EED-15223
  Scenario Outline: Payment Methods - As guest/user I can see GC balance details after redeeming it, except creditcard rest of payments are disabled
    Given I am on locale <locale> of url /geschenkgutscheine of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 2
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      And I type to following inputs
      | element                              | value                         |
      | Checkout.ShippingPage.EmailInput     | pvh.nl.automation@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                       |
      | Checkout.ShippingPage.LastNameInput  | Testovich                     |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
      And I add giftCardFirst billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
      And I click on Checkout.PaymentPage.PaypalButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 3 units for product item <EanNumber> with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And as a guest I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.GiftCardButton is clickable in 10 seconds
    When I click on Checkout.OverviewPanel.EnterPromoCodeButton
      And I wait until Checkout.OverviewPanel.PromoCodeField is clickable
      And I wait until Checkout.OverviewPanel.PromoCodeField is in viewport
      And I type "<promoCode>" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Checkout.OverviewPanel.PromoCodeApplyButton
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I fetch an gift-card number and pin from email <giftCardEmailSubject> using gift-card order as #orderNumber to redeem it
      And I click on Payments.GiftCardPage.ApplyGiftCardButton
      And I wait until Payments.GiftCardPage.KlarnaPaymentDisabled is displayed
      And I wait until Payments.GiftCardPage.PayPalPaymentDisabled is displayed
      And I wait until Payments.GiftCardPage.RemoveGiftCardButton is displayed
      And I wait until Payments.GiftCardPage.CreditCardPaymentDisabled is not displayed
    Then I see Payments.GiftCardPage.GiftCardInSufficientBalanceTitle contains text "Ihre Geschenkkarte wurde erfolgreich angewendet. Bitte wählen Sie eine andere Zahlungsmethode für die verbleibenden"
      And I see Payments.GiftCardPage.GiftCardBalanceDetailsWithSplit with index 1 contains text "Guthaben der Geschenkkarte"
      And I see Payments.GiftCardPage.GiftCardBalanceDetailsWithSplit with index 2 contains text "50,00 €"
      And I see Payments.GiftCardPage.GiftCardInSufficientBalanceTitle contains text "<remaningBalance>"

    @tms:UTR-16938 @ExcludeCK @ExcludeUat
    Examples:
      | locale | langCode | userType | EanNumber     | remaningBalance | giftCardEmailSubject               | promoCode    |
      | at     | default  | guest    | 8719254146793 | 3,73 €          | Tommy Hilfiger Geschenkgutschein - | THAUTOMATION |

    @tms:UTR-16939 @ExcludeTH @ExcludeUat
    Examples:
      | locale | langCode | userType | EanNumber     | remaningBalance | giftCardEmailSubject   | promoCode    |
      | at     | default  | guest    | 8718571438895 | 84,73 €         | CK Geschenkgutschein - | CKAUTOMATION |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @GiftCard @HappyFlow @Negative @feature:EED-15223
  Scenario Outline: Payment Methods - As guest/user I can remove applied GC as payment option and choose paypal payment method
    Given I am on locale <locale> of url /geschenkgutscheine of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 2
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      And I type to following inputs
      | element                              | value                         |
      | Checkout.ShippingPage.EmailInput     | pvh.nl.automation@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                       |
      | Checkout.ShippingPage.LastNameInput  | Testovich                     |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
      And I add giftCardFirst billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
      And I click on Checkout.PaymentPage.PaypalButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 3 units for product item <EanNumber> with forced accepted cookies
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as <userType> to shipping page
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.GiftCardButton is clickable in 10 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I fetch an gift-card number and pin from email <giftCardEmailSubject> using gift-card order as #orderNumber to redeem it
      And I click on Payments.GiftCardPage.ApplyGiftCardButton
      And I wait until Payments.GiftCardPage.PayPalPaymentDisabled is displayed
      And I wait until Payments.GiftCardPage.RemoveGiftCardButton is displayed
      And I wait until Payments.GiftCardPage.CreditCardPaymentDisabled is not displayed
      And I click on Payments.GiftCardPage.ApplyGiftCardButton is clickable
      And I wait for 2 seconds
      And I wait until Payments.GiftCardPage.RemoveGiftCardButton is clickable
      And I click on Payments.GiftCardPage.RemoveGiftCardButton
      And I wait for 2 seconds
    Then I wait until Checkout.PaymentPage.PaypalButton is clickable
      And I wait until Payments.GiftCardPage.KlarnaPaymentDisabled is not displayed
      And I wait until Payments.GiftCardPage.PayPalPaymentDisabled is not displayed
      And I wait until Payments.GiftCardPage.CreditCardPaymentDisabled is not displayed
    When I click on Checkout.PaymentPage.PaypalButton
      And I wait until Checkout.PaymentPage.PayWithPayPal is clickable
      And I set T&C checkbox to true if XCOMREG is enabled
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @tms:UTR-16940 @ExcludeCK @ExcludeUat
    Examples:
      | locale | langCode | userType | EanNumber     | giftCardEmailSubject               |
      | at     | default  | guest    | 8719254146793 | Tommy Hilfiger Geschenkgutschein - |

    @tms:UTR-16939 @ExcludeTH @ExcludeUat
    Examples:
      | locale | langCode | userType | EanNumber     | giftCardEmailSubject   |
      | at     | default  | guest    | 8718571438895 | CK Geschenkgutschein - |


  # @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @Payment @GiftCard @HappyFlow @Negative @feature:EED-15223
  Scenario Outline: Payment Methods - As guest/user when i refresh the page or returning back tp payment page GC is cleared off
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 30 and 100 and inventory between 200 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product items product1#skuPartNumber with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I store the cartId
      And as a guest I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
    Then I wait until Checkout.PaymentPage.GiftCardButton is clickable in 10 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.GiftCardButton
      And in payment page I fill in the gift card details
      | element    | value         |
      | cardNumber | <cardNumber>  |
      | pin        | <securityPin> |
      And I click on Payments.GiftCardPage.ApplyGiftCardButton is clickable
    When I refresh page
      And I wait until Checkout.PaymentPage.GiftCardButton is clickable
    Then I wait until Payments.GiftCardPage.RemoveGiftCardButton is not displayed
      And I click on Checkout.PaymentPage.GiftCardButton
      And in payment page I fill in the gift card details
      | element    | value         |
      | cardNumber | <cardNumber>  |
      | pin        | <securityPin> |
      And I click on Payments.GiftCardPage.ApplyGiftCardButton is clickable
    When I navigate back in the browser
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.GiftCardButton is clickable
    Then I wait until Payments.GiftCardPage.RemoveGiftCardButton is not displayed

    @tms:UTR-16941 @ExcludeUat
    Examples:
      | locale | langCode | userType | cardNumber          | securityPin |
      | fi     | default  | guest    | 6036280000000000000 | 1234        |
