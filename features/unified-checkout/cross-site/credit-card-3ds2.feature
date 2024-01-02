Feature: Unified Checkout - Cross Site - Credit Card 3DS2

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @CreditCard @3DS2 @HappyFlow
  Scenario Outline: Cross Site - As guest/user I can successfully place a 3DS2 order
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
      And I wait for 5 seconds
    When in 3DS2 pop-up I fill in the Adyen password "password"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Then I see Order Confirmation Page with my delivery details

    @tms:UTR-10082 @Mobile
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | uk     | 4917 6100 0000 0000 | default  | guest    | standard       |

    @tms:UTR-10086
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | lt     | 5454 5454 5454 5454 | default  | logged in | standard       |

    @tms:UTR-10113
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | ee     | 4917 6100 0000 0000 | default  | guest    | standard       |

    @tms:UTR-10114
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | be     | 5454 5454 5454 5454 | default  | logged in | express        |

    @tms:UTR-10236 @Mobile
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | be     | 4917 6100 0000 0000 | FR       | guest    | standard       |

    @tms:UTR-10087
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | si     | 4917 6100 0000 0000 | default  | logged in | standard       |

    @tms:UTR-10089
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | sk     | 5454 5454 5454 5454 | default  | guest    | standard       |

    @tms:UTR-10083
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | cz     | 4917 6100 0000 0000 | default  | logged in | standard       |

    @tms:UTR-10084
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | hu     | 5454 5454 5454 5454 | default  | guest    | express        |

    @tms:UTR-10097
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | hr     | 4917 6100 0000 0000 | default  | logged in | standard       |

    @tms:UTR-10094
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | lv     | 5454 5454 5454 5454 | default  | guest    | standard       |

    @tms:UTR-10095 @ExcludeTH
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | ro     | 4917 6100 0000 0000 | default  | logged in | standard       |

    @tms:UTR-10100 @ExcludeTH
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | bg     | 5454 5454 5454 5454 | default  | guest    | standard       |

    @tms:UTR-10101 @Mobile
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | ie     | 4917 6100 0000 0000 | default  | logged in | express        |

    @tms:UTR-10098
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | pt     | 5454 5454 5454 5454 | default  | guest    | express        |

    @tms:UTR-10099
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | pl     | 4917 6100 0000 0000 | default  | logged in | standard       |

    @tms:UTR-10080
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | dk     | 5454 5454 5454 5454 | default  | guest    | express        |

    @tms:UTR-10079
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | fi     | 4917 6100 0000 0000 | default  | logged in | standard       |

    @tms:UTR-10088
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | se     | 5454 5454 5454 5454 | default  | guest    | express        |

    @tms:UTR-10103
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | es     | 4917 6100 0000 0000 | default  | logged in | standard       |

    @tms:UTR-10102
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | it     | 5454 5454 5454 5454 | default  | guest    | express        |

    @tms:UTR-10238 @Mobile
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | de     | 4917 6100 0000 0000 | default  | logged in | standard       |

    @tms:UTR-10237 @Mobile
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | fr     | 5454 5454 5454 5454 | default  | logged in | express        |

    @tms:UTR-10239
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | lu     | 4917 6100 0000 0000 | default  | guest    | standard       |

    @tms:UTR-10240
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | lu     | 4917 6100 0000 0000 | DE       | logged in | express        |

    @tms:UTR-10241
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | ch     | 5454 5454 5454 5454 | default  | guest    | standard       |

    @tms:UTR-10242
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | ch     | 5454 5454 5454 5454 | FR       | logged in | standard       |

    @tms:UTR-10243
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | ch     | 5454 5454 5454 5454 | IT       | guest    | standard       |

    @tms:UTR-13336
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | at     | 4917 6100 0000 0000 | default  | logged in | standard       |

    @tms:UTR-14824
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | de     | 4917 6100 0000 0000 | EN       | guest    | standard       |


  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @CreditCard @3DS2 @HappyFlow
  Scenario Outline: Cross Site - As guest/user I can successfully place a 3DS2 order on nl locale
    Given I am <userType> on locale <locale> of langCode <langCode> with <deliveryMethod> delivery method on the payment page
      And I wait until the current page is loaded
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
      And I wait for 5 seconds
    When in 3DS2 pop-up I fill in the Adyen password "password"
      And I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
    Then I see Order Confirmation Page with my delivery details

    @tms:UTR-10247
    Examples:
      | locale | card                | langCode | userType | deliveryMethod |
      | nl     | 4917 6100 0000 0000 | default  | guest    | express        |

    @tms:UTR-17174
    Examples:
      | locale | card                | langCode | userType  | deliveryMethod |
      | nl     | 4917 6100 0000 0000 | EN       | logged in | express        |

