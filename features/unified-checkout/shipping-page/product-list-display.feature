Feature: Unified Checkout - Shipping Page - Product List Display

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ShippingPage @ProductListDisplay @P2
  Scenario Outline: Product List Display - As guest I want to see all product list attributes on shipping page
    Given There is 1 discounted product items of locale <locale> and langCode <langCode> with inventory between 10 and 9999 filtered by FH
      And There is 1 normal size product items of locale <locale> and langCode <langCode> with inventory between 10 and 9999 filtered by FH
    When I am on locale <locale> shopping bag page for product item product1#skuPartNumber,product2#skuPartNumber with forced accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter contains text "2"
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as guest to shipping page
    Then I check if product item details for part number product1#skuPartNumber are correctly displayed from DB
      And I check if product item details for part number product2#skuPartNumber are correctly displayed from DB

    @tms:UTR-10473
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-10474 @Mobile
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

#TODO: Refactor these tests
# @FullRegression
# @Desktop
# @Chrome @FireFox @Safari
# @UnifiedCheckout @ShippingPage @ProductListDisplay @P2
# Scenario Outline: Product List Display - Verify if item with low stock is indicated also on Checkout page
#   Given There is 1 normal size product item of locale <locale> with inventory between 4 and 9
#     And I am on locale <locale> home page with forced accepted cookies
#     And I am a guest user
#     And I am on locale <locale> shopping bag page for product item product1#skuPartNumber
#     And I wait until Experience.ShoppingBag.StartCheckoutButton is displayed
#   Then I see Checkout.ShippingPage.ProductLowOnStock is displayed in 3 seconds
#   When I click on Experience.ShoppingBag.StartCheckoutButton
#   Then I see Checkout.ShippingPage.ProductLowOnStock is displayed in 3 seconds

#   @tms:UTR-13483
#   Examples:
#     | locale  | langCode |
#     | default | default  |

#   @tms:UTR-14654
#   Examples:
#     | locale           | langCode         |
#     | multiLangDefault | multiLangDefault |