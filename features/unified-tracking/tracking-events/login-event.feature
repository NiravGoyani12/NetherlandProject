Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @P1 @FixedEvent
  @SignIn
  @tms:UTR-865
  Scenario Outline: Login - The event is fired when I login from Checkout
      Given I am on locale <locale> of langCode <langCode> with 1 products on shipping page
      And I wait until the current page is loaded
      And I wait until checkout.SignInPage.CheckoutSignInButton is displayed
      When I inject utag event listener
      When I continue as valid user with remember checkbox as <checkboxStatus> to shipping page
      Then utag event login is fired saved to key #event
      And utag event #event should contain attr event_name with value "login"
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "login"
      And utag event #event should contain attr eventLabel with value "checkout-shipping"
      And utag event #event should contain attr remember_me_checkbox with value "<checkboxStatus>"
      And I execute all datalayer event validation with report key #event
   
    Examples:
      | locale | langCode | checkboxStatus |
      | uk     | default  | true           |
      | uk     | default  | false          |



  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @P1 @FixedEvent
  @SignIn
  @tms:UTR-1729
  Scenario Outline: Login - The event is not fired when I try to login from Checkout with incorrect credentials
      Given I am on locale <locale> of langCode <langCode> with 2 products on shipping page
      And I wait until the current page is loaded
      And I wait until checkout.SignInPage.CheckoutSignInButton is displayed
      When I inject utag event listener
      When I continue as invalid user with remember checkbox as true to shipping page
      Then utag event login is not fired saved to key #event
    
    Examples:
      | locale  | langCode | email        | password |
      | default | default  | test@test.ee |          |
      | default | default  |              | abcde    |


@FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome @FireFox @Safari
  @Analytics @UnifiedMyAccount @PPL @Unification @DataLayerEvent @P1 @FixedEvent
  @tms:UTR-3850
  Scenario Outline: Login - The event is fired when I login from Header
      Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.SignInButton
      When I inject utag event listener
      And I set the checkbox MyAccount.SignInPopUp.RememberMeCheckbox status to <checkboxStatus>
      And I type "automation.test.user@gmail.com" in the field MyAccount.SignInPopUp.EmailField
      And I type "qwerty1234" in the field MyAccount.SignInPopUp.PasswordField
      And I click on MyAccount.SignInPopUp.SignInButton
      Then utag event login is fired saved to key #event
      And utag event #event should contain attr event_name with value "login"
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "login"
      And utag event #event should contain attr eventLabel with value "header"
      And utag event #event should contain attr remember_me_checkbox with value "<checkboxStatus>"
      And I execute all datalayer event validation with report key #event
    
    Examples:
      | locale           | langCode         | page          | checkboxStatus |
      | default          | default          | store-locator | true           |
      | default          | default          | home-page     | false          |
      | default          | default          | PLP           | true           |
      | default          | default          | shopping-bag  | false          |
      | default          | default          | pdp           | true           |
      | default          | default          | search-plp    | false          |
      | multiLangDefault | multiLangDefault | wlp           | true           |