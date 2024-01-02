Feature: Unified Checkout - Newsletter Shipping Page


  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Newsletter @ShippingPage @P3
  Scenario Outline: Newsletter - As a user I see Newsletter checkbox is not displayed in case of saved address
    Given I am logged in on locale <locale> of langCode <langCode> with newly added address and with 1 different any products on checkout page
      And I see Checkout.ShippingPage.SavedDeliveryAddress is displayed
    Then  I see Checkout.ShippingPage.NewAddressSection is not displayed
      And I see Checkout.ShippingPage.NewsletterCheckbox is not displayed

    @tms:UTR-12363 @Mobile
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-12364
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Newsletter @ShippingPage @P2 @ExcludeTH
  @NewsletterAtCheckout
  Scenario Outline: Newsletter - As a user or guest , I should be able to proceed for payment with checkbox ticked for newsletter subscription
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
    When I click on Checkout.ShippingPage.NewsletterExpandButton
      And I set the checkbox Checkout.ShippingPage.NewsletterCheckbox status to true
    When  I see Checkout.ShippingPage.NewAddressSection is displayed
      And as a <userType> I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
    Then I see Checkout.PaymentPage.CreditCardButton is displayed in 5 seconds

    @tms:UTR-12365
    Examples:
      | locale  | userType  | langCode |
      | default | logged in | default  |

    # @tms:UTR-12366 @Mobile
    # Examples:
    #   | locale | userType | langCode |
    #   | es     | guest    | default  |

    @tms:UTR-12367 @Mobile
    Examples:
      | locale           | userType  | langCode         |
      | multiLangDefault | logged in | multiLangDefault |

  # @tms:UTR-12368
  # Examples:
  #   | locale | userType | langCode |
  #   | ch     | guest    | FR       |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Newsletter @ShippingPage @P2 @ExcludeTH
  @NewsletterAtCheckout
  Scenario Outline: Newsletter - As a user I should be able to proceed for payment with checkbox unticket for newsletter subscription and check for newsletter in My Account page
    Given I am logged in on locale <locale> of langCode <langCode> on the shipping page
    When  I see Checkout.ShippingPage.NewAddressSection is displayed
      And I see the checkbox Checkout.ShippingPage.NewsletterCheckbox is unchecked
      And as a guest I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait for 2 seconds
    When I navigate to page myaccount/preferences
    Then I see MyAccount.NewsletterSubscription.NewsletterSignUpButton is displayed in 2 seconds

    @tms:UTR-12369 @Mobile
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-12371
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @MyAccount @Newsletter @ShippingPage @P2 @ExcludeTH
  Scenario Outline: Newsletter - As a user, Newsletter checkbox is not displayed for signed up logged in users
    Given I am on locale <locale> home page with forced accepted cookies
      And I am a logged in user
    When I navigate to page <page>
      And I wait for 2 seconds
    When I set the checkbox MyAccount.NewsletterSubscription.NewsLetterTCCheckbox status to true
      And I click on MyAccount.NewsletterSubscription.NewsletterSignUpButton
    Then I wait until MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo is displayed in 5 seconds
    When I am on locale <locale> shopping bag page with 1 unit of any product
      And I click on Experience.ShoppingBag.StartCheckoutButton
    Then I see Checkout.ShippingPage.NewAddressSection is displayed in 2 seconds
      And I see Checkout.ShippingPage.NewsletterCheckbox is not displayed

    @tms:UTR-12373 @Mobile @issue:EESCK-11706
    Examples:
      | locale  | langCode | page                  |
      | default | default  | myaccount/preferences |

    @tms:UTR-12374 @issue:EESCK-11706
    Examples:
      | locale           | langCode         | page                  |
      | multiLangDefault | multiLangDefault | myaccount/preferences |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @CollectInStore @P3 @ExcludeTH
  Scenario Outline: Collec in Store - Newsletter subscription should be seen in My account when done from Shipping page post selecting Collect in Store
    Given I am logged in on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.CollectInStoreRadioButton is displayed
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I wait for 1 seconds
      And I type "<location>" in the field Checkout.ShippingPage.CollectInStoreSearchField
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
      And I set the checkbox Checkout.ShippingPage.NewsletterTandCCheckbox status to true
      And I wait for 3 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed in 7 seconds
    When I navigate to preferences page
    Then I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo is displayed in 5 seconds
      And I see MyAccount.NewsletterSubscription.NewsLetterSavePreferences is displayed

    @tms:UTR-11404 @Mobile
    Examples:
      | locale | langCode | location |
      | uk     | default  | London   |


  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @BRING @P3 @ExcludeTH
  Scenario Outline: Bring Pakkeshop - Newsletter subscription should be seen in My account when done from Shipping page post selecting Bring Pakkeshop
    Given I am logged in on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I wait until Checkout.ShippingPage.BRINGRadioButton is displayed
      And I click on Checkout.ShippingPage.BRINGRadioButton
      And I wait for 1 seconds
      And I type "<location>" in the field Checkout.ShippingPage.BringSearchField
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
      And I set the checkbox Checkout.ShippingPage.NewsletterTandCCheckbox status to true
      And I wait for 5 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed in 7 seconds
    When I navigate to preferences page
    Then I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo is displayed in 5 seconds
      And I see MyAccount.NewsletterSubscription.NewsLetterSavePreferences is displayed

    @tms:UTR-13591
    Examples:
      | locale | langCode | location |
      | fi     | default  | 00130    |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @BRING @P3 @ExcludeTH
  Scenario Outline: PostNL - Newsletter subscription should be seen in My account when done from Shipping page post selecting PostNL PuP
    Given I am logged in on locale <locale> of langCode <langCode> on the shipping page
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
      And I set the checkbox Checkout.ShippingPage.NewsletterTandCCheckbox status to true
      And I wait for 5 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed in 7 seconds
    When I navigate to preferences page
    Then I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo is displayed in 5 seconds
      And I see MyAccount.NewsletterSubscription.NewsLetterSavePreferences is displayed

    @tms:UTR-17970
    Examples:
      | locale | langCode |
      | nl     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @UPS @P3 @ExcludeTH
  Scenario Outline: UPS - Newsletter subscription should be seen in My account when done from Shipping page post selecting UPS PuP
    Given I am logged in on locale <locale> of langCode <langCode> on the shipping page
      And I click on Checkout.ShippingPage.PickupTabButton
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
      And I wait until Checkout.ShippingPage.UPSAccesPointSearchField is displayed
    When I type "#POSTCODE" in the field Checkout.ShippingPage.UPSAccesPointSearchField
      And I click on Checkout.ShippingPage.UPSAccesPointFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
      And the count of elements Checkout.ShippingPage.PUPSearchResults is greater than 0
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | John                        |
      | Checkout.ShippingPage.LastNameInput  | Doe                         |
      | Checkout.ShippingPage.PhoneInput     | #PHONE                      |
      And I set the checkbox Checkout.ShippingPage.NewsletterTandCCheckbox status to true
      And I wait for 3 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed in 7 seconds
    When I navigate to preferences page
    Then I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo is displayed in 5 seconds
      And I see MyAccount.NewsletterSubscription.NewsLetterSavePreferences is displayed

    @tms:UTR-17971 @Mobile
    Examples:
      | locale | langCode |
      | de     | EN       |






