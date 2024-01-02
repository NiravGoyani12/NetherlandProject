Feature: Unified Checkout - Cross Site - PayPal

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @Payment @PayPal @HappyFlow
  Scenario Outline: Cross Site - As guest/user I can pay by PayPal
    Given I am <userType> on locale <locale> of langCode <langCode> with <deliveryMethod> delivery method on the payment page
      And I wait until Checkout.PaymentPage.PaypalButton is clickable in 10 seconds
      And I store the cartId
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PaypalButton
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
    When I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds
    Then I see Order Confirmation Page with my delivery details

    @tms:UTR-10153
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | uk     | default  | guest    | standard       |

    @tms:UTR-10167
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | cz     | default  | logged in | standard       |

    # @tms:UTR-10156
    # Examples:
    #   | locale | langCode | userType | deliveryMethod |
    #   | lv     | default  | guest    | standard       |

    # @tms:UTR-10159
    # Examples:
    #   | locale | langCode | userType  | deliveryMethod |
    #   | lt     | default  | logged in | standard       |

    @tms:UTR-10157
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | be     | default  | guest    | express        |

    @tms:UTR-10274 @Mobile
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | be     | FR       | logged in | express        |

    # @tms:UTR-10158
    # Examples:
    #   | locale | langCode | userType | deliveryMethod |
    #   | si     | default  | guest    | standard       |

    # @tms:UTR-10181
    # Examples:
    #   | locale | langCode | userType  | deliveryMethod |
    #   | sk     | default  | logged in | standard       |

    # @tms:UTR-10179
    # Examples:
    #   | locale | langCode | userType | deliveryMethod |
    #   | ee     | default  | guest    | standard       |

    # @tms:UTR-10171
    # Examples:
    #   | locale | langCode | userType  | deliveryMethod |
    #   | hu     | default  | logged in | express        |

    # @tms:UTR-10170
    # Examples:
    #   | locale | langCode | userType | deliveryMethod |
    #   | hr     | default  | guest    | standard       |

    # @tms:UTR-10174 @ExcludeTH
    # Examples:
    #   | locale | langCode | userType  | deliveryMethod |
    #   | ro     | default  | logged in | standard       |

    # @tms:UTR-10175 @ExcludeTH
    # Examples:
    #   | locale | langCode | userType | deliveryMethod |
    #   | bg     | default  | guest    | standard       |

    @tms:UTR-10173
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | ie     | default  | logged in | express        |

    @tms:UTR-10164
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | pt     | default  | guest    | express        |

    @tms:UTR-10165
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | pl     | default  | logged in | standard       |

    @tms:UTR-10266
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | dk     | default  | guest    | express        |

    @tms:UTR-10267
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | fi     | default  | logged in | standard       |

    @tms:UTR-10268
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | se     | default  | guest    | express        |

    @tms:UTR-10269
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | it     | default  | logged in | express        |

    @tms:UTR-10270
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | es     | default  | guest    | standard       |

    @tms:UTR-10271 @Mobile
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | de     | default  | logged in | standard       |

    @tms:UTR-10272
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | fr     | default  | guest    | express        |

    @tms:UTR-10275
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | ch     | default  | guest    | standard       |

    @tms:UTR-10276
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | ch     | FR       | logged in | standard       |

    @tms:UTR-10277
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | ch     | IT       | guest    | standard       |

    @tms:UTR-13341
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | at     | default  | logged in | standard       |

    @tms:UTR-14829
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | de     | EN       | guest    | standard       |

  # @tms:UTR-10278
  # Examples:
  #   | locale | langCode |
  #   | lu     | default  |

  # @tms:UTR-10279
  # Examples:
  #   | locale | langCode |
  #   | lu     | DE       |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @Payment @PayPal @HappyFlow
  Scenario Outline: Cross Site - As guest/user I can pay by PayPal on nl locale
    Given I am <userType> on locale <locale> of langCode <langCode> with <deliveryMethod> delivery method on the payment page
      And I wait until Checkout.PaymentPage.PaypalButton is clickable in 10 seconds
      And I store the cartId
      And I click on Checkout.PaymentPage.PaypalButton
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
    When I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds
    Then I see Order Confirmation Page with my delivery details

    @tms:UTR-10273 @Mobile
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | nl     | default  | logged in | express        |

    @tms:UTR-17200
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | nl     | EN       | guest    | standard       |


  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @Payment @PayPal @HappyFlow
  Scenario Outline: Cross Site - As user I can pay by PayPal and verify email confirmation
    Given I am cross site user on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
      And I click on Checkout.PaymentPage.PaypalButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I select paypal payment and go to paypal layover
      And in paypal I complete payment
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds
      And I wait until Checkout.OrderConfirmationPage.ContinueShoppingButton is clickable
      And I verify order confirmation email with subject as <emailSubject> from outlook

    @tms:UTR-13282
    Examples:
      | locale | langCode | emailSubject          |
      | nl     | default  | Je orderbevestiging # |


