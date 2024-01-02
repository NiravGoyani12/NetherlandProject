Feature: Unified PDP - Gift cards

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @GiftCards @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-17115 @ExcludeUat
  Scenario Outline: Gift cards - Verify product image, details and accordions are displayed on the gift card page
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I navigate to page giftcard-pdp
      And I am a guest user
      And I wait until the current page is loaded
    Then I see ProductDetailPage.GiftCardsPage.BackgroundImage is displayed
      And I see the attribute src of element ProductDetailPage.GiftCardsPage.BackgroundImage containing "<imgSrc>"
      And I see ProductDetailPage.GiftCardsPage.GiftCardName is displayed
      And I see ProductDetailPage.GiftCardsPage.FromProductPrice is displayed
      And I see ProductDetailPage.GiftCardsPage.VatInfo is displayed
      And I see ProductDetailPage.GiftCardsPage.DetailsAccordion is displayed
      And I see ProductDetailPage.GiftCardsPage.WhereToRedeemAccordion is displayed
      And I see ProductDetailPage.GiftCardsPage.NeedAssistanceAccordion is displayed
      And I see the attribute class of element ProductDetailPage.GiftCardsPage.DetailsAccordion containing "Accordion_expanded"
      And I see the attribute class of element ProductDetailPage.GiftCardsPage.WhereToRedeemAccordion containing "Accordion_collapsed"
      And I see the attribute class of element ProductDetailPage.GiftCardsPage.NeedAssistanceAccordion containing "Accordion_collapsed"
    When I click on ProductDetailPage.GiftCardsPage.DetailsAccordionButton
    Then I see the attribute class of element ProductDetailPage.GiftCardsPage.DetailsAccordion containing "Accordion_collapsed"
      And I see ProductDetailPage.GiftCardsPage.GiftCardsUsp is displayed

    @ExcludeCK
    Examples:
      | locale | langCode | imgSrc           |
      | dk     | default  | gift-card-TH.png |

    @ExcludeTH
    Examples:
      | locale | langCode | imgSrc           |
      | dk     | default  | gift-card-CK.png |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @GiftCards @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-17116 @ExcludeUat
  Scenario Outline: Gift card prices - verify gift card prices can selected and deselected
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I navigate to page giftcard-pdp
      And I am a guest user
      And I get translation from lokalise for "GiftCardPriceSelectLabel" and store it with key #PriceSelectLabel
      And I wait until the current page is loaded
    Then I see ProductDetailPage.GiftCardsPage.PriceSelectLabel with text #PriceSelectLabel is displayed
      And I see the attribute class of element ProductDetailPage.GiftCardsPage.PriceSelectorButton not containing "PriceSelected"
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
    Then I see the attribute class of element ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1 containing "PriceSelected"
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 2
    Then I see the attribute class of element ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1 not containing "PriceSelected"
      And I see the attribute class of element ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 2 containing "PriceSelected"

    Examples:
      | locale | langCode |
      | dk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @GiftCards @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-17118 @ExcludeUat
  Scenario Outline: Gift card prices - verify gift card can be added to shopping bag by choosing the price
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page giftcard-pdp
      And I am a guest user
      And I get translation from lokalise for "GiftCardPriceSelectError" and store it with key #GiftCardPriceSelectError
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.GiftCardsPage.GiftCardPriceSelectErrorMessage with text #GiftCardPriceSelectError is displayed
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Pdp.AddedtoBagPopup is displayed in 5 seconds
      And I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 2
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 2 is displayed

    Examples:
      | locale | langCode |
      | dk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @GiftCards @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-17371 @ExcludeUat
  Scenario Outline: Gift cards - verify gift card can be added to shopping bag and can be checked out
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page giftcard-pdp
      And I am a logged in user
      And I wait until the current page is loaded
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter is displayed
    When I click on ProductDetailPage.GiftCardsPage.CheckoutButton
    Then URL should contain "checkout/shipping" in 10 seconds

    Examples:
      | locale | langCode |
      | dk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @GiftCards @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-17372 @ExcludeUat
  Scenario Outline: Gift cards - verify error message is thrown when the gift card value is above specified limit for each locale
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page giftcard-pdp
      And I am a guest user
      And I wait until the current page is loaded
      And I get translation from lokalise for "OverTheLimitGiftCardError" and store it with key #overTheLimitGiftCardError
    When I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 7
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 4 is displayed
    When I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
    Then I see ProductDetailPage.GiftCardsPage.GiftCardOverLimitError with text #overTheLimitGiftCardError is displayed

    Examples:
      | locale | langCode |
      | be     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @GiftCards @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-17969 @ExcludeUat
  Scenario Outline: Gift cards - verify coming soon popup is displayed on a gift card page and frrom price is displayed on the popup when no price selected
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I navigate to page giftcard-pdp
      And I get translation from lokalise for "ComingSoonText" and store it with key #<ComingSoonText>
      And I wait until the current page is loaded
      And I extract xcomreg IS_GIFT_CARD_COMING_SOON saved as #giftCardComingSoonToggle
      And I store the value of ProductDetailPage.GiftCardsPage.FromProductPrice with key #DisplayPrice
    Then I see the stored value with key #giftCardComingSoonToggle is equal to "True"
      And I see ProductDetailPage.GiftCardsPage.GiftCardNotifyMeButton is displayed
    When I click on ProductDetailPage.GiftCardsPage.GiftCardNotifyMeButton
    Then I see ProductDetailPage.GiftCardsPage.GiftCardComingSoonPopup is displayed
      And I see ProductDetailPage.NotifyMePopup.Title with text #<ComingSoonText> is displayed in 3 seconds
      And I see ProductDetailPage.GiftCardsPage.ComingSoonPopupFromDisplayPrice contains text "#DisplayPrice"
    When I type "notify@me.com" in the field ProductDetailPage.NotifyMePopup.EmailInput
      And I click on ProductDetailPage.NotifyMePopup.NotifyMeButton
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed

    Examples:
      | locale | langCode |
      | pl     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @GiftCards @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-18753 @ExcludeUat
  Scenario Outline: Gift cards - verify the selected price is displayed on the giftcard coming soon popup
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I get translation from lokalise for "ComingSoonText" and store it with key #<ComingSoonText>
      And I extract xcomreg IS_GIFT_CARD_COMING_SOON saved as #giftCardComingSoonToggle
      And I see the stored value with key #giftCardComingSoonToggle is equal to "True"
    When I navigate to page giftcard-pdp
      And I wait until the current page is loaded
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      And I store the value of ProductDetailPage.GiftCardsPage.ProductPrice with key #DisplayPrice
      And I see ProductDetailPage.GiftCardsPage.GiftCardNotifyMeButton is displayed
    When I click on ProductDetailPage.GiftCardsPage.GiftCardNotifyMeButton
    Then I see ProductDetailPage.GiftCardsPage.GiftCardComingSoonPopup is displayed
      And I see ProductDetailPage.GiftCardsPage.ComingSoonPopupDisplayPrice contains text "#DisplayPrice"

    Examples:
      | locale | langCode |
      | pl     | default  |