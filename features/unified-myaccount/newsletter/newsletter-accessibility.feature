Feature: Newsletter - Accessibility

  # TODO: Refactor for unified newsletter
  # @FullRegression
  @Desktop @Mobile
  @Chrome
  @Accessibility @Newsletter @PPL @P2
  @tms:UTR-5306 @Translation
  Scenario Outline: Check accessibility violations on newsletter from footer
    Given There is 1 account
      And I am on locale <locale> home page of langCode <langCode> with accepted cookies
    When I navigate to page search-plp
      And I scroll to and click on Footer.NewsletterEmailInput
    Then I scan the component Footer.NewsletterContainer for accessibility violations
    When I type "user1#email" in the field Footer.NewsletterEmailInput
      And I set the checkbox Footer.NewsLetterTCCheckbox status to true
      And I scroll to and click on Footer.NewsletterSignUpButton
      And I get translation for "NewsletterSuccessFooter" and store it with key #<NewsletterSuccessFooter>
      And I see Footer.NewsLetterSubscribedSuccessText with text #<NewsletterSuccessFooter> is displayed in 10 seconds
    Then I scan the component Footer.NewsLetterSuccessContainer for accessibility violations

    Examples:
      | locale  | langCode |
      | default | default  |

  # @FullRegression
  @Desktop @Mobile
  @Chrome @Translation
  @Accessibility @Newsletter @PPL @P2
  @tms:UTR-5305
  Scenario Outline: Check accessibility violations on newsletter from search
    Given There is 1 account
      And I am on locale <locale> search page of langCode <langCode> with search term "<search>" with accepted cookies
    When I type "user1#email" in the field NewsletterSearchPage.EmailField
    Then I scan the component NewsletterSearchPage.NewsletterFromSearchContainer for accessibility violations
    When I set the checkbox <newletterCategory> status to true
      And I set the checkbox NewsletterSearchPage.TermsCheckbox status to true
      And I click on NewsletterSearchPage.SignUpButton
      And I get translation for "NewsletterSuccess" and store it with key #<NewsletterSuccess>
      And I see NewsletterPopup.SuccessMessageContainer with text #<NewsletterSuccess> is displayed in 10 seconds
    Then I scan the component NewsletterSearchPage.NewsletterFromSearchContainer for accessibility violations

    Examples:
      | locale     | langCode | search     | newletterCategory                |
      | spaDefault | default  | newsletter | NewsletterSearchPage.MenCheckbox |

  # TODO: Implement once PLP is unified
  # @FullRegression
  @Desktop @Mobile
  @Chrome @Translation
  @Accessibility @Newsletter @PPL @P2
  @tms:UTR-5307
  Scenario Outline: Check accessibility violations on newsletter from PLP pop up
    Given There is 1 account
      And I am on locale <locale> home page of langCode <langCode>
      And I delete all cookies and refresh
    When I click on Experience.CookieNotice.IAgreeButton
      # And in mega menu I click 1st main menu => 3rd category menu => 3rd subdivision menu
      And I see NewsletterPopup.MainScreen is displayed in 10 seconds
    Then I scan the component NewsletterPopup.MainScreen for accessibility violations
    When I type "pvh.nl.automation@outlook.com" in the field NewsletterPopup.EmailField
      And I set the checkbox NewsletterPopup.TermsCheckbox status to true
      And I click on NewsletterPopup.SignUpButton
      And I get translation for "NewsletterSuccess" and store it with key #<NewsletterSuccess>
      And I see NewsletterPopup.SuccessMessageContainer with text #<NewsletterSuccess> is displayed in 10 seconds
    Then I scan the component NewsletterPopup.MainScreen for accessibility violations
      And I verify newsletter confirmation email with subject as <emailSubject> from outlook

    Examples:
      | locale  | langCode | emailSubject                             |
      | default | default  | Thanks for signing up for our newsletter |