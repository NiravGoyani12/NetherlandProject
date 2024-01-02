Feature: Membership and Loyalty - Pop up

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari @Translation @Lokalise
  @EER @M&L @UnifiedPopUp @P2
  @tms:UTR-13268
  Scenario Outline: User can see membership pop up and sign up benefits
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I delete all cookies and refresh
    When I am on home page with accepted cookies
      And I navigate to page <page>
      And I get translation from lokalise for "MembershipBenefitsTitle" and store it with key #BenefitsTitle
      And I get translation from lokalise for "MembershipBenefitsInfo" and store it with key #BenefitsInfo
    Then I see Experience.MLPopUp.BenefitsTitle contains text "#BenefitsTitle"
      And I see Experience.MLPopUp.BenefitsInfo contains text "#BenefitsInfo"
      And I see Experience.MLPopUp.RegisterButton is displayed
      And I see Experience.MLPopUp.CloseButton is displayed
      And I see MyAccount.Newsletter.PopUp is not displayed

    Examples:
      | locale           | langCode         | page                  |
      | default          | default          | no-search-result-page |
      | multiLangDefault | multiLangDefault | wishlist              |
      | default          | default          | shopping-bag          |

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari @Translation @Lokalise
  @EER @M&L @UnifiedPopUp @tms:UTR-13281
  Scenario Outline: User can register to tommy together from membership pop up
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And There is 1 account
      And I delete all cookies and refresh
      And I am on home page with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I wait until Experience.MLPopUp.RegisterButton is clickable
    When I click on Experience.MLPopUp.RegisterButton
      And I type "user1#email" in the field Experience.MLRegisterForm.Email
      And I type "11" in the field Experience.MLRegisterForm.BirthDay
      And I type "11" in the field Experience.MLRegisterForm.BirthMonth
      And I type "1990" in the field Experience.MLRegisterForm.BirthYear
      And in dropdown Experience.MLRegisterForm.Gender I select the option by index "2"
      And I click on Experience.MLRegisterForm.NewsletterCheckbox
      And I click on Experience.MLRegisterForm.BecomeMemberButton
      And I get translation from lokalise for "MembershipSignUpMessage" and store it with key #SignUpSuccess
      And I get translation from lokalise for "MembershipSignUpTitle" and store it with key #SignUpSuccessTitle
    Then I see Experience.MLRegisterForm.MembeshipSignUpSuccessMessage contains text "#SignUpSuccess"
      And I see Experience.MLRegisterForm.MembershipSignUpSuccessTitle contains text "#SignUpSuccessTitle"

    Examples:
      | locale           | langCode         | page          |
      | multiLangDefault | multiLangDefault | pdp           |
      | default          | default          | shopping-bag  |
      | multiLangDefault | multiLangDefault | store-locator |

