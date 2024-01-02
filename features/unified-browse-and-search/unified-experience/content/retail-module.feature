Feature: Unified Content - Retail Module

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedRetailModule @UnifiedExperience @Module @P2
  @feature:DD-5560
  @tms:UTR-18015
  Scenario Outline: Unified Retail Module - Verify retail module template is shown along with content
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateTitleByIndex with data-testid "RetailModule-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "RetailModule-component" is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "RetailModule-component" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "RetailModule-component" contains text "<text-1>"
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "RetailModule-component" is in viewport
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "RetailModule-component" contains text "<text-2>"
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component"##"RetailModule-list"##1 is displayed
      And I see the count of elements Experience.Content.TemplateElement with data-testid "RetailModule-component","RetailModule-item" is equal to <count>
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component"##"RetailModule-item"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component"##"typography-div"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component","typography-div",1 contains text "<text-3>"
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component"##"Address-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component"##"address-line"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component","address-line",1 contains text "<text-4>"
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component"##"address-line"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component","address-line",2 contains text "<text-5>"
      And I see Experience.Content.RetailModuleMapLinkByIndex with href <href>,1 is clickable
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component"##"RetailModule-item"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component"##"typography-div"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component","typography-div",2 contains text "<text-3>"
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component"##"Address-component"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component"##"address-line"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component","address-line",3 contains text "<text-6>"
      And I see Experience.Content.RetailModuleMapLinkByIndex with href <href>,2 is clickable
      
    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                                   | text-1                                | text-2                                                                                                                               | text-3         | text-4           | text-5            | text-6                             | href                                      | count |
      | uk     | cms-debug?contentPageId=content-test-retail-module-01 | exclusively available at these stores | Who What Wear UK readers get an exclusive 20% off in participating stores through June 23rd. Show this page to redeem your discount. | Tommy Hilfiger | Kalverstraat 117 | 1012 PA Amsterdam | Kalverstraat 117 1012 PA Amsterdam | https://maps.app.goo.gl/ViNzDwaq6GR1keBF6 | 12    |

     @ExcludeCK @ExcludeDB0
    Examples:
      | locale | url                                                   | text-1                                | text-2                                                                                                                               | text-3         | text-4           | text-5            | text-6                             | href                                      | count |
      | uk     | cms-debug?contentPageId=content-test-retail-module-01 | exclusively available at these stores | Who What Wear UK readers get an exclusive 20% off in participating stores through June 23rd. Show this page to redeem your discount. | Tommy Hilfiger | Kalverstraat 117 | 1012 PA Amsterdam | Kalverstraat 117 1012 PA Amsterdam | https://maps.app.goo.gl/ViNzDwaq6GR1keBF6 | 4     |

    @ExcludeTH @ExcludeUat
    Examples:
      | locale | url                                                   | text-1                                | text-2                                                                                                                               | text-3             | text-4                   | text-5                | text-6                   | href                        | count |
      | uk     | cms-debug?contentPageId=content-test-retail-module-01 | Exclusively Available At These Stores | Who What Wear UK readers get an exclusive 20% off in participating stores through June 23rd. Show this page to redeem your discount. | Calvin Klein Store | Name 1.5 km Kalverstraat | 117 1012 PA Amsterdam | Name 1.5 km Kalverstraat | https://www.google.com/maps | 12    |

    @ExcludeTH @ExcludeDB0
    Examples:
      | locale | url                                                   | text-1                                | text-2                                                                                                                               | text-3             | text-4                   | text-5                | text-6                   | href                        | count |
      | uk     | cms-debug?contentPageId=content-test-retail-module-01 | Exclusively Available At These Stores | Who What Wear UK readers get an exclusive 20% off in participating stores through June 23rd. Show this page to redeem your discount. | Calvin Klein Store | Name 1.5 km Kalverstraat | 117 1012 PA Amsterdam | Name 1.5 km Kalverstraat | https://www.google.com/maps | 4     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedRetailModule @UnifiedExperience @Module @P2
  @feature:DD-5560
  @tms:UTR-18016
  Scenario Outline: Unified Retail Module - Verify retail module template map link redirects to Google map
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateTitleByIndex with data-testid "RetailModule-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "RetailModule-component" is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "RetailModule-component" is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "RetailModule-component" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component"##"RetailModule-list"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component"##"RetailModule-item"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component"##"typography-div"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component"##"Address-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "RetailModule-component"##"address-line"##1 is displayed
      And I see Experience.Content.RetailModuleMapLinkByIndex with href <href>,1 is clickable
    When I click on Experience.Content.RetailModuleMapLinkByIndex with href <href>,1
    Then I wait until the current page is loaded
      And I see URL should contain "google.com/maps"
      And I navigate back in the browser
      And I wait until the current page is loaded
    When I click on Experience.Content.RetailModuleMapLinkByIndex with href <href>,2
    Then I wait until the current page is loaded
      And I see URL should contain "google.com/maps"
                                    
    @ExcludeCK
    Examples:
      | locale | url                                                   | href                                      |
      | uk     | cms-debug?contentPageId=content-test-retail-module-01 | https://maps.app.goo.gl/ViNzDwaq6GR1keBF6 |

    @ExcludeTH
    Examples:
      | locale | url                                                   | href                        |
      | uk     | cms-debug?contentPageId=content-test-retail-module-01 | https://www.google.com/maps | 