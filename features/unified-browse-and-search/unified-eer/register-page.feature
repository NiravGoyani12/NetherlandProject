Feature: Unified Register page (External Sign in request through Social Media)

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @EER @UnifiedRegister @UnifiedExperience @P1
  @feature:EER-12410 @tms:UTR-14734 @ExcludeTH
  Scenario Outline: CK - I can successfully register from register page
    Given There is 1 account
    When I am on locale <locale> of url /register of langCode <langCode> with forced accepted cookies
      And I type "user1#email" in the field MyAccount.RegisterPopUp.EmailField
      And I type "user1#password" in the field MyAccount.RegisterPopUp.PasswordField
      And I type "user1#password" in the field MyAccount.RegisterPopUp.RepeatPasswordField
      And I type "11" in the field MyAccount.RegisterPopUp.DayField
      And I type "11" in the field MyAccount.RegisterPopUp.MonthField
      And I type "1990" in the field MyAccount.RegisterPopUp.YearField
      And I click on MyAccount.RegisterPopUp.TermsAndConditionsCheckbox
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
    Then I see the current page is MyAccount page

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @EER @UnifiedRegister @UnifiedExperience @P1
  @feature:EER-12410 @tms:UTR-17226 @ExcludeCK
  Scenario Outline: TH - I can successfully register from register page
    Given There is 1 account
    When I am on locale <locale> of url /register of langCode <langCode> with forced accepted cookies
      And I type "user1#email" in the field MyAccount.RegisterPopUp.EmailField
      And I type "11" in the field MyAccount.RegisterPopUp.DayField
      And I type "11" in the field MyAccount.RegisterPopUp.MonthField
      And I type "1990" in the field MyAccount.RegisterPopUp.YearField
      And I click on MyAccount.RegisterPopUp.TermsAndConditionsCheckbox
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
    Then I see MyAccount.RegisterPopUp.CheckYourInboxMessage is displayed

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @EER @UnifiedRegister @UnifiedExperience @P2 @Translation @Lokalise
  @feature:EER-12410 @ExcludeTH
  Scenario Outline: CK - Inline errors are displayed when all validations for registration are not met in register page
    Given I am on locale <locale> of url /register of langCode <langCode> with forced accepted cookies
    When I type "<email>" in the field MyAccount.RegisterPopUp.EmailField
      And I type "<password>" in the field MyAccount.RegisterPopUp.PasswordField
      And I type "<repeatpassword>" in the field MyAccount.RegisterPopUp.RepeatPasswordField
      And I type "11" in the field MyAccount.RegisterPopUp.DayField
      And I type "12" in the field MyAccount.RegisterPopUp.MonthField
      And I type "1990" in the field MyAccount.RegisterPopUp.YearField
      And I click on MyAccount.RegisterPopUp.TermsAndConditionsCheckbox
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
      And I get translation from lokalise for "<expectedError>" and store it with key #errorKey
    Then I see MyAccount.RegisterPopUp.<errorElement> contains text "#errorKey"

    @tms:UTR-15042
    Examples:
      | locale           | langCode         | email            | password     | repeatpassword | errorElement | expectedError |
      | multiLangDefault | multiLangDefault | invalidEmail@pvh | abcdef123456 | abcdef123456   | EmailError   | EmailError    |

    @tms:UTR-17625
    Examples:
      | locale  | langCode | email | password     | repeatpassword | errorElement | expectedError     |
      | default | default  |       | abcdef123456 | abcdef123456   | EmailError   | EmailMissingError |

    @tms:UTR-17626
    Examples:
      | locale           | langCode         | email         | password | repeatpassword | errorElement        | expectedError  |
      | multiLangDefault | multiLangDefault | test@test.com |          |                | RepeatPasswordError | MandatoryField |

    @tms:UTR-17627
    Examples:
      | locale  | langCode | email         | password     | repeatpassword | errorElement        | expectedError      |
      | default | default  | test@test.com | abcdef123456 | abcdef111111   | RepeatPasswordError | PasswordsDontMatch |

    @tms:UTR-17628
    Examples:
      | locale           | langCode         | email                 | password    | repeatpassword | errorElement       | expectedError                 |
      | multiLangDefault | multiLangDefault | blahblahtest@test.com | abccc21453f | abccc21453f    | RegisterationError | PasswordConsecutiveCharacters |

    @tms:UTR-17629
    Examples:
      | locale           | langCode         | email                  | password     | repeatpassword | errorElement       | expectedError                 |
      | multiLangDefault | multiLangDefault | blahblahtest2@test.com | qq1qq2q12345 | qq1qq2q12345   | RegisterationError | PasswordMaxInstanceCharacters |

    @tms:UTR-17688
    Examples:
      | locale  | langCode | email                  | password    | repeatpassword | errorElement       | expectedError        |
      | default | default  | blahblahtest2@test.com | Test@123456 | Test@123456    | RegisterationError | ExistingAccountError |


  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @EER @UnifiedRegister @UnifiedExperience @P2 @Translation @Lokalise
  @feature:EER-12410 @ExcludeCK
  Scenario Outline: TH - Inline errors are displayed when all validations for registration are not met in register page
    Given I am on locale <locale> of url /register of langCode <langCode> with forced accepted cookies
    When I type "<email>" in the field MyAccount.RegisterPopUp.EmailField
      And I type "11" in the field MyAccount.RegisterPopUp.DayField
      And I type "12" in the field MyAccount.RegisterPopUp.MonthField
      And I type "1990" in the field MyAccount.RegisterPopUp.YearField
      And I click on MyAccount.RegisterPopUp.TermsAndConditionsCheckbox
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
      And I get translation from lokalise for "<expectedError>" and store it with key #errorKey
    Then I see MyAccount.RegisterPopUp.<errorElement> contains text "#errorKey"

    @tms:UTR-17630
    Examples:
      | locale           | langCode         | email            | errorElement | expectedError |
      | multiLangDefault | multiLangDefault | invalidEmail@pvh | EmailError   | EmailError    |

    @tms:UTR-17631
    Examples:
      | locale  | langCode | email | errorElement | expectedError     |
      | default | default  |       | EmailError   | EmailMissingError |

    @tms:UTR-17632
    Examples:
      | locale           | langCode         | email                  | errorElement       | expectedError        |
      | multiLangDefault | multiLangDefault | blahblahtest2@test.com | RegisterationError | EmailAlreadyMemberTH |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @EER @UnifiedRegister @UnifiedExperience @P2 @Translation @Lokalise
  @feature:EER-12410 @tms:UTR-15043 @ExcludeTH
  Scenario Outline: CK - Error message appears if the email is already registered in register page
    Given There is 1 account
      And I am on locale <locale> of url /register of langCode <langCode> with forced accepted cookies
      And I wait for 1 seconds
      And I sign up with email user1#email and password user1#password
      And I sign out
      And I wait for 2 seconds
    When I am on locale <locale> of url /register of langCode <langCode> with forced accepted cookies
      #Registered with the same email address used above
      And I type "user1#email" in the field MyAccount.RegisterPopUp.EmailField
      And I type "user1#password" in the field MyAccount.RegisterPopUp.PasswordField
      And I type "user1#password" in the field MyAccount.RegisterPopUp.RepeatPasswordField
      And I click on MyAccount.RegisterPopUp.TermsAndConditionsCheckbox
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
      And I get translation from lokalise for "AlreadyRegisteredEmail" and store it with key #EmailAlreadyRegistered
    Then I see MyAccount.RegisterPopUp.RegisterationError contains text "#EmailAlreadyRegistered"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @EER @UnifiedRegister @UnifiedExperience @P2 @Translation @Lokalise
  @feature:EER-12410 @tms:UTR-17633 @ExcludeCK
  Scenario Outline: TH - Error message appears if the email is already registered in register page
    Given There is 1 account
    When I am on locale <locale> of url /register of langCode <langCode> with forced accepted cookies
      And I wait for 1 seconds
    Then I sign up with email user1#email only
      And I wait for 2 seconds
    When I am on locale <locale> of url /register of langCode <langCode> with forced accepted cookies
      And I wait until MyAccount.RegisterPopUp.EmailField is clickable
      #Registered with the same email address used above
    Then I type "user1#email" in the field MyAccount.RegisterPopUp.EmailField
    When I click on MyAccount.RegisterPopUp.TermsAndConditionsCheckbox
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
      And I get translation from lokalise for "EmailAlreadyMemberTH" and store it with key #EmailAlreadyRegistered
    Then I see MyAccount.RegisterPopUp.RegisterationError contains text "#EmailAlreadyRegistered"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @EER @UnifiedRegister @UnifiedExperience @P2 @Translation @Lokalise
  @feature:EER-12410 @tms:UTR-15046 @ExcludeTH
  Scenario Outline: User can see password requirements when registering in register page
    Given I am on locale <locale> of url /register of langCode <langCode> with forced accepted cookies
    When I type "tester@testing.com" in the field MyAccount.RegisterPopUp.EmailField
      And I type "abcd12" in the field MyAccount.RegisterPopUp.PasswordField
      And I type "abcd12" in the field MyAccount.RegisterPopUp.RepeatPasswordField
      And I get translation from lokalise for "PasswordAlphabetic" and store it with key #PassAlphabetic
      And I get translation from lokalise for "PasswordNumeric" and store it with key #PassNumeric
      And I get translation from lokalise for "RegisterPasswordMinMax" and store it with key #PassMinMax
    Then I see MyAccount.RegisterPopUp.PasswordErrorList with index 1 contains text "#PassAlphabetic"
      And I see MyAccount.RegisterPopUp.PasswordErrorList with index 2 contains text "#PassNumeric"
      And I see MyAccount.RegisterPopUp.PasswordErrorList with index 3 contains text "#PassMinMax"

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @EER @UnifiedRegister @UnifiedExperience @P2 @Translation @Lokalise
  @feature:EER-12410 @tms:UTR-15047
  Scenario Outline: Inline errors are displayed when wrong/invalid DOB entered in register page
    Given I am on locale <locale> of url /register of langCode <langCode> with forced accepted cookies
    When I type "50" in the field MyAccount.RegisterPopUp.DayField
      And I type "50" in the field MyAccount.RegisterPopUp.MonthField
      And I type "0000" in the field MyAccount.RegisterPopUp.YearField
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
      And I get translation from lokalise for "invalidDOB" and store it with key #invalidDOB
    Then I see MyAccount.RegisterPopUp.DOBError contains text "#invalidDOB"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @EER @UnifiedRegister @UnifiedExperience @ExcludeCK
  @feature:EER-12410 @tms:UTR-17644
  Scenario Outline: TH - User can redirect to faq page when click on customer service link after registration
    Given There is 1 account
    When I am on locale <locale> of url /register of langCode <langCode> with forced accepted cookies
      And I type "user1#email" in the field MyAccount.RegisterPopUp.EmailField
      And I type "11" in the field MyAccount.RegisterPopUp.DayField
      And I type "11" in the field MyAccount.RegisterPopUp.MonthField
      And I type "1990" in the field MyAccount.RegisterPopUp.YearField
      And I set the checkbox MyAccount.RegisterPopUp.TermsAndConditionsCheckbox status to true if exist
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
    Then I see MyAccount.RegisterPopUp.CheckYourInboxMessage is displayed
      And I see MyAccount.RegisterPopUp.CustomerServiceLink is displayed
    When I click on MyAccount.RegisterPopUp.CustomerServiceLink
      And I wait until the current page is loaded
    Then I see URL should contain "faqs"

    Examples:
      | locale  | langCode |
      | default | default  |
