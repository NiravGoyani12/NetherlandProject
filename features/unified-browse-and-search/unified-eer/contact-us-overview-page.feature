Feature: Contact Us Overview Page

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ContactUsOverviewPage @UnifiedExperience @EER @HelpApp @P1
  @feature:EER-12383 @tms:UTR-15048
  Scenario Outline: Contact us overview page - Check all modules are display when visit the page
    Given I am on locale <locale> of url <url> of langCode <langCode> with accepted cookies
    Then I see Experience.ContactUsOverviewPage.LiveChatBlock is displayed
      And I see Experience.ContactUsOverviewPage.TelephoneBlock is displayed
      And I see Experience.ContactUsOverviewPage.ContactUSBlock is displayed
      And I see Experience.ContactUsOverviewPage.FAQBlock is displayed

    Examples:
      | locale | langCode | url        |
      | nl      | default  | /contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ContactUsOverviewPage @UnifiedExperience @EER @HelpApp @P3
  @feature:EER-12383 @tms:UTR-15049
  Scenario Outline: Contact us overview page - Contact us form should display when click on link and hide when came back
    Given I am on locale <locale> of url <url> of langCode <langCode> with accepted cookies
    Then I see Experience.ContactUsOverviewPage.ContactUSBlock is displayed
      And I click on Experience.ContactUsOverviewPage.SendUSMessageLink
      And I see Experience.ContactUsPage.ContactUsForm is displayed
    When I click on Experience.ContactUsOverviewPage.ContactUSBlockLink
    Then I see Experience.ContactUsPage.ContactUsForm is not displayed

    Examples:
      | locale           | langCode         | url        |
      | multiLangDefault | multiLangDefault | /contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ContactUsOverviewPage @UnifiedExperience @EER @HelpApp @P3
  @feature:EER-12383 @tms:UTR-15050
  Scenario Outline: Contact us overview page - Check accord is open and close when click
    Given I am on locale <locale> of url <url> of langCode <langCode> with accepted cookies
      And I see Experience.ContactUsOverviewPage.FAQBlock is displayed
      And I scroll to the element Experience.ContactUsOverviewPage.FAQBlock
    When I click on Experience.ContactUsOverviewPage.OpenFAQAccord with index 1
    Then I see Experience.ContactUsOverviewPage.FAQAccordOpened with index 1 is displayed
    When I click on Experience.ContactUsOverviewPage.OpenFAQAccord with index 2
    Then I see Experience.ContactUsOverviewPage.FAQAccordOpened with index 2 is displayed
      And I see Experience.ContactUsOverviewPage.FAQAccordOpened with index 1 is not displayed

    Examples:
      | locale | langCode | url        |
      | uk      | default  | /contactus |

  #FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ContactUsOverviewPage @UnifiedExperience @EER @HelpApp @P3
  @feature:EER-12383 @tms:UTR-15051
  #removing from the DB0 because, we have to manually login to SalesForce to enable Live chat
  Scenario Outline: Contact us overview page - Open Chat window when click on the start chat button and check fields are displayed
    Given I am on locale <locale> of url <url> of langCode <langCode> with accepted cookies
      And I see Experience.ContactUsOverviewPage.LiveChatBlock is displayed
      And I wait until Experience.ContactUsOverviewPage.StartChatButton is clickable
      And I click on Experience.ContactUsOverviewPage.StartChatButton
    Then I see Experience.ContactUsOverviewPage.LiveChatSideBarWindow is displayed in 10 seconds
      And I see Experience.ContactUsOverviewPage.LiveChatFirstNameInput is displayed
      And I see Experience.ContactUsOverviewPage.LiveChatLastNameInput is displayed
      And I see Experience.ContactUsOverviewPage.LiveChatEmailInput is displayed
      And I see Experience.ContactUsOverviewPage.LiveChatSubjectInput is displayed
      And I see Experience.ContactUsOverviewPage.StartChattingButton is displayed

    Examples:
      | locale | langCode | url        |
      | de      | default  | /contactus |

  #FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ContactUsOverviewPage @UnifiedExperience @EER @HelpApp @P3
  @feature:EER-12383 @tms:UTR-15052
  #removing from the DB0 because, we have to manually login to SalesForce to enable Live chat
  Scenario Outline: Contact us overview page - Minimize chat window and re-open to close it
    Given I am on locale <locale> of url <url> of langCode <langCode> with accepted cookies
    Then I see Experience.ContactUsOverviewPage.LiveChatBlock is displayed
    When I wait until Experience.ContactUsOverviewPage.StartChatButton is clickable
      And I click on Experience.ContactUsOverviewPage.StartChatButton
      And I wait until Experience.ContactUsOverviewPage.LiveChatSideBarWindow is displayed
      And I click on Experience.ContactUsOverviewPage.LiveChatSideBarMinimizedButton
    Then I see Experience.ContactUsOverviewPage.LiveChatSideBarMinimizedDocked is displayed in 10 seconds
    When I click on Experience.ContactUsOverviewPage.LiveChatSideBarMinimizedDocked
    Then I see Experience.ContactUsOverviewPage.LiveChatSideBarClosedButton is displayed
    When I click on Experience.ContactUsOverviewPage.LiveChatSideBarClosedButton
    Then I see Experience.ContactUsOverviewPage.LiveChatSideBarWindow is not displayed

    Examples:
      | locale | langCode | url        |
      | it     | default  | /contactus |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ContactUsOverviewPage @UnifiedExperience @EER @HelpApp @P2 @GiftCard
  @tms:UTR-17269 @Translation @ExcludeTH
  Scenario Outline: Contact us overview page - User should be able to see Gift card in side bar with nesting links
    Given I am on locale <locale> of url <url> with accepted cookies
      And I get translation for "<category>" and store it with key #categoryText
      And I see Experience.FaqsPage.SideBarCategoryMenuUsingText with text #categoryText is displayed
    When I click on Experience.FaqsPage.SideBarCategoryMenuUsingText with text #categoryText
      And I wait until the current page is loaded
      And I get translation for "<faqLabel>" and store it with key #categoryText
    Then I see Experience.FaqsPage.FaqTitleWithText with text #categoryText is displayed

    Examples:
      | locale | category                  | faqLabel                   | url        |
      | uk     | salesVoucherGiftCardsText | salesVoucherGiftCardsLabel | /contactus |
