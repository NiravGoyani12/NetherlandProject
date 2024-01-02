Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome @FireFox @Safari
  @Analytics @UnifiedMyAccount @PPL @Unification @MyOrders @DataLayerEvent
  @tms:UTR-5539
  @issue:PPL-1210
  Scenario Outline: The event is fired when I interact with the filter toggle inside my orders
    Given I am Pierre account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I inject utag event listener
      And I click on MyAccount.MyOrdersPage.<filterType>
    Then utag event filter_toggle is fired saved to key #event
      And utag event #event should contain attr event_name with value "filter_toggle"
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "toggle_click"
      And utag event #event should contain attr eventLabel with value "<filterValue>"
      And utag event #event should contain non-empty attr user_id
      And utag event #event should contain non-empty attr contact_id
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale           | langCode         | filterType      | filterValue |
      | default          | default          | TableViewToggle | block       |
      | multiLangDefault | multiLangDefault | ListViewToggle  | rows        |