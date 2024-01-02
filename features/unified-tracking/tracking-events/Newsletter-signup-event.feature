Feature: Unified Tracking - Events

  #TODO: uncomment once this functionality is implemented
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @P1
  @tms:UTR-1419
  Scenario Outline: Newsletter signup - The event is fired when I sign up with checked newsletterbox from Confirmation Page
    Given I am on locale <locale> of langCode default with 1 products on shipping page
      And I wait until Checkout.SignInPage.SignInButton is clickable
      And I continue as <userType> to shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And as a <userType> I add <address> delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | element    | value               |
      | cardNumber | 4111 1111 1111 1111 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | QA                  |
      | lastName   | Automation          |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    When I inject utag event listener
      And I set the checkbox Checkout.OrderConfirmationPage.NewsletterCheckbox status to true
      And I scroll to and click on Checkout.OrderConfirmationPage.NewsletterSubmitBtn
    Then utag event newsletter_signup is fired saved to key #event
      And utag event #event should contain attr event_name with value "newsletter_signup"
      And utag event #event should contain attr eventAction with value "newsletter_signup"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr signup_location with value "confirmation"
      And utag event #event should contain attr eventLabel with value "checkout - confirmation|checkout>thankyoupage"
      And utag event #event should contain non-empty attr user_email_encrypted
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | userType | type  | address |
      | ee     | default  | guest    | guest | first   |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedMyAccount @PPL @P1
  @tms:UTR-8806
  Scenario Outline: Newsletter signup - The event is not fired when not checking the checkbox from Sign up from header
    Given There is 1 account
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.SignInButton
      And I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type to following inputs
      | element                               | value       |
      | MyAccount.RegisterPopUp.EmailField    | user1#email |
      | MyAccount.RegisterPopUp.PasswordField | PVHTest1234 |
      And I set the checkbox MyAccount.RegisterPopUp.TermsAndConditionsCheckbox status to true
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
    When I inject utag event listener
      And I click on MyAccount.Newsletter.OnlyTenPecentDiscount
    Then utag event newsletter_signup is not fired
    @ExcludeTH
    Examples:
      | locale | langCode | page          |
      | ee     | default  | store-locator |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedMyAccount @PPL @P1
  @tms:UTR-8807
  Scenario Outline: Newsletter signup - The event is fired with checking the newsletter checkbox when I Sign Up from header
    Given There is 1 account
      And I am on locale <locale> home page with forced accepted cookies
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.SignInButton
      And I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type to following inputs
      | element                               | value       |
      | MyAccount.RegisterPopUp.EmailField    | user1#email |
      | MyAccount.RegisterPopUp.PasswordField | PVHTest1234 |
      And I set the checkbox MyAccount.RegisterPopUp.TermsAndConditionsCheckbox status to true
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
    When I inject utag event listener
      And I set the checkbox MyAccount.RegisterPopUp.NewsletterCheckbox status to true
      And I click on MyAccount.Newsletter.PopupSubscribeButton
    Then utag event newsletter_signup is fired saved to key #event
      And utag event #event should contain attr eventAction with value "newsletter_signup"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr signup_location with value "account_registration"
      And utag event #event should contain attr eventLabel with value "header"
      And utag event #event should contain non-empty attr user_email_encrypted
      And utag event #event should contain non-empty attr user_id
      And I execute all datalayer event validation with report key #event
    @ExcludeTH
    Examples:
      | locale | langCode | page          |
      | ee     | default  | store-locator |

  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedMyAccount @PPL @tms:UTR-18660
  Scenario Outline: Newsletter signup - The event is fired with checking the newsletter checkbox when I Sign Up from header for TH
    Given There is 1 account
      And I am on locale <locale> home page with forced accepted cookies
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.SignInButton
      And I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type to following inputs
      | element                            | value       |
      | MyAccount.RegisterPopUp.EmailField | user1#email |
      And I set the checkbox MyAccount.RegisterPopUp.TermsAndConditionsCheckbox status to true
    When I inject utag event listener
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
    Then utag event newsletter_signup is fired saved to key #event
      And utag event #event should contain attr eventAction with value "newsletter_signup"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr signup_location with value "account_registration"
      And utag event #event should contain attr eventLabel with value "header"
      And utag event #event should contain non-empty attr user_email_encrypted
      And utag event #event should contain non-empty attr user_id
      And I execute all datalayer event validation with report key #event

    @ExcludeCK
    Examples:
      | locale | langCode | page          |
      | uk     | default  | store-locator |

  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedMyAccount @PPL @tms:UTR-18659
  Scenario Outline: Newsletter signup - The event is fired with checking the newsletter checkbox when I Sign Up from footer
    Given There is 1 account
      And I am on locale <locale> home page with forced accepted cookies
      And I see MyAccount.Newsletter.BannerSubscribeButton is displayed
    When I click on MyAccount.Newsletter.BannerSubscribeButton
    Then I see MyAccount.Newsletter.NewsletterSignUpPopup is displayed
    When I type "user1#email" in the field MyAccount.Newsletter.BannerEmailField
    When I inject utag event listener
      And I set the checkbox MyAccount.Newsletter.BannerTermsAndConditionsCheckbox status to true
      And I click on MyAccount.Newsletter.PopupSubscribeButton
    Then I see MyAccount.Newsletter.PopupDOBBenefit is displayed
      And I type "01" in the field MyAccount.Newsletter.PopupBenefitDDInput
      And I type "01" in the field MyAccount.Newsletter.PopupBenefitMMInput
      And I type "1990" in the field MyAccount.Newsletter.PopupBenefitYYInput
      And I click on MyAccount.Newsletter.PopupSubscribeButton
    Then utag event newsletter_signup is fired saved to key #event
      And utag event #event should contain attr eventAction with value "newsletter_signup"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr signup_location with value "newsletter_popup"
      And utag event #event should contain attr eventLabel with value "footer"
      And I execute all datalayer event validation with report key #event

    @ExcludeTH
    Examples:
      | locale | langCode | page          |
      | uk     | default  | store-locator |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedMyAccount @PPL @P1 @tms:UTR-18658
  Scenario Outline: Newsletter signup - The event is fired with checking the newsletter checkbox when I Sign Up from OOS notification page
    Given There is 1 normal size product style of locale <locale> where 1 size is out of stock with inventory between 5 and 9999
      And I am on unified locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #sku1
      And I click on ProductDetailPage.Pdp.SizeSoldOutButton by js
      And I click on ProductDetailPage.Pdp.NotifyMeButton
      And I wait until ProductDetailPage.Pdp.NotifyMePopup is displayed
      And I type "notify@me.com" in the field ProductDetailPage.NotifyMePopup.EmailInput
    When I inject utag event listener
      And I click on ProductDetailPage.NotifyMePopup.NotifyMeButton
      And I wait until ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed
    Then utag event newsletter_signup is fired saved to key #event
      And utag event #event should contain attr eventAction with value "newsletter_signup"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr signup_location with value "out of stock notification"
      And utag event #event should contain non-empty attr eventLabel
      And I execute all datalayer event validation with report key #event
    @ExcludeTH
    Examples:
      | locale | langCode |
      | ee     | default  |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedMyAccount @PPL @P1 @tms:UTR-18655
  Scenario Outline: Newsletter signup - The event is fired with checking the newsletter checkbox when I Sign Up with DOB
    Given There is 1 account
      And I am on locale <locale> home page with forced accepted cookies
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.SignInButton
      And I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type to following inputs
      | element                               | value       |
      | MyAccount.RegisterPopUp.EmailField    | user1#email |
      | MyAccount.RegisterPopUp.PasswordField | PVHTest1234 |
      And I set the checkbox MyAccount.RegisterPopUp.TermsAndConditionsCheckbox status to true
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
    When I inject utag event listener
      And I see MyAccount.Newsletter.PopupDOBBenefit is displayed
      And I type "01" in the field MyAccount.Newsletter.PopupBenefitDDInput
      And I type "01" in the field MyAccount.Newsletter.PopupBenefitMMInput
      And I type "1990" in the field MyAccount.Newsletter.PopupBenefitYYInput
      And I set the checkbox MyAccount.RegisterPopUp.NewsletterCheckbox status to true
      And I click on MyAccount.Newsletter.PopupSubscribeButton
    Then utag event newsletter_signup is fired saved to key #event
      And utag event #event should contain attr eventAction with value "newsletter_signup"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr signup_location with value "account_registration"
      And utag event #event should contain attr eventLabel with value "header"
      And utag event #event should contain attr newsletter_preferences with value "date of birth"
      And utag event #event should contain non-empty attr user_email_encrypted
      And utag event #event should contain non-empty attr contact_id
      And utag event #event should contain non-empty attr user_id
      And I execute all datalayer event validation with report key #event

    @ExcludeTH
    Examples:
      | locale | langCode | page          |
      | ee     | default  | store-locator |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedMyAccount @PPL @P1 @tms:UTR-18656
  Scenario Outline: Newsletter signup - The event is fired with checking the newsletter checkbox when I Sign Up with gender
    Given There is 1 account
      And I am on locale <locale> home page with forced accepted cookies
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.SignInButton
      And I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type to following inputs
      | element                               | value       |
      | MyAccount.RegisterPopUp.EmailField    | user1#email |
      | MyAccount.RegisterPopUp.PasswordField | PVHTest1234 |
      And I set the checkbox MyAccount.RegisterPopUp.TermsAndConditionsCheckbox status to true
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
    When I inject utag event listener
      And I see MyAccount.Newsletter.PopupDOBBenefit is displayed
      And I click on MyAccount.Newsletter.PopUpWomenCheckbox
      And I set the checkbox MyAccount.RegisterPopUp.NewsletterCheckbox status to true
      And I click on MyAccount.Newsletter.PopupSubscribeButton
    Then utag event newsletter_signup is fired saved to key #event
      And utag event #event should contain attr eventAction with value "newsletter_signup"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr signup_location with value "account_registration"
      And utag event #event should contain attr eventLabel with value "header"
      And utag event #event should contain attr newsletter_preferences with value "gender"
      And utag event #event should contain non-empty attr user_email_encrypted
      And utag event #event should contain non-empty attr contact_id
      And utag event #event should contain non-empty attr user_id
      And I execute all datalayer event validation with report key #event

    @ExcludeTH
    Examples:
      | locale | langCode | page          |
      | ee     | default  | store-locator |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedMyAccount @PPL @P1 @tms:UTR-18657
  Scenario Outline: Newsletter signup - The event is fired with checking the newsletter checkbox when I Sign Up with gender and DOB
    Given There is 1 account
      And I am on locale <locale> home page with forced accepted cookies
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.SignInButton
      And I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type to following inputs
      | element                               | value       |
      | MyAccount.RegisterPopUp.EmailField    | user1#email |
      | MyAccount.RegisterPopUp.PasswordField | PVHTest1234 |
      And I set the checkbox MyAccount.RegisterPopUp.TermsAndConditionsCheckbox status to true
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
    When I inject utag event listener
      And I see MyAccount.Newsletter.PopupDOBBenefit is displayed
      And I type "01" in the field MyAccount.Newsletter.PopupBenefitDDInput
      And I type "01" in the field MyAccount.Newsletter.PopupBenefitMMInput
      And I type "1990" in the field MyAccount.Newsletter.PopupBenefitYYInput
      And I click on MyAccount.Newsletter.PopUpWomenCheckbox
      And I set the checkbox MyAccount.RegisterPopUp.NewsletterCheckbox status to true
      And I click on MyAccount.Newsletter.PopupSubscribeButton
    Then utag event newsletter_signup is fired saved to key #event
      And utag event #event should contain attr eventAction with value "newsletter_signup"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr signup_location with value "account_registration"
      And utag event #event should contain attr eventLabel with value "header"
      And utag event #event should contain attr newsletter_preferences with value "date of birth, gender"
      And utag event #event should contain non-empty attr user_email_encrypted
      And utag event #event should contain non-empty attr contact_id
      And utag event #event should contain non-empty attr user_id
      And I execute all datalayer event validation with report key #event

    @ExcludeTH
    Examples:
      | locale | langCode | page          |
      | ee     | default  | store-locator |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedMyAccount @PPL 
  Scenario Outline: Newsletter signup - The event is fired with checking the newsletter checkbox when I Sign Up with DOB for TH
    Given There is 1 account
      And I am on locale <locale> home page with forced accepted cookies
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.SignInButton
      And I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type to following inputs
      | element                            | value       |
      | MyAccount.RegisterPopUp.EmailField | user1#email |
        And I type "01" in the field MyAccount.Newsletter.PopupBenefitDDInput
      And I type "01" in the field MyAccount.Newsletter.PopupBenefitMMInput
      And I type "1990" in the field MyAccount.Newsletter.PopupBenefitYYInput
      And I set the checkbox MyAccount.RegisterPopUp.TermsAndConditionsCheckbox status to true
    When I inject utag event listener
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
    Then utag event newsletter_signup is fired saved to key #event
      And utag event #event should contain attr eventAction with value "newsletter_signup"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr signup_location with value "account_registration"
      And utag event #event should contain attr eventLabel with value "header"
      And utag event #event should contain attr newsletter_preferences with value "date of birth"
      And utag event #event should contain non-empty attr user_email_encrypted
      And utag event #event should contain non-empty attr user_id
      And I execute all datalayer event validation with report key #event

    @ExcludeCK
    Examples:
      | locale | langCode | page          |
      | ee     | default  | store-locator |
