Feature: Unified Checkout - Order Confirmation Page - GiftCard

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @OrderConfirmationPage @GiftCard
  Scenario Outline: OCP - Guest user can see all elements on Order Confirmation Page for GiftCard
    Given I am on locale <locale> of url /geschenkgutscheine of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
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
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
    When I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 5100 2900 2900 2909 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
      And I add other billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll to and click on Checkout.PaymentPage.PlaceOrderButton
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I see Checkout.OrderConfirmationPage.GiftCardBanner is displayed in 20 seconds
      And I see Checkout.OrderConfirmationPage.GiftCardBannerText contains text "E-Geschenkkarte erhalten Sie in Kürze per E-Mail!"
    Then I see Checkout.OrderConfirmationPage.OCPCustomerDetails with index 1 contains text "Testing Testovich"
      And I see Checkout.OrderConfirmationPage.OCPCustomerDetails with index 2 contains text "pvh.qa.automation@gmail.com"
      And I see Checkout.OrderConfirmationPage.DeliveryMethod contains text "E-Mail-Zustellung"

    @tms:UTR-18088
    Examples:
      | locale | langCode | userType |
      | at     | default  | guest    |
