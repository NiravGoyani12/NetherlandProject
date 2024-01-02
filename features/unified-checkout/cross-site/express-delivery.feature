Feature: Unified Checkout - Cross Site - Express delivery method

  # # @FullRegression
  # @Desktop
  # @Chrome @FireFox @Safari
  # @UnifiedCheckout @CrossSitePayment @CreditCard @DeliveryMethods @ExpressDelivery @HappyFlow
  # Scenario Outline: Cross Site - As guest I can place an order with express delivery
  #   Given I am guest on locale <locale> of langCode <langCode> with express delivery method on the payment page
  #     And I store the cartId
  #     And I wait until Checkout.PaymentPage.CreditCardButton is clickable
  #     And I get translation for "ExpressDelivery" and store it with key #DeliveryText
  #     And I get express shipping costs for current locale and store it with key #ShippingCosts
  #   Then I see Checkout.OverviewPanel.ShippingPrice contains text "#ShippingCosts"
  #     And I see Checkout.OverviewPanel.ShippingMethod contains text "#DeliveryText"
  #   When I click on Checkout.PaymentPage.CreditCardButton
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
  #   When I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds
  #   Then I see Order Confirmation Page with my delivery details

  #   # @tms:UTR-10132
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | lt     | 4111 1111 1111 1111 | default  |

  #   # @tms:UTR-10139
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | ee     | 4988 4388 4388 4305 | default  |

  #   @tms:UTR-10141
  #   Examples:
  #     | locale | card                | langCode |
  #     | be     | 5100 2900 2900 2909 | default  |

  #   @tms:UTR-10254 @issue:EESCK-10758
  #   Examples:
  #     | locale | card                | langCode |
  #     | be     | 4988 4388 4388 4305 | FR       |

  #   # @tms:UTR-10147
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | si     | 5100 2900 2900 2909 | default  |

  #   # @tms:UTR-10151
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | sk     | 4988 4388 4388 4305 | default  |

  #   # @tms:UTR-10144
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | cz     | 5100 2900 2900 2909 | default  |

  #   @tms:UTR-10145
  #   Examples:
  #     | locale | card                | langCode |
  #     | hu     | 4988 4388 4388 4305 | default  |

  #   # @tms:UTR-10135
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | hr     | 4111 1111 1111 1111 | default  |

  #   # @tms:UTR-10136
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | lv     | 5100 2900 2900 2909 | default  |

  #   @tms:UTR-10133 @ExcludeTH
  #   Examples:
  #     | locale | card                | langCode |
  #     | ro     | 4111 1111 1111 1111 | default  |

  #   # @tms:UTR-10134 @ExcludeTH
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | bg     | 4988 4388 4388 4305 | default  |

  #   @tms:UTR-10123
  #   Examples:
  #     | locale | card                | langCode |
  #     | ie     | 5100 2900 2900 2909 | default  |

  #   @tms:UTR-10120
  #   Examples:
  #     | locale | card                | langCode |
  #     | pt     | 4111 1111 1111 1111 | default  |

  #   # @tms:UTR-10122
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | pl     | 4988 4388 4388 4305 | default  |

  #   @tms:UTR-10149
  #   Examples:
  #     | locale | card                | langCode |
  #     | dk     | 5100 2900 2900 2909 | default  |

  #   # @tms:UTR-10146
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | fi     | 4111 1111 1111 1111 | default  |

  #   @tms:UTR-10152
  #   Examples:
  #     | locale | card                | langCode |
  #     | se     | 4988 4388 4388 4305 | default  |

  #   @tms:UTR-10118
  #   Examples:
  #     | locale | card                | langCode |
  #     | it     | 5100 2900 2900 2909 | default  |

  #   # @tms:UTR-10119
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | es     | 4111 1111 1111 1111 | default  |

  #   # @tms:UTR-10255 @Mobile @ExcludeDB0
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | de     | 4988 4388 4388 4305 | default  |

  #   @tms:UTR-10256 @Mobile
  #   Examples:
  #     | locale | card                | langCode |
  #     | fr     | 5100 2900 2900 2909 | default  |

  #   @tms:UTR-10258
  #   Examples:
  #     | locale | card                | langCode |
  #     | lu     | 4988 4388 4388 4305 | default  |

  #   @tms:UTR-10259 @Mobile
  #   Examples:
  #     | locale | card                | langCode |
  #     | lu     | 4988 4388 4388 4305 | DE       |

  #   # @tms:UTR-13338
  #   # Examples:
  #   #   | locale | card                | langCode |
  #   #   | at     | 4111 1111 1111 1111 | default  |

  # @FullRegression
  # @Desktop
  # @Chrome @FireFox @Safari
  # @UnifiedCheckout @CrossSitePayment @PayPal @Payment @DeliveryMethods @HappyFlow
  # Scenario Outline: Cross Site - As user I can place an order with express delivery
  #   Given I am logged in on locale <locale> of langCode <langCode> with express delivery method on the payment page
  #     And I store the cartId
  #     And I wait until Checkout.PaymentPage.CreditCardButton is clickable
  #     And I get translation for "ExpressDelivery" and store it with key #DeliveryText
  #     And I get express shipping costs for current locale and store it with key #ShippingCosts
  #   Then I see Checkout.OverviewPanel.ShippingPrice contains text "#ShippingCosts"
  #     And I see Checkout.OverviewPanel.ShippingMethod contains text "#DeliveryText"
  #   When I click on Checkout.PaymentPage.PaypalButton
  #     And I wait until Checkout.PaymentPage.PayWithPayPal is clickable
  #     And I set T&C checkbox to true if XCOMREG is enabled
  #     And I select paypal payment and go to paypal layover
  #     And in paypal I complete payment
  #   When I switch to 1st browser tab
  #   Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

  #   # @tms:UTR-10131
  #   # Examples:
  #   #   | locale | langCode |
  #   #   | ee     | default  |

  #   @tms:UTR-10128
  #   Examples:
  #     | locale | langCode |
  #     | be     | default  |

  #   @tms:UTR-10263 @issue:EESCK-10758
  #   Examples:
  #     | locale | langCode |
  #     | be     | FR       |

  #   # @tms:UTR-10129
  #   # Examples:
  #   #   | locale | langCode |
  #   #   | lt     | default  |

  #   # @tms:UTR-10125
  #   # Examples:
  #   #   | locale | langCode |
  #   #   | si     | default  |

  #   # @tms:UTR-10127
  #   # Examples:
  #   #   | locale | langCode |
  #   #   | sk     | default  |

  #   # @tms:UTR-10116
  #   # Examples:
  #   #   | locale | langCode |
  #   #   | cz     | default  |

  #   # @tms:UTR-10117
  #   # Examples:
  #   #   | locale | langCode |
  #   #   | hu     | default  |

  #   @tms:UTR-10115
  #   # Examples:
  #   #   | locale | langCode |
  #   #   | hr     | default  |

  #   # @tms:UTR-10142
  #   # Examples:
  #   #   | locale | langCode |
  #   #   | lv     | default  |

  #   @tms:UTR-10143 @ExcludeTH
  #   Examples:
  #     | locale | langCode |
  #     | ro     | default  |

  #   # @tms:UUTR-10138 @ExcludeTH
  #   # Examples:
  #   #   | locale | langCode |
  #   #   | bg     | default  |

  #   @tms:UTR-10140
  #   Examples:
  #     | locale | langCode |
  #     | ie     | default  |

  #   @tms:UTR-10148
  #   Examples:
  #     | locale | langCode |
  #     | pt     | default  |

  #   # @tms:UTR-10150
  #   # Examples:
  #   #   | locale | langCode |
  #   #   | pl     | default  |

  #   @tms:UTR-10124
  #   Examples:
  #     | locale | langCode |
  #     | dk     | default  |

  #   # @tms:UTR-10121
  #   # Examples:
  #   #   | locale | langCode |
  #   #   | fi     | default  |

  #   @tms:UTR-10130
  #   Examples:
  #     | locale | langCode |
  #     | se     | default  |

  #   # @tms:UTR-10126
  #   # Examples:
  #   #   | locale | langCode |
  #   #   | es     | default  |

  #   @tms:UTR-10137 @ExcludeTH
  #   Examples:
  #     | locale | langCode |
  #     | it     | default  |

  #   # @tms:UTR-10260 @ExcludeTH @Mobile @ExcludeDB0
  #   # Examples:
  #   #   | locale | langCode |
  #   #   | de     | default  |

  #   @tms:UTR-10261 @Mobile
  #   Examples:
  #     | locale | langCode |
  #     | fr     | default  |

  #   @tms:UTR-10262 @Mobile
  #   Examples:
  #     | locale | langCode |
  #     | nl     | default  |

  #   @tms:UTR-10264
  #   Examples:
  #     | locale | langCode |
  #     | lu     | default  |

  #   @tms:UTR-10265 @Mobile
  #   Examples:
  #     | locale | langCode |
  #     | lu     | DE       |

  #   # @tms:UTR-13339
  #   # Examples:
  #   #   | locale | langCode |
  #   #   | at     | default  |