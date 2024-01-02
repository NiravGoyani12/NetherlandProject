Feature: Unified My Account - Preferences

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @P2
  Scenario Outline: User is able to subscribe to newsletter from my account
    Given I am on my account preferences page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I get translation from lokalise for "SubscriptionPreferences" and store it with key #PreferencesInfo
      And I get translation from lokalise for "NewsletterSignUpInfo" and store it with key #SignUpTitle
      And I get translation from lokalise for "NewsletterEmailsType" and store it with key #SignUpInfo
      And I get translation from lokalise for "NewsletterUnsubscribeInfo" and store it with key #Unsubscribe
    Then I see MyAccount.NewsletterSubscription.PreferencesInfo contains text "#PreferencesInfo"
      And I see MyAccount.NewsletterSubscription.SignUpTitle contains text "#SignUpTitle"
      And I see MyAccount.NewsletterSubscription.SignUpInfo contains text "#SignUpInfo"
    When I set the checkbox MyAccount.NewsletterSubscription.<gender> status to true
      And I set the checkbox MyAccount.NewsletterSubscription.NewsLetterTCCheckbox status to true
      And I click on MyAccount.NewsletterSubscription.NewsletterSignUpButton
    Then I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo contains text "#Unsubscribe"
      And I see the checkbox MyAccount.NewsletterSubscription.<gender> is checked
      And I see MyAccount.NewsletterSubscription.NewsLetterSavePreferences is displayed

    @tms:UTR-11462
    Examples:
      | locale  | langCode | gender                |
      | default | default  | NewsletterMenCheckbox |

    @tms:UTR-13203
    Examples:
      | locale           | langCode         | gender                  |
      | multiLangDefault | multiLangDefault | NewsletterWomenCheckbox |

    @tms:UTR-13204
    Examples:
      | locale  | langCode | gender                 |
      | default | default  | NewsletterKidsCheckbox |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @P2
  Scenario Outline: User is able to subscribe to multiple newsletter subjects from my account
    Given I am on my account preferences page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I get translation from lokalise for "SubscriptionPreferences" and store it with key #PreferencesInfo
      And I get translation from lokalise for "NewsletterSignUpInfo" and store it with key #SignUpTitle
      And I get translation from lokalise for "NewsletterEmailsType" and store it with key #SignUpInfo
      And I get translation from lokalise for "NewsletterUnsubscribeInfo" and store it with key #Unsubscribe
    Then I see MyAccount.NewsletterSubscription.PreferencesInfo contains text "#PreferencesInfo"
      And I see MyAccount.NewsletterSubscription.SignUpTitle contains text "#SignUpTitle"
      And I see MyAccount.NewsletterSubscription.SignUpInfo contains text "#SignUpInfo"
    When I set the checkbox MyAccount.NewsletterSubscription.NewsletterMenCheckbox status to true
      And I set the checkbox MyAccount.NewsletterSubscription.NewsletterWomenCheckbox status to true
      And I set the checkbox MyAccount.NewsletterSubscription.NewsletterKidsCheckbox status to <value>
      And I set the checkbox MyAccount.NewsletterSubscription.NewsLetterTCCheckbox status to true
      And I click on MyAccount.NewsletterSubscription.NewsletterSignUpButton
    Then I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo contains text "#Unsubscribe"
      And I see the checkbox MyAccount.NewsletterSubscription.NewsletterMenCheckbox is checked
      And I see the checkbox MyAccount.NewsletterSubscription.NewsletterWomenCheckbox is checked
      And I see the checkbox MyAccount.NewsletterSubscription.NewsletterKidsCheckbox is <checkbox>
      And I see MyAccount.NewsletterSubscription.NewsLetterSavePreferences is displayed

    @tms:UTR-13205
    Examples:
      | locale           | langCode         | value | checkbox |
      | multiLangDefault | multiLangDefault | true  | checked  |

    @tms:UTR-13206
    Examples:
      | locale  | langCode | value | checkbox  |
      | default | default  | false | unchecked |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @P2
  Scenario Outline: User is able to edit preferences for newsletter subscription
    Given I am on my account preferences page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I set the checkbox MyAccount.NewsletterSubscription.NewsletterMenCheckbox status to <statusM1>
      And I set the checkbox MyAccount.NewsletterSubscription.NewsletterWomenCheckbox status to <statusW1>
      And I set the checkbox MyAccount.NewsletterSubscription.NewsletterKidsCheckbox status to <statusK1>
      And I set the checkbox MyAccount.NewsletterSubscription.NewsLetterTCCheckbox status to true
      And I click on MyAccount.NewsletterSubscription.NewsletterSignUpButton
    Then I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo is displayed in 5 seconds
      And I see MyAccount.NewsletterSubscription.NewsLetterSavePreferences is displayed
      And I wait for 3 seconds
    When I set the checkbox MyAccount.NewsletterSubscription.NewsletterMenCheckbox status to <statusM2>
      And I set the checkbox MyAccount.NewsletterSubscription.NewsletterWomenCheckbox status to <statusW2>
      And I set the checkbox MyAccount.NewsletterSubscription.NewsletterKidsCheckbox status to <statusK2>
      And I click on MyAccount.NewsletterSubscription.NewsLetterSavePreferences
    Then I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo is displayed in 5 seconds
      And I see the checkbox MyAccount.NewsletterSubscription.NewsletterMenCheckbox is <statusM3>
      And I see the checkbox MyAccount.NewsletterSubscription.NewsletterWomenCheckbox is <statusW3>
      And I see the checkbox MyAccount.NewsletterSubscription.NewsletterKidsCheckbox is <statusK3>

    @tms:UTR-11463
    Examples:
      | locale           | langCode         | statusM1 | statusW1 | statusK1 | statusM2 | statusW2 | statusK2 | statusM3 | statusW3 | statusK3  |
      | multiLangDefault | multiLangDefault | true     | true     | true     | true     | true     | false    | checked  | checked  | unchecked |

    @tms:UTR-13207
    Examples:
      | locale  | langCode | statusM1 | statusW1 | statusK1 | statusM2 | statusW2 | statusK2 | statusM3  | statusW3 | statusK3  |
      | default | default  | true     | false    | true     | false    | true     | false    | unchecked | checked  | unchecked |

    @tms:UTR-13208
    Examples:
      | locale           | langCode         | statusM1 | statusW1 | statusK1 | statusM2 | statusW2 | statusK2 | statusM3  | statusW3  | statusK3  |
      | multiLangDefault | multiLangDefault | true     | true     | true     | false    | false    | false    | unchecked | unchecked | unchecked |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @P2 @Translation @Lokalise
  @tms:UTR-11466
  Scenario Outline: User is able to unsubscribe from newsletter
    Given I am on my account preferences page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I set the checkbox MyAccount.NewsletterSubscription.NewsletterMenCheckbox status to true
      And I set the checkbox MyAccount.NewsletterSubscription.NewsletterWomenCheckbox status to true
      And I set the checkbox MyAccount.NewsletterSubscription.NewsLetterTCCheckbox status to true
      And I click on MyAccount.NewsletterSubscription.NewsletterSignUpButton
    Then I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo is displayed in 5 seconds
      And I wait for 3 seconds
    When I click on MyAccount.NewsletterSubscription.NewsLetterUnsubscribeButton
      And I get translation from lokalise for "UnsubscribedSuccessfully" and store it with key #Unsubscribed
    Then I see MyAccount.NewsletterSubscription.NewsLetterUnsubscribeSuccessMessage contains text "#Unsubscribed"
      And I see MyAccount.NewsletterSubscription.NewsLetterSavePreferences is not displayed
      And I see MyAccount.NewsletterSubscription.NewsletterMenCheckbox is not displayed
      And I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo is not displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @P2
  @tms:UTR-11471
  Scenario Outline: User is not able to subscribe to the newsletter without agreeing to terms and conditions
    Given I am on my account preferences page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I set the checkbox MyAccount.NewsletterSubscription.NewsletterMenCheckbox status to true
      And I click on MyAccount.NewsletterSubscription.NewsletterSignUpButton
    Then I see the checkbox MyAccount.NewsletterSubscription.NewsLetterTCCheckbox is unchecked
      And I see MyAccount.NewsletterSubscription.NewsletterTCCheckboxError is displayed in 5 seconds
      And I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo is not displayed

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @P3 @ExcludeTH
  @tms:UTR-11635
  Scenario Outline: I see newsletter preferences subscribed when done from checkout page
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page to subscribe newsletter while checking out
      And I wait for 3 seconds
    When I navigate to preferences page
    Then I see MyAccount.NewsletterSubscription.NewsetterUnsubscribeInfo is displayed in 5 seconds
      And I see MyAccount.NewsletterSubscription.NewsLetterSavePreferences is displayed

    Examples:
      | locale  | langCode | userType  |
      | default | default  | logged in |