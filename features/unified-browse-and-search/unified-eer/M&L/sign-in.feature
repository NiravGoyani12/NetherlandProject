Feature: Membership and Loyalty - Sign in

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L
  @feature:PPL-543 @tms:UTR-6689
  Scenario Outline: M&L - User see all the components in new sign in form
    Given There is 1 account
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
    When I open sign in panel
    Then I see Experience.MLSigninForm.MembershipLogo is displayed
      And I see Experience.MLSigninForm.CloseButton is displayed
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
    When I click on Experience.MLSigninForm.CloseButton
    Then I see Experience.MLSigninForm.SignInForm is not displayed

    @P1
    Examples:
      | locale  | langCode | page      |
      | default | default  | home-page |

    Examples:
      | locale           | langCode         | page         |
      | multiLangDefault | multiLangDefault | wlp          |
      | default          | default          | shopping-bag |

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L @P2
  @feature:PPL-543 @tms:UTR-6690
  Scenario Outline: M&L - User is navigated to club landing page on selecting the Discover tommy link
    Given There is 1 account
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
    When I open sign in panel
      And I click on Experience.MLSigninForm.DiscoverTommyLink
    Then URL should contain "/tommy-together"

    Examples:
      | locale           | langCode         | page         |
      | multiLangDefault | multiLangDefault | glp          |
      | default          | default          | pdp          |
      | multiLangDefault | multiLangDefault | shopping-bag |

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L @P2
  @feature:PPL-642 @tms:UTR-7936
  Scenario Outline: M&L - Forgot Password Success Screen update
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I open sign in panel
    When I click on Experience.MLSigninForm.ForgotPasswordLink
      And I type "mandlautomationtesting+1@gmail.com" in the field Experience.MLSigninForm.ForgetPasswordEmail
      And I click on Experience.MLSigninForm.SendButton
    Then I see Experience.MLForgotPasswordForm.MembershipLogo is displayed
      And I see Experience.MLForgotPasswordForm.Heading is displayed
      And I see Experience.MLForgotPasswordForm.ContinueShopping is displayed
      And I see Experience.MLForgotPasswordForm.SuccessText is displayed

    Examples:
      | locale  | langCode | page         |
      | default | default  | shopping-bag |
