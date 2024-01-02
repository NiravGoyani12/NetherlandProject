Feature: Unified Newsletter - Register

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedNewsletter @PPL @P2 @ExcludeTH
  @tms:UTR-14093
  Scenario Outline: User can sign up to newsletter from registration form
    Given There is 1 account
      And I am on shopping-bag page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type "user1#email" in the field MyAccount.RegisterPopUp.EmailField
      And I type "user1#password" in the field MyAccount.RegisterPopUp.PasswordField
      And I click on MyAccount.RegisterPopUp.TermsAndConditionsCheckbox
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
      And I set the checkbox MyAccount.RegisterPopUp.NewsletterCheckbox status to true
      And I scroll to and click on MyAccount.RegisterPopUp.NewsletterYesButton
    Then I see the current page is shopping-bag
    When I navigate to preferences page
      And I get translation from lokalise for "NewsletterUnsubscribeInfo" and store it with key #Unsubscribe
    Then I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo contains text "#Unsubscribe"
      And I see MyAccount.NewsletterSubscription.NewsLetterSavePreferences is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedNewsletter @PPL @P2 @ExcludeTH
  @tms:UTR-14104
  Scenario Outline: Newsletter preferences updated on preferences page remain saved after logout
    Given There is 1 account
      And I am on shopping-bag page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type "user1#email" in the field MyAccount.RegisterPopUp.EmailField
      And I type "user1#password" in the field MyAccount.RegisterPopUp.PasswordField
      And I click on MyAccount.RegisterPopUp.TermsAndConditionsCheckbox
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
      And I set the checkbox MyAccount.RegisterPopUp.NewsletterCheckbox status to true
      And I scroll to and click on MyAccount.RegisterPopUp.NewsletterYesButton
    Then I see the current page is shopping-bag
      And I wait for 2 seconds
    When I navigate to preferences page
      And I get translation from lokalise for "NewsletterUnsubscribeInfo" and store it with key #Unsubscribe
    Then I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo contains text "#Unsubscribe"
      And I see MyAccount.NewsletterSubscription.NewsLetterSavePreferences is displayed
    When I set the checkbox MyAccount.NewsletterSubscription.NewsletterMenCheckbox status to true
      And I set the checkbox MyAccount.NewsletterSubscription.NewsletterWomenCheckbox status to true
      And I click on MyAccount.NewsletterSubscription.NewsLetterSavePreferences
      And I wait for 2 seconds
      And I sign out
      And I wait for 3 seconds
    When I sign in with email user1#email and password user1#password
      And I wait for 2 seconds
      And I navigate to preferences page
      And I get translation from lokalise for "NewsletterUnsubscribeInfo" and store it with key #Unsubscribe
    Then I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo contains text "#Unsubscribe"
      And I see MyAccount.NewsletterSubscription.NewsLetterSavePreferences is displayed
      And I see the checkbox MyAccount.NewsletterSubscription.NewsletterMenCheckbox is checked
      And I see the checkbox MyAccount.NewsletterSubscription.NewsletterWomenCheckbox is checked
      And I see the checkbox MyAccount.NewsletterSubscription.NewsletterKidsCheckbox is unchecked

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |