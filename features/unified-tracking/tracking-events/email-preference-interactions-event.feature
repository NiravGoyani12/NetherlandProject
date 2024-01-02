Feature: Unified My Account - Data layer - Email preference interactions event

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedMyAccount @PPL
  @tms:UTR-9735
  @issue:PPL-1069
  Scenario Outline: The event is fired when I subscribe for the email newsletter within My Account preferences
    Given I am on my account preferences page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I wait for 3 seconds
      And I set the checkbox MyAccount.NewsletterSubscription.<gender> status to true
      And I set the checkbox MyAccount.NewsletterSubscription.NewsLetterTCCheckbox status to true
    When I inject utag event listener
      And I click on MyAccount.NewsletterSubscription.NewsletterSignUpButton
    Then utag event email_preference_interactions is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "email_preference_interactions"
      And utag event #event should contain attr eventLabel with value "email_preference_subscribe"
      And utag event #event should contain non-empty attr user_id
      And utag event #event should contain non-empty attr contact_id
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale           | langCode         | gender                  |
      | default          | default          | NewsletterMenCheckbox   |
      | multiLangDefault | multiLangDefault | NewsletterWomenCheckbox |
      | default          | default          | NewsletterKidsCheckbox  |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedMyAccount @PPL
  @tms:UTR-9736
  Scenario Outline: The event is fired when I save preferences for the email newsletter within My Account preferences
    Given I am on my account preferences page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I set the checkbox MyAccount.NewsletterSubscription.NewsletterMenCheckbox status to true
      And I set the checkbox MyAccount.NewsletterSubscription.NewsLetterTCCheckbox status to true
      And I click on MyAccount.NewsletterSubscription.NewsletterSignUpButton
    Then I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo is displayed in 5 seconds
      And I see MyAccount.NewsletterSubscription.NewsLetterSavePreferences is displayed
      And I wait for 3 seconds
    When I set the checkbox MyAccount.NewsletterSubscription.NewsletterWomenCheckbox status to true
      And I inject utag event listener
      And I click on MyAccount.NewsletterSubscription.NewsLetterSavePreferences
    Then utag event email_preference_interactions is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "email_preference_interactions"
      And utag event #event should contain attr eventLabel with value "email_preference_save"
      And utag event #event should contain non-empty attr user_id
      And utag event #event should contain non-empty attr contact_id
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedMyAccount @PPL
  @tms:UTR-9737
  Scenario Outline: The event is fired when I unsubscribe for the email newsletter within My Account preferences
    Given I am on my account preferences page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I set the checkbox MyAccount.NewsletterSubscription.NewsletterMenCheckbox status to true
      And I set the checkbox MyAccount.NewsletterSubscription.NewsletterWomenCheckbox status to true
      And I set the checkbox MyAccount.NewsletterSubscription.NewsLetterTCCheckbox status to true
      And I click on MyAccount.NewsletterSubscription.NewsletterSignUpButton
    Then I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo is displayed in 5 seconds
      And I wait for 3 seconds
    When I inject utag event listener
      And I click on MyAccount.NewsletterSubscription.NewsLetterUnsubscribeButton
    Then utag event email_preference_interactions is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "email_preference_interactions"
      And utag event #event should contain attr eventLabel with value "email_preference_unsubscribe"
      And utag event #event should contain non-empty attr user_id
      And utag event #event should contain non-empty attr contact_id
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale  | langCode |
      | default | default  |