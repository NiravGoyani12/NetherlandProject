Feature: Unified Checkout - Payment Logos and Payment method positioning

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @PaymentPage @PaymentLogo
  Scenario Outline: Payment Logos - I can see the correct payment logos displayed in the footer on the payment page
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
      And I scroll to the element Checkout.PaymentPage.PaymentMethodLogos
    Then I see Checkout.PaymentPage.PaymentMethodLogos is in viewport
    Then I see Checkout.PaymentPage.PayPalLogo is <Paypal>
    Then I see Checkout.PaymentPage.VisaLogo is <Visa>
    Then I see Checkout.PaymentPage.iDealLogo is <iDeal>
    Then I see Checkout.PaymentPage.KlarnaLogo is <Klarna>
    Then I see Checkout.PaymentPage.MaestroLogo is <Maestro>
    Then I see Checkout.PaymentPage.MastercardLogo is <MasterCard>
    Then I see Checkout.PaymentPage.BcmcLogo is <Bcmc>
    Then I see Checkout.PaymentPage.P24Logo is <P24>
    Then I see Checkout.PaymentPage.DankortLogo is <Dankort>

    @tms:UTR-13401
    Examples:
      | locale | langCode | Paypal    | Visa      | iDeal     | Klarna    | Ratepay       | Maestro       | Bcmc          | P24           | MasterCard | Dankort       |
      | nl     | default  | displayed | displayed | displayed | displayed | not displayed | not displayed | not displayed | not displayed | displayed  | not displayed |

    @tms:UTR-13402
    Examples:
      | locale | langCode | Paypal    | Visa      | iDeal         | Klarna    | Ratepay   | Maestro       | Bcmc          | P24       | MasterCard | Dankort       |
      | pl     | default  | displayed | displayed | not displayed | displayed | displayed | not displayed | not displayed | displayed | displayed  | not displayed |

    @tms:UTR-13403
    Examples:
      | locale | langCode | Paypal    | Visa      | iDeal         | Klarna    | Ratepay       | Maestro   | Bcmc      | P24           | MasterCard | Dankort       |
      | be     | default  | displayed | displayed | not displayed | displayed | not displayed | displayed | displayed | not displayed | displayed  | not displayed |

    @tms:UTR-13404
    Examples:
      | locale | langCode | Paypal    | Visa      | iDeal         | Klarna    | Ratepay   | Maestro       | Bcmc          | P24           | MasterCard | Dankort       |
      | de     | default  | displayed | displayed | not displayed | displayed | displayed | not displayed | not displayed | not displayed | displayed  | not displayed |

    @tms:UTR-13405
    Examples:
      | locale | langCode | Paypal    | Visa      | iDeal         | Klarna    | Ratepay       | Maestro   | Bcmc          | P24           | MasterCard | Dankort       |
      | uk     | default  | displayed | displayed | not displayed | displayed | not displayed | displayed | not displayed | not displayed | displayed  | not displayed |

    @tms:UTR-13406
    Examples:
      | locale | langCode | Paypal    | Visa      | iDeal         | Klarna    | Ratepay       | Maestro       | Bcmc          | P24           | MasterCard | Dankort   |
      | dk     | default  | displayed | displayed | not displayed | displayed | not displayed | not displayed | not displayed | not displayed | displayed  | displayed |

  # @FullRegression
  # @Desktop
  # @Chrome @FireFox
  # @UnifiedCheckout @PaymentPage @PaymentMethod
  # Scenario Outline: Payment Methods - I can see the payment methods in the correct order on the payment page
  #   Given I am guest on locale <locale> of langCode <langCode> on the payment page
  #   Then I see Checkout.PaymentPage.PaymentMethodByIndex with index 1 contains text "<First>"
  #   Then I see Checkout.PaymentPage.PaymentMethodByIndex with index 2 contains text "<Second>"
  #   Then I see Checkout.PaymentPage.PaymentMethodByIndex with index 3 contains text "<Third>"
  #   Then I see Checkout.PaymentPage.PaymentMethodByIndex with index 4 contains text "<Fourth>"
  #   Then I see Checkout.PaymentPage.PaymentMethodByIndex with index 5 contains text "<Fifth>"

  #   @tms:UTR-13423
  #   Examples:
  #     | locale | langCode | First      | Second | Third  | Fourth | Fifth  |
  #     | be     | default  | Bancontact | Credit | Paypal | Klarna | ignore |

  #   @tms:UTR-13424
  #   Examples:
  #     | locale | langCode | First | Second | Third                    | Fourth | Fifth  |
  #     | nl     | default  | iDeal | Credit | achteraf betalen. klarna | Klarna | Paypal |

  #   @tms:UTR-13425
  #   Examples:
  #     | locale | langCode | First  | Second | Third  | Fourth | Fifth  |
  #     | uk     | default  | Credit | Klarna | Klarna | PayPal | ignore |

  #   @tms:UTR-13426
  #   Examples:
  #     | locale | langCode | First    | Second | Third  | Fourth | Fifth  |
  #     | pl     | default  | Przelewy | Karta  | Klarną | PayPal | ignore |

  #   @tms:UTR-13427
  #   Examples:
  #     | locale | langCode | First    | Second      | Third  | Fourth | Fifth  |
  #     | de     | default  | Rechnung | Kreditkarte | PayPal | Klarna | ignore |

  #   @tms:UTR-13428
  #   Examples:
  #     | locale | langCode | First    | Second      | Third  | Fourth | Fifth  |
  #     | ch     | default  | Rechnung | Kreditkarte | PayPal | Klarna | ignore |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @PaymentPage @PaymentMethod @ExcludeUat
  Scenario Outline: Payment Methods - I can see GC as payment method on the payment page
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
    Then I see Checkout.PaymentPage.PaymentMethodByIndex with index 1 contains text "<First>"
      And I see Checkout.PaymentPage.PaymentMethodByIndex with index 2 contains text "<Second>"
      And I see Checkout.PaymentPage.PaymentMethodByIndex with index 3 contains text "<Third>"
      And I see Checkout.PaymentPage.PaymentMethodByIndex with index 4 contains text "<Fourth>"
      And I see Checkout.PaymentPage.PaymentMethodByIndex with index 5 contains text "<Fifth>"
      And I see Checkout.PaymentPage.GiftCardButton is displayed

    Examples:
      | locale | langCode | First      | Second      | Third  | Fourth | Fifth         |
      | be     | default  | Bancontact | Credit      | Paypal | Klarna | ignore        |
      | pt     | default  | Credit     | PayPal      | ignore | ignore | ignore        |
      | de     | default  | Rechnung   | Kreditkarte | PayPal | Klarna | ignore        |
      | dk     | default  | credit     | Paypal      | Klarna | ignore | ignore        |
      | at     | default  | Rechnung   | Kreditkarte | PayPal | Klarna | geschenkkarte |
      | fi     | default  | Credit     | Klarna      | Paypal | ignore | ignore        |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @PaymentPage @PaymentMethod @ExcludeUat
  Scenario Outline: Payment Methods - I can see GC is not a payment method available on the payment page
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
    Then I see Checkout.PaymentPage.PaymentMethodByIndex with index 1 contains text "<First>"
      And I see Checkout.PaymentPage.PaymentMethodByIndex with index 2 contains text "<Second>"
      And I see Checkout.PaymentPage.PaymentMethodByIndex with index 3 contains text "<Third>"
      And I see Checkout.PaymentPage.PaymentMethodByIndex with index 4 contains text "<Fourth>"
      And I see Checkout.PaymentPage.GiftCardButton is not displayed

    Examples:
      | locale | langCode | First    | Second      | Third                               | Fourth |
      | nl     | default  | iDeal    | Credit      | achteraf                            | Klarna |
      | uk     | default  | Credit   | Klarna      | Klarna                              | PayPal |
      | pl     | default  | Przelewy | Karta       | Klarną                              | PayPal |
      | ch     | default  | Rechnung | Kreditkarte | PayPal                              | Klarna |
      | fr     | default  | Carte    | PayPal      | Acheter maintenant, payer plus tard | ignore |