Feature: Membership and Loyalty - Registration

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @EER @M&L @P2 @UnifiedExperience
  @feature:PPL-467 @feature:PPL-833 @tms:UTR-6691
  Scenario Outline: M&L - User see all the components in "Become a Member" form
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
    When I open sign in panel
      And I click on Experience.MLSigninForm.BecomeMemberButton
    Then I see Experience.MLRegisterForm.MembershipLogo is displayed
      And I see Experience.MLRegisterForm.CloseButton is displayed
      And I see Experience.MLRegisterForm.Email is displayed
      And I see Experience.MLRegisterForm.BirthDay is displayed
      And I see Experience.MLRegisterForm.BirthMonth is displayed
      And I see Experience.MLRegisterForm.BirthYear is displayed
      And I see Experience.MLRegisterForm.DiscountText is displayed
      And I see Experience.MLRegisterForm.Gender is displayed
      And I see Experience.MLRegisterForm.NewsletterCheckbox is displayed
      And I see Experience.MLRegisterForm.BecomeMemberButton is displayed

    Examples:
      | locale  | langCode | page     |
      | default | default  | wishlist |

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L @P1
  @feature:PPL-544 @tms:UTR-6692
  Scenario Outline: M&L - User is able to register successfully
    Given There is 1 account
      And I am on shopping-bag page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
      When I click on Experience.MLSigninForm.BecomeMemberButton
      And I type "user1#email" in the field Experience.MLRegisterForm.Email
      And I type "11" in the field Experience.MLRegisterForm.BirthDay
      And I type "11" in the field Experience.MLRegisterForm.BirthMonth
      And I type "1990" in the field Experience.MLRegisterForm.BirthYear
      And in dropdown Experience.MLRegisterForm.Gender I select the option by index "2"
      And I click on Experience.MLRegisterForm.NewsletterCheckbox
      And I click on Experience.MLRegisterForm.BecomeMemberButton
    Then I see Experience.MLRegisterForm.MembeshipSignUpSuccessMessage is displayed
      And I see Experience.Header.SignInButton is displayed

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L @P2 @Translation @Lokalise
  @feature:PPL-544 @tms:UTR-6694
  Scenario Outline: M&L - Inline errors when user is already registered
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I open sign in panel
      And I click on Experience.MLSigninForm.BecomeMemberButton
      And I type "autouser213@getairmail.com" in the field Experience.MLRegisterForm.Email
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
  @EER @M&L
  @feature:PPL-544 @tms:UTR-17643
  Scenario Outline: M&L - User can redirect to faq page when click on customer service link after registration
    Given There is 1 account
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
    When I open sign in panel
    Then I click on Experience.MLSigninForm.BecomeMemberButton
      And I type "user1#email" in the field Experience.MLRegisterForm.Email
      And I type "11" in the field Experience.MLRegisterForm.BirthDay
      And I type "11" in the field Experience.MLRegisterForm.BirthMonth
      And I type "1990" in the field Experience.MLRegisterForm.BirthYear
      And in dropdown Experience.MLRegisterForm.Gender I select the option by index "2"
      And I click on Experience.MLRegisterForm.NewsletterCheckbox
    When I click on Experience.MLRegisterForm.BecomeMemberButton
    Then I see Experience.MLRegisterForm.MembeshipSignUpSuccessMessage is displayed
    When I click on MyAccount.RegisterPopUp.CustomerServiceLink
      And I wait until the current page is loaded
    Then I see URL should contain "faqs"

    Examples:
      | locale           | langCode         | page     |
      | multiLangDefault | multiLangDefault | wishlist |

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L @Translation @Lokalise
  @tms:UTR-18058
  Scenario Outline: M&L - User should be 18 years old to register himself
    Given There is 1 account
    When I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
    When I open sign in panel
    Then I click on Experience.MLSigninForm.BecomeMemberButton
      And I type "user1#email" in the field Experience.MLRegisterForm.Email
      And I type "11" in the field Experience.MLRegisterForm.BirthDay
      And I type "11" in the field Experience.MLRegisterForm.BirthMonth
      And I type "2020" in the field Experience.MLRegisterForm.BirthYear
      And in dropdown Experience.MLRegisterForm.Gender I select the option by index "2"
      And I click on Experience.MLRegisterForm.NewsletterCheckbox
    When I click on Experience.MLRegisterForm.BecomeMemberButton
      And I get translation from lokalise for "RegisterAgeError" and store it with key #RegisterAgeError
    Then I see Experience.MLRegisterForm.EmailError contains text "#RegisterAgeError"

    Examples:
      | locale  | langCode | page     |
      | default | default  | wishlist |
