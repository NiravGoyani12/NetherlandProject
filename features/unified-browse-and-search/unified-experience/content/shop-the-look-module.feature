Feature: Unified Content - Shop The Look Module

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedShopTheLookModule @UnifiedExperience @Module @P1
  @tms:UTR-15389
  Scenario Outline: Unified Shop The Look Module - Verify shop the look module template is shown along with content for desktop
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "ShopTheLook-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "ShopTheLook-component" is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "ShopTheLook-component"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "ShopTheLook-component"##1 is in viewport
      And I see Experience.Content.TemplateButtonLink with data-testid "ShopTheLook-component"##<href-1>##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateCarouselArrowButton with data-testid "ShopTheLook-component"##1 is displayed
      And I see Experience.Content.TemplateCarouselArrowButton with data-testid "ShopTheLook-component"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"CarouselItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"scene7image-picture"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"WishListAdornment-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"PriceText"##1 is displayed
      And I see Experience.Content.TemplateProductTitleByIndex with data-testid "ShopTheLook-component"##"ShopTheLook_productTitle__nWK7d"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"CarouselItem"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"scene7image-picture"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"WishListAdornment-component"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"PriceText"##2 is displayed
      And I see Experience.Content.TemplateProductTitleByIndex with data-testid "ShopTheLook-component"##"ShopTheLook_productTitle__nWK7d"##2 is displayed
      And the count of elements Experience.Content.TemplateElement with data-testid "ShopTheLook-component","CarouselItem" is equal to <count>
                                    
    @ExcludeTH
    Examples:
      | locale | url                                       | href-1     | count |
      | uk     | cms-debug?contentPageId=Automated-test-1  | /sport-men | 15    |

    @ExcludeCK
    Examples:
      | locale | url                                       | href-1         | count |
      | uk     | cms-debug?contentPageId=Automated-test-1  | /womens-skirts | 17    |

  @FullRegression
  @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedShopTheLookModule @UnifiedExperience @Module @P1
  @tms:UTR-15390
  Scenario Outline: Unified Shop The Look Module - Verify shop the look module template is shown along with content for mobile
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "ShopTheLook-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "ShopTheLook-component" is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "ShopTheLook-component"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "ShopTheLook-component"##1 is in viewport
      And I see Experience.Content.TemplateButtonLink with data-testid "ShopTheLook-component"##<href-1>##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"CarouselItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"scene7image-picture"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"WishListAdornment-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"PriceText"##1 is displayed
      And I see Experience.Content.TemplateProductTitleByIndex with data-testid "ShopTheLook-component"##"ShopTheLook_productTitle__nWK7d"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"CarouselItem"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"scene7image-picture"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"WishListAdornment-component"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"PriceText"##2 is displayed
      And I see Experience.Content.TemplateProductTitleByIndex with data-testid "ShopTheLook-component"##"ShopTheLook_productTitle__nWK7d"##2 is displayed
      And the count of elements Experience.Content.TemplateElement with data-testid "ShopTheLook-component","CarouselItem" is equal to <count>
                                    
    @ExcludeTH
    Examples:
      | locale | url                                       | href-1     | count |
      | uk     | cms-debug?contentPageId=Automated-test-1  | /sport-men | 15    | 

    @ExcludeCK
    Examples:
      | locale | url                                      | href-1         | count |
      | uk     | cms-debug?contentPageId=Automated-test-1 | /womens-skirts | 17    |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedShopTheLookModule @UnifiedExperience @Module @P3
  @tms:UTR-15391
  Scenario Outline: Unified Shop The Look Module - Verify shop the look module template while clicking on a product in carousel redirects to the PDP page of the respective product
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "ShopTheLook-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "ShopTheLook-component" is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "ShopTheLook-component"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "ShopTheLook-component"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"CarouselItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"scene7image-picture"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"WishListAdornment-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"PriceText"##1 is displayed
      And I see Experience.Content.TemplateProductTitleByIndex with data-testid "ShopTheLook-component"##"ShopTheLook_productTitle__nWK7d"##1 is displayed
      And I see Experience.Content.TemplateCarouselItemByLink with data-testid "ShopTheLook-component",<href-1> is clickable
    When I click on Experience.Content.TemplateCarouselItemByLink with data-testid "ShopTheLook-component",<href-1>
    Then And I wait until the current page is loaded
      And URL should contain "<href-1>"
      And I see the current page is PDP
      
                                    
    @ExcludeTH
    Examples:
      | locale | url                                       | href-1                    |
      | uk     | cms-debug?contentPageId=Automated-test-1  | /gym-shorts-00gmf2s811bae |

    @ExcludeCK
    Examples:
      | locale | url                                       | href-1                                                                  |
      | uk     | cms-debug?contentPageId=Automated-test-1  | /tommy-hilfiger-x-vacation-floral-print-ruched-maxi-skirt-ww0ww401650lp |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedShopTheLookModule @UnifiedExperience @Module @P3
  @tms:UTR-15392
    Scenario Outline: Unified Shop The Look Module - Verify shop the look module cta redirects to the associated page
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "ShopTheLook-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "ShopTheLook-component" is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "ShopTheLook-component"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "ShopTheLook-component"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateButtonLink with data-testid "ShopTheLook-component",<href-1>,1 is clickable
    When I click on Experience.Content.TemplateButtonLink with data-testid "ShopTheLook-component",<href-1>,1
    Then And I wait for 2 seconds
      And URL should contain "<href-1>"

    @ExcludeTH
    Examples:
      | locale | url                                      | href-1     |
      | uk     | cms-debug?contentPageId=Automated-test-1 | /sport-men |

    @ExcludeCK
    Examples:
      | locale | url                                       | href-1         |
      | uk     | cms-debug?contentPageId=Automated-test-1  | /womens-skirts |

  # @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedShopTheLookModule @UnifiedExperience @Module @P3
  @tms:UTR-16826
    Scenario Outline: Unified Shop The Look Module - Verify Exclusive product label is displayed and the product is accessed by Members Logged In and the Wishlist icon should toggle add/remove to Wishlist
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "ShopTheLook-component",2
    Then I wait until Experience.Content.TemplateBlock with data-testid "ShopTheLook-component"##2 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "ShopTheLook-component"##2 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "ShopTheLook-component"##2 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"ResponsiveImage-component"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"Carousel-component"##2 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "CarouselItem"##17 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "scene7image-picture"##17 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "ProductLabel-component",10 contains text "EXCLUSIVE"
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "MembersOnlyLabel-component"##2 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "icon-utility-lock-svg"##2 is displayed
      And I see Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "PlpMemberOnlyActionIconAdornment-component"##"icon-lock-svg"##2 is displayed
      And I see Experience.Header.SignInButton is clickable
    When I click on Experience.Header.SignInButton
    Then I see Experience.Content.SignInFormElement with data-testid "header-pvh-login-form" is displayed
      And I see Experience.Content.SignInFormElement with data-testid "email-inputField" is displayed
      And I type "<EmailAddress>" in the field Experience.Content.SignInFormElement with data-testid "email-inputField"
      And I see Experience.Content.SignInFormElement with data-testid "password-inputField" is displayed
      And I type "<Password>" in the field Experience.Content.SignInFormElement with data-testid "password-inputField"
      And I see Experience.Content.SignInFormElement with data-testid "login-form-submit-pvh-button" is displayed
    When I click on Experience.Content.SignInFormElement with data-testid "login-form-submit-pvh-button"
    Then I scroll to the element Experience.Content.TemplateBlock with data-testid "ShopTheLook-component",2
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "CarouselItem"##17 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "scene7image-picture"##17 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "ProductLabel-component",10 contains text "EXCLUSIVE"
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "MembersOnlyLabel-component"##2 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "icon-utility-unlocked-svg"##2 is displayed
      And I see Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "PlpMemberOnlyActionIconAdornment-component"##"icon-lock-svg"##2 is not displayed
      And I see Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "WishListAdornment-component"##"icon-utility-wishlist-svg"##17 is displayed
    When I click on Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "WishListAdornment-component","icon-utility-wishlist-svg",17
    Then I wait until Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "WishListAdornment-component"##"icon-utility-wishlist-filled-svg"##1 is displayed
      And I see Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "WishListAdornment-component"##"icon-utility-wishlist-filled-svg"##1 is displayed
      And I click on Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "WishListAdornment-component","icon-utility-wishlist-filled-svg",1

    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                      | EmailAddress                   | Password   |
      | uk     | cms-debug?contentPageId=Automated-test-1 | automation.test.user@gmail.com | qwerty1234 |

  # @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedShopTheLookModule @UnifiedExperience @Module @P3
  @tms:UTR-16827
    Scenario Outline: Unified Shop The Look Module - Verify Exclusive product lable is displayed and the product is accessed by users subscribed to the Newsletter and the Wishlist icon should toggle add/remove to Wishlist
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "ShopTheLook-component",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "ShopTheLook-component"##1 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "ShopTheLook-component"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "ShopTheLook-component"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "CarouselItem"##3 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "scene7image-picture"##3 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "ProductLabel-component",3 contains text "exclusiva"
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "MembersOnlyLabel-component"##1 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "icon-utility-lock-svg"##1 is displayed
      And I see Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "PlpMemberOnlyActionIconAdornment-component"##"icon-lock-svg"##1 is displayed
    When I click on Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "CarouselItem",3
    Then I wait until the current page is loaded
      And I see Experience.Content.NewsLetterSubscribeLockIcon is displayed
      And I see Experience.Content.NewsLetterSubscribeButton is clickable
    When I click on Experience.Content.NewsLetterSubscribeButton
    Then I see Experience.Content.NewsLetterPopUp is displayed
      And I see Experience.Content.NewsLetterEmailInput is displayed
      And I see Experience.Content.NewsLetterSubmitButton is clickable
      And And I type "test@test.com" in the field Experience.Content.NewsLetterEmailInput
      And I set the checkbox Experience.Content.NewsLetterCheckBox with index 1 status to true
    When I click on Experience.Content.NewsLetterSubmitButton
    Then I see Experience.Content.NewsLetterSignUpSuccess is displayed
      And I see Experience.Content.NewsLetterPopUpCloseButton is displayed
    When I click on Experience.Content.NewsLetterPopUpCloseButton
    Then I see Experience.Content.NewsLetterSubscribeUnlockIcon is displayed
      And I navigate back in the browser
      And I wait until the current page is loaded
      And I scroll to the element Experience.Content.TemplateBlock with data-testid "ShopTheLook-component",1
      And I see Experience.Content.TemplateTitleByIndex with data-testid "ShopTheLook-component"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "ShopTheLook-component"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "CarouselItem"##3 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "scene7image-picture"##3 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "ProductLabel-component",3 contains text "exclusiva"
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "MembersOnlyLabel-component"##1 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "icon-utility-unlocked-svg"##1 is displayed
      And I see Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "PlpMemberOnlyActionIconAdornment-component"##"icon-lock-svg"##1 is not displayed
      And I see Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "WishListAdornment-component"##"icon-utility-wishlist-svg"##3 is displayed
    When I click on Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "WishListAdornment-component","icon-utility-wishlist-svg",3
    Then I see Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "WishListAdornment-component"##"icon-utility-wishlist-filled-svg"##1 is displayed
      And I click on Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "WishListAdornment-component","icon-utility-wishlist-filled-svg",1

    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                      |
      | es     | cms-debug?contentPageId=content-test-500 |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedShopTheLookModule @UnifiedExperience @Module @P3
  @tms:UTR-17051
    Scenario Outline: Unified Shop The Look Module - Verify Exclusive product label is displayed and the product is not accessed by Members not Logged In
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "ShopTheLook-component",2
    Then I wait until Experience.Content.TemplateBlock with data-testid "ShopTheLook-component"##2 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "ShopTheLook-component"##2 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "ShopTheLook-component"##2 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"ResponsiveImage-component"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"Carousel-component"##2 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "CarouselItem"##17 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "scene7image-picture"##17 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "ProductLabel-component",10 contains text "EXCLUSIVE"
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "MembersOnlyLabel-component"##2 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "icon-utility-lock-svg"##2 is displayed
      And I see Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "PlpMemberOnlyActionIconAdornment-component"##"icon-lock-svg"##2 is displayed
    When I click on Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "PlpMemberOnlyActionIconAdornment-component","icon-lock-svg",2
    Then I see Experience.Content.SignInFormElement with data-testid "header-pvh-login-form" is displayed
      And I see Experience.Content.SignInFormElement with data-testid "email-inputField" is displayed
   
    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                      |
      | uk     | cms-debug?contentPageId=Automated-test-1 |

  # @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedShopTheLookModule @UnifiedExperience @Module @P3
  @tms:UTR-17052
    Scenario Outline: Unified Shop The Look Module - Verify Exclusive product lable is displayed and the product is not accessed by users not subscribed to the Newsletter
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "ShopTheLook-component",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "ShopTheLook-component"##1 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "ShopTheLook-component"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "ShopTheLook-component"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "CarouselItem"##3 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "scene7image-picture"##3 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "ProductLabel-component",3 contains text "exclusiva"
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "MembersOnlyLabel-component"##1 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "icon-utility-lock-svg"##1 is displayed
      And I see Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "PlpMemberOnlyActionIconAdornment-component"##"icon-lock-svg"##1 is displayed
    When I click on Experience.Content.ShopTheLookWishlistButtonByIndex with data-testid "PlpMemberOnlyActionIconAdornment-component","icon-lock-svg",1
    Then I see Experience.Content.NewsLetterPopUp is displayed
      And I see Experience.Content.NewsLetterEmailInput is displayed
      And I see Experience.Content.NewsLetterSubmitButton is clickable

    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                      |
      | es     | cms-debug?contentPageId=content-test-500 |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedShopTheLookModule @UnifiedExperience @Module @P3
  @feature:TEC-5341 
  @tms:UTR-17148
  Scenario Outline: Unified Shop The Look Module - Verify the alt text for carousel element should have format as expected
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "ShopTheLook-component",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "ShopTheLook-component"##1 is in viewport
      And I see Experience.Content.TemplateTitleByIndex with data-testid "ShopTheLook-component"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "ShopTheLook-component"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "ShopTheLook-component"##"Carousel-component"##1 is displayed
      And I see Experience.Content.ShopTheLookTemplateCarouselItemElement with data-testid "CarouselItem"##1 is displayed
      And I see the attribute alt of element Experience.Content.ShopTheLookTemplateCarouselItemImgElement with index 1 containing "<text>"

    @ExcludeCK
    Examples:
      | locale | url                                      | text                                                                                     | 
      | uk     | cms-debug?contentPageId=Automated-test-1 | yellow tommy hilfiger x vacation floral print ruched maxi skirt for women tommy hilfiger |

    @ExcludeTH
    Examples:
      | locale | url                                      | text                                     | 
      | uk     | cms-debug?contentPageId=Automated-test-1 | black gym t-shirt for men ck performance |