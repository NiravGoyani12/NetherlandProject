Feature: Unified PDP - Product Name and Price

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ProductName @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-5111
  Scenario Outline: Product Name - I see product name is displayed correctly
    Given There is 1 any product item of locale <locale> and langCode <langCode> with inventory between 10 and 999 filtered by FH
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I extract product style detail by style colour part number product1#styleColourPartNumber
    Then in unified PDP I see product name is matched to product style colour part number product1#styleColourPartNumber

    @P1
    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ProductPrices @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-5112
  Scenario Outline: Product Price - I see correct product price info when add same price product without discount
    Given There is 1 product style with same current price of locale <locale> and langCode <langCode> filtered by FH
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I extract product style detail by style colour part number product1#styleColourPartNumber
    Then in unified PDP I see product info is matched to product style by style colour number product1#styleColourPartNumber

    @P1
    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ProductPrices @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-5122
  Scenario Outline: Product Price - I see correct product price info when add same price product with discount
    Given There is 1 discounted product style with same current price of locale <locale> and langCode <langCode> filtered by FH
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I extract product style detail by style colour part number product1#styleColourPartNumber
    Then in unified PDP I see product info is matched to product style by style colour number product1#styleColourPartNumber

    @P1
    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ProductPrices @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-5113
  Scenario Outline: Product Price - I see correct product price info when add different price product without discount
    Given There is 1 product style with different current price of locale <locale> and langCode <langCode> filtered by FH
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I extract product style detail by style colour part number product1#styleColourPartNumber
    Then in unified PDP I see product info is matched to product style by style colour number product1#styleColourPartNumber

    @P1
    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ProductPrices @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-5123
  Scenario Outline: Product Price format - Validate product price format on PDP when switching the color
    Given There is 1 multi colour product with at least 2 colours of locale <locale> and langCode <langCode> with inventory between 10 and 99999 filtered by FH
      And I extract product style from product product1#stylePartNumber with index 0 saved as #styleColourPartNumber
      And I get price format for current locale and store it with key #priceFormat
    When I am on locale <locale> pdp page for product style #styleColourPartNumber with forced accepted cookies
    Then I wait until the current page is loaded
      And the value of ProductDetailPage.Pdp.CurrentPrice should match regex pattern "#priceFormat"
    When I click on ProductDetailPage.Pdp.ColorSwatchButton with index 2
    Then the value of ProductDetailPage.Pdp.CurrentPrice should match regex pattern "#priceFormat"

    @P1
    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PriorPrice @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13430
  Scenario Outline: Product Prior Price - Verify the discounted product shows the prior price message next to the product price
    Given There are 2 discounted product style with same current price of locale <locale> and langCode <langCode>
    When I am on locale <locale> pdp page for product style product2#styleColourPartNumber with forced accepted cookies
      And I extract product style detail by style colour part number product2#styleColourPartNumber
      And I extract xcomreg PRIOR_PRICE_ENABLE_TOGGLE saved as #PriorPriceToggle
    Then I see the stored value with key #PriorPriceToggle is equal to "true"
      And I get translation from lokalise for "LowestPrice" and store it with key #LowestPrice
    Then I see ProductDetailPage.Pdp.PriorPriceMessage with text #LowestPrice is displayed

    Examples:
      | locale | langCode |
      | be     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ProductPrices @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-17483
  Scenario Outline: Product Price - Verify only kids has From price prefix for markdown products
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type Price
      And I set the checkbox Experience.PlpFilters.OnSalePriceFilter status to true
      And I click on Experience.PlpProducts.ProductGridItems with index 1 until ProductDetailPage.Pdp.Content is displayed
    Then I see ProductDetailPage.Pdp.PricePrefixFrom is <status>

    @ExcludeCK
    Examples:
      | locale  | langCode | categoryId        | status        |
      | default | default  | th_women_clothing | not displayed |
      | default | default  | th_men_clothing   | not displayed |

    @ExcludeTH
    Examples:
      | locale  | langCode | categoryId                 | status        |
      | default | default  | women_clothes_t-shirts     | not displayed |
      | default | default  | men_clothes_t-shirts       | not displayed |
      # | be      | default  | kids_boys_clothes_t-shirts | displayed     |
