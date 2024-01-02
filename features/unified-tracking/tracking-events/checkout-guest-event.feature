Feature: Unified Tracking - Events

  # TODO: Check for failures
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @SignIn @UnifiedCheckout @P3
  @tms:UTR-863
  Scenario Outline: Checkout guest - The event is fired when I proceed to checkout as a guest
    Given I am on locale <locale> of langCode <langCode> with 2 products on shipping page
    When I inject utag event listener
      And I continue as guest to shipping page
    Then utag event checkout_guest is fired saved to key #event
      And utag event #event should contain attr event_name with value "checkout_guest"
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "checkout_guest"
      And utag event #event should contain attr eventLabel with value "checkout - sign in|checkout>login"

    Examples:
      | locale | langCode |
      | ee     | default  |