Feature: Unified Content - Splash Module

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSplashModule @UnifiedExperience @Module
  @tms:UTR-14649
  Scenario Outline: Unified Splash Module - Verify splash module template is shown along with content with Image as a background and with Side bar on home page CK
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I scroll to the element Experience.Content.TemplateBlock with data-testid "Splash-module",1
    When I wait until Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is displayed
    Then I see Experience.Content.TemplateImageByIndex with data-testid "Splash-module"##1 is displayed
    #   And I see Experience.Content.TemplateBlock with data-testid "Splash-module"##2 is displayed
    #   And I see Experience.Content.TemplateTitleByIndex with data-testid "Splash-module"##1 is displayed
    # When I scroll to the element Experience.Content.TemplateSubTitleByIndex with data-testid "Splash-module",1
    # Then I see Experience.Content.TemplateSubTitleByIndex with data-testid "Splash-module"##1 is in viewport
    
    @ExcludeTH @P1
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSplashModule @UnifiedExperience @Module
  @tms:UTR-15898
  Scenario Outline: Unified Splash Module - Verify splash module template is shown along with content with Image as a background and with Side bar on home page TH
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I scroll to the element Experience.Content.TemplateBlock with data-testid "Splash-module",1
    When I wait until Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is displayed
    Then I see Experience.Content.TemplateImageByIndex with data-testid "Splash-module"##1 is displayed
      # And I see Experience.Content.TemplateBlock with data-testid "Splash-module"##2 is displayed
    #   And I see Experience.Content.TemplateTitleByIndex with data-testid "Splash-module"##1 is displayed
    # When I scroll to the element Experience.Content.TemplateSubTitleByIndex with data-testid "Splash-module",1
    # Then I see Experience.Content.TemplateSubTitleByIndex with data-testid "Splash-module"##1 is in viewport
    
    @P1
    Examples:
      | locale  | langCode |
      | default | default  |
  
      
  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSplashModule @UnifiedExperience @Module
  @tms:UTR-14650
  Scenario Outline: Unified Splash Module - Verify splash module template CTAs are shown and navigates to correct pages
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I scroll to the element Experience.Content.TemplateBlock with data-testid "Splash-module",1
    When I wait until Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is displayed
    Then I see Experience.Content.TemplateImageByIndex with data-testid "Splash-module"##1 is displayed
      # And I see Experience.Content.TemplateBlock with data-testid "Splash-module"##2 is displayed
      And I see Experience.Content.TemplateButtonLink with data-testid "Splash-module",<href-1> is clickable
    When I click on Experience.Content.TemplateButtonLink with data-testid "Splash-module",<href-1>
    Then I wait until the current page is loaded
      And URL should contain "<href-1>"
        
    @P1 @ExcludeCK
    Examples:
      | locale | langCode | href-1     |
      | uk     | default  | women      |
      | uk     | default  | men        |
      | uk     | default  | kids       |

    @P1 @ExcludeTH
    Examples:
      | locale | langCode | href-1     |
      | uk     | default  | women      |
      | uk     | default  | men        |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSplashModule @UnifiedExperience @Module @P3
  @tms:UTR-14651
  Scenario Outline: Unified Splash Module - Verify Splash Module displays the Countdown component in the side bar with days, hours and mins when the countdown is greater than 24 hours 
    Given I am on locale <locale> of url /cms-debug?contentPageId=Automated-test-1 with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "Splash-module",2
    Then I wait until Experience.Content.TemplateBlock with data-testid "Splash-module"##2 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "Splash-module"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "Splash-module"##1 is in viewport
      And I see Experience.Content.TemplateCounterDays with data-testid "Splash-module" is displayed
      And I see Experience.Content.TemplateCounterDaysText with data-testid "Splash-module" contains text "days"
      And I see Experience.Content.TemplateCounterHours with data-testid "Splash-module" is displayed
      And I see Experience.Content.TemplateCounterHoursText with data-testid "Splash-module" contains text "hr"
      And I see Experience.Content.TemplateCounterMinutes with data-testid "Splash-module" is displayed
      And I see Experience.Content.TemplateCounterMinutesText with data-testid "Splash-module" contains text "min"
         
    Examples:
      | locale | langCode | 
      | uk     | default  |