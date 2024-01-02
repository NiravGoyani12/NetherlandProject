Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1 @tms:UTR-17383 @AnalyticsGiftcard
  Scenario Outline: Giftcard Payment Method Interaction - The event is fired when I apply a giftcard
      Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 40 and 100 and inventory between 200 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product items product1#skuPartNumber with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      When I click on Experience.ShoppingBag.StartCheckoutButton
      And as a guest I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      Then I wait until Checkout.PaymentPage.GiftCardButton is clickable in 10 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.GiftCardButton
      When I inject utag event listener
      And in payment page I fill in the gift card details
      | element    | value               |
      | cardNumber | 6036280000000000000 |
      | pin        | 1234                |
      And I click on Payments.GiftCardPage.ApplyGiftCardButton is clickable
      Then utag event giftcard_payment_method_interaction is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "giftcard payment method interaction"
      And utag event #event should contain attr eventLabel with value "giftcard_applied_successfully"
      And utag event #event should contain non-empty attr giftcardBalanceAmount
      And utag event #event should contain non-empty attr hasGiftcardValue
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | userType |
      | fi     | default  | guest    |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1 @tms:UTR-17401 @AnalyticsGiftcard
  Scenario Outline: Giftcard Payment Method Interaction - The event is fired when I remove a giftcard
      Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 40 and 100 and inventory between 200 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 1 units for product items product1#skuPartNumber with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      When I click on Experience.ShoppingBag.StartCheckoutButton
      And as a guest I add first delivery details
      And I scroll in mobile view and click on to Checkout.ShippingPage.ProceedToPayment
      Then I wait until Checkout.PaymentPage.GiftCardButton is clickable in 10 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.GiftCardButton
      And in payment page I fill in the gift card details
      | element    | value               |
      | cardNumber | 6036280000000000000 |
      | pin        | 1234                |
      And I click on Payments.GiftCardPage.ApplyGiftCardButton is clickable
      And I wait until Payments.GiftCardPage.RemoveGiftCardButton is clickable
      When I inject utag event listener
      And I click on Payments.GiftCardPage.RemoveGiftCardButton
      Then utag event giftcard_payment_method_interaction is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "giftcard payment method interaction"
      And utag event #event should contain attr eventLabel with value "giftcard_removed_successfully"
      And utag event #event should contain non-empty attr giftcardBalanceAmount
      And utag event #event should contain non-empty attr hasGiftcardValue
      And I execute all datalayer event validation with report key #event
 
     Examples:
      | locale | langCode | userType |
      | fi     | default  | guest    |