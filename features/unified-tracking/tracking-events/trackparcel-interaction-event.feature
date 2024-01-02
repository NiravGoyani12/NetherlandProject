Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedMyAccount @PPL
  @tms:UTR-5537
  @issue:PPL-1210
  Scenario Outline: The event is fired when I click on track parcel button inside order details
    Given I am Joost account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I inject utag event listener
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButton
      And I click on MyAccount.OrderDetailsPage.TrackParcelButton
    Then utag event trackparcel_interaction is fired saved to key #event
      And utag event #event should contain attr event_name with value "trackparcel_interaction"
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "trackparcel_click"
      And utag event #event should contain attr eventLabel with value "track parcel"
      And utag event #event should contain non-empty attr user_id
      And utag event #event should contain non-empty attr contact_id
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale  | langCode |
      | default | default  |