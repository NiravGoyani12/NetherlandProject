Feature: Unified Checkout - Shopping Bag - GiftCard

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShoppingBag @GiftCard
  Scenario Outline: Gift Card - As a guest I can see the correct elements displayed on the shopping bag page and I am able to remove the giftcard
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I am a guest user
      And I wait until the current page is loaded
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I get translation from lokalise for "Quantity" and store it with key #Quantity
    When I get translation from lokalise for "GiftcardShipMethod" and store it with key #gcShipMeth
    Then I see Checkout.OverviewPanel.ShippingMethod contains text "#gcShipMeth"
      And I see Experience.ShoppingBag.ItemAtrribute with text #Quantity is displayed
      And I wait until Experience.ShoppingBag.ItemCurrentPrice is displayed
      And I see Experience.ShoppingBag.EditProductButton is not displayed
      And I see Experience.ShoppingBag.RemoveButton is displayed
      And I see Experience.ShoppingBag.CheckoutWithPaypalButton is displayed in 2 seconds
      And I click on Experience.ShoppingBag.RemoveButton
    When I click on Experience.ShoppingBag.RemoveConfirmButton
    Then I see Experience.ShoppingBag.EmptyShoppingBagTitle is displayed in 10 seconds
      And the count of elements Experience.ShoppingBag.Item is equal to 0 in 2 seconds
      And I see Experience.ShoppingBag.EmptyShoppingBagButton is displayed

    @tms:UTR-18072
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShoppingBag @GiftCard
  Scenario Outline: Gift Card - As a user I can see the correct elements displayed on the shopping bag page and I am able to remove one of the multiple giftcards
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I am a guest user
      And I wait until the current page is loaded
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I get translation from lokalise for "Quantity" and store it with key #Quantity
      And I see Checkout.OverviewPanel.ShippingMethod contains text "E-Mail-Zustellung"
      And I see Experience.Header.ShoppingBagCounter with text 2 is displayed
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 2
      And I see Experience.ShoppingBag.ItemAtrribute with text #Quantity is displayed
    Then I wait until Experience.ShoppingBag.ItemCurrentPrice is displayed
      And I see Experience.ShoppingBag.EditProductButton is not displayed
      And I see Experience.ShoppingBag.RemoveButton is displayed
    When I click on Experience.ShoppingBag.RemoveButton
      And I click on Experience.ShoppingBag.RemoveConfirmButton
    Then the count of elements Experience.ShoppingBag.Item is equal to 1 in 2 seconds

    @tms:UTR-18073
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise @P2
  @UnifiedCheckout @ShoppingBag @GiftCard @MixedBasket @feature:EESCK-12615
  Scenario Outline: Gift Card - As a guest/user I cannot navigate to shipping page with a mixed basket containing a Giftcard
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 units of any product on shopping bag page
      And I wait until the count of elements Experience.ShoppingBag.Item is equal to 1
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I wait until the count of elements Experience.ShoppingBag.Item is equal to 2
    Then I see Experience.ShoppingBag.ErrorNotification is displayed
    When I get translation from lokalise for "GiftcardMixedBasketError" and store it with key #mixedBasketError
    Then I see Experience.ShoppingBag.ErrorNotification contains text "#mixedBasketError"
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait for 5 seconds
      And I wait until the count of elements Experience.ShoppingBag.Item is equal to 2
    Then I see Experience.ShoppingBag.ErrorNotification is displayed

    @Mobile @tms:UTR-18333
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-18334
    Examples:
      | locale | langCode | userType  |
      | at     | default  | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @P3
  @UnifiedCheckout @ShoppingBag @GiftCard @MixedBasket @feature:EESCK-12615
  Scenario Outline: Gift Card - As a guest I cannot navigate in the URL to shipping page with a mixed basket containing a Giftcard
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product with forced accepted cookies
      And I wait until the current page is shopping-bag
      And I wait until the count of elements Experience.ShoppingBag.Item is equal to 1
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I wait until the count of elements Experience.ShoppingBag.Item is equal to 2
      And I am on locale <locale> of url /checkout/shipping of langCode <langCode>
      And I wait for 5 seconds
      And I wait until the count of elements Experience.ShoppingBag.Item is equal to 2
    Then I see Experience.ShoppingBag.ErrorNotification is displayed

    @tms:UTR-18335
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @P3
  @UnifiedCheckout @ShoppingBag @GiftCard @MixedBasket @feature:EESCK-12615
  Scenario Outline: Gift Card - As a registered user I cannot navigate in the URL to payment page with a mixed basket containing a Giftcard
    Given I am cross site user on locale <locale> of langCode <langCode> on the shopping bag page
      And I wait until the current page is shopping-bag
      And I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product
      And I wait until the count of elements Experience.ShoppingBag.Item is equal to 1
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I wait until the count of elements Experience.ShoppingBag.Item is equal to 2
      And I am on locale <locale> of url /checkout/payment of langCode <langCode>
      And I wait for 5 seconds
      And I wait until the count of elements Experience.ShoppingBag.Item is equal to 2
    Then I see Experience.ShoppingBag.ErrorNotification is displayed
      And I clear shopping bag for the registered user of this locale

    @tms:UTR-18336
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @GiftCard @ExcludeUat
  Scenario Outline: GiftCard - As a guest/reg user I cannot proceed to checkout if I have a mixed basket
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
    Given There is 1 product style with same current price of locale <locale>
    When I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber
      And I wait for 2 seconds
      And I extract product style detail by style colour part number product1#styleColourPartNumber
      And I extract a product item from product style product1#styleColourPartNumber which has lowest price saved as #skuPartNumber
      And I wait until the current page is PDP
      And in unified PDP I select size by sku part number #skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I wait until ProductDetailPage.Header.ShoppingBagCounter with text 2 is displayed
      And I hover over Experience.Header.ShoppingBagButton
    When I click on <buttonToClick>
      And I get translation from lokalise for "GiftcardMixedBasketError" and store it with key #noGCMixedBasket
      And I wait until the current page is shopping-bag
      And the count of elements Experience.ShoppingBag.Item is equal to 2
      And I wait until Checkout.PaymentPage.ErrorNotification is displayed in 3 seconds
    Then I see Checkout.PaymentPage.ErrorNotification contains text "#noGCMixedBasket"
      And I click on Experience.ShoppingBag.ErrorNotificationCloseIcon
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until the current page is shopping-bag
      And I wait until Checkout.PaymentPage.ErrorNotification is displayed in 3 seconds
    Then I see Checkout.PaymentPage.ErrorNotification contains text "#noGCMixedBasket"

    @tms:UTR-18517
    Examples:
      | locale  | langCode | userType | buttonToClick                             |
      | default | default  | guest    | Experience.MiniShoppingBag.CheckOutButton |

    @tms:UTR-18518
    Examples:
      | locale | langCode | userType  | buttonToClick                        |
      | at     | default  | logged in | ProductDetailPage.Pdp.CheckoutButton |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Translation @Lokalise
  @UnifiedCheckout @ShoppingBag @Promocode @Negative @GiftCard @P2
  Scenario Outline: Gift Card - As a guest I cannot use promo codes on giftcard orders on the shopping bag page
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I get translation from lokalise for "PromoNotEligible" and store it with key #PromoNotEligible
      And I get checkout search data for "PromoCode" and store it with key #Promo
    When I apply promocode "#Promo" in the overview panel on shopping bag page and store the discounted amount with key #DiscountedAmount
    Then I see Experience.ShoppingBag.PromoCodeErrorMsgNotEligible contains text "#PromoNotEligible"

    @tms:UTR-18772
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-18773
    Examples:
      | locale | langCode | userType |
      | de     | EN       | guest    |
