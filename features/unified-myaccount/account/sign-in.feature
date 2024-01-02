Feature: Unified My Account - Sign in

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @SignIn @issue:PPL-2226
  @feature:PPL-306 @feature:CET1-4494
  Scenario Outline: User can successfully signin and signout with valid email and password
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I wait for 3 seconds
    When I sign in with email automation.test.user@gmail.com and password qwerty1234
      And I wait for 5 seconds
    Then I can sign out
      And I wait for 3 seconds
      And I see the current page is <page>
      And I see Experience.SessionExpiryPopUp.ItemTitle is not displayed in 5 seconds

    @P1 @SmokeTest @RCTest @tms:UTR-3594 
    Examples:
      | locale  | langCode | page         |
      | default | default  | shopping-bag |

    @P1 @SmokeTest @RCTest @tms:UTR-14575
    Examples:
      | locale           | langCode         | page      |
      | multiLangDefault | multiLangDefault | home-page |

    @P2 @tms:UTR-14581
    Examples:
      | locale | langCode | page |
      | ee     | default  | PLP  |

    @P2 @tms:UTR-14576
    Examples:
      | locale           | langCode         | page |
      | multiLangDefault | multiLangDefault | wlp  |

    @P2 @tms:UTR-14577 @issue:TEX-15324
    Examples:
      | locale | langCode | page          |
      | pl     | default  | store-locator |

    @P2 @tms:UTR-14578 @issue:TEX-15324
    Examples:
      | locale           | langCode         | page |
      | multiLangDefault | multiLangDefault | pdp  |

    @P2 @tms:UTR-14579
    Examples:
      | locale | langCode | page       |
      | at     | default  | search-plp |

    @P2 @tms:UTR-14580 @issue:TEX-15324
    Examples:
      | locale           | langCode         | page |
      | multiLangDefault | multiLangDefault | glp  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @SignIn @P2
  @feature:PPL-306
  Scenario Outline: Inline errors are displayed when invalid email or password is given
    Given I am on shopping-bag page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
    When I sign in with user "<email>" and password "<password>"
      And I get translation from lokalise for "<expectedError>" and store it with key #ExpectedError
    Then I see MyAccount.SignInPopUp.<errorElement> contains text "#ExpectedError"

    @tms:UTR-3593
    Examples:
      | locale           | langCode         | email            | password | errorElement | expectedError |
      | multiLangDefault | multiLangDefault | invalidEmail@pvh | abc123   | EmailError   | EmailError    |

    @tms:UTR-14582
    Examples:
      | locale  | langCode | email | password | errorElement | expectedError     |
      | default | default  |       | abc123   | EmailError   | EmailMissingError |

    # @tms:UTR-14583
    # Examples:
    #   | locale           | langCode         | email         | password | errorElement  | expectedError  |
    #   | multiLangDefault | multiLangDefault | test@test.com | abc      | PasswordError | PasswordMinMax |

    @tms:UTR-14584
    Examples:
      | locale  | langCode | email         | password | errorElement  | expectedError  |
      | default | default  | test@test.com |          | PasswordError | MandatoryField |

    @tms:UTR-14585 @issue:ECSUP-19548
    Examples:
      | locale           | langCode         | email                         | password | errorElement | expectedError            |
      | multiLangDefault | multiLangDefault | pvh.test.automation@gmail.com | abcd1234 | SignInError  | UserAndPasswordDontMatch |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @SignIn @P2
  @feature:PPL-405 @tms:UTR-4067
  @issue:TEX-15324
  Scenario Outline: User can sign out
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I sign in with email my.account.pierre.automation@outlook.com and password AutoNation2023
      And I wait for 3 seconds
      And I navigate to page shopping-bag
    When I sign out
      And I click on MyAccount.SignInPopUp.CloseSignInPopUp if displayed
    Then I see the current page is shopping-bag

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @ForgotPassword @P1
  @feature:PPL-307 @tms:UTR-3921
  Scenario Outline: User can select forgot password to recover password
    Given There is 1 account
      And I am on shopping-bag page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.SignInPopUp.ForgotPasswordLink
      And I type "user1#email" in the field MyAccount.SignInPopUp.ForgotPasswordEmailField
      And I click on MyAccount.SignInPopUp.ForgotPasswordSendButton
    Then I see MyAccount.SignInPopUp.PasswordResetMessage is displayed
      And I see MyAccount.SignInPopUp.PasswordResetCloseButton is displayed

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @ForgotPassword @P3
  @feature:PPL-307 @tms:UTR-3922
  Scenario Outline: User cannot recover password for an unregistered email
    Given I am on shopping-bag page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.SignInPopUp.ForgotPasswordLink
      And I type "pvh" in the field MyAccount.SignInPopUp.ForgotPasswordEmailField
      And I click on MyAccount.SignInPopUp.ForgotPasswordSendButton
      And I get translation from lokalise for "EmailError" and store it with key #ExpectedError
    Then I see MyAccount.SignInPopUp.ForgotPasswordEmailError contains text "#ExpectedError"
      And I see MyAccount.SignInPopUp.PasswordResetMessage is not displayed
      And I see MyAccount.SignInPopUp.PasswordResetCloseButton is not displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @SignIn @P1
  @feature:PPL-221 @tms:UTR-3844
  Scenario Outline: If user hovers over or clicks the my account link on the header, the flyout menu should be displayed and the options should be redirected to correct link
    Given I am on shopping-bag page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
    When I sign in with user "automation.test.user@gmail.com" and password "qwerty1234"
      And I wait until Experience.Header.MyAccountButton is displayed in 10 seconds
      And I wait for 5 seconds
    When I hover over Experience.Header.MyAccountButton
      And I hover over Experience.Header.MyAccountButton
    Then I see MyAccount.AccountFlyout.AccountOrdersLink is displayed
      And I see MyAccount.AccountFlyout.AccountDetailsLink is displayed
      And I see MyAccount.AccountFlyout.AccountAddressesLink is displayed
      And I see MyAccount.AccountFlyout.AccountEmailPreferencesLink is displayed
      And I see MyAccount.AccountFlyout.SignOutButton is displayed
    When I click on MyAccount.AccountFlyout.AccountOrdersLink by js
    Then URL should contain "myaccount/orders"
    When I navigate to page store-locator
      And I hover over Experience.Header.MyAccountButton
      And I click on MyAccount.AccountFlyout.AccountDetailsLink by js
    Then URL should contain "myaccount/details"
    When I navigate to page store-locator
      And I hover over Experience.Header.MyAccountButton
      And I click on MyAccount.AccountFlyout.AccountAddressesLink by js
    Then URL should contain "myaccount/addresses"
    When I navigate to page store-locator
      And I hover over Experience.Header.MyAccountButton
      And I click on MyAccount.AccountFlyout.AccountEmailPreferencesLink by js
    Then URL should contain "myaccount/preferences"

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @SignIn @P3
  @feature:PPL-221 @tms:UTR-3845
  Scenario Outline: If user removes the hovers from the my account link on the header, the flyout menu should be collapsed
    Given I am on shopping-bag page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
    When I sign in with user "automation.test.user@gmail.com" and password "qwerty1234"
    Then I see Experience.Header.MyAccountButton is displayed
    When I hover over Experience.Header.MyAccountButton
    Then I see MyAccount.AccountFlyout.FlyMenu is displayed
    When I hover over Experience.Header.SearchField
    Then I see MyAccount.AccountFlyout.FlyMenu is not displayed

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  #@FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @SignIn @P2
  @tms:UTR-13438
  Scenario Outline: Account is not locked after 6 wrong login attemtps and user can login
    Given There is 1 accounts
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I sign up with email user1#email and password user1#password
    When I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I open sign in panel
      And I type "user1#email" in the field MyAccount.SignInPopUp.EmailField
      And I type "qwerty" in the field MyAccount.SignInPopUp.PasswordField
      And I click on MyAccount.SignInPopUp.SignInButton
    Then I see MyAccount.SignInPopUp.SignInError is displayed
    When I type "qwerty" in the empty field MyAccount.SignInPopUp.PasswordField
      And I click on MyAccount.SignInPopUp.SignInButton
    Then I see MyAccount.SignInPopUp.SignInError is displayed
    When I type "qwerty" in the empty field MyAccount.SignInPopUp.PasswordField
      And I click on MyAccount.SignInPopUp.SignInButton
    Then I see MyAccount.SignInPopUp.SignInError is displayed
    When I wait for 31 seconds
      And I type "qwerty" in the empty field MyAccount.SignInPopUp.PasswordField
      And I click on MyAccount.SignInPopUp.SignInButton
    Then I see MyAccount.SignInPopUp.SignInError is displayed
    When I type "qwerty" in the empty field MyAccount.SignInPopUp.PasswordField
      And I click on MyAccount.SignInPopUp.SignInButton
    Then I see MyAccount.SignInPopUp.SignInError is displayed
    When I type "qwerty" in the empty field MyAccount.SignInPopUp.PasswordField
      And I click on MyAccount.SignInPopUp.SignInButton
    Then I see MyAccount.SignInPopUp.SignInError is displayed
    When I type "qwerty" in the empty field MyAccount.SignInPopUp.PasswordField
      And I click on MyAccount.SignInPopUp.SignInButton
    Then I see MyAccount.SignInPopUp.SignInError is displayed
    When I wait for 31 seconds
      And I clear text field of element MyAccount.SignInPopUp.PasswordField
      And I type "user1#password" in the empty field MyAccount.SignInPopUp.PasswordField
      And I click on MyAccount.SignInPopUp.SignInButton
    Then I see Experience.Header.MyAccountButton is displayed in 5 seconds

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @SignIn @P2
  @tms:UTR-18008
  Scenario Outline: User will be redirected back to the authenticated content they were trying to access whilst not logged in
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am on locale <locale> of url /myaccount
    Then I see MyAccount.AccountFlyout.FlyMenuSignIn is displayed
      And I type "my.account.henk.automation@outlook.com" in the field MyAccount.SignInPopUp.EmailField
      And I type "AutoNation2023" in the field MyAccount.SignInPopUp.PasswordField
      And I click on MyAccount.SignInPopUp.SignInButton
      And I wait for 3 seconds
    Then I see the current page is MyAccount page

    Examples:
      | locale  | langCode |
      | default | default  |
