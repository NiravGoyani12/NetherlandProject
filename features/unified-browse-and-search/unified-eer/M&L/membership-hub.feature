Feature: Membership and Loyalty - Membership hub

  @FullRegression
  @Desktop @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L @MembershipHub @P1
  @feature:PPL-618 @tms:UTR-8355
  Scenario Outline: M&L - User see all the components in Tommy Together Hub Page
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page home-page
      And I open sign in panel
    When I type "autouser213@getairmail.com" in the field Experience.MLSigninForm.Email
      And I type "London@213" in the field Experience.MLSigninForm.Password
      And I click on Experience.MLSigninForm.SubmitButton
      And I hover over Experience.Header.MyAccountButton
    When I store translated value of "<category>" with key #categoryText
      And I click on Experience.FaqsPage.SideBarCategoryMenu with text #categoryText
    Then I see Experience.MLMembershiphubPage.MembershipLogo is displayed
      And I see Experience.MLMembershiphubPage.BannerWithText is displayed
      And I see Experience.MLMembershiphubPage.MemberId is displayed
      And I see Experience.MLMembershiphubPage.VoucherComponent is displayed

    Examples:
      | locale  | langCode | category      |
      | default | default  | membershiphub |

  @FullRegression
  @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L @MembershipHub @P2
  @feature:PPL-618 @tms:UTR-8362
  Scenario Outline: M&L - User see all the components in Tommy Together Hub Page
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I open sign in panel
    When I type "autouser213@getairmail.com" in the field Experience.MLSigninForm.Email
      And I type "London@213" in the field Experience.MLSigninForm.Password
      And I click on Experience.MLSigninForm.SubmitButton
      And I navigate to tommy club page
      And I wait for 4 seconds
    Then I see Experience.MLMembershiphubPage.MembershipLogo is displayed
      And I see Experience.MLMembershiphubPage.BannerWithText is displayed
      And I see Experience.MLMembershiphubPage.MemberId is displayed
      And I see Experience.MLMembershiphubPage.VoucherComponent is displayed

    Examples:
      | locale           | langCode         | page      |
      | multiLangDefault | multiLangDefault | home-page |

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L @MembershipHub @P2
  @feature:PPL-737 @tms:UTR-8454
  Scenario Outline: M&L - User lands on default My details page when navigates to my account on non-M&L locale
    Given There is 1 account
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
    When I navigate to page myaccount/details
    Then I see MyAccount.MyDetailsPage.PageHeader is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile @UnifiedExperience
  @Chrome @FireFox @Safari
  @EER @M&L @MembershipHub @P2
  @feature:PPL-737 @tms:UTR-8455
  Scenario Outline: M&L - User lands on default Tommy together hub page when navigates to my account on M&L locale
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I open sign in panel
      And I type "autouser213@getairmail.com" in the field Experience.MLSigninForm.Email
      And I type "London@213" in the field Experience.MLSigninForm.Password
      And I click on Experience.MLSigninForm.SubmitButton
    When I navigate to page myaccount
    Then I see Experience.MLMembershiphubPage.MembershipLogo is displayed

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |
