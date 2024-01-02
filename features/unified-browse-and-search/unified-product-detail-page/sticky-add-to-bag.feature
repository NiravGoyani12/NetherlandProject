Feature: Unified PDP - Sticky Add to Bag

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PDP @TEE @UnifiedPdp @UnifiedExperience @StickyAddToBag @P2
  @tms:UTR-12157
  Scenario Outline: Sticky Add To Bag - Verify Sticky add to bag is displayed when add to bag button is not in the viewport
    Given There are 5 normal size product style of locale <locale> with inventory between 10 and 99999
    When I am on locale <locale> pdp page for product style product3#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
      And I get translation from lokalise for "AddToBagText" and store it with key #AddToBag
      And I move to the bottom of the page
    Then I see ProductDetailPage.Pdp.AddToBagButton is not in viewport in 2 seconds
      And I see ProductDetailPage.Pdp.StickyAddToBagPanel is displayed
      And I see ProductDetailPage.Pdp.StickyAddToBagButton with text #AddToBag is displayed

    Examples:
      | locale           |
      | default          |
      | multiLangDefault |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @StickyAddToBag @P2
  @tms:UTR-12158 @issue:PAN-6023
  Scenario Outline: Sticky Add To Bag - Verify Sticky add to bag is not displayed when add to bag button is in the viewport
    Given There are 5 normal size product style of locale <locale> with inventory between 10 and 99999
    When I am on locale <locale> pdp page for product style product3#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
      And I scroll to the element ProductDetailPage.Pdp.AddToBagButton
    Then I see ProductDetailPage.Pdp.AddToBagButton is in viewport
      And I see ProductDetailPage.Pdp.StickyAddToBagPanel is not displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @StickyAddToBag @P2
  @tms:UTR-12159
  Scenario Outline: Sticky Add To Bag - Desktop - Verify Sticky add to bag is not displayed on Desktop PDP
    Given There is 1 normal size product style of locale <locale> with inventory between 10 and 99999 filtered by FH
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.AddToBagButton is displayed
    When I move to the bottom of the page
    Then I see ProductDetailPage.Pdp.StickyAddToBagPanel is not displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @StickyAddToBag @P2
  @tms:UTR-12160
  Scenario Outline: Sticky Add To Bag - Verify normal size product can be added to cart from sticky add to bag
    Given There are 5 normal size product item of locale <locale> with inventory between 10 and 99999
    When I am on locale <locale> pdp page for product style product3#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
      And in unified PDP I select size by sku part number product3#skuPartNumber
      And I move to the bottom of the page
      And I click on ProductDetailPage.Pdp.StickyAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @StickyAddToBag @P2
  @tms:UTR-12161
  Scenario Outline: Sticky Add To Bag - Verify one size product can be added to cart from sticky add to bag
    Given There is 1 one size product item of locale <locale> with inventory between 10 and 99999 filtered by FH
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
      And I move to the bottom of the page
      And I click on ProductDetailPage.Pdp.StickyAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PDP @TEE @UnifiedPdp @UnifiedExperience @StickyAddToBag @P2
  @tms:UTR-12162
  Scenario Outline: Sticky Add To Bag - Verify error message is thrown when product is added from sticky add to bag without choosing the sizes
    Given There are 5 normal size product item of locale <locale> and langCode <langCode> with inventory between 10 and 99999
    When I am on locale <locale> pdp page for product style product3#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
      And I get translation from lokalise for "SelectSizeError" and store it with key #SelectSizeError
      And I move to the bottom of the page
      And I click on ProductDetailPage.Pdp.StickyAddToBagButton
    Then I see ProductDetailPage.Pdp.SelectSizeErrorMessage with text #SelectSizeError is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @StickyAddToBag @P2
  @tms:UTR-12163
  Scenario Outline: Sticky Add To Bag - Verify Sticky add to bag is displayed when changing colours for combi product
    Given There is 1 multi colour product with at least 2 colours of locale <locale> with inventory between 10 and 99999
      And I extract product style from product product1#stylePartNumber with index 0 saved as #styleColourPartNumber
    When I am on locale <locale> pdp page for product style #styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
      And I move to the bottom of the page
    Then I see ProductDetailPage.Pdp.StickyAddToBagPanel is displayed
    When I scroll to the element ProductDetailPage.Pdp.ColorSwatchButton with index 2
      And I click on ProductDetailPage.Pdp.ColorSwatchButton with index 2
      And I move to the bottom of the page
    Then I see ProductDetailPage.Pdp.StickyAddToBagPanel is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PDP @TEE @UnifiedPdp @UnifiedExperience @StickyAddToBag @P2
  @tms:UTR-12164
  Scenario Outline: Sticky Add To Bag - Verify notify me flow from sticky add to bag for OOS normal size product
    Given There are 5 normal size product style of locale <locale> and langCode <langCode> where 1 size is out of stock with inventory between 5 and 9999
    When I am on locale <locale> pdp page for product style product3#styleColourPartNumber with accepted cookies
      And I get translation from lokalise for "NotifyMeButtonText" and store it with key #NotifyMe
      And I wait until the current page is loaded
      And I click on ProductDetailPage.Pdp.SizeSoldOutButton
    Then I see ProductDetailPage.Pdp.NotifyMeButton with text #NotifyMe is displayed
    When I move to the bottom of the page
    Then I see ProductDetailPage.Pdp.StickyAddToBagPanel is in viewport
      And I see ProductDetailPage.Pdp.StickyNotifyMeButton is displayed
    When I click on ProductDetailPage.Pdp.StickyNotifyMeButton
    Then I see ProductDetailPage.Pdp.NotifyMePopup is displayed
      And I type "notify@me.com" in the field ProductDetailPage.NotifyMePopup.EmailInput
      And I click on ProductDetailPage.NotifyMePopup.NotifyMeButton by js
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @StickyAddToBag @P2
  @tms:UTR-12165
  Scenario Outline: Sticky Add To Bag - Verify notify me flow from sticky add to bag for one size OOS product
    Given There is 1 one size product style of locale <locale> with inventory between 0 and 0 filtered by FH
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.NotifyMeButton is displayed
    When I move to the bottom of the page
    Then I see ProductDetailPage.Pdp.StickyAddToBagPanel is in viewport
      And I see ProductDetailPage.Pdp.StickyNotifyMeButton is displayed
    When I click on ProductDetailPage.Pdp.StickyNotifyMeButton
    Then I see ProductDetailPage.Pdp.NotifyMePopup is displayed
      And I type "notify@me.com" in the field ProductDetailPage.NotifyMePopup.EmailInput
      And I click on ProductDetailPage.NotifyMePopup.NotifyMeButton by js
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed

    Examples:
      | locale  |
      | default |
