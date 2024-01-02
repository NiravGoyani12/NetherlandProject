Feature: Unified My Account - Gift Card Orders

  #Scenarios for CK

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @GiftCard
  @UnifiedMyAccount @PPL @MyOrders @ExcludeUat @ExcludeTH @P2
  @tms:UTR-18770
  Scenario Outline: GiftCard orders should not have an estimated delivery time or track parcel button
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001507517
      And I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery is not displayed
      And I see MyAccount.OrderDetailsPage.TrackParcelButton is not displayed
    Then I see MyAccount.OrderDetailsPage.CancelOrderButton is not displayed

    @tms:UTR-18770
    Examples:
      | locale | langCode |
      | fi     | default  |

  #Scenarios for TH

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @GiftCard
  @UnifiedMyAccount @PPL @MyOrders @ExcludeUat @ExcludeCK @P2
  @tms:UTR-18771
  Scenario Outline: GiftCard orders should not have an estimated delivery time or track parcel button
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001507521
      And I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery is not displayed
      And I see MyAccount.OrderDetailsPage.TrackParcelButton is not displayed
    Then I see MyAccount.OrderDetailsPage.CancelOrderButton is not displayed

    @tms:UTR-18771
    Examples:
      | locale | langCode |
      | dk     | default  |