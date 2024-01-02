Feature: Unified My Account - Forgot password

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @ForgotPassword @P1
  @tms:UTR-13435
  Scenario Outline: User can recover password by using forgot password link
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I open sign in panel
      And I click on MyAccount.SignInPopUp.ForgotPasswordLink
    When I type "ThisIsAutomatedTesting@test.com" in the field MyAccount.SignInPopUp.ForgotPasswordEmailField
      And I click on MyAccount.SignInPopUp.ForgotPasswordSendButton
      And I get translation from lokalise for "ForgotPasswordTitle" and store it with key #Title
    Then I see MyAccount.SignInPopUp.PasswordResetMessageTitle contains text "#Title"
      And I see MyAccount.SignInPopUp.PasswordResetMessage contains text "ThisIsAutomatedTesting@test.com"
      And I click on MyAccount.SignInPopUp.PasswordResetCloseButton

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @ForgotPassword @P2
  Scenario Outline: Invalid email in forgot password email field will result in error message displayed
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I open sign in panel
      And I click on MyAccount.SignInPopUp.ForgotPasswordLink
    When I type "<email>" in the field MyAccount.SignInPopUp.ForgotPasswordEmailField
      And I click on MyAccount.SignInPopUp.ForgotPasswordSendButton
      And I get translation from lokalise for "<error>" and store it with key #Message
    Then I see MyAccount.SignInPopUp.ForgotPasswordEmailError contains text "#Message"

    @tms:UTR-13436
    Examples:
      | locale           | langCode         | page     | email | error             |
      | multiLangDefault | multiLangDefault | wishlist |       | EmailMissingError |

    @tms:UTR-14567
    Examples:
      | locale  | langCode | page         | email | error      |
      | default | default  | shopping-bag | bla   | EmailError |

    @tms:UTR-14568
    Examples:
      | locale           | langCode         | page | email   | error      |
      | multiLangDefault | multiLangDefault | pdp  | bla@bla | EmailError |

    @tms:UTR-14569
    Examples:
      | locale | langCode | page | email    | error      |
      | ie     | default  | glp  | bla@.com | EmailError |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @ForgotPassword @P3
  @tms:UTR-18767
  Scenario Outline: User can see password already populated in the forgot password field if it was typed before clicking the link
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I open sign in panel
    When I type "ThisIsAutomatedTesting@test.com" in the field MyAccount.SignInPopUp.EmailField
      And I click on MyAccount.SignInPopUp.ForgotPasswordLink
      And I click on MyAccount.SignInPopUp.ForgotPasswordEmailField
      Then I see the attribute value of element MyAccount.SignInPopUp.ForgotPasswordEmailField containing "ThisIsAutomatedTesting@test.com"

    Examples:
      | locale  | langCode |
      | default | default  |