Feature: Unified Shopping Bag - OOS/Insufficient Stock Items

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @UnifiedCheckout @StockTest @ShippingPage
  Scenario Outline: Out of Stock Item - For OOS product item I am unable to proceed to shipping
    Given There is 1 normal size product items of locale <locale> with inventory between 10 and 9999
      And I am on locale <locale> shopping bag page for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I get translation from lokalise for "StockNotificationBanner" and store it with key #oosError
      And I fetch from the DB the quantity of product item product1#skuPartNumber and store it with key #originalInventory
    When I update in the DB the quantity of product item product1#skuPartNumber to 0
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until Experience.ShoppingBag.ErrorNotification is displayed in 5 seconds
    Then I see Experience.ShoppingBag.ErrorNotification contains text "#oosError"
    When I click on Experience.ShoppingBag.ErrorNotificationCloseIcon
      And I wait until Experience.ShoppingBag.ErrorNotification is not displayed
    Then I see Experience.ShoppingBag.ProductOutOfStockText is displayed
      And I update in the DB the quantity of product item product1#skuPartNumber to #originalInventory

    @tms:UTR-17402 @P1
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @UnifiedCheckout @StockTest @ShippingPage @P2
  Scenario Outline: Insufficient Stock Item - For insufficient product item stock I am unable to proceed to shipping page
    Given There is 1 product items with 0% discount of locale <locale> with price between 10 and 600 and inventory between 2 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 3 units for product items product1#skuPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I fetch from the DB the quantity of product item product1#skuPartNumber and store it with key #originalInventory
    When I update in the DB the quantity of product item product1#skuPartNumber to 2
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I get translation from lokalise for "QtyNotAvailable" and store it with key #noAvailableQty
      And I wait until the current page is loaded
      And I see Experience.ShoppingBag.ErrorNotification is displayed in 5 seconds
    Then I see the current page is shopping-bag
    When I click on Experience.ShoppingBag.ErrorNotificationCloseIcon
      And I wait until Experience.ShoppingBag.ErrorNotification is not displayed
      And I see Experience.ShoppingBag.ProductLowOnStockText is displayed
    Then I see Experience.ShoppingBag.ProductLowOnStockText contains text "#noAvailableQty"
      And I update in the DB the quantity of product item product1#skuPartNumber to #originalInventory

    @tms:UTR-17403
    Examples:
      | locale  | langCode |
      | default | default  |