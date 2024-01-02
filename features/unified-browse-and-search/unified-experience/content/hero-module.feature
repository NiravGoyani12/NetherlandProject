Feature: Unified Content - Hero Module

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedHeroModule @UnifiedExperience @Module @P1
  @tms:UTR-14296
  Scenario Outline: Unified Hero Module - Verify hero module template is shown along with content on women glp
    Given I am on locale <locale> <gender> glp page of langCode <langCode> with accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "hero-template"
    Then I wait until Experience.Content.TemplateBlock with data-testid "hero-template" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "hero-template"##1 is displayed
      # And I see Experience.Content.TemplateSubTitleByIndex with data-testid "hero-template"##1 is in viewport
   
    Examples:
      | locale  | langCode | gender |
      | default | default  | women  |
   
  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedHeroModule @UnifiedExperience @Module @P1
  @tms:UTR-14297
  Scenario Outline: Unified Hero Module - Verify hero module template is shown along with content on men glp
    Given I am on locale <locale> <gender> glp page of langCode <langCode> with accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "hero-template"
    Then I wait until Experience.Content.TemplateBlock with data-testid "hero-template" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "hero-template"##1 is displayed
      # And I see Experience.Content.TemplateSubTitleByIndex with data-testid "hero-template"##1 is in viewport
      
    Examples:
      | locale  | langCode | gender |
      | default | default  | men    |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedHeroModule @UnifiedExperience @Module @P1
  @tms:UTR-14298
  Scenario Outline: Unified Hero Module - Verify hero module template is shown along with content on kids glp
    Given I am on locale <locale> <gender> glp page of langCode <langCode> with accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "hero-template"
    Then I wait until Experience.Content.TemplateBlock with data-testid "hero-template" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "hero-template"##1 is displayed
      # And I see Experience.Content.TemplateSubTitleByIndex with data-testid "hero-template"##1 is in viewport
   
    Examples:
      | locale  | langCode | gender |
      | default | default  | kids   |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedHeroModule @UnifiedExperience @Module @P2
  @tms:UTR-15228
  Scenario Outline: Unified Hero Module - Verify hero module template is shown along with content and ctas redirectng to the associated page
    Given I am on locale <locale> of url /cms-debug?contentPageId=Automated-test-3 with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "hero-template"
    Then I wait until Experience.Content.TemplateBlock with data-testid "hero-template" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "hero-template"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "hero-template"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "hero-template","cta-pvh-button",1 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "hero-template","cta-pvh-button",1
    Then I wait until the current page is loaded
      And URL should contain "<href-1>"
      
    @ExcludeTH
    Examples:
      | locale | href-1                |
      | uk     | /womens-clothing-sale |

    @ExcludeCK
    Examples:
      | locale | href-1                |
      | uk     | /womens-clothing-sale |
  
  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedHeroModule @UnifiedExperience @Module @P3
  @tms:UTR-14514
  Scenario Outline: Unified Hero Module - Verify hero module template countdown timer more than 24 hours is shown
    Given I am on locale <locale> of url /cms-debug?contentPageId=Automated-test-2 with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "hero-template"
    Then I wait until Experience.Content.TemplateBlock with data-testid "hero-template" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "hero-template"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "hero-template"##1 is in viewport
      And I see Experience.Content.TemplateCounterHours with data-testid "hero-template" is displayed
      And I see Experience.Content.TemplateCounterHoursText with data-testid "hero-template" contains text "hr"
      And I see Experience.Content.TemplateCounterMinutes with data-testid "hero-template" is displayed
      And I see Experience.Content.TemplateCounterMinutesText with data-testid "hero-template" contains text "min"
      And I see Experience.Content.TemplateCounterSeconds with data-testid "hero-template" is displayed
      And I see Experience.Content.TemplateCounterSecondsText with data-testid "hero-template" contains text "sec"
    
    @ExcludeCK @ExcludeUat
    Examples:
      | locale | langCode | 
      | uk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedHeroModule @UnifiedExperience @Module @P3
  @tms:UTR-14515
  Scenario Outline: Unified Hero Module - Verify hero module template countdown timer less than 24 hours is shown
    Given I am on locale <locale> of url /cms-debug?contentPageId=Automated-test-2 with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "hero-template"
    Then I wait until Experience.Content.TemplateBlock with data-testid "hero-template" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "hero-template"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "hero-template"##1 is in viewport
      And I see Experience.Content.TemplateCounterHours with data-testid "hero-template" is displayed
      And I see Experience.Content.TemplateCounterHoursText with data-testid "hero-template" contains text "hr"
      And I see Experience.Content.TemplateCounterMinutes with data-testid "hero-template" is displayed
      And I see Experience.Content.TemplateCounterMinutesText with data-testid "hero-template" contains text "min"
      And I see Experience.Content.TemplateCounterSeconds with data-testid "hero-template" is displayed
      And I see Experience.Content.TemplateCounterSecondsText with data-testid "hero-template" contains text "sec"
   
    @ExcludeTH @ExcludeUat
    Examples:
      | locale | langCode | 
      | uk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedHeroModule @UnifiedExperience @Module @P3
  @tms:UTR-14516
  Scenario Outline: Unified Hero Module - Verify hero module template video behavior when the voice icon is muted and un-muted
    Given I am on locale <locale> of url /cms-debug?contentPageId=Automated-test-1 with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "hero-template"
    Then I wait until Experience.Content.TemplateBlock with data-testid "hero-template" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "hero-template"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "hero-template"##1 is in viewport
      And I see Experience.Content.TemplateButton with data-testid "hero-template","icon-utility-sound-off",2 is clickable
    When I click on Experience.Content.TemplateButton with data-testid "hero-template","icon-utility-sound-off",2
    Then I see Experience.Content.TemplateButton with data-testid "hero-template"##"icon-utility-sound-off"##2 is not displayed
     And I see Experience.Content.TemplateButton with data-testid "hero-template","icon-utility-sound-on",1 is clickable
    When I click on Experience.Content.TemplateButton with data-testid "hero-template","icon-utility-sound-on",1
    Then I see Experience.Content.TemplateButton with data-testid "hero-template"##"icon-utility-sound-on"##1 is not displayed
     And I see Experience.Content.TemplateButton with data-testid "hero-template","icon-utility-sound-off",2 is clickable 

    Examples:
      | locale | langCode | 
      | uk     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedHeroModule @UnifiedExperience @Module @P2
  @feature:DD-5554 
  @tms:UTR-17244
  Scenario Outline: Unified Hero Module - Verify hero module template image is clickable when only 1 CTA is configured
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "hero-template"
    Then I wait until Experience.Content.TemplateBlock with data-testid "hero-template" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "hero-template"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "hero-template"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "hero-template"##"cta-pvh-button"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "hero-template"##"VideoBackground-video"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "hero-template","LinkOverlay-component",1 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "hero-template","LinkOverlay-component",1
    Then I wait until the current page is loaded
      And URL should contain "<href-1>"
      
    @ExcludeTH
    Examples:
      | locale | url                                       | href-1          |
      | uk     | /cms-debug?contentPageId=Automated-test-1 |/mycalvins-women |
    
    @ExcludeCK
    Examples:
     | locale | url                                       | href-1            |
     | uk     | /cms-debug?contentPageId=Automated-test-1 |/boys-new-arrivals |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedHeroModule @UnifiedExperience @Module @P2
  @feature:DD-5554
  @tms:UTR-17245
  Scenario Outline: Unified Hero Module - Verify hero module template image is not clickable when more than 1 CTA is configured
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "hero-template"
    Then I wait until Experience.Content.TemplateBlock with data-testid "hero-template" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "hero-template"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "hero-template"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "hero-template"##"cta-pvh-button"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "hero-template"##"cta-pvh-button"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "hero-template"##"VideoBackground-video"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "hero-template"##"LinkOverlay-component"##2 is not displayed
      
    @ExcludeUat
    Examples:
      | locale | url                                       |
      | uk     | /cms-debug?contentPageId=Automated-test-1 |

  # @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedHeroModule @UnifiedExperience @Module @P3
  @feature:DD-5379
  @tms:UTR-17905
  Scenario Outline: Unified Hero Module - Verify hero module template hotspot click shows product info
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "hero-template",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "hero-template"##1 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "hero-template"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "hero-template"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "hero-template"##"poi-icon"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "hero-template"##"icon-utility-plus-svg"##1 is displayed
    When I click on Experience.Content.TemplateElement with data-testid "hero-template","icon-utility-plus-svg",1
    Then I see Experience.Content.TemplateElement with data-testid "hero-template"##"poi-panel"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "hero-template"##"PriceText"##1 is displayed
    When I click on Experience.Content.TemplateElement with data-testid "hero-template","icon-utility-plus-svg",1
    Then I see Experience.Content.TemplateElement with data-testid "hero-template"##"poi-panel"##1 is not displayed
      And I see Experience.Content.TemplateElement with data-testid "hero-template"##"PriceText"##1 is not displayed

      
   @ExcludeUat
    Examples:
      | locale | url                                       |
      | uk     | /cms-debug?contentPageId=Automated-test-3 |