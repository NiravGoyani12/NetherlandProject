Feature: Unified Content - Smart Card Module

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSmartCardModule @UnifiedExperience @Module @P2
  @tms:UTR-15469
  Scenario Outline: Unified Smart Card Module - Verify smart card module template is shown along with content
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "smart-cards"
    Then I wait until Experience.Content.TemplateBlock with data-testid "smart-cards" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "smart-cards"##"smart-cards-title-text"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "smart-cards"##"Grid-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "smart-cards"##"smart-cards-card"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "smart-cards"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "smart-cards"##"smart-cards-card-title-text-0" is displayed
    When I hover over Experience.Content.TemplateElement with data-testid "smart-cards","ResponsiveImage-component",1
    Then I see Experience.Content.TemplateElement with data-testid "smart-cards"##"smart-cards-card-arrow-icon-0" is displayed
      And I see Experience.Content.TemplateElement with data-testid "smart-cards"##"smart-cards-card"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "smart-cards"##"ResponsiveImage-component"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "smart-cards"##"smart-cards-card-title-text-1" is displayed
    When I hover over Experience.Content.TemplateElement with data-testid "smart-cards","ResponsiveImage-component",2
    Then I see Experience.Content.TemplateElement with data-testid "smart-cards"##"smart-cards-card-arrow-icon-1" is displayed
      And I see Experience.Content.TemplateElement with data-testid "smart-cards"##"smart-cards-card"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "smart-cards"##"ResponsiveImage-component"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "smart-cards"##"smart-cards-card-title-text-2" is displayed
    When I hover over Experience.Content.TemplateElement with data-testid "smart-cards","ResponsiveImage-component",3
    Then I see Experience.Content.TemplateElement with data-testid "smart-cards"##"smart-cards-card-arrow-icon-2" is displayed
                                          
    @ExcludeTH
    Examples:
      | locale | url                                       |
      | uk     | cms-debug?contentPageId=Automated-test-1  |

    @ExcludeCK
    Examples:
      | locale | url                                      |
      | uk     | cms-debug?contentPageId=Automated-test-1 |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSmartCardModule @UnifiedExperience @Module @P3
  @tms:UTR-15470
  Scenario Outline: Unified Smart Card Module - Verify smart card module when click on the smart card it redirects to the respective PLP page
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "smart-cards"
    Then I wait until Experience.Content.TemplateBlock with data-testid "smart-cards" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "smart-cards"##"smart-cards-title-text"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "smart-cards"##"Grid-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "smart-cards"##"smart-cards-card"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "smart-cards","ResponsiveImage-component",1 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "smart-cards","ResponsiveImage-component",1
    Then I wait for 2 seconds
      And URL should contain "<href-1>"
      And I navigate back in the browser
      And I wait until the current page is loaded
      And I see Experience.Content.TemplateElement with data-testid "smart-cards"##"smart-cards-card"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "smart-cards","ResponsiveImage-component",2 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "smart-cards","ResponsiveImage-component",2
    Then I wait for 2 seconds
      And URL should contain "<href-2>"
      And I navigate back in the browser
      And I wait until the current page is loaded
      And I see Experience.Content.TemplateElement with data-testid "smart-cards"##"smart-cards-card"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "smart-cards","ResponsiveImage-component",3 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "smart-cards","ResponsiveImage-component",3
    Then I wait for 2 seconds
      And URL should contain "<href-3>"
                                               
    @ExcludeTH
    Examples:
      | locale | url                                       | href-1                     | href-2         | href-3           |
      | uk     | cms-debug?contentPageId=Automated-test-1  | /mens-special-collection-1 | /ck-1996-women | /partywear-women |

    @ExcludeCK
    Examples:
      | locale | url                                       | href-1               |  href-2        | href-3              |
      | uk     | cms-debug?contentPageId=Automated-test-1  | /womens-trench-coats | /womens-basics |/clothing-for-curves |