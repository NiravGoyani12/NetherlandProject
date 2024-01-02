Feature: Unified XO - PDP

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @UnifiedExperience @UnifiedXo @TEX
  @tms:UTR-11153 @ExcludeProdStag @issue:TEX-16319
  Scenario Outline: Unified XO From Unified PDP - In Recommend To You I can open PDP
    Given There is 1 normal size product item of locale <locale> and langCode <langCode> with inventory between 100 and 9999 filtered by FH
      And I am on unified locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
      And I wait until the current page is loaded
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
    When I click on Experience.Recommendations.RecoForYouItem with index 1
      And I wait until the current page is loaded
    Then in unified PDP I see product info is matched to product style by style colour number <styleColourPartNumber>

    @ExcludeCK @P1
    Examples:
      | locale  | langCode | styleColourPartNumber | xoWidgetId               | sizeType |
      | default | default  | MWF1782456000         | 63b41dbd355034a2ffc911a8 | one      |

    @ExcludeCK @P2
    Examples:
      | locale  | langCode | styleColourPartNumber | xoWidgetId               | sizeType     |
      | default | default  | WW0WW11860410         | 63b567c9c466f7573189c3ac | width-length |

    @ExcludeTH @P1
    Examples:
      | locale  | langCode | styleColourPartNumber | xoWidgetId               | sizeType |
      | default | default  | J20J213178YAF         | 63b6bb75f616cce339184d4f | normal   |

    @ExcludeTH @P2
    Examples:
      | locale  | langCode | styleColourPartNumber | xoWidgetId               | sizeType |
      | default | default  | J30J3155711BZ         | 63b6bc9be592f04c8a55c100 | one      |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedExperience @UnifiedXo @TEX
  @tms:UTR-13284 @ExcludeProdStag @issue:TEX-16319
  Scenario Outline: Unified XO From Unified PDP - In Matched items I can open PDP
    Given There is 1 normal size product item of locale <locale> and langCode <langCode> with inventory between 100 and 9999 filtered by FH
      And I am on unified locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
      And I wait until the current page is loaded
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
    When I click on Experience.Recommendations.MatchedItem with index 1
      And I wait until the current page is loaded
    Then in unified PDP I see product info is matched to product style by style colour number <styleColourPartNumber>

    @ExcludeCK @P1
    Examples:
      | locale | langCode | styleColourPartNumber | xoWidgetId               | sizeType |
      | ee     | default  | MWF1782456000         | 63b41dbd355034a2ffc911a8 | one      |

    @ExcludeCK @P2
    Examples:
      | locale | langCode | styleColourPartNumber | xoWidgetId               | sizeType     |
      | ee     | default  | WW0WW11860410         | 63b567c9c466f7573189c3ac | width-length |
      | ee     | default  | 76J2532ADP670         | 63b59446c466f7573189f67a | normal       |
    # | ee     | default  | MW0MW180351A9         | 63b5682c9a767ed18063fdc9 | width only   |

    @ExcludeTH @P1
    Examples:
      | locale | langCode | styleColourPartNumber | xoWidgetId               | sizeType |
      | ee     | default  | J20J213178YAF         | 63b6bb75f616cce339184d4f | normal   |

    @ExcludeTH @P2
    Examples:
      | locale | langCode | styleColourPartNumber | xoWidgetId               | sizeType     |
      | ee     | default  | J30J3155711BZ         | 63b6bc9be592f04c8a55c100 | width-length |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @UnifiedExperience @UnifiedXo @TEX
  @tms:UTR-13285 @ExcludeProdStag @issue:TEX-16319
  Scenario Outline: Unified XO From Unified PDP - In recently viewed items I can open PDP
    Given There is 1 normal size product item of locale <locale> and langCode <langCode> with inventory between 100 and 9999 filtered by FH
      And I am on unified locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
      And I wait until the current page is loaded
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
    When I click on Experience.Recommendations.RecentlyViewedItem with index 1
      And I wait until the current page is loaded
    Then in unified PDP I see product info is matched to product style by style colour number <styleColourPartNumber>

    @ExcludeCK @P1
    Examples:
      | locale | langCode | styleColourPartNumber | xoWidgetId               | sizeType |
      | ee     | default  | MWF1782456000         | 63b41dbd355034a2ffc911a8 | one      |

    @ExcludeCK @P2
    Examples:
      | locale | langCode | styleColourPartNumber | xoWidgetId               | sizeType     |
      | ee     | default  | WW0WW11860410         | 63b567c9c466f7573189c3ac | width-length |
      | ee     | default  | 76J2532ADP670         | 63b59446c466f7573189f67a | normal       |
    # | ee     | default  | MW0MW180351A9         | 63b5682c9a767ed18063fdc9 | width only   |

    @ExcludeTH @P1
    Examples:
      | locale | langCode | styleColourPartNumber | xoWidgetId               | sizeType |
      | ee     | default  | J20J213178YAF         | 63b6bb75f616cce339184d4f | normal   |

    @ExcludeTH @P2
    Examples:
      | locale | langCode | styleColourPartNumber | xoWidgetId               | sizeType     |
      | uk     | default  | J30J3155711BZ         | 63b6bc9be592f04c8a55c100 | width-length |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedExperience @UnifiedXo @TEX @P2
  @tms:UTR-460 @ExcludeProdStag @issue:TEX-16319
  Scenario Outline: Unified XO From Unified PDP - product color switch trigger recommendation api to change products in recommendations
    Given There is 1 multi colour product with at least 2 colours of locale <locale> and langCode <langCode> with inventory between 1 and 9999 filtered by FH
      And I extract a product style from product product1#stylePartNumber saved as #styleColourPartNumber
      And I am on unified locale <locale> pdp page of langCode <langCode> for product style #styleColourPartNumber with accepted cookies
    Then I expect 3 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
    When I click on ProductDetailPage.Pdp.ColorSwatchButton with index 2
    Then I expect at least 4 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds

    @ExcludeCK
    Examples:
      | locale | langCode |
      | ee     | default  |

    @ExcludeTH
    Examples:
      | locale | langCode |
      | ee     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedExperience @UnifiedXo @TEX @P2
  @tms:UTR-695 @ExcludeProdStag @issue:TEX-16319
  Scenario Outline: Unified XO From Unified PDP - in XO recommendations chrome extension is enabled
    Given There is 1 normal size product item of locale <locale> and langCode <langCode> with inventory between 100 and 9999 filtered by FH
      And I am on unified locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I wait until page ProductDetailPage.Pdp is loaded
      And in js extract window.ebRecoIds.length save to #NumberOfXOWidget
      And I see the stored value with key #NumberOfXOWidget is equal to "3"
    When in js extract window.ebRecoIds[0] save to #sourceId1
    Then I see the stored value with key #sourceId1 should contain "-"
    When in js extract window.ebRecoIds[1] save to #sourceId2
    Then I see the stored value with key #sourceId2 should contain "-"
    When in js extract window.ebRecoIds[2] save to #sourceId3
    Then I see the stored value with key #sourceId3 should contain "-"

    @ExcludeCK
    Examples:
      | locale | langCode |
      | ee     | default  |

    @ExcludeTH
    Examples:
      | locale | langCode |
      | ee     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedExperience @UnifiedXo @TEX @P2
  @tms:UTR-749 @ExcludeProdStag @issue:TEX-15154
  Scenario Outline: Unified XO From Unified PDP - in XO recommendations I am able to recognise channel traffic entry
    Given There is 1 normal size product item of locale <locale> and langCode <langCode> with inventory between 100 and 9999 filtered by FH
      And I am on unified locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with accepted cookies
    When I force the url with a xo-widget-id <xoWidgetId>
      And I wait until the current page is loaded
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
    When I navigate to current url with suffix <trafficSuffix>
      And I click on Experience.Recommendations.MatchedItem with index 1
      And I wait for 3 seconds
    Then I wait until the current page is loaded
      And I see xo variable "<channel>" should be present in xo uri
      And I see xo variable "$utm_term" should be present in xo api
      And I see xo variable "$utm_source" should be present in xo api
      And I see xo variable "$utm_campaign" should be present in xo api

    @ExcludeCK
    Examples:
      | locale | langCode | xoWidgetId               | channel  | trafficSuffix                                                                                                                                                                   |
      | ee     | default  | 63b41dbd355034a2ffc911a8 | facebook | &cmpid=ch:social_organic%7Cso:facebook%7Ccj:interest%7Ccp:who_makeyourmove_sp22&utm_medium=social_organic&utm_source=social_organic_facebook&utm_campaign=who_makeyourmove_sp22 |
      | ee     | default  | 63b41dbd355034a2ffc911a8 | twitter  | &cmpid=ch:social_organic%7Cso:twitter%7Ccj:interest%7Ccp:who_makeyourmove_sp22&utm_medium=social_organic&utm_source=social_organic_twitter&utm_campaign=who_makeyourmove_sp22   |

    @ExcludeTH
    Examples:
      | locale | langCode | xoWidgetId               | channel  | trafficSuffix                                                                                                                                                                   |
      | ee     | default  | 63b6bc9be592f04c8a55c100 | facebook | &cmpid=ch:social_organic%7Cso:facebook%7Ccj:interest%7Ccp:who_makeyourmove_sp22&utm_medium=social_organic&utm_source=social_organic_facebook&utm_campaign=who_makeyourmove_sp22 |
      | ee     | default  | 63b6bc9be592f04c8a55c100 | twitter  | &cmpid=ch:social_organic%7Cso:twitter%7Ccj:interest%7Ccp:who_makeyourmove_sp22&utm_medium=social_organic&utm_source=social_organic_twitter&utm_campaign=who_makeyourmove_sp22   |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedExperience @UnifiedXo @TEX @P2
  @tms:UTR-1278 @ExcludeProdStag @issue:TEX-16319
  Scenario Outline: Unified XO From Unified PDP - in XO recommendations I am able to recognise channel traffic entry from the latest source
    Given There is 1 normal size product item of locale <locale> and langCode <langCode> with inventory between 100 and 9999 filtered by FH
      And I am on unified locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with accepted cookies
    When I force the url with a xo-widget-id <xoWidgetId>
      And I wait until the current page is loaded
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
    When I navigate to current url with suffix <traffic1Suffix>
    Then URL should contain "<channel1>"
    When I am on unified locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
      And I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I navigate to current url with suffix <traffic2Suffix>
      And I click on Experience.Recommendations.MatchedItem with index 1
    Then I wait until page ProductDetailPage.Pdp is loaded
      And I see xo variable "<channel2>" should be present in xo uri

    @ExcludeCK
    Examples:
      | locale | langCode | xoWidgetId               | channel1 | traffic1Suffix                                                                                                                                                                  | channel2 | traffic2Suffix                                                                                                                                                                |
      | ee     | default  | 63b59446c466f7573189f67a | facebook | &cmpid=ch:social_organic%7Cso:facebook%7Ccj:interest%7Ccp:who_makeyourmove_sp22&utm_medium=social_organic&utm_source=social_organic_facebook&utm_campaign=who_makeyourmove_sp22 | twitter  | &cmpid=ch:social_organic%7Cso:twitter%7Ccj:interest%7Ccp:who_makeyourmove_sp22&utm_medium=social_organic&utm_source=social_organic_twitter&utm_campaign=who_makeyourmove_sp22 |

    @ExcludeTH
    Examples:
      | locale | langCode | xoWidgetId               | channel1 | traffic1Suffix                                                                                                                                                                  | channel2 | traffic2Suffix                                                                                                                                                                |
      | ee     | default  | 63b6bc9be592f04c8a55c100 | facebook | &cmpid=ch:social_organic%7Cso:facebook%7Ccj:interest%7Ccp:who_makeyourmove_sp22&utm_medium=social_organic&utm_source=social_organic_facebook&utm_campaign=who_makeyourmove_sp22 | twitter  | &cmpid=ch:social_organic%7Cso:twitter%7Ccj:interest%7Ccp:who_makeyourmove_sp22&utm_medium=social_organic&utm_source=social_organic_twitter&utm_campaign=who_makeyourmove_sp22 |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedExperience @UnifiedXo @TEX @P2
  @tms:UTR-1319 @ExcludeProdStag @issue:TEX-16319
  Scenario Outline: Unified XO From Unified PDP - in XO recommendations I am NOT able to recognise channel traffic entry when analytics cookies are not accepted
    Given There is 1 normal size product item of locale <locale> and langCode <langCode> with inventory between 100 and 9999 filtered by FH
      And I am on unified locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber
    When I force the url with a xo-widget-id <xoWidgetId>
      And I wait until the current page is loaded
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
    When I navigate to current url with suffix <trafficSuffix>
      And I wait until page ProductDetailPage.Pdp is loaded
      And I am on unified locale <locale> pdp page of langCode <langCode> for product style <styleColourPartNumber>
    Then I see xo variable "<channel>" should not be present in xo api
      And I see xo variable "none" should be present in xo api

    @ExcludeCK
    Examples:
      | locale    | langCode | styleColourPartNumber | xoWidgetId               | channel  | trafficSuffix                                                                                                                                                                   |
      | xoDefault | default  | 76J2532ADP670         | 63b59446c466f7573189f67a | facebook | &cmpid=ch:social_organic%7Cso:facebook%7Ccj:interest%7Ccp:who_makeyourmove_sp22&utm_medium=social_organic&utm_source=social_organic_facebook&utm_campaign=who_makeyourmove_sp22 |

    @ExcludeTH
    Examples:
      | locale    | langCode | styleColourPartNumber | xoWidgetId               | channel  | trafficSuffix                                                                                                                                                                   |
      | xoDefault | default  | J30J3155711BZ         | 63b6bc9be592f04c8a55c100 | facebook | &cmpid=ch:social_organic%7Cso:facebook%7Ccj:interest%7Ccp:who_makeyourmove_sp22&utm_medium=social_organic&utm_source=social_organic_facebook&utm_campaign=who_makeyourmove_sp22 |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedExperience @UnifiedXo @TEX
  @tms:UTR-5592 @ExcludeProdStag @issue:TEX-16319
  Scenario Outline: Unified XO From Unified PDP - XO From PDP - In recommendations size dropdown opens on clicking Add button filtered by FH
    Given There is 1 normal size product item of locale <locale> and langCode <langCode> with inventory between 100 and 9999
      And I am on unified locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
    When I force the url with a xo-widget-id <xoWidgetId>
      And I wait until the current page is loaded
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
    When I scroll to the element <recommendationSection>
      And I click on Experience.Recommendations.AddToCartButtonByStyleColour with args <injectionId>,<styleColourPartNumber>
    Then I see Experience.Recommendations.OpenSizeDropdownContainer with args <injectionId>##<styleColourPartNumber> is displayed

    @ExcludeCK @P1
    Examples:
      | locale    | langCode | styleColourPartNumber | xoWidgetId               | sizeType | recommendationSection                           | injectionId |
      | xoDefault | default  | 76J2532ADP670         | 63b59446c466f7573189f67a | normal   | Experience.Recommendations.MatchingItemsSection | injection1  |

    @ExcludeCK @P2
    Examples:
      | locale    | langCode | styleColourPartNumber | xoWidgetId               | sizeType     | recommendationSection                        | injectionId |
      | xoDefault | default  | WW0WW11860410         | 63b567c9c466f7573189c3ac | width-length | Experience.Recommendations.RecoForYouSection | injection2  |
    # | xoDefault | default  | MW0MW180351A9         | 63b5682c9a767ed18063fdc9 | width only   | Experience.Recommendations.RecentlyViewedSection | injection3  |

    @ExcludeTH @P1
    Examples:
      | locale    | langCode | styleColourPartNumber | xoWidgetId               | sizeType | recommendationSection                           | injectionId |
      | xoDefault | default  | J20J213178YAF         | 63b6bb75f616cce339184d4f | normal   | Experience.Recommendations.MatchingItemsSection | injection1  |

    @ExcludeTH @P2
    Examples:
      | locale    | langCode | styleColourPartNumber | xoWidgetId               | sizeType     | recommendationSection                            | injectionId |
      | xoDefault | default  | J30J3155711BZ         | 63b6bc9be592f04c8a55c100 | width-length | Experience.Recommendations.RecoForYouSection     | injection2  |
      | xoDefault | default  | J20J213178YAF         | 63b6bb75f616cce339184d4f | normal       | Experience.Recommendations.MatchingItemsSection  | injection1  |
      | xoDefault | default  | J30J3155711BZ         | 63b6bc9be592f04c8a55c100 | width-length | Experience.Recommendations.RecentlyViewedSection | injection3  |
