Feature: CSR - Account management create and edit user

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  @tms:UTR-11937
  Scenario Outline: Csr user can see results when search in account management
    Given I am in csr account search of locale default and langCode default with L4 csr account with forced accepted cookies
      And I mix uppercase and lowercase of csr L1 account and store it with key #newEmail
    When I type "<searchTermEmail>" in the empty field Csr.AccountManagementPage.EmailInput
      And I type "L1_Automation" in the empty field Csr.AccountManagementPage.FisrtNameInput
      And I type "Test" in the empty field Csr.AccountManagementPage.SurnameInput
      And I click on Csr.AccountManagementPage.SearchButton
    Then I see Csr.AccountManagementPage.SearchResultTableEmailColumn with text <searchTermEmailToCheck> is displayed in 10 seconds
      And I see Csr.AccountManagementPage.SearchResultTableNameColumn with text L1_Automation Test is displayed
      And I see Csr.AccountManagementPage.SearchResultTableDeactivateButton is displayed
      And I see Csr.AccountManagementPage.SearchResultTablePasswordButton is displayed

    Examples:
      | searchTermEmail | searchTermEmailToCheck |
      | #newEmail       | #csrL1Email            |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-11939
  Scenario Outline: L4 Csr user can edit Csr First and Last name of agent account
    Given I am in csr account search of locale default and langCode default with L4 csr account with forced accepted cookies
      And I type "<searchTermEmail>" in the empty field Csr.AccountManagementPage.EmailInput
      And I click on Csr.AccountManagementPage.SearchButton
    Then I see Csr.AccountManagementPage.SearchResultTableEmailColumn with text <searchTermEmail> is displayed in 15 seconds
    When I click on Csr.AccountManagementPage.SearchResultTableEditButton
      And I store the value of attribute value of element Csr.AccountManagementPage.EditFirstNameInput with key #firstnameBefore
      And I store the value of attribute value of element Csr.AccountManagementPage.EditLastNameInput with key #lastnameBefore
      And I clear text field of element Csr.AccountManagementPage.EditFirstNameInput
      And I clear text field of element Csr.AccountManagementPage.EditLastNameInput
      And I type random string with length 8 in the field Csr.AccountManagementPage.EditFirstNameInput
      And I type random string with length 8 in the field Csr.AccountManagementPage.EditLastNameInput
      And I click on Csr.AccountManagementPage.EditSaveButton
      And I click on Csr.AccountManagementPage.BackToSearchButton
      And I click on Csr.AccountManagementPage.SearchResultTableEditButton
      And I wait for 5 seconds
    Then the value of attribute value of element Csr.AccountManagementPage.EditFirstNameInput should not be equal to the stored value with key #firtnameBefore
      And the value of attribute value of element Csr.AccountManagementPage.EditLastNameInput should not be equal to the stored value with key #lastnameBefore

    Examples:
      | searchTermEmail   |
      | csr1@salmon.com |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-11940
  Scenario: L3 Csr user can not edit Csr account
    Given I am in csr account search of locale default and langCode default with L3 csr account with forced accepted cookies
      And I click on Csr.AccountManagementPage.ClearButton
      And I type "csr3@salmon.com" in the empty field Csr.AccountManagementPage.EmailInput
      And I click on Csr.AccountManagementPage.SearchButton
    Then I see Csr.AccountManagementPage.SearchResultTableEmailColumn is displayed in 10 seconds
      And I see Csr.AccountManagementPage.SearchResultTableEditButton is not displayed
      And I see Csr.AccountManagementPage.SearchResultTableDeactivateButton is not displayed

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-11941
  Scenario: L4 Csr user see error message when no changes has been made
    Given I am in csr account search of locale default and langCode default with L4 csr account with forced accepted cookies
      And I click on Csr.AccountManagementPage.ClearButton
      And I type "Test" in the empty field Csr.AccountManagementPage.FisrtNameInput
      And I click on Csr.AccountManagementPage.SearchButton
      And I click on Csr.AccountManagementPage.SearchResultTableEditButton in 10 seconds
      And I see Csr.AccountManagementPage.EditFirstNameInput is displayed
      And I click on Csr.AccountManagementPage.EditSaveButton
    Then I see Csr.AccountManagementPage.SearchErrorMsg contains text "No changes have been made"

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-10861
  Scenario Outline: L4 Csr user can see edit, change password and deactivate when searched for Csr agent account
    Given I am in csr account search of locale default and langCode default with L4 csr account with forced accepted cookies
      And I type "<email>" in the empty field Csr.AccountManagementPage.EmailInput
      And I click on Csr.AccountManagementPage.SearchButton
    Then I see Csr.AccountManagementPage.SearchResultTableEmailColumn with text <email> is displayed in 10 seconds
      And I see Csr.AccountManagementPage.SearchResultTableEditButton is displayed
    When I click on Csr.AccountManagementPage.SearchResultTableEditButton
    Then I see Csr.AccountManagementPage.EditFirstNameInput is displayed
      And I see Csr.AccountManagementPage.EditLastNameInput is displayed
      And I see Csr.AccountManagementPage.EditSaveButton is displayed
      And I click on Csr.AccountManagementPage.AccountManagementTab
    When I click on Csr.AccountManagementPage.SearchResultTablePasswordButton
    Then I see Csr.AccountManagementPage.PasswordResetPopup is displayed
      And I click on Csr.AccountManagementPage.PasswordResetPopupClose
    When I click on Csr.AccountManagementPage.SearchResultTableDeactivateButton
    Then I see Csr.AccountManagementPage.DeactivatePopup is displayed
      And I see Csr.AccountManagementPage.DeactivatePopupConfirmButton is displayed
      And I see Csr.AccountManagementPage.DeactivatePopupCancelButton is displayed
      And I click on Csr.AccountManagementPage.DeactivatePopupCancelButton

    Examples:
      | email                    |
      | csr2@salmon.com |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-10855
  Scenario Outline: L4 Csr user can change password of another L4 Csr agent account
    Given I am in csr account search of locale default and langCode default with L4 csr account with forced accepted cookies
      And I type "<email>" in the field Csr.AccountManagementPage.EmailInput
      And I click on Csr.AccountManagementPage.SearchButton
    Then I see Csr.AccountManagementPage.SearchResultTableEmailColumn with text <email> is displayed in 10 seconds
    When I click on Csr.AccountManagementPage.SearchResultTablePasswordButton
      And I enter CSR L4 password in the field Csr.AccountManagementPage.PasswordPopupInputField
      And I click on Csr.AccountManagementPage.GeneratePasswordButton
    Then I see Csr.AccountManagementPage.UpdatePasswordPopup contains text "Password for `<email>` CSR user has been updated"

    Examples:
      | email                    |
      | testautomationl4@pvh.com |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  Scenario Outline: Csr user can see results when searching with valid data
    Given I am in csr account search of locale default and langCode default with L4 csr account with forced accepted cookies
    When I type "<text>" in the empty field Csr.AccountManagementPage.<inputField>
      And I click on Csr.AccountManagementPage.SearchButton
    Then I see Csr.AccountManagementPage.SearchResultTable is displayed in 10 seconds
      And I see Csr.AccountManagementPage.<resultColumn> contains text "<text>" is displayed

    @tms:UTR-10857
    Examples:
      | inputField | text              | resultColumn                 |
      | EmailInput | dtcsr1@salmon.com | SearchResultTableEmailColumn |

    @tms:UTR-10858
    Examples:
      | inputField     | text | resultColumn                |
      | FisrtNameInput | Test | SearchResultTableNameColumn |

    @tms:UTR-10851
    Examples:
      | inputField   | text | resultColumn                |
      | SurnameInput | User | SearchResultTableNameColumn |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-10853
  Scenario Outline: Csr user can see results when searching with Csr Level
    Given I am in csr account search of locale default and langCode default with L4 csr account with forced accepted cookies
    When in dropdown Csr.AccountManagementPage.CsrLevelDropdown I select the option by text "<text>"
      And I click on Csr.AccountManagementPage.SearchButton
    Then I see Csr.AccountManagementPage.SearchResultTable is displayed in 15 seconds
      And I see Csr.AccountManagementPage.SearchResultTableLevelColumn contains text "<text>" is displayed

    Examples:
      | text   |
      | level1 |
      | level2 |
      | level3 |
      | level4 |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  Scenario Outline: Csr user can see no results when searching with invalid data
    Given I am in csr account search of locale default and langCode default with L4 csr account with forced accepted cookies
    When I type "<text>" in the empty field Csr.AccountManagementPage.<inputField>
      And I click on Csr.AccountManagementPage.SearchButton
    Then I see Csr.AccountManagementPage.SearchResultTable is not displayed
      And I see Csr.AccountManagementPage.SearchResultText with text Found 0 matching accounts is displayed in 10 seconds

    @tms:UTR-10854
    Examples:
      | inputField | text                                        |
      | EmailInput | reallSstrangeEmailThatShouldntExist@pvh.com |
      | EmailInput | 123@@@-com                                  |

    @tms:UTR-10850
    Examples:
      | inputField     | text |
      | FisrtNameInput | 123  |
      | FisrtNameInput | $@@  |

    @tms:UTR-10852
    Examples:
      | inputField   | text |
      | SurnameInput | 123  |
      | SurnameInput | $@@  |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-10856
  Scenario: Csr user can see results when searching with valid firstname and surname
    Given I am in csr account search of locale default and langCode default with L4 csr account with forced accepted cookies
    When I type "Test" in the empty field Csr.AccountManagementPage.FisrtNameInput
      And I type "User" in the empty field Csr.AccountManagementPage.SurnameInput
      And I click on Csr.AccountManagementPage.SearchButton
    Then I see Csr.AccountManagementPage.SearchResultTable is displayed
      And I see Csr.AccountManagementPage.SearchResultTableNameColumn contains text "Test" is displayed
      And I see Csr.AccountManagementPage.SearchResultTableNameColumn contains text "Test" is displayed

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-10860
  Scenario Outline: Csr user can see results when searching with valid firstname and email
    Given I am in csr account search of locale default and langCode default with L4 csr account with forced accepted cookies
    When I type "Test" in the empty field Csr.AccountManagementPage.FisrtNameInput
      And I type "<email>" in the empty field Csr.AccountManagementPage.EmailInput
      And I click on Csr.AccountManagementPage.SearchButton
    Then I see Csr.AccountManagementPage.SearchResultTable is displayed
      And I see Csr.AccountManagementPage.SearchResultTableNameColumn contains text "Test" is displayed
      And I see Csr.AccountManagementPage.SearchResultTableEmailColumn contains text "<email>" is displayed

    Examples:
      | email                 |
      | automationl46@pvh.com |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-10849
  Scenario: Csr user can see results when searching with valid surname and email
    Given I am in csr account search of locale default and langCode default with L4 csr account with forced accepted cookies
    When I type "User" in the empty field Csr.AccountManagementPage.SurnameInput
      And I type "automationl46@pvh.com" in the empty field Csr.AccountManagementPage.EmailInput
      And I click on Csr.AccountManagementPage.SearchButton
    Then I see Csr.AccountManagementPage.SearchResultTable is displayed
      And I see Csr.AccountManagementPage.SearchResultTableNameColumn contains text "Test" is displayed
      And I see Csr.AccountManagementPage.SearchResultTableEmailColumn contains text "automationl46@pvh.com" is displayed

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-10859 @issue:EER-12147
  Scenario: Csr user can see results by clicking on search button without any input data
    Given I am in csr account search of locale default and langCode default with L4 csr account with forced accepted cookies
      And I click on Csr.AccountManagementPage.SearchButton
    Then I see Csr.AccountManagementPage.SearchResultTable is displayed
      And I see Csr.AccountManagementPage.SearchResultTableNameColumn is displayed

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-2471
  Scenario: L4 Csr user can see error messages when creating new user with empty fields
    Given I am in csr account creation of locale default and langCode default with L4 csr account with forced accepted cookies
      And I click on Csr.CsrCreateUserPage.CreateUserSubmitButton
    Then the count of elements Csr.CsrCreateUserPage.InputError is equal to 5

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-11942
  Scenario Outline: L4 Csr user can create new Csr user
    Given I am in csr account creation of locale default and langCode default with L4 csr account with forced accepted cookies
      And There is 1 account
      And I type to following inputs
      | element                              | value       |
      | Csr.CsrCreateUserPage.FirstNameInput | CSRFirsName |
      | Csr.CsrCreateUserPage.LastNameInput  | CSRLastName |
      | Csr.CsrCreateUserPage.EmailInput     | <userEmail> |
      And in dropdown Csr.CsrCreateUserPage.CsrLevelDropdown I select the option by text "level1"
      And in dropdown Csr.CsrCreateUserPage.CsrCompanyDropdown I select the option by text "PVH"
      And I click on Csr.CsrCreateUserPage.CreateUserSubmitButton
    Then I see Csr.CsrCreateUserPage.CreatedUserText contains text "Created CSR users"
      And I see Csr.CsrCreateUserPage.CreatedUserEmail with text <userEmail> is displayed
      And I see Csr.CsrCreateUserPage.CreatedUserPassword is displayed
      And I see Csr.CsrCreateUserPage.CreatedUserPasswordCopyButton is displayed

    Examples:
      | userEmail   |
      | user1#email |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-2470
  Scenario Outline: Csr user can see error message when entering invalid email
    Given I am in csr account creation of locale default and langCode default with L4 csr account with forced accepted cookies
    When I type "<invalidEmail>" in the field Csr.CsrCreateUserPage.EmailInput
      And I click on Csr.CsrCreateUserPage.CreateUserSubmitButton
    Then I see Csr.CsrCreateUserPage.EmailInputError with text <invalidEmail> is not a valid email is displayed

    Examples:
      | invalidEmail |
      | 1234@.com    |
      | abc@###      |
      | xyz.com      |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-16382
  Scenario Outline: Csr user is allow to login using upper case character in email address
    Given I am in csr account search of locale default and langCode default with <email> <password> csr account with forced accepted cookies
    When I type "<email>" in the field Csr.AccountManagementPage.EmailInput
      And I click on Csr.AccountManagementPage.SearchButton
    Then I see Csr.AccountManagementPage.SearchResultTable is displayed
      And I see Csr.AccountManagementPage.SearchResultTableNameColumn is displayed

    Examples:
      | email                     | password      |
      | automationl4UPPER@pvh.com | London@123456 |
