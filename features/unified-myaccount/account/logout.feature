Feature: Unified My Account - Logout

  @FullRegression @RCTest
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @SignOut @P2
  @tms:UTR-13473
  Scenario Outline: I can logout after I sign in
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I sign in with email my.account.pierre.automation@outlook.com and password AutoNation2023
      And I wait for 1 seconds
    Then I can sign out

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @SignOut @P2 @ExcludeTH
  @tms:UTR-13474
  Scenario Outline: I can logout after I sign up
    Given There is 1 account
      And I am on locale <locale> home page of langCode <langCode> with accepted cookies
    When in header I sign up with email user1#email and password user1#password
    Then I can sign out

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @SignOut @P2
  @tms:UTR-13475
  Scenario: User stays on GLP after logging out on GLP
    Given There is 1 account
      And I am on locale default home page with forced accepted cookies
    When I sign in with email my.account.charles.automation@outlook.com and password AutoNation2023
      And I wait for 2 seconds
      And I navigate to page glp
      And I save current decoded url as key #glpUrl
      And I sign out
      And I wait until MyAccount.AccountFlyout.FlyMenuSignIn is not displayed in 5 seconds
      And I wait for 2 seconds
    Then I see the current page is GLP
      And URL should contain "#glpUrl"