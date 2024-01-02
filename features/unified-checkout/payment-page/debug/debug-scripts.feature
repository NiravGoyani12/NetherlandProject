Feature: Unified Checkout - Debug script

  @Debug
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @PaymentMethods @CreditCard
  Scenario Outline: Debug - As a guest I can successfully place a non 3DS order from debug page
    Given I am on locale <locale> checkout debug page of langCode <langCode>
      And I see Checkout.DebugPage.ShoppingCartItem with text 267420 is existing
      And I click on Checkout.DebugPage.ShoppingCartItem with text 267420
      And I refresh page
      And I wait until Checkout.DebugPage.BasketItem is displayed
      And I navigate to page checkout-shipping
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And as a guest I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | element    | value      |
      | cardNumber | <card>     |
      | cvv        | 737        |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | QA         |
      | lastName   | Automation |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I wait for 300 seconds

    Examples:
      | locale | card                | langCode |
      | uk     | 4988 4388 4388 4305 | default  |

  @Debug
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @PaymentMethods @CreditCard
  Scenario Outline: Debug - As a guest I can successfully place a non 3DS order from empty shopping bag page
    Given I am on locale <locale> home page of langCode default with forced accepted cookies
    When I navigate to page shopping-bag
      And I refresh page
      And I wait until Recommendations.EmptyCartRecoCarousel is displayed in 10 seconds
      And I scroll to the element Recommendations.EmptyCartRecoCarousel
      And I click on Recommendations.EmptyCartRecoAddToBagBtn with index 1 I select in stock size and add product to bag
      And I navigate to page shopping-bag
      And I navigate to page checkout-shipping
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And as a guest I add first delivery details
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | element    | value      |
      | cardNumber | <card>     |
      | cvv        | 737        |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | QA         |
      | lastName   | Automation |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I wait for 300 seconds

    Examples:
      | locale | card                | langCode |
      | uk     | 4988 4388 4388 4305 | default  |