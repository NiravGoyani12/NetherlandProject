Feature: Unified Tracking - Events
 # TODO: Check for failures
 # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @ShippingPage @P3
  @tms:UTR-9310
  Scenario Outline: Select store - The event is fired when I choose the CIS shipping method and select a store
    Given I am logged in on locale <locale> of langCode <langCode> with 1 products with value below shipping threshold on shipping page
      And I wait until Checkout.ShippingPage.CollectInStoreRadioButton is displayed
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I type "london" in the field Checkout.ShippingPage.CollectInStoreSearchField
      And I click on Checkout.ShippingPage.CollectInStoreFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
    When I inject utag event listener
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
    Then utag event select_store is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "select_store"
      And utag event #event should contain non-empty attr eventLabel
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode |
      | uk     | default  |

  # TODO: Check for failures
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @ShippingPage
  @tms:UTR-9311
  Scenario Outline: Change selected store - The event is fired when I choose the CIS shipping method and I change the selected store
    Given I am logged in on locale <locale> of langCode <langCode> with 1 products with value below shipping threshold on shipping page
      And I wait until Checkout.ShippingPage.CollectInStoreRadioButton is displayed
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I type "london" in the field Checkout.ShippingPage.CollectInStoreSearchField
      And I click on Checkout.ShippingPage.CollectInStoreFindStoreButton
      And I wait until Checkout.ShippingPage.PUPModalSearchField is displayed
      And I click on Checkout.ShippingPage.PUPSearchResult by index 1
      And I click on Checkout.ShippingPage.PUPModalSelectStoreButton
    When I inject utag event listener
      And I wait until Checkout.ShippingPage.CiSChangeStoreButton is clickable
      And I click on Checkout.ShippingPage.CiSChangeStoreButton
    Then utag event change_selected_store is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "change_selected_store"
      And utag event #event should contain attr eventLabel with value "change_selected_store"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode |
      | uk     | default  |

  # TODO: Check for failures
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @ShippingPage
  @tms:UTR-9312
  Scenario Outline: Collect in store - The event is fired when I choose the CIS shipping method and click on the "search store" button
    Given I am logged in on locale <locale> of langCode <langCode> with 1 products with value below shipping threshold on shipping page
      And I wait until Checkout.ShippingPage.CollectInStoreRadioButton is displayed
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
      And I click on Checkout.ShippingPage.CollectInStoreSearchField
      And I type "london" in the field Checkout.ShippingPage.CollectInStoreSearchField
    When I inject utag event listener
      And I click on Checkout.ShippingPage.CollectInStoreFindStoreButton
    Then utag event collect_in_store is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "collect_in_store"
      And utag event #event should contain attr eventLabel with value "collect_in_store"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode |
      | uk     | default  |