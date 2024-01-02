
Feature: Unified Country swtich popup

  Within our PVH network, or device lab, we cannot override the locale now, because the Akamai copied from PROD-LIVE to UAT-PROD

  Background: I enable Country Switch Popup
    Given I store the value "true" with key #EnableCountrySwitchPop

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome @FireFox @UnifiedExperience
  @CountrySwitchPopup @TEX  @UnifiedTEX
  @feature:TEX-16115
  @tms:UTR-18697
  Scenario Outline: Unified Country Switch PopUp - I should see country switch popup in home page, glp, pdp and plp
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I clear session storage item CSPopupSeen and stay on 1st browser tab
      And I delete all cookies and refresh page
    When I click on Experience.CookieNotice.IAgreeButton
      And I wait for 5 seconds
    Then I see Experience.CountrySwitchPopup.MainBlock is displayed
      And I see Experience.CountrySwitchPopup.Title is displayed
      And I see Experience.CountrySwitchPopup.Link is displayed

    @P1
    Examples:
      | locale | langCode | page      |
      | uk     | default  | home-page |

    @P2
    Examples:
      | locale | langCode | page |
      | ch     | FR       | plp  |
      | be     | default  | glp  |
      | ee     | default  | pdp  |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome @UnifiedExperience @Translation @lokalise
  @CountrySwitchPopup @TEX @UnifiedTEX
  @feature:TEX-16115
  @tms:UTR-18698
  Scenario Outline: Unified Country Switch PopUp - Popup is displayed with correct translation when visiting foreign locale
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I clear session storage item CSPopupSeen and stay on 1st browser tab
      And I delete all cookies and refresh page
      And I wait until the current page is loaded
      And I click on Experience.CookieNotice.IAgreeButton
      And I get translation from lokalise for "CountryPopUpSuggestionTitleDE" and store it with key #CountryPopUpSuggestionTitleText
      And I get translation from lokalise for "CountryNameDE" and store it with key #CountryName
      And I add text "#CountryName" to placeholder in text "#CountryPopUpSuggestionTitleText" and store it with key #CountryPopUpSuggestionTitleTextFinal
    Then I see Experience.CountrySwitchPopup.MainBlock is displayed
      And I see Experience.CountrySwitchPopup.Title contains text "#CountryPopUpSuggestionTitleTextFinal"
      And I see the current page is <page>
    When I click on Experience.CountrySwitchPopup.Link
    Then I see the current page is <RedirectedPage>
      And URL should contain "<mockedLocale>"

    @P2
    Examples:
      | locale | langCode | mockedLocale | page      | RedirectedPage |
      | uk     | default  | de           | home-page | home-page      |

    @P3
    Examples:
      | locale | langCode | mockedLocale | page | RedirectedPage |
      | ch     | FR       | de           | glp  | glp            |
      | ee     | default  | de           | PLP  | PLP            |
      | uk     | default  | de           | pdp  | home-page      |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome @UnifiedExperience
  @CountrySwitchPopup @TEX @UnifedTEX @P2
  @feature:TEX-16115
  @tms:UTR-18699
  Scenario Outline: Unified Country Switch PopUp - Verify that Popup is not shown and does not reappear after clicking close button
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I delete all cookies and refresh page
      And I click on Experience.CookieNotice.IAgreeButton
      And I wait until Experience.CountrySwitchPopup.MainBlock is displayed
      And I click on Experience.CountrySwitchPopup.CloseButton
      And I wait until Experience.CountrySwitchPopup.MainBlock is not displayed in 2 seconds
      And I refresh page
    Then I see Experience.CountrySwitchPopup.MainBlock is not displayed in 5 seconds

    Examples:
      | locale | langCode |
      | uk     | default  |
      | ch     | FR       |
