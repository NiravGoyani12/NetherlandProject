Feature: Unified Content - Two Images Module

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedTwoImagesModule @Module @P1
  @tms:UTR-14847
  Scenario Outline: Unified Two Images Module - Verify two images module template is shown along with content
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "two-images"
    Then I wait until Experience.Content.TemplateBlock with data-testid "two-images" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-big-image" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-small-image" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-title" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-body-text" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-cta-container" is displayed
                                    
    @ExcludeCK
    Examples:
      | locale | url                                      |
      | uk     | cms-debug?contentPageId=Automated-test-2 |

    @ExcludeTH
    Examples:
      | locale | url                                       |
      | uk     | /cms-debug?contentPageId=Automated-test-2 |

  @FullRegression
  @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedTwoImagesModule @Module @P1
  @tms:UTR-14848
  Scenario Outline: Unified Two Images Module - Verify Mobile two images module template is shown along with content and one image hidden
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "two-images"
    Then I wait until Experience.Content.TemplateBlock with data-testid "two-images" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-big-image" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-small-image" is not displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-title" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-body-text" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-cta-container" is displayed
                                    
    @ExcludeTH
    Examples:
      | locale | url                                       |
      | uk     | cms-debug?contentPageId=Automated-test-2  |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedTwoImagesModule @Module @P3
  @tms:UTR-14987
  Scenario Outline: Unified Two Images Module - Verify two images module template the images are clickable and redirect to associated page 
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "two-images"
    Then I wait until Experience.Content.TemplateBlock with data-testid "two-images" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "two-images","two-images-big-image" is clickable
    When I click on Experience.Content.TemplateElement with data-testid "two-images","two-images-big-image"
    Then I wait for 3 seconds
      And URL should contain "<href-1>"
      And I navigate back in the browser
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "two-images"
    Then I wait until Experience.Content.TemplateBlock with data-testid "two-images" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "two-images","two-images-small-image" is clickable
    When I click on Experience.Content.TemplateElement with data-testid "two-images","two-images-small-image"
    Then I wait for 3 seconds
      And URL should contain "<href-1>"
      
                                    
    @ExcludeTH
    Examples:
      | locale | url                                       | href-1       |
      | uk     | cms-debug?contentPageId=Automated-test-2  | /mens-shorts |

    @ExcludeCK
    Examples:
      | locale | url                                       | href-1        |
      | uk     | cms-debug?contentPageId=Automated-test-2  | /mens-clothes |

  # @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedTwoImagesModule @Module @P3
  @tms:UTR-14988
  Scenario Outline: Unified Two Images Module - Verify two images module template video behaviour when the voice icon is muted and un-muted
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "two-images"
    Then I wait until Experience.Content.TemplateBlock with data-testid "two-images" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"VideoBackground-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"VideoBackground-component"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-title" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-body-text" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-cta-container" is displayed
      And I see Experience.Content.TemplateButton with data-testid "two-images","icon-utility-sound-off",1 is clickable
      And I see Experience.Content.TemplateButton with data-testid "two-images","icon-utility-sound-off",2 is clickable
    When I click on Experience.Content.TemplateButton with data-testid "two-images","icon-utility-sound-off",1
      And I click on Experience.Content.TemplateButton with data-testid "two-images","icon-utility-sound-off",1
    Then I see Experience.Content.TemplateButton with data-testid "two-images"##"icon-utility-sound-off"##1 is not displayed
      And I see Experience.Content.TemplateButton with data-testid "two-images"##"icon-utility-sound-off"##2 is not displayed
      And I see Experience.Content.TemplateButton with data-testid "two-images","icon-utility-sound-on",1 is clickable
      And I see Experience.Content.TemplateButton with data-testid "two-images","icon-utility-sound-on",2 is clickable
    When I click on Experience.Content.TemplateButton with data-testid "two-images","icon-utility-sound-on",1
      And I click on Experience.Content.TemplateButton with data-testid "two-images","icon-utility-sound-on",1
    Then I see Experience.Content.TemplateButton with data-testid "two-images"##"icon-utility-sound-on"##1 is not displayed
      And I see Experience.Content.TemplateButton with data-testid "two-images"##"icon-utility-sound-on"##2 is not displayed
      And I see Experience.Content.TemplateButton with data-testid "two-images","icon-utility-sound-off",1 is clickable 
      And I see Experience.Content.TemplateButton with data-testid "two-images","icon-utility-sound-off",2 is clickable 
      
                                    
    @ExcludeUat
    Examples:
      | locale | url                                       |
      | uk     | cms-debug?contentPageId=Automated-test-1  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedTwoImagesModule @Module @P3
  @tms:UTR-14991
  Scenario Outline: Unified Two Images Module - Verify two images module template CTA redirects to the associated page
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "two-images"
    Then I wait until Experience.Content.TemplateBlock with data-testid "two-images" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-big-image" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-title" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-body-text" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-cta-container" is displayed
    When I click on Experience.Content.TemplateElement with data-testid "two-images","two-images-cta-container"
    Then I wait until the current page is loaded
     And URL should contain "<href-1>"
                                    
    @ExcludeTH
    Examples:
      | locale | url                                       | href-1       |
      | uk     | cms-debug?contentPageId=Automated-test-2  | /mens-shorts |

    @ExcludeCK
    Examples:
      | locale | url                                       | href-1        |
      | uk     | cms-debug?contentPageId=Automated-test-2  | /mens-clothes |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedTwoImagesModule @Module @P3
  @feature:DD-5469
  @tms:UTR-18591
  Scenario Outline: Unified Two Images Module - Verify two images module template has product visible with image and title
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "two-images"
    Then I wait until Experience.Content.TemplateBlock with data-testid "two-images" is in viewport
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-big-image" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"scene7image-picture" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-title" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images","two-images-title" contains text "<text-1>"
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"PriceDisplay" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images","PriceDisplay" contains text "<text-2>"
      And I see Experience.Content.TemplateElement with data-testid "two-images"##"two-images-body-text" is displayed
      And I see Experience.Content.TemplateElement with data-testid "two-images","two-images-body-text" contains text "<text-3>"
                                    
    @ExcludeTH
    Examples:
      | locale | url                                       | text-1                    | text-2 | text-3                                                       |
      | uk     | cms-debug?contentPageId=Automated-test-4  | Slim Varsity Logo T-shirt | £35.00 | Bright colours and bold logos. New swimwear and accessories. |

    @ExcludeCK
    Examples:
      | locale | url                                       | text-1                                 | text-2 | text-3             |
      | uk     | cms-debug?contentPageId=Automated-test-4  | Hilfiger Logo Spaghetti Strap Bralette | £42.00 | Testing Two images |