# @FullRegression
# @Desktop
# @Chrome @FireFox @Safari
# @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @CreditCard @3DS2 @HappyFlow
# Scenario Outline: Cross Site - As user I can successfully place a 3DS2 order
#   Given I am cross site user on locale <locale> of langCode <langCode> on the payment page
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
#     And I wait for 5 seconds
#   When in 3DS2 pop-up I fill in the Adyen password "password"
#   Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

#   @tms:UTR-10106 @Mobile @P1
#   Examples:
#     | locale | card                | langCode |
#     | uk     | 5454 5454 5454 5454 | default  |

#   @tms:UTR-10096
#   Examples:
#     | locale | card                | langCode |
#     | ee     | 5454 5454 5454 5454 | default  |

#   @tms:UTR-10111
#   Examples:
#     | locale | card                | langCode |
#     | lt     | 4917 6100 0000 0000 | default  |

#   @tms:UTR-10112
#   Examples:
#     | locale | card                | langCode |
#     | si     | 5454 5454 5454 5454 | default  |

#   # @tms:UTR-10110
#   # Examples:
#   #   | locale | card                | langCode |
#   #   | be     | 4917 6100 0000 0000 | default  |

#   @tms:UTR-10249 @Mobile
#   Examples:
#     | locale | card                | langCode |
#     | be     | 5454 5454 5454 5454 | FR       |

#   @tms:UTR-10085
#   Examples:
#     | locale | card                | langCode |
#     | cz     | 5454 5454 5454 5454 | default  |

#   @tms:UTR-10092
#   Examples:
#     | locale | card                | langCode |
#     | sk     | 4917 6100 0000 0000 | default  |

#   @tms:UTR-10093
#   Examples:
#     | locale | card                | langCode |
#     | hr     | 5454 5454 5454 5454 | default  |

#   @tms:UTR-10090
#   Examples:
#     | locale | card                | langCode |
#     | hu     | 4917 6100 0000 0000 | default  |

#   @tms:UTR-10091 @ExcludeTH
#   Examples:
#     | locale | card                | langCode |
#     | ro     | 5454 5454 5454 5454 | default  |

#   @tms:UTR-10077 @ExcludeTH
#   Examples:
#     | locale | card                | langCode |
#     | bg     | 4917 6100 0000 0000 | default  |

#   @tms:UTR-10078
#   Examples:
#     | locale | card                | langCode |
#     | lv     | 4917 6100 0000 0000 | default  |

#   @tms:UTR-10075 @Mobile
#   Examples:
#     | locale | card                | langCode |
#     | ie     | 5454 5454 5454 5454 | default  |

#   @tms:UTR-10076
#   Examples:
#     | locale | card                | langCode |
#     | pl     | 5454 5454 5454 5454 | default  |

#   @tms:UTR-10081
#   Examples:
#     | locale | card                | langCode |
#     | pt     | 4917 6100 0000 0000 | default  |

#   @tms:UTR-10105
#   Examples:
#     | locale | card                | langCode |
#     | dk     | 5454 5454 5454 5454 | default  |

#   @tms:UTR-10104
#   Examples:
#     | locale | card                | langCode |
#     | fi     | 4917 6100 0000 0000 | default  |

#   @tms:UTR-10109
#   Examples:
#     | locale | card                | langCode |
#     | se     | 5454 5454 5454 5454 | default  |

#   @tms:UTR-10108
#   Examples:
#     | locale | card                | langCode |
#     | es     | 4917 6100 0000 0000 | default  |

#   @tms:UTR-10107
#   Examples:
#     | locale | card                | langCode |
#     | it     | 5454 5454 5454 5454 | default  |

#   @tms:UTR-10244 @Mobile
#   Examples:
#     | locale | card                | langCode |
#     | de     | 4917 6100 0000 0000 | default  |

#   @tms:UTR-10245
#   Examples:
#     | locale | card                | langCode |
#     | fr     | 5454 5454 5454 5454 | default  |

#   # @tms:UTR-10246
#   # Examples:
#   #   | locale | card                | langCode |
#   #   | nl     | 5454 5454 5454 5454 | default  |

#   # @tms:UTR-10248
#   # Examples:
#   #   | locale | card                | langCode |
#   #   | lu     | 5454 5454 5454 5454 | default  |

#   @tms:UTR-13337
#   Examples:
#     | locale | card                | langCode |
#     | at     | 4917 6100 0000 0000 | default  |

#   @tms:UTR-10250
#   Examples:
#     | locale | card                | langCode |
#     | lu     | 5454 5454 5454 5454 | DE       |

#   # @tms:UTR-10251
#   # Examples:
#   #   | locale | card                | langCode |
#   #   | ch     | 4917 6100 0000 0000 | default  |

#   # @tms:UTR-10252
#   # Examples:
#   #   | locale | card                | langCode |
#   #   | ch     | 4917 6100 0000 0000 | FR       |

#   @tms:UTR-10253 @Mobile
#   Examples:
#     | locale | card                | langCode |
#     | ch     | 5454 5454 5454 5454 | IT       |