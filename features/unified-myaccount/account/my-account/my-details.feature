Feature: Unified My Account - My details

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @P2
  @tms:UTR-14699 @Translation @Lokalise
  Scenario Outline: User can see the sign in button and my account links translated
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I get translation from lokalise for "SignInRegister" and store it with key #SignIn
    Then I see Experience.Header.SignInButton contains text "#SignIn"
    When I sign in with email automation.test.user@gmail.com and password qwerty1234
      And I get translation from lokalise for "MyAccountDetails" and store it with key #Details
      And I get translation from lokalise for "MyAccountOrders" and store it with key #Orders
      And I get translation from lokalise for "MyAccountAddresses" and store it with key #Addresses
      And I get translation from lokalise for "MyAccountPreferences" and store it with key #Preferences
      And I get translation from lokalise for "MyAccountNotifications" and store it with key #Notifications
      And I get translation from lokalise for "SignOut" and store it with key #SignOut
      And I open my account menu
    Then I see MyAccount.AccountFlyout.AccountDetailsLink contains text "#Details"
      And I see MyAccount.AccountFlyout.AccountOrdersLink contains text "#Orders"
      And I see MyAccount.AccountFlyout.AccountAddressesLink contains text "#Addresses"
      And I see MyAccount.AccountFlyout.AccountEmailPreferencesLink contains text "#Preferences"
      And I see MyAccount.AccountFlyout.AccountNotificationsLink contains text "#Notifications"
      And I see MyAccount.AccountFlyout.SignOutButton contains text "#SignOut"

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @P2
  @tms:UTR-14700
  Scenario Outline: User can see my account button translated and used them to navigated on each page
    Given I am on my account details page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I get translation from lokalise for "MyAccountDetails" and store it with key #Details
      And I get translation from lokalise for "MyAccountOrders" and store it with key #Orders
      And I get translation from lokalise for "MyAccountAddresses" and store it with key #Addresses
      And I get translation from lokalise for "MyAccountPreferences" and store it with key #Preferences
      And I get translation from lokalise for "MyAccountNotifications" and store it with key #Notifications
    Then I see MyAccount.Overview.DetailsButton contains text "#Details"
      And I see MyAccount.Overview.OrdersButton contains text "#Orders"
      And I see MyAccount.Overview.AddressesButton contains text "#Addresses"
      And I see MyAccount.Overview.PreferencesButton contains text "#Preferences"
      And I see MyAccount.Overview.NotificationsButton contains text "#Notifications"
    When I click on MyAccount.Overview.OrdersButton
    Then URL should contain "myaccount/orders"
    When I click on MyAccount.Overview.AddressesButton
    Then URL should contain "myaccount/addresses"
    When I click on MyAccount.Overview.PreferencesButton
    Then URL should contain "myaccount/preferences"
    When I click on MyAccount.Overview.NotificationsButton
    Then URL should contain "myaccount/notifications"
    When I click on MyAccount.Overview.DetailsButton
    Then URL should contain "myaccount/details"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyDetails @P2
  @feature:PPL-222 @tms:UTR-4435
  Scenario Outline: User is able to see all the components in account details
    Given I am on my account details page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I get translation from lokalise for "DetailsHeader" and store it with key #Header
      And I get translation from lokalise for "DetailsInfo" and store it with key #Info
      And I get translation from lokalise for "PersonalDetails" and store it with key #PersonalDetails
      And I get translation from lokalise for "Password" and store it with key #Password
    Then I see MyAccount.MyDetailsPage.PageHeader contains text "#Header"
      And I see MyAccount.MyDetailsPage.PageSubtitle contains text "#Info"
      And I see MyAccount.MyDetailsPage.PersonalDetailsCard contains text "#PersonalDetails"
      And I see MyAccount.MyDetailsPage.EmailCard contains text "@gmail.com"
      And I see MyAccount.MyDetailsPage.PasswordCard contains text "#Password"
      And I see MyAccount.MyDetailsPage.PasswordCard contains text "***********"

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyDetails @P1
  @feature:PPL-363 @tms:UTR-5582
  Scenario Outline: User is able to update personal details
    Given I am on my account details page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.MyDetailsPage.DetailsEditCancelButton
      And I click on MyAccount.MyDetailsPage.OtherButton
      And I type "Test" in the field MyAccount.MyDetailsPage.FirstName
      And I type "User" in the field MyAccount.MyDetailsPage.LastName
      And I type "01" in the field MyAccount.MyDetailsPage.Day
      And I type "10" in the field MyAccount.MyDetailsPage.Month
      And I type "1990" in the field MyAccount.MyDetailsPage.Year
      And I click on MyAccount.MyDetailsPage.DetailsUpdateButton
      And I get translation from lokalise for "PersonalDetailsUpdated" and store it with key #UpdateMessage
    Then I see MyAccount.MyDetailsPage.SuccessNotify contains text "#UpdateMessage"
      And I see MyAccount.MyDetailsPage.PersonalDetailsCard contains text "Mx Test User"
      And I see MyAccount.MyDetailsPage.PersonalDetailsCard contains text "1990-10-01"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyDetails @P3
  @feature:PPL-363
  Scenario Outline: Inline error when user is trying to update personal details
    Given I am on my account details page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.MyDetailsPage.DetailsEditCancelButton
      And I click on MyAccount.MyDetailsPage.MrButton
      And I type "<FirstName>" in the field MyAccount.MyDetailsPage.FirstName
      And I type "<LastName>" in the field MyAccount.MyDetailsPage.LastName
      And I type "<Day>" in the field MyAccount.MyDetailsPage.Day
      And I type "<Month>" in the field MyAccount.MyDetailsPage.Month
      And I type "<Year>" in the field MyAccount.MyDetailsPage.Year
    When I click on MyAccount.MyDetailsPage.DetailsUpdateButton
      And I get translation from lokalise for "<FirstNameError>" and store it with key #FirstNameError
      And I get translation from lokalise for "<LastNameError>" and store it with key #LastNameError
      And I get translation from lokalise for "<DateError>" and store it with key #DateError
    Then I see MyAccount.MyDetailsPage.FirstNameError contains text "#FirstNameError"
      And I see MyAccount.MyDetailsPage.LastNameError contains text "#LastNameError"
      And I see MyAccount.MyDetailsPage.DateError contains text "#DateError"
      And the count of elements MyAccount.MyDetailsPage.InputFieldsError is equal to <Errors>

    @tms:UTR-5584
    Examples:
      | locale  | langCode | FirstName | LastName | Day  | Month | Year | FirstNameError       | LastNameError       | DateError          | Errors |
      | default | default  | 123Test   | T35t     | four | teen  | fall | FirstNameFormatError | LastNameFormatError | InvalidDateOfBirth | 5      |

    @tms:UTR-14559
    Examples:
      | locale           | langCode         | FirstName | LastName | Day | Month | Year | FirstNameError | LastNameError  | DateError          | Errors |
      | multiLangDefault | multiLangDefault |           |          | $%  | @#    | @$#% | MandatoryField | MandatoryField | InvalidDateOfBirth | 5      |

    @tms:UTR-14560
    Examples:
      | locale  | langCode | FirstName | LastName | Day | Month | Year | FirstNameError       | LastNameError       | DateError          | Errors |
      | default | default  | 321       | 2        | 32  | 13    | 2045 | FirstNameFormatError | LastNameFormatError | InvalidDateOfBirth | 4      |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @MyDetails @P2
  @feature:PPL-421 @tms:UTR-5586
  Scenario Outline: User can close personal edit form and information will not be saved
    Given I am on my account details page on locale <locale> of langCode <langCode> with forced accepted cookies
    Then I see MyAccount.MyDetailsPage.PersonalDetailsCard contains text "--"
      And I see MyAccount.MyDetailsPage.PersonalDetailsCard does not contain text "Test User"
    When I click on MyAccount.MyDetailsPage.DetailsEditCancelButton
      And I click on MyAccount.MyDetailsPage.OtherButton
      And I type "Test" in the field MyAccount.MyDetailsPage.FirstName
      And I type "User" in the field MyAccount.MyDetailsPage.LastName
      And I type "01" in the field MyAccount.MyDetailsPage.Day
      And I type "10" in the field MyAccount.MyDetailsPage.Month
      And I type "1990" in the field MyAccount.MyDetailsPage.Year
      And I click on MyAccount.MyDetailsPage.DetailsEditCancelButton
    Then I see MyAccount.MyDetailsPage.DiscardButton is displayed
      And I see MyAccount.MyDetailsPage.ContinueEditingButton is displayed
    When I click on MyAccount.MyDetailsPage.DiscardButton
    Then I see MyAccount.MyDetailsPage.DetailsUpdateButton is not displayed
      And I see MyAccount.MyDetailsPage.PersonalDetailsCard does not contain text "Mx Test User"
      And I see MyAccount.MyDetailsPage.PersonalDetailsCard does not contain text "1990-10-01"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyDetails @P3
  @feature:PPL-421 @tms:UTR-4974
  Scenario Outline: User can close personal details edit form and then decide to continue to edit and save new details
    Given I am on my account details page on locale <locale> of langCode <langCode> with forced accepted cookies
    Then I see MyAccount.MyDetailsPage.PersonalDetailsCard contains text "--"
      And I see MyAccount.MyDetailsPage.PersonalDetailsCard does not contain text "Test User"
    When I click on MyAccount.MyDetailsPage.DetailsEditCancelButton
      And I click on MyAccount.MyDetailsPage.OtherButton
      And I type "Automation" in the field MyAccount.MyDetailsPage.FirstName
      And I type "Nation" in the field MyAccount.MyDetailsPage.LastName
      And I type "30" in the field MyAccount.MyDetailsPage.Day
      And I click on MyAccount.MyDetailsPage.DetailsEditCancelButton
    Then I see MyAccount.MyDetailsPage.DiscardButton is displayed
      And I see MyAccount.MyDetailsPage.ContinueEditingButton is displayed
    When I click on MyAccount.MyDetailsPage.ContinueEditingButton
    Then I see MyAccount.MyDetailsPage.FirstName is displayed
      And I see the attribute value of element MyAccount.MyDetailsPage.LastName containing "Nation"
    When I type "12" in the field MyAccount.MyDetailsPage.Month
      And I type "1976" in the field MyAccount.MyDetailsPage.Year
      And I click on MyAccount.MyDetailsPage.DetailsUpdateButton
      And I get translation from lokalise for "PersonalDetailsUpdated" and store it with key #UpdateMessage
    Then I see MyAccount.MyDetailsPage.SuccessNotify contains text "#UpdateMessage"
      And I see MyAccount.MyDetailsPage.PersonalDetailsCard contains text "Mx Automation Nation"
      And I see MyAccount.MyDetailsPage.PersonalDetailsCard contains text "1976-12-30"

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyDetails @P1
  @feature:PPL-228 @tms:UTR-4971
  Scenario Outline: User is able to update email address
    Given There is 2 account
      And I am in url / of locale <locale> and langCode <langCode> with new account email user1#email and password user1#password with forced accepted cookies
      And I wait for 1 seconds
      And I navigate to details page
    When I click on MyAccount.MyDetailsPage.EmailEditCancelButton
      And I type "user2#email" in the field MyAccount.MyDetailsPage.NewEmail
      And I type "user2#email" in the field MyAccount.MyDetailsPage.NewEmailConfirm
      And I type "user1#password" in the field MyAccount.MyDetailsPage.Password
      And I click on MyAccount.MyDetailsPage.EmailUpdateButton
      And I get translation from lokalise for "EmailUpdatedSuccessfully" and store it with key #UpdateMessage
    Then I see MyAccount.MyDetailsPage.EmailUpdatedMessage contains text "#UpdateMessage"
      And I see MyAccount.MyDetailsPage.EmailCard contains text "user2#email"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyDetails @P2
  @feature:PPL-228
  Scenario Outline: Inline errors when user is trying to update email address
    Given There is 2 account
      And I am in url / of locale <locale> and langCode <langCode> with new account email user1#email and password user1#password with forced accepted cookies
      And I wait for 1 seconds
      And I navigate to details page
    When I click on MyAccount.MyDetailsPage.EmailEditCancelButton
      And I type "<NewEmail>" in the field MyAccount.MyDetailsPage.NewEmail
      And I type "<NewEmailConfirm>" in the field MyAccount.MyDetailsPage.NewEmailConfirm
      And I type "<Password>" in the field MyAccount.MyDetailsPage.Password
      And I click on MyAccount.MyDetailsPage.EmailUpdateButton
      And I get translation from lokalise for "<FieldError>" and store it with key #Error
    Then I see MyAccount.MyDetailsPage.<Element> contains text "#Error"

    @tms:UTR-4973
    Examples:
      | locale  | langCode | NewEmail | NewEmailConfirm | Password       | Element       | FieldError |
      | default | default  | abc      | abc             | user1#password | NewEmailError | EmailError |

    @tms:UTR-14562
    Examples:
      | locale           | langCode         | NewEmail    | NewEmailConfirm | Password       | Element           | FieldError             |
      | multiLangDefault | multiLangDefault | user2#email | test@test.com   | user1#password | ConfirmEmailError | ConfirmationEmailError |

    @tms:UTR-14563
    Examples:
      | locale  | langCode | NewEmail    | NewEmailConfirm | Password    | Element            | FieldError        |
      | default | default  | user2#email | user2#email     | 12345678900 | EmailPasswordError | IncorrectPassword |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyDetails @P3
  @feature:PPL-228 @tms:UTR-4680
  Scenario Outline: User can close email edit form and then decide to continue to edit and save new details
    Given I am on my account details page on locale <locale> of langCode <langCode> with forced accepted cookies
    Then I see MyAccount.MyDetailsPage.EmailCard contains text "user1#email"
    When I click on MyAccount.MyDetailsPage.EmailEditCancelButton
      And I type "testing.automation@gmail.com" in the field MyAccount.MyDetailsPage.NewEmail
      And I type "testing.automation@gmail.com" in the field MyAccount.MyDetailsPage.NewEmailConfirm
      And I type "user1#password" in the field MyAccount.MyDetailsPage.Password
      And I click on MyAccount.MyDetailsPage.EmailEditCancelButton
    Then I see MyAccount.MyDetailsPage.DiscardButton is displayed
      And I see MyAccount.MyDetailsPage.ContinueEditingButton is displayed
    When I click on MyAccount.MyDetailsPage.DiscardButton
    Then I see MyAccount.MyDetailsPage.EmailCard contains text "user1#email"
      And I see MyAccount.MyDetailsPage.SuccessNotify is not displayed
    When I click on MyAccount.MyDetailsPage.EmailEditCancelButton
      And I type "#RANDOM" in the field MyAccount.MyDetailsPage.NewEmail
      And I type "#RANDOM" in the field MyAccount.MyDetailsPage.NewEmailConfirm
      And I type "user1#password" in the field MyAccount.MyDetailsPage.Password
      And I click on MyAccount.MyDetailsPage.EmailEditCancelButton
    Then I see MyAccount.MyDetailsPage.DiscardButton is displayed
      And I see MyAccount.MyDetailsPage.ContinueEditingButton is displayed
    When I click on MyAccount.MyDetailsPage.ContinueEditingButton
    Then I see MyAccount.MyDetailsPage.CurrentEmail contains text "user1#email"
      And I see MyAccount.MyDetailsPage.SuccessNotify is not displayed
    When I click on MyAccount.MyDetailsPage.EmailUpdateButton
      And I get translation from lokalise for "EmailUpdatedSuccessfully" and store it with key #UpdateMessage
    Then I see MyAccount.MyDetailsPage.SuccessNotify contains text "#UpdateMessage"
      And I see MyAccount.MyDetailsPage.EmailCard contains text "user2#email"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyDetails @P1
  @feature:PPL-229 @feature:PPL-351 @tms:UTR-4677
  Scenario Outline: User is able to update the password successfully
    Given I am on my account details page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.MyDetailsPage.PasswordEditCancelButton
      And I type "user1#password" in the field MyAccount.MyDetailsPage.OldPassword
      And I type "1234abc7890" in the field MyAccount.MyDetailsPage.NewPassword
      And I type "1234abc7890" in the field MyAccount.MyDetailsPage.NewPasswordConfirm
      And I click on MyAccount.MyDetailsPage.PasswordUpdateButton
      And I get translation from lokalise for "PasswordUpdated" and store it with key #PassUpdate
    Then I see MyAccount.MyDetailsPage.SuccessNotify contains text "#PassUpdate"

    Examples:
      | locale  | langCode |
      | default | default  |

  #@FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyDetails @P2
  @feature:PPL-229 @feature:PPL-351 @tms:UTR-4679
  Scenario Outline: User can see password requirements when changing password
    Given I am on my account details page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.MyDetailsPage.PasswordEditCancelButton
      And I type "user1#password" in the field MyAccount.MyDetailsPage.OldPassword
      And I type "abc" in the field MyAccount.MyDetailsPage.NewPassword
      And I type "234" in the field MyAccount.MyDetailsPage.NewPasswordConfirm
      And I get translation from lokalise for "PasswordAlphabetic" and store it with key #PassAlphabetic
      And I get translation from lokalise for "PasswordNumeric" and store it with key #PassNumeric
      And I get translation from lokalise for "RegisterPasswordMinMax" and store it with key #PassMinMax
    Then I see MyAccount.MyDetailsPage.PasswordRequirementsList with index 1 contains text "#PassAlphabetic"
      And I see MyAccount.MyDetailsPage.PasswordRequirementsList with index 2 contains text "#PassNumeric"
      And I see MyAccount.MyDetailsPage.PasswordRequirementsList with index 3 contains text "#PassMinMax"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyDetails @P2
  @feature:PPL-974
  Scenario Outline: User can see password requirements error when using consecutive characters or instances
    Given I am on my account details page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.MyDetailsPage.PasswordEditCancelButton
      And I type "user1#password" in the field MyAccount.MyDetailsPage.OldPassword
      And I type "<pass>" in the field MyAccount.MyDetailsPage.NewPassword
      And I type "<pass>" in the field MyAccount.MyDetailsPage.NewPasswordConfirm
      And I click on MyAccount.MyDetailsPage.PasswordUpdateButton
      And I get translation from lokalise for "<ErrorMessage>" and store it with key #PassError
    Then I see MyAccount.MyDetailsPage.PasswordConsecutiveCharError contains text "#PassError"

    @tms:UTR-12156
    Examples:
      | locale  | langCode | pass        | ErrorMessage                  |
      | default | default  | abccc21453f | PasswordConsecutiveCharacters |

    @tms:UTR-14564
    Examples:
      | locale           | langCode         | pass            | ErrorMessage                  |
      | multiLangDefault | multiLangDefault | abc1111dsfg2134 | PasswordConsecutiveCharacters |

    @tms:UTR-14565
    Examples:
      | locale  | langCode | pass         | ErrorMessage                  |
      | default | default  | qq1qq2q12345 | PasswordMaxInstanceCharacters |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyDetails @P3
  @feature:PPL-228 @tms:UTR-12216
  Scenario Outline: User can close password edit form and then decide to continue to edit and save new details
    Given I am on my account details page on locale <locale> of langCode <langCode> with forced accepted cookies
    Then I see MyAccount.MyDetailsPage.PasswordCard contains text "*********"
    When I click on MyAccount.MyDetailsPage.PasswordEditCancelButton
      And I type "user1#password" in the field MyAccount.MyDetailsPage.OldPassword
      And I type "1abc34567890" in the field MyAccount.MyDetailsPage.NewPassword
      And I type "1abc34567890" in the field MyAccount.MyDetailsPage.NewPasswordConfirm
      And I click on MyAccount.MyDetailsPage.PasswordEditCancelButton
    Then I see MyAccount.MyDetailsPage.DiscardButton is displayed
      And I see MyAccount.MyDetailsPage.ContinueEditingButton is displayed
    When I click on MyAccount.MyDetailsPage.DiscardButton
    Then I see MyAccount.MyDetailsPage.SuccessNotify is not displayed
      And I see MyAccount.MyDetailsPage.OldPassword is not displayed
    When I click on MyAccount.MyDetailsPage.PasswordEditCancelButton
      And I type "user1#password" in the field MyAccount.MyDetailsPage.OldPassword
      And I type "1abc34567890" in the field MyAccount.MyDetailsPage.NewPassword
      And I type "1abc34567890" in the field MyAccount.MyDetailsPage.NewPasswordConfirm
      And I click on MyAccount.MyDetailsPage.PasswordEditCancelButton
    Then I see MyAccount.MyDetailsPage.DiscardButton is displayed
      And I see MyAccount.MyDetailsPage.ContinueEditingButton is displayed
    When I click on MyAccount.MyDetailsPage.ContinueEditingButton
    Then I see the attribute value of element MyAccount.MyDetailsPage.OldPassword containing "user1#password"
      And I see the attribute value of element MyAccount.MyDetailsPage.NewPassword containing "1abc34567890"
      And I see the attribute value of element MyAccount.MyDetailsPage.NewPasswordConfirm containing "1abc34567890"
    When I click on MyAccount.MyDetailsPage.PasswordUpdateButton
      And I get translation from lokalise for "PasswordUpdated" and store it with key #UpdateMessage
    Then I see MyAccount.MyDetailsPage.SuccessNotify contains text "#UpdateMessage"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyDetails @ExcludeCK @P3
  Scenario Outline: User can see the updated Tommy Together newsletter text when wanting to delete their account
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I sign in with email my.account.pierre.automation@outlook.com and password AutoNation2023
      And I wait for 3 seconds
      And I navigate to details page
    When I click on MyAccount.MyDetailsPage.DeleteAccountButton
      And I click on MyAccount.MyDetailsPage.ExpandTextButton
      And I get translation from lokalise for "NewsletterStaySub" and store it with key #NewsletterStaySub
    Then I see MyAccount.MyDetailsPage.NewsletterText contains text "#NewsletterStaySub"

    @tms:UTR-18769
    Examples:
      | locale  | langCode |
      | default | default  |