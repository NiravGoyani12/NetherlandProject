Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @P1
  @tms:UTR-18459
  Scenario Outline: Purchase Giftcard - The event is fired when I purchase giftcard only
     Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page giftcard-pdp
      And I wait until the current page is giftcard pdp
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I click on ProductDetailPage.Header.ShoppingBagButton
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I type to following inputs
      | element                              | value                       |
      | Checkout.ShippingPage.EmailInput     | pvh.qa.automation@gmail.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                     |
      | Checkout.ShippingPage.LastNameInput  | Testovich                   |
      And I wait for 3 seconds
      And I scroll to and click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
      And I add giftCardFirst billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | element    | value               |
      | cardNumber | 4111 1111 1111 1111 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | QA                  |
      | lastName   | Automation          |
      And I add giftCardFirst billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      When I inject utag event listener
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      Then utag event purchase_giftcard is fired saved to key #event
      And utag event #event should contain attr event_name with value "purchase_giftcard"
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "purchase giftcard"
      And utag event #event should contain non-empty attr eventLabel
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

      Examples:
      | locale | langCode | userType |
      | at     | default  | guest    |