Feature: Unified Tracking - Events

  #TODO: uncomment once this functionality is implemented
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @Payment @PaypalExpress @UnifiedCheckout @P1
  @MiniShoppingBag
  Scenario Outline: Pay with paypal express - The event is fired when I pay with paypal express from Mini Shopping Bag
    Given I am on locale <locale> of langCode <langCode> with 2 products on shipping page
    When I inject utag event listener
      And I navigate to page <page>
      # TODO: add PPX buttons
      #  And I click on MiniShoppingBag.BasketIcon
      #  And I click on MiniShoppingBag.PaypalExpressButton
      #  And I wait until MiniShoppingBag.PaypalExpressButtonModal is clickable
      #  And I set the checkbox MiniShoppingBag.PaypalExpressTermsConditionsCheckbox status to true
      #  And I click on MiniShoppingBag.PaypalExpressButtonModal
      And I navigate to page <page>
      And in js extract digitalData.page.pageInfo.pageName save to #pageName
    Then utag event pay_with_paypal_express is fired saved to key #event
      And utag event #event should contain attr event_name with value "pay_with_paypal_express"
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "pay_with_paypal_express"
      And utag event #event should contain attr eventLabel with value "#pageName"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | page         |
      | ee     | default  | shopping-bag |
      | ee     | default  | pdp          |

  #TODO: uncomment once this functionality is implemented
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @Payment @PaypalExpress @UnifiedCheckout @P1
  @ShoppingBagPage
  @tms:UTR-9987
  Scenario Outline: Pay with paypal express - The event is fired when I pay with paypal express from Shopping Bag
    Given There is 1 normal size product item of locale <locale> and langCode <langCode> with inventory between 11 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
    When I inject utag event listener
      And I click on Experience.ShoppingBag.CheckoutWithPaypalButton
      And I set the checkbox Experience.ShoppingBag.PaypalTermsAndConditionCheckBox status to true if displayed
      And I click on Experience.ShoppingBag.PaypalTermsAndConditionCheckoutButton if displayed
      And I navigate to page shopping-bag
    Then utag event pay_with_paypal_express is fired saved to key #event
      And utag event #event should contain attr event_name with value "pay_with_paypal_express"
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "pay_with_paypal_express"
      And utag event #event should contain attr eventLabel with value "cartcheckout>cart"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode |
      | ee     | default  |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @Payment @PaypalExpress @UnifiedCheckout @P1
  @SignIn
  @tms:UTR-875
  Scenario Outline: Pay with paypal express - The event is fired when I pay with paypal express from Checkout Sign In Page
    Given I am on locale <locale> of langCode <langCode> with 2 products on shipping page
      And I wait until Checkout.SignInPage.PaypalExpressButton is clickable
    When I inject utag event listener
      And I select paypal express and get to paypal login
    Then utag event pay_with_paypal_express is fired saved to key #event
      And utag event #event should contain attr event_name with value "pay_with_paypal_express"
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "pay_with_paypal_express"
      And utag event #event should contain attr eventLabel with value "checkout - address shipment|checkout>shipping"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode |
      | cz     | default  |