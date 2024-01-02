Feature: Unified My Account - My addresses

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedMyAccount @PPL @MyAddresses @P2
  @feature:PPL-501 @tms:UTR-5467
  Scenario Outline: User is able to see all the components in address overview page
    Given I am on shopping-bag page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
      And I sign in with user "pvh.es.automation@outlook.com" and password "AutoNation2023"
      And I wait for 1 seconds
      And I navigate to addresses page
    Then I see MyAccount.AddressPage.AddAddressButton is displayed in 5 seconds
      And I see MyAccount.AddressPage.AddressCard is displayed
      And I see MyAccount.AddressPage.AddressEditButton is displayed
      And I see MyAccount.AddressPage.EmailAddress is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyAddresses
  @feature:PPL-505
  Scenario Outline: User is able to add new address successfully
    Given I am on my account addresses page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.AddressPage.AddAddressButton
      And in dropdown MyAccount.AddressPage.AddressTypeDropdown I select the option by index "<addressTypeIndex>"
      And I add a new address as Mr
      And I click on MyAccount.AddressPage.SaveAddressButton
      And I get translation from lokalise for "SuccessfullyAddedNewAddress" and store it with key #NewAddressMessage
    Then I see MyAccount.AddressPage.SuccessfullDoneNotification contains text "#NewAddressMessage"
      And I see MyAccount.AddressPage.AddressCard is displayed

    @tms:UTR-5532 @P1
    Examples:
      | locale           | langCode         | addressTypeIndex |
      | multiLangDefault | multiLangDefault | 1                |

    @tms:UTR-5476 @P2
    Examples:
      | locale  | langCode | addressTypeIndex |
      | default | default  | 2                |

    @tms:UTR-12890 @P2
    Examples:
      | locale           | langCode         | addressTypeIndex |
      | multiLangDefault | multiLangDefault | 3                |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyAddresses @P2
  @feature:PPL-505 @tms:UTR-5569
  Scenario Outline: User can close or cancel adding an address and details will not be saved
    Given  I am on my account addresses page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.AddressPage.AddAddressButton
      And I add a new address as Other
    When I click on MyAccount.AddressPage.CancelButton
      And I get translation from lokalise for "ChangesNotSaved" and store it with key #Title
      And I get translation from lokalise for "AreYouSure" and store it with key #AreYouSure
    Then I see MyAccount.AddressPage.ChangesNotSavedPopUpTitle contains text "#Title"
      And I see MyAccount.AddressPage.ChangesNotSavedPopUpInfo contains text "#AreYouSure"
      And I see MyAccount.AddressPage.DiscardButton is displayed
      And I see MyAccount.AddressPage.ContinueEdittingButton is displayed
      And I see MyAccount.AddressPage.PopUpCloseButton is displayed
    When I click on MyAccount.AddressPage.ContinueEdittingButton
    Then I see MyAccount.AddressPage.FirstNameInput is displayed
      And I see MyAccount.AddressPage.SaveAddressButton is displayed
    When I click on MyAccount.AddressPage.AddFormCloseButton
    Then I see MyAccount.AddressPage.ChangesNotSavedPopUpTitle is displayed
    When I click on MyAccount.AddressPage.DiscardButton
    Then I see MyAccount.AddressPage.FirstNameInput is not displayed
      And I see MyAccount.AddressPage.AddAddressButton is displayed
      And I see MyAccount.AddressPage.AddressCard is not displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyAddresses
  @feature:PPL-505
  Scenario Outline: Error validations for input fields when adding a new address
    Given  I am on my account addresses page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.AddressPage.AddAddressButton
    When I type "<FirstName>" in the field MyAccount.AddressPage.FirstNameInput
      And I type "<LastName>" in the field MyAccount.AddressPage.LastNameInput
      And I type "<City>" in the field MyAccount.AddressPage.CityInput
      And I type "<PostalCode>" in the field MyAccount.AddressPage.PostCodeInput
      And I click on MyAccount.AddressPage.SaveAddressButton
      And I get translation from lokalise for "<FirstNameError>" and store it with key #FirstNameError
      And I get translation from lokalise for "<LastNameError>" and store it with key #LastNameError
      And I get translation from lokalise for "<CityError>" and store it with key #CityError
      And I get translation from lokalise for "<PostCodeError>" and store it with key #PostCodeError
    Then I see MyAccount.AddressPage.FirstNameError contains text "#FirstNameError"
      And I see MyAccount.AddressPage.LastNameError contains text "#LastNameError"
      And I see MyAccount.AddressPage.CityError contains text "#CityError"
      And I see MyAccount.AddressPage.PostCodeError contains text "#PostCodeError"

    @tms:UTR-5571 @P2
    Examples:
      | locale           | langCode         | FirstName | LastName | City | PostalCode | FirstNameError       | LastNameError       | CityError       | PostCodeError       |
      | multiLangDefault | multiLangDefault | 123Test   | T35t     | 1    | ab1        | FirstNameFormatError | LastNameFormatError | CityFormatError | PostCodeFormatError |

    @tms:UTR-14557 @P2
    Examples:
      | locale  | langCode | FirstName | LastName | City    | PostalCode | FirstNameError       | LastNameError       | CityError       | PostCodeError       |
      | default | default  | 5345      | 123      | Nitra23 | #@fr21     | FirstNameFormatError | LastNameFormatError | CityFormatError | PostCodeFormatError |

    @tms:UTR-18768 @P3
    Examples:
      | locale | langCode | FirstName | LastName | City    | PostalCode | FirstNameError       | LastNameError       | CityError       | PostCodeError       |
      | ie     | default  | 5345      | 123      | Nitra23 | #@fr21     | FirstNameFormatError | LastNameFormatError | CityFormatError | PostCodeFormatError |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyAddresses @P2
  @feature:PPL-505 @tms:UTR-5572
  Scenario Outline: User gets an error when adding a new address for every mandatory field
    Given  I am on my account addresses page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I click on MyAccount.AddressPage.AddAddressButton
    When I click on MyAccount.AddressPage.SaveAddressButton
      And I get translation from lokalise for "FirstNameRequired" and store it with key #FirstNameError
      And I get translation from lokalise for "LastNameRequired" and store it with key #LastNameError
      And I get translation from lokalise for "AddressRequired" and store it with key #AddressError
      And I get translation from lokalise for "CityRequired" and store it with key #CityError
      And I get translation from lokalise for "PostCodeRequired" and store it with key #PostCodeError
    Then I see MyAccount.AddressPage.FirstNameError contains text "#FirstNameError"
      And I see MyAccount.AddressPage.LastNameError contains text "#LastNameError"
      And I see MyAccount.AddressPage.AddressError contains text "#AddressError"
      And I see MyAccount.AddressPage.CityError contains text "#CityError"
      And I see MyAccount.AddressPage.PostCodeError contains text "#PostCodeError"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyAddresses @P2
  @feature:PPL-503 @tms:UTR-5703
  @issue:PPL-1437
  Scenario Outline: User is able to edit an address
    Given  I am on my account addresses page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.AddressPage.AddAddressButton
      And I add a new address as Mrs
      And I click on MyAccount.AddressPage.SaveAddressButton
      And I wait for 1 seconds
      And I get translation from lokalise for "SuccessfullyAddedNewAddress" and store it with key #NewAddressMessage
    Then I see MyAccount.AddressPage.SuccessfullDoneNotification contains text "#NewAddressMessage"
      And I see MyAccount.AddressPage.AddressCard is displayed
      And I click on MyAccount.AddressPage.ClosePopUp
    When I click on MyAccount.AddressPage.AddressEditButton
      And I type "Automation" in the empty field MyAccount.AddressPage.FirstNameInput
      And I type "Tester" in the empty field MyAccount.AddressPage.LastNameInput
      And I type "Vodkalane" in the empty field MyAccount.AddressPage.AddressInput
      And I type "Absolut" in the empty field MyAccount.AddressPage.CityInput
      And I click on MyAccount.AddressPage.SaveAddressButton
      And I get translation from lokalise for "SuccessfullyEditedAddress" and store it with key #EditAddress
    Then I see MyAccount.AddressPage.SuccessfullDoneNotification contains text "#EditAddress"
      And I see MyAccount.AddressPage.AddressCard contains text "Automation Tester"
      And I see MyAccount.AddressPage.AddressCard contains text "Vodkalane"
      And I see MyAccount.AddressPage.AddressCard contains text "Absolut"

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyAddresses @P2
  @feature:PPL-503 @tms:UTR-5704
  Scenario Outline: User is able to cancel address edit and info remains the same
    Given  I am on my account addresses page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.AddressPage.AddAddressButton
      And I get translation from lokalise for "SuccessfullyAddedNewAddress" and store it with key #NewAddressMessage
      And I add a new address as Other
      And I click on MyAccount.AddressPage.SaveAddressButton
    Then I see MyAccount.AddressPage.SuccessfullDoneNotification contains text "#NewAddressMessage"
      And I see MyAccount.AddressPage.AddressCard is displayed
    When I click on MyAccount.AddressPage.AddressEditButton
      And I type "Automation" in the empty field MyAccount.AddressPage.FirstNameInput
      And I type "Tester" in the empty field MyAccount.AddressPage.LastNameInput
      And I type "Vodkalane" in the empty field MyAccount.AddressPage.AddressInput
      And I type "Absolut" in the empty field MyAccount.AddressPage.CityInput
      And I click on MyAccount.AddressPage.CancelButton
      And I get translation from lokalise for "ChangesNotSaved" and store it with key #Title
      And I get translation from lokalise for "AreYouSure" and store it with key #AreYouSure
    Then I see MyAccount.AddressPage.ChangesNotSavedPopUpTitle contains text "#Title"
      And I see MyAccount.AddressPage.ChangesNotSavedPopUpInfo contains text "#AreYouSure"
      And I see MyAccount.AddressPage.DiscardButton is displayed
      And I see MyAccount.AddressPage.ContinueEdittingButton is displayed
      And I see MyAccount.AddressPage.PopUpCloseButton is displayed
    When I click on MyAccount.AddressPage.ContinueEdittingButton
    Then I see MyAccount.AddressPage.FirstNameInput is displayed
      And I see MyAccount.AddressPage.AddressInput is displayed
    When I scroll to and click on MyAccount.AddressPage.AddressEditButton
    Then I see MyAccount.AddressPage.ChangesNotSavedPopUpTitle is displayed
    When I click on MyAccount.AddressPage.DiscardButton
    Then I see MyAccount.AddressPage.FirstNameInput is not displayed
      And I see MyAccount.AddressPage.AddAddressButton is displayed
      And I see MyAccount.AddressPage.AddressCard does not contain text "Automation Tester"
      And I see MyAccount.AddressPage.AddressCard does not contain text "Vodkalane"
      And I see MyAccount.AddressPage.AddressCard does not contain text "Absolut"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyAddresses @P2
  @feature:PPL-503 @tms:UTR-5702
  Scenario Outline: User is able to delete an address
    Given  I am on my account addresses page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.AddressPage.AddAddressButton
      And I get translation from lokalise for "SuccessfullyAddedNewAddress" and store it with key #NewAddressMessage
      And I add a new address as Other
      And I click on MyAccount.AddressPage.SaveAddressButton
    Then I see MyAccount.AddressPage.SuccessfullDoneNotification contains text "#NewAddressMessage"
      And I see MyAccount.AddressPage.AddressCard is displayed
    When I click on MyAccount.AddressPage.AddressEditButton
      And I click on MyAccount.AddressPage.DeleteAddressButton
      And I get translation from lokalise for "DeleteAddress" and store it with key #Title
      And I get translation from lokalise for "AreYouSureYouWantToDelete" and store it with key #AreYouSure
    Then I see MyAccount.AddressPage.ChangesNotSavedPopUpTitle contains text "#Title"
      And I see MyAccount.AddressPage.ChangesNotSavedPopUpInfo contains text "#AreYouSure"
      And I see MyAccount.AddressPage.DiscardButton is displayed
      And I see MyAccount.AddressPage.ContinueEdittingButton is displayed
      And I see MyAccount.AddressPage.PopUpCloseButton is displayed
    When I click on MyAccount.AddressPage.ContinueEdittingButton
    Then I see MyAccount.AddressPage.FirstNameInput is displayed
      And I see MyAccount.AddressPage.AddressInput is displayed
    When I click on MyAccount.AddressPage.DeleteAddressButton
      And I click on MyAccount.AddressPage.DiscardButton
    Then I see MyAccount.AddressPage.FirstNameInput is not displayed
      And I see MyAccount.AddressPage.AddAddressButton is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyAddresses @P3
  @feature:PPL-503 @tms:UTR-5701
  Scenario Outline: User is able to delete multiple addresses
    Given  I am on my account addresses page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.AddressPage.AddAddressButton
      And I get translation from lokalise for "SuccessfullyAddedNewAddress" and store it with key #NewAddressMessage
      And I add a new address as Other
      And I click on MyAccount.AddressPage.SaveAddressButton
      And I click on MyAccount.AddressPage.ClosePopUp
      And I wait for 1 seconds
      And I click on MyAccount.AddressPage.AddAddressButton
      And I add a new address as Mr
      And I click on MyAccount.AddressPage.SaveAddressButton
      And I click on MyAccount.AddressPage.ClosePopUp
      And I wait for 1 seconds
      And I click on MyAccount.AddressPage.AddAddressButton
      And I add a new address as Mrs
      And I click on MyAccount.AddressPage.SaveAddressButton
      And I click on MyAccount.AddressPage.ClosePopUp
      And I wait for 2 seconds
    Then the count of displayed elements MyAccount.AddressPage.AddressCard is equal to 3
    When I click on MyAccount.AddressPage.AddressEditButton
      And I click on MyAccount.AddressPage.DeleteAddressButton
      And I click on MyAccount.AddressPage.DiscardButton
      And I wait for 2 seconds
    When I click on MyAccount.AddressPage.AddressEditButton
      And I click on MyAccount.AddressPage.DeleteAddressButton
      And I click on MyAccount.AddressPage.DiscardButton
      And I wait for 2 seconds
    When I click on MyAccount.AddressPage.AddressEditButton
      And I click on MyAccount.AddressPage.DeleteAddressButton
      And I click on MyAccount.AddressPage.DiscardButton
    Then I see MyAccount.AddressPage.AddressCard is not displayed

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedMyAccount @PPL @MyAddresses @P2
  @feature:PPL-505 @tms:UTR-12891
  Scenario Outline: User can change country and add a new address and specific fields for that country will be displayed
    Given  I am on my account addresses page on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.AddressPage.AddAddressButton
      And in dropdown MyAccount.AddressPage.AddressTypeDropdown I select the option by index "2"
      And in dropdown MyAccount.AddressPage.CountryDropdown I select the option by text "Dinamarca"
      And I click on MyAccount.AddressPage.OtherButton
      And I type "Automation" in the empty field MyAccount.AddressPage.FirstNameInput
      And I type "Tester" in the empty field MyAccount.AddressPage.LastNameInput
      And I type "Vodkalane" in the empty field MyAccount.AddressPage.AddressInput
      And I type "14 A" in the empty field MyAccount.AddressPage.AditionInput
      And I type "Absolut" in the empty field MyAccount.AddressPage.StateInput
      And I type "Snowland" in the empty field MyAccount.AddressPage.CityInput
      And I type "3213" in the empty field MyAccount.AddressPage.PostCodeInput
      And I type "132321412" in the empty field MyAccount.AddressPage.PhoneInput
      And I click on MyAccount.AddressPage.SaveAddressButton
      And I get translation from lokalise for "SuccessfullyAddedNewAddress" and store it with key #NewAddressMessage
    Then I see MyAccount.AddressPage.SuccessfullDoneNotification contains text "#NewAddressMessage"
      And I see MyAccount.AddressPage.AddressCard is displayed

    Examples:
      | locale  | langCode |
      | default | default  |