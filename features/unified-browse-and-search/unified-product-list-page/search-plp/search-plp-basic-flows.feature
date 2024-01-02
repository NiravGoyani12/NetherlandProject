Feature: Unified Search PLP - Basic Flows

  @FullRegression
  @UnifiedSearchPLP
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending @P1
  @UnifiedPLP @UnifiedExperience @EESK @BasicFlows
  @tms:UTR-15831
  Scenario Outline: Unified Search PLP - Verify Unified Search PLP elements are displayed
    Given I am on locale <locale> glp page of langCode <langCode> with accepted cookies
    When I navigate to page <page>
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpHeader.PageHeader is displayed
      And I see Experience.PlpHeader.ProductCount is displayed
      And the count of elements Experience.PlpProducts.ListingItems is greater than 1
      And the numeric value of Experience.PlpHeader.ProductCount is greater than 1
      And I see the count of Experience.PlpProducts.ProductsPrice is the same as the count of Experience.PlpProducts.ListingItems
      And I see the count of Experience.PlpProducts.ProductTitles is the same as the count of Experience.PlpProducts.ListingItems

    Examples:
      | locale  | langCode | page       |
      | default | default  | search-plp |

  @FullRegression
  @UnifiedSearchPLP
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @UnifiedPLP @UnifiedExperience @PDP @EESK @BasicFlows @P1
  @tms:UTR-15832
  Scenario Outline: Unified Search PLP - Search PLP item redirects to correct PDP
    Given I am on locale <locale> glp page of langCode <langCode> with accepted cookies
    When I navigate to page <page>
      And I wait until page Experience.PlpProducts is loaded
      And I store the value of Experience.PlpProducts.ProductsPrice with index 1 with key #productPrice
      And I store the value of Experience.PlpProducts.ProductTitles with index 1 with key #productTitle
      And I click on Experience.PlpProducts.ListingItems with index 1 until ProductDetailPage.Pdp.Content is displayed
      And I wait until ProductDetailPage.Pdp.Content is displayed
    Then the value of ProductDetailPage.Pdp.ProductName should be equal to the stored value with key #productTitle

    Examples:
      | locale | langCode | page       |
      | uk     | default  | search-plp |

  # @FullRegression
  @UnifiedSearchPLP
  @Desktop
  @Chrome @FireFox @SafariPending
  @UnifiedPLP @UnifiedExperience @EESK @BasicFlows @P2
  @tms:UTR-15856
  Scenario Outline: Unified Search PLP Desktop - Each product has 5 images
    Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    When I hover over Experience.PlpProducts.ListingItems with index 1
    Then I see Experience.PlpProducts.ProductCarouselNextButton is displayed in 10 seconds
      And I see Experience.PlpProducts.ProductCarouselPrevButton is displayed in 10 seconds
      And I see the count of elements Experience.PlpProducts.ProductTileDots with args 1 is equal to 5
      And I see the count of elements Experience.PlpProducts.ProductImages with args 1 is equal to 5
    When I click on Experience.PlpProducts.ProductCarouselNextButton
    Then I see the attribute class of element Experience.PlpProducts.ProductTileDotByIndex with args 1,2 containing "Current" in 5 seconds
      And I see Experience.PlpProducts.ProductImageByIndex with index 1##1 is existing
      And I see Experience.PlpProducts.ProductImageByIndex with index 1##2 is existing
      And I see Experience.PlpProducts.ProductImageByIndex with index 1##3 is existing
      And I see Experience.PlpProducts.ProductImageByIndex with index 1##4 is existing
      And I see Experience.PlpProducts.ProductImageByIndex with index 1##5 is existing

    Examples:
      | locale | langCode | page       |
      | uk     | default  | search-plp |

  @FullRegression @RCTest
  @UnifiedSearchPLP
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Search @UnifiedPLP @UnifiedExperience @EESK @P2
  @tms:UTR-15843
  Scenario Outline: Unified Search PLP - Verify no search result page
    Given I am on locale <locale> search page with search term "qwerty" with accepted cookies
    Then I see Experience.PlpNosearch.NoSearchResultMessage is displayed
      And I see Experience.PlpNosearch.NoSearchResultMessage contains text "qwerty"
      And the count of displayed elements Experience.PlpProducts.ListingItems is equal to 0 in 2 seconds

    Examples:
      | locale |
      | ee     |

  @FullRegression
  @UnifiedSearchPLP
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Search @UnifiedPLP @UnifiedExperience @EESK @P1
  @tms:UTR-15844
  Scenario Outline: Unified Search PLP - Search query returns relevant results
    Given I am on locale <locale> search page with search term "<searchTerm>" with accepted cookies
    When I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpProducts.ProductTitles with index 1 contains text "<termFound>"
      And I see Experience.PlpProducts.ProductTitles with index 2 contains text "<termFound>"
      And I see Experience.PlpProducts.ProductTitles with index 3 contains text "<termFound>"
      And I see Experience.PlpHeader.PageHeader contains text "<searchTerm>"
      And I see Experience.PlpHeader.ProductCount is displayed

    @RCTest
    Examples:
      | locale  | searchTerm | termFound |
      | default | jeans      | jeans     |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending
  @Header @Search @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @EESK @P2
  @feature:EESK-56
  @tms:UTR-15847
  Scenario Outline: Unified Search Desktop - User can navigate to search results page from category PLP
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
      And I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "<termFound>" in the field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpHeader.PageHeader contains text "<termFound>"
      And I see Experience.PlpHeader.ProductCount is displayed
      And the count of elements Experience.PlpProducts.ListingItems is greater than 1
      And the numeric value of Experience.PlpHeader.ProductCount is greater than 1
    Then I see Experience.PlpProducts.ProductTitles with index 2 contains text "<termFound>"
      And I see Experience.PlpProducts.ProductTitles with index 3 contains text "<termFound>"

    @ExcludeTH
    Examples:
      | locale  | langCode | categoryId             | termFound |
      | default | default  | women_clothes_t-shirts | jean      |

    @ExcludeCK
    Examples:
      | locale  | langCode | categoryId                 | termFound |
      | default | default  | th_women_clothing_t-shirts | jean      |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending
  @Header @Search @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @EESK @P2
  @feature:EESK-56
  @tms:UTR-15848
  Scenario Outline: Unified Search Desktop - User can navigate to no-search-results page from category PLP
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
      And I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "qwertyblabla" in the field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
    Then I see Experience.PlpNosearch.NoSearchResultMessage is displayed
      And I see Experience.PlpNosearch.NoSearchResultMessage contains text "qwerty"
      And the count of displayed elements Experience.PlpProducts.ListingItems is equal to 0 in 2 seconds

    @ExcludeTH
    Examples:
      | locale | langCode | categoryId             |
      | uk     | default  | women_clothes_t-shirts |

    @ExcludeCK
    Examples:
      | locale | langCode | categoryId                 |
      | uk     | default  | th_women_clothing_t-shirts |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending
  @Header @Search @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @EESK @P2
  @feature:EESK-4238
  @tms:UTR-17140
  Scenario Outline: Unified Search PLP - Verify user should remain on the multilang locale after unified search
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
      And I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.Header.UnifiedSearchContainer
    When I type "jeans" in the field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
    Then URL should contain "DE" in 5 seconds

    @ExcludeTH
    Examples:
      | locale | langCode | categoryId             |
      | lu     | DE       | women_clothes_t-shirts |

    @ExcludeCK
    Examples:
      | locale | langCode | categoryId                 |
      | lu     | DE       | th_women_clothing_t-shirts |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending
  @Header @Search @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @EESK @P2
  @feature:EESK-56
  @tms:UTR-15849
  Scenario Outline: Unified Search Desktop - User can navigate to category PLP from search results page via megamenu
    Given I am on locale <locale> women glp page of langCode <langCode> with forced accepted cookies
      And I am on locale <locale> search page of langCode <langCode> with search term "jeans"
    When I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpHeader.PageHeader contains text "jeans"
      And the count of elements Experience.PlpProducts.ListingItems is greater than 0
      And URL should contain "search?searchTerm=jeans"
      And I see Experience.PlpHeader.ProductCount is displayed
      And the count of elements Experience.PlpProducts.ListingItems is greater than 1
      And the numeric value of Experience.PlpHeader.ProductCount is greater than 1
      And I ensure unified mega menu is interactable
    When In unified Megamenu I navigate to PLP using text with category Clothes and sub-category T-shirts
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpHeader.PageHeader contains translated text "T-shirts"

    Examples:
      | locale | langCode |
      | uk     | default  |

  @FullRegression
  @Desktop @Mobile
  @OnlyEmulator
  @Chrome @FireFox
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @EESK @BasicFlows @BackButton @P2
  @feature:EESK-3854
  @tms:UTR-15854
  Scenario Outline: Unfiltered Unified Search PLP - When clicking back from PDP ensure that only 1 products call is made
    Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
      And I am a <userType> user
      And I wait until page Experience.PlpProducts is loaded
    When I click on Experience.PlpProducts.ListingItems with index 2 until ProductDetailPage.Pdp.Content is displayed
      And I wait until ProductDetailPage.Pdp.Content is displayed
    Then I navigate back in the browser
      And I expect not more than 1 network request named products?filter of type xmlhttprequest to be processed in 10 seconds

    Examples:
      | locale | langCode | userType  |
      | uk     | default  | logged in |
      | uk     | default  | guest     |

  @FullRegression
  @Desktop @Mobile
  @OnlyEmulator
  @Chrome @FireFox
  @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @EESK @BasicFlows @BackButton @P2
  @feature:EESK-3854
  @tms:UTR-15855
  Scenario Outline: Filtered Unified Search PLP - When clicking back from PDP ensure that only 1 products call is made
    Given I am on locale <locale> search page of langCode <langCode> with search term "shirts" with accepted cookies
      And I am a <userType> user
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
      And I expect not more than 1 network request named products?filter of type xmlhttprequest to be processed in 10 seconds
      And I wait until page Experience.PlpProducts is loaded
    When I click on Experience.PlpProducts.ListingItems with index 2 until ProductDetailPage.Pdp.Content is displayed
      And I wait until ProductDetailPage.Pdp.Content is displayed
    Then I navigate back in the browser
      And I see Experience.PlpFilters.ActiveFilterLabels is in viewport

    @ExcludeTH
    Examples:
      | locale | langCode | userType  | filterType | filterOption |
      | uk     | default  | logged in | FIT        | Regular      |
      | uk     | default  | guest     | FIT        | Regular      |

    @ExcludeCK
    Examples:
      | locale | langCode | userType  | filterType | filterOption |
      | uk     | default  | guest     | Category   | Shirts       |
      | uk     | default  | logged in | Category   | Shirts       |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @UnifiedSearchPLP
  @UnifiedFooter @UnifiedPLP @UnifiedExperience @P2
  @tms:UTR-15857 @EESK-5099
  Scenario Outline: Unified Search PLP - Language selector in unified footer is able to navigate to correct locale
    Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    When I move to the bottom of the page
      And in unified footer I ensure Experience.Footer.CountryDropdown is interactable
      And in dropdown Experience.Footer.CountryDropdown I select the option by text "<countryName>" in 5 seconds
      And I click on Experience.Footer.CountrySwitchButton
    Then URL should contain "<countryCode>" in 5 seconds

    Examples:
      | locale | langCode | countryName    | countryCode |
      | uk     | default  | United Kingdom | uk          |
      | uk     | default  | Schweiz        | ch          |
      | uk     | default  | France         | fr          |

  #Temp test cases till Regular PLP is SPA and search PLP is unified(Bug:TEX-15569). Will be removed once both are unified
  # @FullRegression
  # @Desktop @Mobile
  # @Chrome @FireFox @Safari @SPAToUnificationFlow @UnifiedTEX
  # @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @PlpPagination @Viewport @TEX @P2
  # @tms:UTR-15945 @ExcludeCK
  # Scenario Outline: SPA Regular PLP to Unified Search PLP - TH - Verify that user is able to search and navigate to Unified search PLP from SPA Regular PLP
  #   Given I am on locale <locale> of url <SPAplp> with forced accepted cookies
  #     And I wait until the current page is loaded
  #     #Verify and search of SPA PLP
  #     And I see Header.SearchInput is displayed
  #   When in header I search "<searchTerm>"
  #     #Verify Unified PLP
  #     And I wait until page Experience.PlpProducts is loaded
  #   Then I see Experience.PlpHeader.PageHeader is displayed
  #     And I see Experience.PlpHeader.ProductCount is displayed
  #     And the count of elements Experience.PlpProducts.ListingItems is greater than 1
  #     And the numeric value of Experience.PlpHeader.ProductCount is greater than 1
  #     And I see the count of Experience.PlpProducts.ProductsPrice is the same as the count of Experience.PlpProducts.ListingItems

  #   Examples:
  #     | locale | searchTerm | SPAplp                         |
  #     | uk     |shirts     | /tommy-x-mercedes-f1-awake-men |

  # #Temp test cases till Regular PLP is SPA and search PLP is unified(Bug:EESK-5169). Will be removed once both are unified
  # @FullRegression
  # @Desktop
  # @Chrome @FireFox @Safari @SPAToUnificationFlow @UnifiedTEX
  # @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP @PlpPagination @Viewport @TEX @P2
  # @tms:UTR-15949 @ExcludeTH
  # Scenario Outline: SPA Regular PLP to Unified Search PLP - CK - Verify that user is able to search and navigate to Unified search PLP from SPA Regular PLP
  #   Given I am on locale <locale> of url <SPAplp> with forced accepted cookies
  #     And I wait until the current page is loaded
  #     #Verify and search of SPA PLP
  #     And I wait until Header.SearchField is displayed in 10 seconds
  #     And I clear text field of element Header.SearchField
  #   When I type "<searchTerm>" in the field Header.SearchField
  #     And I click on Header.SearchSubmitButton
  #     #Verify Unified PLP
  #     And I wait until page Experience.PlpProducts is loaded
  #   Then I see Experience.PlpHeader.PageHeader is displayed
  #     And I see Experience.PlpHeader.ProductCount is displayed
  #     And the count of elements Experience.PlpProducts.ListingItems is greater than 1
  #     And the numeric value of Experience.PlpHeader.ProductCount is greater than 1
  #     And I see the count of Experience.PlpProducts.ProductsPrice is the same as the count of Experience.PlpProducts.ListingItems

  #   Examples:
  #     | locale | searchTerm | SPAplp         |
  #     | uk     |shirts     | /ck-1996-women |

  #  This TC might fail in case of new stock
  @FullRegression
  @Mobile @Desktop @Translation
  @Chrome @FireFox @Lokalise
  @UnifiedPLP @UnifiedExperience @EESK @P2
  @feature:EESK-5126 @feature:EESK-5327
  @tms:UTR-16944
  Scenario Outline: Unified PLP - Verify Coming soon and Sold out label is appearing on a given product ID
    Given I am on locale <locale> glp page of langCode <langCode> with accepted cookies
      And I get translation from lokalise for "ComingSoonText" and store it with key #ComingSoonText
      And I get translation from lokalise for "SoldOutText" and store it with key #SoldOutText
      And I click on Experience.Header.UnifiedSearchContainer
      And I type "<searchTerm1>" in the field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpProducts.ProductLabelSoldOut is displayed
    Then I see Experience.PlpProducts.ProductLabel with text #ComingSoonText is not displayed
      And I click on Experience.Header.UnifiedSearchContainer
      And I type "<searchTerm2>" in the field Experience.Header.UnifiedSearchField
      And I click on Experience.Header.SearchIcon
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpProducts.ProductLabelSoldOut with text #SoldOutText is not displayed
    Then I see Experience.PlpProducts.ProductLabel with text #ComingSoonText is displayed

    @ExcludeCK
    Examples:
      | locale | langCode | productLabel1 | productLabel2 | searchTerm1               | searchTerm2                                       |
      | uk     | default  | COMING SOON   | SOLD OUT      | White wireless headphones | Vacation Floral Print Spaghetti Straps Maxi Dress |

    @ExcludeTH
    Examples:
      | locale | langCode | productLabel1 | productLabel2 | searchTerm1                        | searchTerm2              |
      | uk     | default  | COMING SOON   | SOLD OUT      | Beach Tank Top Intense Power women | Men 75ml Eau De Toilette |