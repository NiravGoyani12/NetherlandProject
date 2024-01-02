Feature: Unified Content - Black Friday

  #@FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedBlackFriday @UnifiedExperience @Module @P2
  @feature:EEI-11359
  @tms:UTR-18074
  Scenario Outline: Unified Black Friday - Verify early access content is visible when user signing up from sign up form and exclusive access cookie is set to blackfriday
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "Promo-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "Promo-component"##1 is displayed
      And I see Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is not displayed
      And I see Experience.Content.TemplateImageByIndex with data-testid "Splash-module"##1 is not displayed
      And I see Experience.Header.SignInButton is clickable
    When I click on Experience.Header.SignInButton
    Then I see Experience.Content.SignInFormElement with data-testid "header-pvh-login-form" is displayed
      And I see Experience.Content.SignInFormElement with data-testid "email-inputField" is displayed
      And I type "<EmailAddress>" in the field Experience.Content.SignInFormElement with data-testid "email-inputField"
      And I see Experience.Content.SignInFormElement with data-testid "password-inputField" is displayed
      And I type "<Password>" in the field Experience.Content.SignInFormElement with data-testid "password-inputField"
      And I see Experience.Content.SignInFormElement with data-testid "login-form-submit-pvh-button" is displayed
    When I click on Experience.Content.SignInFormElement with data-testid "login-form-submit-pvh-button"
    Then I wait until Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is displayed
      And I see Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is displayed
      And I see Experience.Content.TemplateImageByIndex with data-testid "Splash-module"##1 is displayed
      And cookie exclusive_access should have parameter value set to blackfriday
      
    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                         | EmailAddress                   | Password   |
      | uk     | cms-debug?contentPageId=Automated-test-BF-1 | automation.test.user@gmail.com | qwerty1234 |

    @ExcludeTH @ExcludeUat
    Examples:
      | locale | url                                         | EmailAddress                           | Password   |
      | uk     | cms-debug?contentPageId=Automated-test-BF-1 | automation.test.user07112023@gmail.com | qwerty1234 |

  #@FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedBlackFriday @UnifiedExperience @Module @P2
  @feature:EEI-11359
  @tms:UTR-18075
  Scenario Outline: Unified Black Friday - Verify early access content is visible when user signing up from Newsletter footer and exclusive access cookie is set to blackfriday
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "Promo-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "Promo-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "Promo-component"##"Promo-subtitle"##1 is in viewport
      And I see Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is not displayed
      And I see Experience.Content.TemplateImageByIndex with data-testid "Splash-module"##1 is not displayed
      And I see Experience.Content.TemplateBlock with data-testid "MembershipBanner-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "MembershipBanner-component","pvh-button",1 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "MembershipBanner-component","pvh-button",1
    Then I see Experience.Content.SignInFormElement with data-testid "pvh-button" is displayed
    When I click on Experience.Content.SignInFormElement with data-testid "pvh-button"
    Then I see Experience.Content.SignInFormElement with data-testid "membership-banner-pvh-login-form" is displayed
      And I see Experience.Content.SignInFormElement with data-testid "email-inputField" is displayed
      And I type "<EmailAddress>" in the field Experience.Content.SignInFormElement with data-testid "email-inputField"
      And I see Experience.Content.SignInFormElement with data-testid "password-inputField" is displayed
      And I type "<Password>" in the field Experience.Content.SignInFormElement with data-testid "password-inputField"
      And I see Experience.Content.SignInFormElement with data-testid "login-form-submit-pvh-button" is displayed
    When I click on Experience.Content.SignInFormElement with data-testid "login-form-submit-pvh-button"
    Then I wait until Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is displayed
      And I see Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is displayed
      And I see Experience.Content.TemplateImageByIndex with data-testid "Splash-module"##1 is displayed
      And cookie exclusive_access should have parameter value set to blackfriday

    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                         | EmailAddress                   | Password   |
      | uk     | cms-debug?contentPageId=Automated-test-BF-1 | automation.test.user@gmail.com | qwerty1234 |

  #@FullRegression 
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedBlackFriday @UnifiedExperience @Module @P2
  @feature:EEI-11356
  @tms:UTR-18252
  Scenario Outline: Unified Black Friday - Verify early access content is visible when user sign-in/register and exclusive access cookie is set to blackfriday
    Given There is 1 account
      And I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "Promo-component"
    Then I wait until Experience.Content.TemplateBlock with data-testid "Promo-component" is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "Promo-component"##1 is displayed
      And I see Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is not displayed
      And I see Experience.Content.TemplateImageByIndex with data-testid "Splash-module"##1 is not displayed
      And I see Experience.Header.SignInButton is clickable
    When I click on Experience.Header.SignInButton
    Then I see Experience.Content.SignInFormElement with data-testid "header-pvh-login-form" is displayed
      And I see Experience.Content.SignInFormElement with data-testid "register-pvh-button" is displayed
    When I click on Experience.Content.SignInFormElement with data-testid "register-pvh-button"
    Then I see Experience.Content.SignInFormElement with data-testid "email-inputField" is displayed
      And I see Experience.Content.SignInFormElement with data-testid "password-inputField" is displayed
      And I see Experience.Content.SignInFormElement with data-testid "terms-Checkbox-Component-icon" is displayed
      And I see Experience.Content.SignInFormElement with data-testid "register-form-submit-pvh-button" is displayed
      And I type "user1#email" in the field Experience.Content.SignInFormElement with data-testid "email-inputField"
      And I type "user1#password" in the field Experience.Content.SignInFormElement with data-testid "password-inputField"
      And I set the checkbox Experience.Content.SignInFormElement with data-testid "terms-Checkbox-Component-icon" status to true
    When I click on Experience.Content.SignInFormElement with data-testid "register-form-submit-pvh-button"
    Then I wait until Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is displayed
      And I see Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is displayed
      And I see Experience.Content.TemplateImageByIndex with data-testid "Splash-module"##1 is displayed 
      And cookie exclusive_access should have parameter value set to blackfriday   
      
    @ExcludeTH @ExcludeUat
    Examples:
      | locale | url                                         |
      | uk     | cms-debug?contentPageId=Automated-test-BF-1 |

  #@FullRegression 
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedBlackFriday @UnifiedExperience @Module @P2
  @feature:EEI-11354
  @tms:UTR-18278
  Scenario Outline: Unified Black Friday - Verify PDP promo code & percentage is displayed in the Promo code placement
    Given There is 1 account
      And I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
      And I see Experience.Content.PromoCodePlacement is not displayed
      And I see Experience.Header.SignInButton is clickable
    When I click on Experience.Header.SignInButton
    Then I see Experience.Content.SignInFormElement with data-testid "header-pvh-login-form" is displayed
      And I see Experience.Content.SignInFormElement with data-testid "email-inputField" is displayed
      And I type "<EmailAddress>" in the field Experience.Content.SignInFormElement with data-testid "email-inputField"
      And I see Experience.Content.SignInFormElement with data-testid "password-inputField" is displayed
      And I type "<Password>" in the field Experience.Content.SignInFormElement with data-testid "password-inputField"
      And I see Experience.Content.SignInFormElement with data-testid "login-form-submit-pvh-button" is displayed
    When I click on Experience.Content.SignInFormElement with data-testid "login-form-submit-pvh-button"
    Then I wait until Experience.Content.PromoCodePlacement is displayed 
      And cookie exclusive_access should have parameter value set to blackfriday 
      And I see Experience.Content.PromoCodeTitle contains text "VIP access to Black Friday"
      And I see Experience.Content.PromoCodeSubTitle contains text "30% off selected styles. Use code VIP30 at checkout."
      And I see Experience.Content.PromoCodeButton is displayed
      And I see Experience.Content.PromoCodeButton contains text "VIP30"
      And I see Experience.Content.PromoCodeCopy is displayed
      
    @ExcludeTH @ExcludeUat
    Examples:
      | locale | url                                                 | EmailAddress                           | Password   |
      | uk     | /lace-high-waisted-bikini-briefs-ck96-000qf7177eub1 | automation.test.user07112023@gmail.com | qwerty1234 |

  #@FullRegression 
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedBlackFriday @UnifiedExperience @Module @P2
  @feature:EEI-11328
  @tms:UTR-18457
  Scenario Outline: Unified Black Friday - Verify USP Banner Exclusive access visibility if the promotion is active
    Given There is 1 account
      And I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "AnnouncementsBanner-component",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "AnnouncementsBanner-component"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "AnnouncementsBanner-component"##"AnnouncementsBannerSlideElement"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "AnnouncementsBanner-component"##"AnnouncementsBannerItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "AnnouncementsBanner-component","AnnouncementsBannerItem",1 contains text "<text-1>"
    When I click on Experience.Header.SignInButton
    Then I see Experience.Content.SignInFormElement with data-testid "header-pvh-login-form" is displayed
      And I see Experience.Content.SignInFormElement with data-testid "email-inputField" is displayed
      And I type "<EmailAddress>" in the field Experience.Content.SignInFormElement with data-testid "email-inputField"
      And I see Experience.Content.SignInFormElement with data-testid "password-inputField" is displayed
      And I type "<Password>" in the field Experience.Content.SignInFormElement with data-testid "password-inputField"
      And I see Experience.Content.SignInFormElement with data-testid "login-form-submit-pvh-button" is displayed
    When I click on Experience.Content.SignInFormElement with data-testid "login-form-submit-pvh-button"
    Then I wait for 20 seconds
      And cookie exclusive_access should have parameter value set to blackfriday
      And I see Experience.Content.TemplateElement with data-testid "AnnouncementsBanner-component"##"AnnouncementsBannerSlideElement"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "AnnouncementsBanner-component"##"AnnouncementsBannerItem"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "AnnouncementsBanner-component","AnnouncementsBannerItem",1 contains text "<text-2>"
      
    @ExcludeTH @ExcludeUat
    Examples:
      | locale | url | EmailAddress                           | Password   | text-1                                        | text-2           |
      | uk     | /   | automation.test.user07112023@gmail.com | qwerty1234 | VIP Access to Black Friday is live. Shop now. | VIP content here | 

    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url | EmailAddress                           | Password   | text-1                              | text-2                                            |
      | uk     | /   | automation.test.user07112023@gmail.com | qwerty1234 | Black Friday - Non Exclusive for CR | Black Friday - Exclusive access visibility for CR |
