Feature: Unified Content - Dynamic Module

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedDynamicModule @UnifiedExperience @Module @P2
  @tms:UTR-15093
  Scenario Outline: Unified Dynamic Module - Verify dynamic module is shown along with content in lanscape mode
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component",1
    Then I wait until Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is displayed
      And I see Experience.Content.TemplateBlock with data-testid "DynamicModule-component" is in viewport
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "DynamicModule-component"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##2 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "DynamicModule-component"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"ResponsiveImage-component"##2 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"ResponsiveImage-component"##3 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"ResponsiveImage-component"##4 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##5 is displayed
                                    
    Examples:
      | locale | url                                      |
      | uk     | cms-debug?contentPageId=Automated-test-1 |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedDynamicModule @UnifiedExperience @Module @P1
  @tms:UTR-15094
  Scenario Outline: Unified Dynamic Module - Verify dynamic module is shown along with content in portrait mode
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component",1
    Then I wait until Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is displayed
      And I see Experience.Content.TemplateBlock with data-testid "DynamicModule-component" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"ResponsiveImage-component"##2 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"ResponsiveImage-component"##3 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"ResponsiveImage-component"##4 is displayed
                                    
    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                      |
      | uk     | cms-debug?contentPageId=Automated-test-2 |

    @ExcludeTH
    Examples:
      | locale | url |
      | uk     | men |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedDynamicModule @UnifiedExperience @Module @P3
  @tms:UTR-15139
  Scenario Outline: Unified Dynamic Module - Verify dynamic module Desktop is shown along with content in landscape mode (Carousel)
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component",1
    Then I wait until Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is displayed
      And I see Experience.Content.TemplateBlock with data-testid "DynamicModule-component" is in viewport
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "DynamicModule-component"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##2 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "DynamicModule-component"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"Carousel-nav-prev-pvh-icon-button"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component","Carousel-nav-next-pvh-icon-button",1 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "DynamicModule-component","Carousel-nav-next-pvh-icon-button",1
    Then I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##5 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##6 is displayed
                                    
    @ExcludeUat
    Examples:
      | locale | url                                      |
      | uk     | cms-debug?contentPageId=Automated-test-3 |

  @FullRegression
  @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedDynamicModule @UnifiedExperience @Module @P3
  @tms:UTR-15182
    Scenario Outline: Unified Dynamic Module - Verify dynamic module mobile is shown along with content in landscape mode (Carousel)
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component",1
    Then I wait until Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is displayed
      And I see Experience.Content.TemplateBlock with data-testid "DynamicModule-component" is in viewport
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "DynamicModule-component"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##2 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "DynamicModule-component"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##5 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##6 is displayed
                                    
    @ExcludeUat
    Examples:
      | locale | url                                      |
      | uk     | cms-debug?contentPageId=Automated-test-3 |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedDynamicModule @UnifiedExperience @Module @P3
  @tms:UTR-15140
  Scenario Outline: Unified Dynamic Module - Verify dynamic module is shown along with content in portrait mode (Carousel)
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component",1
    Then I wait until Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is displayed
      And I see Experience.Content.TemplateBlock with data-testid "DynamicModule-component" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"Carousel-nav-prev-pvh-icon-button"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component","Carousel-nav-next-pvh-icon-button",1 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "DynamicModule-component","Carousel-nav-next-pvh-icon-button",1
    Then I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##4 is displayed
      And Then I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##6 is displayed
                                    
    @ExcludeUat
    Examples:
      | locale | url                                      |
      | uk     | cms-debug?contentPageId=Automated-test-4 |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedDynamicModule @UnifiedExperience @Module @P2
  @tms:UTR-15143
  Scenario Outline: Unified Dynamic Module - Verify dynamic module desktop image click is redirecting to the associated page
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component",1
    Then I wait until Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is displayed
      And I see Experience.Content.TemplateBlock with data-testid "DynamicModule-component" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##<CarouselItemIndex> is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component","ResponsiveImage-component",<CarouselItemIndex> is clickable
    When I click on Experience.Content.TemplateElement with data-testid "DynamicModule-component","ResponsiveImage-component",<CarouselItemIndex>
    Then And I wait until the current page is loaded
      And URL should contain "<href-1>" 
                                    
    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                      | href-1           | CarouselItemIndex |
      | uk     | cms-debug?contentPageId=Automated-test-3 | /1985-essentials | 2                 |

    @ExcludeTH @ExcludeDB0
    Examples:
      | locale | url |  href-1           | CarouselItemIndex |
      | uk     | men | /mens-eveningwear | 2                 |

    @ExcludeTH @ExcludeUat
    Examples:
      | locale | url                                      | href-1         | CarouselItemIndex |
      | uk     | cms-debug?contentPageId=Automated-test-1 | /womens-dresses | 1                 |

  @FullRegression
  @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedDynamicModule @UnifiedExperience @Module @P2
  @tms:UTR-15183
  Scenario Outline: Unified Dynamic Module - Verify dynamic module mobile image click is redirecting to the associated page
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component",1
    Then I wait until Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is displayed
      And I see Experience.Content.TemplateBlock with data-testid "DynamicModule-component" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"Carousel-component"##1 is displayed
      And I swipe to left direction on element Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##2
      And I wait for 2 seconds
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##2 is displayed
    When I click on Experience.Content.TemplateElement with data-testid "DynamicModule-component","ResponsiveImage-component",2
    Then And I wait until the current page is loaded
      And URL should contain "<href-1>" 
                                    
    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                      | href-1           |
      | uk     | cms-debug?contentPageId=Automated-test-3 | /1985-essentials |

    @ExcludeTH @ExcludeDB0
    Examples:
      | locale | url |  href-1           |
      | uk     | men | /mens-eveningwear |
    
    @ExcludeTH @ExcludeUat
    Examples:
      | locale | url                                      |  href-1              |
      | uk     | cms-debug?contentPageId=Automated-test-3 | /new-arrivals-womens |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedDynamicModule @UnifiedExperience @Module @P2
  @tms:UTR-15185
  Scenario Outline: Unified Dynamic Module - Verify dynamic module CTAs click is redirecting to the associated page
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component",1
    Then I wait until Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is displayed
      And I see Experience.Content.TemplateBlock with data-testid "DynamicModule-component" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateButtonLink with data-testid "DynamicModule-component",<href-1>,1 is clickable
    When I click on Experience.Content.TemplateButtonLink with data-testid "DynamicModule-component",<href-1>,1
    Then I wait until the current page is loaded
      And URL should contain "<href-1>"
      And I navigate back in the browser
      And I wait until the current page is loaded
      And I see Experience.Content.TemplateButtonLink with data-testid "DynamicModule-component",<href-2>,1 is clickable
    When I click on Experience.Content.TemplateButtonLink with data-testid "DynamicModule-component",<href-2>,1
    Then I wait until the current page is loaded
      And URL should contain "<href-2>"
                                    
    @ExcludeTH @ExcludeDB0
    Examples:
      | locale | url |  href-1        | href-2            |
      | uk     | men | /men-swim-shop | /mens-eveningwear |

    @ExcludeTH @ExcludeUat
    Examples:
      | locale | url                                       | href-1          | href-2               |
      | uk     | /cms-debug?contentPageId=Automated-test-1 | /womens-dresses | /new-arrivals-womens |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedDynamicModule @UnifiedExperience @Module @P2
  @tms:UTR-15186
  Scenario Outline: Unified Dynamic Module - Verify dynamic module CTAs click is redirecting to the associated page
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component",1
    Then I wait until Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is displayed
      And I see Experience.Content.TemplateBlock with data-testid "DynamicModule-component" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##2 is displayed
      And I see Experience.Content.TemplateButtonLink with data-testid "DynamicModule-component",<href-1>,1 is clickable
    When I click on Experience.Content.TemplateButtonLink with data-testid "DynamicModule-component",<href-1>,1
    Then And I wait until the current page is loaded
      And URL should contain "<href-1>"
      And I navigate back in the browser
      And I wait until the current page is loaded
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component","Carousel-nav-next-pvh-icon-button",1 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "DynamicModule-component","Carousel-nav-next-pvh-icon-button",1
      And I click on Experience.Content.TemplateElement with data-testid "DynamicModule-component","Carousel-nav-next-pvh-icon-button",1
    Then I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##6 is displayed
      And I see Experience.Content.TemplateButtonLink with data-testid "DynamicModule-component",<href-2>,1 is clickable
    When I click on Experience.Content.TemplateButtonLink with data-testid "DynamicModule-component",<href-2>,1
    Then And I wait until the current page is loaded
      And URL should contain "<href-2>"
                                       
    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                       |  href-1          | href-2              |
      | uk     | /cms-debug?contentPageId=Automated-test-3 | /1985-essentials | /mens-coats-jackets |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedDynamicModule @UnifiedExperience @Module @P3
  @tms:UTR-15267
  Scenario Outline: Unified Dynamic Module - Verify dynamic module with multiple CTAs click is redirecting to the associated page
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component",1
    Then I wait until Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "DynamicModule-component"##1 is displayed
      And I see Experience.Content.TemplateBlock with data-testid "DynamicModule-component" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "DynamicModule-component"##"CarouselItem"##1 is displayed
      And I see Experience.Content.TemplateButtonLink with data-testid "DynamicModule-component",<href-1>,1 is clickable
    When I click on Experience.Content.TemplateButtonLink with data-testid "DynamicModule-component",<href-1>,1
    Then And I wait until the current page is loaded
      And URL should contain "<href-1>"
      And I navigate back in the browser
      And I wait until the current page is loaded
      And I see Experience.Content.TemplateButtonLink with data-testid "DynamicModule-component",<href-2>,1 is clickable
    When I click on Experience.Content.TemplateButtonLink with data-testid "DynamicModule-component",<href-2>,1
    Then And I wait until the current page is loaded
      And URL should contain "<href-2>"
                                       
    @ExcludeTH @ExcludeUat
    Examples:
      | locale | url                                       |  href-1          | href-2              |
      | uk     | /cms-debug?contentPageId=Automated-test-5 | /summer-shop-men | /womens-collections |