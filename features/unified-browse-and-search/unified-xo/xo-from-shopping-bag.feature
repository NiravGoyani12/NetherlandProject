Feature: Unified XO - Shopping Bag

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox
  @UnifiedExperience @UnifiedXo @TEX @P1
  @tms:UTR-5594 @ExcludeProdStag
  Scenario Outline: XO From Shopping bag - In Recommendations I can open PDP
    Given I am on locale <locale> of url shopping-bag of langCode <langCode> with accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
      And I wait until the current page is loaded
      And I smoothly scroll to the element Experience.Footer.MainBlock
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 60 seconds
    When I scroll to and click on Experience.Recommendations.RecoShoppingBasketItemImage with args <styleColourPartNumber>
    Then I wait until page ProductDetailPage.Pdp is loaded
      And in unified PDP I see product info is matched to product style by style colour number <styleColourPartNumber>

    @ExcludeTH
    Examples:
      | locale  | langCode | styleColourPartNumber | xoWidgetId               | sizeType |
      | default | default  | J20J213178YAF         | 63b6bb75f616cce339184d4f | normal   |

    @ExcludeCK
    Examples:
      | locale  | langCode | styleColourPartNumber | xoWidgetId               | sizeType |
      | default | default  | MWF1782456000         | 63b41dbd355034a2ffc911a8 | one      |

  @FullRegression
  @Desktop @Safari
  @Chrome @FireFox
  @UnifiedExperience @UnifiedXo @TEX @P2
  @tms:UTR-5593 @ExcludeProdStag
  Scenario Outline: XO from shopping bag - in xo recommendation I can open size dropdown by clicking on Add button
    Given I am on locale <locale> of url shopping-bag of langCode <langCode> with accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
      And I smoothly scroll to the element Experience.Footer.MainBlock
      And I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
    When I wait until Experience.Recommendations.RecoShoppingBasketSection is displayed in 10 seconds
      And I scroll to the element Experience.Recommendations.RecoShoppingBasketSection
      And I wait until Experience.Recommendations.RecoShoppingBasketSection is displayed in 5 seconds
    When I click on Experience.Recommendations.RecoShoppingBasketAddToBagBtn with args <styleColourPartNumber>
    Then I see Experience.Recommendations.OpenSizeDropdownContainer with args <injectionId>##<styleColourPartNumber> is displayed

    @ExcludeTH
    Examples:
      | locale | langCode | styleColourPartNumber | xoWidgetId               | sizeType | injectionId |
      | uk     | default  | J20J213178YAF         | 63b6bb75f616cce339184d4f | normal   | injection1  |

    @ExcludeCK
    Examples:
      | locale | langCode | styleColourPartNumber | xoWidgetId               | sizeType     | injectionId |
      | uk     | default  | WW0WW11860410         | 63b567c9c466f7573189c3ac | width-length | injection1  |

  @FullRegression
  @Desktop @Mobile @Safari
  @Chrome @FireFox
  @UnifiedExperience @UnifiedXo @TEX @P2
  @tms:UTR-701 @ExcludeProdStag
  Scenario Outline: XO From Shopping bag - in XO recommendations chrome extension is enabled
    Given I am on locale <locale> of url shopping-bag of langCode <langCode> with accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
      And I smoothly scroll to the element Experience.Footer.MainBlock
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And in js extract window.ebRecoIds.length save to #numberOfXOWidget
      And I see the stored value with key #numberOfXOWidget is equal to "1"
    When in js extract window.ebRecoIds[0] save to #sourceId
    Then I see the stored value with key #sourceId should contain "-"

    @ExcludeTH
    Examples:
      | locale | langCode | xoWidgetId               |
      | uk     | default  | 63b6bb75f616cce339184d4f |

    @ExcludeCK
    Examples:
      | locale | langCode | xoWidgetId               |
      | uk     | default  | 63b41dbd355034a2ffc911a8 |


  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedExperience @UnifiedXo @TEX @P2
  @tms:UTR-3848 @ExcludeProdStag
  Scenario Outline: XO From Shopping bag - in XO recommendations request uri I am able to see Basket Amount
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product with forced accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I see Experience.ShoppingBag.Item with args product1#skuPartNumber is displayed
    When I force the url with a xo-widget-id <xoWidgetId>
      And I smoothly scroll to the element Experience.Footer.MainBlock
      And I store the wholePart value of Experience.ShoppingBag.SubTotalPriceInfo with key #subTotalPrice
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I wait until Experience.Recommendations.RecoShoppingBasketSection is displayed in 5 seconds
      And I see xo variable "<basketVariable>" should be present in xo api
      And I see xo variable "#subTotalPrice" should be present in xo api

    @ExcludeTH
    Examples:
      | locale | langCode | xoWidgetId               | basketVariable    | sizeType |
      | uk     | default  | 63b6bb75f616cce339184d4f | basketTotalAmount | normal   |

    @ExcludeCK
    Examples:
      | locale | langCode | xoWidgetId               | basketVariable    | sizeType |
      | uk     | default  | 63b41dbd355034a2ffc911a8 | basketTotalAmount | one      |

  @FullRegression
  @Desktop @Mobile @Safari
  @Chrome @FireFox
  @UnifiedExperience @UnifiedXo @TEX @P2
  @tms:UTR-13286 @ExcludeProdStag
  Scenario Outline: XO from shopping bag - in xo recommendation I can add one size item to ShoppingBag by clicking on Add button
    Given I am on locale <locale> of url shopping-bag of langCode <langCode> with accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
      And I smoothly scroll to the element Experience.Footer.MainBlock
      And I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 20 seconds
    When I wait until Experience.Recommendations.RecoShoppingBasketSection is displayed in 10 seconds
      And I scroll to the element Experience.Recommendations.RecoShoppingBasketSection
      And I wait until Experience.Recommendations.RecoShoppingBasketSection is displayed in 5 seconds
      And I click on Experience.Recommendations.RecoShoppingBasketAddToBagBtn with args <styleColourPartNumber>
      And I wait until Experience.AddToBagPopUp.MainBlock is displayed
    Then I see Experience.Header.ShoppingBagCounter contains text "1"
      And I refresh page
      And I scroll to the element Experience.ShoppingBag.FilledShoppingBagSection
      And the count of displayed elements Experience.ShoppingBag.Item is equal to 1 in 10 seconds

    @ExcludeTH
    Examples:
      | locale | langCode | styleColourPartNumber | xoWidgetId               | sizeType |
      | uk     | default  | K50K502533001         | 63b598289a767ed180664d78 | one      |

    @ExcludeCK
    Examples:
      | locale | langCode | styleColourPartNumber | xoWidgetId               | sizeType |
      | uk     | default  | MWF1782456000         | 63b41dbd355034a2ffc911a8 | one      |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox
  @UnifiedXo @UnifiedExperience @TEX
  @tms:UTR-13287 @ExcludeProdStag
  Scenario Outline: XO from shopping bag - in xo recommendation I can add any size item to ShoppingBag
    Given I am on locale <locale> of url shopping-bag of langCode <langCode> with accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
    When I fetch size name of product item <skuPartNumber> saved as #sizeName
      And I smoothly scroll to the element Experience.Footer.MainBlock
      And I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
    When I wait until Experience.Recommendations.RecoShoppingBasketSection is displayed in 30 seconds
      And I scroll to the element Experience.Recommendations.RecoShoppingBasketSection
      And I wait until Experience.Recommendations.RecoShoppingBasketSection is displayed in 5 seconds
      And from unified XO recommendation with <styleColourPartNumber> I add product in bag by selecting dropdown option by text "#sizeName"
      And I wait until Experience.AddToBagPopUp.MainBlock is displayed in 10 seconds
    Then I see Experience.Header.ShoppingBagCounter contains text "1"
      And I refresh page
      And I scroll to the element Experience.ShoppingBag.FilledShoppingBagSection
      And the count of displayed elements Experience.ShoppingBag.Item is equal to 1 in 10 seconds

    @ExcludeCK @P1
    Examples:
      | locale  | langCode | skuPartNumber | styleColourPartNumber | xoWidgetId               | sizeType |
      | default | default  | 8720641066372 | 76J2532ADP670         | 63b59446c466f7573189f67a | normal   |

    @ExcludeCK @P2
    Examples:
      | locale | langCode | skuPartNumber | styleColourPartNumber | xoWidgetId               | sizeType     |
      | uk     | default  | 7613272450645 | MWF1782456000         | 63b41dbd355034a2ffc911a8 | one          |
      | uk     | default  | 8718941982652 | WW0WW11860410         | 63b567c9c466f7573189c3ac | width-length |

    @ExcludeTH @P1
    Examples:
      | locale  | langCode | skuPartNumber | styleColourPartNumber | xoWidgetId               | sizeType |
      | default | default  | 8719852224305 | J20J213178YAF         | 63b6bb75f616cce339184d4f | normal   |
