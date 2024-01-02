Feature: Unified Content - Generic

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedGEnericContent @Module @P1
  @tms:UTR-16049
  Scenario Outline: Unified Generic Content - Verify event details module is shown with content
    Given I am on locale <locale> of url <url> of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "EventDetails-component",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "EventDetails-component"##1 is in viewport
      And I see Experience.Content.TemplateEventDetailsHeadingByIndex with data-testid "EventDetails-component"##1 is displayed
      And I see Experience.Content.TemplateEventDetailsTextByIndex with data-testid "EventDetails-component"##1 is displayed
      And I see Experience.Content.TemplateEventDetailsTextByIndex with data-testid "EventDetails-component",1 contains text "22 September 2024"
      And I see Experience.Content.TemplateEventDetailsHeadingByIndex with data-testid "EventDetails-component"##2 is displayed
      And I see Experience.Content.TemplateEventDetailsTextByIndex with data-testid "EventDetails-component"##2 is displayed
      And I see Experience.Content.TemplateEventDetailsTextByIndex with data-testid "EventDetails-component",2 contains text "9/22/2024"
      And I see Experience.Content.TemplateEventDetailsHeadingByIndex with data-testid "EventDetails-component"##3 is displayed
      And I see Experience.Content.TemplateEventDetailsTextByIndex with data-testid "EventDetails-component"##3 is displayed
      And I see Experience.Content.TemplateEventDetailsTextByIndex with data-testid "EventDetails-component",3 contains text "London Bridge"
                                                      
    @ExcludeCK @ExcludeUat
    Examples:
      | locale | langCode | url                                       |
      | uk     | default  | /cms-debug?contentPageId=Automated-test-4 |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedGEnericContent @Module @P2
  @tms:UTR-16050
  Scenario Outline: Unified Generic Content - Verify recommendations module is shown with content
    Given I am on locale <locale> of url <url> of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "Recommendations-component-cart_rec_injection1",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "Recommendations-component-cart_rec_injection1"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "Recommendations-component-cart_rec_injection1"##"title-heading"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "Recommendations-component-cart_rec_injection1"##"pvh-button"##1 is displayed
      And I see Experience.Content.TemplateButtonLink with data-testid "Recommendations-component-cart_rec_injection1",<href-1> is clickable
      And I see Experience.Content.TemplateElement with data-testid "Recommendations-component-cart_rec_injection1"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "Recommendations-component-cart_rec_injection1"##"CarouselItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "Recommendations-component-cart_rec_injection1"##"product-recommendations_img"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "Recommendations-component-cart_rec_injection1"##"ProductLabel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "Recommendations-component-cart_rec_injection1","ProductLabel-component",1 contains text "-45%"
      And I see Experience.Content.TemplateElement with data-testid "Recommendations-component-cart_rec_injection1"##"icon-utility-wishlist-svg"##1 is displayed
      And I see Experience.Content.TemplateRecommendationsProductTitleIndex with data-testid "Recommendations-component-cart_rec_injection1"##1 is displayed
      And I see Experience.Content.TemplateRecommendationsProductTitleIndex with data-testid "Recommendations-component-cart_rec_injection1",1 contains text "Beach Shorts - Intense Power"
      And I see Experience.Content.TemplateElement with data-testid "Recommendations-component-cart_rec_injection1"##"WasPriceText"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "Recommendations-component-cart_rec_injection1","WasPriceText",1 contains text "£40.00"
      And I see Experience.Content.TemplateElement with data-testid "Recommendations-component-cart_rec_injection1"##"PriceText"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "Recommendations-component-cart_rec_injection1","PriceText",1 contains text "£21.00"
      And I see Experience.Content.TemplateElement with data-testid "Recommendations-component-cart_rec_injection1"##"CarouselItem"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "Recommendations-component-cart_rec_injection1"##"CarouselItem"##3 is displayed
      And I see Experience.Content.TemplateElement with data-testid "Recommendations-component-cart_rec_injection1"##"CarouselItem"##4 is displayed

                                                      
    @ExcludeTH
    Examples:
      | locale | langCode | url                                       | href-1       |
      | uk     | default  | /cms-debug?contentPageId=Automated-test-4 | /womens-bras |

  @FullRegression 
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedGEnericContent @P2
  @tms:UTR-17117
  Scenario Outline: Unified Generic Content - Verify sidebar is present on size-guide and faq pages
    Given I am on locale <locale> of url <url> of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.<locator-1>
    Then I wait until Experience.Content.<locator-1> is in viewport
      And I see Experience.Content.<locator-1> is displayed
      And I see Experience.Content.<locator-2> is displayed
      And I see Experience.Content.<locator-3> is displayed
      And the count of elements Experience.Content.<locator-4> is greater than 1
                                                      
    @ExcludeCK                                                  
    Examples:
      | locale | langCode | url                  | locator-1          | locator-2               | locator-3                  | locator-4                      |
      | uk     | default  | /faqs                | SideBar            | SideBarTitle            | SideBarMenuList            | SideBarMenuListItem            |
      | uk     | default  | /size-guide          | SideBar            | SideBarTitle            | SideBarMenuList            | SideBarMenuListItem            |
      | uk     | default  | /womens-size-guide   | SideBarSizeGuideTH | SideBarTitleSizeGuideTH | SideBarMenuListSizeGuideTH | SideBarMenuListItemSizeGuideTH |
      | uk     | default  | /mens-size-guide     | SideBarSizeGuideTH | SideBarTitleSizeGuideTH | SideBarMenuListSizeGuideTH | SideBarMenuListItemSizeGuideTH |
      | uk     | default  | /children-size-guide | SideBarSizeGuideTH | SideBarTitleSizeGuideTH | SideBarMenuListSizeGuideTH | SideBarMenuListItemSizeGuideTH |

    @ExcludeTH                                                  
    Examples:
      | locale | langCode | url                | locator-1          | locator-2               | locator-3                  | locator-4                      |
      | uk     | default  | /faqs              | SideBar            | SideBarTitle            | SideBarMenuList            | SideBarMenuListItem            |
      | uk     | default  | /size-guide        | SideBarSizeGuideCK | SideBarTitleSizeGuideCK | SideBarMenuListSizeGuideCK | SideBarMenuListItemSizeGuideCK |
      | uk     | default  | /womens-size-guide | SideBarSizeGuideCK | SideBarTitleSizeGuideCK | SideBarMenuListSizeGuideCK | SideBarMenuListItemSizeGuideCK |
      | uk     | default  | /mens-size-guide   | SideBarSizeGuideCK | SideBarTitleSizeGuideCK | SideBarMenuListSizeGuideCK | SideBarMenuListItemSizeGuideCK |
      | uk     | default  | /kids-size-guide   | SideBarSizeGuideCK | SideBarTitleSizeGuideCK | SideBarMenuListSizeGuideCK | SideBarMenuListItemSizeGuideCK |
     
  # @FullRegression 
  @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedGEnericContent @P2
  @tms:UTR-17119
  Scenario Outline: Unified Generic Content - Verify sidebar is present on size-guide and faq pages for mobile
    Given I am on locale <locale> of url <url> of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.<locator-1>
    Then I wait until Experience.Content.<locator-1> is in viewport
      And I see Experience.Content.<locator-1> is displayed
      And I see Experience.Content.<locator-2> is displayed
      And the count of elements Experience.Content.<locator-3> is greater than 1
                                                      
    @ExcludeCK                                                  
    Examples:
      | locale | langCode | url                  | locator-1          | locator-2                  | locator-3                      |
      | uk     | default  | /faqs                | SideBar            | SideBarMenuList            | SideBarMenuListItem            |
      | uk     | default  | /size-guide          | SideBar            | SideBarMenuList            | SideBarMenuListItem            |
      | uk     | default  | /womens-size-guide   | SideBarSizeGuideTH | SideBarMenuListSizeGuideTH | SideBarMenuListItemSizeGuideTH |
      | uk     | default  | /mens-size-guide     | SideBarSizeGuideTH | SideBarMenuListSizeGuideTH | SideBarMenuListItemSizeGuideTH |
      | uk     | default  | /children-size-guide | SideBarSizeGuideTH | SideBarMenuListSizeGuideTH | SideBarMenuListItemSizeGuideTH |

    @ExcludeTH                                                  
    Examples:
      | locale | langCode | url                | locator-1          | locator-2                  | locator-3                      |
      | uk     | default  | /faqs              | SideBar            | SideBarMenuList            | SideBarMenuListItem            |
      | uk     | default  | /size-guide        | SideBarSizeGuideCK | SideBarMenuListSizeGuideCK | SideBarMenuListItemSizeGuideCK |
      | uk     | default  | /womens-size-guide | SideBarSizeGuideCK | SideBarMenuListSizeGuideCK | SideBarMenuListItemSizeGuideCK |
      | uk     | default  | /mens-size-guide   | SideBarSizeGuideCK | SideBarMenuListSizeGuideCK | SideBarMenuListItemSizeGuideCK |
      | uk     | default  | /kids-size-guide   | SideBarSizeGuideCK | SideBarMenuListSizeGuideCK | SideBarMenuListItemSizeGuideCK |

  @FullRegression 
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedVideoModule @Module @P1
  @feature:DD-4865
  @tms:UTR-17335
  Scenario Outline: Unified Video Module - Verify video module template is shown along with content
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "Video-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "Video-component" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "Video-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "Video-component"##"video-item"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "Video-component"##"pvh-icon-button"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "Video-component"##"icon-utility-play"##1 is displayed
    When I click on Experience.Content.TemplateElement with data-testid "Video-component","icon-utility-play",1
    Then I see Experience.Content.TemplateElement with data-testid "Video-component"##"icon-utility-play"##1 is not displayed
      And I see Experience.Content.TemplateElement with data-testid "Video-component"##"pvh-icon-button"##1 is not displayed
   
    Examples:
      | locale | url                                       |
      | uk     | /cms-debug?contentPageId=Automated-test-2 |
  
  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedLiveSellingModule @Module @P2
  @feature:DD-5549
  @tms:UTR-17429
  Scenario Outline: Unified Live Selling Module - Verify Live Selling Module template is shown along with content
    Given I am on locale <locale> of url <url> with accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "hero-template"
    Then I wait until Experience.Content.TemplateBlock with data-testid "hero-template" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "hero-template"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "hero-template","cta-pvh-button",1 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "hero-template","cta-pvh-button",1
    Then I wait until Experience.Content.LivesellingIframePlayer is displayed
      And I see Experience.Content.LivesellingIframePlayer is displayed

    @ExcludeCK
    Examples:
      | locale | url                                       |
      | uk     | /cms-debug?contentPageId=Automated-test-4 |

    @ExcludeTH
    Examples:
      | locale | url                                         |
      | uk     | /cms-debug?contentPageId=LS-AUTOMATEDTEST-5 |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedAccordionModule @Module @P2
  @feature:DD-5440
  @tms:UTR-17459
  Scenario Outline: Unified Accordian Module - Verify Accordian Module is shown along with heading and subcopy
    Given I am on locale <locale> of url <url> with accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.AccordionTitle is displayed
    Then I wait until Experience.Content.AccordionSubTitle is displayed
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-trigger"##1 is displayed
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-icon"##1 is displayed
      And I see Experience.Content.AccordionTextByIndex with index 1 contains text "How can I track my order or check the delivery status?"
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-trigger"##2 is displayed
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-icon"##2 is displayed
      And I see Experience.Content.AccordionTextByIndex with index 2 contains text "What should I do when my order was delivered at the wrong address?"
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-trigger"##3 is displayed
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-icon"##3 is displayed
      And I see Experience.Content.AccordionTextByIndex with index 3 contains text "What happens when I miss the delivery of my order?"
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-trigger"##4 is displayed
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-icon"##4 is displayed
      And I see Experience.Content.AccordionTextByIndex with index 4 contains text "What delivery options do I have?"

    Examples:
      | locale | url                                               |
      | uk     | /cms-debug?contentPageId=accordion_Automated_test |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedAccordionModule @Module @P2
  @feature:DD-5440
  @tms:UTR-17461
  Scenario Outline: Unified Accordian Module - Verify Accordian Module template has nested images and text
    Given I am on locale <locale> of url <url> with accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.AccordionTitle is displayed
    Then I wait until Experience.Content.AccordionSubTitle is displayed
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-trigger"##1 is displayed
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-icon"##1 is displayed
      And I see Experience.Content.AccordionTextByIndex with index 1 contains text "How can I track my order or check the delivery status?"
    When I click on Experience.Content.AccordianElement with data-testid "pvh-accordion","accordion-icon",1 is displayed
    Then I see Experience.Content.AccordionContentByIndex with index 1 is displayed
      And I scroll to the element Experience.Content.AccordianElement with data-testid "pvh-accordion","accordion-trigger",2
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-trigger"##2 is displayed
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-icon"##2 is displayed
      And I see Experience.Content.AccordionTextByIndex with index 2 contains text "What should I do when my order was delivered at the wrong address?"
    When I click on Experience.Content.AccordianElement with data-testid "pvh-accordion","accordion-icon",2 is displayed
    Then I see Experience.Content.AccordionContentByIndex with index 2 is displayed
      And I see Experience.Content.AccordionImageByIndex with index 2 is displayed
      And I scroll to the element Experience.Content.AccordianElement with data-testid "pvh-accordion","accordion-trigger",3
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-trigger"##3 is displayed
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-icon"##3 is displayed
      And I see Experience.Content.AccordionTextByIndex with index 3 contains text "What happens when I miss the delivery of my order?"
    When I click on Experience.Content.AccordianElement with data-testid "pvh-accordion","accordion-icon",3 is displayed
    Then I see Experience.Content.AccordionContentByIndex with index 3 is displayed
      And I scroll to the element Experience.Content.AccordianElement with data-testid "pvh-accordion","accordion-trigger",4
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-trigger"##4 is displayed
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-icon"##4 is displayed
      And I see Experience.Content.AccordionTextByIndex with index 4 contains text "What delivery options do I have?"
    When I click on Experience.Content.AccordianElement with data-testid "pvh-accordion","accordion-icon",4 is displayed
    Then I see Experience.Content.AccordionContentByIndex with index 4 is displayed

    Examples:
      | locale | url                                               |
      | uk     | /cms-debug?contentPageId=accordion_Automated_test |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedAccordionModule @Module @P2
  @feature:DD-5440
  @tms:UTR-17463
  Scenario Outline: Unified Accordian Module - Verify Accordian Module template has hyperlinks to text inside accordions
    Given I am on locale <locale> of url <url> with accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.AccordionTitle is displayed
    Then I wait until Experience.Content.AccordionSubTitle is displayed
      And I scroll to the element Experience.Content.AccordianElement with data-testid "pvh-accordion","accordion-trigger",2
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-trigger"##2 is displayed
      And I see Experience.Content.AccordianElement with data-testid "pvh-accordion"##"accordion-icon"##2 is displayed
      And I see Experience.Content.AccordionTextByIndex with index 2 contains text "What should I do when my order was delivered at the wrong address?"
    When I click on Experience.Content.AccordianElement with data-testid "pvh-accordion","accordion-icon",2 is displayed
    Then I see Experience.Content.AccordionContentByIndex with index 2 is displayed
      And I see Experience.Content.AccordionImageByIndex with index 2 is displayed
      And I wait until Experience.Content.AccordionHyperlinkByHref with href <href> is clickable
    When I click on Experience.Content.AccordionHyperlinkByHref with href <href>
    Then I wait until the current page is loaded
      And URL should contain "<href>" 

    Examples:
      | locale | url                                               | href       |
      | uk     | /cms-debug?contentPageId=accordion_Automated_test | /contactus |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedVisualNavigationModule @Module @P2
  @feature:DD-5164
  @tms:UTR-17492
  Scenario Outline: Unified Visual Navigation Module - Verify Visual Navigation Module template is shown along with content
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "VisualNavigation-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "VisualNavigation-component" is displayed
      And I see Experience.Content.TemplateElement with data-testid "VisualNavigation-component"##"Carousel-component" is displayed
      And I see the count of elements Experience.Content.TemplateElement with data-testid "VisualNavigation-component","CarouselItem" is equal to <count>
      And I see Experience.Content.TemplateElement with data-testid "VisualNavigation-component"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "VisualNavigation-component"##"smart-cards-card-title-text-0" is displayed
      And I see Experience.Content.TemplateElement with data-testid "VisualNavigation-component","smart-cards-card-title-text-0" contains text "Skinny"
    When I hover over Experience.Content.TemplateElement with data-testid "VisualNavigation-component","ResponsiveImage-component",1
    Then I see Experience.Content.TemplateElement with data-testid "VisualNavigation-component"##"smart-cards-card-arrow-icon-0"##1 is displayed
    When I click on Experience.Content.TemplateElement with data-testid "VisualNavigation-component","ResponsiveImage-component",1
    Then I wait until the current page is loaded
      And I see URL should contain "<href-1>"
      And I navigate back in the browser
      And I wait until the current page is loaded
      And I see Experience.Content.TemplateElement with data-testid "VisualNavigation-component"##"ResponsiveImage-component"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "VisualNavigation-component"##"smart-cards-card-title-text-1" is displayed
      And I see Experience.Content.TemplateElement with data-testid "VisualNavigation-component","smart-cards-card-title-text-1" contains text "Mom Jeans"
    When I hover over Experience.Content.TemplateElement with data-testid "VisualNavigation-component","ResponsiveImage-component",2
    Then I see Experience.Content.TemplateElement with data-testid "VisualNavigation-component"##"smart-cards-card-arrow-icon-1" is displayed
    When I click on Experience.Content.TemplateElement with data-testid "VisualNavigation-component","ResponsiveImage-component",2
    Then I wait until the current page is loaded
      And I see URL should contain "<href-2>"

    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                       | href-1                               | href-2            | count |
      | uk     | /cms-debug?contentPageId=Automated-test-4 | /womens-skinny-fit-jeans-tommy-jeans | /womens-mom-jeans | 8     |

    @ExcludeCK @ExcludeDB0
    Examples:
      | locale | url                                       | href-1                   | href-2                        | count |
      | uk     | /cms-debug?contentPageId=Automated-test-4 | /womens-skinny-fit-jeans | /womens-mom-jeans-tommy-jeans | 4     |

    @ExcludeTH @ExcludeUat
    Examples:
      | locale | url                                       | href-1               | href-2           | count |
      | uk     | /cms-debug?contentPageId=Automated-test-4 | /womens-skinny-jeans | /women-mom-jeans | 8     |

    @ExcludeTH @ExcludeDB0
    Examples:
      | locale | url                                       | href-1               | href-2           | count |
      | uk     | /cms-debug?contentPageId=Automated-test-4 | /womens-skinny-jeans | /women-mom-jeans | 4     |


  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @Module @P2
  @feature:TEX-15258
  @tms:UTR-18273
  Scenario Outline: Unified SEO - Verify the logo in the header have a crawlable link
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.BrandLogo
    Then I wait until Experience.Content.BrandLogo is displayed
      And I see Experience.Content.BrandLogoLink with href <href> is clickable
     
    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                     | href                          |
      | uk     | /women                                  | https://uk.devtestp.tommy.com |
      | uk     | /men                                    | https://uk.devtestp.tommy.com |
      | uk     | /kids                                   | https://uk.devtestp.tommy.com |
      | uk     | /crochet-crew-neck-jumper-ww0ww39004c66 | https://uk.devtestp.tommy.com |

    @ExcludeCK @ExcludeDB0
    Examples:
      | locale | url                                     | href                         |
      | uk     | /                                       | https://uk.b2ceuup.tommy.com |
      | uk     | /women                                  | https://uk.b2ceuup.tommy.com |
      | uk     | /men                                    | https://uk.b2ceuup.tommy.com |
      | uk     | /kids                                   | https://uk.b2ceuup.tommy.com |
      | uk     | /crochet-crew-neck-jumper-ww0ww39004c66 | https://uk.b2ceuup.tommy.com |

    @ExcludeTH @ExcludeUat
    Examples:
      | locale | url                               | href                                |
      | uk     | /kids                             | https://uk.devtestp.calvinklein.com |
      | uk     | /logo-patch-t-shirt-j20j222170beh | https://uk.devtestp.calvinklein.com |

    @ExcludeTH @ExcludeDB0
    Examples:
      | locale | url                               | href                           |
      | uk     | /                                 | https://b2ceuup.calvinklein.uk |
      | uk     | /women                            | https://b2ceuup.calvinklein.uk |
      | uk     | /men                              | https://b2ceuup.calvinklein.uk |
      | uk     | /kids                             | https://b2ceuup.calvinklein.uk |
      | uk     | /logo-patch-t-shirt-j20j222170beh | https://b2ceuup.calvinklein.uk |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @P2
  @feature:DD-5870
  @tms:UTR-18543
  Scenario Outline: Verify olapic cookies are set only after accepting the cookies for women/men GLP pages
    Given I am on locale <locale> of url <url>
      And I wait until the current page is loaded
      And olapic cookies should not be set
    When I am on locale <locale> of url <url> with forced accepted cookies
    Then I wait until the current page is loaded
      And I wait for 5 seconds
      And olapic cookies should be set
     
    @ExcludeCK
    Examples:
      | locale | url     |
      | uk     | /women  |
      | uk     | /men    |
      | de     | /damen  |
      | de     | /herren |
      | nl     | /dames  |
      | nl     | /heren  |