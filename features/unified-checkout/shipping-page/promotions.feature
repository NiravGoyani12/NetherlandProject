Feature: Unified Checkout - Promotions

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @Promotions @OverviewPanel @EmployeeDiscount @P2
  Scenario Outline: Promotions - As an employee I want to verify that my discount is applied correctly and displayed in overview
    Given I am guest on locale <locale> of langCode <langCode> with 2 products with value above shipping threshold on shipping page
      And I log in with user automation_employee@testing.com and password AutoNation2023 on sign in page
      And I wait for 5 seconds
      And I wait until Checkout.OverviewPanel.SubTotalPriceInfo is displayed
      And I get translation from lokalise for "FreeCosts" and store it with key #FreeShippingCosts
    Then I see Checkout.OverviewPanel.ShippingPrice contains text "#FreeShippingCosts"
      And I see Checkout.OverviewPanel.DiscountLabel is displayed
    When I store the numeric value of Checkout.OverviewPanel.SubTotalPriceInfo with key #SubtotalAmount
      And I store the numeric value of Checkout.OverviewPanel.PromoCodePriceInfo with key #DiscountedAmount
      And I subtract #DiscountedAmount from #SubtotalAmount and save to #TotalPriceWithPromo
    Then I see the numeric value of Checkout.OverviewPanel.TotalPriceInfo is equal to #TotalPriceWithPromo
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | element    | value               |
      | cardNumber | 4111 1111 1111 1111 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | QA                  |
      | lastName   | Automation          |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-11249
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-11250
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |