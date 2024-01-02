Feature: Membership and Loyalty - Registration Page

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L @P2
  @feature:EER-12410 @tms:UTR-14566
  Scenario Outline: M&L - User see all the components in "Become a Member" on register page
    Given I am on locale <locale> of url /register of langCode <langCode> with accepted cookies
    Then I see Experience.MLRegisterForm.MembershipLogo is displayed
      And I see Experience.MLRegisterForm.Email is displayed
      And I see Experience.MLRegisterForm.BirthDay is displayed
      And I see Experience.MLRegisterForm.BirthMonth is displayed
      And I see Experience.MLRegisterForm.BirthYear is displayed
      And I see Experience.MLRegisterForm.DiscountText is displayed
      And I see Experience.MLRegisterForm.Gender is displayed
      And I see Experience.MLRegisterForm.NewsletterCheckbox is displayed
      And I see Experience.MLRegisterForm.BecomeMemberButton is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L
  @feature:EER-12410 @tms:UTR-15033
  Scenario Outline: M&L - User is able to register successfully from register page
    Given There is 1 account
    When I am on locale <locale> of url /register of langCode <langCode> with accepted cookies
      And I type "user1#email" in the field Experience.MLRegisterForm.Email
      And I type "11" in the field Experience.MLRegisterForm.BirthDay
      And I type "11" in the field Experience.MLRegisterForm.BirthMonth
      And I type "1990" in the field Experience.MLRegisterForm.BirthYear
      And in dropdown Experience.MLRegisterForm.Gender I select the option by index "<gender>"
      And I click on Experience.MLRegisterForm.NewsletterCheckbox
      And I click on Experience.MLRegisterForm.BecomeMemberButton
    Then I see Experience.MLRegisterForm.MembeshipSignUpSuccessMessage is displayed
      And I see Experience.MLRegisterForm.CloseButton is displayed

    @P1
    Examples:
      | locale           | langCode         | gender |
      | multiLangDefault | multiLangDefault | 1      |

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L @P2 @Translation @Lokalise
  @feature:EER-12410 @tms:UTR-15034
  Scenario Outline: M&L - Inline errors when user is already registered in register page
    Given I am on locale <locale> of url /register of langCode <langCode> with accepted cookies
    When I type "autouser213@getairmail.com" in the field Experience.MLRegisterForm.Email
      And I type "12" in the field Experience.MLRegisterForm.BirthDay
      And I type "02" in the field Experience.MLRegisterForm.BirthMonth
      And I type "2000" in the field Experience.MLRegisterForm.BirthYear
      And in dropdown Experience.MLRegisterForm.Gender I select the option by index "2"
      And I click on Experience.MLRegisterForm.NewsletterCheckbox
      And I click on Experience.MLRegisterForm.BecomeMemberButton
      And I get translation from lokalise for "ExistingAccountError" and store it with key #ExistingAccountError
    Then I see Experience.MLRegisterForm.EmailError contains text "#ExistingAccountError"

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L @P2 @Translation @Lokalise
  @feature:EER-12410 @tms:UTR-15035
  Scenario Outline: M&L - Inline errors are displayed when wrong/empty email entered in register page
    Given I am on locale <locale> of url /register of langCode <langCode> with accepted cookies
    When I type "<email>" in the field MyAccount.RegisterPopUp.EmailField
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
      And I get translation from lokalise for "<expectedError>" and store it with key #ExpectedError
    Then I see MyAccount.RegisterPopUp.<errorElement> contains text "#ExpectedError"

    Examples:
      | locale           | langCode         | email            | errorElement | expectedError     |
      | multiLangDefault | multiLangDefault | invalidEmail@pvh | EmailError   | EmailError        |
      | default          | default          |                  | EmailError   | EmailMissingError |

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L @P2 @Translation @Lokalise
  @feature:EER-12410 @tms:UTR-15036
  Scenario Outline: M&L - Inline errors are displayed when wrong/invalid DOB entered in register page
    Given I am on locale <locale> of url /register of langCode <langCode> with accepted cookies
    When I type "50" in the field MyAccount.RegisterPopUp.DayField
      And I type "50" in the field MyAccount.RegisterPopUp.MonthField
      And I type "0000" in the field MyAccount.RegisterPopUp.YearField
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
      And I get translation from lokalise for "invalidDOB" and store it with key #invalidDOB
    Then I see Experience.MLRegisterForm.DOBError contains text "#invalidDOB"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L @Translation @Lokalise
  @tms:UTR-18059
  Scenario Outline: M&L - User should be 18 years old to register himself on register page
    Given There is 1 account
    When I am on locale <locale> of url <url> of langCode <langCode> with accepted cookies
    Then I type "user1#email" in the field Experience.MLRegisterForm.Email
      And I type "11" in the field Experience.MLRegisterForm.BirthDay
      And I type "11" in the field Experience.MLRegisterForm.BirthMonth
      And I type "2020" in the field Experience.MLRegisterForm.BirthYear
      And in dropdown Experience.MLRegisterForm.Gender I select the option by index "2"
      And I click on Experience.MLRegisterForm.NewsletterCheckbox
    When I click on Experience.MLRegisterForm.BecomeMemberButton
      And I get translation from lokalise for "RegisterAgeError" and store it with key #RegisterAgeError
    Then I see Experience.MLRegisterForm.EmailError contains text "#RegisterAgeError"

    Examples:
      | locale  | langCode | url       |
      | default | default  | /register |
