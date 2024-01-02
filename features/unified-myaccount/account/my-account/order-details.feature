Feature: Unified My Account - My order details

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @P2 @ExcludeSIT
  @feature:PPL-393 @tms:UTR-12596
  Scenario Outline: User is able to see all the details related to order in order details page
    Given I am Henk account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I store the numeric value of MyAccount.MyOrdersPage.OrderNumber with index 1 with key #OrderNumber
    When I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButton with index 1
      And I get translation from lokalise for "OrderDetailsInfo" and store it with key #OrderInfo
      And I get translation from lokalise for "Date" and store it with key #Date
      And I get translation from lokalise for "OrderType" and store it with key #OrderType
      And I get translation from lokalise for "DeliveryMethod" and store it with key #DeliveryMethod
      And I get translation from lokalise for "Payment" and store it with key #Payment
      And I get translation from lokalise for "Total" and store it with key #Total
    Then I see MyAccount.OrderDetailsPage.BackToOrdersPageLink is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetailsMessage contains text "#OrderInfo"
      And I see MyAccount.OrderDetailsPage.OrderStatus is displayed
      And I see MyAccount.OrderDetailsPage.OrderNumber contains text "#OrderNumber"
      And I see MyAccount.OrderDetailsPage.TrackParcelButton is not displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #Date is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #OrderType is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #DeliveryMethod is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #Total is displayed
    When I get translation from lokalise for "ProductName" and store it with key #ProductName
      And I get translation from lokalise for "Status" and store it with key #Status
      And I get translation from lokalise for "Color" and store it with key #Color
      And I get translation from lokalise for "Size" and store it with key #Size
      And I get translation from lokalise for "Quantity" and store it with key #Quantity
    Then I see MyAccount.OrderDetailsPage.OrderProductName is displayed
      And I see MyAccount.OrderDetailsPage.OrderOverview with text #ProductName is displayed
      # And I see MyAccount.OrderDetailsPage.OrderOverview with text #Status is displayed
      And I see MyAccount.OrderDetailsPage.OrderOverview with text #Color is displayed
      And I see MyAccount.OrderDetailsPage.OrderOverview with text #Quantity is displayed
    When I get translation from lokalise for "Subtotal" and store it with key #Subtotal
      And I get translation from lokalise for "Delivery" and store it with key #Delivery
      And I get translation from lokalise for "PromotionalDiscount" and store it with key #Discount
      And I get translation from lokalise for "DeliveryAddress" and store it with key #DeliveryAddress
      And I get translation from lokalise for "BillingAddress" and store it with key #BillingAddress
      And I get translation from lokalise for "Return" and store it with key #Return
    Then I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Subtotal is displayed
      And I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Delivery is displayed
      And I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Discount is displayed
      And I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Total is displayed
      And I see MyAccount.OrderDetailsPage.ShippingAddress contains text "#DeliveryAddress"
      And I see MyAccount.OrderDetailsPage.BillingAddress contains text "#BillingAddress"
    When I click on MyAccount.OrderDetailsPage.BackToOrdersPageLink
    Then URL should contain "myaccount/orders"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  # Track and trace scenarios for TH
  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeCK @ExcludeUat
  @tms:UTR-15693
  Scenario Outline: User can see progress stepper with sub-statuses for order in not collected status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001185524
      And I get translation from lokalise for "OrderNotCollected" and store it with key #OrderNotCollected
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "ReadyForPickUp" and store it with key #ReadyForPickUp
      And I get translation from lokalise for "OrderNotCollectedSubStatus" and store it with key #OrderNotCollectedSubStatus
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "SATURDAY, JULY 15"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.ReadyForPickUpStep contains text "#ReadyForPickUp"
      And I see MyAccount.OrderDetailsPage.OrderNotCollectedStep contains text "#OrderNotCollected"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 3
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
      And I store the numeric value of MyAccount.OrderDetailsPage.TrackingId with key #Id
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And I see MyAccount.OrderDetailsPage.TrackingId is displayed
      And I see the length of key #Id is equal to 17
    When I click on MyAccount.OrderDetailsPage.TrackingIdCopyButton
    Then I see MyAccount.OrderDetailsPage.TrackingIdCopyedMessage contains text "Copied to clipboard"
      And I see MyAccount.OrderDetailsPage.TrackingIdCopyedMessage contains text "#Id"
    When I click on MyAccount.OrderDetailsPage.OrderNotCollectedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderNotCollectedSubStatus"
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | fi     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeCK @ExcludeUat
  @tms:UTR-15395
  Scenario Outline: User can see progress stepper with sub-statuses for order in order delayed status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001185516
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I get translation from lokalise for "DelayedSubStatus" and store it with key #DelayedSubStatus
      And I get translation from lokalise for "OrderDelivered" and store it with key #OrderDelivered
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "FRIDAY, JULY 28"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.OutForDeliveryStep contains text "#OutForDelivery"
      And I see MyAccount.OrderDetailsPage.OrderDelayedSubStatus contains text "#DelayedSubStatus"
      And I see MyAccount.OrderDetailsPage.DeliveredStep contains text "#OrderDelivered"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 3
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
      And I store the numeric value of MyAccount.OrderDetailsPage.TrackingId with key #Id
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And I see MyAccount.OrderDetailsPage.TrackingId is displayed
      And I see the length of key #Id is equal to 17
    When I click on MyAccount.OrderDetailsPage.OutForDeliveryStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "Your order was picked up by the courier POSTEN."
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | dk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeCK @ExcludeUat
  @tms:UTR-15396
  Scenario Outline: User can see progress stepper with sub-statuses for order we missed you status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184751
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I get translation from lokalise for "WeMissedYouSubStatus" and store it with key #WeMissedYouSubStatus
      And I get translation from lokalise for "OrderDelivered" and store it with key #OrderDelivered
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "SATURDAY, JULY 15"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.OutForDeliveryStep contains text "#OutForDelivery"
      And I see MyAccount.OrderDetailsPage.WeMissedYouSubStatus contains text "#WeMissedYouSubStatus"
      And I see MyAccount.OrderDetailsPage.DeliveredStep contains text "#OrderDelivered"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 3
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
      And I store the numeric value of MyAccount.OrderDetailsPage.TrackingId with key #Id
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And I see MyAccount.OrderDetailsPage.TrackingId is displayed
      And I see the length of key #Id is equal to 17
    When I click on MyAccount.OrderDetailsPage.OutForDeliveryStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "Your order was picked up by the courier POSTEN."
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | se     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeCK @ExcludeUat
  @tms:UTR-15397
  Scenario Outline: User can see progress stepper with sub-statuses for order in order refused status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184743
      And I get translation from lokalise for "OrderRefused" and store it with key #OrderRefused
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I get translation from lokalise for "Collected" and store it with key #Collected
      And I get translation from lokalise for "OrderRefusedSubStatus" and store it with key #OrderRefusedSubStatus
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "SATURDAY, JULY 15"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.OutForDeliveryStep contains text "#OutForDelivery"
      And I see MyAccount.OrderDetailsPage.OrderRefusedStep contains text "#OrderRefused"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 4
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
      And I store the numeric value of MyAccount.OrderDetailsPage.TrackingId with key #Id
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And I see MyAccount.OrderDetailsPage.TrackingId is displayed
      And I see the length of key #Id is equal to 17
    When I click on MyAccount.OrderDetailsPage.OutForDeliveryStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "Your order was picked up by the courier POSTEN."
    When I click on MyAccount.OrderDetailsPage.OrderRefusedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderRefusedSubStatus"
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | fi     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeCK @ExcludeUat
  @tms:UTR-15727
  Scenario Outline: User can see progress stepper with sub-statuses for order in collected status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184748
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "ReadyForPickUp" and store it with key #ReadyForPickUp
      And I get translation from lokalise for "Collected" and store it with key #Collected
      And I get translation from lokalise for "OrderCollectedSuccessfully" and store it with key #OrderCollectedSuccessfully
      And I get translation from lokalise for "OrderCancelationHeader" and store it with key #OrderCancelationHeader
      And I get translation from lokalise for "OrderCancelationSubtitleNo" and store it with key #OrderCancelationSubtitleNo
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "WEDNESDAY, JULY 26"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.ReadyForPickUpStep contains text "#ReadyForPickUp"
      And I see MyAccount.OrderDetailsPage.CollectedStep contains text "#Collected"
      And I see MyAccount.OrderDetailsPage.OrderCancelationHeader contains text "#OrderCancelationHeader"
      And I see MyAccount.OrderDetailsPage.OrderCancelationSubtitle contains text "#OrderCancelationSubtitleNo"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 3
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
      And I store the numeric value of MyAccount.OrderDetailsPage.TrackingId with key #Id
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And I see MyAccount.OrderDetailsPage.TrackingId is displayed
      And I see the length of key #Id is equal to 17
    When I click on MyAccount.OrderDetailsPage.CollectedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderCollectedSuccessfully"
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | dk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeCK @ExcludeUat
  @tms:UTR-15394
  Scenario Outline: User can see progress stepper with sub-statuses for order in ready to pick up status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184746
      And I get translation from lokalise for "ReadyForPickUp" and store it with key #ReadyForPickUp
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I get translation from lokalise for "Collected" and store it with key #Collected
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "SATURDAY, JULY 15"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.ReadyForPickUpStep contains text "#ReadyForPickUp"
      And I see MyAccount.OrderDetailsPage.CollectedStep contains text "#Collected"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 2
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
      And I store the numeric value of MyAccount.OrderDetailsPage.TrackingId with key #Id
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And I see MyAccount.OrderDetailsPage.TrackingId is displayed
      And I see the length of key #Id is equal to 17
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | se     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeCK @ExcludeUat
  @tms:UTR-15730
  Scenario Outline: User can see progress stepper with sub-statuses for order in delivered status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184715
      And I get translation from lokalise for "OrderDelivered" and store it with key #OrderDelivered
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I get translation from lokalise for "Collected" and store it with key #Collected
      And I get translation from lokalise for "OrderSuccessfullyDelivered" and store it with key #OrderSuccessfullyDelivered
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "TUESDAY, JULY 11"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.OutForDeliveryStep contains text "#OutForDelivery"
      And I see MyAccount.OrderDetailsPage.DeliveredStep contains text "#OrderDelivered"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 4
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
      And I store the numeric value of MyAccount.OrderDetailsPage.TrackingId with key #Id
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And I see MyAccount.OrderDetailsPage.TrackingId is displayed
      And I see the length of key #Id is equal to 17
    When I click on MyAccount.OrderDetailsPage.OutForDeliveryStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "Your order was picked up by the courier POSTEN."
    When I click on MyAccount.OrderDetailsPage.DeliveredStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderSuccessfullyDelivered"
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | fi     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeCK @ExcludeUat
  @tms:UTR-15731
  Scenario Outline: User cannot see progress stepper with sub-statuses for order in cancel status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184527
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery is not displayed
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep is not displayed
      And I see MyAccount.OrderDetailsPage.ShippedStep is not displayed
      And I see MyAccount.OrderDetailsPage.OutForDeliveryStep is not displayed
      And I see MyAccount.OrderDetailsPage.DeliveredStep is not displayed

    Examples:
      | locale | langCode |
      | dk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeCK @ExcludeUat
  @tms:UTR-15732
  Scenario Outline: User can see progress stepper with sub-statuses for order in out for delivery status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184525
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I get translation from lokalise for "OrderDelivered" and store it with key #OrderDelivered
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "FRIDAY, AUGUST 4"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.OutForDeliveryStep contains text "#OutForDelivery"
      And I see MyAccount.OrderDetailsPage.DeliveredStep contains text "#OrderDelivered"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 3
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
      And I store the numeric value of MyAccount.OrderDetailsPage.TrackingId with key #Id
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And I see MyAccount.OrderDetailsPage.TrackingId is displayed
      And I see the length of key #Id is equal to 17
    When I click on MyAccount.OrderDetailsPage.OutForDeliveryStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "Your order was picked up by the courier POSTEN."
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | se     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeCK @ExcludeUat
  @tms:UTR-15393
  Scenario Outline: User can see progress stepper with sub-statuses for order in shipped status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184521
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I get translation from lokalise for "OrderDelivered" and store it with key #OrderDelivered
      # Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "Within 3 - 5 working days"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.OutForDeliveryStep contains text "#OutForDelivery"
      And I see MyAccount.OrderDetailsPage.DeliveredStep contains text "#OrderDelivered"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 2
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | fi     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeCK @ExcludeUat
  @tms:UTR-15737
  Scenario Outline: User can see progress stepper with sub-statuses for order in order is being prepared status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184520
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I get translation from lokalise for "OrderDelivered" and store it with key #OrderDelivered
      # Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "Within 3 - 5 working days"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.OutForDeliveryStep contains text "#OutForDelivery"
      And I see MyAccount.OrderDetailsPage.DeliveredStep contains text "#OrderDelivered"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 1
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"

    Examples:
      | locale | langCode |
      | dk     | default  |

  # Track and trace scenarios for CK
  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeTH @ExcludeUat
  @tms:UTR-15731
  Scenario Outline: User cannot see progress stepper with sub-statuses for order in cancel status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001185523
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery is not displayed
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep is not displayed
      And I see MyAccount.OrderDetailsPage.ShippedStep is not displayed
      And I see MyAccount.OrderDetailsPage.OutForDeliveryStep is not displayed
      And I see MyAccount.OrderDetailsPage.DeliveredStep is not displayed

    Examples:
      | locale | langCode |
      | fi     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeTH @ExcludeUat
  @tms:UTR-15397
  Scenario Outline: User can see progress stepper with sub-statuses for order in order refused status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001185522
      And I get translation from lokalise for "OrderRefused" and store it with key #OrderRefused
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I get translation from lokalise for "Collected" and store it with key #Collected
      And I get translation from lokalise for "OrderRefusedSubStatus" and store it with key #OrderRefusedSubStatus
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "SATURDAY, JULY 15"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.OutForDeliveryStep contains text "#OutForDelivery"
      And I see MyAccount.OrderDetailsPage.OrderRefusedStep contains text "#OrderRefused"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 4
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
      And I store the numeric value of MyAccount.OrderDetailsPage.TrackingId with key #Id
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And I see MyAccount.OrderDetailsPage.TrackingId is displayed
      And I see the length of key #Id is equal to 17
    When I click on MyAccount.OrderDetailsPage.OutForDeliveryStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "Your order was picked up by the courier POSTEN."
    When I click on MyAccount.OrderDetailsPage.OrderRefusedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderRefusedSubStatus"
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | dk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeTH @ExcludeUat
  @tms:UTR-15730
  Scenario Outline: User can see progress stepper with sub-statuses for order in delivered status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184750
      And I get translation from lokalise for "OrderDelivered" and store it with key #OrderDelivered
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I get translation from lokalise for "Collected" and store it with key #Collected
      And I get translation from lokalise for "OrderSuccessfullyDelivered" and store it with key #OrderSuccessfullyDelivered
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "TUESDAY, JULY 11"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.OutForDeliveryStep contains text "#OutForDelivery"
      And I see MyAccount.OrderDetailsPage.DeliveredStep contains text "#OrderDelivered"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 4
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
      And I store the numeric value of MyAccount.OrderDetailsPage.TrackingId with key #Id
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And I see MyAccount.OrderDetailsPage.TrackingId is displayed
      And I see the length of key #Id is equal to 17
    When I click on MyAccount.OrderDetailsPage.OutForDeliveryStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "Your order was picked up by the courier POSTEN."
    When I click on MyAccount.OrderDetailsPage.DeliveredStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderSuccessfullyDelivered"
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | se     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeTH @ExcludeUat
  @tms:UTR-15396
  Scenario Outline: User can see progress stepper with sub-statuses for order we missed you status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184747
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I get translation from lokalise for "WeMissedYouSubStatus" and store it with key #WeMissedYouSubStatus
      And I get translation from lokalise for "OrderDelivered" and store it with key #OrderDelivered
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "SATURDAY, JULY 15"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.OutForDeliveryStep contains text "#OutForDelivery"
      And I see MyAccount.OrderDetailsPage.WeMissedYouSubStatus contains text "#WeMissedYouSubStatus"
      And I see MyAccount.OrderDetailsPage.DeliveredStep contains text "#OrderDelivered"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 3
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
      And I store the numeric value of MyAccount.OrderDetailsPage.TrackingId with key #Id
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And I see MyAccount.OrderDetailsPage.TrackingId is displayed
      And I see the length of key #Id is equal to 17
    When I click on MyAccount.OrderDetailsPage.OutForDeliveryStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "Your order was picked up by the courier POSTEN."
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | fi     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeTH @ExcludeUat
  @tms:UTR-15395
  Scenario Outline: User can see progress stepper with sub-statuses for order in order delayed status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184745
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I get translation from lokalise for "DelayedSubStatus" and store it with key #DelayedSubStatus
      And I get translation from lokalise for "OrderDelivered" and store it with key #OrderDelivered
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "FRIDAY, JULY 28"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.OutForDeliveryStep contains text "#OutForDelivery"
      And I see MyAccount.OrderDetailsPage.OrderDelayedSubStatus contains text "#DelayedSubStatus"
      And I see MyAccount.OrderDetailsPage.DeliveredStep contains text "#OrderDelivered"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 3
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
      And I store the numeric value of MyAccount.OrderDetailsPage.TrackingId with key #Id
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And I see MyAccount.OrderDetailsPage.TrackingId is displayed
      And I see the length of key #Id is equal to 17
    When I click on MyAccount.OrderDetailsPage.OutForDeliveryStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "Your order was picked up by the courier POSTEN."
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | dk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeTH @ExcludeUat
  @tms:UTR-15693
  Scenario Outline: User can see progress stepper with sub-statuses for order in not collected status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184504
      And I get translation from lokalise for "OrderNotCollected" and store it with key #OrderNotCollected
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "ReadyForPickUp" and store it with key #ReadyForPickUp
      And I get translation from lokalise for "OrderNotCollectedSubStatus" and store it with key #OrderNotCollectedSubStatus
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "SATURDAY, JULY 15"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.ReadyForPickUpStep contains text "#ReadyForPickUp"
      And I see MyAccount.OrderDetailsPage.OrderNotCollectedStep contains text "#OrderNotCollected"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 3
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
      And I store the numeric value of MyAccount.OrderDetailsPage.TrackingId with key #Id
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And I see MyAccount.OrderDetailsPage.TrackingId is displayed
      And I see the length of key #Id is equal to 17
    When I click on MyAccount.OrderDetailsPage.TrackingIdCopyButton
    Then I see MyAccount.OrderDetailsPage.TrackingIdCopyedMessage contains text "Copied to clipboard"
      And I see MyAccount.OrderDetailsPage.TrackingIdCopyedMessage contains text "#Id"
    When I click on MyAccount.OrderDetailsPage.OrderNotCollectedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderNotCollectedSubStatus"
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | se     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeTH @ExcludeUat
  @tms:UTR-15727
  Scenario Outline: User can see progress stepper with sub-statuses for order in collected status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184503
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "ReadyForPickUp" and store it with key #ReadyForPickUp
      And I get translation from lokalise for "Collected" and store it with key #Collected
      And I get translation from lokalise for "OrderCollectedSuccessfully" and store it with key #OrderCollectedSuccessfully
      And I get translation from lokalise for "OrderCancelationHeader" and store it with key #OrderCancelationHeader
      And I get translation from lokalise for "OrderCancelationSubtitleNo" and store it with key #OrderCancelationSubtitleNo
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "WEDNESDAY, JULY 26"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.ReadyForPickUpStep contains text "#ReadyForPickUp"
      And I see MyAccount.OrderDetailsPage.CollectedStep contains text "#Collected"
      And I see MyAccount.OrderDetailsPage.OrderCancelationHeader contains text "#OrderCancelationHeader"
      And I see MyAccount.OrderDetailsPage.OrderCancelationSubtitle contains text "#OrderCancelationSubtitleNo"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 3
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
      And I store the numeric value of MyAccount.OrderDetailsPage.TrackingId with key #Id
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And I see MyAccount.OrderDetailsPage.TrackingId is displayed
      And I see the length of key #Id is equal to 17
    When I click on MyAccount.OrderDetailsPage.CollectedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderCollectedSuccessfully"
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | fi     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeTH @ExcludeUat
  @tms:UTR-15394
  Scenario Outline: User can see progress stepper with sub-statuses for order in ready to pick up status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184501
      And I get translation from lokalise for "ReadyForPickUp" and store it with key #ReadyForPickUp
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I get translation from lokalise for "Collected" and store it with key #Collected
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "SATURDAY, JULY 15"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.ReadyForPickUpStep contains text "#ReadyForPickUp"
      And I see MyAccount.OrderDetailsPage.CollectedStep contains text "#Collected"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 2
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
      And I store the numeric value of MyAccount.OrderDetailsPage.TrackingId with key #Id
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And I see MyAccount.OrderDetailsPage.TrackingId is displayed
      And I see the length of key #Id is equal to 17
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | dk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeTH @ExcludeUat
  @tms:UTR-15732
  Scenario Outline: User can see progress stepper with sub-statuses for order in out for delivery status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184496
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I get translation from lokalise for "OrderDelivered" and store it with key #OrderDelivered
    Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "FRIDAY, AUGUST 4"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.OutForDeliveryStep contains text "#OutForDelivery"
      And I see MyAccount.OrderDetailsPage.DeliveredStep contains text "#OrderDelivered"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 3
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
      And I store the numeric value of MyAccount.OrderDetailsPage.TrackingId with key #Id
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And I see MyAccount.OrderDetailsPage.TrackingId is displayed
      And I see the length of key #Id is equal to 17
    When I click on MyAccount.OrderDetailsPage.OutForDeliveryStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "Your order was picked up by the courier POSTEN."
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | se     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeTH @ExcludeUat
  @tms:UTR-15737
  Scenario Outline: User can see progress stepper with sub-statuses for order in order is being prepared status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184493
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I get translation from lokalise for "OrderDelivered" and store it with key #OrderDelivered
      # Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "Within 3 - 5 working days"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.OutForDeliveryStep contains text "#OutForDelivery"
      And I see MyAccount.OrderDetailsPage.DeliveredStep contains text "#OrderDelivered"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 1
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"

    Examples:
      | locale | langCode |
      | fi     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&Trace @P2 @ExcludeTH @ExcludeUat
  @tms:UTR-15393
  Scenario Outline: User can see progress stepper with sub-statuses for order in shipped status
    Given I am T&T account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I click on MyAccount.MyOrdersPage.LoadMoreButton
      And I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButtonById with args 900001184491
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I get translation from lokalise for "OrderProccessedInWarehouse" and store it with key #OrderProccessedInWarehouse
      And I get translation from lokalise for "Shipped" and store it with key #Shipped
      And I get translation from lokalise for "PickedUpByCarrier" and store it with key #PickedUpByCarrier
      And I get translation from lokalise for "OutForDelivery" and store it with key #OutForDelivery
      And I get translation from lokalise for "OrderDelivered" and store it with key #OrderDelivered
      # Then I see MyAccount.OrderDetailsPage.OrderEstimatedDelivery contains text "Within 3 - 5 working days"
      And I see MyAccount.OrderDetailsPage.OrderPlacedStep contains text "#OrderPlaced"
      And I see MyAccount.OrderDetailsPage.ShippedStep contains text "#Shipped"
      And I see MyAccount.OrderDetailsPage.OutForDeliveryStep contains text "#OutForDelivery"
      And I see MyAccount.OrderDetailsPage.DeliveredStep contains text "#OrderDelivered"
      And the count of displayed elements MyAccount.OrderDetailsPage.StepChevron is equal to 2
    When I click on MyAccount.OrderDetailsPage.OrderPlacedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#OrderProccessedInWarehouse"
    When I click on MyAccount.OrderDetailsPage.ShippedStep
    Then I see MyAccount.OrderDetailsPage.SubStatus contains text "#PickedUpByCarrier"
      And the count of displayed elements MyAccount.OrderDetailsPage.SubStatus is equal to 1

    Examples:
      | locale | langCode |
      | dk     | default  |

  # Track and trace scenarios for guest user TH

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&TraceGuest @P2 @ExcludeUat @ExcludeCK
  @tms:UTR-17454
  Scenario Outline: Guest user can search for their order and see all the relevant information
    Given I am on locale <locale> of url /services/view-order with accepted cookies
      And I type "900001184715" in the field MyAccount.OrderDetailsPage.OrderInput
      And I type "12345" in the field MyAccount.OrderDetailsPage.PostCodeInput
      And I click on MyAccount.OrderDetailsPage.ViewOrderButton
      And I get translation from lokalise for "Date" and store it with key #Date
      And I get translation from lokalise for "OrderType" and store it with key #OrderType
      And I get translation from lokalise for "DeliveryMethod" and store it with key #DeliveryMethod
      And I get translation from lokalise for "Payment" and store it with key #Payment
      And I get translation from lokalise for "Total" and store it with key #Total
      And I see MyAccount.OrderDetailsPage.OrderNumber contains text "900001184715"
      And I see MyAccount.OrderDetailsPage.TrackParcelButton is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #Date is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #OrderType is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #DeliveryMethod is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #Total is displayed
    When I get translation from lokalise for "ProductName" and store it with key #ProductName
      And I get translation from lokalise for "Status" and store it with key #Status
      And I get translation from lokalise for "Color" and store it with key #Color
      And I get translation from lokalise for "Size" and store it with key #Size
      And I get translation from lokalise for "Quantity" and store it with key #Quantity
    Then I see MyAccount.OrderDetailsPage.OrderProductName is displayed
      And I see MyAccount.OrderDetailsPage.OrderOverview with text #ProductName is displayed
      And I see MyAccount.OrderDetailsPage.OrderOverview with text #Color is displayed
      And I see MyAccount.OrderDetailsPage.OrderOverview with text #Quantity is displayed
    When I get translation from lokalise for "Subtotal" and store it with key #Subtotal
      And I get translation from lokalise for "Delivery" and store it with key #Delivery
      And I get translation from lokalise for "PromotionalDiscount" and store it with key #Discount
      And I get translation from lokalise for "DeliveryAddress" and store it with key #DeliveryAddress
      And I get translation from lokalise for "Return" and store it with key #Return
    Then I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Subtotal is displayed
      And I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Delivery is displayed
      And I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Discount is displayed
      And I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Total is displayed
      And I see MyAccount.OrderDetailsPage.ShippingAddress contains text "#DeliveryAddress"

    Examples:
      | locale | langCode |
      | fi     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&TraceGuest @P2 @ExcludeUat @ExcludeCK
  @tms:UTR-17453
  Scenario Outline: Registered user can search for their order and see all the relevant information using the track order page
    Given I am Henk account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I wait for 2 seconds
      And I navigate to page services/view-order
      And I type "900001184715" in the field MyAccount.OrderDetailsPage.OrderInput
      And I type "12345" in the field MyAccount.OrderDetailsPage.PostCodeInput
      And I click on MyAccount.OrderDetailsPage.ViewOrderButton
      And I get translation from lokalise for "Date" and store it with key #Date
      And I get translation from lokalise for "OrderType" and store it with key #OrderType
      And I get translation from lokalise for "DeliveryMethod" and store it with key #DeliveryMethod
      And I get translation from lokalise for "Payment" and store it with key #Payment
      And I get translation from lokalise for "Total" and store it with key #Total
      And I see MyAccount.OrderDetailsPage.OrderNumber contains text "900001184715"
      And I see MyAccount.OrderDetailsPage.TrackParcelButton is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #Date is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #OrderType is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #DeliveryMethod is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #Total is displayed
    When I get translation from lokalise for "ProductName" and store it with key #ProductName
      And I get translation from lokalise for "Status" and store it with key #Status
      And I get translation from lokalise for "Color" and store it with key #Color
      And I get translation from lokalise for "Size" and store it with key #Size
      And I get translation from lokalise for "Quantity" and store it with key #Quantity
    Then I see MyAccount.OrderDetailsPage.OrderProductName is displayed
      And I see MyAccount.OrderDetailsPage.OrderOverview with text #ProductName is displayed
      And I see MyAccount.OrderDetailsPage.OrderOverview with text #Color is displayed
      And I see MyAccount.OrderDetailsPage.OrderOverview with text #Quantity is displayed
    When I get translation from lokalise for "Subtotal" and store it with key #Subtotal
      And I get translation from lokalise for "Delivery" and store it with key #Delivery
      And I get translation from lokalise for "PromotionalDiscount" and store it with key #Discount
      And I get translation from lokalise for "DeliveryAddress" and store it with key #DeliveryAddress
      And I get translation from lokalise for "Return" and store it with key #Return
    Then I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Subtotal is displayed
      And I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Delivery is displayed
      And I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Discount is displayed
      And I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Total is displayed
      And I see MyAccount.OrderDetailsPage.ShippingAddress contains text "#DeliveryAddress"

    Examples:
      | locale | langCode |
      | fi     | default  |

  # Track and trace scenarios for guest user CK

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&TraceGuest @P2 @ExcludeUat @ExcludeTH
  @tms:UTR-17454
  Scenario Outline: Guest user can search for their order and see all the relevant information
    Given I am on locale <locale> of url /services/view-order with accepted cookies
      And I type "900001184503" in the field MyAccount.OrderDetailsPage.OrderInput
      And I type "00100" in the field MyAccount.OrderDetailsPage.PostCodeInput
      And I click on MyAccount.OrderDetailsPage.ViewOrderButton
      And I get translation from lokalise for "Date" and store it with key #Date
      And I get translation from lokalise for "OrderType" and store it with key #OrderType
      And I get translation from lokalise for "DeliveryMethod" and store it with key #DeliveryMethod
      And I get translation from lokalise for "Payment" and store it with key #Payment
      And I get translation from lokalise for "Total" and store it with key #Total
      And I see MyAccount.OrderDetailsPage.OrderNumber contains text "900001184503"
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #Date is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #OrderType is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #DeliveryMethod is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #Total is displayed
    When I get translation from lokalise for "ProductName" and store it with key #ProductName
      And I get translation from lokalise for "Status" and store it with key #Status
      And I get translation from lokalise for "Color" and store it with key #Color
      And I get translation from lokalise for "Size" and store it with key #Size
      And I get translation from lokalise for "Quantity" and store it with key #Quantity
    Then I see MyAccount.OrderDetailsPage.OrderProductName is displayed
      And I see MyAccount.OrderDetailsPage.OrderOverview with text #ProductName is displayed
      And I see MyAccount.OrderDetailsPage.OrderOverview with text #Color is displayed
      And I see MyAccount.OrderDetailsPage.OrderOverview with text #Quantity is displayed
    When I get translation from lokalise for "Subtotal" and store it with key #Subtotal
      And I get translation from lokalise for "Delivery" and store it with key #Delivery
      And I get translation from lokalise for "PromotionalDiscount" and store it with key #Discount
      And I get translation from lokalise for "DeliveryAddress" and store it with key #DeliveryAddress
      And I get translation from lokalise for "Return" and store it with key #Return
    Then I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Subtotal is displayed
      And I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Delivery is displayed
      And I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Discount is displayed
      And I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Total is displayed
      And I see MyAccount.OrderDetailsPage.ShippingAddress contains text "#DeliveryAddress"

    Examples:
      | locale | langCode |
      | fi     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&TraceGuest @P2 @ExcludeUat @ExcludeTH
  @tms:UTR-17453
  Scenario Outline: Registered user can search for their order and see all the relevant information using the track order page
    Given I am Henk account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I wait for 2 seconds
      And I navigate to page services/view-order
      And I type "900001184503" in the field MyAccount.OrderDetailsPage.OrderInput
      And I type "00100" in the field MyAccount.OrderDetailsPage.PostCodeInput
      And I click on MyAccount.OrderDetailsPage.ViewOrderButton
      And I get translation from lokalise for "Date" and store it with key #Date
      And I get translation from lokalise for "OrderType" and store it with key #OrderType
      And I get translation from lokalise for "DeliveryMethod" and store it with key #DeliveryMethod
      And I get translation from lokalise for "Payment" and store it with key #Payment
      And I get translation from lokalise for "Total" and store it with key #Total
      And I see MyAccount.OrderDetailsPage.OrderNumber contains text "900001184503"
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #Date is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #OrderType is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #DeliveryMethod is displayed
      And I see MyAccount.OrderDetailsPage.OrderDetails with text #Total is displayed
    When I get translation from lokalise for "ProductName" and store it with key #ProductName
      And I get translation from lokalise for "Status" and store it with key #Status
      And I get translation from lokalise for "Color" and store it with key #Color
      And I get translation from lokalise for "Size" and store it with key #Size
      And I get translation from lokalise for "Quantity" and store it with key #Quantity
    Then I see MyAccount.OrderDetailsPage.OrderProductName is displayed
      And I see MyAccount.OrderDetailsPage.OrderOverview with text #ProductName is displayed
      And I see MyAccount.OrderDetailsPage.OrderOverview with text #Color is displayed
      And I see MyAccount.OrderDetailsPage.OrderOverview with text #Quantity is displayed
    When I get translation from lokalise for "Subtotal" and store it with key #Subtotal
      And I get translation from lokalise for "Delivery" and store it with key #Delivery
      And I get translation from lokalise for "PromotionalDiscount" and store it with key #Discount
      And I get translation from lokalise for "DeliveryAddress" and store it with key #DeliveryAddress
      And I get translation from lokalise for "Return" and store it with key #Return
    Then I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Subtotal is displayed
      And I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Delivery is displayed
      And I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Discount is displayed
      And I see MyAccount.OrderDetailsPage.PriceInfoSection with text #Total is displayed
      And I see MyAccount.OrderDetailsPage.ShippingAddress contains text "#DeliveryAddress"

    Examples:
      | locale | langCode |
      | fi     | default  |

  # Track and trace scenarios for guest - common

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&TraceGuest @P2
  @tms:UTR-17451
  Scenario Outline: Guest user can see the corresponding errors when inputting wrong information
    Given I am on locale <locale> of url /services/view-order with accepted cookies
      And I see MyAccount.OrderDetailsPage.SignIn is displayed
      And I click on MyAccount.OrderDetailsPage.ViewOrderButton
      And I get translation from lokalise for "OrderNumberNotEntered" and store it with key #OrderNumberNotEntered
      And I see MyAccount.OrderDetailsPage.OrderError contains text "#OrderNumberNotEntered"
      And I get translation from lokalise for "PostCodeNotEntered" and store it with key #PostCodeNotEntered
      And I see MyAccount.OrderDetailsPage.PostCodeError contains text "#PostCodeNotEntered"
      And I type "12" in the field MyAccount.OrderDetailsPage.PostCodeInput
    When I click on MyAccount.OrderDetailsPage.ViewOrderButton
      And I see MyAccount.OrderDetailsPage.PostCodeError is displayed
      And I get translation from lokalise for "InvalidPostCode" and store it with key #InvalidPostCode
      And I see MyAccount.OrderDetailsPage.PostCodeError contains text "#InvalidPostCode"
      And I type "abcd" in the field MyAccount.OrderDetailsPage.OrderInput
      And I type "345" in the field MyAccount.OrderDetailsPage.PostCodeInput
    When I click on MyAccount.OrderDetailsPage.ViewOrderButton
    When I click on MyAccount.OrderDetailsPage.ViewOrderButton
      And I get translation from lokalise for "SearchOrderError" and store it with key #SearchOrderError
      And I see MyAccount.OrderDetailsPage.SearchOrderError contains text "#SearchOrderError"

    Examples:
      | locale | langCode |
      | fi     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @MyOrders @Track&TraceGuest @P3 @ExcludeTH
  @tms:UTR-17413
  Scenario Outline: Guest user can register on the tracking page and will remain on it
    Given There is 1 account
      And I am on services/view-order page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type "user1#email" in the field MyAccount.RegisterPopUp.EmailField
      And I type "user1#password" in the field MyAccount.RegisterPopUp.PasswordField
      And I click on MyAccount.RegisterPopUp.TermsAndConditionsCheckbox
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
      And I scroll to and click on MyAccount.RegisterPopUp.NewsletterNoButton
    Then URL should contain "/view-order"
      And I see MyAccount.OrderDetailsPage.SignIn is not displayed

    Examples:
      | locale | langCode |
      | dk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&TraceGuest @P3
  @tms:UTR-17414
  Scenario Outline: Guest user can login on order tracking page and will be redirected to my order page
    Given I am on services/view-order page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
      And I see MyAccount.OrderDetailsPage.SignIn is displayed
    # And I get translation from lokalise for "OrderTrackSignInMessage" and store it with key #OrderTrackSignInMessage
    # And I see MyAccount.OrderDetailsPage.SignIn with href sign in contains text "#OrderTrackSignInMessage"
    When I sign in with user "my.account.charles.automation@outlook.com" and password "AutoNation2023"
      And I wait for 1 seconds
    Then URL should contain "myaccount/orders"
    Then I see MyAccount.AccountFlyout.FlyMenuSignIn is not displayed

    Examples:
      | locale | langCode |
      | fi     | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @Track&TraceGuest @P2
  @tms:UTR-18010
  Scenario Outline: Guest user can navigate to the guest order tracking page via the footer link on the homepage
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I scroll to the element Experience.Footer.OrderStatus
      And I click on Experience.Footer.OrderStatus
    Then URL should contain "services/view-order"

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @CancelOrder @P2
  @tms:UTR-18241
  Scenario Outline: User can cancel their order in the first 30 min after placing from the order details page
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
      And I store the numeric value of MyAccount.MyOrdersPage.OrderNumber with index 1 with key #OrderNumber
    When I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButton with index 1
      And I wait until MyAccount.OrderDetailsPage.OrderDetails is displayed
      And I get translation from lokalise for "OrderCancelationButton" and store it with key #OrderCancelationButton
      And I get translation from lokalise for "OrderCancelationWarning" and store it with key #OrderCancelationWarning
      And I get translation from lokalise for "KeepButton" and store it with key #KeepButton
      And I get translation from lokalise for "OrderCancelationButton" and store it with key #CancelButton
      And I get translation from lokalise for "OrderCancelationSubtitleYes" and store it with key #OrderCancelationSubtitleYes
      And I get translation from lokalise for "OrderCancelled" and store it with key #OrderCancelled
      And I see MyAccount.OrderDetailsPage.OrderCancelationSubtitle contains text "#OrderCancelationSubtitleYes"
    When I click on MyAccount.OrderDetailsPage.CancelOrderButton
    Then I see MyAccount.OrderDetailsPage.CancelOrderButton contains text "#OrderCancelationButton"
      And I see MyAccount.OrderDetailsPage.OrderCancelationWarning contains text "#OrderCancelationWarning"
      And I see MyAccount.OrderDetailsPage.KeepButton contains text "#KeepButton"
      And I see MyAccount.OrderDetailsPage.CancelButton contains text "#CancelButton"
    Then I click on MyAccount.OrderDetailsPage.CancelButton
      And I see MyAccount.OrderDetailsPage.CancelOrderButton is not displayed
      And I see MyAccount.OrderDetailsPage.OrderStatus contains text "#OrderCancelled"

    Examples:
      | locale | langCode |
      | ee     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyOrders @CancelOrder @P2
  @tms:UTR-18240
  Scenario Outline: User can cancel their order in the first 30 min after placing but decide to keep it from the order details page
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
      And I store the numeric value of MyAccount.MyOrdersPage.OrderNumber with index 1 with key #OrderNumber
    When I scroll to and click on MyAccount.MyOrdersPage.ViewOrderButton with index 1
      And I wait until MyAccount.OrderDetailsPage.OrderDetails is displayed
      And I get translation from lokalise for "OrderCancelationButton" and store it with key #OrderCancelationButton
      And I get translation from lokalise for "OrderCancelationWarning" and store it with key #OrderCancelationWarning
      And I get translation from lokalise for "KeepButton" and store it with key #KeepButton
      And I get translation from lokalise for "OrderCancelationButton" and store it with key #CancelButton
      And I get translation from lokalise for "OrderCancelationSubtitleYes" and store it with key #OrderCancelationSubtitleYes
      And I get translation from lokalise for "OrderPlaced" and store it with key #OrderPlaced
      And I see MyAccount.OrderDetailsPage.OrderCancelationSubtitle contains text "#OrderCancelationSubtitleYes"
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
      | at     | default  |
