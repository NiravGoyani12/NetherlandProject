Feature: Unified Tracking - Events

  #The Terms & Conditions pop-up isn't on the NL, UK, BE and DE markets, so this event is not triggered there.

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @Payment @PaypalExpress @SignIn @UnifiedCheckout
  @tms:UTR-873
  Scenario Outline: Paypal conditions click - The event is fired when I accept the condtions of paypal express from Checkout Signin
    Given I am on locale <locale> of langCode <langCode> with 2 products on shipping page
      And I wait until Checkout.SignInPage.PaypalExpressButton is clickable
      And I click on Checkout.SignInPage.PaypalExpressButton
    When I inject utag event listener
      And I wait until Checkout.SignInPage.PaypalExpressTermsModal is displayed
      And I set the checkbox Checkout.SignInPage.PaypalExpressTermsCheckbox status to true
      And I click on Checkout.SignInPage.PayWithPaypalExpressButton
    Then utag event paypal_conditions_click is fired saved to key #event
      And utag event #event should contain attr event_name with value "paypal_conditions_click"
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "paypal_conditions_click"
      And utag event #event should contain attr eventLabel with value "paypal_conditions_accept"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode |
      | lv     | default  |