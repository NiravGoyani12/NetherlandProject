Feature: Unified Shopping Bag - Shipping cost

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @ShippingPromotion @ShoppingBag @UnifiedCheckout @P2
  @feature:CET1-3307
  Scenario Outline: Shopping Bag Overview - Verify shipping fee is introduced when not meeting the shipping threshold
    Given I am on locale <locale> home page with forced accepted cookies
      And I get standard shipping costs for current locale and store it with key #ShippingCosts
      And in DB I extract the shipping promo threshold save to #ShippingThreshold
      And I add 25 to numeric store value #ShippingThreshold save to #MaxValue
      And There is 1 product items with 0% discount of locale <locale> with price between 0 and #ShippingThreshold and inventory between 2 and 99999
      And There is 1 product items with 0% discount of locale <locale> with price between #ShippingThreshold and #MaxValue and inventory between 2 and 99999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product items product1#skuPartNumber,product2#skuPartNumber with forced accepted cookies
      And I get translation from lokalise for "FreeCosts" and store it with key #freeDeliveryMessage
      And I get translation from lokalise for "StandardDelivery" and store it with key #shippingMethod
    Then I see Experience.ShoppingBag.ShippingChargeAmount contains text "#freeDeliveryMessage"
      And I see Experience.ShoppingBag.ShippingChargeLabel contains text "#shippingMethod"
    When I click on Experience.ShoppingBag.RemoveButton with args product2#skuPartNumber
      And I click on Experience.ShoppingBag.RemoveConfirmButton
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
    Then the value of Experience.ShoppingBag.ShippingChargeAmount should contain the stored value with key #ShippingCosts
      And I see Experience.ShoppingBag.ShippingChargeLabel contains text "#shippingMethod"

    @tms:UTR-13257
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16427
    Examples:
      | locale | langCode |
      | be     | FR       |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @P2 @Translation
  @ShippingPromotion @ShoppingBag @Promocode @UnifiedCheckout
  @feature:CET1-3307
  Scenario Outline: Shopping Bag Overview - Shipping promotion is retained after promocode is applied on shopping bag page
    Given I am on locale <locale> home page with forced accepted cookies
      And in DB I extract the shipping promo threshold save to #minimumValue
      And I add 15 to numeric store value #ShippingThreshold save to #thresholdValue
    Given There is 1 product items with 0% discount of locale <locale> with price between #minimumValue and #thresholdValue and inventory between 2 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product items product1#skuPartNumber with forced accepted cookies
      And I get checkout search data for "PromoCode" and store it with key #Promo
      And I get translation from lokalise for "FreeCosts" and store it with key #freeDeliveryMessage
      And I get translation from lokalise for "StandardDelivery" and store it with key #shippingMethod
      And I wait until the current page is loaded
    Then I see Experience.ShoppingBag.ShippingChargeAmount contains text "#freeDeliveryMessage"
      And I store the numeric value of Experience.ShoppingBag.TotalPriceInfo with key #TotalPriceInfo
      And I type "#Promo" in the field Experience.ShoppingBag.PromoCodeField
    When I click on Experience.ShoppingBag.PromoCodeApplyButton
      And I wait until Experience.ShoppingBag.PromoCodeRemoveButton is displayed
    Then the numeric value of Experience.ShoppingBag.TotalPriceInfo should not be equal to the stored value with key #TotalPriceInfo
      And the numeric value of Experience.ShoppingBag.PromoCodeDiscountInfo is greater than 0
      And I see Experience.ShoppingBag.ShippingChargeAmount contains text "#freeDeliveryMessage"
      And I see Experience.ShoppingBag.ShippingChargeLabel contains text "#shippingMethod"

    @tms:UTR-2197
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-15638
    Examples:
      | locale | langCode |
      | be     | FR       |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending @Translation @Lokalise
  @ShippingPromotion @ShoppingBag @UnifiedCheckout @P2
  @feature:CET1-3307
  Scenario Outline: Shopping bag overview - Verify shipping method is updated on shopping bag page after changing it on delivery page
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 products with value above shipping threshold on shopping bag page
      And I get translation from lokalise for "FreeCosts" and store it with key #freeDeliveryMessage
      And I get translation from lokalise for "StandardDelivery" and store it with key #shippingMethod
      And I wait until Experience.ShoppingBag.ShippingChargeAmount contains text "#freeDeliveryMessage"
      And I wait until Experience.ShoppingBag.ShippingChargeLabel contains text "#shippingMethod"
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until Checkout.ShippingPage.StandardRadioButton is displayed
      And I click on Checkout.ShippingPage.ExpressRadioButton
      And I wait for 3 seconds
    When I get express shipping costs for current locale and store it with key #updatedShippingfee
      And I navigate to page shopping-bag
    Then I see Experience.ShoppingBag.ShippingChargeAmount contains text "#updatedShippingfee"
      And I see Experience.ShoppingBag.ShippingChargeLabel contains text "Express"

    @tms:UTR-2198
    Examples:
      | locale | langCode | userType |
      | be     | default  | guest    |

    @tms:UTR-16428
    Examples:
      | locale | langCode | userType  |
      | be     | FR       | logged in |