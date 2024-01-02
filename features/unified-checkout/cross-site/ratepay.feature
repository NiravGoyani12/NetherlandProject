Feature: Unified Checkout - Cross Site - Ratepay

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @Payment @Ratepay @HappyFlow
  Scenario Outline: As guest I can pay by payment on invoice (Ratepay)
    Given I am <userType> on locale <locale> of langCode <langCode> with <deliveryMethod> delivery method on the payment page
      And I store the cartId
      And I click on Checkout.PaymentPage.RatepayButton
      And I set attribute type of element Checkout.PaymentPage.BirthdayDayDate to "text"
      And I type to following inputs
      | element                               | value      |
      | Checkout.PaymentPage.PhoneNumberInput | 7865321321 |
      | Checkout.PaymentPage.BirthdayDayDate  | 09092000   |
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-187 @Mobile
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | de     | default  | guest    | standard       |

    @tms:UTR-14830
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | de     | EN       | logged in | standard       |

    @tms:UTR-66
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | at     | default  | guest    | standard       |

    @tms:UTR-203
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | ch     | default  | logged in | standard       |

    @tms:UTR-10444 @Mobile
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | ch     | FR       | guest    | standard       |

    @tms:UTR-10445
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | ch     | IT       | logged in | standard       |

  # @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @Payment @Ratepay @HappyFlow
  Scenario Outline: As user I can pay by payment on invoice (Ratepay)
    Given I am cross site user on locale <locale> of langCode <langCode> on the payment page
      And I store the cartId
      And I click on Checkout.PaymentPage.RatepayButton
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-253 @Mobile
    Examples:
      | locale | langCode |
      | de     | default  |

    @tms:UTR-162 @Mobile
    Examples:
      | locale | langCode |
      | at     | default  |

    # @tms:UTR-225
    # Examples:
    #   | locale | langCode |
    #   | ch     | default  |

    @tms:UTR-10447
    Examples:
      | locale | langCode |
      | ch     | IT       |

# @tms:UTR-10446
# Examples:
#   | locale | langCode |
#   | ch     | FR       |
