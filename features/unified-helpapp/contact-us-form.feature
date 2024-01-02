Feature: Unified - Contact Us Form

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedContactUsPage @UnifiedExperience @EER @HelpApp @P3 @ExcludeUat
  Scenario Outline: Contact us page - Character countdown message is displayed
    Given I am on locale <locale> of url <url> of langCode <langCode> with accepted cookies
      And I see Experience.ContactUsOverviewPage.ContactUSBlock is displayed
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
      Then I see Experience.ContactUsPage.ContactUsForm is displayed
      And I type random string with length <messageInputLength> in the field Experience.ContactUsPage.MessageInput
      And I see Experience.ContactUsPage.CharactersLimitMessage with text <messageLength> is displayed

    @tms:UTR-11637
    Examples:
      | locale  | langCode | messageInputLength | messageLength | url             |
      | default | default  | 0                  | 0/2000        | /help/contactus |

    @tms:UTR-11638
    Examples:
      | locale           | langCode         | messageInputLength | messageLength | url        |
      | multiLangDefault | multiLangDefault | 23                 | 23/2000       | /help/contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedContactUsPage @UnifiedExperience @EER @HelpApp @ExcludeSIT @ExcludeUat
  Scenario Outline: Contact us page - User can see error message when submitting without captcha
    Given I am on locale <locale> of url <url> of langCode <langCode> with accepted cookies
      And I see Experience.ContactUsOverviewPage.ContactUSBlock is displayed
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
    Then I see Experience.ContactUsPage.ContactUsForm is displayed
      And I get translation from lokalise for "RequestTypePayment" and store it with key #requestTypePaymentText
      And I get translation from lokalise for "RequestTypeSubCateCancel" and store it with key #requestTypeSubCateCancelText
      And I get translation from lokalise for "CUSubmitWithoutcaptchaError" and store it with key #submitWithoutcaptchaErrorText
    When in dropdown Experience.ContactUsPage.RequestTypeDropdown I select the option by text "#requestTypePaymentText"
      And in dropdown Experience.ContactUsPage.RequestTypeSubCategoryDropdown I select the option by text "#requestTypeSubCateCancelText"
      And I click on Experience.ContactUsPage.GenderToggleInput with text <genderIndex>
      And I type "test@test.ee" in the field Experience.ContactUsPage.EmailInput
      And I type "bla bla bla message" in the field Experience.ContactUsPage.MessageInput
      And I wait until Experience.ContactUsPage.FirstNameInput is clickable
      And I type "firstName" in the field Experience.ContactUsPage.FirstNameInput
      And I wait until Experience.ContactUsPage.LastNameInput is clickable
      And I type "lastName" in the field Experience.ContactUsPage.LastNameInput
      And I wait until Experience.ContactUsPage.PhoneInput is clickable
      And I type "0123456789" in the field Experience.ContactUsPage.PhoneInput
      And I type "1230" in the field Experience.ContactUsPage.OrderNumber
      And I scroll to the element Experience.ContactUsPage.ContactUsSubmitButton
      And I see Experience.ContactUsPage.CallUsComponent is displayed in 2 seconds
      And I click on Experience.ContactUsPage.ContactUsSubmitButton
    Then I see Experience.ContactUsPage.FormErrorMsg is displayed with text #submitWithoutcaptchaErrorText

    @tms:UTR-11641 @P1
    Examples:
      | locale  | langCode | genderIndex | url        |
      | default | default  | 1           | /help/contactus |

    @tms:UTR-11642
    Examples:
      | locale           | langCode         | genderIndex | url        |
      | multiLangDefault | multiLangDefault | 2           | /help/contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedContactUsPage @UnifiedExperience @EER @HelpApp @P3 @ExcludeUat
  Scenario Outline: Contact us page - User is restricted to enter not more than 80 characters in Item number field
    Given I am on locale <locale> of url <url> of langCode <langCode> with accepted cookies
      And I see Experience.ContactUsOverviewPage.ContactUSBlock is displayed
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
    Then I see Experience.ContactUsPage.ContactUsForm is displayed
      And I get translation from lokalise for "RequestTypeOS&D" and store it with key #requestTypeOS&DText
      And in dropdown Experience.ContactUsPage.RequestTypeDropdown I select the option by text "#requestTypeOS&DText"
      And I type random string with length <itemNumberInputLength> in the field Experience.ContactUsPage.ItemNumberInput
      And I store the value of attribute value of element Experience.ContactUsPage.ItemNumberInput with key #itemNumber
    Then I see the length of key #itemNumber is equal to 80

    @tms:UTR-11643
    Examples:
      | locale  | langCode | itemNumberInputLength | url        |
      | default | default  | 85                    | /help/contactus |

    @tms:UTR-11644
    Examples:
      | locale           | langCode         | itemNumberInputLength | url        |
      | multiLangDefault | multiLangDefault | 85                    | /help/contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedContactUsPage @UnifiedExperience @EER @HelpApp @P3 @ExcludeUat
  Scenario Outline: Contact us page - error messages are displayed if fields are missing
    Given I am on locale <locale> of url <url> of langCode <langCode> with accepted cookies
      And I see Experience.ContactUsOverviewPage.ContactUSBlock is displayed
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
    Then I see Experience.ContactUsPage.ContactUsForm is displayed
      And I get translation from lokalise for "RequestTypeOther" and store it with key #requestTypeOtherText
      And in dropdown Experience.ContactUsPage.RequestTypeDropdown I select the option by text "#requestTypeOtherText"
      And I scroll to the element Experience.ContactUsPage.ContactUsSubmitButton
      And I click on Experience.ContactUsPage.ContactUsSubmitButton
    Then the count of elements Experience.ContactUsPage.NoInputError is equal to 6

    @tms:UTR-11645
    Examples:
      | locale  | langCode | url        |
      | default | default  | /help/contactus |

    @tms:UTR-11646
    Examples:
      | locale           | langCode         | url        |
      | multiLangDefault | multiLangDefault | /help/contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedContactUsPage @UnifiedExperience @EER @HelpApp @P3 @ExcludeUat
  Scenario Outline: Contact us page - User can see error message is displayed if enters invalid input
    Given I am on locale <locale> of url <url> of langCode <langCode> with accepted cookies
      And I see Experience.ContactUsOverviewPage.ContactUSBlock is displayed
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
    Then I see Experience.ContactUsPage.ContactUsForm is displayed
      And I get translation from lokalise for "RequestTypePayment" and store it with key #requestTypePaymentText
      And I get translation from lokalise for "RequestTypeOther" and store it with key #requestTypeOtherText
      And in dropdown Experience.ContactUsPage.RequestTypeDropdown I select the option by text "<requestType>"
      And I type "<invalidData>" in the empty field Experience.ContactUsPage.<inputField>
      And I click on Experience.ContactUsPage.ContactUsSubmitButton
    Then I see Experience.ContactUsPage.<inputError> is displayed

    @tms:UTR-11647
    Examples:
      | locale  | langCode | requestType             | inputField | invalidData | inputError    | url        |
      | default | default  | #requestTypePaymentText | EmailInput | abc@234     | EmailErrorMsg | /help/contactus |
      | default | default  | #requestTypeOtherText   | EmailInput | abc@234     | EmailErrorMsg | /help/contactus |

    @tms:UTR-11648
    Examples:
      | locale           | langCode         | requestType             | inputField | invalidData | inputError    | url        |
      | multiLangDefault | multiLangDefault | #requestTypeOtherText   | PhoneInput | abc         | PhoneErrorMsg | /help/contactus |
      | multiLangDefault | multiLangDefault | #requestTypePaymentText | PhoneInput | @@456       | PhoneErrorMsg | /help/contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedContactUsPage @UnifiedExperience @EER @HelpApp @P3 @ExcludeUat
  Scenario Outline: Contact us page - Message Length error displayed when limit exceeded
    Given I am on locale <locale> of url <url> of langCode <langCode> with accepted cookies
      And I see Experience.ContactUsOverviewPage.ContactUSBlock is displayed
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
    Then I see Experience.ContactUsPage.ContactUsForm is displayed
      And I type random string with length <messageInputLength> in the field Experience.ContactUsPage.MessageInput
      And I click on Experience.ContactUsPage.ContactUsSubmitButton
    Then I see Experience.ContactUsPage.CharactersLimitMessage with text <messageLength> is displayed
      And I see Experience.ContactUsPage.<inputError> is displayed

    @tms:UTR-11649
    Examples:
      | locale  | langCode | messageInputLength | messageLength | inputError         | url        |
      | default | default  | 2001               | 2001/2000     | MessageLengthError | /help/contactus |

    @tms:UTR-11650
    Examples:
      | locale           | langCode         | messageInputLength | messageLength | inputError         | url        |
      | multiLangDefault | multiLangDefault | 2005               | 2005/2000     | MessageLengthError | /help/contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedContactUsPage @UnifiedExperience @EER @HelpApp @P2 @Translation @Lokalise @ExcludeUat
  Scenario Outline: Contact us page - User should be able to change the category after subcategory selection, subcategory throwing error if not selected.
    Given I am on locale <locale> of url <url> of langCode <langCode> with accepted cookies
      And I see Experience.ContactUsOverviewPage.ContactUSBlock is displayed
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
    Then I see Experience.ContactUsPage.ContactUsForm is displayed
      And I get translation from lokalise for "RequestTypePayment" and store it with key #requestTypePaymentText
      And I get translation from lokalise for "RequestTypeSubCateCancel" and store it with key #requestTypeSubCateCancelText
      And I get translation from lokalise for "RequestTypeMyAcc" and store it with key #newRequestCategoryText
      And I get translation from lokalise for "CUSubmitWithoutcaptchaError" and store it with key #submitWithoutcaptchaErrorText
      And I get translation from lokalise for "SubmitWithoutSubCategoryError" and store it with key #SubmitWithoutSubCategoryErrorText
      And in dropdown Experience.ContactUsPage.RequestTypeDropdown I select the option by text "#requestTypePaymentText"
      And in dropdown Experience.ContactUsPage.RequestTypeSubCategoryDropdown I select the option by text "#requestTypeSubCateCancelText"
      And I click on Experience.ContactUsPage.GenderToggleInput with text <genderIndex>
      And I type "test@test.ee" in the field Experience.ContactUsPage.EmailInput
      And I type "bla bla bla message" in the field Experience.ContactUsPage.MessageInput
      And I wait until Experience.ContactUsPage.FirstNameInput is clickable
      And I type "firstName" in the field Experience.ContactUsPage.FirstNameInput
      And I wait until Experience.ContactUsPage.LastNameInput is clickable
      And I type "lastName" in the field Experience.ContactUsPage.LastNameInput
      And I wait until Experience.ContactUsPage.PhoneInput is clickable
      And I type "0123456789" in the field Experience.ContactUsPage.PhoneInput
      And I type "1230" in the field Experience.ContactUsPage.OrderNumber
      And in dropdown Experience.ContactUsPage.RequestTypeDropdown I select the option by text "#newRequestCategoryText"
      And I scroll to the element Experience.ContactUsPage.ContactUsSubmitButton
      And I click on Experience.ContactUsPage.ContactUsSubmitButton
    Then I see Experience.ContactUsPage.FormErrorMsg is displayed with text #SubmitWithoutSubCategoryErrorText
      And I see Experience.ContactUsPage.FormErrorMsg is displayed with text #submitWithoutcaptchaErrorText

    @tms:UTR-13213
    Examples:
      | locale  | langCode | genderIndex | url        |
      | default | default  | 1           | /help/contactus |

    @tms:UTR-13214
    Examples:
      | locale           | langCode         | genderIndex | url        |
      | multiLangDefault | multiLangDefault | 1           | /help/contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedContactUsPage @UnifiedExperience @EER @HelpApp @P2 @ExcludeUat
  @tms:UTR-13218
  Scenario Outline: Contact us page - Logged in user should be able to see email id populated, also error message when submitting without captcha
    Given I am on locale <locale> of url <url> with accepted cookies
      And I am a logged in user
      And I wait until the current page is loaded
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
    Then I see Experience.ContactUsPage.ContactUsForm is displayed
      And I store the value of Experience.ContactUsPage.EmailInput with key #contactUsuserEmailId
    When I navigate to page <page>
      And I store the value of MyAccount.MyDetailsPage.EmailCard with key #userEmailId
    Then I see MyAccount.MyDetailsPage.EmailCard contains text "#contactUsuserEmailId"
    When I navigate back in the browser
      Then I wait until Experience.ContactUsOverviewPage.ContactUSBlock is displayed
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
    Then I see Experience.ContactUsPage.ContactUsForm is displayed
      And I get translation from lokalise for "RequestTypePayment" and store it with key #requestTypePaymentText
      And I get translation from lokalise for "RequestTypeSubCateCancel" and store it with key #requestTypeSubCateCancelText
      And I get translation from lokalise for "CUSubmitWithoutcaptchaError" and store it with key #submitWithoutcaptchaErrorText
      And in dropdown Experience.ContactUsPage.RequestTypeDropdown I select the option by text "#requestTypePaymentText"
      And in dropdown Experience.ContactUsPage.RequestTypeSubCategoryDropdown I select the option by text "#requestTypeSubCateCancelText"
      And I click on Experience.ContactUsPage.GenderToggleInput with text <genderIndex>
      And I type "test@test.ee" in the field Experience.ContactUsPage.EmailInput
      And I type "bla bla bla message" in the field Experience.ContactUsPage.MessageInput
      And I wait until Experience.ContactUsPage.FirstNameInput is clickable
      And I type "firstName" in the field Experience.ContactUsPage.FirstNameInput
      And I wait until Experience.ContactUsPage.LastNameInput is clickable
      And I type "lastName" in the field Experience.ContactUsPage.LastNameInput
      And I wait until Experience.ContactUsPage.PhoneInput is clickable
      And I type "0123456789" in the field Experience.ContactUsPage.PhoneInput
      And I type "1230" in the field Experience.ContactUsPage.OrderNumber
      And I scroll to the element Experience.ContactUsPage.ContactUsSubmitButton
      And I click on Experience.ContactUsPage.ContactUsSubmitButton
    Then I see Experience.ContactUsPage.FormErrorMsg is displayed with text #submitWithoutcaptchaErrorText

    Examples:
      | locale  | page              | genderIndex | url        |
      | default | myaccount/details | 2           | /help/contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedContactUsPage @UnifiedExperience @EER @HelpApp @P2 @ExcludeUat
  @tms:UTR-13217 @Translation @Lokalise
  Scenario Outline: Contact us page - Logged in user should be able to see email id populated, change it, also error message when submitting without captcha
    Given I am on locale <locale> of url <url> with accepted cookies
      And I am a logged in user
      And I wait until the current page is loaded
      And I see Experience.ContactUsOverviewPage.ContactUSBlock is displayed
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
    Then I see Experience.ContactUsPage.ContactUsForm is displayed
      And I get translation from lokalise for "RequestTypePayment" and store it with key #requestTypePaymentText
      And I get translation from lokalise for "RequestTypeSubCateCancel" and store it with key #requestTypeSubCateCancelText
      And I get translation from lokalise for "CUSubmitWithoutcaptchaError" and store it with key #submitWithoutcaptchaErrorText
    When I navigate to end of string and then clear text field of element Experience.ContactUsPage.EmailInput
      And in dropdown Experience.ContactUsPage.RequestTypeDropdown I select the option by text "#requestTypePaymentText"
      And in dropdown Experience.ContactUsPage.RequestTypeSubCategoryDropdown I select the option by text "#requestTypeSubCateCancelText"
      And I click on Experience.ContactUsPage.GenderToggleInput with text <genderIndex>
      And I type "test@test.ee" in the field Experience.ContactUsPage.EmailInput
      And I type "bla bla bla message" in the field Experience.ContactUsPage.MessageInput
      And I wait until Experience.ContactUsPage.FirstNameInput is clickable
      And I type "firstName" in the field Experience.ContactUsPage.FirstNameInput
      And I wait until Experience.ContactUsPage.LastNameInput is clickable
      And I type "lastName" in the field Experience.ContactUsPage.LastNameInput
      And I wait until Experience.ContactUsPage.PhoneInput is clickable
      And I type "0123456789" in the field Experience.ContactUsPage.PhoneInput
      And I type "1230" in the field Experience.ContactUsPage.OrderNumber
      And I scroll to the element Experience.ContactUsPage.ContactUsSubmitButton
      And I click on Experience.ContactUsPage.ContactUsSubmitButton
    Then I see Experience.ContactUsPage.FormErrorMsg is displayed with text #submitWithoutcaptchaErrorText

    Examples:
      | locale  | genderIndex | url        |
      | default | 2           | /help/contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedContactUsPage @UnifiedExperience @EER @HelpApp @P3 @ExcludeUat
  @tms:UTR-13219 @Translation @Lokalise
  Scenario Outline: Contact us page - Logged in user should be able to see error message for incorrect email format when removed auto populated email and added new one
    Given I am on locale <locale> of url <url> with accepted cookies
      And I am a logged in user
      And I wait until Experience.ContactUsOverviewPage.ContactUSBlock is displayed
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
    Then I see Experience.ContactUsPage.ContactUsForm is displayed
      And I get translation from lokalise for "RequestTypePayment" and store it with key #requestTypePaymentText
      And I get translation from lokalise for "RequestTypeSubCateCancel" and store it with key #requestTypeSubCateCancelText
      And I get translation from lokalise for "CUSubmitWithoutcaptchaError" and store it with key #submitWithoutcaptchaErrorText
      And I get translation from lokalise for "EmailIdIncorrectFormat" and store it with key #submitwithIncorrectEmailErrorText
    When I navigate to end of string and then clear text field of element Experience.ContactUsPage.EmailInput
      And in dropdown Experience.ContactUsPage.RequestTypeDropdown I select the option by text "#requestTypePaymentText"
      And in dropdown Experience.ContactUsPage.RequestTypeSubCategoryDropdown I select the option by text "#requestTypeSubCateCancelText"
      And I click on Experience.ContactUsPage.GenderToggleInput with text <genderIndex>
      And I type "test" in the field Experience.ContactUsPage.EmailInput
      And I type "bla bla bla message" in the field Experience.ContactUsPage.MessageInput
      And I wait until Experience.ContactUsPage.FirstNameInput is clickable
      And I type "firstName" in the field Experience.ContactUsPage.FirstNameInput
      And I wait until Experience.ContactUsPage.LastNameInput is clickable
      And I type "lastName" in the field Experience.ContactUsPage.LastNameInput
      And I wait until Experience.ContactUsPage.PhoneInput is clickable
      And I type "0123456789" in the field Experience.ContactUsPage.PhoneInput
      And I type "1230" in the field Experience.ContactUsPage.OrderNumber
      And I scroll to the element Experience.ContactUsPage.ContactUsSubmitButton
      And I see Experience.ContactUsPage.CallUsComponent is displayed in 2 seconds
      And I click on Experience.ContactUsPage.ContactUsSubmitButton
    Then I see Experience.ContactUsPage.EmailErrorMsg is displayed with text #submitwithIncorrectEmailErrorText
      And I see Experience.ContactUsPage.FormErrorMsg is displayed with text #submitWithoutcaptchaErrorText

    Examples:
      | locale  | genderIndex | url        |
      | default | 2           | /help/contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedContactUsPage @UnifiedExperience @EER @HelpApp @P3 @ExcludeUat
  @tms:@UTR-13283
  Scenario Outline: Contact us page - User is notified with error messages for the mandatory fields if left empty
    Given I am on locale <locale> of url <url> with accepted cookies
      And I see Experience.ContactUsOverviewPage.ContactUSBlock is displayed
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
    Then I see Experience.ContactUsPage.ContactUsForm is displayed
    When I click on Experience.ContactUsPage.ContactUsSubmitButton
    Then I see Experience.ContactUsPage.FormErrorMsg is displayed
      And the count of elements Experience.ContactUsPage.FormErrorMsg is equal to 3
      And I see Experience.ContactUsPage.FirstNameError is displayed
      And I see Experience.ContactUsPage.LastNameError is displayed
      And I see Experience.ContactUsPage.<inputError> is displayed
      And I see Experience.ContactUsPage.MessageLengthError is displayed

    Examples:
      | locale  | inputError    | url        |
      | default | EmailErrorMsg | /help/contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedContactUsPage @UnifiedExperience @EER @HelpApp @P2 @ExcludeUat
  @tms:UTR-13291 @Translation @Lokalise
  Scenario Outline: Contact us page - Other sub category should be available for user to submit a request
    Given I am on locale <locale> of url <url> with accepted cookies
      And I wait until Experience.ContactUsOverviewPage.ContactUSBlock is displayed
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
    Then I see Experience.ContactUsPage.ContactUsForm is displayed
      And I get translation from lokalise for "RequestTypeOther" and store it with key #requestTypeOtherText
      And I get translation from lokalise for "RequestTypeSubCateOther" and store it with key #requestTypeSubCateOtherText
      And I get translation from lokalise for "CUSubmitWithoutcaptchaError" and store it with key #submitWithoutcaptchaErrorText
    When I scroll to the element Experience.ContactUsPage.RequestTypeDropdown
      And in dropdown Experience.ContactUsPage.RequestTypeDropdown I select the option by text "#requestTypeOtherText"
      And I scroll to the element Experience.ContactUsPage.RequestTypeSubCategoryDropdown
      And in dropdown Experience.ContactUsPage.RequestTypeSubCategoryDropdown I select the option by text "#requestTypeSubCateOtherText"
      And I click on Experience.ContactUsPage.GenderToggleInput with text <genderIndex>
      And I type "test@test.ee" in the field Experience.ContactUsPage.EmailInput
      And I type "bla bla bla message" in the field Experience.ContactUsPage.MessageInput
      And I wait until Experience.ContactUsPage.FirstNameInput is clickable
      And I type "firstName" in the field Experience.ContactUsPage.FirstNameInput
      And I wait until Experience.ContactUsPage.LastNameInput is clickable
      And I type "lastName" in the field Experience.ContactUsPage.LastNameInput
      And I wait until Experience.ContactUsPage.PhoneInput is clickable
      And I type "0123456789" in the field Experience.ContactUsPage.PhoneInput
    And I scroll to the element Experience.ContactUsPage.ContactUsSubmitButton
      And I click on Experience.ContactUsPage.ContactUsSubmitButton
    Then I see Experience.ContactUsPage.FormErrorMsg is displayed with text #submitWithoutcaptchaErrorText

    Examples:
      | locale  | genderIndex | url        |
      | default | 2           | /help/contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedContactUsPage @UnifiedExperience @EER @HelpApp @P2 @ExcludeUat
  @UTR-13369 @Translation @Lokalise
  Scenario Outline: Contact us page - If special character is there in sub category then user should be able to submit a request
    Given I am on locale <locale> of url <url> with accepted cookies
      And I wait until Experience.ContactUsOverviewPage.ContactUSBlock is displayed
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
    Then I see Experience.ContactUsPage.ContactUsForm is displayed
      And I get translation from lokalise for "RequestTypeOS&D" and store it with key #requestTypeOS&DText
      And I get translation from lokalise for "RequestTypeSubCateItemDamaged" and store it with key #requestTypeSubCateItemDamagedText
      And I get translation from lokalise for "CUSubmitWithoutcaptchaError" and store it with key #submitWithoutcaptchaErrorText
    When I scroll to the element Experience.ContactUsPage.RequestTypeDropdown
      And in dropdown Experience.ContactUsPage.RequestTypeDropdown I select the option by text "#requestTypeOS&DText"
      And I scroll to the element Experience.ContactUsPage.RequestTypeSubCategoryDropdown
      And in dropdown Experience.ContactUsPage.RequestTypeSubCategoryDropdown I select the option by text "#requestTypeSubCateItemDamagedText"
      And I click on Experience.ContactUsPage.GenderToggleInput with text <genderIndex>
      And I type "test@test.ee" in the field Experience.ContactUsPage.EmailInput
      And I type "bla bla bla message" in the field Experience.ContactUsPage.MessageInput
      And I wait until Experience.ContactUsPage.FirstNameInput is clickable
      And I type "firstName" in the field Experience.ContactUsPage.FirstNameInput
      And I wait until Experience.ContactUsPage.LastNameInput is clickable
      And I type "lastName" in the field Experience.ContactUsPage.LastNameInput
      And I wait until Experience.ContactUsPage.PhoneInput is clickable
      And I type "0123456789" in the field Experience.ContactUsPage.PhoneInput
      And I type "01234" in the field Experience.ContactUsPage.OrderNumber
      And I scroll to the element Experience.ContactUsPage.ContactUsSubmitButton
      And I click on Experience.ContactUsPage.ContactUsSubmitButton
    Then I see Experience.ContactUsPage.FormErrorMsg is displayed with text #submitWithoutcaptchaErrorText

    Examples:
      | locale  | genderIndex | url        |
      | default | 2           | /help/contactus |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedContactUsPage @UnifiedExperience @EER @HelpApp @P2 @ExcludeUat
  @tms:UTR-15828 @Translation @Lokalise
  Scenario Outline: Contact us page - User should be able to see left side bar with nesting links
    Given I am on locale <locale> of url <url> with accepted cookies
      And I wait until Experience.ContactUsOverviewPage.ContactUSBlock is displayed
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
    Then I see Experience.ContactUsPage.ContactUsForm is displayed
      And I get translation from lokalise for "<category>" and store it with key #categoryText
      And I see Experience.FaqsPage.SideBarCategoryMenuUsingText with text #categoryText is displayed

    Examples:
      | locale  | category         | url        |
      | default | WomenSidebarLink | /help/contactus |
      | default | StoreLocator     | /help/contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedContactUsPage @UnifiedExperience @EER @HelpApp @P2 @GiftCard @ExcludeUat
  @tms:UTR-17290 @Translation @Lokalise
  Scenario Outline: Contact us page - User should be able to see Gift card in request type with sub-category
    Given I am on locale <locale> of url <url> with accepted cookies
      And I wait until Experience.ContactUsOverviewPage.ContactUSBlock is displayed
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
    Then I see Experience.ContactUsPage.ContactUsForm is displayed
      And I scroll to the element Experience.ContactUsPage.RequestTypeDropdown
      And I get translation from lokalise for "<category>" and store it with key #requestTypeGiftCard
      And I get translation from lokalise for "<subCategory>" and store it with key #subCategoryGiftCard
    When in dropdown Experience.ContactUsPage.RequestTypeDropdown I select the option by text "#requestTypeGiftCard"
      And I scroll to the element Experience.ContactUsPage.RequestTypeSubCategoryDropdown
      And in dropdown Experience.ContactUsPage.RequestTypeSubCategoryDropdown I select the option by text "#subCategoryGiftCard"
      And I scroll to the element Experience.ContactUsPage.ContactUsSubmitButton
    Then I click on Experience.ContactUsPage.ContactUsSubmitButton
    And I see Experience.ContactUsPage.FormErrorMsg is displayed with text #submitWithoutcaptchaErrorText

    Examples:
      | locale | category                | subCategory      | url        |
      | at     | PromotionCodesGiftCards | PurchaseGiftCard | /help/contactus |
      | at     | PromotionCodesGiftCards | RedeemGiftCard   | /help/contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedContactUsPage @UnifiedExperience @EER @HelpApp @P2 @ExcludeUat
  @tms:UTR-18057 @Translation @Lokalise
  Scenario Outline: Contact us page - Return the error when not enter the promotion code to submit a request
    Given I am on locale <locale> of url <url> of langCode <langCode> with accepted cookies
      And I wait until Experience.ContactUsOverviewPage.ContactUSBlock is displayed
    When I click on Experience.ContactUsOverviewPage.SendUSMessageLink
    Then I see Experience.ContactUsPage.ContactUsForm is displayed
      And I get translation from lokalise for "PromotionCodesGiftCards" and store it with key #promotionCodeVouchersText
      And I get translation from lokalise for "<subCategory>" and store it with key #subCategoryText
    When I scroll to the element Experience.ContactUsPage.RequestTypeDropdown
    Then in dropdown Experience.ContactUsPage.RequestTypeDropdown I select the option by text "#promotionCodeVouchersText"
    When I scroll to the element Experience.ContactUsPage.RequestTypeSubCategoryDropdown
    Then in dropdown Experience.ContactUsPage.RequestTypeSubCategoryDropdown I select the option by text "#subCategoryText"
      And I click on Experience.ContactUsPage.GenderToggleInput with text <genderIndex>
      And I type "test@test.ee" in the field Experience.ContactUsPage.EmailInput
      And I type "bla bla bla message" in the field Experience.ContactUsPage.MessageInput
      And I wait until Experience.ContactUsPage.FirstNameInput is clickable
      And I type "firstName" in the field Experience.ContactUsPage.FirstNameInput
      And I wait until Experience.ContactUsPage.LastNameInput is clickable
      And I type "lastName" in the field Experience.ContactUsPage.LastNameInput
      And I scroll to the element Experience.ContactUsPage.ContactUsSubmitButton
    When I click on Experience.ContactUsPage.ContactUsSubmitButton
    Then I see Experience.ContactUsPage.promoCodeError is displayed

    Examples:
      | locale           | langCode         | genderIndex | url        | subCategory           |
      | default          | default          | 2           | /help/contactus | RequestNewCodeText    |
      | multiLangDefault | multiLangDefault | 1           | /help/contactus | ForgotToApplyCodeText |

