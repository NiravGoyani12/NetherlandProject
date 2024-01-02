Feature: Unified Checkout - Cross Site - PayPal Express

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @Payment @PayPalExpress @HappyFlow
  Scenario Outline: Cross Site - As guest I can pay by PayPalExpress from shipping page
    Given I am on locale <locale> of langCode <langCode> with 1 products on shipping page
      And I store the cartId
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.SignInPage.PaypalExpressButton is clickable
    When I click on Checkout.SignInPage.PaypalExpressButton
      And I wait until Checkout.SignInPage.PaypalExpressTermsModal is displayed
      And I set the checkbox Checkout.SignInPage.PaypalExpressTermsCheckbox status to true
      And I click on Checkout.SignInPage.PayWithPaypalExpressButton
      And in paypal I complete payment
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @tms:UTR-10195 @issue:EESCK-11546
    Examples:
      | locale | langCode |
      | cz     | default  |

    # @tms:UTR-10192
    # Examples:
    #   | locale | langCode |
    #   | lv     | default  |

    # @tms:UTR-10193
    # Examples:
    #   | locale | langCode |
    #   | lt     | default  |

    # @tms:UTR-10190
    # Examples:
    #   | locale | langCode |
    #   | si     | default  |

    # @tms:UTR-10196 @issue:EESCK-11546
    # Examples:
    #   | locale | langCode |
    #   | sk     | default  |

    # @tms:UTR-10186
    # Examples:
    #   | locale | langCode |
    #   | ee     | default  |

    # @tms:UTR-10197 @issue:EESCK-11546
    # Examples:
    #   | locale | langCode |
    #   | hu     | default  |

    # @tms:UTR-10194
    # Examples:
    #   | locale | langCode |
    #   | hr     | default  |

    # @tms:UTR-10184 @ExcludeTH
    # Examples:
    #   | locale | langCode |
    #   | ro     | default  |

    # @tms:UTR-10185 @ExcludeTH
    # Examples:
    #   | locale | langCode |
    #   | bg     | default  |

    @tms:UTR-10187
    Examples:
      | locale | langCode |
      | ie     | default  |

    @tms:UTR-10188
    Examples:
      | locale | langCode |
      | pt     | default  |

    @tms:UTR-10191
    Examples:
      | locale | langCode |
      | pl     | default  |

    @tms:UTR-10294 @Mobile
    Examples:
      | locale | langCode |
      | it     | default  |

    @tms:UTR-10295 @issue:EESCK-11546
    Examples:
      | locale | langCode |
      | es     | default  |

    @tms:UTR-10296
    Examples:
      | locale | langCode |
      | fr     | default  |

    @tms:UTR-10302
    Examples:
      | locale | langCode |
      | ch     | default  |

    @tms:UTR-10300
    Examples:
      | locale | langCode |
      | ch     | FR       |

    @tms:UTR-10301 @Mobile
    Examples:
      | locale | langCode |
      | ch     | IT       |

    @tms:UTR-13342 @issue:EESCK-11546
    Examples:
      | locale | langCode |
      | at     | default  |

    @tms:UTR-10303
    Examples:
      | locale | langCode |
      | lu     | default  |

    @tms:UTR-10304
    Examples:
      | locale | langCode |
      | lu     | DE       |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @Payment @PayPalExpress @HappyFlow
  Scenario Outline: Cross Site - As guest I can pay by PayPalExpress from shipping page with modal T&C
    Given I am on locale <locale> of langCode <langCode> with 1 products on shipping page
      And I store the cartId
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.SignInPage.PaypalExpressButton is clickable
      And I click on Checkout.SignInPage.PaypalExpressButton
      And in paypal I complete payment
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @tms:UTR-10183 @Mobile
    Examples:
      | locale | langCode |
      | uk     | default  |

    @tms:UTR-10297 @Mobile
    Examples:
      | locale | langCode |
      | de     | default  |

    @tms:UTR-14827
    Examples:
      | locale | langCode |
      | de     | EN       |

    @tms:UTR-10298
    Examples:
      | locale | langCode |
      | nl     | default  |

    @tms:UTR-10299 @Mobile
    Examples:
      | locale | langCode |
      | be     | FR       |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedCheckout @CrossSitePayment @ShoppingBagPage @Payment @PayPalExpress @issue:EESCK-11546
  Scenario Outline: Cross Site - As guest I can pay by PayPalExpress from shopping bag page
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 2 unit of any product with forced accepted cookies
      And I select paypal express and get to paypal login
      And in paypal I complete payment for locale <locale>
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @tms:UTR-13090
    Examples:
      | locale | langCode |
      | cz     | default  |

    # @tms:UTR-13091
    # Examples:
    #   | locale | langCode |
    #   | lv     | default  |

    # @tms:UTR-13092
    # Examples:
    #   | locale | langCode |
    #   | lt     | default  |

    # @tms:UTR-13093
    # Examples:
    #   | locale | langCode |
    #   | si     | default  |

    # @tms:UTR-13094 @issue:EESCK-11546
    # Examples:
    #   | locale | langCode |
    #   | sk     | default  |

    # @tms:UTR-13095
    # Examples:
    #   | locale | langCode |
    #   | ee     | default  |

    # @tms:UTR-13096 @issue:EESCK-11546
    # Examples:
    #   | locale | langCode |
    #   | hu     | default  |

    # @tms:UTR-13097
    # Examples:
    #   | locale | langCode |
    #   | hr     | default  |

    # @tms:UTR-13098 @ExcludeTH
    # Examples:
    #   | locale | langCode |
    #   | ro     | default  |

    # @tms:UTR-13099 @ExcludeTH
    # Examples:
    #   | locale | langCode |
    #   | bg     | default  |

    @tms:UTR-13100
    Examples:
      | locale | langCode |
      | ie     | default  |

    @tms:UTR-13101
    Examples:
      | locale | langCode |
      | pt     | default  |

    @tms:UTR-13102
    Examples:
      | locale | langCode |
      | pl     | default  |

    @tms:UTR-13103
    Examples:
      | locale | langCode |
      | it     | default  |

    @tms:UTR-13104 @issue:EESCK-11546
    Examples:
      | locale | langCode |
      | es     | default  |

    @tms:UTR-13105 @P2
    Examples:
      | locale | langCode |
      | fr     | default  |

    @tms:UTR-13106
    Examples:
      | locale | langCode |
      | ch     | default  |

    @tms:UTR-13107
    Examples:
      | locale | langCode |
      | lu     | default  |

    @tms:UTR-13108 @Mobile
    Examples:
      | locale | langCode |
      | uk     | default  |

    @tms:UTR-13109 @Mobile
    Examples:
      | locale | langCode |
      | de     | default  |

    @tms:UTR-13111 @Mobile
    Examples:
      | locale | langCode |
      | nl     | default  |

    @tms:UTR-13110
    Examples:
      | locale | langCode |
      | be     | FR       |

    @tms:UTR-13343 @issue:EESCK-11546
    Examples:
      | locale | langCode |
      | at     | default  |

    @tms:UTR-14828
    Examples:
      | locale | langCode |
      | de     | EN       |

  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @PaymentPage @GiftCard @iDeal @HappyFlow
  Scenario: Paypal - As a guest/user I can purchase regular item and a giftcard using Paypal Express payment
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 40 and 100 and inventory between 200 and 9999
      And I am on locale <locale> shopping bag page of langCode <langCode> with 2 units for product items product1#skuPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I navigate to page gift-cards
      And I wait until the current page is loaded
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagCounter
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I store the cartId
      And I expect at least 1 network request named custom_usable_shipping_info of type fetch to be processed in 10 seconds
      And I wait until Checkout.SignInPage.PaypalExpressButton is clickable
    When I click on Checkout.SignInPage.PaypalExpressButton
      And I wait until Checkout.SignInPage.PaypalExpressTermsModal is displayed
      And I set the checkbox Checkout.SignInPage.PaypalExpressTermsCheckbox status to true
      And I click on Checkout.SignInPage.PayWithPaypalExpressButton
      And in paypal I complete payment
      And I switch to 1st browser tab
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds

    @tms:UTR-17254 @Mobile
    Examples:
      | locale | langCode |
      | at     | default  |

# @ExcludeTH @tms:UTR-17255 //TBD
# Examples:
#   | locale | langCode |
#   | at     | default  |
