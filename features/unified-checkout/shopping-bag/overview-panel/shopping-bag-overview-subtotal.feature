Feature: Shopping Bag - SubTotal

#TODO when product listing is available
  # @FullRegression
  # @Desktop @Mobile
  # @Chrome @FireFox @SafariPending
  # @ShoppingBag @OverviewPanel @UnifiedCheckout
  # @feature:CET1-3307
  # Scenario Outline: Shopping Bag Overview - Subtotal is showing sum of all items prices in the bag
  #   Given There is 1 product item with 0% discount of locale <locale> with price between 10 and 500 and inventory between 2 and 9999
  #     And There is 1 discounted product item of locale <locale> with inventory between 10 and 9999
  #   When I am on locale <locale> shopping bag page for product item product1#skuPartNumber,product2#skuPartNumber with forced accepted cookies
  #     # When I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 2
  #     And I see Experience.Header.ShoppingBagCounter contains text "2"
  #     And I store the numeric value of Experience.ShoppingBag.ItemCurrentPrice with args product1#skuPartNumber with key #price1
  #     And I store the numeric value of Experience.ShoppingBag.ItemCurrentPrice with args product2#skuPartNumber with key #price2
  #     And I add #price1 to #price2 and save to #subtotalPrice
  #   Then the numeric value of Experience.ShoppingBag.SubTotalPriceInfo is equal to #subtotalPrice

  #   Examples:
  #     | locale |
  #     | ee     |

  # @FullRegression
  # @Desktop @Mobile
  # @Chrome @FireFox @SafariPending
  # @ShoppingBag @OverviewPanel @Promocode @UnifiedCheckout
  # @feature:CET1-3307
  # Scenario Outline: Shopping Bag Overview - Subtotal does not include shipping fee and promocode
  #   Given There is 1 product item with 0% discount of locale <locale> with price between 10 and 20 and inventory between 2 and 9999
  #   When I am on locale <locale> shopping bag page for product item product1#skuPartNumber with forced accepted cookies
  #     # When I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
  #     And I see Experience.Header.ShoppingBagCounter contains text "1"
  #     And I store the numeric value of Experience.ShoppingBag.ItemCurrentPrice with args product1#skuPartNumber with key #price1
  #     And I click on Experience.ShoppingBag.PromoCodeButton
  #     And I type "unifiedpromo" in the field Experience.ShoppingBag.PromoCodeField
  #     And I click on Experience.ShoppingBag.PromoCodeApplyButton
  #     And I see Experience.ShoppingBag.PromoCodeDiscountInfo is displayed
  #   Then the numeric value of Experience.ShoppingBag.SubTotalPriceInfo is equal to #price1
  #     And the numeric value of Experience.ShoppingBag.ShippingChargeAmount is greater than 0
  #     And the numeric value of Experience.ShoppingBag.PromoCodeDiscountInfo is greater than 0

  #   Examples:
  #     | locale |
  #     | ee     |
