Feature: Newsletter - Search

  # TODO: Refactor once PLP is unified
  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation
  @Newsletter @PPL @P2
  @tms:UTR-934
  Scenario Outline: I can sign up newsletter
    Given There is 1 account
      And I am on locale <locale> search page of langCode <langCode> with search term "<search>" with accepted cookies
    When I type "user1#email" in the field NewsletterSearchPage.EmailField
      And I set the checkbox <newletterCategory> status to true
      And I set the checkbox NewsletterSearchPage.TermsCheckbox status to true
      And I click on NewsletterSearchPage.SignUpButton
      And I get translation for "NewsletterSuccess" and store it with key #<NewsletterSuccess>
    Then I see NewsletterPopup.SuccessMessageContainer with text #<NewsletterSuccess> is displayed in 10 seconds

    Examples:
      | locale     | langCode | search      | newletterCategory                  |
      | spaDefault | default  | newsletter  | NewsletterSearchPage.MenCheckbox   |
      | default    | default  | newsLetter  | NewsletterSearchPage.WomenCheckbox |
      | spaDefault | default  | nEWSLETTER  | NewsletterSearchPage.KidsCheckbox  |
      | default    | default  | nieuwsbrief | NewsletterSearchPage.MenCheckbox   |
      | spaDefault | default  | newslettern | NewsletterSearchPage.WomenCheckbox |
      | default    | default  | newsletters | NewsletterSearchPage.KidsCheckbox  |
      | spaDefault | default  | Nieuwsbrief | NewsletterSearchPage.MenCheckbox   |
      | default    | default  | Newslettern | NewsletterSearchPage.WomenCheckbox |
      | spaDefault | default  | NEWSLETTERS | NewsletterSearchPage.KidsCheckbox  |

  # @FullRegression
  @RCTest
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation
  @Newsletter @PPL @P2
  @tms:UTR-932
  Scenario: I can not sign up for newsletter multi times
    Given There is 1 account
    Given I am on locale uk search page with search term "newsletter" with accepted cookies
      And I get translation for "NewsletterSuccess" and store it with key #<NewsletterSuccess>
      And I get translation for "NewsletterSuccessText" and store it with key #<NewsletterSuccessText>
    When I type "user1#email" in the field NewsletterSearchPage.EmailField
      And I set the checkbox NewsletterSearchPage.TermsCheckbox status to true
      And I click on NewsletterSearchPage.SignUpButton
      And I wait until NewsletterSearchPage.SuccessMessageContainer with text #<NewsletterSuccess> is displayed in 10 seconds
      And I refresh page
      And I wait for 1 second
    Then I see NewsletterSearchPage.AlreadySubscribedSuccessMessage with text #<NewsletterSuccessText> is displayed in 10 seconds
      And I see NewsletterSearchPage.SignUpButton is not displayed

  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Newsletter @PPL @P2 @Translation
  @tms:UTR-933
  Scenario Outline: I see correct link for terms and conditions
    Given There is 1 account
    Given I am on locale <locale> search page of langCode <langCode> with search term "newsletter" with accepted cookies
      And I get translation for "HilfigerClubTermsAndConditionsUrl" and store it with key #<HilfigerClubTermsAndConditionsUrl>
    When I type "user1#email" in the field NewsletterSearchPage.EmailField
    Then I see NewsletterSearchPage.TermsAndConditionsLink with href #<HilfigerClubTermsAndConditionsUrl> is displayed

    Examples:
      | locale           | langCode         |
      | default          | default          |