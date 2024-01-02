Feature: Unified My Account - Register

  @FullRegression @RCTest
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @Register @P1 @ExcludeTH
  @tms:UTR-3628
  @feature:PPL-305
  Scenario Outline: I can successfully register
    Given There is 1 account
      And I am on shopping-bag page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type "user1#email" in the field MyAccount.RegisterPopUp.EmailField
      And I type "user1#password" in the field MyAccount.RegisterPopUp.PasswordField
      And I click on MyAccount.RegisterPopUp.TermsAndConditionsCheckbox
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
      And I scroll to and click on MyAccount.RegisterPopUp.NewsletterNoButton
    Then I see the current page is shopping-bag

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation
  @UnifiedMyAccount @PPL @Register @P3 @ExcludeTH
  @tms:UTR-15944
  @feature:PPL-305
  Scenario Outline: As a user after registering a new account, multilang language is kept in the URL on my Account page
    Given There is 1 account
      And I am on wishlist page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type "user1#email" in the field MyAccount.RegisterPopUp.EmailField
      And I type "user1#password" in the field MyAccount.RegisterPopUp.PasswordField
      And I click on MyAccount.RegisterPopUp.TermsAndConditionsCheckbox
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
      And I scroll to and click on MyAccount.RegisterPopUp.NewsletterNoButton
    Then I see the current page is wlp
      And I get translation for "UrlLang" and store it with key #Language
    When I navigate to details page
      And URL should contain "#Language"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile @Translation @Lokalise
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @Register @P2 @ExcludeTH
  @feature:PPL-305 @feature:PPL-299
  Scenario Outline: Inline errors are displayed when all validations for registration are not met
    Given I am on shopping-bag page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type "<email>" in the field MyAccount.RegisterPopUp.EmailField
      And I type "<password>" in the field MyAccount.RegisterPopUp.PasswordField
      And I click on MyAccount.RegisterPopUp.TermsAndConditionsCheckbox
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
      And I get translation from lokalise for "<expectedError>" and store it with key #ExpectedError
    Then I see MyAccount.RegisterPopUp.<errorElement> contains text "#ExpectedError"

    @tms:UTR-3629
    Examples:
      | locale           | langCode         | email            | password     | errorElement | expectedError |
      | multiLangDefault | multiLangDefault | invalidEmail@pvh | abcdef123456 | EmailError   | EmailError    |

    @tms:UTR-14570
    Examples:
      | locale  | langCode | email | password     | errorElement | expectedError     |
      | default | default  |       | abcdef123456 | EmailError   | EmailMissingError |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @Register @P2 @ExcludeTH
  @tms:UTR-3627 @Translation @Lokalise
  @feature:PPL-305
  @issue:PPL-1534
  Scenario Outline: Error message appears if the email is already registered
    Given There is 1 account
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I sign up with email user1#email and password user1#password
      And I wait for 2 seconds
      And I sign out
      And I wait for 2 seconds
    When I am on shopping-bag page with sign in flyout open on locale <locale> of langCode <langCode>
      And I click on MyAccount.RegisterPopUp.RegisterFormButton
      #Registered with the same email address used above
      And I type "user1#email" in the field MyAccount.RegisterPopUp.EmailField
      And I type "user1#password" in the field MyAccount.RegisterPopUp.PasswordField
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
  @UnifiedMyAccount @PPL @Register @P2 @ExcludeTH
  @tms:UTR-4604 @Translation @Lokalise
  @feature:PPL-305
  Scenario Outline: User can see password requirements when registering
    Given I am on shopping-bag page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type "tester@testing.com" in the field MyAccount.RegisterPopUp.EmailField
      And I type "abcd12" in the field MyAccount.RegisterPopUp.PasswordField
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
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @Register @P2 @ExcludeTH
  @feature:PPL-305
  Scenario Outline: User can see password requirements error when using consecutive characters or instances
    Given There is 1 account
      And I am on shopping-bag page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type "user1#email" in the field MyAccount.RegisterPopUp.EmailField
      And I type "<pass>" in the field MyAccount.RegisterPopUp.PasswordField
      And I click on MyAccount.RegisterPopUp.TermsAndConditionsCheckbox
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
      And I get translation from lokalise for "<ErrorMessage>" and store it with key #PassError
    Then I see MyAccount.RegisterPopUp.RegisterationError contains text "#PassError"

    @tms:UTR-12812
    Examples:
      | locale           | langCode         | pass        | ErrorMessage                  |
      | multiLangDefault | multiLangDefault | abccc21453f | PasswordConsecutiveCharacters |

    @tms:UTR-14573
    Examples:
      | locale  | langCode | pass            | ErrorMessage                  |
      | default | default  | abc1111dsfg2134 | PasswordConsecutiveCharacters |

    @tms:UTR-14574
    Examples:
      | locale           | langCode         | pass         | ErrorMessage                  |
      | multiLangDefault | multiLangDefault | qq1qq2q12345 | PasswordMaxInstanceCharacters |