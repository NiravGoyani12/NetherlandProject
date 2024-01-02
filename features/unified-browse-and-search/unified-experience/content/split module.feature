Feature: Unified Content - Split Module

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSplitModule @UnifiedExperience @Module @P1
  @tms:UTR-15591
  Scenario Outline: Unified Split Module - Verify split module template is shown along with content
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "split-container",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "split-container"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "split-container"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "split-container"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "split-container","cta-pvh-button",1 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "split-container","cta-pvh-button",1
    Then I wait until the current page is loaded
     And I see the current page is PLP

    @ExcludeCK                                            
    Examples:
      | locale | url                                       |
      | uk     | /cms-debug?contentPageId=Automated-test-1 |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSplitModule @UnifiedExperience @Module @P1
  @tms:UTR-15592
  Scenario Outline: Unified Split Module - Verify split module newsletter sign-up template is shown along with content
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "split-container",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "split-container"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"NewsletterSignUpForm-component-title"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "split-container"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-form-email-inputField"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-banner-form-submit-pvh-button"##1 is displayed
    When I click on Experience.Content.TemplateElement with data-testid "split-container","newsletter-form-email-inputField",1
    Then I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-men-Checkbox-Component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-men-Checkbox-Component-icon"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-men-Checkbox-Component-content"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-women-Checkbox-Component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-women-Checkbox-Component-icon"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-women-Checkbox-Component-content"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-kids-Checkbox-Component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-kids-Checkbox-Component-icon"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-kids-Checkbox-Component-content"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-terms-Checkbox-Component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-terms-Checkbox-Component-icon"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-terms-Checkbox-Component-content"##1 is displayed
      And I see Experience.Content.TemplateSplitNewsLetterDownArrowByIndex with data-testid "split-container"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"SignUpTerms-truncatedText"##1 is displayed
                                                       
    Examples:
      | locale | url                                       |
      | uk     | /cms-debug?contentPageId=Automated-test-2 |  

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSplitModule @UnifiedExperience @Module @P2
  @tms:UTR-15593
  Scenario Outline: Unified Split Module - Verify split module campaign template is shown along with content
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "split-container",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "split-container"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"CampaignTitle-name-typography-h6"##1 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "split-container"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "split-container"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "split-container","cta-pvh-button",1 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "split-container","cta-pvh-button",1
    Then I wait until the current page is loaded
     And I see the current page is PLP
     And I navigate back in the browser
     And I wait until the current page is loaded
     And I see Experience.Content.TemplateElement with data-testid "split-container","cta-pvh-button",2 is clickable
    When I click on Experience.Content.TemplateElement with data-testid "split-container","cta-pvh-button",2
    Then I wait until the current page is loaded
     And I see the current page is PLP
      
    @ExcludeUat                                                   
    Examples:
      | locale | url                                       |
      | uk     | /cms-debug?contentPageId=Automated-test-1 |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSplitModule @UnifiedExperience @Module @P3
  @tms:UTR-15698
  Scenario Outline: Unified Split Module - Verify split module template countdown timer is shown
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "split-container",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "split-container"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "split-container"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "split-container"##1 is in viewport
      And I see Experience.Content.TemplateCounterHours with data-testid "split-container" is displayed
      And I see Experience.Content.TemplateCounterHoursText with data-testid "split-container" contains text "hr"
      And I see Experience.Content.TemplateCounterMinutes with data-testid "split-container" is displayed
      And I see Experience.Content.TemplateCounterMinutesText with data-testid "split-container" contains text "min"
      And I see Experience.Content.TemplateElement with data-testid "split-container","cta-pvh-button",1 is clickable
                
    @ExcludeTH @ExcludeUat
    Examples:
      | locale | url                                       |
      | uk     | /cms-debug?contentPageId=Automated-test-3 |

    @ExcludeCK @ExcludeUat 
    Examples:
      | locale | url                                       |
      | uk     | /cms-debug?contentPageId=Automated-test-4 |
 
  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSplitModule @UnifiedExperience @Module @P2
  @tms:UTR-15699
  Scenario Outline: Unified Split Module - Verify split module newsletter sign-up successfully
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "split-container",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "split-container"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"NewsletterSignUpForm-component-title"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "split-container"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-form-email-inputField"##1 is displayed
    When I click on Experience.Content.TemplateElement with data-testid "split-container","newsletter-form-email-inputField",1
    Then I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-men-Checkbox-Component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-women-Checkbox-Component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-kids-Checkbox-Component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-terms-Checkbox-Component"##1 is displayed
      And I type "<emailaddress>" in the field Experience.Content.TemplateElement with data-testid "split-container","newsletter-form-email-inputField",1
      And I set the checkbox Experience.Content.TemplateElement with data-testid "split-container","newsletter-men-Checkbox-Component-icon" status to true
      And I set the checkbox Experience.Content.TemplateElement with data-testid "split-container","newsletter-terms-Checkbox-Component-icon" status to true
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-banner-form-submit-pvh-button"##1 is displayed
    When I click on Experience.Content.TemplateElement with data-testid "split-container","newsletter-banner-form-submit-pvh-button",1
    Then I see Experience.Content.TemplateElement with data-testid "split-container","NewsletterSignUpSuccess-component-title",1 contains text "<SignUpFormSuccessTitle>"
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "split-container",1 contains text "<SignUpFormSuccessSubTitle>"
                                                       
    @ExcludeCK
    Examples:
      | locale | url                                       | emailaddress        | SignUpFormSuccessTitle  | SignUpFormSuccessSubTitle |
      | uk     | /cms-debug?contentPageId=Automated-test-2 | testEmail@gmail.com | form submitted          | Explore More              |
    
    @ExcludeTH
    Examples:
      | locale | url                                       | emailaddress        | SignUpFormSuccessTitle         | SignUpFormSuccessSubTitle |
      | uk     | /cms-debug?contentPageId=Automated-test-2 | testEmail@gmail.com | sign up successfully submitted | Explore Next              |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSplitModule @UnifiedExperience @Module @P2
  @tms:UTR-15700
  Scenario Outline: Unified Split Module - Verify split module newsletter sign-up email negative behaviours
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "split-container",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "split-container"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"NewsletterSignUpForm-component-title"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "split-container"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-form-email-inputField"##1 is displayed
    When I click on Experience.Content.TemplateElement with data-testid "split-container","newsletter-form-email-inputField",1
    Then I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-men-Checkbox-Component"##1 is displayed
      And I type "<emailaddress>" in the field Experience.Content.TemplateElement with data-testid "split-container","newsletter-form-email-inputField",1
      And I set the checkbox Experience.Content.TemplateElement with data-testid "split-container","newsletter-men-Checkbox-Component-icon" status to true
      And I set the checkbox Experience.Content.TemplateElement with data-testid "split-container","newsletter-terms-Checkbox-Component-icon" status to true
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-banner-form-submit-pvh-button"##1 is displayed
    When I click on Experience.Content.TemplateElement with data-testid "split-container","newsletter-banner-form-submit-pvh-button",1
    Then I see Experience.Content.TemplateElement with data-testid "split-container"##"NewsletterSignUpSuccess-component-title"##1 is not displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container","alert-error-newsletter-form-email",1 contains text "<SignUpFormInputError>"
                                                       
    Examples:
      | locale | url                                       | emailaddress   | SignUpFormInputError                           |
      | uk     | /cms-debug?contentPageId=Automated-test-2 | 123            | Sorry, that doesn't look like an email address |
      | uk     | /cms-debug?contentPageId=Automated-test-2 | testemail@     | Sorry, that doesn't look like an email address |
      | uk     | /cms-debug?contentPageId=Automated-test-2 | test_123@gmail | Sorry, that doesn't look like an email address |
      | uk     | /cms-debug?contentPageId=Automated-test-2 | test.com       | Sorry, that doesn't look like an email address |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSplitModule @UnifiedExperience @Module @P2
  @tms:UTR-15701
  Scenario Outline: Unified Split Module - Verify split module event form is shown along with content
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "split-container",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "split-container"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"DateBadge-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"split-event-form-module"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"CampaignTitle-component"##1 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "split-container"##1 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "split-container"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"email-inputField"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"email-inputLabelText"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"answer-textarea"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"termsAgreement-Checkbox-Component-icon"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"termsAgreement-Checkbox-Component-content"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"icon-utility-chevron-down-svg"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"event-sign-up-form-submit-pvh-button"##1 is displayed
                                                           
    @ExcludeCK
    Examples:
      | locale | url                                       |
      | uk     | /cms-debug?contentPageId=Automated-test-3 |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSplitModule @UnifiedExperience @Module @P2
  @tms:UTR-15702
  Scenario Outline: Unified Split Module - Verify split module event form is Submitted successfully
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "split-container",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "split-container"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"DateBadge-component"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"split-event-form-module"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"CampaignTitle-component"##1 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "split-container"##1 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "split-container"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"email-inputField"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"email-inputLabelText"##1 is displayed
      And I type "<emailaddress>" in the field Experience.Content.TemplateElement with data-testid "split-container","email-inputField",1
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"answer-textarea"##1 is displayed
      And I type "<AnswerText>" in the field Experience.Content.TemplateElement with data-testid "split-container","answer-textarea",1
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"termsAgreement-Checkbox-Component-icon"##1 is displayed
      And I set the checkbox Experience.Content.TemplateElement with data-testid "split-container","termsAgreement-Checkbox-Component-icon",1 status to true
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"event-sign-up-form-submit-pvh-button"##1 is displayed
    When I click on Experience.Content.TemplateElement with data-testid "split-container","event-sign-up-form-submit-pvh-button",1
    Then I see Experience.Content.TemplateElement with data-testid "split-container","NewsletterSignUpSuccess-component-title",1 contains text "<EventFormSuccessTitle>"
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "split-container",1 contains text "<EventFormSuccessSubTitle>"
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"cta-pvh-button"##1 is displayed


    @ExcludeCK
    Examples:
      | locale | url                                       | emailaddress        | AnswerText | EventFormSuccessTitle  | EventFormSuccessSubTitle                                                                                                                                   |
      | uk     | /cms-debug?contentPageId=Automated-test-3 | testEmail@gmail.com | Test       | Thanks for Signing Up! | Keep an eye on your inbox to find out if you will be our lucky winner, plus stay tuned for the next chapter in our sustainability story with Shawn Mendes. |
  
  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedSplitModule @UnifiedExperience @Module @P3
  @tms:UTR-16674
  Scenario Outline: Unified Split Module - Event Sign up - Verify Event Sign up form content appears as expected and email gets populated on form when registered user signed in successfully
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "split-container",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "split-container"##1 is in viewport
      And I see Experience.Header.SignInButton is clickable
    When I click on Experience.Header.SignInButton
    Then I see Experience.Content.SignInFormElement with data-testid "header-pvh-login-form" is displayed
      And I see Experience.Content.SignInFormElement with data-testid "email-inputField" is displayed
      And I type "<EmailAddress>" in the field Experience.Content.SignInFormElement with data-testid "email-inputField"
      And I see Experience.Content.SignInFormElement with data-testid "password-inputField" is displayed
      And I type "<Password>" in the field Experience.Content.SignInFormElement with data-testid "password-inputField"
      And I see Experience.Content.SignInFormElement with data-testid "login-form-submit-pvh-button" is displayed
    When I click on Experience.Content.SignInFormElement with data-testid "login-form-submit-pvh-button"
    Then I scroll to the element Experience.Content.TemplateBlock with data-testid "split-container",2
      And I see Experience.Content.TemplateBlock with data-testid "split-container"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"ResponsiveImage-component"##2 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "split-container"##1 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "split-container"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"email-inputField"##1 is displayed
      And I see the attribute value of element Experience.Content.SplitContainerEmailInputField containing "<EmailAddress>"
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"answer-textarea"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"termsAgreement-Checkbox-Component-icon"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"sign-up-terms-component"##2 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"event-sign-up-form-submit-pvh-button"##1 is displayed

    Examples:
      | locale | url                                       | EmailAddress                   | Password   |
      | uk     | /cms-debug?contentPageId=Automated-test-2 | automation.test.user@gmail.com | qwerty1234 |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedSplitModule @UnifiedExperience @Module @P3
  @feature:DD-5665
  @tms:UTR-18095
  Scenario Outline: Unified Split Module - Verify split module template countdown timer is displayed on sign up form and also displayed after sign up
    Given I am on locale <locale> of url <url> with forced accepted cookies
      And I wait until the current page is loaded
    When I scroll to the element Experience.Content.TemplateBlock with data-testid "split-container",1
    Then I wait until Experience.Content.TemplateBlock with data-testid "split-container"##1 is in viewport
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"ResponsiveImage-component"##1 is displayed
      And I see Experience.Content.TemplateTitleByIndex with data-testid "split-container"##1 is displayed
      And I see Experience.Content.TemplateSubTitleByIndex with data-testid "split-container"##1 is in viewport
      And I see Experience.Content.TemplateCounterHours with data-testid "split-container" is displayed
      And I see Experience.Content.TemplateCounterHoursText with data-testid "split-container" contains text "hr"
      And I see Experience.Content.TemplateCounterMinutes with data-testid "split-container" is displayed
      And I see Experience.Content.TemplateCounterMinutesText with data-testid "split-container" contains text "min"
      And I see Experience.Content.TemplateCounterSeconds with data-testid "split-container" is displayed
      And I see Experience.Content.TemplateCounterSecondsText with data-testid "split-container" contains text "sec"
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-form-email-inputField"##1 is displayed
    When I click on Experience.Content.TemplateElement with data-testid "split-container","newsletter-form-email-inputField",1
    Then I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-men-Checkbox-Component-icon"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container"##"newsletter-terms-Checkbox-Component-icon"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container","newsletter-banner-form-submit-pvh-button",1 is clickable
      And I type "<EmailAddress>" in the field Experience.Content.TemplateElement with data-testid "split-container","newsletter-form-email-inputField",1
      And I set the checkbox Experience.Content.TemplateElement with data-testid "split-container","newsletter-men-Checkbox-Component-icon",1 status to true
      And I set the checkbox Experience.Content.TemplateElement with data-testid "split-container","newsletter-terms-Checkbox-Component-icon",1 status to true
    When I click on Experience.Content.TemplateElement with data-testid "split-container","newsletter-banner-form-submit-pvh-button",1
    Then I see Experience.Content.TemplateElement with data-testid "split-container"##"NewsletterSignUpSuccess-component-title"##1 is displayed
      And I see Experience.Content.TemplateElement with data-testid "split-container","NewsletterSignUpSuccess-component-title",1 contains text "Thank You"
      And I see Experience.Content.TemplateCounterHours with data-testid "split-container" is displayed
      And I see Experience.Content.TemplateCounterHoursText with data-testid "split-container" contains text "hr"
      And I see Experience.Content.TemplateCounterMinutes with data-testid "split-container" is displayed
      And I see Experience.Content.TemplateCounterMinutesText with data-testid "split-container" contains text "min"
      And I see Experience.Content.TemplateCounterSeconds with data-testid "split-container" is displayed
      And I see Experience.Content.TemplateCounterSecondsText with data-testid "split-container" contains text "sec"
      
    @ExcludeCK @ExcludeUat
    Examples:
      | locale | url                                          | EmailAddress  |
      | uk     | /cms-debug?contentPageId=Automated-test-BF-1 | test@test.com |