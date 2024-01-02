Feature: Unified Content - Promo Module

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedPromoModule @UnifiedExperience @Module @P1
  @tms:UTR-14735
  Scenario Outline: Unified Promo Module - Verify promo module template is shown along with content and the promo code can be copied to clipboard
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "Promo-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "Promo-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "Promo-component"##"Promo-subtitle"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "Promo-component"##"PromoCode-code" is displayed
      And I see Experience.Content.PromoCodeCopyButton with text "copy" is displayed
      And I see Experience.Content.PromoCodeCopyButton is clickable
    When I click on Experience.Content.PromoCodeCopyButton
    Then I see Experience.Content.PromoCodeCopyButton with text "copied" is displayed
     And I see Experience.Content.CopySuccessNotification with text "Copied to clipboard:" is displayed
              
    @ExcludeTH
    Examples:
      | locale | url                                       |
      | uk     | cms-debug?contentPageId=Automated-test-2  |
    
    @ExcludeCK
    Examples:
      | locale | url                                       |
      | uk     | cms-debug?contentPageId=Automated-test-1  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedPromoModule @UnifiedExperience @Module @P3
  @tms:UTR-14736
  Scenario Outline: Unified Promo Module - Verify Promo module template countdown timer more than 24 hours is shown
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "Promo-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "Promo-component"##1 is in viewport
      And I see Experience.Content.TemplateCounterHours with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateCounterHoursText with data-testid "Promo-component" contains text "hr"
      And I see Experience.Content.TemplateCounterMinutes with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateCounterMinutesText with data-testid "Promo-component" contains text "min"
      And I see Experience.Content.TemplateCounterSeconds with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateCounterSecondsText with data-testid "Promo-component" contains text "sec"
      And I see Experience.Content.TemplateButtonLink with data-testid "Promo-component",<href-1> is clickable
    When I click on Experience.Content.TemplateButtonLink with data-testid "Promo-component",<href-1>
    Then I wait until the current page is loaded
      And URL should contain "<href-1>"
    
    @ExcludeTH
    Examples:
      | locale | url                                       | href-1               |
      | uk     | cms-debug?contentPageId=Automated-test-1  | /womens-socks-tights |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedPromoModule @UnifiedExperience @Module @P3
  @tms:UTR-14737
  Scenario Outline: Unified Promo Module - Verify Promo module template countdown timer less than 24 hours is shown
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "Promo-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "Promo-component"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "Promo-component"##"Promo-subtitle"##1 is in viewport
      And I see Experience.Content.TemplateCounterHours with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateCounterHoursText with data-testid "Promo-component" contains text "hr"
      And I see Experience.Content.TemplateCounterMinutes with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateCounterMinutesText with data-testid "Promo-component" contains text "min"
      And I see Experience.Content.TemplateCounterSeconds with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateCounterSecondsText with data-testid "Promo-component" contains text "sec"
      And I see Experience.Content.TemplateButtonLink with data-testid "Promo-component",<href-1> is clickable
    When I click on Experience.Content.TemplateButtonLink with data-testid "Promo-component",<href-1>
    Then I wait until the current page is loaded
      And URL should contain "<href-1>"
    
    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                       | href-1 |
      | uk     | cms-debug?contentPageId=Automated-test-2  | /men   |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedPromoModule @UnifiedExperience @Module @P3
  @tms:UTR-14777
  Scenario Outline: Unified Promo Module - verify Promo module with countdown timer with title and no button variation
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "Promo-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "Promo-component"##1 is in viewport
      And I see Experience.Content.TemplateCounterHours with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateCounterHoursText with data-testid "Promo-component" contains text "hr"
      And I see Experience.Content.TemplateCounterMinutes with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateCounterMinutesText with data-testid "Promo-component" contains text "min"
      And I see Experience.Content.TemplateCounterSeconds with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateCounterSecondsText with data-testid "Promo-component" contains text "sec"
    
    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                       |
      | uk     | cms-debug?contentPageId=Automated-test-3  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedPromoModule @UnifiedExperience @Module @P3
  @tms:UTR-14778
  Scenario Outline: Unified Promo Module - verify Promo module with countdown timer with brand logo, title and no button variation
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "Promo-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateElement with data-testid "Promo-component"##"Promo-brand-logo"##1 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "Promo-component"##1 is in viewport
      And I see Experience.Content.TemplateCounterHours with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateCounterHoursText with data-testid "Promo-component" contains text "hr"
      And I see Experience.Content.TemplateCounterMinutes with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateCounterMinutesText with data-testid "Promo-component" contains text "min"
      And I see Experience.Content.TemplateCounterSeconds with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateCounterSecondsText with data-testid "Promo-component" contains text "sec"
    
    @ExcludeCK
    Examples:
      | locale | url                                       |
      | uk     | cms-debug?contentPageId=Automated-test-4  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedPromoModule @UnifiedExperience @Module @P3
  @tms:UTR-14779
  Scenario Outline: Unified Promo Module - verify Promo module with countdown timer with brand logo, title and 2 buttons variation
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "Promo-component",2
    Then I wait until Experience.Content.TemplateBlock with data-testid "Promo-component"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "Promo-component"##"Promo-brand-logo"##2 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "Promo-component"##2 is in viewport
      And I see Experience.Content.TemplateCounterHours with data-testid "Promo-component"##2 is displayed
      And I see Experience.Content.TemplateCounterHoursText with data-testid "Promo-component",2 contains text "hr"
      And I see Experience.Content.TemplateCounterMinutes with data-testid "Promo-component"##2 is displayed
      And I see Experience.Content.TemplateCounterMinutesText with data-testid "Promo-component",2 contains text "min"
      And I see Experience.Content.TemplateCounterSeconds with data-testid "Promo-component"##2 is displayed
      And I see Experience.Content.TemplateCounterSecondsText with data-testid "Promo-component",2 contains text "sec"
    And I see Experience.Content.TemplateButtonLink with data-testid "Promo-component",<href-1> is clickable
    When I click on Experience.Content.TemplateButtonLink with data-testid "Promo-component",<href-1>
    Then I wait until the current page is loaded
      And URL should contain "<href-1>"
      And I navigate back in the browser
      And I wait until the current page is loaded 
    And I see Experience.Content.TemplateButtonLink with data-testid "Promo-component",<href-2> is clickable
    When I click on Experience.Content.TemplateButtonLink with data-testid "Promo-component",<href-2>
    Then I wait until the current page is loaded
      And URL should contain "<href-2>"

    @ExcludeCK
    Examples:
      | locale | url                                       | href-1       | href-2 |
      | uk     | cms-debug?contentPageId=Automated-test-4  | /womens-bags | /men   |