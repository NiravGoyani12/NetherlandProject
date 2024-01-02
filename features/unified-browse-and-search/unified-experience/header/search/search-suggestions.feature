Feature: Unified Header - Search suggestion

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-3835
  @tms:UTR-11993
  Scenario Outline: Unified Search suggestions Desktop - Verify search suggestions displayed after typing 3 character valid search query
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "<searchQuery>" in the field Experience.Header.UnifiedSearchField
      And I wait for 1 network request named suggestions of type fetch to be processed
      And I wait until Experience.SearchSuggestionPanel.SearchSuggestionsFlyout is displayed
    Then the count of displayed elements Experience.SearchSuggestionPanel.SearchSuggestionLinks is greater than 0
      And I see Experience.SearchSuggestionPanel.SearchSuggestionResultsButton is displayed

    @ExcludeCK
    Examples:
      | locale | langCode | page          | searchQuery |
      | es     | default  | store-locator | pij         |
      | es     | default  | wlp           | pij         |
      | es     | default  | shopping-bag  | pij         |
      | es     | default  | pdp           | pij         |

    @ExcludeTH
    Examples:
      | locale | langCode | page          | searchQuery |
      | es     | default  | store-locator | jea         |
      | es     | default  | wlp           | jea         |
      | es     | default  | shopping-bag  | jea         |
      | es     | default  | pdp           | jea         |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending
  @Header @UnifiedSearch @UnifiedExperience @EESK @PLP @UnifiedExperience @P2
  @feature:EESK-3835
  @tms:UTR-11992
  @ExcludeUat
  Scenario Outline: Unified Search suggestions - Clicking on search suggestion link redirects to unified search PLP
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "<searchQuery>" in the field Experience.Header.UnifiedSearchField
      And I wait for 1 network request named suggestions of type fetch to be processed
      And I wait until Experience.SearchSuggestionPanel.SearchSuggestionsFlyout is displayed in 10 seconds
      And I store the value of Experience.SearchSuggestionPanel.SearchSuggestionHighlightText with index 1 with key #suggestionName
      And I click on Experience.SearchSuggestionPanel.SearchSuggestionLinks with index 1 until Experience.PlpProducts.ProductListContainer is displayed
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpHeader.CatalogHeading contains text "#suggestionName"

    @ExcludeCK
    Examples:
      | locale | langCode | page          | searchQuery |
      | es     | default  | store-locator | hombre      |
      | es     | default  | wlp           | hombre      |
      | es     | default  | shopping-bag  | hombre      |
      | es     | default  | pdp           | hombre      |

    @ExcludeTH
    Examples:
      | locale | langCode | page          | searchQuery |
      | es     | default  | store-locator | jeans       |
      | es     | default  | wlp           | jeans       |
      | es     | default  | shopping-bag  | jeans       |
      | es     | default  | pdp           | jeans       |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-3835
  @tms:UTR-11994
  Scenario Outline: Unified Search suggestions - Verify search suggestions is also displayed for invalid search query
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "<searchQuery>" in the field Experience.Header.UnifiedSearchField
      And I wait until Experience.SearchSuggestionPanel.SearchSuggestionsFlyout is displayed in 10 seconds

    Examples:
      | locale | langCode | page          | searchQuery |
      | es     | default  | store-locator | dnjldjnv    |
      | es     | default  | wlp           | dnjldjnv    |
      | es     | default  | shopping-bag  | dnjldjnv    |
      | es     | default  | pdp           | dnjldjnv    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-3835
  @tms:UTR-11995
  Scenario Outline: Unified Search suggestions - Verify search suggestions not displayed after clicking on search field
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.SearchField is active in 10 seconds
    When I click on Experience.Header.SearchFieldContainer
    Then I see Experience.SearchSuggestionPanel.SearchOverlayActive is displayed
      And I see Experience.SearchSuggestionPanel.SearchSuggestionsFlyout is not displayed

    Examples:
      | locale | langCode | page          |
      | es     | default  | store-locator |
      | es     | default  | wlp           |
      | es     | default  | shopping-bag  |
      | es     | default  | pdp           |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-3835
  @tms:UTR-11996
  Scenario Outline: Unified Search suggestions - Search suggestions links have product count
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.SearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "<searchQuery>" in the field Experience.Header.UnifiedSearchField
      And I wait for 1 network request named suggestions of type fetch to be processed
      And I wait until Experience.SearchSuggestionPanel.SearchSuggestionsFlyout is displayed in 10 seconds
    Then I see the count of Experience.SearchSuggestionPanel.SearchSuggestionProductCount is the same as the count of Experience.SearchSuggestionPanel.SearchSuggestionLinks

    @ExcludeCK
    Examples:
      | locale | langCode | page          | searchQuery |
      | es     | default  | store-locator | hombre      |
      | es     | default  | wlp           | hombre      |
      | es     | default  | shopping-bag  | hombre      |
      | es     | default  | pdp           | hombre      |

    @ExcludeTH
    Examples:
      | locale | langCode | page          | searchQuery |
      | es     | default  | store-locator | jeans       |
      | es     | default  | wlp           | jeans       |
      | es     | default  | shopping-bag  | jeans       |
      | es     | default  | pdp           | jeans       |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @Header @UnifiedSearch @UnifiedExperience @PLP @EESK @UnifiedExperience @P2
  @feature:EESK-3835
  @tms:UTR-11997
  @ExcludeUat
  Scenario Outline: Unified Search suggestions - Suggestion result button redirects to search query PLP
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "<searchQuery>" in the field Experience.Header.UnifiedSearchField
      And I wait for 1 network request named suggestions of type fetch to be processed
      And I wait until Experience.SearchSuggestionPanel.SearchSuggestionsFlyout is displayed in 10 seconds
      And I click on Experience.SearchSuggestionPanel.SearchSuggestionResultsButton until Experience.PlpProducts.ProductListContainer is displayed in 5 seconds
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpHeader.CatalogHeading contains text "<searchQuery>"
      And I see Experience.PlpHeader.CatalogHeading does not contain text "<pageHeader>"

    @ExcludeCK
    Examples:
      | locale | langCode | page          | searchQuery | pageHeader |
      | es     | default  | store-locator | homb        | hombre     |
      | es     | default  | wlp           | homb        | hombre     |
      | es     | default  | shopping-bag  | homb        | hombre     |
      | es     | default  | pdp           | homb        | hombre     |

    @ExcludeTH
    Examples:
      | locale | langCode | page          | searchQuery | pageHeader |
      | es     | default  | store-locator | jean        | jeans      |
      | es     | default  | wlp           | jean        | jeans      |
      | es     | default  | shopping-bag  | jean        | jeans      |
      | es     | default  | pdp           | jean        | jeans      |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-3835
  @tms:UTR-13176
  Scenario Outline: Unified Search suggestions Desktop - Verify search suggestions of past search are pushed out
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "<searchQuery1>" in the field Experience.Header.UnifiedSearchField
      And I wait for 1 network request named suggestions of type fetch to be processed
      And I wait until Experience.SearchSuggestionPanel.SearchSuggestionsFlyout is displayed
    Then the count of displayed elements Experience.SearchSuggestionPanel.SearchSuggestionLinks is greater than 0
      And I see Experience.SearchSuggestionPanel.SearchSuggestionResultsButton is displayed
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
    When I clear text field of element Experience.Header.UnifiedSearchField
      And I type "<searchQuery2>" in the field Experience.Header.SearchField
      And I wait until Experience.SearchSuggestionPanel.SearchSuggestionsFlyout is displayed
    Then the count of displayed elements Experience.SearchSuggestionPanel.SearchSuggestionLinks is greater than 0
      And in unified header I see every search suggestion matches search query "<searchQuery2>"
      And I see Experience.SearchSuggestionPanel.SearchSuggestionResultsButton contains text "<searchQuery2>"

    @ExcludeCK
    Examples:
      | locale | langCode | page          | searchQuery1 | searchQuery2 |
      | es     | default  | store-locator | homb         | hombre       |
      | es     | default  | wlp           | homb         | hombre       |
      | es     | default  | shopping-bag  | homb         | hombre       |
      | es     | default  | pdp           | homb         | hombre       |

    @ExcludeTH
    Examples:
      | locale | langCode | page          | searchQuery1 | searchQuery2 |
      | es     | default  | store-locator | jean         | jeans        |
      | es     | default  | wlp           | jean         | jeans        |
      | es     | default  | shopping-bag  | jean         | jeans        |
      | es     | default  | pdp           | jean         | jeans        |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience @P2
  @feature:EESK-3835
  @tms:UTR-13178
  Scenario Outline: Unified Search suggestions - Each search suggestion matches the search query
    Given I am on locale <locale> home page with forced accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "<searchQuery>" in the field Experience.Header.UnifiedSearchField
      And I wait until Experience.SearchSuggestionPanel.SearchSuggestionsFlyout is displayed in 10 seconds
    Then in unified header I see every search suggestion matches search query "<searchQuery>"
      And I see Experience.SearchSuggestionPanel.SearchSuggestionResultsButton contains text "<searchQuery>"

    @ExcludeCK
    Examples:
      | locale | langCode | page          | searchQuery |
      | es     | default  | store-locator | hombre      |
      | es     | default  | wlp           | hombre      |
      | es     | default  | shopping-bag  | hombre      |
      | es     | default  | pdp           | hombre      |

    @ExcludeTH
    Examples:
      | locale | langCode | page          | searchQuery |
      | es     | default  | store-locator | jeans       |
      | es     | default  | wlp           | jeans       |
      | es     | default  | shopping-bag  | jeans       |
      | es     | default  | pdp           | jeans       |

  @FullRegression
  @Mobile
  @Chrome @SafariPending
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience
  @RCTest @feature:EESK-56
  @tms:UTR-16682
  Scenario Outline: Unified Search suggestions Mobile - Verify search suggestions displayed after typing 3 character valid search query
    Given I am on locale <locale> home page with forced accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "Jea" in the field Experience.Header.UnifiedSearchField
      And I wait for 5 seconds
    Then I see Experience.SearchSuggestionPanel.SearchSuggestionsFlyout is displayed in 10 seconds
      And the count of elements Experience.SearchSuggestionPanel.SearchSuggestionLinks is greater than 0
      And I see Experience.SearchSuggestionPanel.SearchSuggestionResultsButton is displayed

    Examples:
      | locale | page             |
      | fr     | mainRedirectPage |

  # @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience
  @feature:EESK-243
  # @tms:UTR-16883
  @issue:EESK-5285
  Scenario Outline: Unified Search suggestions - Hovering over mini-shopping bag should deactivate search flyout
    Given I am on locale <locale> glp page with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> shopping bag page with 1 unit of any product
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I wait until Experience.Header.UnifiedSearchField is displayed in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
      And I clear text field of element Experience.Header.UnifiedSearchField
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "Jeans" in the field Experience.Header.UnifiedSearchField
      And I wait for 5 seconds
      And I wait until Experience.SearchSuggestionPanel.SearchSuggestionsFlyout with index 2 is displayed in 10 seconds
      And I hover over Experience.Header.ShoppingBagButton
    Then I see Experience.MiniShoppingBag.MainPanel is in viewport
      And I see Experience.SearchSuggestionPanel.SearchSuggestionsFlyout is not displayed in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
    Then I see Experience.SearchSuggestionPanel.SearchSuggestionsFlyout with index 2 is displayed
    When I hover over Experience.Header.MegaMenuSecondLevelItems
    Then I see Experience.Header.MegaMenuOpenSecondLevel is in viewport
      And I see Experience.SearchSuggestionPanel.SearchSuggestionsFlyout is not displayed in 10 seconds

    Examples:
      | locale | page                  | userType |
      | ee     | no-search-result-page | guest    |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Header @UnifiedSearch @UnifiedExperience @TEX @UnifiedTEX @UnifiedExperience @P2
  @feature:TEX-15356
  @tms:UTR-16846
  Scenario Outline: Unified Search suggestions - Verify that search suggestion panel contains product suggestion with product image, title, price and discount price
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "<searchQuery>" in the field Experience.Header.UnifiedSearchField
      And I wait for 1 network request named suggestions of type fetch to be processed
      And I wait until Experience.SearchSuggestionPanel.SearchSuggestionsFlyout is displayed
    Then the count of displayed elements Experience.SearchSuggestionPanel.SearchSuggestionLinks is greater than 0
      And the count of displayed elements Experience.SearchSuggestionPanel.SearchSuggestionsProductTiles is equal to 4
    When in unified search suggestion I extract style part number of 1st suggestion that saved as #styleColourPartNumber
    Then in unified search suggestion I see the content of the 1st suggestion is matched to product style #styleColourPartNumber
      And I see the attribute loading of element Experience.SearchSuggestionPanel.ItemImage with index 1 containing "lazy"
    When in unified search suggestion I extract style part number of 2nd suggestion that saved as #styleColourPartNumber
    Then in unified search suggestion I see the content of the 2nd suggestion is matched to product style #styleColourPartNumber
      And I see the attribute loading of element Experience.SearchSuggestionPanel.ItemImage with index 2 containing "lazy"
    When in unified search suggestion I extract style part number of 3rd suggestion that saved as #styleColourPartNumber
    Then in unified search suggestion I see the content of the 3rd suggestion is matched to product style #styleColourPartNumber
      And I see the attribute loading of element Experience.SearchSuggestionPanel.ItemImage with index 3 containing "lazy"
    When in unified search suggestion I extract style part number of 4th suggestion that saved as #styleColourPartNumber
    Then in unified search suggestion I see the content of the 4th suggestion is matched to product style #styleColourPartNumber
      And I see the attribute loading of element Experience.SearchSuggestionPanel.ItemImage with index 4 containing "lazy"
      And I see Experience.SearchSuggestionPanel.SearchSuggestionResultsButton is displayed

    @ExcludeCK
    Examples:
      | locale | langCode | searchQuery |
      | uk     | default  | jea         |

    @ExcludeTH
    Examples:
      | locale | langCode | searchQuery |
      | uk     | default  | jea         |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @UnifiedPLP @EESK @UnifiedExperience @P2
  @feature:EESK-4464
  @tms:UTR-15327
  Scenario Outline: Unified Search suggestions - Verify internal search results should not conflict with the navigation on navigatong from plp to wlp
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
      And I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And in unified PLP I scroll down to the <itemIndex> listing item
      And I click on Experience.PlpProducts.WishListIcon with index <itemIndex>
    Then in header I wait until unified wishlist is active in 10 seconds
      And the count of elements Experience.PlpProducts.ActiveWishListIcon is equal to 1 in 5 seconds
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "<searchTerm>" in the field Experience.Header.UnifiedSearchField
    Then I see Experience.SearchSuggestionPanel.SearchSuggestionsFlyout is displayed
      And I see Experience.Header.MegaMenuSecondLevelItems is not displayed

    @ExcludeCK
    Examples:
      | locale | searchTerm | categoryId              | itemIndex | page |
      | it     | jean       | th_women_clothing_jeans | 15        | wlp  |

    @ExcludeTH
    Examples:
      | locale | itemIndex | categoryId           | itemIndex | page | searchTerm |
      | ee     | 35        | MEN_CLOTHES_T-SHIRTS | 15        | wlp  | jean       |

  @FullRegression
  @Desktop
  @Chrome @SafariPending
  @Header @UnifiedSearch @UnifiedExperience @EESK @UnifiedExperience
  @feature:EESK-4651
  @tms:UTR-17053
  Scenario Outline: Unified Search suggestions - Verify that entering white spaces in unified Header does nothing
    Given I am on locale <locale> home page with forced accepted cookies
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "  " in the field Experience.Header.UnifiedSearchField
      And I see Experience.SearchSuggestionPanel.SearchSuggestionsFlyout is not displayed in 10 seconds
      And I see Experience.SearchSuggestionPanel.PopularSearchFlyout is not displayed
      And I see Experience.SearchSuggestionPanel.RecentSearchSuggestionsFlyout is not displayed
      And I click on Experience.Header.SearchIcon
    Then I see the current page is Homepage

    Examples:
      | locale |
      | ee     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @Header @UnifiedSearch @UnifiedExperience @TEX @UnifiedTEX @UnifiedExperience @P2
  @feature:TEX-15843 @issue:TEX-15922
  @tms:UTR-17334
  Scenario Outline: Unified Search suggestions - Verify user is able to clear text in search bar using translated clear all button
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I get translation from lokalise for "clearAllText" and store it with key #clearAll
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
      And I wait until element Experience.Header.UnifiedSearchField is active in 10 seconds
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "<searchQuery>" in the field Experience.Header.UnifiedSearchField
      And I wait for 1 network request named suggestions of type fetch to be processed
    Then I see Experience.SearchSuggestionPanel.SearchSuggestionLinks with index 1 is displayed in 10 seconds
      And I see Experience.Header.ClearSearchText with text #clearAll is displayed
    When I click on Experience.Header.ClearSearchButton
    Then I see Experience.Header.ClearSearchText with text #clearAll is not displayed in 10 seconds
      And I see Experience.SearchSuggestionPanel.SearchSuggestionLinks with index 1 is not displayed in 10 seconds

    Examples:
      | locale  | langCode | page | searchQuery |
      | default | default  | pdp  | shir        |

    @issue:TEX-15893
    Examples:
      | locale           | langCode         | page | searchQuery |
      | multiLangDefault | multiLangDefault | plp  | jean        |
      | multiLangDefault | default          | plp  | jean        |
