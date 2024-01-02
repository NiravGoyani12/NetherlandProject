Feature: Unified Checkout - Shipping Page - GiftCard

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @PaymentPage @GiftCard @ExcludeUat
  Scenario Outline: GiftCard - Guest user can see all elements on Payment Page for GiftCard
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I am a guest user
      And I wait until the current page is loaded
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                     |
      | Checkout.ShippingPage.LastNameInput  | Testovich                   |
      And I wait for 3 seconds
      And I scroll to and click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
      And I see Checkout.PaymentPage.PersonalDetailsTitle is displayed
    When I get translation from lokalise for "PersonalDetails" and store it with key #persDetailsTitle
    Then I see Checkout.PaymentPage.PersonalDetailsTitle contains text "#persDetailsTitle"
    When I get translation from lokalise for "GCEmailSubtitle" and store it with key #gcEmailSubtitle
    Then I see Checkout.PaymentPage.GCEmailSubtitle contains text "#gcEmailSubtitle"
      And I see Checkout.PaymentPage.DeliveryAddressLine with index 1 contains text "Testing Testovich"
      And I see Checkout.PaymentPage.DeliveryAddressLine with index 2 contains text "pvh.qa.automation@gmail.com"
      And I see Checkout.ShippingPage.EditAddressButton is displayed
      And I see Checkout.PaymentPage.SameAsShippingCheckbox is not displayed

    @tms:UTR-18083
    Examples:
      | locale | langCode | userType |
      | at     | default  | guest    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Translation @Lokalise
  @UnifiedCheckout @PaymentPage @GiftCard @ExcludeUat
  Scenario Outline: GiftCard - Guest user can edit Personal Details form on payment page then cancel the action
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I am a guest user
      And I wait until the current page is loaded
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                     |
      | Checkout.ShippingPage.LastNameInput  | Testovich                   |
      And I wait for 3 seconds
      And I scroll to and click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
      And I see Checkout.PaymentPage.PersonalDetailsTitle is displayed
    When I get translation from lokalise for "PersonalDetails" and store it with key #persDetailsTitle
    Then I see Checkout.PaymentPage.PersonalDetailsTitle contains text "#persDetailsTitle"
    When I get translation from lokalise for "GCEmailSubtitle" and store it with key #gcEmailSubtitle
    Then I see Checkout.PaymentPage.GCEmailSubtitle contains text "#gcEmailSubtitle"
      And I see Checkout.ShippingPage.EditAddressButton is clickable
    Then I click on Checkout.ShippingPage.EditAddressButton
      And I see Checkout.ShippingPage.FirstNameInput is displayed
      And I see Checkout.ShippingPage.LastNameInput is displayed
      And I see Checkout.ShippingPage.EmailInput is displayed
      And I see Checkout.ShippingPage.Address1Input is not displayed
      And I see Checkout.ShippingPage.Address2Input is not displayed
      And I see Checkout.ShippingPage.CityInput is not displayed
      And I see Checkout.ShippingPage.StateInput is not displayed
      And I see Checkout.ShippingPage.PostcodeInput is not displayed
      And I click on Checkout.ShippingPage.ModalCancelAddress
      And I see Checkout.PaymentPage.DeliveryAddressLine with index 1 contains text "Testing Testovich"
      And I see Checkout.PaymentPage.DeliveryAddressLine with index 2 contains text "pvh.qa.automation@gmail.com"
      And I see Checkout.PaymentPage.SameAsShippingCheckbox is not displayed

    @tms:UTR-18084 @issue:EESCK-12874
    Examples:
      | locale | langCode | userType |
      | at     | default  | guest    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Translation @Lokalise
  @UnifiedCheckout @PaymentPage @GiftCard @ExcludeUat
  Scenario Outline: GiftCard - Guest user can edit Personal Details form on payment page
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I am a guest user
      And I wait until the current page is loaded
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                     |
      | Checkout.ShippingPage.LastNameInput  | Testovich                   |
      And I wait for 3 seconds
      And I scroll to and click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
      And I see Checkout.PaymentPage.PersonalDetailsTitle is displayed
    When I get translation from lokalise for "PersonalDetails" and store it with key #persDetailsTitle
    Then I see Checkout.PaymentPage.PersonalDetailsTitle contains text "#persDetailsTitle"
    When I get translation from lokalise for "GCEmailSubtitle" and store it with key #gcEmailSubtitle
    Then I see Checkout.PaymentPage.GCEmailSubtitle contains text "#gcEmailSubtitle"
      And I see Checkout.ShippingPage.EditAddressButton is clickable
    Then I click on Checkout.ShippingPage.EditAddressButton
      And I see Checkout.ShippingPage.FirstNameInput is displayed
      And I see Checkout.ShippingPage.LastNameInput is displayed
      And I see Checkout.ShippingPage.EmailInput is displayed
      And I see Checkout.ShippingPage.Address1Input is not displayed
      And I see Checkout.ShippingPage.Address2Input is not displayed
      And I see Checkout.ShippingPage.CityInput is not displayed
      And I see Checkout.ShippingPage.StateInput is not displayed
      And I see Checkout.ShippingPage.PostcodeInput is not displayed
      And I wait for 2 seconds
      And I type "Tommy" in the empty field Checkout.ShippingPage.FirstNameInput
      And I type "Hilfy" in the empty field Checkout.ShippingPage.LastNameInput
      And I type "pvh.at.automation@gmail.com" in the empty field Checkout.ShippingPage.EmailInput
      And I click on Checkout.ShippingPage.ModalSaveAddress
      And I see Checkout.PaymentPage.DeliveryAddressLine with index 1 contains text "Tommy Hilfy"
      And I see Checkout.PaymentPage.DeliveryAddressLine with index 2 contains text "pvh.at.automation@gmail.com"
      And I see Checkout.PaymentPage.SameAsShippingCheckbox is not displayed

    @tms:UTR-18086 @issue:EESCK-12874
    Examples:
      | locale | langCode | userType |
      | at     | default  | guest    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Translation @Lokalise
  @UnifiedCheckout @PaymentPage @GiftCard @ExcludeUat
  Scenario Outline: GiftCard - Guest user can see the billing information fields displayed on the payment page
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I am a guest user
      And I wait until the current page is loaded
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                     |
      | Checkout.ShippingPage.LastNameInput  | Testovich                   |
      And I wait for 3 seconds
      And I scroll to and click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
      And I see Checkout.PaymentPage.PersonalDetailsTitle is displayed
    When I get translation from lokalise for "PersonalDetails" and store it with key #persDetailsTitle
    Then I see Checkout.PaymentPage.PersonalDetailsTitle contains text "#persDetailsTitle"
    When I get translation from lokalise for "GCEmailSubtitle" and store it with key #gcEmailSubtitle
    Then I see Checkout.PaymentPage.GCEmailSubtitle contains text "#gcEmailSubtitle"
      And I see Checkout.ShippingPage.EditAddressButton is clickable
      And I see Checkout.PaymentPage.SameAsShippingCheckbox is not displayed
      And I see Checkout.PaymentPage.FirstNameInput is displayed
      And I see Checkout.PaymentPage.LastNameInput is displayed
      And I see Checkout.PaymentPage.Address1Input is displayed
      And I see Checkout.PaymentPage.Address2Input is displayed
      And I see Checkout.PaymentPage.CityInput is displayed
      And I see Checkout.PaymentPage.PostcodeInput is displayed

    @tms:UTR-18087
    Examples:
      | locale | langCode | userType |
      | at     | default  | guest    |
