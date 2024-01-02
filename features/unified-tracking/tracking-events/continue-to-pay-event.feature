Feature: Unified Tracking - Events

  #TODO: uncomment once this functionality is implemented
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedCheckout
  @tms:xx
  Scenario Outline: Continue to pay - The event is fired when I click on the continue to pay button on the delivery page
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
    When I inject utag event listener
      And I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until the current page is loaded
    Then utag event continue_to_pay is fired saved to key #event
      And utag event #event should contain attr event_name with value "continue_to_pay"
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "continue_to_pay"
      And utag event #event should contain attr eventLabel with value "checkout - address shipment|checkout>shipping"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | userType  |
      | ee     | default  | guest     |
      | ee     | default  | logged in |

  # add to full regression once deployed on UAT
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer
  @ShoppingBag @CET1
  @tms:UTR-9992
  Scenario Outline: Continue to pay - The event is fired when I click on the continue to pay button on the shopping bag page
    Given I am on locale <locale> shopping bag page with 1 unit of any product with forced accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter contains text "1"
    When I inject utag event listener
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I wait until the current page is loaded
    Then utag event continue_to_pay is fired saved to key #event
      And utag event #event should contain attr event_name with value "continue_to_pay"
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "continue_to_pay"
      And utag event #event should contain attr eventLabel with value "cart|checkout>cart"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode |
      | ee     | default  |

  # TODO: Check for failures
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedCheckout
  @TEE @PDP
  @tms:UTR-10530
  Scenario Outline: Continue to pay - The event is fired when I click on the continue to pay button on PDP
    Given There is 1 normal size product item of locale <locale> with inventory between 50 and 9999
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until page ProductDetailPage.Pdp is loaded
    When I inject utag event listener
      And in unified PDP I select size by sku part number product1#skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Pdp.CheckoutButton
      And I wait until the current page is loaded
    Then utag event continue_to_pay is fired saved to key #event
      And utag event #event should contain attr event_name with value "continue_to_pay"
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "continue_to_pay"
      And utag event #event should contain attr eventLabel with value "pdp_popup"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale |
      | ee     |
  # TODO: Check for failures
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedCheckout
  @CET1
  @tms:UTR-13129
  Scenario Outline: Continue to pay - The event is fired when I click on the continue to pay button on Mini Shoppingbag
    Given I am on locale <locale> shopping bag page with 1 unit of any product with forced accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I navigate to page <page>
      And I wait until Experience.Header.ShoppingBagCounter is displayed
    When I inject utag event listener
      And I hover over Experience.Header.ShoppingBagButton
      And I click on Experience.MiniShoppingBag.CheckOutButton
      And I wait until the current page is loaded
    Then utag event continue_to_pay is fired saved to key #event
      And utag event #event should contain attr event_name with value "continue_to_pay"
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "continue_to_pay"
      And utag event #event should contain attr eventLabel with value "header"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | page |
      | ee     | wlp  |