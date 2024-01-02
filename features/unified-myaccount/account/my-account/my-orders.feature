Feature: Unified My Account - My orders

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @MyOrders @P1 @ExcludeSIT
  @feature:PPL-234 @tms:UTR-12531 @Translation @Lokalise
  Scenario Outline: User can see all the components in my orders page in default card view
    Given I am on shopping-bag page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
    When I sign in with user "my.account.charles.automation@outlook.com" and password "AutoNation2023"
      And I wait until Experience.Header.MyAccountButton is displayed in 10 seconds
      And I am on locale <locale> of url /myaccount/orders
      And I get translation from lokalise for "AccountOrdersPeriod" and store it with key #OrderPeriod
    Then I see MyAccount.MyOrdersPage.OrdersPeriodDropdown is displayed
      And I see the attribute value of element MyAccount.MyOrdersPage.OrdersPeriodDropdown containing "#OrderPeriod"
      And I see MyAccount.MyOrdersPage.TableViewToggle is displayed
      And I see MyAccount.MyOrdersPage.ListViewToggle is displayed
      And the count of displayed elements MyAccount.MyOrdersPage.OrderStatus is equal to 3
      And the count of displayed elements MyAccount.MyOrdersPage.OrderCard is equal to 3
      And I see MyAccount.MyOrdersPage.OrderDate is displayed
      And I see MyAccount.MyOrdersPage.TotalPrice is displayed
      And the count of displayed elements MyAccount.MyOrdersPage.ProductName is equal to 3
      And the count of displayed elements MyAccount.MyOrdersPage.ProductImage is equal to 3
      And I see MyAccount.MyOrdersPage.ProductPrice is displayed
      And the count of displayed elements MyAccount.MyOrdersPage.ItemDetails is not less than 9
      And I see MyAccount.MyOrdersPage.ViewOrderButton is displayed
      And the count of displayed elements MyAccount.MyOrdersPage.ViewOrderButton is equal to 3
      And I see MyAccount.MyOrdersPage.LoadMoreButton is displayed

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @MyOrders @P1 @ExcludeSIT
  @feature:PPL-234 @tms:UTR-12531
  Scenario Outline: User can see all the components in my orders page in default card view
    Given I am Charles account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
    Then I see MyAccount.MyOrdersPage.TableViewToggle is displayed
      And I see MyAccount.MyOrdersPage.ListViewToggle is displayed
      And the count of displayed elements MyAccount.MyOrdersPage.OrderStatus is equal to 3
      And the count of displayed elements MyAccount.MyOrdersPage.OrderCard is equal to 3
      And I see MyAccount.MyOrdersPage.OrderDate is displayed
      And I see MyAccount.MyOrdersPage.TotalPrice is displayed
      And the count of displayed elements MyAccount.MyOrdersPage.ProductName is equal to 3
      And the count of displayed elements MyAccount.MyOrdersPage.ProductImage is equal to 3
      And I see MyAccount.MyOrdersPage.ProductPrice is displayed
      And the count of displayed elements MyAccount.MyOrdersPage.ItemDetails is not less than 9
      And I see MyAccount.MyOrdersPage.ViewOrderButton is displayed
      And the count of displayed elements MyAccount.MyOrdersPage.ViewOrderButton is equal to 3
      And I see MyAccount.MyOrdersPage.LoadMoreButton is displayed

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @MyOrders @P2 @ExcludeSIT
  @feature:PPL-233 @tms:UTR-12571
  Scenario Outline: User can see all the components in my orders page in list view
    Given I am Pierre account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.MyOrdersPage.ListViewToggle
    Then the count of displayed elements MyAccount.MyOrdersPage.OrderTableHeader is equal to 6
      And the count of displayed elements MyAccount.MyOrdersPage.OrderNumberLink is equal to 10
      And the count of displayed elements MyAccount.MyOrdersPage.OrderPrice is equal to 10
      And the count of displayed elements MyAccount.MyOrdersPage.ListOrderStatus is equal to 10
    When I click on MyAccount.MyOrdersPage.OrderNumberLink with index 3
    Then URL should contain "myaccount/order/"

    Examples:
      | locale  | langCode |
      | default | default  |

  # TODO: Enable once data copy back is finished and order can be shipped in SAP
  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @MyOrders @P2 @ExcludeCK @ExcludeDB0 @ExcludeSIT
  @feature:PPL-393 @tms:UTR-12763
  Scenario Outline: User is able to download invoice and see credit note for shipped order
    Given I am default account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I wait until the count of displayed elements MyAccount.MyOrdersPage.OrderStatus is equal to 3
      And in dropdown MyAccount.MyOrdersPage.OrdersPeriodDropdown I select the option by text "2022"
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I wait for 2 seconds
    When I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButton with index 4
    Then I see MyAccount.OrderDetailsPage.TrackParcelButton is displayed
    When I click on MyAccount.OrderDetailsPage.DownloadInvoiceButton
    Then URL should not contain "error"
    When I click on MyAccount.OrderDetailsPage.CreditNoteLink
    Then URL should not contain "error"
    When I click on MyAccount.OrderDetailsPage.BackToOrdersPageLink
    Then URL should contain "myaccount/orders"
    When I click on MyAccount.MyOrdersPage.ListViewToggle
      And in dropdown MyAccount.MyOrdersPage.OrdersPeriodDropdown I select the option by text "2022"
    Then I see MyAccount.MyOrdersPage.ViewInvoiceLink is displayed
      And I see MyAccount.MyOrdersPage.ViewCreditNoteLink is displayed
    When I click on MyAccount.MyOrdersPage.ViewCreditNoteLink
    Then URL should not contain "error"
    When I click on MyAccount.MyOrdersPage.ViewInvoiceLink
    Then URL should not contain "error"

    Examples:
      | locale  | langCode |
      | default | default  |

  # TODO: Enable once data copy back is finished and order can be shipped in SAP
  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @MyOrders @P2 @ExcludeTH @ExcludeDB0 @ExcludeSIT
  @feature:PPL-393 @tms:UTR-12763
  Scenario Outline: User is able to download invoice and see credit note for shipped order
    Given I am default account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I wait until the count of displayed elements MyAccount.MyOrdersPage.OrderStatus is equal to 2
      And in dropdown MyAccount.MyOrdersPage.OrdersPeriodDropdown I select the option by text "2022"
    When I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButton with index 1
    Then I see MyAccount.OrderDetailsPage.TrackParcelButton is displayed
    When I click on MyAccount.OrderDetailsPage.DownloadInvoiceButton
    Then URL should not contain "error"
    When I click on MyAccount.OrderDetailsPage.CreditNoteLink
    Then URL should not contain "error"
    When I click on MyAccount.OrderDetailsPage.BackToOrdersPageLink
    Then URL should contain "myaccount/orders"
    When I click on MyAccount.MyOrdersPage.ListViewToggle
      And in dropdown MyAccount.MyOrdersPage.OrdersPeriodDropdown I select the option by text "2022"
    Then I see MyAccount.MyOrdersPage.ViewInvoiceLink is displayed
      And I see MyAccount.MyOrdersPage.ViewCreditNoteLink is displayed
    When I click on MyAccount.MyOrdersPage.ViewCreditNoteLink
    Then URL should not contain "error"
    When I click on MyAccount.MyOrdersPage.ViewInvoiceLink
    Then URL should not contain "error"

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @P3
  @feature:PPL-390 @tms:UTR-12772 @issue:PPL-2047
  Scenario Outline: User is able to get information about returning an item
    Given I am Henk account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.ViewOrderButton with index 1
    When I scroll to and click on MyAccount.OrderDetailsPage.ReturnItemButton
      And I get translation from lokalise for "ReturnInfo" and store it with key #ReturnInfo
      And I get translation from lokalise for "Faq" and store it with key #Faq
    Then I see MyAccount.OrderDetailsPage.ReturnText contains text "#ReturnInfo"
      And I see MyAccount.OrderDetailsPage.FAQButton contains text "#Faq"
    When I click on MyAccount.OrderDetailsPage.FAQButton
    Then I see the current page is FAQs

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @MyOrders @P3
  @feature:PPL-233 @tms:UTR-12773
  Scenario Outline: User can load more orders in list view
    Given I am Cross account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I wait until MyAccount.MyOrdersPage.ListViewToggle is displayed in 30 seconds
      And I click on MyAccount.MyOrdersPage.ListViewToggle
    Then the count of displayed elements MyAccount.MyOrdersPage.OrderNumberLink is equal to 10
    When I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
    Then the count of displayed elements MyAccount.MyOrdersPage.OrderNumberLink is greater than 45

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @MyOrders @P3
  @feature:PPL-252 @tms:UTR-13189
  Scenario Outline: User can filter orders on year
    Given I am Charles account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
    When in dropdown MyAccount.MyOrdersPage.OrdersPeriodDropdown I select the option by text "2023"
    Then I see MyAccount.MyOrdersPage.OrderDate with index 1 contains text "2023"
      And I see MyAccount.MyOrdersPage.OrderDate with index 3 contains text "2023"
      And I see MyAccount.MyOrdersPage.OrderDate with index 5 contains text "2023"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  # TODO: Enable once data copy back is finished and status can be added back
  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @P3 @ExcludeCK @ExcludeDB0
  @feature:PPL-232 @tms:UTR-13196
  Scenario Outline: User can only see 3 statuses for his orders
    Given I am default account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And in dropdown MyAccount.MyOrdersPage.OrdersPeriodDropdown I select the option by text "2022"
      And I click on MyAccount.MyOrdersPage.ListViewToggle
      And I get translation from lokalise for "OrderBeingPrepared" and store it with key #OrderBeingPrepared
      And I get translation from lokalise for "OrderShipped" and store it with key #OrderShipped
      And I get translation from lokalise for "OrderCancelled" and store it with key #OrderCancelled
    Then I see MyAccount.MyOrdersPage.ListOrderStatus with index 1 contains text "#OrderBeingPrepared"
      And I see MyAccount.MyOrdersPage.ListOrderStatus with index 4 contains text "#OrderShipped"
      And I see MyAccount.MyOrdersPage.ListOrderStatus with index 5 contains text "#OrderCancelled"

    Examples:
      | locale  | langCode |
      | default | default  |

  # TODO: Enable once data copy back is finished and status can be added back
  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @MyOrders @P3 @ExcludeTH @ExcludeDB0
  @feature:PPL-252 @tms:UTR-13196
  Scenario Outline: User can only see 3 statuses for his orders
    Given I am default account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And in dropdown MyAccount.MyOrdersPage.OrdersPeriodDropdown I select the option by text "2022"
      And I click on MyAccount.MyOrdersPage.ListViewToggle
      And I get translation from lokalise for "OrderBeingPrepared" and store it with key #OrderBeingPrepared
      And I get translation from lokalise for "OrderShipped" and store it with key #OrderShipped
      And I get translation from lokalise for "OrderCancelled" and store it with key #OrderCancelled
    Then I see MyAccount.MyOrdersPage.ListOrderStatus with index 1 contains text "#OrderShipped"
      And I see MyAccount.MyOrdersPage.ListOrderStatus with index 2 contains text "#OrderCancelled"
      And I see MyAccount.MyOrdersPage.ListOrderStatus with index 3 contains text "#OrderBeingPrepared"

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @P3
  @feature:PPL-20 @tms:UTR-13197
  Scenario Outline: User can see message that he has no orders and start shopping button
    Given I am on my account orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I get translation from lokalise for "NoOrders" and store it with key #NoOrdersMessage
      And I get translation from lokalise for "StartShopping" and store it with key #StartShopping
    Then I see MyAccount.MyOrdersPage.NoOrdersMessage contains text "#NoOrdersMessage"
      And I see MyAccount.MyOrdersPage.StartShoppingButton contains text "#StartShopping"
    When I click on MyAccount.MyOrdersPage.StartShoppingButton
    Then I see the current page is Homepage

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeCK @ExcludeUat
  @tms:UTR-15053
  Scenario Outline: User can see track and trace data on his orders
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I get translation from lokalise for "OrderNotCollected" and store it with key #OrderNotCollected
      And I get translation from lokalise for "OrderDelayed" and store it with key #OrderDelayed
      And I get translation from lokalise for "WeMissedYou" and store it with key #WeMissedYou
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I get translation from lokalise for "OrderRefused" and store it with key #OrderRefused
      And I get translation from lokalise for "Collected" and store it with key #Collected
      And I get translation from lokalise for "ReadyForPickUp" and store it with key #ReadyForPickUp
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I get translation from lokalise for "OrderDelivered" and store it with key #OrderDelivered
      And I get translation from lokalise for "OrderCancelled" and store it with key #OrderCancelled
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "OrderBeingPrepared" and store it with key #OrderBeingPrepared
    Then I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001185524 contains text "#OrderNotCollected"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001185524 contains text "SATURDAY, JULY 15"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001185516 contains text "#OrderDelayed"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001185516 contains text "FRIDAY, JULY 28"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184751 contains text "#WeMissedYou"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184751 contains text "SATURDAY, JULY 15"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184743 contains text "#OrderRefused"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184743 contains text "SATURDAY, JULY 15"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184748 contains text "#Collected"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184748 contains text "WEDNESDAY, JULY 26"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184746 contains text "#ReadyForPickUp"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184746 contains text "SATURDAY, JULY 15"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184715 contains text "#OrderDelivered"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184715 contains text "TUESDAY, JULY 11"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184527 contains text "#OrderCancelled"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184527 is not existing
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184525 contains text "#OutForDelivery"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184525 contains text "FRIDAY, AUGUST 4"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184521 contains text "#Shipped"
      # And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184521 contains text "Within 3 - 5 Working Days"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184520 contains text "#OrderBeingPrepared"
    # And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184520 contains text "Within 3 - 5 Working Days"

    Examples:
      | locale | langCode |
      | fi     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeTH @ExcludeUat
  @tms:UTR-15053
  Scenario Outline: User can see track and trace data on his orders
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I get translation from lokalise for "OrderNotCollected" and store it with key #OrderNotCollected
      And I get translation from lokalise for "OrderDelayed" and store it with key #OrderDelayed
      And I get translation from lokalise for "WeMissedYou" and store it with key #WeMissedYou
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I get translation from lokalise for "OrderRefused" and store it with key #OrderRefused
      And I get translation from lokalise for "Collected" and store it with key #Collected
      And I get translation from lokalise for "ReadyForPickUp" and store it with key #ReadyForPickUp
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I get translation from lokalise for "OrderDelivered" and store it with key #OrderDelivered
      And I get translation from lokalise for "OrderCancelled" and store it with key #OrderCancelled
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "OrderBeingPrepared" and store it with key #OrderBeingPrepared
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
    Then I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001185523 contains text "#OrderCancelled"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001185523 is not existing
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001185522 contains text "#OrderRefused"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001185522 contains text "Saturday, July 15"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184750 contains text "#OrderDelivered"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184750 contains text "Tuesday, July 11"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184747 contains text "#WeMissedYou"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184747 contains text "Saturday, July 15"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184745 contains text "#OrderDelayed"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184745 contains text "Friday, July 28"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184504 contains text "#OrderNotCollected"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184504 contains text "Saturday, July 15"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184503 contains text "#Collected"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184503 contains text "Wednesday, July 26"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184501 contains text "#ReadyForPickUp"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184501 contains text "Saturday, July 15"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184496 contains text "#OutForDelivery"
      And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184496 contains text "Friday, August 4"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184493 contains text "#OrderBeingPrepared"
      # And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184493 contains text "Within 3 - 5 Working Days"
      And I see MyAccount.MyOrdersPage.OrderDeliveryStatus with args 900001184491 contains text "#Shipped"
    # And I see MyAccount.MyOrdersPage.OrderEstimatedDelivery with args 900001184491 contains text "Within 3 - 5 Working Days"

    Examples:
      | locale | langCode |
      | se     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @CancelOrder @P2
  @tms:UTR-18238
  Scenario Outline: User can cancel their order in the first 30 min after placing from My Orders page
    Given I am cross site user on locale <locale> of langCode <langCode> on the payment page
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
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    When I navigate to orders page
      And I wait until MyAccount.MyOrdersPage.ViewOrderButton is clickable
      And I get translation from lokalise for "OrderCancelationButton" and store it with key #OrderCancelationButton
      And I get translation from lokalise for "OrderCancelationWarning" and store it with key #OrderCancelationWarning
      And I get translation from lokalise for "KeepButton" and store it with key #KeepButton
      And I get translation from lokalise for "OrderCancelationButton" and store it with key #CancelButton
      And I get translation from lokalise for "OrderCancelled" and store it with key #OrderCancelled
    When I click on MyAccount.OrderDetailsPage.CancelOrderButton
    Then I see MyAccount.OrderDetailsPage.CancelOrderButton contains text "#OrderCancelationButton"
      And I see MyAccount.OrderDetailsPage.OrderCancelationWarning contains text "#OrderCancelationWarning"
      And I see MyAccount.OrderDetailsPage.KeepButton contains text "#KeepButton"
      And I see MyAccount.OrderDetailsPage.CancelButton contains text "#CancelButton"
    Then I click on MyAccount.OrderDetailsPage.CancelButton
      And I wait for 3 seconds
      And I see MyAccount.OrderDetailsPage.OrderStatus contains text "#OrderCancelled"

    Examples:
      | locale | langCode |
      | es     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @CancelOrder @P2
  @tms:UTR-18239
  Scenario Outline: User can cancel their order in the first 30 min after placing but decide to keep it from My Orders page
    Given I am cross site user on locale <locale> of langCode <langCode> on the payment page
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
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    When I navigate to orders page
      And I wait for 5 seconds
      And I wait until MyAccount.MyOrdersPage.ViewOrderButton is clickable
      And I get translation from lokalise for "OrderCancelationButton" and store it with key #OrderCancelationButton
      And I get translation from lokalise for "OrderCancelationWarning" and store it with key #OrderCancelationWarning
      And I get translation from lokalise for "KeepButton" and store it with key #KeepButton
      And I get translation from lokalise for "OrderCancelationButton" and store it with key #CancelButton
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
    When I click on MyAccount.OrderDetailsPage.CancelOrderButton
    Then I see MyAccount.OrderDetailsPage.CancelOrderButton contains text "#OrderCancelationButton"
      And I see MyAccount.OrderDetailsPage.OrderCancelationWarning contains text "#OrderCancelationWarning"
      And I see MyAccount.OrderDetailsPage.KeepButton contains text "#KeepButton"
      And I see MyAccount.OrderDetailsPage.CancelButton contains text "#CancelButton"
    Then I click on MyAccount.OrderDetailsPage.KeepButton
      And I see MyAccount.OrderDetailsPage.CancelOrderButton is displayed
      And I see MyAccount.OrderDetailsPage.OrderStatus contains text "#OrderPlaced"

    Examples:
      | locale | langCode |
      | be     | default  |
