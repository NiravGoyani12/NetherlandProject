Feature: Unified Checkout - Peak Season - Promocodes

  @PeakTesting
  @Desktop @Mobile
  @Chrome @FireFox @Safari @ExcludeTH
  @UnifiedCheckout @Promocodes @OverviewPanel @Payment @P1
  Scenario Outline: CK Cyber Monday Order - As a guest/user I want to successfully place an order with a peak promotional discount
    Given I am on locale <locale> search page of langCode <langCode> with search term "<searchTerm>" with accepted cookies
      And I am a <userType> user
      And I wait until page Experience.PlpProducts is loaded
      And I wait until the current page is loaded
    When in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
    Then in unified filter panel I see filter type <filterType> with filter <filterOption> is active
    When in unified filter panel I open filter type Category and select Jeans as filter option
    Then in unified filter panel I see filter type Category with filter Jeans is active
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.PlpProducts.ListingItems with index 1 until ProductDetailPage.Pdp.Content is displayed
      And I wait for 2 seconds
      # And I click on ProductDetailPage.Pdp.WidthSizeButtonByIndex with index 1
      # And I click on ProductDetailPage.Pdp.LengthSizeButtonByIndex with index 1
      And I wait for 2 seconds
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagButton
      And I wait until the current page is shopping-bag
      And the count of elements Experience.ShoppingBag.Item is equal to 1
    When I apply promocode "<promocode>" in the overview panel on shopping bag page and store the discounted amount with key #Discount
    Then I wait until Checkout.OverviewPanel.PromoCodeText is displayed
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until the current page is shipping page
      And I store the cartId
      And as a guest I add first delivery details
      And I wait for 3 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed in 7 seconds
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
    When I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @CyberMonday
    Examples:
      | locale  | langCode | userType | searchTerm | filterType | filterOption | promocode |
      | default | default  | guest    | jeans      | Gender     | Men          | CM10      |

    @CyberMonday
    Examples:
      | locale           | langCode         | userType  | searchTerm | filterType | filterOption | promocode |
      | multiLangDefault | multiLangDefault | logged in | jeans      | Gender     | Men          | CM10      |

  @PeakTesting
  @Desktop @Mobile
  @Chrome @FireFox @Safari @ExcludeTH
  @UnifiedCheckout @Promocodes @OverviewPanel @Payment @P1
  Scenario Outline: CK Singles Day Order - As a guest/user I want to successfully place an order with a peak promotional discount
    Given I am on locale <locale> search page of langCode <langCode> with search term "<searchTerm>" with accepted cookies
      And I am a <userType> user
      And I wait until page Experience.PlpProducts is loaded
      And I wait until the current page is loaded
    When in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
    Then in unified filter panel I see filter type <filterType> with filter <filterOption> is active
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.PlpProducts.ListingItems with index 1 until ProductDetailPage.Pdp.Content is displayed
      And I wait until ProductDetailPage.Pdp.SingleSizeButtonByIndex with index 1 is clickable
      And I click on ProductDetailPage.Pdp.SingleSizeButtonByIndex with index 1
      And I wait for 2 seconds
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagButton
      And I wait until the current page is shopping-bag
      And the count of elements Experience.ShoppingBag.Item is equal to 1
    When I apply promocode "<promocode>" in the overview panel on shopping bag page and store the discounted amount with key #Discount
    Then I wait until Checkout.OverviewPanel.PromoCodeText is displayed
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until the current page is shipping page
      And I store the cartId
      And as a guest I add first delivery details
      And I wait for 3 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed in 7 seconds
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
    When I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @SinglesDay
    Examples:
      | locale  | langCode | userType | searchTerm | filterType | filterOption | promocode |
      | default | default  | guest    | sports     | Gender     | Men          | SD22      |

    @SinglesDay
    Examples:
      | locale           | langCode         | userType  | searchTerm | filterType | filterOption | promocode |
      | multiLangDefault | multiLangDefault | logged in | sports     | Gender     | Women        | SD22      |

  @PeakTesting
  @Desktop @Mobile
  @Chrome @FireFox @Safari @ExcludeCK
  @UnifiedCheckout @Promocodes @OverviewPanel @Payment @P1
  Scenario Outline: TH Peak Order Placement - As a guest/user I want to successfully place an order with a peak promotional discount
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And There is 1 product style with same current price of locale <locale>
      And I am a <userType> user
      And I wait until the current page is loaded
      And I extract a product item from product style <productStyle> which has inventory saved as #skuPartNumber
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item #skuPartNumber
      And I wait until the current page is shopping-bag
    Then the count of elements Experience.ShoppingBag.Item is equal to 1
    When I apply promocode "<promocode>" in the overview panel on shopping bag page and store the discounted amount with key #Discount
    Then I wait until Checkout.OverviewPanel.PromoCodeText is displayed
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until the current page is shipping page
      And I store the cartId
      And as a guest I add first delivery details
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed in 7 seconds
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

    @CyberMonday
    Examples:
      | locale  | langCode | userType | productStyle                   | promocode |
      | default | default  | guest    | product1#styleColourPartNumber | CM10      |

    @CyberMonday
    Examples:
      | locale           | langCode         | userType  | productStyle                   | promocode |
      | multiLangDefault | multiLangDefault | logged in | product1#styleColourPartNumber | CM10      |

    @SinglesDayRerun
    Examples:
      | locale  | langCode | userType | productStyle  | promocode |
      | default | default  | guest    | WW0WW11860410 | SD22      |

    @SinglesDayRerun
    Examples:
      | locale           | langCode         | userType  | productStyle  | promocode |
      | multiLangDefault | multiLangDefault | logged in | 1M87635002415 | SD22      |

  @PeakTesting
  @Desktop @Mobile
  @Chrome @FireFox @Safari @ExcludeTH
  @UnifiedCheckout @Promocodes @OverviewPanel @Payment @P2
  Scenario Outline: CK Peak Promocode - As a guest/user I want to successfully check peak promos
    Given I am on locale <locale> search page of langCode <langCode> with search term "<searchTerm>" with accepted cookies
      And I am a <userType> user
      And I wait until page Experience.PlpProducts is loaded
      And I wait until the current page is loaded
    When in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
    Then in unified filter panel I see filter type <filterType> with filter <filterOption> is active
    When in unified filter panel I open filter type Category and select Jeans as filter option
    Then in unified filter panel I see filter type Category with filter Jeans is active
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.PlpProducts.ListingItems with index 1
      And I wait until ProductDetailPage.Pdp.AddToBagButton is clickable
      And I click on ProductDetailPage.Pdp.WidthSizeButtonByIndex with index 1
      And I click on ProductDetailPage.Pdp.LengthSizeButtonByIndex with index 1
      And I wait for 2 seconds
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagButton
      And I wait until the current page is shopping-bag
      And the count of elements Experience.ShoppingBag.Item is equal to 1
    When I apply promocode "<promocode>" in the overview panel on shopping bag page and store the discounted amount with key #Discount
      And I wait until Checkout.OverviewPanel.PromoCodeText is displayed
    Then I see Checkout.OverviewPanel.PromoCodeText contains text "<discountText>"
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until the current page is shipping page
      And I store the cartId
    Then I see Checkout.OverviewPanel.PromoCodeText contains text "<discountText>"
      And I see Checkout.OverviewPanel.PromoCodePriceInfo contains text "#Discount"
      And as a guest I add first delivery details
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed in 7 seconds
    Then I see Checkout.OverviewPanel.PromoCodeText contains text "<discountText>"
      And I see Checkout.OverviewPanel.PromoCodePriceInfo contains text "#Discount"
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
    When I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed
    Then I see Checkout.OverviewPanel.PromoCodeText contains text "<discountText>"
      And I see Checkout.OverviewPanel.PromoCodePriceInfo contains text "#Discount"

    @CyberMonday
    Examples:
      | locale  | langCode | userType | searchTerm | filterType | filterOption | promocode | discountText |
      | default | default  | guest    | jeans      | Gender     | Men          | CM10      | CM10         |

  @PeakTesting
  @Desktop @Mobile
  @Chrome @FireFox @Safari @ExcludeTH
  @UnifiedCheckout @Promocodes @OverviewPanel @Payment @P2
  Scenario Outline: CK Peak Promocode - As a guest/user I want to successfully check peak promos
    Given I am on locale <locale> search page of langCode <langCode> with search term "<searchTerm>" with accepted cookies
      And I am a <userType> user
      And I wait until page Experience.PlpProducts is loaded
      And I wait until the current page is loaded
    When in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
    Then in unified filter panel I see filter type <filterType> with filter <filterOption> is active
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.PlpProducts.ListingItems with index 1
      And I wait until ProductDetailPage.Pdp.AddToBagButton is clickable
      And I click on ProductDetailPage.Pdp.SingleSizeButtonByIndex with index 1
      And I wait for 2 seconds
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagButton
      And I wait until the current page is shopping-bag
      And the count of elements Experience.ShoppingBag.Item is equal to 1
    When I apply promocode "<promocode>" in the overview panel on shopping bag page and store the discounted amount with key #Discount
      And I wait until Checkout.OverviewPanel.PromoCodeText is displayed
    Then I see Checkout.OverviewPanel.PromoCodeText contains text "<discountText>"
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until the current page is shipping page
      And I store the cartId
    Then I see Checkout.OverviewPanel.PromoCodeText contains text "<discountText>"
      And I see Checkout.OverviewPanel.PromoCodePriceInfo contains text "#Discount"
      And as a guest I add first delivery details
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed in 7 seconds
    Then I see Checkout.OverviewPanel.PromoCodeText contains text "<discountText>"
      And I see Checkout.OverviewPanel.PromoCodePriceInfo contains text "#Discount"
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
    When I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed
    Then I see Checkout.OverviewPanel.PromoCodeText contains text "<discountText>"
      And I see Checkout.OverviewPanel.PromoCodePriceInfo contains text "#Discount"

    @SinglesDay
    Examples:
      | locale  | langCode | userType | searchTerm | filterType | filterOption | promocode | discountText |
      | default | default  | guest    | sports     | Gender     | Women        | SD22      | SD22         |

  @PeakTesting
  @Desktop @Mobile
  @Chrome @FireFox @Safari @ExcludeCK
  @UnifiedCheckout @Promocodes @OverviewPanel @Payment @P2
  Scenario Outline: TH Peak Promocode - As a guest/user I want to successfully check peak promos
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And There is 1 product style with same current price of locale <locale>
      And I am a <userType> user
      And I wait until the current page is loaded
      And I extract a product item from product style <productStyle> which has inventory saved as #skuPartNumber
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item #skuPartNumber
      And I wait until the current page is shopping-bag
      And the count of elements Experience.ShoppingBag.Item is equal to 1
    When I apply promocode "<promocode>" in the overview panel on shopping bag page and store the discounted amount with key #DiscountedAmount
      And I wait until Checkout.OverviewPanel.PromoCodeText is displayed
    Then I see Checkout.OverviewPanel.PromoCodeText contains text "<discountText>"
    When I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until the current page is shipping page
      And I store the cartId
    Then I see Checkout.OverviewPanel.PromoCodeText contains text "<discountText>"
      And I see Checkout.OverviewPanel.PromoCodePriceInfo contains text "#DiscountedAmount"
      And as a guest I add first delivery details
      And I wait for 2 seconds
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is displayed in 7 seconds
    Then I see Checkout.OverviewPanel.PromoCodeText contains text "<discountText>"
      And I see Checkout.OverviewPanel.PromoCodePriceInfo contains text "#DiscountedAmount"
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
    When I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed
    Then I see Checkout.OverviewPanel.PromoCodeText contains text "<discountText>"
      And I see Checkout.OverviewPanel.PromoCodePriceInfo contains text "#DiscountedAmount"

    @CyberMonday
    Examples:
      | locale  | langCode | userType | productStyle  | promocode | discountText |
      | default | default  | guest    | KB0KB04140055 | CM10      | CM10         |

    @SinglesDayRerun
    Examples:
      | locale           | langCode         | userType  | productStyle  | promocode | discountText |
      | multiLangDefault | multiLangDefault | logged in | 1M87635002415 | SD22      | SD22         |
