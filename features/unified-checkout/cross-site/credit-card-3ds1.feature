Feature: Unified Checkout - Cross Site - Credit Card 3DS1

  #3DS1 cards are no longer supported
  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @CreditCard @3DS1
  Scenario Outline: Cross Site - As guest I can successfully place a 3DS1 order
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
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
    Then URL should contain "validate" within 15 seconds
    When with user "user" and password "password" I complete 3DS1 payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-7088
    Examples:
      | locale | card                | langCode |
      | uk     | 5212 3456 7890 1234 | default  |

    @tms:UTR-5171
    Examples:
      | locale | card                | langCode |
      | lt     | 4212 3456 7890 1237 | default  |

    @tms:UTR-5221
    Examples:
      | locale | card                | langCode |
      | ee     | 5212 3456 7890 1234 | default  |

    @tms:UTR-5222
    Examples:
      | locale | card                | langCode |
      | be     | 4212 3456 7890 1237 | default  |

    @tms:UTR-5223
    Examples:
      | locale | card                | langCode |
      | si     | 5212 3456 7890 1234 | default  |

    @tms:UTR-5224
    Examples:
      | locale | card                | langCode |
      | sk     | 4212 3456 7890 1237 | default  |

    @tms:UTR-5225
    Examples:
      | locale | card                | langCode |
      | cz     | 5212 3456 7890 1234 | default  |

    @tms:UTR-5226
    Examples:
      | locale | card                | langCode |
      | hu     | 4212 3456 7890 1237 | default  |

    @tms:UTR-5227
    Examples:
      | locale | card                | langCode |
      | hr     | 5212 3456 7890 1234 | default  |

    @tms:UTR-5228
    Examples:
      | locale | card                | langCode |
      | lv     | 4212 3456 7890 1237 | default  |

    @tms:UTR-5229 @ExcludeTH
    Examples:
      | locale | card                | langCode |
      | ro     | 5212 3456 7890 1234 | default  |

    @tms:UTR-5230 @ExcludeTH
    Examples:
      | locale | card                | langCode |
      | bg     | 4212 3456 7890 1237 | default  |

    @tms:UTR-5231
    Examples:
      | locale | card                | langCode |
      | ie     | 5212 3456 7890 1234 | default  |

    @tms:UTR-5232
    Examples:
      | locale | card                | langCode |
      | pt     | 4212 3456 7890 1237 | default  |

    @tms:UTR-5233
    Examples:
      | locale | card                | langCode |
      | pl     | 5212 3456 7890 1234 | default  |

    @tms:UTR-7089
    Examples:
      | locale | card                | langCode |
      | dk     | 4212 3456 7890 1237 | default  |

    @tms:UTR-7090
    Examples:
      | locale | card                | langCode |
      | fi     | 5212 3456 7890 1234 | default  |

    @tms:UTR-7091
    Examples:
      | locale | card                | langCode |
      | se     | 4212 3456 7890 1237 | default  |

    @tms:UTR-7092
    Examples:
      | locale | card                | langCode |
      | es     | 5212 3456 7890 1234 | default  |

    @tms:UTR-7093
    Examples:
      | locale | card                | langCode |
      | it     | 5212 3456 7890 1234 | default  |

    @tms:
    Examples:
      | locale | card                | langCode |
      | fr     | 4212 3456 7890 1237 | default  |

    @tms:
    Examples:
      | locale | card                | langCode |
      | de     | 4212 3456 7890 1237 | default  |

    @tms:
    Examples:
      | locale | card                | langCode |
      | nl     | 5212 3456 7890 1234 | default  |

    @tms:
    Examples:
      | locale | card                | langCode |
      | be     | 5212 3456 7890 1234 | FR       |

    @tms:
    Examples:
      | locale | card                | langCode |
      | ch     | 5212 3456 7890 1234 | FR       |

    @tms:
    Examples:
      | locale | card                | langCode |
      | lu     | 5212 3456 7890 1234 | DE       |

    @tms:
    Examples:
      | locale | card                | langCode |
      | be     | 5212 3456 7890 1234 | default  |

    @tms:
    Examples:
      | locale | card                | langCode |
      | ch     | 5212 3456 7890 1234 | default  |

    @tms:
    Examples:
      | locale | card                | langCode |
      | lu     | 5212 3456 7890 1234 | default  |

    @tms:
    Examples:
      | locale | card                | langCode |
      | ch     | 4212 3456 7890 1237 | IT       |


  #3DS1 cards are no longer supported
  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @CreditCard @3DS1 @P1
  Scenario Outline: Cross Site - As user I can successfully place a 3DS1 order
    Given I am cross site user on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
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
    Then URL should contain "validate" within 15 seconds
    When with user "user" and password "password" I complete 3DS1 payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-7094
    Examples:
      | locale | card                | langCode |
      | uk     | 4212 3456 7890 1237 | default  |

    @tms:UTR-5170
    Examples:
      | locale | card                | langCode |
      | ee     | 4212 3456 7890 1237 | default  |

    @tms:UTR-5234
    Examples:
      | locale | card                | langCode |
      | lt     | 5212 3456 7890 1234 | default  |

    @tms:UTR-5235
    Examples:
      | locale | card                | langCode |
      | si     | 4212 3456 7890 1237 | default  |

    @tms:UTR-5236
    Examples:
      | locale | card                | langCode |
      | be     | 5212 3456 7890 1234 | default  |

    @tms:UTR-5238
    Examples:
      | locale | card                | langCode |
      | cz     | 4212 3456 7890 1237 | default  |

    @tms:UTR-5237
    Examples:
      | locale | card                | langCode |
      | sk     | 5212 3456 7890 1234 | default  |

    @tms:UTR-5239
    Examples:
      | locale | card                | langCode |
      | hr     | 4212 3456 7890 1237 | default  |

    @tms:UTR-5240
    Examples:
      | locale | card                | langCode |
      | hu     | 5212 3456 7890 1234 | default  |

    @tms:UTR-5241 @ExcludeTH
    Examples:
      | locale | card                | langCode |
      | ro     | 4212 3456 7890 1237 | default  |

    @tms:UTR-5242 @ExcludeTH
    Examples:
      | locale | card                | langCode |
      | bg     | 5212 3456 7890 1234 | default  |

    @tms:UTR-5243
    Examples:
      | locale | card                | langCode |
      | lv     | 5212 3456 7890 1234 | default  |

    @tms:UTR-5244
    Examples:
      | locale | card                | langCode |
      | ie     | 4212 3456 7890 1237 | default  |

    @tms:UTR-5245
    Examples:
      | locale | card                | langCode |
      | pl     | 4212 3456 7890 1237 | default  |

    @tms:UTR-5246
    Examples:
      | locale | card                | langCode |
      | pt     | 5212 3456 7890 1234 | default  |

    @tms:UTR-7095
    Examples:
      | locale | card                | langCode |
      | dk     | 4212 3456 7890 1237 | default  |

    @tms:UTR-7096
    Examples:
      | locale | card                | langCode |
      | fi     | 5212 3456 7890 1234 | default  |

    @tms:UTR-7097
    Examples:
      | locale | card                | langCode |
      | se     | 4212 3456 7890 1237 | default  |

    @tms:UTR-7098
    Examples:
      | locale | card                | langCode |
      | es     | 5212 3456 7890 1234 | default  |

    @tms:UTR-7099 @ExcludeTH
    Examples:
      | locale | card                | langCode |
      | it     | 5212 3456 7890 1234 | default  |

    @tms:
    Examples:
      | locale | card                | langCode |
      | fr     | 4212 3456 7890 1237 | default  |

    @tms: @ExcludeTH
    Examples:
      | locale | card                | langCode |
      | de     | 4212 3456 7890 1237 | default  |

    @tms:
    Examples:
      | locale | card                | langCode |
      | nl     | 5212 3456 7890 1234 | default  |

    @tms:
    Examples:
      | locale | card                | langCode |
      | be     | 5212 3456 7890 1234 | FR       |

    @tms:
    Examples:
      | locale | card                | langCode |
      | ch     | 5212 3456 7890 1234 | FR       |

    @tms:
    Examples:
      | locale | card                | langCode |
      | ch     | 5212 3456 7890 1234 | IT       |

    @tms:
    Examples:
      | locale | card                | langCode |
      | lu     | 5212 3456 7890 1234 | DE       |

    @tms:
    Examples:
      | locale | card                | langCode |
      | ch     | 5212 3456 7890 1234 | default  |

    @tms:
    Examples:
      | locale | card                | langCode |
      | lu     | 5212 3456 7890 1234 | default  |
