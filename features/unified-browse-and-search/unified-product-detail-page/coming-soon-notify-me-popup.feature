Feature: Unified PDP - Coming soon Popup

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @ComingSoonPopup @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-12965
  Scenario Outline: Coming soon product - I should see all sizes coming soon
    Given I am on locale <locale> pdp page of langCode <langCode> for product style WW0WW401600G9/J20J221345BEH with accepted cookies
      And I wait until the current page is loaded
      And I get translation from lokalise for "ComingSoonText" and store it with key #<ComingSoonText>
      And I see ProductDetailPage.Pdp.ProductLabel with text #<ComingSoonText> is displayed
    When in unified PDP I select the oos size and save as #size
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.NotifyMePopup.Title with text #<ComingSoonText> is displayed in 3 seconds
    When I type "notify@me.com" in the field ProductDetailPage.NotifyMePopup.EmailInput
      And I click on ProductDetailPage.NotifyMePopup.NotifyMeButton by js
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @ComingSoonPopup @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-12966
  Scenario Outline: Coming soon product - In a multi colored product I should see one color is coming soon
    Given I am on locale <locale> pdp page of langCode <langCode> for product style WW0WW401600G9/J20J221345BEH with accepted cookies
      And I wait until the current page is loaded
      And I get translation from lokalise for "ComingSoonText" and store it with key #<ComingSoonText>
      And I see ProductDetailPage.Pdp.ProductLabel with text #<ComingSoonText> is displayed
    When I click on ProductDetailPage.Pdp.ColorSwatchButton with index 2
    Then I see ProductDetailPage.Pdp.ProductLabel with text #<ComingSoonText> is not displayed
    When I click on ProductDetailPage.Pdp.ColorSwatchButton with index 1
      And in unified PDP I select the oos size and save as #size
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.NotifyMePopup.Title with text #<ComingSoonText> is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @ComingSoonPopup @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-12967 @ExcludeCK
  Scenario Outline: Coming soon product - I should see one size is coming soon
    Given I am on locale <locale> pdp page of langCode <langCode> for product style FW0FW07427YBS with forced accepted cookies
      And I wait until the current page is loaded
      And I get translation from lokalise for "ComingSoonText" and store it with key #<ComingSoonText>
      And I fetch size name of product item <skuPartNumber> saved as #sizeName
    When I click on ProductDetailPage.Pdp.SizeSoldOutButton with value #sizeName
    Then I see ProductDetailPage.Pdp.ProductLabel with text #<ComingSoonText> is displayed
    When I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.NotifyMePopup.Title with text #<ComingSoonText> is displayed

    Examples:
      | locale  | langCode | skuPartNumber |
      | default | default  | 8720644286968 |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @ComingSoonPopup @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-12967 @ExcludeTH
  Scenario Outline: Coming soon product - I should see one size is coming soon
    Given I am on locale <locale> pdp page of langCode <langCode> for product style J20J221461SFX with forced accepted cookies
      And I wait until the current page is loaded
      And I get translation from lokalise for "ComingSoonText" and store it with key #<ComingSoonText>
      And I fetch size name of product item <skuPartNumber> saved as #sizeName
    When I click on ProductDetailPage.Pdp.SizeSoldOutButton with value #sizeName
    Then I see ProductDetailPage.Pdp.ProductLabel with text #<ComingSoonText> is displayed
    When I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.NotifyMePopup.Title with text #<ComingSoonText> is displayed

    Examples:
      | locale  | langCode | skuPartNumber |
      | default | default  | 8720108112109 |