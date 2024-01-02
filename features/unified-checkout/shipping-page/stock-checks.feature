Feature: Unified Checkout - Shipping Page - OOS/Insufficient Stock Items

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @UnifiedCheckout @StockTest @ShippingPage
  Scenario Outline: Out of Stock Item - For sold out product items I am unable to place an order
    Given There are 1 product items with 0% discount of locale <locale> with price between 10 and 500 and inventory between 11 and 99999
      And I am on locale <locale> shopping bag page for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until Checkout.ShippingPage.NewAddressSection is displayed
      And as a guest I add first delivery details
      And I fetch from the DB the quantity of product item product1#skuPartNumber and store it with key #originalInventory
      And I get translation from lokalise for "StockNotificationBanner" and store it with key #oosError
    When I update in the DB the quantity of product item product1#skuPartNumber to 0
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.ShippingPage.ErrorNotification is displayed in 5 seconds
    Then I see Checkout.ShippingPage.ErrorNotification contains text "#oosError"
    When I click on Checkout.ShippingPage.ErrorNotificationCloseIcon
      And I wait until Checkout.ShippingPage.ErrorNotification is not displayed
    Then I see Checkout.ShippingPage.ProductOutOfStockText is displayed
      And I see Checkout.ShippingPage.ProductOutOfStockRemoveButton is displayed
      And I update in the DB the quantity of product item product1#skuPartNumber to #originalInventory

    @tms:UTR-17404 @P1
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @UnifiedCheckout @StockTest @ShippingPage @P2
  Scenario Outline: Insufficient Stock Item - For insufficient product item stock I am unable to proceed to payment
    Given There is 1 width-length size product item of locale <locale> with inventory between 5 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 3 units for product items product1#skuPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until Checkout.ShippingPage.NewAddressSection is displayed
      And I get translation from lokalise for "StockNotificationBanner" and store it with key #oosError
      And I get translation from lokalise for "QtyNotAvailable" and store it with key #noAvailableQty
      And as a guest I add first delivery details
      And I fetch from the DB the quantity of product item product1#skuPartNumber and store it with key #originalInventory
    When I update in the DB the quantity of product item product1#skuPartNumber to 2
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.ShippingPage.ErrorNotification is displayed in 5 seconds
      And I see the current page is shipping page
    Then I see Checkout.ShippingPage.ErrorNotification contains text "#oosError"
    When I click on Checkout.ShippingPage.ErrorNotificationCloseIcon
      And I wait until Checkout.ShippingPage.ErrorNotification is not displayed
      And I see Checkout.ShippingPage.ProductLowOnStockText is displayed
    Then I see Checkout.ShippingPage.ProductLowOnStockText contains text "#noAvailableQty"
      And I update in the DB the quantity of product item product1#skuPartNumber to #originalInventory

    @tms:UTR-17405
    Examples:
      | locale  | langCode |
      | default | default  |