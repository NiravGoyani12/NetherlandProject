Feature: Unified Checkout - Cross Site - Klarna

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @Payment @Klarna @HappyFlow
  Scenario Outline: Cross Site - Klarna - As guest I can place order with Klarna
    Given I am <userType> on locale <locale> of langCode default with <deliveryMethod> delivery method on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.Klarna is clickable
      And I click on Checkout.PaymentPage.Klarna
      And I wait for 1 seconds
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 10 seconds
      And in klarna I complete payment for scenario Positive
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10202
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | be     | default  | guest    | express        |

    @tms:UTR-10308 @Mobile
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | be     | FR       | logged in | express        |

    @tms:UTR-10208
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | pl     | default  | guest    | standard       |

    @tms:UTR-10199 @Mobile
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | uk     | default  | logged in | standard       |

    @tms:UTR-10205
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | dk     | default  | guest    | express        |

    @tms:UTR-10201
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | fi     | default  | logged in | standard       |

    @tms:UTR-10203
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | se     | default  | guest    | express        |

    @tms:UTR-13414
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | at     | default  | guest    | standard       |

    @tms:UTR-13413
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | de     | default  | logged in | standard       |

    @tms:UTR-13415
    Examples:
      | locale | langCode | userType | deliveryMethod |
      | ch     | default  | guest    | standard       |

    @tms:UTR-14826
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | de     | EN       | logged in | standard       |

 @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @Payment @Klarna @HappyFlow
  Scenario Outline: Cross Site - Klarna - As guest I can place order with Klarna
    Given I am <userType> on locale <locale> of langCode default with <deliveryMethod> delivery method on the payment page
      And I store the cartId
      And I wait until Checkout.PaymentPage.Klarna is clickable
      And I click on Checkout.PaymentPage.Klarna
      And I wait for 1 seconds
      And I see Checkout.PaymentPage.TermsAndConditionsCheckbox is not displayed
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 10 seconds
      And in klarna I complete payment for scenario Positive
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

  @tms:UTR-10307 @Mobile
    Examples:
      | locale | langCode | userType  | deliveryMethod |
      | nl     | default  | logged in | express        |     

  # @FullRegression
  # @Desktop
  # @Chrome @FireFox @Safari
  # @UnifiedCheckout @CrossSitePayment @Payment @Klarna @HappyFlow
  # Scenario Outline: Cross Site - Klarna - As user I can place order with Klarna
  #   Given I am cross site user on locale <locale> of langCode <langCode> on the payment page
  #     And I store the cartId
  #     And I wait until Checkout.PaymentPage.Klarna is clickable
  #     And I click on Checkout.PaymentPage.Klarna
  #     And I wait for 1 seconds
  #     And I set T&C checkbox to true if XCOMREG is enabled
  #     And I click on Checkout.PaymentPage.PlaceOrderButton
  #     And I wait for 10 seconds
  #     And in klarna I complete payment for scenario Positive
  #   Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

  #   # @tms:UTR-10207
  #   # Examples:
  #   #   | locale | langCode |
  #   #   | be     | default  |

  #   @tms:UTR-10305 @Mobile
  #   Examples:
  #     | locale | langCode |
  #     | be     | FR       |

  #   @tms:UTR-10206 @Mobile
  #   Examples:
  #     | locale | langCode |
  #     | pl     | default  |

  #   @tms:UTR-10204
  #   Examples:
  #     | locale | langCode |
  #     | uk     | default  |

  #   @tms:UTR-10198
  #   Examples:
  #     | locale | langCode |
  #     | dk     | default  |

  #   @tms:UTR-10200
  #   Examples:
  #     | locale | langCode |
  #     | fi     | default  |

  #   @tms:UTR-10209
  #   Examples:
  #     | locale | langCode |
  #     | se     | default  |

  #   @tms:UTR-10306 @Mobile
  #   Examples:
  #     | locale | langCode |
  #     | nl     | default  |