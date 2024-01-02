Feature: Unified XO - No search Page

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedExperience @UnifiedXo @TEX @P2
  @tms:UTR-5590 @ExcludeProdStag @ExcludeUat
  Scenario Outline: Unified XO From no search result page - in XO recommendations I can open PDP
    Given I am on locale <locale> search page of langCode <langCode> with search term "neverexistsearch" with forced accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
      And I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
    When I wait until Experience.Recommendations.RecoNoSearchSection is displayed in 10 seconds
      And I scroll to the element Experience.Recommendations.RecoNoSearchSection
      And I store the value of Experience.Recommendations.RecoProductName with index 1 with key #displayedProductName
      And I click on Experience.Recommendations.RecoProductLink with index 1
      And I wait until page ProductDetailPage.Pdp is loaded
      And I store the value of ProductDetailPage.Pdp.ProductName with key #expectedProductName
    Then I see the stored value with key #displayedProductName should contain "#expectedProductName"

    @ExcludeCK
    Examples:
      | locale | langCode | xoWidgetId               |
      | ee     | default  | 63b567c9c466f7573189c3ac |

    @ExcludeTH
    Examples:
      | locale | langCode | xoWidgetId               |
      | ee     | default  | 63b6bc9be592f04c8a55c100 |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedExperience @UnifiedXo @TEX @XO @P3
  @tms:UTR-16792
  Scenario Outline: Unified XO From no search result page - in XO recommendations chrome extension is enabled
    Given I am on locale <locale> search page of langCode <langCode> with search term "neverexistsearch" with forced accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And in js extract window.ebRecoIds.length save to #numberOfXOWidget
      And I see the stored value with key #numberOfXOWidget is equal to "1"
    When in js extract window.ebRecoIds[0] save to #sourceId
    Then I see the stored value with key #sourceId should contain "-"

    @ExcludeCK
    Examples:
      | locale | langCode | xoWidgetId               |
      | ee     | default  | 63b567c9c466f7573189c3ac |

    @ExcludeTH
    Examples:
      | locale | langCode | xoWidgetId               |
      | ee     | default  | 63b6bc9be592f04c8a55c100 |


  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedExperience @UnifiedXo @TEX @XO
  @tms:UTR-16793
  Scenario Outline: Unified XO From From no search result page - in XO recommendations I can open size dropdown by clicking on Add button
    Given I am on locale <locale> search page of langCode <langCode> with search term "neverexistsearch" with forced accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
      And I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I wait until Experience.Recommendations.RecoNoSearchSection is displayed in 10 seconds
      And I scroll to the element Experience.Recommendations.RecoNoSearchSection
      And I store the value of Experience.Recommendations.RecoProductName with index 1 with key #displayedProductName
    When I click on Experience.Recommendations.RecoNoSearchAddToBagBtn with args <styleColourPartNumber>
    Then I see Experience.Recommendations.OpenSizeDropdownContainer with args <injectionId>##<styleColourPartNumber> is displayed

    @ExcludeCK @P1
    Examples:
      | locale | langCode | skuPartNumber | styleColourPartNumber | xoWidgetId               | sizeType | injectionId |
      | ee     | default  | 8720641066372 | 76J2532ADP670         | 63b59446c466f7573189f67a | normal   | injection1  |

    @ExcludeCK @P2
    Examples:
      | locale | langCode | skuPartNumber | styleColourPartNumber | xoWidgetId               | sizeType     | injectionId |
      | ee     | default  | 8718941982652 | WW0WW11860410         | 63b567c9c466f7573189c3ac | width-length | injection1  |

    @ExcludeTH @P1
    Examples:
      | locale | langCode | skuPartNumber | styleColourPartNumber | xoWidgetId               | sizeType | injectionId |
      | ee     | default  | 8719852224305 | J20J213178YAF         | 63b6bb75f616cce339184d4f | normal   | injection1  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedExperience @UnifiedXo @TEX @XO
  @tms:UTR-16794
  Scenario Outline: Unified XO From From no search result page - in xo recommendation I can add any size item to ShoppingBag
    Given I am on locale <locale> search page of langCode <langCode> with search term "neverexistsearch" with forced accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
      And I fetch size name of product item <skuPartNumber> saved as #sizeName
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I wait until Experience.Recommendations.RecoNoSearchSection is displayed in 10 seconds
      And I scroll to the element Experience.Recommendations.RecoNoSearchSection
      And from unified XO recommendation with <styleColourPartNumber> I add product in bag by selecting dropdown option by text "#sizeName"
      And I wait until Experience.AddToBagPopUp.MainBlock is displayed in 10 seconds
      And I see Experience.Header.ShoppingBagCounter contains text "1"
    When I navigate to page shopping-bag
      And I scroll to the element Experience.ShoppingBag.FilledShoppingBagSection
    Then the count of displayed elements Experience.ShoppingBag.Item is equal to 1 in 10 seconds

    @ExcludeCK @P1
    Examples:
      | locale | langCode | skuPartNumber | styleColourPartNumber | xoWidgetId               | sizeType |
      | ee     | default  | 8720641066372 | 76J2532ADP670         | 63b59446c466f7573189f67a | normal   |

    @ExcludeCK @P2
    Examples:
      | locale | langCode | skuPartNumber | styleColourPartNumber | xoWidgetId               | sizeType     |
      | ee     | default  | 8718941982652 | WW0WW11860410         | 63b567c9c466f7573189c3ac | width-length |

    @ExcludeTH @P1
    Examples:
      | locale | langCode | skuPartNumber | styleColourPartNumber | xoWidgetId               | sizeType |
      | ee     | default  | 8719852224305 | J20J213178YAF         | 63b6bb75f616cce339184d4f | normal   |
