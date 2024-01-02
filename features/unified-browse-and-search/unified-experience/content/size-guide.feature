Feature: Size-Guide Page

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @SizeGuide @ContentCheck @UnifiedContent @UnifiedExperience @Size-Guide @UnifiedExperience @P3
  @tms:UTR-14146
  Scenario Outline: Unified Size-Guide - Verify size-guide page is shown along with content CK
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page size-guide
    When I wait until Experience.SizeGuide.SizeGuideLinks with href <href-women> is clickable
    Then I see Experience.SizeGuide.SizeGuideLinks with href <href-unisex> is displayed
      And I see Experience.SizeGuide.SizeGuideLinks with href <href-women> is displayed
      And I see Experience.SizeGuide.SizeGuideLinks with href <href-men> is displayed
      And I see Experience.SizeGuide.SizeGuideLinks with href <href-kids> is displayed
      And the count of displayed elements Experience.Content.TemplateImageByIndex with data-testid "lazy-image-container" is greater than 0

    @ExcludeTH
    Examples:
      | locale | langCode | href-unisex                   | href-women        | href-men        | href-kids       |
      | uk     | default  | underwear-swimwear-size-guide | womens-size-guide | mens-size-guide | kids-size-guide |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @SizeGuide @ContentCheck @UnifiedContent @UnifiedExperience @Size-Guide @UnifiedExperience @P3
  @tms:UTR-14146 @issue:DD-5672
  Scenario Outline: Unified Size-Guide - Verify size-guide page is shown along with content TH
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page size-guide
    When I wait until Experience.SizeGuide.SizeGuideLinksTH with href <href-women> is clickable
      And I see Experience.SizeGuide.SizeGuideLinksTH with href <href-women> is displayed
      And I see Experience.SizeGuide.SizeGuideLinksTH with href <href-men> is displayed
      And I see Experience.SizeGuide.SizeGuideLinksTH with href <href-kids> is displayed

    @ExcludeCK
    Examples:
      | locale | langCode | href-women         | href-men         | href-kids            |
      | uk     | default  | /womens-size-guide | /mens-size-guide | /children-size-guide |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @SizeGuide @ContentCheck @UnifiedContent @UnifiedExperience @Size-Guide @UnifiedExperience @P3
  @tms:UTR-14149
  Scenario Outline: Unified Size-Guide - Verify women size-guide table is shown along with content CK
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page size-guide
    When I wait until Experience.SizeGuide.SizeGuideLinks with href <href-women> is clickable
    Then I see Experience.SizeGuide.SizeGuideLinks with href <href-women> is displayed
      And I click on Experience.SizeGuide.SizeGuideLinks with href <href-women>
      And I wait until Experience.SizeGuide.WomenSizeGuidePageTitle is clickable
      And I wait until Experience.SizeGuide.WomenSizeGuideTables is displayed
      And I see Experience.SizeGuide.SizeGuideTableToggleByIndex with index 1 is displayed
      And I see Experience.SizeGuide.SizeGuideTableMetricUnits with index 1 is displayed
      And I see Experience.SizeGuide.SizeGuideTableMetricUnits with index 2 is displayed
    When I click on Experience.SizeGuide.SizeGuideTableToggleByIndex with index 1
    Then I see Experience.SizeGuide.SizeGuideTableImperialUnits with index 1 is displayed
      And I see Experience.SizeGuide.SizeGuideTableMetricUnits with index 1 is displayed
    When I click on Experience.SizeGuide.SizeGuideTableToggleByIndex with index 2
    Then I see Experience.SizeGuide.SizeGuideTableImperialUnits with index 1 is displayed
      And I see Experience.SizeGuide.SizeGuideTableImperialUnits with index 2 is displayed

    @ExcludeTH
    Examples:
      | locale | langCode | href-women        |
      | uk     | default  | womens-size-guide |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @SizeGuide @ContentCheck @UnifiedContent @UnifiedExperience @Size-Guide @UnifiedExperience @P3
  @tms:UTR-14149 @issue:DD-5672
  Scenario Outline: Unified Size-Guide - Verify women/men/kids size-guide table is shown along with content TH
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page size-guide
    When I wait until Experience.SizeGuide.SizeGuideLinksTH with href <href-women> is clickable
    Then I see Experience.SizeGuide.SizeGuideLinksTH with href <href-women> is displayed
      And I click on Experience.SizeGuide.SizeGuideLinksTH with href <href-women>
      And I wait until Experience.SizeGuide.WomenSizeGuidePageTitleTH is clickable
      And I wait until Experience.SizeGuide.WomenSizeGuideTablesTH is displayed
      And I see Experience.SizeGuide.SizeGuideTableToggleByIndexTH with index 1 is displayed
      And I navigate to page size-guide
    When I wait until Experience.SizeGuide.SizeGuideLinksTH with href <href-men> is clickable
    Then I see Experience.SizeGuide.SizeGuideLinksTH with href <href-men> is displayed
      And I click on Experience.SizeGuide.SizeGuideLinksTH with href <href-men>
      And I wait until Experience.SizeGuide.WomenSizeGuidePageTitleTH is clickable
      And I wait until Experience.SizeGuide.WomenSizeGuideTablesTH is displayed
      And I see Experience.SizeGuide.SizeGuideTableToggleByIndexTH with index 1 is displayed
      And I navigate to page size-guide
    When I wait until Experience.SizeGuide.SizeGuideLinksTH with href <href-kids> is clickable
    Then I see Experience.SizeGuide.SizeGuideLinksTH with href <href-kids> is displayed
      And I click on Experience.SizeGuide.SizeGuideLinksTH with href <href-kids>
      And I wait until Experience.SizeGuide.WomenSizeGuidePageTitleTH is clickable
      And I wait until Experience.SizeGuide.WomenSizeGuideTablesTH is displayed
      And I see Experience.SizeGuide.SizeGuideTableToggleByIndexTH with index 1 is displayed

    @ExcludeCK
    Examples:
      | locale | langCode | href-women         | href-men         | href-kids            |
      | uk     | default  | /womens-size-guide | /mens-size-guide | /children-size-guide |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @SizeGuide @ContentCheck @UnifiedContent @UnifiedExperience @Size-Guide @UnifiedExperience @P3
  @tms:UTR-14189
  Scenario Outline: Unified Size-Guide - Verify in desktop underwear and swimwear sizeguide table prevcup and nextcup behaviour CK
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I navigate to page size-guide
      And I wait until Experience.Content.TemplateBlock with data-testid "lazy-image-container",2 is clickable
      And I see Experience.SizeGuide.SizeGuideLinks with href <href-women> is displayed
    When I click on Experience.SizeGuide.SizeGuideLinks with href <href-underwear>
      And I wait for 2 seconds
    Then I click on Experience.SizeGuide.SizeGuideTableNextIcon
      And I wait for 2 seconds
      And I see Experience.SizeGuide.SizeGuideTableValueByColumn with index 12 contains text "32B"

   @ExcludeTH
   Examples:
      | locale | langCode | href-women        | href-underwear                |
      | uk     | default  | womens-size-guide | underwear-swimwear-size-guide |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @SizeGuide @ContentCheck @UnifiedContent @UnifiedExperience @Size-Guide @UnifiedExperience @P3
  @tms:UTR-14190
  Scenario Outline: Unified Size-Guide - Verify how to measure myself behaviour CK
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page size-guide
      And I wait until Experience.SizeGuide.SizeGuideLinks with href <href-women> is clickable
    When I click on Experience.SizeGuide.SizeGuideLinks with href <href-women>
    Then I wait until Experience.SizeGuide.SizeGuideHowToMeasureMySelfButton is clickable
      And I scroll to the element Experience.SizeGuide.SizeGuideHowToMeasureMySelfButton
    When I click on Experience.SizeGuide.SizeGuideHowToMeasureMySelfButton
    Then I see Experience.SizeGuide.SizeGuideHowToMeasureMySelfModal is displayed
      And I see Experience.SizeGuide.SizeGuideHowToMeasureModalImage is displayed
    When I click on Experience.SizeGuide.SizeGuideHowToMeasureCloseButton
    Then I see Experience.SizeGuide.SizeGuideHowToMeasureMySelfModal is not displayed

   @ExcludeTH
   Examples:
      | locale | langCode | href-women        |
      | uk     | default  | womens-size-guide |