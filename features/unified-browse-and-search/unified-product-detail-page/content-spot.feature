Feature: Unified PDP - Content spot

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @CurveContentSpot @P2
  @tms:UTR-13407  @ExcludeCK
  Scenario Outline: Curve content spot - Verify clicking on the plus size link on the PDP re-directs to plus-size product PDP
    When I am on locale <locale> PDP with plus-size linking of langCode <langCode> for identifier key <identifierKey> with forced accepted cookies
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.ContentSpotPlusSizeLink is displayed
    When I click on ProductDetailPage.Pdp.ContentSpotPlusSizeLink
      And I wait until the current page is loaded
    Then URL should contain "#additionalSizeUrl"
      And I see ProductDetailPage.Pdp.ProductLabel with text <ProductLabelText> is displayed

    Examples:
      | locale | langCode | identifierKey | ProductLabelText |
      | uk     | default  | DM0DM16835BDS | PLUS SIZE        |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @CurveContentSpot @P2
  @tms:UTR-13407 @ExcludeTH
  Scenario Outline: Curve content spot - Verify clicking on the plus size link on the PDP re-directs to plus-size product PDP
    When I am on locale <locale> PDP with plus-size linking of langCode <langCode> for identifier key <identifierKey> with forced accepted cookies
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.ContentSpotPlusSizeLink is displayed
    When I click on ProductDetailPage.Pdp.ContentSpotPlusSizeLink
      And I wait until the current page is loaded
    Then URL should contain "#additionalSizeUrl"
      And I see ProductDetailPage.Pdp.ProductLabel with text <ProductLabelText> is displayed

    Examples:
      | locale | langCode | identifierKey | ProductLabelText |
      | uk     | default  | 0000F3786E100 | PLUS SIZE        |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @CurveContentSpot @P2
  @tms:UTR-13408 @ExcludeCK
  Scenario Outline: Curve content spot - Verify clicking on the plus size link on plus-size PDP re-directs to the correct PDP
    When I am on locale <locale> plus-sized PDP of langCode <langCode> for identifier key <identifierKey> with forced accepted cookies
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.ContentSpotPlusSizeLink is displayed
      And I see ProductDetailPage.Pdp.ProductLabel with text <ProductLabelText> is displayed
    When I click on ProductDetailPage.Pdp.ContentSpotPlusSizeLink
      And I wait until the current page is loaded
    Then URL should contain "#regularSizeUrl"
      And I see ProductDetailPage.Pdp.ProductLabel with text <ProductLabelText> is not displayed

    Examples:
      | locale | langCode | identifierKey | ProductLabelText |
      | uk     | default  | DM0DM16835BDS | PLUS SIZE        |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @CurveContentSpot @P2
  @tms:UTR-13408 @ExcludeTH
  Scenario Outline: Curve content spot - Verify clicking on the plus size link on plus-size PDP re-directs to the correct PDP
    When I am on locale <locale> plus-sized PDP of langCode <langCode> for identifier key <identifierKey> with forced accepted cookies
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.ContentSpotPlusSizeLink is displayed
      And I see ProductDetailPage.Pdp.ProductLabel with text <ProductLabelText> is displayed
    When I click on ProductDetailPage.Pdp.ContentSpotPlusSizeLink
      And I wait until the current page is loaded
    Then URL should contain "#regularSizeUrl"
      And I see ProductDetailPage.Pdp.ProductLabel with text <ProductLabelText> is not displayed

    Examples:
      | locale | langCode | identifierKey | ProductLabelText |
      | uk     | default  | 0000F3786E100 | PLUS SIZE        |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @ShoppingBagContentSpot @P2
  @tms:UTR-13410
  Scenario Outline: USP content spot - Verify USP content spot is displayed on PDP
    Given There are 5 normal size product style of locale <locale> with inventory between 10 and 9999
      And I am on locale <locale> pdp page for product style product3#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
    When I save current url as key #PdpUrl
    Then I see ProductDetailPage.Pdp.UspContentSpot is displayed
      And I see ProductDetailPage.Pdp.UspContentSpotLink is displayed
    When I click on ProductDetailPage.Pdp.UspContentSpotLink
    Then URL should not contain "#PdpUrl"

    Examples:
      | locale | langCode |
      | uk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PDP @TEE @UnifiedPdp @UnifiedExperience @PromoCodeContentSpot @P3
  @tms:UTR-13441
  Scenario Outline: Promocode content spot - Verify promocode content spot is displayed on PDP and the promocode can be copied
    Given I am on locale <locale> pdp page of langCode <langCode> for product style MW0MW22197DW5/J30J3227921BY with accepted cookies
      And I wait until the current page is loaded
      And I get translation from lokalise for "CopyText" and store it with key #copy
      And I get translation from lokalise for "Copied" and store it with key #copied
      And I get translation from lokalise for "CopiedToClipboard" and store it with key #copiedToClipboard
    Then I see ProductDetailPage.Pdp.PromoCodeContentSpot is displayed
      And I see ProductDetailPage.Pdp.PromoCodeCopyButton with text #copy is displayed
      And I see ProductDetailPage.Pdp.PromoCode is displayed
    When I click on ProductDetailPage.Pdp.PromoCode
    Then I see ProductDetailPage.Pdp.PromoCodeCopyButton with text #copied is displayed
      And I see ProductDetailPage.Pdp.CopySuccessNotification with text #copiedToClipboard is displayed

    Examples:
      | locale | langCode |
      | nl     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @FHCampaign @P3
  @tms:UTR-13442 @ExcludeCK
  Scenario Outline: FH Campaign content spot- I should see a fredhopper campaign usp message with/without a link below add to bag CTA
    Given I am on locale <locale> pdp page of langCode <langCode> for product style <styleColourPartNumber> with accepted cookies
    When I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.FhCampaign is displayed
      And I see ProductDetailPage.Pdp.FhCampaignLink is <linkStatus>

    Examples:
      | locale  | langCode | styleColourPartNumber | linkStatus    |
      | default | default  | KS0KS00309C87         | displayed     |
      | default | default  | FW0FW07407ZGS         | not displayed |