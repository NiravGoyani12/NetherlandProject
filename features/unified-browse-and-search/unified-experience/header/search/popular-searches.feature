Feature: Unifiied Header - Popular searches

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending
  @UnifiedHeader @UnifiedSearch @UnifiedExperience @EESK @P2
  @Homepage @ExcludeTH
  @tms:UTR-16842
  Scenario: Unified Popular searches - Desktop Popular searches are not displayed with no gender cookies
    Given I am on locale <locale> home page with forced accepted cookies
      And I ensure unified mega menu is interactable
    When I click on Experience.Header.UnifiedSearchContainer
    Then I see Experience.SearchSuggestionPanel.PopularSearchFlyout is not displayed in 2 seconds
      And the count of displayed elements Experience.SearchSuggestionPanel.PopularSearchImages is equal to 0 in 2 seconds
      And the count of displayed elements Experience.SearchSuggestionPanel.PopularSearchLinks is equal to 0 in 2 seconds

    Examples:
      | locale |
      | ee     |

  @FullRegression
  @Desktop @ExcludeTH
  @Chrome @FireFox @SafariPending
  @UnifiedHeader @UnifiedSearch @UnifiedExperience @EESK @P2
  @tms:UTR-16841
  Scenario Outline: Unified Popular searches - Desktop Popular searches are displayed with empty search history
    Given I am on locale <locale> glp page with forced accepted cookies
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
    When I click on Experience.Header.UnifiedSearchContainer
      And I clear text field of element Experience.Header.UnifiedSearchField
      And I click on Experience.Header.UnifiedSearchContainer
    Then I see Experience.SearchSuggestionPanel.PopularSearchFlyout is displayed
      And I see Experience.SearchSuggestionPanel.PopularSearchHeader is displayed
      And the count of elements Experience.SearchSuggestionPanel.PopularSearchImages is equal to 6
      And the count of elements Experience.SearchSuggestionPanel.PopularSearchLinks is equal to 6
      And I see Experience.SearchSuggestionPanel.RecentSearchSuggestionsFlyout is not displayed in 2 seconds

    Examples:
      | locale | page                  |
      | ee     | no-search-result-page |

  @FullRegression
  @Desktop @ExcludeTH
  @Chrome
  @UnifiedHeader @UnifiedSearch @UnifiedExperience @EESK @P2
  @tms:UTR-16843
  Scenario Outline: Unified Popular searches -Desktop Popular searches are displayed with search history
    Given I am on locale <locale> glp page with forced accepted cookies
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.UnifiedSearchContainer
      And I clear text field of element Experience.Header.UnifiedSearchField
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "jeans" in the field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.UnifiedSearchContainer
      And I clear text field of element Experience.Header.UnifiedSearchField
    Then I see Experience.SearchSuggestionPanel.RecentSearchSuggestionsFlyout is displayed
      And I see Experience.SearchSuggestionPanel.PopularSearchFlyout is displayed
      And I see Experience.SearchSuggestionPanel.PopularSearchHeader is displayed
      And the count of elements Experience.SearchSuggestionPanel.PopularSearchImages is equal to 6
      And the count of elements Experience.SearchSuggestionPanel.PopularSearchLinks is equal to 6

    Examples:
      | locale | page                  |
      | ee     | no-search-result-page |

  @FullRegression
  @Desktop @ExcludeTH
  @Chrome
  @UnifiedHeader @UnifiedSearch @UnifiedExperience @EESK @P2
  @tms:UTR-16845
  Scenario Outline: Unified Popular searches - Desktop Popular searches is only shown with empty search field
    Given I am on locale <locale> glp page with forced accepted cookies
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.UnifiedSearchContainer
      And I clear text field of element Experience.Header.UnifiedSearchField
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "J" in the field Experience.Header.UnifiedSearchField
    Then I see Experience.SearchSuggestionPanel.PopularSearchFlyout is not displayed in 2 seconds
      And the count of elements Experience.SearchSuggestionPanel.PopularSearchImages is equal to 0 in 2 seconds
      And the count of elements Experience.SearchSuggestionPanel.PopularSearchLinks is equal to 0 in 2 seconds
    When I press key Backspace on the keyboard
    Then I see Experience.SearchSuggestionPanel.PopularSearchFlyout is displayed
      And I see Experience.SearchSuggestionPanel.PopularSearchHeader is displayed
      And the count of elements Experience.SearchSuggestionPanel.PopularSearchImages is equal to 6
      And the count of elements Experience.SearchSuggestionPanel.PopularSearchLinks is equal to 6

    Examples:
      | locale | page                  |
      | ee     | no-search-result-page |

  @FullRegression
  @Desktop @ExcludeTH
  @Chrome
  @UnifiedHeader @UnifiedSearch @UnifiedExperience @EESK @P2
  @tms:UTR-16848
  Scenario Outline: Unified Popular searches - Desktop recent searches are shown above Popular searches
    Given I am on locale <locale> glp page with forced accepted cookies
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
    When I click on Experience.Header.UnifiedSearchContainer
      And I clear text field of element Experience.Header.UnifiedSearchField
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "jeans" in the field Experience.Header.UnifiedSearchField
      And I press key Enter on the keyboard
      And I wait until page Experience.PlpProducts is loaded
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.UnifiedSearchContainer
      And I clear text field of element Experience.Header.UnifiedSearchField
    Then the count of elements Experience.SearchSuggestionPanel.SearchContentContainerElements is equal to 2
      And I see Experience.SearchSuggestionPanel.SearchContentContainerElements with index 1 text "recent" is displayed
      And I see Experience.SearchSuggestionPanel.SearchContentContainerElements with index 2 text "popular" is displayed
  
    Examples:
      | locale | page                  |
      | ee     | no-search-result-page |

  @FullRegression
  @Desktop @ExcludeTH
  @Chrome @FireFox @SafariPending
  @UnifiedHeader @UnifiedSearch @UnifiedExperience @UnifiedPLP @EESK @P2
  @tms:UTR-16847
  Scenario Outline: Unified Popular searches - Desktop Clicking on popular search link redirects to relevant PLP
    Given I am on locale <locale> glp page with forced accepted cookies
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
    When I click on Experience.Header.UnifiedSearchContainer
      And I clear text field of element Experience.Header.UnifiedSearchField
      And I wait until Experience.SearchSuggestionPanel.PopularSearchFlyout is displayed in 10 seconds
      And I store the value of Experience.SearchSuggestionPanel.PopularSearchLinks with index <linkIndex> with key #popularSearchName
      And I scroll to and click on Experience.SearchSuggestionPanel.PopularSearchLinks with index <linkIndex>
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpHeader.PageHeader contains text "#popularSearchName" in 10 seconds
      And URL should contain "#popularSearchName"
      And the count of elements Experience.PlpProducts.ListingItems is greater than 0

    Examples:
      | locale | linkIndex | page                  |
      | ee     | 1         | no-search-result-page |
      | uk     | 2         | no-search-result-page |

  @FullRegression
  @Desktop @ExcludeTH
  @Chrome @FireFox @SafariPending
  @UnifiedHeader @UnifiedSearch @UnifiedExperience @UnifiedPLP @EESK @P2
  @tms:UTR-16849
  Scenario Outline: Unified Popular searches - Desktop popular searches appear in split view for unified kids plp
    Given I am on locale <locale> kids glp page with forced accepted cookies
      And I ensure unified mega menu is interactable
    When I click on Experience.Header.UnifiedSearchContainer
      And I wait until Experience.SearchSuggestionPanel.PopularSearchFlyout is displayed in 10 seconds
      And I see Experience.SearchSuggestionPanel.PopularSearchHeaderKids with text <PopularSearchTerm1> is displayed
      And I see Experience.SearchSuggestionPanel.PopularSearchHeaderKids with text <PopularSearchTerm2> is displayed
      And the count of elements Experience.SearchSuggestionPanel.PopularSearchImages is equal to 6
      And the count of elements Experience.SearchSuggestionPanel.PopularSearchKidsImagesGirls is equal to 3
      And the count of elements Experience.SearchSuggestionPanel.PopularSearchKidsImagesBoys is equal to 3
      And the count of elements Experience.SearchSuggestionPanel.PopularSearchLinks is equal to 6
      And the count of elements Experience.SearchSuggestionPanel.PopularSearchLinksKidsGirls is equal to 3
      And the count of elements Experience.SearchSuggestionPanel.PopularSearchLinksKidsBoys is equal to 3

    Examples:
      | locale | PopularSearchTerm1   | PopularSearchTerm2  |
      | ee     | girls popular search | boys popular search |