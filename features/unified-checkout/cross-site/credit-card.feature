Feature: Unified Checkout - Cross Site - Credit Card

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @EESCK
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @CreditCard @HappyFlow
  Scenario Outline: Cross Site - As guest/user I can successfully place an Order using credit card
    Given I am <userType> on locale <locale> of langCode <langCode> with <deliveryMethod> delivery method on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
      And I store the cartId
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
    When I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Then I see Order Confirmation Page with my delivery details

    @tms:UTR-10053 @Mobile
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | uk     | 4988 4388 4388 4305 | default  | guest    | standard       |

    @tms:UTR-10071
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | lt     | 4111 1111 1111 1111 | default  | logged in | standard       |

    @tms:UTR-10066
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | ee     | 4988 4388 4388 4305 | default  | guest    | standard       |

    @tms:UTR-10074
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | be     | 5100 2900 2900 2909 | default  | logged in | express        |

    @tms:UTR-10222 @Mobile
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | be     | 5100 2900 2900 2909 | FR       | guest    | express        |

    @tms:UTR-10040
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | si     | 5100 2900 2900 2909 | default  | logged in | standard       |

    @tms:UTR-10048
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | sk     | 4988 4388 4388 4305 | default  | guest    | standard       |

    @tms:UTR-10050
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | cz     | 5100 2900 2900 2909 | default  | logged in | standard       |

    @tms:UTR-10051
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | hu     | 4988 4388 4388 4305 | default  | guest    | express        |

    @tms:UTR-10059
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | hr     | 4111 1111 1111 1111 | default  | logged in | standard       |

    @tms:UTR-10060
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | lv     | 5100 2900 2900 2909 | default  | guest    | standard       |

    @tms:UTR-10068 @ExcludeTH
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | ro     | 4111 1111 1111 1111 | default  | logged in | standard       |

    @tms:UTR-10067 @ExcludeTH
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | bg     | 4988 4388 4388 4305 | default  | guest    | standard       |

    @tms:UTR-10070 @Mobile
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | ie     | 5100 2900 2900 2909 | default  | logged in | express        |

    @tms:UTR-10072
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | pt     | 4111 1111 1111 1111 | default  | guest    | express        |

    @tms:UTR-10069
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | pl     | 4988 4388 4388 4305 | default  | logged in | standard       |

    @tms:UTR-10043
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | dk     | 5100 2900 2900 2909 | default  | guest    | express        |

    @tms:UTR-10041
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | se     | 4111 1111 1111 1111 | default  | logged in | express        |

    @tms:UTR-10047
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | fi     | 4988 4388 4388 4305 | default  | guest    | standard       |

    @tms:UTR-10045
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | es     | 5100 2900 2900 2909 | default  | logged in | standard       |

    @tms:UTR-10044
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | it     | 4111 1111 1111 1111 | default  | guest    | express        |

    @tms:UTR-10218 @Mobile
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | de     | 4988 4388 4388 4305 | default  | guest    | standard       |

    @tms:UTR-10220 @Mobile
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | fr     | 4988 4388 4388 4305 | default  | logged in | express        |

    @tms:UTR-10223
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | lu     | 4111 1111 1111 1111 | default  | logged in | express        |

    @tms:UTR-10224
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | lu     | 4111 1111 1111 1111 | DE       | guest    | express        |

    @tms:UTR-10225
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | ch     | 5100 2900 2900 2909 | default  | logged in | standard       |

    @tms:UTR-10227
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | ch     | 5100 2900 2900 2909 | FR       | guest    | standard       |

    @tms:UTR-10226
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | ch     | 5100 2900 2900 2909 | IT       | logged in | standard       |

    @tms:UTR-13334
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | at     | 4111 1111 1111 1111 | default  | guest    | standard       |

    @tms:UTR-14825
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | de     | 4111 1111 1111 1111 | EN       | logged in | standard       |

  # @FullRegression
  # @Desktop
  # @Chrome @FireFox @Safari
  # @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @CreditCard @HappyFlow
  # Scenario Outline: Cross Site - As user I can successfully place a non 3DS order
    # Given I am cross site user on locale <locale> of langCode <langCode> on the payment page
  #     And I store the cartId
  #     And I wait until Checkout.PaymentPage.CreditCardButton is clickable
  #     And I click on Checkout.PaymentPage.CreditCardButton
  #     And in payment page I fill in the credit card details
  #     | element    | value      |
  #     | cardNumber | <card>     |
  #     | cvv        | 737        |
  #     | year       | 2030       |
  #     | month      | 03         |
  #     | firstName  | QA         |
  #     | lastName   | Automation |
  #     And I set T&C checkbox to true if XCOMREG is enabled
  #     And I click on Checkout.PaymentPage.PlaceOrderButton
  #   Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

  #   @tms:UTR-10052 @Mobile
  #   Examples:
  #     | locale | card                | langCode |
  #     | uk     | 4988 4388 4388 4305 | default  |

  #   @tms:UTR-10055
  #   Examples:
  #     | locale | card                | langCode |
  #     | ee     | 5100 2900 2900 2909 | default  |

  #   # @tms:UTR-10056
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | be     | 4111 1111 1111 1111 | default  |

  #   @tms:UTR-10228 @Mobile
  #   Examples:
  #     | locale | card                | langCode |
  #     | be     | 5100 2900 2900 2909 | FR       |

  #   @tms:UTR-10073
  #   Examples:
  #     | locale | card                | langCode |
  #     | lt     | 4988 4388 4388 4305 | default  |

  #   @tms:UTR-10054
  #   Examples:
  #     | locale | card                | langCode |
  #     | si     | 5100 2900 2900 2909 | default  |

  #   @tms:UTR-10063
  #   Examples:
  #     | locale | card                | langCode |
  #     | sk     | 4111 1111 1111 1111 | default  |

  #   @tms:UTR-10065
  #   Examples:
  #     | locale | card                | langCode |
  #     | cz     | 4988 4388 4388 4305 | default  |

  #   @tms:UTR-10039
  #   Examples:
  #     | locale | card                | langCode |
  #     | hu     | 4111 1111 1111 1111 | default  |

  #   @tms:UTR-10042
  #   Examples:
  #     | locale | card                | langCode |
  #     | hr     | 4988 4388 4388 4305 | default  |

  #   @tms:UTR-10049
  #   Examples:
  #     | locale | card                | langCode |
  #     | lv     | 5100 2900 2900 2909 | default  |

  #   @tms:UTR-10046 @ExcludeTH
  #   Examples:
  #     | locale | card                | langCode |
  #     | ro     | 4988 4388 4388 4305 | default  |

  #   @tms:UTR-10037 @ExcludeTH
  #   Examples:
  #     | locale | card                | langCode |
  #     | bg     | 4111 1111 1111 1111 | default  |

  #   @tms:UTR-10038
  #   Examples:
  #     | locale | card                | langCode |
  #     | ie     | 5100 2900 2900 2909 | default  |

  #   @tms:UTR-10035
  #   Examples:
  #     | locale | card                | langCode |
  #     | pt     | 4988 4388 4388 4305 | default  |

  #   @tms:UTR-10036
  #   Examples:
  #     | locale | card                | langCode |
  #     | pl     | 4988 4388 4388 4305 | default  |

  #   @tms:UTR-10057 @Mobile
  #   Examples:
  #     | locale | card                | langCode |
  #     | dk     | 5100 2900 2900 2909 | default  |

  #   @tms:UTR-10062
  #   Examples:
  #     | locale | card                | langCode |
  #     | se     | 4111 1111 1111 1111 | default  |

  #   @tms:UTR-10064
  #   Examples:
  #     | locale | card                | langCode |
  #     | fi     | 4988 4388 4388 4305 | default  |

  #   @tms:UTR-10061
  #   Examples:
  #     | locale | card                | langCode |
  #     | es     | 5100 2900 2900 2909 | default  |

  #   @tms:UTR-10058
  #   Examples:
  #     | locale | card                | langCode |
  #     | it     | 4111 1111 1111 1111 | default  |

  #   @tms:UTR-10219 @Mobile
  #   Examples:
  #     | locale | card                | langCode |
  #     | de     | 4988 4388 4388 4305 | default  |

  #   @tms:UTR-10229
  #   Examples:
  #     | locale | card                | langCode |
  #     | fr     | 4988 4388 4388 4305 | default  |

  #   # @tms:UTR-10230 @Mobile
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | nl     | 4111 1111 1111 1111 | default  |

  #   @tms:UTR-10231
  #   Examples:
  #     | locale | card                | langCode |
  #     | lu     | 5100 2900 2900 2909 | default  |

  #   # @tms:UTR-10232
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | lu     | 5100 2900 2900 2909 | DE       |

  #   # @tms:UTR-10233
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | ch     | 4988 4388 4388 4305 | default  |

  #   # @tms:UTR-10234
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | ch     | 4988 4388 4388 4305 | FR       |

  #   @tms:UTR-10235
  #   Examples:
  #     | locale | card                | langCode |
  #     | ch     | 5100 2900 2900 2909 | IT       |

  #   @tms:UTR-13334
  #   Examples:
  #     | locale | card                | langCode |
  #     | at     | 4111 1111 1111 1111 | default  |


  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @EESCK
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @CreditCard @HappyFlow
  Scenario Outline: Cross Site - As guest/user I can successfully place an Order using credit card on nl locale
    Given I am <userType> on locale <locale> of langCode <langCode> with <deliveryMethod> delivery method on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable in 10 seconds
      And I store the cartId
      And I click on Checkout.PaymentPage.CreditCardButton
      And in payment page I fill in the credit card details
      | element    | value      |
      | cardNumber | <card>     |
      | cvv        | 737        |
      | year       | 2030       |
      | month      | 03         |
      | firstName  | QA         |
      | lastName   | Automation |
      And I click on Checkout.PaymentPage.PlaceOrderButton
    When I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Then I see Order Confirmation Page with my delivery details

    @tms:UTR-10221 @Mobile
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | nl     | 4988 4388 4388 4305 | default  | guest    | express        |

    @tms:UTR-17179
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | nl     | 4988 4388 4388 4305 | EN       | logged in | express        |