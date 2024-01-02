Feature: Unified Checkout - Cross Site - Klarna Pay Over time

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @KlarnaInstalments @HappyFlow
  Scenario Outline: Cross Site - Klarna Pay Overtime - As guest I can place order with Klarna pay in instalments
    Given I am <userType> on locale <locale> of langCode default with <deliveryMethod> delivery method on the payment page
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is clickable in 10 seconds
      And I store the cartId
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait until Checkout.PaymentPage.TermsAndConditionsCheckbox is displayed
      And I set T&C checkbox to true if XCOMREG is enabled
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 10 seconds
      And in klarna I complete payment for scenario Instalments
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10216
    Examples:
      | locale | userType  | deliveryMethod |
      | ie     | logged in | express        |

    @tms:UTR-10213 @Mobile
    Examples:
      | locale | userType | deliveryMethod |
      | uk     | guest    | standard       |

    @tms:UTR-10214
    Examples:
      | locale | userType  | deliveryMethod |
      | it     | logged in | express        |

    @tms:UTR-10211
    Examples:
      | locale | userType | deliveryMethod |
      | es     | guest    | standard       |

    @tms:UTR-xxxx 
    Examples:
      | locale | userType | deliveryMethod |
      | cz     | guest    | standard       |

    @tms:UTR-xxxx @ExcludeTH
    Examples:
      | locale | userType | deliveryMethod |
      | ro     | guest    | standard       |

    @tms:UTR-10311 @Mobile 
    Examples:
      | locale | userType  | deliveryMethod |
      | fr     | logged in | express        |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @KlarnaInstalments @HappyFlow
  Scenario Outline: Cross Site - Klarna Pay Overtime - As guest I can place order with Klarna pay in instalments on nl locale
    Given I am <userType> on locale <locale> of langCode default with <deliveryMethod> delivery method on the payment page
      And I wait until Checkout.PaymentPage.KlarnaPayInstallments is clickable in 10 seconds
      And I store the cartId
      And I click on Checkout.PaymentPage.KlarnaPayInstallments
      And I wait until Checkout.PaymentPage.TermsAndConditionsCheckbox is not displayed
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 10 seconds
      And in klarna I complete payment for scenario Instalments
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

    @tms:UTR-10312 @Mobile
    Examples:
      | locale | userType | deliveryMethod |
      | nl     | guest    | standard       |

# # @FullRegression
# @Desktop
# @Chrome @FireFox @Safari
# @UnifiedCheckout @CrossSitePayment @PaymentPage @Payment @KlarnaInstalments @HappyFlow
# Scenario Outline: Cross Site - Klarna Pay Overtime - As user I can place order with Klarna pay in instalments
#   Given I am cross site user on locale <locale> of langCode default on the payment page
#     And I store the cartId
#     And I wait until Checkout.PaymentPage.KlarnaPayInstallments is clickable
#     And I click on Checkout.PaymentPage.KlarnaPayInstallments
#     And I wait for 1 seconds
#     And I set T&C checkbox to true if XCOMREG is enabled
#     And I click on Checkout.PaymentPage.PlaceOrderButton
#     And I wait for 10 seconds
#     And in klarna I complete payment for scenario Instalments
#   Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 20 seconds

#   @tms:UTR-10215
#   Examples:
#     | locale |
#     | ie     |

#   @tms:UTR-10217 @Mobile
#   Examples:
#     | locale |
#     | uk     |

#   @tms:UTR-10212
#   Examples:
#     | locale |
#     | it     |

#   @tms:UTR-10210 @Mobile
#   Examples:
#     | locale |
#     | es     |

#   @tms:UTR-10309
#   Examples:
#     | locale |
#     | fr     |

#   @tms:UTR-10310 @Mobile
#   Examples:
#     | locale |
#     | nl     |