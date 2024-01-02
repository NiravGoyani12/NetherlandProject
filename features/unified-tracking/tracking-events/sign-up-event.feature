Feature: Unified Tracking - Events
  # TODO: Check for failures only CK
  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @P1 @FixedEvent
  @tms:UTR-3259
  Scenario Outline: Sign up - The event is fired when I sign up from Checkout Confirmation
      Given I am guest on locale <locale> of langCode <langCode> on the payment page
      And I wait for 30 seconds
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
      And I wait until Checkout.OrderConfirmationPage.ContinueShoppingButton is clickable
      When I inject utag event listener
      And I scroll to and click on Checkout.OrderConfirmationPage.SignUpPasswordInput
      And I type "PVHTest1234" in the field Checkout.OrderConfirmationPage.SignUpPasswordInput
      And I type "PVHTest1234" in the field Checkout.OrderConfirmationPage.SignUpConfirmPasswordInput
      And I set the checkbox Checkout.OrderConfirmationPage.SignUpTermsAndConditionsCheckbox status to true
      And I scroll to and click on Checkout.OrderConfirmationPage.SignUpButton
      And I wait for 30 seconds
      Then utag event sign_up is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "sign up"
      And utag event #event should contain attr eventLabel with value "checkout - confirmation"
      And utag event #event should contain attr signup_location with value "confirmation"
      And utag event #event should contain non-empty attr user_email_encrypted
      And I execute all datalayer event validation with report key #event
    
    @ExcludeTH
    Examples:
      | locale  | langCode |
      | ee      | default  |

 @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @Authentication @UnifiedMyAccount @PPL @P1 @FixedEvent
  @tms:UTR-3260
  Scenario Outline: Sign up - The event is fired when I sign up from Header
      Given There is 1 account
      And I am on <page> page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.RegisterPopUp.RegisterFormButton
      When I inject utag event listener
      And I type "user1#email" in the field MyAccount.RegisterPopUp.EmailField
      And I type "PVHTest1234" in the field MyAccount.RegisterPopUp.PasswordField
      And I click on MyAccount.RegisterPopUp.TermsAndConditionsCheckbox
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
      And I wait for 30 seconds
      Then utag event sign_up is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "sign up"
      And utag event #event should contain attr eventLabel with value "header"
      And utag event #event should contain attr signup_location with value "account_registration"
      And utag event #event should contain non-empty attr user_email_encrypted
      And I execute all datalayer event validation with report key #event
      
    @ExcludeTH
    Examples:
      | locale  | langCode | page |
      | default | default  | shopping-bag|
      | default | default  | wishlist|