Feature: Unified Customer service FAQ page

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedFaq @UnifiedExperience @EER @HelpApp @P2 @ExcludeUat
  @tms:UTR-13120
  Scenario Outline: Unified FAQ page - User should be able to navigate to main FAQ category page from FAQ Question page using Back menu
    Given I am on locale <locale> of url /help/faqs of langCode <langCode> with accepted cookies
    When I see Experience.FaqsPage.CentreFAQFrame is displayed
      And I click on Experience.FaqsPage.CategoryCard with text "<category>"
      And I see Experience.FaqsPage.QuestionList is displayed in 2 seconds
      And I see Experience.FaqsPage.CategoryBackLinkOnQuestion is displayed
      And I click on Experience.FaqsPage.CategoryBackLinkOnQuestion
    Then I see Experience.FaqsPage.CentreFAQFrame is displayed in 2 seconds

    Examples:
      | locale  | langCode | category               |
      | default | default  | Account and Newsletter |

    Examples:
      | locale           | langCode         | category               |
      | multiLangDefault | multiLangDefault | Account and Newsletter |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedFaq @UnifiedExperience @EER @HelpApp @P2 @ExcludeUat
  @tms:UTR-13121
  Scenario Outline: Unified FAQ page - User should be able to access "contact us" via FAQ page
    Given I am on locale <locale> of url /help/faqs of langCode <langCode> with accepted cookies
    When I see Experience.FaqsPage.CentreFAQFrame is displayed
    Then I see Experience.FaqsPage.HelpSection is displayed
      And I scroll to and click on Experience.FaqsPage.ContactUsButton
      And URL should contain "contactus" in 2 seconds
    When I navigate back in the browser
    Then URL should contain "faqs" in 2 seconds

    Examples:
      | locale           | langCode         |
      | default          | default          |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedFaq @UnifiedExperience @EER @HelpApp @P2 @ExcludeUat
  @tms:UTR-13122 @Translation
  Scenario Outline: Unified FAQ page - User should be able to access left side bar for FAQ category
    Given I am on locale <locale> of url /help/faqs of langCode <langCode> with accepted cookies
    When I see Experience.FaqsPage.CentreFAQFrame is displayed
      And I see Experience.FaqsPage.SideBarCategoryList is displayed
      And I get translation from lokalise for "<category>" and store it with key #categoryText
    When I click on Experience.FaqsPage.SideBarCategoryMenuUsingText with text #categoryText
    Then I see Experience.FaqsPage.QuestionList is displayed in 2 seconds
      And URL should contain "#categoryText" in 2 seconds

    Examples:
      | locale           | langCode         | category |
      | default          | default          | Delivery |
      | multiLangDefault | multiLangDefault | Delivery |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedFaq @UnifiedExperience @EER @HelpApp @P2
  @tms:UTR-13123
  Scenario Outline: Unified FAQ page - User should be able to navigate to Centre frame FAQ categories when on left side bar FAQ category
    Given I am on locale <locale> of url /help/faqs of langCode <langCode> with accepted cookies
    When I see Experience.FaqsPage.CentreFAQFrame is displayed
      And I see Experience.FaqsPage.SideBarCategoryList is displayed
    When I store translated value of "<category>" with key #categoryText
      And I click on Experience.FaqsPage.SideBarCategoryMenu with text #categoryText
    Then URL should contain "#categoryText" in 2 seconds
    When I see Experience.FaqsPage.CategoryBackLinkOnQuestion is displayed in 4 minutes
      And I click on Experience.FaqsPage.CategoryBackLinkOnQuestion
    Then I see Experience.FaqsPage.CentreFAQFrame is displayed in 2 seconds
      And I click on Experience.FaqsPage.CategoryCard with text #categoryText
      And I see Experience.FaqsPage.QuestionList is displayed in 2 seconds

    Examples:
      | locale           | langCode         | category            |
      | default          | default          | product information |
      | multiLangDefault | multiLangDefault | product information |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedFaq @UnifiedExperience @EER @HelpApp @ExcludeUat
  @tms:UTR-13187 @ExcludeTH @Translation
  Scenario Outline: Unified FAQ page - User should be able to access answer content for a particular category - question
    Given I am on locale <locale> of url /help/faqs with accepted cookies
      And I see Experience.FaqsPage.CentreFAQFrame is displayed
      And I get translation for "<category>" and store it with key #categoryText
    When I click on Experience.FaqsPage.CategoryElement with text #categoryText
    Then I see Experience.FaqsPage.QuestionList is displayed in 2 seconds
    When I store translated value of "<categoryQuestion>" with key #categoryQuestionText
    And I see Experience.FaqsPage.CategoryQuestion with text #categoryQuestionText is displayed in 2 seconds
    When I click on Experience.FaqsPage.CategoryQuestion with text #categoryQuestionText
    When I store translated value of "<categoryQuestionAnswer>" with key #categoryQuestionAnswerText
    Then I see Experience.FaqsPage.CategoryAnswer with text #categoryQuestionAnswerText is displayed in 2 seconds

    @P1
    Examples:
      | locale | category | categoryQuestion | categoryQuestionAnswer                           |
      | sk     | Delivery | track my order   | you can trace your parcel with a tracking number |

    @ExcludeSIT
    Examples:
      | locale | category | categoryQuestion | categoryQuestionAnswer                           |
      | es     | Delivery | track my order   | you can trace your parcel with a tracking number |
      | it     | Delivery | track my order   | you can trace your parcel with a tracking number |


  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedFaq @UnifiedExperience @EER @HelpApp @P2 @Translation @ExcludeUat
  @tms:UTR-13188
  Scenario Outline: Unified FAQ page - User should be able to access contact us section on Questions page
    Given I am on locale <locale> of url /help/faqs with accepted cookies
      And I see Experience.FaqsPage.CentreFAQFrame is displayed
      And I get translation for "<category>" and store it with key #categoryText
    When I click on Experience.FaqsPage.CategoryElement with text #categoryText
    Then I see Experience.FaqsPage.QuestionList is displayed in 4 seconds
    When I store translated value of "<categoryQuestion>" with key #categoryQuestionText
      And I see Experience.FaqsPage.CategoryQuestion with text #categoryQuestionText is displayed in 2 seconds
    When I click on Experience.FaqsPage.CategoryQuestion with text #categoryQuestionText
    When I store translated value of "<categoryQuestionAnswer>" with key #categoryQuestionAnswerText
    Then I see Experience.FaqsPage.CategoryAnswer with text #categoryQuestionAnswerText is displayed in 2 seconds
    When I scroll to and click on Experience.FaqsPage.ContactUsButton
    Then URL should contain "contactus" in 2 seconds
    When I navigate back in the browser
      And I get translation for "<category>" and store it with key #CategoryText
    Then URL should contain "#CategoryText" in 5 seconds

    Examples:
      | locale | category | categoryQuestion | categoryQuestionAnswer                           |
      | es     | Delivery | track my order   | you can trace your parcel with a tracking number |


  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedFaq @UnifiedExperience @EER @HelpApp @P3 @ExcludeUat
  @tms:UTR-13301 @Translation @Lokalise
  Scenario Outline: Unified FAQ page - User should be able to access only 1 question at given time
    Given I am on locale <locale> of url /help/faqs with accepted cookies
      And I see Experience.FaqsPage.CentreFAQFrame is displayed
      And I get translation from lokalise for "<category>" and store it with key #categoryText
    When I click on Experience.FaqsPage.CategoryElement with text #categoryText
    Then I see Experience.FaqsPage.QuestionList is displayed in 2 seconds
    When I store translated value of "<categoryQuestion>" with key #categoryQuestionText
      And I see Experience.FaqsPage.CategoryQuestion with text #categoryQuestionText is displayed in 2 seconds
    When I click on Experience.FaqsPage.CategoryQuestion with text #categoryQuestionText
    When I store translated value of "<categoryQuestionAnswer>" with key #categoryQuestionAnswerText
    Then I see Experience.FaqsPage.CategoryAnswer with text #categoryQuestionAnswerText is displayed in 2 seconds
      And I store translated value of "<categoryQuestion1>" with key #categoryQuestion1Text
    When I click on Experience.FaqsPage.CategoryQuestion with text #categoryQuestion1Text
    Then the count of elements Experience.FaqsPage.CategoryQuestionExpanded is equal to 1

    Examples:
      | locale | category | categoryQuestion | categoryQuestionAnswer                           | categoryQuestion1     |
      | sk     | Delivery | track my order   | you can trace your parcel with a tracking number | What delivery options |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedFaq @UnifiedExperience @EER @HelpApp @tms:EER-3987 @P1 @Translation @ExcludeUat
  Scenario Outline: FAQ page - user can navigate between category and questions
    Given I am on locale <locale> of url /help/faqs with accepted cookies
    When I see Experience.FaqsPage.CategoryLink is displayed
    Then I see Experience.FaqsPage.NeedMoreHelpSection is displayed
      And the count of displayed elements Experience.FaqsPage.CategoryLink is greater than 5
    When I store translated value of "<category>" with key #categoryText
      And I store translated value of "<categoryQuestion>" with key #categoryQuestionText
      And I click on Experience.FaqsPage.CategoryLink with text #categoryText
    Then I see Experience.FaqsPage.CategoryQuestions with text #categoryQuestionText is displayed
      And I see Experience.FaqsPage.NeedMoreHelpSection is displayed

    Examples:
      | locale | category           | categoryQuestion      |
      | pl     | Orders and payment | Can I cancel my order |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedFaq @UnifiedExperience @EER @HelpApp @tms:UTR-17360 @GiftCard @ExcludeUat
  Scenario Outline: FAQ page - User can check their gift card balance
    Given I am on locale <locale> of url <url> of langCode <langCode> with accepted cookies
      And I get translation for "<category>" and store it with key #categoryText
      And I see Experience.FaqsPage.SideBarCategoryMenuUsingText with text #categoryText is displayed
    When I click on Experience.FaqsPage.SideBarCategoryMenuUsingText with text #categoryText
      And I wait until the current page is loaded
    Then I wait until Experience.FaqsPage.CheckGiftCardBalanceButton is clickable
    When I click on Experience.FaqsPage.CheckGiftCardBalanceButton
      And I wait until Experience.FaqsPage.GiftCardInputIframe is displayed
      And I switch to iframe Experience.FaqsPage.GiftCardInputIframe
      And I type "1234 5678 9012 3456" in the field Experience.FaqsPage.GiftCardCardNumberInput
      And I switch to default content
      And I wait until Experience.FaqsPage.GiftCardPinIframe is displayed
      And I switch to iframe Experience.FaqsPage.GiftCardPinIframe
      And I type "123" in the field Experience.FaqsPage.GiftCardPinInput
      And I switch to default content
    When I click on Experience.FaqsPage.GiftCardBalanceButton
      And I get translation from lokalise for "CUSubmitWithoutcaptchaError" and store it with key #submitWithoutcaptchaErrorText
    Then I see Experience.FaqsPage.GiftCardModalFormErrorMsg is displayed with text #submitWithoutcaptchaErrorText

    Examples:
      | locale | langCode | category                  | url   |
      | at      | default  | salesVoucherGiftCardsText | /help/faqs |
