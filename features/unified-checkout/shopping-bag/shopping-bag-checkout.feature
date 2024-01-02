Feature: Unified Shopping Bag - checkout

  @FullRegression @RCTest
  @Mobile
  @Chrome @Safari
  @feature:CET1-3305 @ShoppingBag @UnifiedCheckout @P1
  Scenario Outline: Shopping bag checkout - Verify mobile secondary checkout buttons redirect to correct pages
    Given I am on locale <locale> shopping bag page with 1 unit of any product with forced accepted cookies
      And I wait until Experience.ShoppingBag.Item with args product1#skuPartNumber is displayed
    When I scroll to and click on <mobileCheckoutButton>
      And I set the checkbox Experience.ShoppingBag.PaypalTermsAndConditionCheckBox status to true if exist
      And I click on Experience.ShoppingBag.PaypalTermsAndConditionCheckoutButton if displayed
    Then URL should contain "<checkoutUrl>" in 15 seconds

    @tms:UTR-2235
    Examples:
      | locale  | langCode | mobileCheckoutButton                                 | checkoutUrl       |
      | default | default  | Experience.ShoppingBag.MobileSecondaryCheckoutButton | checkout/shipping |

    @tms:UTR-16459
    Examples:
      | locale           | langCode         | mobileCheckoutButton                               | checkoutUrl        |
      | multiLangDefault | multiLangDefault | Experience.ShoppingBag.MobileSecondaryPaypalButton | sandbox.paypal.com |


  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @Paypal @UnifiedCheckout @P2
  @feature:CET1-3305
  @tms:UTR-13261
  Scenario Outline: Shopping bag checkout - Going back from paypal express returns user to shopping bag page
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product with forced accepted cookies
    When I click on Experience.ShoppingBag.CheckoutWithPaypalButton
      And I set the checkbox Experience.ShoppingBag.PaypalTermsAndConditionCheckBox status to true if exist
      And I click on Experience.ShoppingBag.PaypalTermsAndConditionCheckoutButton if displayed
      And I wait for 5 seconds
      And I navigate back in the browser
    Then I see Experience.ShoppingBag.StartCheckoutButton is displayed in 15 seconds
      And the count of elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.OverviewSection is displayed

    @tms:UTR-13261
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16462
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @Paypal @UnifiedCheckout @P2
  @feature:CET1-3305
  Scenario Outline: Shopping bag checkout - Cancelling paypal express returns user to shopping bag page
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product with forced accepted cookies
    When I click on Experience.ShoppingBag.CheckoutWithPaypalButton
      And I set the checkbox Experience.ShoppingBag.PaypalTermsAndConditionCheckBox status to true if exist
      And I click on Experience.ShoppingBag.PaypalTermsAndConditionCheckoutButton if displayed
      And I wait until the current page is loaded
      And in paypal I cancel payment
      And I wait until the current page is loaded
    Then I see Experience.ShoppingBag.StartCheckoutButton is displayed in 15 seconds
      And the count of elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.OverviewSection is displayed

    @tms:UTR-13261
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16465
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @UnifiedCheckout
  Scenario Outline: Shopping bag checkout - Unable to checkout with OOS products in the bag
    Given There is 1 normal size product item of locale <locale> with inventory between 0 and 0
    When I am on locale <locale> shopping bag page of langCode <langCode> for product items product1#skuPartNumber with forced accepted cookies
      And I wait for 2 seconds
    Then I see Experience.ShoppingBag.NoStockMessage with args product1#skuPartNumber is displayed
      And I see Experience.ShoppingBag.OutOfStockErrorMessage is displayed
    When I click on <checkoutButton>
      And I set the checkbox Experience.ShoppingBag.PaypalTermsAndConditionCheckBox status to true if exist
      And I click on Experience.ShoppingBag.PaypalTermsAndConditionCheckoutButton if displayed
      And I wait until Experience.ShoppingBag.Item with args product1#skuPartNumber is displayed
    Then I see Experience.ShoppingBag.NoStockMessage with args product1#skuPartNumber is displayed
      And I see Experience.ShoppingBag.OutOfStockErrorMessage is displayed
      And URL should contain "shopping-bag"
      And URL should not contain "<checkoutUrl>" in 5 second

    @tms:UTR-2236
    Examples:
      | locale  | langCode | checkoutButton                                  | checkoutUrl |
      | default | default  | Experience.ShoppingBag.CheckoutWithPaypalButton | paypal.com  |

    @tms:UTR-16466
    Examples:
      | locale           | langCode         | checkoutButton                             | checkoutUrl |
      | multiLangDefault | multiLangDefault | Experience.ShoppingBag.StartCheckoutButton | checkout    |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @UnifiedCheckout @P2
  Scenario Outline: Shopping bag checkout - User is able to checkout after removing OOS product from bag
    Given There is 1 normal size product item of locale <locale> with inventory between 0 and 1
      And There is 1 normal size product items of locale <locale> with inventory between 11 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> for product items product1#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I am on locale <locale> shopping bag page of langCode <langCode> for product items product2#skuPartNumber
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 2
      And I wait until Experience.ShoppingBag.NoStockMessage with args product1#skuPartNumber is displayed
      And I wait until Experience.ShoppingBag.NoStockMessage with args product2#skuPartNumber is not displayed in 2 seconds
      And I wait until Experience.ShoppingBag.OutOfStockErrorMessage is displayed
    When I click on Experience.ShoppingBag.RemoveButton with args product1#skuPartNumber
      And I wait for 3 seconds
      And I click on Experience.ShoppingBag.RemoveConfirmButton
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
    Then I see Experience.ShoppingBag.NoStockMessage with args product1#skuPartNumber is not displayed in 2 seconds
      And I see Experience.ShoppingBag.OutOfStockErrorMessage is not displayed in 2 seconds
    When I click on <checkoutButton>
      And I set the checkbox Experience.ShoppingBag.PaypalTermsAndConditionCheckBox status to true if exist
      And I click on Experience.ShoppingBag.PaypalTermsAndConditionCheckoutButton if displayed
    Then URL should contain "<checkoutUrl>"
      And URL should not contain "shopping-bag" in 1 second

    @tms:UTR-2237
    Examples:
      | locale  | langCode | checkoutButton                             | checkoutUrl       |
      | default | default  | Experience.ShoppingBag.StartCheckoutButton | checkout/shipping |

    @tms:UTR-16467
    Examples:
      | locale           | langCode         | checkoutButton                                  | checkoutUrl |
      | multiLangDefault | multiLangDefault | Experience.ShoppingBag.CheckoutWithPaypalButton | paypal.com  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @Paypal @UnifiedCheckout @P2
  Scenario Outline: Shopping bag checkout - Verify paypal button is shown if the order total below threshold
    Given There is 1 product item with 0% discount of locale <locale> with price between <minPrice> and <maxPrice> and inventory between 15 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> with <numberProducts> units for product item product1#skuPartNumber with forced accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter is displayed
    Then I see Experience.ShoppingBag.CheckoutWithPaypalButton is displayed

    @tms:UTR-2243
    Examples:
      | locale  | langCode | numberProducts | minPrice | maxPrice |
      | default | default  | 1              | 50       | 100      |

    @tms:UTR-16467
    Examples:
      | locale           | langCode         | numberProducts | minPrice | maxPrice |
      | multiLangDefault | multiLangDefault | 10             | 90       | 110      |

# @FullRegression
# @Desktop @Mobile
# @Chrome @FireFox @SafariPending
# @ShoppingBag @Paypal @Promocode @UnifiedCheckout @P2
# Scenario Outline: Shopping bag checkout - Verify paypal button is shown/hidden based on total value
#   Given There is 1 product item with 0% discount of locale <locale> with price between <minPrice> and <maxPrice> and inventory between 100 and 9999
#   When I am on locale <locale> shopping bag page with <numberProducts> units for product item product1#skuPartNumber with forced accepted cookies
#     And I wait until Experience.Header.ShoppingBagCounter is displayed
#   Then I see Experience.ShoppingBag.CheckoutWithPaypalButton is <paypalDisplayState> in 2 seconds
#     And I type "unifiedpromo" in the field Experience.ShoppingBag.PromoCodeField
#     And I click on Experience.ShoppingBag.PromoCodeApplyButton
#   Then I see Experience.ShoppingBag.CheckoutWithPaypalButton is displayed

#   @tms:UTR-2244
#   Examples:
#     | locale | numberProducts | minPrice | maxPrice | paypalDisplayState |
#     | fr     | 1              | 163      | 179      | displayed          |

#   @tms:
#   Examples:
#     | locale | numberProducts | minPrice | maxPrice | paypalDisplayState |
#     | fr     | 15             | 104      | 113      | not displayed      |
