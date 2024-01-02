Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome @FireFox @Safari
  @Analytics @UnifiedMyAccount @PPL @Unification @DataLayerEvent
  @tms:UTR-3852
  Scenario Outline: The event is fired when I click on the forgot password link on Sign In from header
    Given There is 1 account
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
      And in js extract digitalData.page.pageInfo.pageName save to #pageName
      And I click on Experience.Header.SignInButton
    When I inject utag event listener
      And I click on MyAccount.SignInPopUp.ForgotPasswordLink
      And I type "user1#email" in the field MyAccount.SignInPopUp.ForgotPasswordEmailField
      And I click on MyAccount.SignInPopUp.ForgotPasswordSendButton
    Then utag event forgot_password is fired saved to key #event
      And utag event #event should contain attr event_name with value "forgot_password"
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "forgot_password"
      And utag event #event should contain attr eventLabel with value "#pageName"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale           | langCode         | page          |
      | default          | default          | store-locator |
      | multiLangDefault | multiLangDefault | wlp           |