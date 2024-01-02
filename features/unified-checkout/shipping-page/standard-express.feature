Feature: Unified Checkout - Shipping Page - Delivery methods

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @DeliveryMethods @P3
  Scenario Outline: Standard delivery is always selected by default
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 products with value <limit> shipping threshold on shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is displayed
      And I get translation from lokalise for "StandardDelivery" and store it with key #DeliveryText
      And I get translation from lokalise for "FreeCosts" and store it with key #FreeShipping
      And I get standard shipping costs for current locale and store it with key #ShippingCosts
    Then I see Checkout.ShippingPage.StandardRadioButton contains text "#DeliveryText"
      And I see Checkout.OverviewPanel.ShippingMethod contains text "#DeliveryText"
      And I see Checkout.OverviewPanel.ShippingPrice contains text "<costs>"

    @tms:UTR-11255 @Mobile
    Examples:
      | locale  | langCode | userType | limit | costs          |
      | default | default  | guest    | below | #ShippingCosts |

    # @tms:UTR-11258
    # Examples:
    #   | locale  | langCode | userType  | limit | costs         |
    #   | default | default  | logged in | above | #FreeShipping |

    # @tms:UTR-11256 @Mobile
    # Examples:
    #   | locale           | langCode         | userType | limit | costs          |
    #   | multiLangDefault | multiLangDefault | guest    | below | #ShippingCosts |

    @tms:UTR-11257
    Examples:
      | locale           | langCode         | userType  | limit | costs         |
      | multiLangDefault | multiLangDefault | logged in | above | #FreeShipping |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @DeliveryMethods @ShippingPage @P2
  Scenario Outline: User can swap between Standard and Express shipping methods
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 products with value below shipping threshold on shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is displayed
      And as a <userType> I add first delivery details
      And I get express shipping costs for current locale and store it with key #shippingCosts
      And I click on Checkout.ShippingPage.ExpressRadioButton
    Then I see Checkout.OverviewPanel.ShippingPrice contains text "#shippingCosts"
      And as a <userType> I add first delivery details
    When I click on Checkout.ShippingPage.ProceedToPayment
      And I wait until Checkout.PaymentPage.CreditCardButton is clickable
    Then I check that my delivery details have been saved

    @tms:UTR-11262 @Mobile
    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |

    # @tms:UTR-11259
    # Examples:
    #   | locale | langCode | userType  |
    #   | es     | default  | logged in |

    @tms:UTR-11261
    Examples:
      | locale | langCode | userType |
      | lu     | DE       | guest    |

    @tms:UTR-11260 @Mobile
    Examples:
      | locale | langCode | userType  |
      | be     | FR       | logged in |
