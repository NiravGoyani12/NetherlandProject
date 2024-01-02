Feature: Unified Checkout - Cross Site - Gift Card - Purshcase

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @GiftCard @Payment @CrossSitePayment @HappyFlow @GiftCardPurchase @ExcludeUat
  Scenario Outline: Cross Site - As guest I purchase giftcard using CC as payment and their is no payment method as giftcard
    Given I am on locale <locale> of url /geschenkgutscheine of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      # And I store the cartId
      And I type to following inputs
      | element                              | value                    |
      | Checkout.ShippingPage.EmailInput     | pvh.sap_user@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                  |
      | Checkout.ShippingPage.LastNameInput  | Testovich                |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
      And I add giftCardFirst billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | element    | value      |
      | cardNumber | <card>     |
      | cvv        | 737        |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | QA         |
      | lastName   | Automation |
      And I add giftCardFirst billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 5 seconds
      When in 3DS2 pop-up I fill in the Adyen password "password"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber

    @tms:UTR-17175 @ExcludeCK @Mobile 
    Examples:
      | locale | langCode | card                |
      | at     | default  | 5454 5454 5454 5454 |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @Payment @GiftCard @HappyFlow @GiftCardRedemption @ExcludeUat
  Scenario Outline: Cross Site - As a user I can place giftcard and regular items orders successfully
    Given I am on locale <locale> of url /geschenkgutscheine of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 2
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 2 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I expect at least 1 network request named address of type fetch to be processed in 10 seconds
      # And I store the cartId
      And I wait until Checkout.SignInPage.SignInButton is clickable
      And I type to following inputs
      | element                              | value                    |
      | Checkout.ShippingPage.EmailInput     | pvh.sap_user@outlook.com |
      | Checkout.ShippingPage.FirstNameInput | Testing                  |
      | Checkout.ShippingPage.LastNameInput  | Testovich                |
      And I wait for 2 seconds
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
    Then I see Checkout.PaymentPage.GiftCardButton is not displayed
    When I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | name       | value               |
      | cardNumber | 4917 6100 0000 0000 |
      | cvv        | 737                 |
      | year       | 2030                |
      | month      | 03                  |
      | firstName  | Automation          |
      | lastName   | QA                  |
      And I add giftCardFirst billing details
      And I set T&C checkbox to true if XCOMREG is enabled
      And I scroll to and click on Checkout.PaymentPage.PlaceOrderButton
    When in 3DS2 pop-up I fill in the Adyen password "password"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
      And I get the text on element Checkout.OrderConfirmationPage.OrderNumberConfirmationMessage with index 2 via js and save it as #orderNumber

    @tms:UTR-17177 @P2 @Mobile @issue:EED-15551
    Examples:
      | locale | langCode |
      | de     | default  |

# @tms:UTR-17178
# Examples:
#   | locale | langCode |
#   | at     | default  |