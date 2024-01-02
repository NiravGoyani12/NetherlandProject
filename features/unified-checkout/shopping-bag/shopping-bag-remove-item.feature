Feature: Unified Shopping Bag - Remove item

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @EditItem @UnifiedCheckout @P2
  @feature:CET1-3331
  Scenario Outline: Unified Shopping bag - Remove products from shopping basket and not confirming
    Given There is 1 normal size product item of locale <locale> with inventory between 11 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
    When I click on Experience.ShoppingBag.RemoveButton with args product1#skuPartNumber
      And I click on Experience.ShoppingBag.RemoveCancelButton
    Then the count of elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.Item with args product1#skuPartNumber is displayed

    @tms:UTR-11882
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16541
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @EditItem @Wishlist @UnifiedCheckout
  @feature:EESCK-12278
  Scenario Outline: Unified Shopping bag - As a user I want to remove 1 item from shopping basket to wishlist
    Given I am on locale <locale> home page with forced accepted cookies
      And There is 1 normal size product items of locale <locale> with inventory between 11 and 99999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until Experience.ShoppingBag.RemoveButton is displayed in 5 seconds
      And I wait until Experience.ShoppingBag.RemoveButton is clickable
      And I see the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I click on Experience.ShoppingBag.RemoveButton with args product1#skuPartNumber
      And I wait until Experience.ShoppingBag.RemoveItemModal is displayed in 5 seconds
      And I wait until Experience.ShoppingBag.RemoveAddWishlistButton is clickable
    When I click on Experience.ShoppingBag.RemoveAddWishlistButton
      And I wait until Experience.Header.WishListCounter with text 1 is displayed
    Then I see Experience.ShoppingBag.EmptyShoppingBagTitle is displayed

    @tms:UTR-17759 @P1
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-17760 @P2
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @EditItem @Wishlist @UnifiedCheckout @P2
  @feature:EESCK-12278
  Scenario Outline: Unified Shopping bag - As a user I want to remove 2 products 1 by 1 from shopping basket to wishlist
    Given I am on locale <locale> home page with forced accepted cookies
      And There is 1 normal size product items of locale <locale> with inventory between 11 and 99999
      And There is 1 width-length size product items of locale <locale> with inventory between 20 and 99999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber,product2#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 2
      And I wait for 2 seconds
      And I click on Experience.ShoppingBag.RemoveButton with args product1#skuPartNumber
      And I wait until Experience.ShoppingBag.RemoveItemModal is displayed
      And I wait until Experience.ShoppingBag.RemoveAddWishlistButton is clickable
    When I click on Experience.ShoppingBag.RemoveAddWishlistButton
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I wait until Experience.ShoppingBag.Item with args product2#skuPartNumber is displayed
    Then I see Experience.Header.WishListCounter with text 1 is displayed in 10 seconds
    When I click on Experience.Header.WishListIcon
      And I wait until the current page is wlp
      And I wait until Experience.Wishlist.FilledWishlistTitle is displayed
    Then I see Experience.Wishlist.ItemTitle with index 1 is displayed
      And I navigate to page shopping-bag
      And I wait until Experience.ShoppingBag.Item with args product2#skuPartNumber is displayed
    When I click on Experience.ShoppingBag.RemoveButton with args product2#skuPartNumber
      And I wait until Experience.ShoppingBag.RemoveAddWishlistButton is clickable
    When I click on Experience.ShoppingBag.RemoveAddWishlistButton
      And I wait until Experience.Header.WishListCounter with text 2 is displayed in 10 seconds
    Then I see Experience.ShoppingBag.EmptyShoppingBagTitle is displayed
    When I navigate to page wlp
      And I wait until Experience.Wishlist.FilledWishlistTitle is displayed
    Then I see the count of elements Experience.Wishlist.ItemTitle is equal to 2

    @tms:UTR-17126
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-17127
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression @RCTest
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @EditItem @UnifiedCheckout
  @feature:CET1-3331
  Scenario Outline: Unified Shopping bag - Remove products from shopping basket and confirming makes shopping cart is empty
    Given There is 1 normal size product items of locale <locale> with inventory between 11 and 99999
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
    When I click on Experience.ShoppingBag.RemoveButton with args product1#skuPartNumber
      And I wait for 3 seconds
      And I click on Experience.ShoppingBag.RemoveConfirmButton
    When I see Experience.ShoppingBag.EmptyShoppingBagTitle is displayed in 10 seconds
      And the count of elements Experience.ShoppingBag.Item is equal to 0 in 2 seconds
    Then I see Experience.ShoppingBag.EmptyShoppingBagButton is displayed

    @tms:UTR-11881 @P1
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16542 @P2
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @EditItem @Promocode @UnifiedCheckout @P2
  @feature:CET1-3331
  Scenario Outline: Unified Shopping bag - Remove 1 out of 2 products in shopping bag with promocode - user should see 1 item and promocode
    Given There is 1 normal size product items of locale <locale> with inventory between 11 and 99999
      And There is 1 one size product items of locale <locale> with inventory between 11 and 99999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber,product2#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 2
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I type "#Promo" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Experience.ShoppingBag.PromoCodeApplyButton
      And I wait until Experience.ShoppingBag.PromoCodeRemoveButton is displayed
      And I store the numeric value of Experience.ShoppingBag.TotalPriceInfo with key #totalPriceInfo
      And I store the numeric value of Experience.ShoppingBag.PromoCodeDiscountInfo with key #initialDiscount
      And I click on Experience.ShoppingBag.RemoveButton with args product1#skuPartNumber
      And I click on Experience.ShoppingBag.RemoveConfirmButton
      And I wait until Experience.ShoppingBag.Item is displayed in 7 seconds
    Then the count of elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.Item with args product2#skuPartNumber is displayed
      And I see Experience.ShoppingBag.RemoveButton with args product2#skuPartNumber is displayed
      And the numeric value of Experience.ShoppingBag.TotalPriceInfo should not be equal to the stored value with key #totalPriceInfo
      And I see Experience.ShoppingBag.PromoCodeRemoveButton is displayed
      And the numeric value of Experience.ShoppingBag.PromoCodeDiscountInfo is greater than 0
      And the numeric value of Experience.ShoppingBag.PromoCodeDiscountInfo is less than #initialDiscount

    @tms:UTR-11879
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16543
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression @RCTest
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @EditItem @UnifiedCheckout @P2
  @feature:CET1-3331
  Scenario Outline: Unified Shopping bag - Remove 1 out of 2 products in shopping bag - user should see 1 item
    Given There is 1 normal size product items of locale <locale> with inventory between 11 and 9999
      And There is 1 one size product items of locale <locale> with inventory between 11 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber,product2#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 2
    When I click on Experience.ShoppingBag.RemoveButton with args product1#skuPartNumber
      And I wait for 3 seconds
      And I click on Experience.ShoppingBag.RemoveConfirmButton
    Then the count of elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.Item with args product2#skuPartNumber is displayed
      And I see Experience.ShoppingBag.RemoveButton with args product2#skuPartNumber is displayed

    @tms:UTR-11880
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16545
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending
  @ShoppingBag @EditItem @MiniShoppingBag @UnifiedCheckout @P2
  Scenario Outline: Unified Shopping bag - Mini shopping bag is updated after removing product from shopping bag
    Given There is 1 product items with 0% discount of locale <locale> with price between 10 and 500 and inventory between 20 and 9999
      And There is 1 one size product items of locale <locale> with inventory between 11 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber,product2#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 2
      And I wait until Experience.Header.ShoppingBagCounter contains text "2"
      And I store the numeric value of Experience.ShoppingBag.TotalPriceInfo with key #initialTotalPrice
    When I click on Experience.ShoppingBag.RemoveButton with args product1#skuPartNumber
      And I wait for 3 seconds
      And I click on Experience.ShoppingBag.RemoveConfirmButton
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I store the numeric value of Experience.ShoppingBag.TotalPriceInfo with key #updatedTotalPrice
      And I store the numeric value of Experience.ShoppingBag.SubTotalPriceInfo with key #updatedSubTotalPrice
      And I hover over Experience.Header.ShoppingBagButton
    Then the count of displayed elements Experience.MiniShoppingBag.Products is equal to 1
      And I hover over Experience.Header.ShoppingBagButton
      And I wait until Experience.MiniShoppingBag.ProductPriceSelling is displayed
      And the numeric value of Experience.MiniShoppingBag.ProductPriceSelling is equal to #updatedSubTotalPrice
      And the numeric value of Experience.MiniShoppingBag.ProductPriceSelling is less than #initialTotalPrice
      And I see Experience.Header.ShoppingBagCounter contains text "1"

    @tms:UTR-2307
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-13504
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |
