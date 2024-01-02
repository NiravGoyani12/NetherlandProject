Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @P1
  @tms:UTR-874
  Scenario Outline: Payment method selection - The event is fired when I choose the payment method credit card
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    When I inject utag event listener
      And I click on Checkout.PaymentPage.CreditCardButton
    Then utag event payment_method_selection is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "payment_method_selection"
      And utag event #event should contain attr eventLabel with value "payment_method_credit_debit"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | userType  |
      | pl     | default  | guest     |
      | pl     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @P1
  @tms:UTR-1421
  Scenario Outline: Payment method selection - The event is fired when I choose the payment method paypal
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
    When I inject utag event listener
      And I click on Checkout.PaymentPage.PaypalButton
    Then utag event payment_method_selection is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "payment_method_selection"
      And utag event #event should contain attr eventLabel with value "payment_method_paypal"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | userType  |
      | de     | default  | guest     |
      | de    | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @P1
  @tms:UTR-5659
  Scenario Outline: Payment method selection - The event is fired when I choose the payment method Klarna
    Given I am <userType> on locale <locale> of langCode default on the payment page
      And I wait until Checkout.PaymentPage.Klarna is clickable
    When I inject utag event listener
      And I click on Checkout.PaymentPage.Klarna
    Then utag event payment_method_selection is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "payment_method_selection"
      And utag event #event should contain attr eventLabel with value "payment_method_klarna"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | userType  |
      | pl     | default  | guest     |
      | pl     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @P1
  @tms:UTR-5660
  Scenario Outline: Payment method selection - The event is fired when I choose the payment method Klarna over time
    Given I am <userType> on locale <locale> of langCode default on the payment page
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is clickable
    When I inject utag event listener
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
    Then utag event payment_method_selection is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "payment_method_selection"
      And utag event #event should contain attr eventLabel with value "payment_method_klarna_account"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | userType  |
      | ie     | default  | guest     |
      | ie     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @P1
  @tms:UTR-5831
  Scenario Outline: Payment method selection - The event is fired when I choose the payment method P24
    Given I am <userType> on locale <locale> of langCode default on the payment page
      And I wait until Checkout.PaymentPage.P24Button is clickable
    When I inject utag event listener
      And I click on Checkout.PaymentPage.P24Button
    Then utag event payment_method_selection is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "payment_method_selection"
      And utag event #event should contain attr eventLabel with value "payment_method_przelewy"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | userType  |
      | pl     | default  | guest     |
      | pl     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @P1
  @tms:UTR-8708
  Scenario Outline: Payment method selection - The event is fired when I choose the payment method POI Ratepay
    Given I am <userType> on locale <locale> of langCode default on the payment page
      And I wait until Checkout.PaymentPage.RatepayButton is clickable
    When I inject utag event listener
      And I wait until Checkout.PaymentPage.RatepayButton is clickable
      And I click on Checkout.PaymentPage.RatepayButton
    Then utag event payment_method_selection is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "payment_method_selection"
      And utag event #event should contain attr eventLabel with value "payment_method_ratepay"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | userType  |
      | de     | default  | guest     |
      | de     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @P1
  @tms:UTR-8788
  Scenario Outline: Payment method selection - The event is fired when I choose the payment method Bancontact
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.BancontactButton is clickable
    When I inject utag event listener
      And I click on Checkout.PaymentPage.BancontactButton
    Then utag event payment_method_selection is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "payment_method_selection"
      And utag event #event should contain attr eventLabel with value "payment_method_bcmc"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | userType  |
      | be     | default  | guest     |
      | be     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @P1
  @tms:UTR-8871
  Scenario Outline: Payment method selection - The event is fired when I choose the payment method Ideal
    Given I am <userType> on locale <locale> of langCode default on the payment page
      And I wait until Checkout.PaymentPage.IdealButton is clickable
    When I inject utag event listener
      And I click on Checkout.PaymentPage.IdealButton
    Then utag event payment_method_selection is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "payment_method_selection"
      And utag event #event should contain attr eventLabel with value "payment_method_ideal"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | userType  |
      | nl     | default  | guest     |
      | nl     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedCheckout @P1 
  @tms:UTR-17384 @AnalyticsGiftcard
  Scenario Outline: Payment method selection - The event is fired when I choose the payment method giftcard
      Given I am <userType> on locale <locale> of langCode default on the payment page
      And I wait until Checkout.PaymentPage.GiftCardButton is clickable
      When I inject utag event listener
      And I click on Checkout.PaymentPage.GiftCardButton
      Then utag event payment_method_selection is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "payment_method_selection"
      And utag event #event should contain attr eventLabel with value "payment_method_giftcard"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | userType  |
      | fi     | default  | guest     |
      | fi     | default  | logged in |
