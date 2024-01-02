Feature: Unified Checkout - Payment Page - OOS/Insufficient Stock Items

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @UnifiedCheckout @StockTest @ShippingPage
  @feature:EESCK-6666
  Scenario Outline: Out of Stock Item - For sold out product items I am unable to place an order
    Given There are 1 product items with 0% discount of locale <locale> with price between 10 and 2000 and inventory between 11 and 99999
      And I am on locale <locale> shopping bag page for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until Checkout.ShippingPage.NewAddressSection is displayed
      And as a guest I add first delivery details
      And I fetch from the DB the quantity of product item product1#skuPartNumber and store it with key #originalInventory
      And I get translation from lokalise for "StockNotificationBanner" and store it with key #oosError
      And I click on Checkout.ShippingPage.ProceedToPayment
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
    When I update in the DB the quantity of product item product1#skuPartNumber to 0
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 3 seconds
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed
      And I wait until Checkout.PaymentPage.ErrorNotification is displayed in 5 seconds
    Then I see Checkout.PaymentPage.ErrorNotification contains text "#oosError"
    When I click on Checkout.PaymentPage.ErrorNotificationCloseIcon
      And I wait until Checkout.PaymentPage.ErrorNotification is not displayed
    Then I see Checkout.PaymentPage.ProductOutOfStockText is displayed
      And I see Checkout.PaymentPage.ProductOutOfStockRemoveButton is displayed
      And I update in the DB the quantity of product item product1#skuPartNumber to #originalInventory

    @tms:UTR-17922
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @UnifiedCheckout @StockTest @ShippingPage @P2
  @feature:EESCK-6666
  Scenario Outline: Insufficient Stock Item - For insufficient product item stock I am unable to place an order
    Given There is 1 width-length size product item of locale <locale> with inventory between 5 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 2 units for product items product1#skuPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until Checkout.ShippingPage.NewAddressSection is displayed
      And as a guest I add first delivery details
      And I get translation from lokalise for "StockNotificationBanner" and store it with key #oosError
      And I get translation from lokalise for "QtyNotAvailable" and store it with key #noAvailableQty
      And I fetch from the DB the quantity of product item product1#skuPartNumber and store it with key #originalInventory
      And I click on Checkout.ShippingPage.ProceedToPayment
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
    When I update in the DB the quantity of product item product1#skuPartNumber to 1
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 3 seconds
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is not displayed
    When I wait until Checkout.PaymentPage.ErrorNotification is displayed in 5 seconds
    Then I see Checkout.PaymentPage.ErrorNotification contains text "#oosError"
    When I click on Checkout.PaymentPage.ErrorNotificationCloseIcon
      And I wait until Checkout.PaymentPage.ErrorNotification is not displayed
      And I wait until Checkout.PaymentPage.ProductLowOnStockText is displayed
    Then I see Checkout.ShippingPage.ProductLowOnStockText contains text "#noAvailableQty"
      And I update in the DB the quantity of product item product1#skuPartNumber to #originalInventory

    @tms:UTR-17923 @issue:EESCK-12844
    Examples:
      | locale  | langCode |
      | default | default  |