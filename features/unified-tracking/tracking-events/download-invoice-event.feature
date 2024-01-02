Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome @FireFox @Safari
  @Analytics @UnifiedMyAccount @PPL @Unification @MyOrders @DataLayerEvent
  @tms:UTR-5538
  @issue:PPL-1069
  Scenario Outline: The event is fired when I click on download invoice button inside order details
    Given I am Joost account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButton
    When I inject utag event listener
      And I click on MyAccount.OrderDetailsPage.DownloadInvoiceButton
    Then utag event download_invoice is fired saved to key #event
      And utag event #event should contain attr event_name with value "download_invoice"
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "invoice_click"
      And utag event #event should contain attr eventLabel with value "download invoice"
      And utag event #event should contain non-empty attr user_id
      And utag event #event should contain non-empty attr contact_id
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Analytics @UnifiedMyAccount @PPL @Unification @MyOrders @DataLayerEvent
  @tms:UTR-8199
  @issue:PPL-1069
  Scenario Outline: The event is fired when I click on download invoice button inside order details
    Given I am Joost account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.ListViewToggle
    When I inject utag event listener
      And I click on MyAccount.MyOrdersPage.ViewInvoiceLink
    Then utag event download_invoice is fired saved to key #event
      And utag event #event should contain attr event_name with value "download_invoice"
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "invoice_click"
      And utag event #event should contain attr eventLabel with value "download invoice"
      And utag event #event should contain non-empty attr user_id
      And utag event #event should contain non-empty attr contact_id
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |