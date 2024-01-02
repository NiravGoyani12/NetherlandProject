Feature: Unified PDP - Product Content and Elements

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @Accordion @P2
  @tms:UTR-5116
  Scenario Outline: PDP accordian - I should see details section is open by default and shipping section is closed
    Given There is 1 normal size product style of locale <locale> with inventory between 10 and 99999 filtered by FH
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
    Then I see ProductDetailPage.Pdp.ExpandedProductDetailsSection is displayed
      And I see ProductDetailPage.Pdp.ClosedProductShippingAndReturnsSection is displayed
    When I scroll to and click on ProductDetailPage.Pdp.ExpandedProductDetailsSection
    Then I see ProductDetailPage.Pdp.ClosedProductDetailsSection is displayed
    When I scroll to and click on ProductDetailPage.Pdp.ClosedProductShippingAndReturnsSection
    Then I see ProductDetailPage.Pdp.ExpandedProductShippingAndReturnsSection is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PDP @TEE @UnifiedPdp @UnifiedExperience @Accordion @P2
  @tms:UTR-5115
  Scenario Outline: PDP accordian - Verify PDP accordion section titles are correctly translated
    Given There is 3 normal size product style of locale <locale> with inventory between 50 and 9999
    When I am on locale <locale> pdp page of langCode <langCode> for product style product3#styleColourPartNumber with accepted cookies
      And I get translation from lokalise for "DescriptionHeader" and store it with key #productDetailsText
      And I get translation from lokalise for "ShippingReturnsHeader" and store it with key #productReturnsText
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.ProductDetailsButton contains text "#productDetailsText"
      And I see ProductDetailPage.Pdp.ProductShippingAndReturnsButton contains text "#productReturnsText"

    Examples:
      | locale  | langCode |
      | default | default  |
      | be      | FR       |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @ColorSelector
  @tms:UTR-8356
  Scenario Outline: Color Selector - I want to see the colour swatch is displayed on product page when I select a multi color product
    Given There are 1 multi colour products with <count> colours of locale <locale> with inventory between 50 and 9999 filtered by FH
      And I extract a product style from product product1#stylePartNumber saved as #styleColourPartNumber
      And I extract a product item from product style #styleColourPartNumber which has inventory saved as #sku
      And I fetch colour name of product item #sku saved as #colourName
      And I am on locale <locale> pdp page for product style #styleColourPartNumber with forced accepted cookies
    When I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.ColorLabel with text #colourName is displayed
      And I see the count of elements ProductDetailPage.Pdp.ColorSwatches is equal to <count>
      And I see the attribute class of element ProductDetailPage.Pdp.ColorSwatchButton with index 1 containing "ColourSelected"

    @P1
    Examples:
      | locale  | count |
      | default | 7     |

    Examples:
      | locale           | count |
      | multiLangDefault | 7     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @ColorSelector @P2
  @tms:UTR-8357
  Scenario Outline: Color Selector - I want to see the colour swatch is not displayed on product page when I select a single color product
    Given There is 1 single colour product with 1 colour of locale <locale> with inventory between 10 and 99999
      And I extract a product style from product product1#stylePartNumber saved as #styleColourPartNumber
      And I extract a product item from product style #styleColourPartNumber which has inventory saved as #sku
      And I fetch colour name of product item #sku saved as #colourName
      And I am on locale <locale> pdp page for product style #styleColourPartNumber with forced accepted cookies
    When I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.ColorLabel with text #colourName is displayed
      And I see ProductDetailPage.Pdp.ColorSwatches is not displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @ColorSelector @P2
  @tms:UTR-8358
  Scenario Outline: Color Selector - I should see url and colour name has been changed when I change colour
    Given There is 1 multi colour products with at least 2 colours of locale <locale> and langCode <langCode> with inventory between 50 and 9999 filtered by FH
    When I extract a product style from product product1#stylePartNumber saved as #styleColourPartNumber
      And I am on locale <locale> pdp page for product style #styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I extract the colour name of ProductDetailPage.Pdp.ColorLabel and store it with key #colour1
      And I save current decoded url as key #url1
      And I click on ProductDetailPage.Pdp.ColorSwatchButton with index 2
      And I extract the colour name of ProductDetailPage.Pdp.ColorLabel and store it with key #colour2
      And I save current decoded url as key #url2
    Then I see the stored value with key #colour1 is not equal to "#colour2"
      And I see the stored value with key #url1 is not equal to "#url2"

    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @ColorSelector @P2
  @tms:UTR-8359
  Scenario Outline: Color Selector - I should see the previous colour name when I navigate back from a different colour
    Given There is 1 multi colour products with at least 2 colours of locale <locale> and langCode <langCode> with inventory between 50 and 9999 filtered by FH
    When I extract a product style from product product1#stylePartNumber saved as #styleColourPartNumber
      And I am on locale <locale> pdp page for product style #styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I extract the colour name of ProductDetailPage.Pdp.ColorLabel and store it with key #colour1
      And I click on ProductDetailPage.Pdp.ColorSwatchButton with index 2
      And I navigate back in the browser
      And I extract the colour name of ProductDetailPage.Pdp.ColorLabel and store it with key #colour2
    Then I see the stored value with key #colour1 is equal to "#colour2"

    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @ColorSelector @P2
  @tms:UTR-8360
  Scenario Outline: Color Selector - I should see with clicking on different colour and refreshing the page, page is rendered with new colour as first colour
    Given There is 1 multi colour products with at least 2 colours of locale <locale> and langCode <langCode> with inventory between 50 and 9999 filtered by FH
    When I extract a product style from product product1#stylePartNumber saved as #styleColourPartNumber
      And I am on locale <locale> pdp page for product style #styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I extract the colour name of ProductDetailPage.Pdp.ColorLabel and store it with key #colour1
      And I click on ProductDetailPage.Pdp.ColorSwatchButton with index 2
      And I extract the colour name of ProductDetailPage.Pdp.ColorLabel and store it with key #colour2
    Then I see the stored value with key #colour1 is not equal to "#colour2"
    When I refresh page
      And I extract the colour name of ProductDetailPage.Pdp.ColorLabel and store it with key #colour3
    Then I see the stored value with key #colour3 is equal to "#colour2"
      And I see ProductDetailPage.Pdp.FirstColour with text #colour3 is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @ColorSelector
  @tms:UTR-11047
  Scenario Outline: Color Selector - I should see add to bag button is displayed when adding different colour
    Given There is 1 multi colour product with at least 2 colours of locale <locale> and langCode <langCode> with inventory between 50 and 99999 filtered by FH
      And I extract product style from product product1#stylePartNumber with index 0 saved as #styleColourPartNumber1
      And I extract product style from product product1#stylePartNumber with index 1 saved as #styleColourPartNumber2
      And I extract a product item from product style #styleColourPartNumber2 which has inventory saved as #skuPartNumber
    When I am on locale <locale> pdp page for product style #styleColourPartNumber1 with forced accepted cookies
      And I wait until the current page is loaded
    Then I see the count of elements ProductDetailPage.Pdp.ColorSwatches is greater than 1
      And I see ProductDetailPage.Pdp.AddToBagButton is displayed
    When I click on ProductDetailPage.Pdp.ColorSwatchButton with index 2
      And I wait until the current page is loaded
    Then URL should contain "#styleColourPartNumber2"
    When in unified PDP I select size by sku part number #skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed

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
  @SizeSelector @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-8361
  Scenario Outline: Size Selector - I should see product with one size has size preselected and cannot be unselected
    Given There is 1 one size product style of locale <locale> with inventory between 1 and 9999
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
      And I get translation from lokalise for "Size" and store it with key #<SizeLabel>
    Then I see the attribute class of element ProductDetailPage.Pdp.OneSizeButton containing "SizeSelected"
      And I see ProductDetailPage.Pdp.SizeLabel with text #<SizeLabel> is displayed
    When I click on ProductDetailPage.Pdp.OneSizeButton
    Then I see the attribute class of element ProductDetailPage.Pdp.OneSizeButton containing "SizeSelected"

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @SizeSelector @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5103
  Scenario Outline: Size Selector - I should see normal size product with multiple sizes has size no preselected and can switch between sizes
    Given There is 5 normal size product style of locale <locale> with inventory between 50 and 9999
    When I am on locale <locale> pdp page for product style product2#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
      And I get translation from lokalise for "Size" and store it with key #<SizeLabel>
    Then I see the attribute class of element ProductDetailPage.Pdp.SizeSelectorButtons not containing "SizeSelected"
      And I see ProductDetailPage.Pdp.SizeLabel with text #<SizeLabel> is displayed
    When I click on ProductDetailPage.Pdp.SizeSelectorButtons with index 1
    Then I see the attribute class of element ProductDetailPage.Pdp.SizeSelectorButtons with index 1 containing "SizeSelected"
    When I click on ProductDetailPage.Pdp.SizeSelectorButtons with index 2
    Then I see the attribute class of element ProductDetailPage.Pdp.SizeSelectorButtons with index 1 not containing "SizeSelected"
      And I see the attribute class of element ProductDetailPage.Pdp.SizeSelectorButtons with index 2 containing "SizeSelected"

    Examples:
      | locale  |
      | default |

    Examples:
      | locale           |
      | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @SizeSelector @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13397 @ExcludeCK
  Scenario Outline: Size Selector - I should see width-length product with multiple sizes has size no preselected
    Given There are 5 width-length size product style of locale <locale> with inventory between 50 and 9999
    When I am on locale <locale> pdp page for product style product2#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
      And I get translation from lokalise for "WidthLabel" and store it with key #<WidthSizeLabel>
      And I get translation from lokalise for "LengthLabel" and store it with key #<LengthSizeLabel>
    Then I see the attribute class of element ProductDetailPage.Pdp.SizeSelectorButtons not containing "SizeSelected"
      And I see ProductDetailPage.Pdp.SizeLabel with text #<WidthSizeLabel> is displayed
      And I see ProductDetailPage.Pdp.SizeLabel with text #<LengthSizeLabel> is displayed

    Examples:
      | locale  |
      | default |

    Examples:
      | locale           |
      | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @PDP @WLP @SizeSelection @TEE
  @feature:EECK-4921 @P2
  @tms:UTR-13209 @issue:CET1-3756
  Scenario Outline: Size Selector - Size order on PDP and WLP should be consistent
    Given There is 5 normal size product style of locale <locale> with inventory between 50 and 9999
    When I am on locale <locale> pdp page for product style product2#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
      And I store the values of all elements ProductDetailPage.Pdp.AllSizes with key #pdpSizeOrder
      And I click on ProductDetailPage.Pdp.WishListIcon
      And in header I wait until unified wishlist is active in 5 seconds
      And I navigate to page wlp
      And in header I wait until unified wishlist is active in 5 seconds
      And I click on Experience.Wishlist.DisabledAddToBagButton with index 1
    Then the values of all elements Experience.Wishlist.AllSizes should be equal to the stored values with key #pdpSizeOrder

    Examples:
      | locale  |
      | default |

    Examples:
      | locale           |
      | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @ExcludeCK @Translation @Lokalise
  @SustainabilityAccordion @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5104
  Scenario Outline: Sustainable styles - I see sustainable style details section is opened by default and correct sustainable type and icon is present
    Given There is 1 sustainable product style with Sustainable type <sustainableType> of locale <locale> and langCode default with inventory between 1 and 999999
      And I am on locale <locale> pdp page of langCode default for product style product1#styleColourPartNumber with accepted cookies
    When I wait until the current page is loaded
      And I get translation from lokalise for "<sustainableType>" and store it with key #sustainableTypeText
      And I smoothly scroll to the element ProductDetailPage.Pdp.SustainableStyleSection
    Then I see ProductDetailPage.Pdp.ExpandedSustainableDetailsSection is displayed
      And I see ProductDetailPage.Pdp.SustainableIcon is displayed
      And I see ProductDetailPage.Pdp.SustainableType with text #sustainableTypeText is displayed
      And I see ProductDetailPage.Pdp.ClosedProductDetailsSection is displayed
      And I see ProductDetailPage.Pdp.ClosedProductShippingAndReturnsSection is displayed

    Examples:
      | locale  | sustainableType                 |
      | default | Sustainable_sustainable_viscose |
      | default | Sustainable_sustainable_modal   |
      | default | Sustainable_sustainable_lyocell |
      | default | Sustainable_lenzing_modal       |
      | default | Sustainable_organic_leather     |
      | default | Sustainable_transitional_cotton |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @ExcludeCK
  @BenefitsAccordion @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5108
  Scenario Outline: TH - Benefits section - I see benefits section is opened by default and correct benefit type and icon is present
    Given There is 1 product style with Benefit type <BenefitType> of locale <locale> with inventory between 1 and 999999
      And I am on locale <locale> pdp page of langCode default for product style product1#styleColourPartNumber with accepted cookies
    When I wait until the current page is loaded
      And I smoothly scroll to the element ProductDetailPage.Pdp.BenefitsSection
    Then I see benefits section is expanded when no sustainable section is displayed
    When I click on ProductDetailPage.Pdp.ClosedBenefitsSection if displayed
    Then I see ProductDetailPage.Pdp.ExpandedBenefitsSection is displayed
      And I see ProductDetailPage.Pdp.BenefitsIcon is displayed
      And I see ProductDetailPage.Pdp.BenefitsType with text "<BenefitsTypeText>" is displayed

    Examples:
      | locale  | BenefitType                     | BenefitsTypeText |
      | default | TH_Functionality_Packable       | Packable         |
      | default | TH_Functionality_WaterRepellent | Water Repellent  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @ExcludeTH
  @BenefitsAccordion @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5108
  Scenario Outline: CK - Benefits section - I see benefits section is opened by default and correct benefit type and icon is present
    Given There is 1 product style with Benefit type <BenefitType> of locale <locale> with inventory between 1 and 999999
      And I am on locale <locale> pdp page of langCode default for product style product1#styleColourPartNumber with accepted cookies
    When I wait until the current page is loaded
      And I smoothly scroll to the element ProductDetailPage.Pdp.BenefitsSection
    Then I see benefits section is expanded when no sustainable section is displayed
    When I click on ProductDetailPage.Pdp.ClosedBenefitsSection if displayed
    Then I see ProductDetailPage.Pdp.ExpandedBenefitsSection is displayed
      And I see ProductDetailPage.Pdp.BenefitsIcon is displayed
      And I see ProductDetailPage.Pdp.BenefitsType with text "<BenefitsTypeText>" is displayed

    Examples:
      | locale  | BenefitType           | BenefitsTypeText |
      | default | Functionality_BREATHE | BREATHE          |
      | default | Functionality_REFLECT | REFLECT          |
      | default | Functionality_WICK    | WICK             |
      | default | Functionality_DRY     | DRY              |