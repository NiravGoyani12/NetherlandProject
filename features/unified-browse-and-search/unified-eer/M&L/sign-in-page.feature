Feature: Membership and Loyalty - Sign in Page

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L
  @feature:EER-12410 @tms:UTR-14561
  Scenario Outline: M&L - User see all the components in new sign in page
    Given There is 1 account
    When I am on locale <locale> of url /signin of langCode <langCode> with accepted cookies
    Then I see Experience.MLSigninForm.MembershipLogo is displayed
      And I see Experience.MLSigninForm.Email is displayed
      And I see Experience.MLSigninForm.Password is displayed
      And I see Experience.MLSigninForm.SubmitButton is displayed
      And I see Experience.MLSigninForm.RememberMeCheckbox is displayed
      And I see Experience.MLSigninForm.ForgotPasswordLink is displayed
      And I see Experience.MLSigninForm.DiscoverTommyLink is displayed
      And I see Experience.MLSigninForm.BecomeMemberButton is displayed
      And I see Experience.MLSigninForm.MemebrshipSignInTitle is displayed
      And I see Experience.MLSigninForm.MemebrshipBenefitText is displayed
      And I see Experience.MLSigninForm.ShowPasswordButton is displayed
    When I click on Experience.MLSigninForm.DiscoverTommyLink
    Then URL should contain "/tommy-together"

    @P1
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L @P2
  @feature:EER-12410 @tms:UTR-15031
  Scenario Outline: M&L - Forgot Password Success Screen update in sign in page
    Given I am on locale <locale> of url /signin of langCode <langCode> with accepted cookies
    When I click on Experience.MLSigninForm.ForgotPasswordLink
      And I type "mandlautomationtesting+1@gmail.com" in the field Experience.MLSigninForm.ForgetPasswordEmail
      And I click on Experience.MLSigninForm.SendButton
    Then I see Experience.MLForgotPasswordForm.MembershipLogo is displayed
      And I see Experience.MLForgotPasswordForm.Heading is displayed
      And I see Experience.MLForgotPasswordForm.ContinueShopping is displayed
      And I see Experience.MLForgotPasswordForm.SuccessText is displayed

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L @P2 @Translation @Lokalise
  @feature:EER-12410 @tms:UTR-15032
  Scenario Outline: M&L - Inline errors are displayed when invalid email or password is given in sign in page
    Given I am on locale <locale> of url /signin of langCode <langCode> with accepted cookies
    When I sign in with user "<email>" and password "<password>"
      And I get translation from lokalise for "<expectedError>" and store it with key #ExpectedError
    Then I see MyAccount.SignInPopUp.<errorElement> contains text "#ExpectedError"

    Examples:
      | locale           | langCode         | email            | password | errorElement  | expectedError     |
      | default          | default          | invalidEmail@pvh | abc123   | EmailError    | EmailError        |
      | multiLangDefault | multiLangDefault |                  | abc123   | EmailError    | EmailMissingError |
      | default          | default          | test@test.com    |          | PasswordError | MandatoryField    |