# @FullRegression
# @Desktop
# @Chrome @FireFox @Safari
# @UnifiedCheckout @CrossSitePayment @Payment @PayPal @HappyFlow
# Scenario Outline: Cross Site - As user I can pay by PayPal
#   Given I am cross site user on locale <locale> of langCode <langCode> on the payment page
#     And I store the cartId
#     And I wait until Checkout.PaymentPage.PaypalButton is clickable
#     And I set T&C checkbox to true if XCOMREG is enabled
#     And I click on Checkout.PaymentPage.PaypalButton
#     And I wait until Checkout.PaymentPage.PayWithPayPal is clickable
#     And I select paypal payment and go to paypal layover
#     And in paypal I complete payment
#     And I switch to 1st browser tab
#   Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

#   @tms:UTR-10168 @Mobile
#   Examples:
#     | locale | langCode |
#     | uk     | default  |

#   @tms:UTR-10166
#   Examples:
#     | locale | langCode |
#     | cz     | default  |

#   @tms:UTR-10163
#   Examples:
#     | locale | langCode |
#     | lv     | default  |

#   @tms:UTR-10154
#   Examples:
#     | locale | langCode |
#     | lt     | default  |

#   # @tms:UTR-10155
#   # Examples:
#   #   | locale | langCode |
#   #   | be     | default  |

#   @tms:UTR-10287 @Mobile
#   Examples:
#     | locale | langCode |
#     | be     | FR       |

#   @tms:UTR-10160
#   Examples:
#     | locale | langCode |
#     | si     | default  |

#   @tms:UTR-10161
#   Examples:
#     | locale | langCode |
#     | sk     | default  |

#   @tms:UTR-10176
#   Examples:
#     | locale | langCode |
#     | ee     | default  |

#   @tms:UTR-10180
#   Examples:
#     | locale | langCode |
#     | hu     | default  |

#   @tms:UTR-10182
#   Examples:
#     | locale | langCode |
#     | hr     | default  |

#   @tms:UTR-10177 @ExcludeTH
#   Examples:
#     | locale | langCode |
#     | ro     | default  |

#   @tms:UTR-10178 @ExcludeTH
#   Examples:
#     | locale | langCode |
#     | bg     | default  |

#   @tms:UTR-10172
#   Examples:
#     | locale | langCode |
#     | ie     | default  |

#   @tms:UTR-10169
#   Examples:
#     | locale | langCode |
#     | pt     | default  |

#   @tms:UTR-10162
#   Examples:
#     | locale | langCode |
#     | pl     | default  |

#   @tms:UTR-10280
#   Examples:
#     | locale | langCode |
#     | dk     | default  |

#   @tms:UTR-10281
#   Examples:
#     | locale | langCode |
#     | fi     | default  |

#   @tms:UTR-10282
#   Examples:
#     | locale | langCode |
#     | se     | default  |

#   @tms:UTR-10283 @ExcludeTH
#   Examples:
#     | locale | langCode |
#     | it     | default  |

#   @tms:UTR-10285
#   Examples:
#     | locale | langCode |
#     | es     | default  |

#   @tms:UTR-10284 @ExcludeTH @Mobile
#   Examples:
#     | locale | langCode |
#     | de     | default  |

#   @tms:UTR-10286
#   Examples:
#     | locale | langCode |
#     | fr     | default  |

#   # @tms:UTR-10288 @Mobile
#   # Examples:
#   #   | locale | langCode |
#   #   | nl     | default  |

#   # @tms:UTR-10289
#   # Examples:
#   #   | locale | langCode |
#   #   | ch     | default  |

#   # @tms:UTR-10290
#   # Examples:
#   #   | locale | langCode |
#   #   | ch     | IT       |

#   @tms:UTR-10291
#   Examples:
#     | locale | langCode |
#     | ch     | FR       |

#   # @tms:UTR-10292
#   # Examples:
#   #   | locale | langCode |
#   #   | lu     | default  |

#   @tms:UTR-10293
#   Examples:
#     | locale | langCode |
#     | lu     | DE       |

#   @tms:UTR-13340
#   Examples:
#     | locale | langCode |
#     | at     | default  |
