Feature: Unified Content - Sticky Nav Module

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedStickyNavModule @UnifiedExperience @Module @P1
  @feature:EEI-10665
  @tms:UTR-17655
  Scenario Outline: Unified Sticky Nav Module - Verify sticky nav module template is shown along with content
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "sticky-nav"
    Then I wait until Experience.Content.TemplateBlock with data-testid "sticky-nav" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"pvh-button"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"smart-cards-card-title-text-0" is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav","smart-cards-card-title-text-0" contains text "<text-1>"
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"pvh-button"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"smart-cards-card-title-text-1" is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav","smart-cards-card-title-text-1" contains text "<text-2>"
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"pvh-button"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"smart-cards-card-title-text-2" is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav","smart-cards-card-title-text-2" contains text "<text-3>"
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"pvh-button"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"smart-cards-card-title-text-3" is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav","smart-cards-card-title-text-3" contains text "<text-4>"
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##5 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"pvh-button"##5 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"smart-cards-card-title-text-4" is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav","smart-cards-card-title-text-4" contains text "<text-5>"
                                    
    @ExcludeCK
    Examples:
      | locale | url                                      | text-1                                       | text-2                                                          | text-3             | text-4             | text-5       |
      | uk     | cms-debug?contentPageId=Automated-test-1 | E-GIFT CARDS. REDEEMABLE ONLINE AND IN Store | Splash Design View 1 - DO NOT UPDATE - USED FOR AUTOMATED TESTS | FEEL THE FRESH AIR | FEEL THE FRESH AIR | Explore more |

    @ExcludeTH
    Examples:
      | locale | url                                      | text-1                                                          | text-2            | text-3           | text-4                          | text-5 |
      | uk     | cms-debug?contentPageId=Automated-test-1 | Splash Design View 1 - DO NOT UPDATE - USED FOR AUTOMATED TESTS | Calvin or Nothing | Drop into Summer | E-GIFT CARDS. REDEEMABLE ONLINE | New In |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedStickyNavModule @UnifiedExperience @Module @P2
  @feature:EEI-10665
  @tms:UTR-17656
  Scenario Outline: Unified Sticky Nav Module - Verify sticky nav module redirects to the respective module when clicked in the nav bar 
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "sticky-nav"
    Then I wait until Experience.Content.TemplateBlock with data-testid "sticky-nav" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"pvh-button"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"smart-cards-card-title-text-0" is displayed
    When I click on Experience.Content.TemplateElement with data-testid "sticky-nav","pvh-button",1
    Then I see Experience.Content.TemplateBlock with data-testid "<module-1>"##1 is displayed in the viewport
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"pvh-button"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"smart-cards-card-title-text-1" is displayed
    When I click on Experience.Content.TemplateElement with data-testid "sticky-nav","pvh-button",2
    Then I see Experience.Content.TemplateBlock with data-testid "<module-2>"##1 is displayed in the viewport
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"pvh-button"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"smart-cards-card-title-text-2" is displayed
    When I click on Experience.Content.TemplateElement with data-testid "sticky-nav","pvh-button",3
    Then I see Experience.Content.TemplateBlock with data-testid "<module-3>"##1 is displayed in the viewport
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"pvh-button"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"smart-cards-card-title-text-3" is displayed
    When I click on Experience.Content.TemplateElement with data-testid "sticky-nav","pvh-button",4
    Then I see Experience.Content.TemplateBlock with data-testid "<module-4>"##1 is displayed in the viewport
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##5 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"pvh-button"##5 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"smart-cards-card-title-text-4" is displayed
    When I click on Experience.Content.TemplateElement with data-testid "sticky-nav","pvh-button",5
    Then I see Experience.Content.TemplateBlock with data-testid "<module-5>"##1 is displayed in the viewport
                                    
    @ExcludeCK
    Examples:
      | locale | url                                      | module-1        | module-2      | module-3      | module-4      | module-5                |
      | uk     | cms-debug?contentPageId=Automated-test-1 | Promo-component | Splash-module | hero-template | hero-template | DynamicModule-component |

    @ExcludeTH
    Examples:
      | locale | url                                      | module-1      | module-2      | module-3      | module-4        | module-5                |
      | uk     | cms-debug?contentPageId=Automated-test-1 | Splash-module | hero-template | hero-template | Promo-component | DynamicModule-component |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedStickyNavModule @UnifiedExperience @Module @P2
  @feature:EEI-10665
  @tms:UTR-17657
  Scenario Outline: Unified Sticky Nav Module - Verify sticky nav module should disappear when all the related modules are not in the view
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "sticky-nav"
    Then I wait until Experience.Content.TemplateBlock with data-testid "sticky-nav" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##5 is displayed
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "<module-1>"
    Then I wait for 2 seconds
      And I see Experience.Content.TemplateBlock with data-testid "sticky-nav" is not in viewport
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"Carousel-component"##1 is not in viewport
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##1 is not in viewport
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##2 is not in viewport
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##3 is not in viewport
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##4 is not in viewport
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##5 is not in viewport
                                    
    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                      | module-1              |
      | uk     | cms-debug?contentPageId=Automated-test-1 | ShopTheLook-component |

    @ExcludeTH @ExcludeUat
    Examples:
      | locale | url                                      | module-1              |
      | uk     | cms-debug?contentPageId=Automated-test-1 | ShopTheLook-component |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedStickyNavModule @UnifiedExperience @Module @P2
  @feature:EEI-10665
  @tms:UTR-17658
  Scenario Outline: Unified Sticky Nav Module - Verify for sticky nav module the mobile specific modules should not appear in the desktop 
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "sticky-nav"
    Then I wait until Experience.Content.TemplateBlock with data-testid "sticky-nav" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"pvh-button"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"smart-cards-card-title-text-0" is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav","smart-cards-card-title-text-0" does not contain text "<text-1>"
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav","smart-cards-card-title-text-0" contains text "<text-2>"
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"pvh-button"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"smart-cards-card-title-text-1" is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav","smart-cards-card-title-text-1" contains text "<text-3>"
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"pvh-button"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"smart-cards-card-title-text-2" is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav","smart-cards-card-title-text-2" contains text "<text-4>"
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"CarouselItem"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"pvh-button"##4 is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav"##"smart-cards-card-title-text-3" is displayed
      And I see Experience.Content.TemplateElement with data-testid "sticky-nav","smart-cards-card-title-text-3" contains text "<text-5>"
                                    
    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                      | text-1                                  | text-2              | text-3                                              | text-4                                       | text-5                                                          |
      | uk     | cms-debug?contentPageId=Automated-test-4 | CATEGORY CARDS-Automation-DO NOT UPDATE | TOMORROW'S CLASSICS | E-GIFT CARDS. REDEEMABLE ONLINE AND IN Store-000000 | E-GIFT CARDS. REDEEMABLE ONLINE AND IN Store | Splash Design View 4 - DO NOT UPDATE - USED FOR AUTOMATED TESTS |

      
      
   