Feature: Unified Content - SEO Module

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSeotModule @UnifiedExperience @Module @P1
  @tms:UTR-15746
  Scenario Outline: Unified Seo Module - Verify seo module template is shown along with content
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "seo-module-component",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "seo-module-component"##1 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "seo-module-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "seo-module-component"##"truncated-text-content"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "seo-module-component","toggle-text-expand-button",1 is clickable
      And I see Experience.Content.TemplateElement with data-testid "seo-module-component","toggle-text-expand-button",1 contains text "Read more"
    When I click on Experience.Content.TemplateElement with data-testid "seo-module-component","toggle-text-expand-button",1
    Then I see Experience.Content.TemplateElement with data-testid "seo-module-component","toggle-text-expand-button",1 contains text "Read less"
      And I see Experience.Content.TemplateElement with data-testid "seo-module-component","toggle-text-expand-button",1 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "seo-module-component","toggle-text-expand-button",1
    Then I see Experience.Content.TemplateElement with data-testid "seo-module-component","toggle-text-expand-button",1 contains text "Read more" 
                                                      
    Examples:
      | locale  | langCode | 
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSeotModule @UnifiedExperience @Module @P2
  @tms:UTR-15748
  Scenario Outline: Unified Seo Module - Verify seo module template hyperlinks in seo text navigates to corresponding pages
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "seo-module-component",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "seo-module-component"##1 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "seo-module-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "seo-module-component"##"truncated-text-content"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "seo-module-component","toggle-text-expand-button",1 contains text "Read more"
    When I click on Experience.Content.TemplateElement with data-testid "seo-module-component","toggle-text-expand-button",1
    Then I see Experience.Content.TemplateElement with data-testid "seo-module-component","toggle-text-expand-button",1 contains text "Read less"
      And I see Experience.Content.TemplateCTAByIndex with data-testid "seo-module-component"##<href-1>##1 is displayed
    When I click on Experience.Content.TemplateCTAByIndex with data-testid "seo-module-component",<href-1>,1
    Then I wait until the current page is loaded
      And URL should contain "<href-1>"
                                                          
    @ExcludeCK
    Examples:
      | locale | langCode | href-1                |
      | uk     | default  | /men                  |
      | uk     | default  | /women                |
      | uk     | default  | /womens-coats-jackets |

    @ExcludeTH @ExcludeUat
    Examples:
      | locale | langCode | href-1          |
      | uk     | default  | /mens-underwear |
      | uk     | default  | /mens-jeans     |
      | uk     | default  | /womens-clothes |

    @ExcludeTH @ExcludeDB0
    Examples:
      | locale | langCode | href-1         |
      | uk     | default  | /underwear     |
      | uk     | default  | /mens-jeans    |
      | uk     | default  | /mens-clothing |