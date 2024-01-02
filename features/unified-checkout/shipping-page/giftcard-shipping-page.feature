Feature: Unified Checkout - Shipping Page - GiftCard

  @FullRegression
  @Desktop
  @Chrome @FireFox @Translation @Lokalise
  @UnifiedCheckout @ShippingPage @GiftCard @ExcludeTH
  Scenario Outline: Gift Card - As a guest I can see/not see the correct elements displayed on the shipping page
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I am a guest user
      And I wait until the current page is loaded
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I see Checkout.PaymentPage.PersonalDetailsTitle is displayed
      And I get translation from lokalise for "PersonalDetails" and store it with key #persDetailsTitle
    Then I see Checkout.PaymentPage.PersonalDetailsTitle contains text "#persDetailsTitle"
      And I see Checkout.ShippingPage.StandardRadioButton is not displayed
      And I see Checkout.ShippingPage.PickupTabButton is not displayed
      And I see Checkout.ShippingPage.EmailInput is displayed
      And I see Checkout.ShippingPage.FirstNameInput is displayed
      And I see Checkout.ShippingPage.LastNameInput is displayed
      And I see Checkout.SignInPage.SignInButton is displayed
      And I see Checkout.ShippingPage.GiftCardBanner is displayed
      And I see Checkout.ShippingPage.NewsletterTandC is displayed
    When I get translation from lokalise for "GiftcardShipMethod" and store it with key #gcShipMeth
      And I see Checkout.OverviewPanel.ShippingMethod contains text "#gcShipMeth"
      And I see Checkout.OverviewPanel.ShippingTime contains text "within 15 - 30 mins"
      And I get translation from lokalise for "GCEmailMessage" and store it with key #gcEmailMessage
    Then I see Checkout.ShippingPage.GiftCardBannerMessage contains text "#gcEmailMessage"

    @tms:UTR-18080
    Examples:
      | locale | langCode |
      | at     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Translation @Lokalise
  @UnifiedCheckout @ShippingPage @GiftCard @ExcludeTH
  Scenario Outline: Gift Card - As a user I can see/not see the correct elements displayed on the shipping page
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
    Then I click on Experience.ShoppingBag.StartCheckoutButton
      And I see Checkout.SignInPage.SignInButton is displayed
      And I click on Checkout.SignInPage.SignInButton
    When I sign in with user "pvh.at.automation@outlook.com" and password "AutoNation2023"
      And I see the attribute value of element Checkout.ShippingPage.EmailInput containing "pvh.at.automation@outlook.com"
      And I see Checkout.ShippingPage.StandardRadioButton is not displayed
      And I see Checkout.ShippingPage.PickupTabButton is not displayed
      And I see Checkout.ShippingPage.GiftCardBanner is displayed
      And I see Checkout.ShippingPage.EmailInput is displayed
      And I see Checkout.ShippingPage.FirstNameInput is displayed
      And I see Checkout.ShippingPage.LastNameInput is displayed
      And I see Checkout.ShippingPage.SelectedDeliveryAddress is not displayed
      And I see Checkout.ShippingPage.NewsletterTandC is displayed
      And I get translation from lokalise for "GiftcardShipMethod" and store it with key #gcShipMeth
    Then I see Checkout.OverviewPanel.ShippingMethod contains text "#gcShipMeth"
      And I see Checkout.OverviewPanel.ShippingTime contains text "within 15 - 30 mins"
    When I get translation from lokalise for "GCEmailMessage" and store it with key #gcEmailMessage
    Then I see Checkout.ShippingPage.GiftCardBannerMessage contains text "#gcEmailMessage"
      And I clear shopping bag for the registered user of this locale

    @tms:UTR-18081
    Examples:
      | locale | langCode |
      | at     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Translation @Lokalise
  @UnifiedCheckout @ShippingPage @GiftCard @ExcludeCK
  Scenario Outline: Gift Card - As a guest I can see/not see the correct elements displayed on the shipping page
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I am a guest user
      And I wait until the current page is loaded
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I see Checkout.PaymentPage.PersonalDetailsTitle is displayed
    When I get translation from lokalise for "PersonalDetails" and store it with key #persDetailsTitle
    Then I see Checkout.PaymentPage.PersonalDetailsTitle contains text "#persDetailsTitle"
    When I get translation from lokalise for "GCEmailSubtitle" and store it with key #gcEmailSubtitle
    Then I see Checkout.PaymentPage.GCEmailSubtitle contains text "#gcEmailSubtitle"
      And I see Checkout.ShippingPage.StandardRadioButton is not displayed
      And I see Checkout.ShippingPage.PickupTabButton is not displayed
      And I see Checkout.ShippingPage.EmailInput is displayed
      And I see Checkout.ShippingPage.FirstNameInput is displayed
      And I see Checkout.ShippingPage.LastNameInput is displayed
      And I see Checkout.SignInPage.SignInButton is displayed
      And I see Checkout.ShippingPage.GiftCardBanner is displayed
      And I see Checkout.ShippingPage.NewsletterTandC is not displayed
    When I get translation from lokalise for "GiftcardShipMethod" and store it with key #gcShipMeth
    Then I see Checkout.OverviewPanel.ShippingMethod contains text "#gcShipMeth"
      And I see Checkout.OverviewPanel.ShippingTime contains text "egiftcard over email"
    When I get translation from lokalise for "GCEmailMessage" and store it with key #gcEmailMessage
    Then I see Checkout.ShippingPage.GiftCardBannerMessage contains text "#gcEmailMessage"

    @tms:UTR-18080
    Examples:
      | locale | langCode |
      | at     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Translation @Lokalise
  @UnifiedCheckout @ShippingPage @GiftCard @ExcludeCK
  Scenario Outline: Gift Card - As a user I can see/not see the correct elements displayed on the shipping page
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I am a guest user
      And I wait until the current page is loaded
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I see Checkout.SignInPage.SignInButton is displayed
      And I click on Checkout.SignInPage.SignInButton
      And I sign in with user "pvh.fr.automation@outlook.com" and password "AutoNation2023"
      And I see the attribute value of element Checkout.ShippingPage.EmailInput containing "pvh.fr.automation@outlook.com"
      And I see Checkout.ShippingPage.StandardRadioButton is not displayed
      And I see Checkout.ShippingPage.PickupTabButton is not displayed
      And I see Checkout.ShippingPage.GiftCardBanner is displayed
      And I see Checkout.ShippingPage.EmailInput is displayed
      And I see Checkout.ShippingPage.FirstNameInput is displayed
      And I see Checkout.ShippingPage.LastNameInput is displayed
      And I see Checkout.ShippingPage.SelectedDeliveryAddress is not displayed
      And I see Checkout.ShippingPage.NewsletterTandC is not displayed
    When I get translation from lokalise for "GiftcardShipMethod" and store it with key #gcShipMeth
    Then I see Checkout.OverviewPanel.ShippingMethod contains text "#gcShipMeth"
      And I see Checkout.OverviewPanel.ShippingTime contains text "egiftcard over email"
    When I get translation from lokalise for "GCEmailMessage" and store it with key #gcEmailMessage
    Then I see Checkout.ShippingPage.GiftCardBannerMessage contains text "#gcEmailMessage"
      And I clear shopping bag for the registered user of this locale

    @tms:UTR-18081
    Examples:
      | locale | langCode |
      | at     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Translation @Lokalise
  @UnifiedCheckout @ShippingPage @GiftCard @Negative
  Scenario Outline: Gift Card - I can check for the validation errors on the shipping page for Personal Details
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
    Then I click on Experience.ShoppingBag.StartCheckoutButton
      And I see Checkout.PaymentPage.PersonalDetailsTitle is displayed
    When I get translation from lokalise for "PersonalDetails" and store it with key #persDetailsTitle
    Then I see Checkout.PaymentPage.PersonalDetailsTitle contains text "#persDetailsTitle"
    When I get translation from lokalise for "GCEmailSubtitle" and store it with key #gcEmailSubtitle
    Then I see Checkout.PaymentPage.GCEmailSubtitle contains text "#gcEmailSubtitle"
      And I see Checkout.ShippingPage.EmailInput is displayed
      And I see Checkout.ShippingPage.FirstNameInput is displayed
      And I see Checkout.ShippingPage.LastNameInput is displayed
      And I scroll to and click on Checkout.ShippingPage.ProceedToPayment
    When I get translation from lokalise for "FirstNameRequired" and store it with key #firstNameRequired
    Then I see Checkout.ShippingPage.InputErrorMessage with index 1 contains text "#firstNameRequired"
    When I get translation from lokalise for "LastNameRequired" and store it with key #lastNameRequired
      And I see Checkout.ShippingPage.InputErrorMessage with index 2 contains text "#lastNameRequired"
    When I get translation from lokalise for "EmailRequired" and store it with key #emailRequired
    Then I see Checkout.ShippingPage.InputErrorMessage with index 3 contains text "#emailRequired"
      And I wait for 2 seconds
      And I type to following inputs
      | element                              | value |
      | Checkout.ShippingPage.EmailInput     | 1     |
      | Checkout.ShippingPage.FirstNameInput | 2     |
      | Checkout.ShippingPage.LastNameInput  | 3     |
      And I scroll to and click on Checkout.ShippingPage.ProceedToPayment
    When I get translation from lokalise for "InvalidFirstName" and store it with key #invalidFirstName
    Then I see Checkout.ShippingPage.InputErrorMessage with index 1 contains text "#invalidFirstName"
    When I get translation from lokalise for "InvalidLastName" and store it with key #invalidFirstName
    Then I see Checkout.ShippingPage.InputErrorMessage with index 2 contains text "#invalidFirstName"
    When I get translation from lokalise for "InvalidEmail" and store it with key #invalidEmail
    Then I see Checkout.ShippingPage.InputErrorMessage with index 3 contains text "#invalidEmail"

    @tms:UTR-18082
    Examples:
      | locale | langCode |
      | at     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @GiftCard
  Scenario Outline: Gift Card - As a guest I can see/not see the correct elements displayed on the shipping page for UK
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I am a guest user
      And I wait until the current page is loaded
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I see Checkout.PaymentPage.PersonalDetailsTitle is displayed
    Then I see Checkout.ShippingPage.EmailInput is displayed
      And I see Checkout.ShippingPage.FirstNameInput is displayed
      And I see Checkout.ShippingPage.LastNameInput is displayed
      And I see Checkout.ShippingPage.Address1Input is displayed
      And I see Checkout.ShippingPage.Address2Input is displayed
      And I see Checkout.ShippingPage.CityInput is displayed
      And I see Checkout.ShippingPage.PostcodeInput is displayed
    When as a guest I add first delivery details
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
    Then I check that my delivery details have been saved
      And I see the checkbox Checkout.PaymentPage.SameAsShippingCheckbox is checked
    When I navigate back in the browser
      And I wait until Checkout.PaymentPage.PersonalDetailsTitle is displayed
    Then I check that my delivery details have been saved

    @tms:UTR-18806
    Examples:
      | locale | langCode |
      | uk     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Translation @Lokalise
  @UnifiedCheckout @ShippingPage @GiftCard
  Scenario Outline: Gift Card - As a guest/reg user on UK I cannot proceed to payment after entering an invalid postcode
    Given I am on locale <locale> home page of langCode default with accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I see Checkout.PaymentPage.PersonalDetailsTitle is displayed
      And as a <userType> I add first delivery details
      And I clear text field of element Checkout.ShippingPage.PostcodeInput
      And I clear text field of element Checkout.ShippingPage.PostcodeInput
    When I type "<wrongPostcode>" in the field Checkout.ShippingPage.PostcodeInput
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until the count of elements Checkout.ShippingPage.InputError is equal to 1
      And I get translation from lokalise for "<PostcodeTranslation>" and store it with key #invalidPostcodeUK
      And I see the current page is shipping page
    Then I see Checkout.ShippingPage.InputError with index 1 contains text "#invalidPostcodeUK"

    @tms:UTR-18804
    Examples:
      | locale | userType | wrongPostcode | PostcodeTranslation |
      | uk     | guest    |               | MandatoryPostcode   |

    @tms:UTR-18805
    Examples:
      | locale | userType  | wrongPostcode | PostcodeTranslation |
      | uk     | logged in | @!#           | InvalidPostcodeUK   |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Translation @Lokalise
  @UnifiedCheckout @ShippingPage @GiftCard @tms:UTR-18803
  Scenario Outline: Gift Card - As a reg user I can see UK address displayed on Shipping Page
    Given I am on locale uk home page of langCode default with accepted cookies
      And I wait until the current page is loaded
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until the current page is loaded
    When I continue as logged in to shipping page
      And I wait until Checkout.ShippingPage.SavedDeliveryAddress is displayed
    Then I see Checkout.ShippingPage.DeliveryAddressDropdown is displayed
      And I see Checkout.ShippingPage.EditAddressButton is displayed
      And I see Checkout.ShippingPage.NewAddressButton is displayed