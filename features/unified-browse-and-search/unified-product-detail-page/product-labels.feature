Feature: Unified PDP - Product labels

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @ProductLabels @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-11765
  Scenario Outline: Promotion labels - I see products with correct promotion labels on the image tile
    Given There are 2 product style with Promotion type <PromotionType> of locale <locale> and langCode <langCode> with inventory between 1 and 999999
    When I am on locale <locale> pdp page of langCode default for product style product2#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.ProductLabel is displayed
      And I see ProductDetailPage.Pdp.ProductLabel with text <PromotionTypeText> is displayed

    Examples:
      | locale  | langCode | PromotionType | PromotionTypeText |
      | default | default  | EXCLUSIVE     | EXCLUSIVE         |

    @ExcludeCK
    Examples:
      | locale | langCode | PromotionType | PromotionTypeText |
      | ch     | default  | NEW           | NEU               |
      | de     | EN       | CURVE         | CURVE             |
      | ee     | default  | PLUS SIZE     | PLUS SIZE         |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari
  @ProductLabels @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-14558
  Scenario Outline: Product labels - I see the labels are displayed on every carousel image on mobiles
    Given There are 2 product style with Promotion type <PromotionType> of locale <locale> and langCode <langCode> with inventory between 1 and 999999
    When I am on locale <locale> pdp page of langCode default for product style product2#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
      And I see ProductDetailPage.Pdp.ProductLabel with text <PromotionType> is displayed
      And I store the number of elements ProductDetailPage.Pdp.ProductImages with key #ProductImagesCount
    Then the count of displayed elements ProductDetailPage.Pdp.ProductLabel is equal to #ProductImagesCount

    Examples:
      | locale  | langCode | PromotionType | PromotionTypeText |
      | default | default  | EXCLUSIVE     | EXCLUSIVE         |

    @ExcludeCK
    Examples:
      | locale | langCode | PromotionType | PromotionTypeText |
      | ch     | default  | NEW           | NEU               |
      | de     | EN       | CURVE         | CURVE             |
      | ee     | default  | PLUS SIZE     | PLUS SIZE         |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ProductLabels @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-11766
  Scenario Outline: MarkdownPercentage label - I see markdown percentage label on the image tile of products with discount
    Given There is 1 discounted product style with same current price of locale <locale>
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I extract product style detail by style colour part number product1#styleColourPartNumber
    Then I see ProductDetailPage.Pdp.MarkDownPercentageLabel is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @ProductLabels @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-11767
  Scenario Outline: Soldout label - I see soldout label on the image tile of OOS product
    Given There is 1 normal size product style of locale <locale> with inventory between 0 and 0
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
      And I get translation from lokalise for "SoldOutText" and store it with key #<SoldOut>
    Then I see ProductDetailPage.Pdp.ProductLabel is displayed
      And I see ProductDetailPage.Pdp.ProductLabel with text #<SoldOut> is displayed

    Examples:
      | locale  |
      | default |