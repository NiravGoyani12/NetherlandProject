Feature: Unified Content - Category Card Module

  @FullRegression
  @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedCategoryCardModule @UnifiedExperience @Module @P2
  @tms:UTR-15512
  Scenario Outline: Unified Category Card Module - Verify category card module template is shown along with content
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "CategoryCards-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "CategoryCards-component" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component"##"CarouselItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateCategoryCardNameByIndex with data-testid "CategoryCards-component",1 contains text "<text-1>"
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component"##"CarouselItem"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component"##"ResponsiveImage-component"##2 is displayed
      And I see Experience.Content.TemplateCategoryCardNameByIndex with data-testid "CategoryCards-component",2 contains text "<text-2>"
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component"##"CarouselItem"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component"##"ResponsiveImage-component"##3 is displayed
      And I see Experience.Content.TemplateCategoryCardNameByIndex with data-testid "CategoryCards-component",3 contains text "<text-3>"
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component"##"CarouselItem"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component"##"ResponsiveImage-component"##4 is displayed
      And I see Experience.Content.TemplateCategoryCardNameByIndex with data-testid "CategoryCards-component",4 contains text "<text-4>"
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component"##"CarouselItem"##5 is displayed
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component"##"ResponsiveImage-component"##5 is displayed
      And I see Experience.Content.TemplateCategoryCardNameByIndex with data-testid "CategoryCards-component",5 contains text "<text-5>"
                                                
    @ExcludeCK @ExcludeDB0
    Examples:
      | locale | url   | text-1 | text-2         | text-3      | text-4   | text-5   |
      | uk     | women | NEW IN | DISNEY X TOMMY | COLLECTIONS | CLOTHING | SWIMWEAR |

    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url   | text-1 | text-2   | text-3 | text-4 | text-5    |
      | uk     | women | NEW IN | CLOTHING | BAGS   | SHOES  | accessory |

  @FullRegression
  @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedCategoryCardModule @UnifiedExperience @Module @P2
  @tms:UTR-15513
  Scenario Outline: Unified Category Card Module - Verify category card module when click on a category card the associated links are displayed
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "CategoryCards-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "CategoryCards-component" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component"##"CarouselItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component","ResponsiveImage-component",1 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "CategoryCards-component","ResponsiveImage-component",1
    Then I see Experience.Content.TemplateCategoryCardlinkslistItemByIndex with data-testid "CategoryCards-component"##1 is displayed in 2 seconds
      And I see Experience.Content.TemplateCategoryCardlinkslistItemByIndex with data-testid "CategoryCards-component",1 is clickable
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component"##"CarouselItem"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component","ResponsiveImage-component",2 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "CategoryCards-component","ResponsiveImage-component",2
    Then I see Experience.Content.TemplateCategoryCardlinkslistItemByIndex with data-testid "CategoryCards-component"##1 is displayed in 2 seconds
      And I see Experience.Content.TemplateCategoryCardlinkslistItemByIndex with data-testid "CategoryCards-component",1 is clickable
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component"##"CarouselItem"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component","ResponsiveImage-component",3 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "CategoryCards-component","ResponsiveImage-component",3
    Then I see Experience.Content.TemplateCategoryCardlinkslistItemByIndex with data-testid "CategoryCards-component"##1 is displayed in 2 seconds
      And I see Experience.Content.TemplateCategoryCardlinkslistItemByIndex with data-testid "CategoryCards-component",1 is clickable
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component"##"CarouselItem"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "CategoryCards-component","ResponsiveImage-component",4 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "CategoryCards-component","ResponsiveImage-component",4
    Then I see Experience.Content.TemplateCategoryCardlinkslistItemByIndex with data-testid "CategoryCards-component"##1 is displayed in 2 seconds
      And I see Experience.Content.TemplateCategoryCardlinkslistItemByIndex with data-testid "CategoryCards-component",1 is clickable
                                                   
    @ExcludeCK
    Examples:
      | locale | url   |
      | uk     | women |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedCategoryCardModule @UnifiedExperience @Module @P2
  @tms:UTR-15514
  Scenario Outline: Unified Category Entries Module - Verify category entries module template is shown along with content
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "CategoryEntries-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "CategoryEntries-component" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "CategoryEntries-component"##1 is in viewport
      And I see Experience.Content.TemplateButtonLink with data-testid "CategoryEntries-component",<href-1> is clickable
    When I click on Experience.Content.TemplateButtonLink with data-testid "CategoryEntries-component",<href-1>
    Then I wait until the current page is loaded
      And URL should contain "<href-1>"
      And I navigate back in the browser
      And I wait until the current page is loaded
      And I see Experience.Content.TemplateButtonLink with data-testid "CategoryEntries-component",<href-2> is clickable
    When I click on Experience.Content.TemplateButtonLink with data-testid "CategoryEntries-component",<href-2>
    Then I wait until the current page is loaded 
      And URL should contain "<href-2>"
                                 
    @ExcludeTH
    Examples:
      | locale | url                                       | href-1               | href-2       |
      | uk     | /cms-debug?contentPageId=Automated-test-4 | /new-arrivals-womens | /girls-jeans |

    @ExcludeCK @ExcludeDB0
    Examples:
      | locale | url                                       | href-1        | href-2           |
      | uk     | /cms-debug?contentPageId=Automated-test-4 | /mens-jackets | /tommy-jeans-men |

    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                       | href-1              | href-2           |
      | uk     | /cms-debug?contentPageId=Automated-test-4 | /mens-coats-jackets | /tommy-jeans-men |
