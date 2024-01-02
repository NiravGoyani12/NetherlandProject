Feature: Unified Header - Recent searches

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4269
  @tms:UTR-13177
  Scenario Outline: Unified recent searches - recent searches are not shown with no search history
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.SearchField is active in 10 seconds
    When I click on Experience.Header.SearchFieldInputLabelText by js
    Then I see Experience.SearchSuggestionPanel.RecentSearchSuggestionsFlyout is not displayed in 2 seconds
      And the count of displayed elements Experience.SearchSuggestionPanel.RecentSearchLinks is equal to 0 in 2 seconds

    Examples:
      | locale | langCode | page          |
      | es     | default  | store-locator |
      | es     | default  | wlp           |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4269
  @tms:UTR-13179
  Scenario Outline: Unified recent searches - recent searches are displayed with search history
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "<searchQuery1>" in the field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.SearchFieldInputLabelText by js
    Then I see Experience.SearchSuggestionPanel.RecentSearchSuggestionsFlyout is displayed
      And I see Experience.SearchSuggestionPanel.RecentSearchHeader is displayed
      And I see Experience.SearchSuggestionPanel.RecentSearchLinks with text <searchQuery1> is displayed
      And the count of displayed elements Experience.SearchSuggestionPanel.RecentSearchLinks is equal to 1

    Examples:
      | locale | langCode | page | searchQuery1 |
      | es     | default  | wlp  | jeans        |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4269
  @tms:UTR-13180
  Scenario Outline: Unified recent searches - recent searches is only shown with empty search field
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
      And I type "<searchQuery1>" in the field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
      And I type "<searchQuery2>" in the field Experience.Header.SearchField
      And I see Experience.SearchSuggestionPanel.RecentSearchSuggestionsFlyout is not displayed in 5 seconds
      And the count of displayed elements Experience.SearchSuggestionPanel.RecentSearchLinks is equal to 0 in 5 seconds
    When I clear text field of element Experience.Header.SearchField
    Then I see Experience.SearchSuggestionPanel.RecentSearchSuggestionsFlyout is displayed
      And I see Experience.SearchSuggestionPanel.RecentSearchHeader is displayed
      And I see Experience.SearchSuggestionPanel.RecentSearchLinks with text jeans is displayed
      And the count of displayed elements Experience.SearchSuggestionPanel.RecentSearchLinks is equal to 1

    Examples:
      | locale | langCode | page | searchQuery1 | searchQuery2 |
      | es     | default  | wlp  | jeans        | J            |

    @P2 @EngTranslation
    Examples:
      | locale           | langCode | page          | searchQuery1 | searchQuery2 |
      | multiLangDefault | default  | store-locator | jeans        | J            |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4269
  @tms:UTR-13181
  Scenario Outline: Unified recent searches - Clicking on recent search link redirects to relevant PLP
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
      And I type "<searchQuery1>" in the field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.SearchFieldInputLabelText by js
      And I wait until Experience.SearchSuggestionPanel.RecentSearchSuggestionsFlyout is displayed
    When I click on Experience.SearchSuggestionPanel.RecentSearchLinks with text <searchQuery1>
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpHeader.CatalogHeading contains text "<searchQuery1>" in 10 seconds
      And URL should contain "<searchQuery1>"
      And I wait until page Experience.PlpProducts is loaded

    Examples:
      | locale | langCode | page          | searchQuery1 |
      | es     | default  | store-locator | jeans        |
      | es     | default  | wlp           | jeans        |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4269
  @tms:UTR-13182
  Scenario Outline: Unified recent searches - Maximum 5 recent searches are shown sorted from newest to oldest
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "<searchQuery1>" in the empty field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
      And I type "<searchQuery2>" in the empty field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.UnifiedSearchContainer
      And I type "<searchQuery3>" in the empty field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.UnifiedSearchContainer
      And I type "<searchQuery4>" in the empty field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.UnifiedSearchContainer
      And I type "<searchQuery5>" in the empty field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.UnifiedSearchContainer
      And I type "<searchQuery6>" in the empty field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.SearchFieldInputLabelText by js
      And I wait until Experience.SearchSuggestionPanel.SearchSuggestionsFlyout is displayed in 10 seconds
    Then I see Experience.SearchSuggestionPanel.RecentSearchLinks with text jeans is not displayed in 5 seconds
      And the count of displayed elements Experience.SearchSuggestionPanel.RecentSearchLinks is equal to 5
      And I see Experience.SearchSuggestionPanel.RecentSearchLinkByIndex with index 1 contains text "<searchQuery6>"
      And I see Experience.SearchSuggestionPanel.RecentSearchLinkByIndex with index 2 contains text "<searchQuery5>"
      And I see Experience.SearchSuggestionPanel.RecentSearchLinkByIndex with index 3 contains text "<searchQuery4>"
      And I see Experience.SearchSuggestionPanel.RecentSearchLinkByIndex with index 4 contains text "<searchQuery3>"
      And I see Experience.SearchSuggestionPanel.RecentSearchLinkByIndex with index 5 contains text "<searchQuery2>"

    Examples:
      | locale | langCode | page | searchQuery1 | searchQuery2 | searchQuery3 | searchQuery4 | searchQuery5 | searchQuery6 |
      | es     | default  | wlp  | jeans        | shirts       | boxer        | hombre       | ropa         | tshirts      |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4269
  @tms:UTR-13183
  Scenario Outline: Unified recent searches - Recent searches are case insensitive and don't show duplicate searches
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.UnifiedSearchContainer
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
    When I type "<searchQuery1>" in the field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
      And I type "<searchQuery2>" in the field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.SearchField is active in 10 seconds
      And I click on Experience.Header.SearchFieldInputLabelText by js
      And I wait until Experience.SearchSuggestionPanel.RecentSearchSuggestionsFlyout is displayed
    Then the count of displayed elements Experience.SearchSuggestionPanel.RecentSearchLinks is equal to 2
      And I see Experience.SearchSuggestionPanel.RecentSearchLinkByIndex with index 1 contains text "<searchQuery2>"
      And I see Experience.SearchSuggestionPanel.RecentSearchLinkByIndex with index 2 contains text "<searchQuery1>"
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "<searchQuery3>" in the field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.SearchFieldInputLabelText by js
      And I wait until Experience.SearchSuggestionPanel.RecentSearchSuggestionsFlyout is displayed
    Then the count of displayed elements Experience.SearchSuggestionPanel.RecentSearchLinks is equal to 2
      And I see Experience.SearchSuggestionPanel.RecentSearchLinkByIndex with index 1 contains text "<searchQuery1>"
      And I see Experience.SearchSuggestionPanel.RecentSearchLinkByIndex with index 2 contains text "<searchQuery2>"

    Examples:
      | locale | langCode | page          | searchQuery1 | searchQuery2 | searchQuery3 |
      | es     | default  | store-locator | jeans        | t-shirts     | JEANS        |
      | es     | default  | wlp           | jeans        | t-shirts     | JEANS        |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-4269
  # @tms:UTR-13186
  Scenario Outline: Unified recent searches - Recent searches are locale specific
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I am on locale <newLocale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "jeans" in the field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.SearchFieldInputLabelText by js
    Then I see Experience.SearchSuggestionPanel.RecentSearchSuggestionsFlyout is displayed
    Given I am on locale <locale> home page
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
    When I click on Experience.Header.SearchFieldInputLabelText by js
    Then I see Experience.SearchSuggestionPanel.RecentSearchSuggestionsFlyout is not displayed in 5 seconds
      And the count of displayed elements Experience.SearchSuggestionPanel.RecentSearchLinks is equal to 0 in 5 seconds

    Examples:
      | locale | newLocale        | langCode | page             |
      | ee     | es               | default  | store-locator    |
      | ee     | es               | default  | wlp              |
      | fr     | multiLangDefault | default  | mainRedirectPage |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience @P2 @ExcludeTH
  @feature:EESK-4269
  @tms:UTR-13184
  Scenario Outline: Unified recent searches - Recent searches show 40 max character searches
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "<searchTerm1>" in the field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon in 5 seconds
      And I wait until Experience.PlpNosearch.NoSearchResultMessage is displayed in 10 seconds
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
      And I type "<searchTerm2>" in the field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until Experience.PlpNosearch.NoSearchResultMessage is displayed in 10 seconds
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.SearchFieldInputLabelText by js
      And I wait until Experience.SearchSuggestionPanel.RecentSearchSuggestionsFlyout is displayed
    Then the count of displayed elements Experience.SearchSuggestionPanel.RecentSearchLinks is equal to 1
      And I see Experience.SearchSuggestionPanel.RecentSearchLinkByIndex with index 1 contains text "thisisexactlythirtyninecharacterssearch"

    Examples:
      | locale | langCode | page | searchTerm1                             | searchTerm2                               |
      | es     | default  | wlp  | thisisexactlythirtyninecharacterssearch | thisismorethanthirtyninecharacterssearch1 |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience @P2
  @tms:UTR-16681
  Scenario Outline: Unified Recent searches - Recent searches are shared across languages for multi language locales
    Given I am on locale <locale> home page with forced accepted cookies
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "jeans" in the field Experience.Header.UnifiedSearchField
      And I press key Enter on the keyboard
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I am on locale <locale> home page of langCode <langCode>
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
      And I open search content container
    Then I see Experience.SearchSuggestionPanel.RecentSearchSuggestionsFlyout is displayed
      And I see Experience.SearchSuggestionPanel.RecentSearchHeader is displayed
      And I see Experience.SearchSuggestionPanel.RecentSearchLinks with text jeans is displayed
      And the count of displayed elements Experience.SearchSuggestionPanel.RecentSearchLinks is equal to 1

    Examples:
      | locale           | langCode         | page             |
      | multiLangDefault | multiLangDefault | mainRedirectPage |