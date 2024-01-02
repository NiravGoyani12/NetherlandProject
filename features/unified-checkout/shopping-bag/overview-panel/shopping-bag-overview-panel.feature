Feature: Unified Shopping Bag - Overview

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @ShoppingBag @OverviewPanel @UnifiedCheckout
  @feature:CET1-3307
  Scenario Outline: Shopping Bag Overview - Validate overview section of filled shopping bag is displayed
    Given I am on locale <locale> shopping bag page with 1 unit of any product with forced accepted cookies
      And I see Experience.Header.ShoppingBagCounter contains text "1"
      And I wait until the current page is loaded
    Then I see following elements are displayed
      | element                                         | args |
      | Experience.ShoppingBag.SubTotalPriceInfo        |      |
      | Experience.ShoppingBag.SubTotalPriceLabel       |      |
      | Experience.ShoppingBag.ShippingChargeAmount     |      |
      | Experience.ShoppingBag.ShippingChargeLabel      |      |
      | Experience.ShoppingBag.TotalPriceInfo           |      |
      | Experience.ShoppingBag.TotalPriceLabel          |      |
      | Experience.ShoppingBag.StartCheckoutButton      |      |
      | Experience.ShoppingBag.CheckoutWithPaypalButton |      |
      | Experience.ShoppingBag.PaymentMethodLogos       |      |
      | Experience.ShoppingBag.PayPalLogo               |      |
      | Experience.ShoppingBag.VisaLogo                 |      |
      | Experience.ShoppingBag.MastercardLogo           |      |

    @tms:UTR-5618 @P1
    Examples:
      | locale  |
      | default |

  @FullRegression
  @Mobile
  @Chrome @Safari @P1
  @ShoppingBag @OverviewPanel @UnifiedCheckout
  @feature:CET1-3307
  @tms:UTR-5619
  Scenario Outline: Shopping Bag Overview Mobile - Validate overview section of filled shopping bag is displayed
    Given I am on locale default shopping bag page of langCode default with 1 unit of any product with forced accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter contains text "1"
      And I wait until the current page is loaded
    Then I see following elements are displayed
      | element                                              | args |
      | Experience.ShoppingBag.SubTotalPriceInfo             |      |
      | Experience.ShoppingBag.SubTotalPriceLabel            |      |
      | Experience.ShoppingBag.ShippingChargeAmount          |      |
      | Experience.ShoppingBag.ShippingChargeLabel           |      |
      | Experience.ShoppingBag.TotalPriceInfo                |      |
      | Experience.ShoppingBag.TotalPriceLabel               |      |
      | Experience.ShoppingBag.MobileTotalPriceInfo          |      |
      | Experience.ShoppingBag.MobileTotalPriceLabel         |      |
      | Experience.ShoppingBag.StartCheckoutButton           |      |
      | Experience.ShoppingBag.CheckoutWithPaypalButton      |      |
      | Experience.ShoppingBag.MobileSecondaryCheckoutButton |      |
      | Experience.ShoppingBag.MobileSecondaryPaypalButton   |      |
      | Experience.ShoppingBag.PaymentMethodLogos            |      |
      | Experience.ShoppingBag.PayPalLogo                    |      |
      | Experience.ShoppingBag.VisaLogo                      |      |
      | Experience.ShoppingBag.MastercardLogo                |      |
      | Experience.ShoppingBag.AmericanExpressLogo           |      |

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Safari
  @ShoppingBag @OverviewPanel @UnifiedCheckout @P2
  @feature:EESCK-11630
  Scenario Outline: Shopping Bag Overview  - Validate USP in the overview section of filled shopping bag is displayed
    Given I am guest on locale <locale> of langCode <langCode> with 1 products with value <limit> shipping threshold on shopping bag page
      And I wait until the current page is loaded
    When I see Experience.ShoppingBag.OverviewSection is displayed
    Then I see the count of displayed elements Experience.ShoppingBag.ShoppingBagUSP is greater than 1
    When I click on Experience.ShoppingBag.ShoppingBagUSP by js with index 1

    @tms:UTR-14775
    Examples:
      | locale  | langCode | limit |
      | default | default  | below |

    @tms:UTR-14776
    Examples:
      | locale           | langCode         | limit |
      | multiLangDefault | multiLangDefault | above |