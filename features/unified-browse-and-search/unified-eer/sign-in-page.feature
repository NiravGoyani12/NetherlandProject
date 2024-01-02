Feature: Unified Sign in Page (External Sign in request through Social Media)

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @EER @UnifiedSignIn @UnifiedExperience @P1
  @feature:EER-12410 @tms:UTR-14733 @issue:PPL-2226
  Scenario Outline: User can successfully signin and signout with valid email and password in sign in page
    Given I am on locale <locale> of url /signin of langCode <langCode> with forced accepted cookies
    When I sign in with email automation.test.user@gmail.com and password qwerty1234
    And I wait for 5 seconds
    Then I can sign out
    And I see Experience.SessionExpiryPopUp.ItemTitle is not displayed in 5 seconds

    Examples:
      | locale           | langCode         |
      | default          | default          |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @EER @UnifiedSignIn @UnifiedExperience @P2 @Translation @Lokalise
  @feature:EER-12410 @tms:UTR-15037
  Scenario Outline: Inline errors are displayed when invalid/empty email or password is given in sign in page
    Given I am on locale <locale> of url /signin of langCode <langCode> with forced accepted cookies
    When I sign in with user "<email>" and password "<password>"
      And I get translation from lokalise for "<expectedError>" and store it with key #ExpectedError
    Then I see MyAccount.SignInPopUp.<errorElement> contains text "#ExpectedError"

    Examples:
      | locale           | langCode         | email                           | password | errorElement  | expectedError            |
      | multiLangDefault | multiLangDefault | invalidEmail@pvh                | abc123   | EmailError    | EmailError               |
      | default          | default          |                                 | abc123   | EmailError    | EmailMissingError        |
      | default          | default          | test@test.com                   |          | PasswordError | MandatoryField           |
      | multiLangDefault | multiLangDefault | cross.site.automation@gmail.com | abcd1234 | SignInError   | UserAndPasswordDontMatch |
      | multiLangDefault | multiLangDefault | test@test.com                   | abc      | PasswordError | PasswordMinMax           |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @EER @UnifiedSignIn @UnifiedExperience @P2
  @feature:EER-12410 @tms:UTR-15038
  Scenario Outline: User can sign out from myaccount and redirect to homepage
    Given There is 1 account
    When I am on locale <locale> of url /signin of langCode <langCode> with forced accepted cookies
      And I sign in with email automation.test.user@gmail.com and password qwerty1234
      And I see Experience.Header.MyAccountButton is displayed in 10 seconds
    When I sign out
    Then I see the current page is Homepage

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @EER @UnifiedSignIn @UnifiedExperience @P2
  @feature:EER-12410 @tms:UTR-15039
  Scenario Outline: User can select forgot password to recover password in sign in page
    Given There is 1 account
      And I am on locale <locale> of url /signin of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.SignInPopUp.ForgotPasswordLink
      And I type "user1#email" in the field MyAccount.SignInPopUp.ForgotPasswordEmailField
      And I click on MyAccount.SignInPopUp.ForgotPasswordSendButton
    Then I see MyAccount.SignInPopUp.PasswordResetMessage is displayed
      And I see MyAccount.SignInPopUp.PasswordResetCloseButton is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @EER @UnifiedSignIn @UnifiedExperience @P3 @Translation @Lokalise
  @feature:EER-12410 @tms:UTR-15040
  Scenario Outline: User cannot recover password for an invalid email from sign in page
    Given I am on locale <locale> of url /signin of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.SignInPopUp.ForgotPasswordLink
      And I type "notfoundemail@pvh" in the field MyAccount.SignInPopUp.ForgotPasswordEmailField
      And I click on MyAccount.SignInPopUp.ForgotPasswordSendButton
      And I get translation from lokalise for "EmailError" and store it with key #ExpectedError
    Then I see MyAccount.SignInPopUp.ForgotPasswordEmailError contains text "#ExpectedError"
      And I see MyAccount.SignInPopUp.PasswordResetMessage is not displayed
      And I see MyAccount.SignInPopUp.PasswordResetCloseButton is not displayed

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @EER @UnifiedSignIn @UnifiedExperience
  @feature:EER-12410 @tms:UTR-15041
  Scenario Outline: Hovers over second level mega menu sign in page and checked menu should be display options
    Given I am on locale <locale> of url /signin of langCode <langCode> with forced accepted cookies
    Then I see Experience.UXHeader.MegaMenuSecondLevelItems with text Women is displayed
    Then I see Experience.UXHeader.MegaMenuSecondLevelItems with text Men is displayed
    Then I see Experience.UXHeader.MegaMenuSecondLevelItems with text Kids is displayed
    When I hover over Experience.UXHeader.MegaMenuSecondLevelItems with text Women
      And I wait until Experience.UXHeader.MegaMenuThirdLevelLinks with index 1 is clickable
      And I hover over Experience.UXHeader.ShoppingBasketIcon
    Then I see Experience.UXHeader.MegaMenuThirdLevelLinks with index 1 is not displayed
    When I hover over Experience.UXHeader.MegaMenuSecondLevelItems with text Men
      And I wait until Experience.UXHeader.MegaMenuThirdLevelHrefByIndex with href mens-boxers,1 is clickable
      And I hover over Experience.UXHeader.ShoppingBasketIcon
    Then I see Experience.UXHeader.MegaMenuThirdLevelHrefByIndex with href mens-boxers,1 is not displayed

    Examples:
      | locale | langCode |
      | ee      | default  |
