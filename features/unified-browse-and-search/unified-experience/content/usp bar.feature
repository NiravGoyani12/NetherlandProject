Feature: Unified Content - USP Bar

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedUspBar @UnifiedExperience @Module @P2
  @tms:UTR-15893
  Scenario Outline: Unified Usp Bar - Verify usp bar is shown on Home and GLP pages TH
    Given I am on locale <locale> of url <url> of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "AnnouncementsBanner-component",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "AnnouncementsBanner-component"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "AnnouncementsBanner-component"##"AnnouncementsBannerSlideElement"##1 is displayed
      # And I see Experience.Content.TemplateHrefByIndex with data-testid "AnnouncementsBanner-component"##<href-1> is displayed
    
    @ExcludeCK @ExcludeUat                                           
    Examples:
      | locale  | langCode | url                                     | href-1           |
      | default | default  | /                                       | /pets-collection |
      | default | default  | /women                                  | /pets-collection |
      | default | default  | /men                                    | /pets-collection |
      | default | default  | /kids                                   | /pets-collection |
      | default | default  | /crochet-crew-neck-jumper-ww0ww39004c66 | /pets-collection |
      | default | default  | /wishlist                               | /pets-collection |

    @ExcludeCK @ExcludeDB0                                                 
    Examples:
      | locale  | langCode | url                                     | href-1 |
      | default | default  | /                                       | /kids  |
      | default | default  | /women                                  | /kids  |
      | default | default  | /men                                    | /kids  |
      | default | default  | /kids                                   | /kids  |
      | default | default  | /crochet-crew-neck-jumper-ww0ww39004c66 | /kids  |
      | default | default  | /wishlist                               | /kids  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedUspBar @UnifiedExperience @Module @P2
  @tms:UTR-15894
  Scenario Outline: Unified Usp Bar - Verify usp bar is shown on Home and GLP pages CK
    Given I am on locale <locale> of url <url> of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "AnnouncementsBanner-component",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "AnnouncementsBanner-component"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "AnnouncementsBanner-component"##"AnnouncementsBannerSlideElement"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "AnnouncementsBanner-component"##"AnnouncementsBannerItem"##1 is displayed
      # And I see Experience.Content.TemplateHrefByIndex with data-testid "AnnouncementsBanner-component"##<href-1> is displayed
      # And I wait for 2 seconds
      # And I see Experience.Content.TemplateHrefByIndex with data-testid "AnnouncementsBanner-component"##<href-2> is displayed

    @ExcludeTH 
    Examples:
      | locale  | langCode | url                               | href-1 | href-2         |
      | default | default  | /                                 | /sale  | /faqs-delivery |
      | default | default  | /women                            | /sale  | /faqs-delivery |
      | default | default  | /men                              | /sale  | /faqs-delivery |
      | default | default  | /kids                             | /sale  | /faqs-delivery |
      | default | default  | /logo-patch-t-shirt-j20j222170beh | /sale  | /faqs-delivery |
      | default | default  | /wishlist                         | /sale  | /faqs-delivery |