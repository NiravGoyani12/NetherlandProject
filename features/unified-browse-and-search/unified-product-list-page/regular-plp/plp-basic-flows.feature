Feature: Unified PLP - Basic Flows

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @EESK @BasicFlows @P1
  @tms:UTR-15899
  Scenario Outline: Unified PLP - Verify Unified PLP elements are displayed
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpHeader.PageHeader is displayed
      And I see Experience.PlpHeader.ProductCount is displayed
      And the count of elements Experience.PlpProducts.ListingItems is greater than 1
      And the numeric value of Experience.PlpHeader.ProductCount is greater than 1
      And I see the count of Experience.PlpProducts.ProductsPrice is the same as the count of Experience.PlpProducts.ListingItems
      And I see the count of Experience.PlpProducts.ProductTitles is the same as the count of Experience.PlpProducts.ListingItems

    @ExcludeTH
    Examples:
      | locale | langCode | categoryId             |
      | uk     | default  | women_clothes_t-shirts |

    @ExcludeCK
    Examples:
      | locale | langCode | categoryId              |
      | uk     | default  | th_women_clothing_jeans |


  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @PDP @EESK @BasicFlows @P1
  @tms:UTR-15900
  Scenario Outline: Unified PLP - Unified PLP item redirects to correct PDP
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I store the value of Experience.PlpProducts.ProductsPrice with index 1 with key #productPrice
      And I store the value of Experience.PlpProducts.ProductTitles with index 1 with key #productTitle
      And I click on Experience.PlpProducts.ListingItems with index 1 until ProductDetailPage.Pdp.Content is displayed
      And I wait until ProductDetailPage.Pdp.Content is displayed
    Then the value of ProductDetailPage.Pdp.ProductName should be equal to the stored value with key #productTitle

    @ExcludeTH
    Examples:
      | locale | langCode | categoryId             |
      | uk     | default  | women_clothes_t-shirts |

    @ExcludeCK
    Examples:
      | locale | langCode | categoryId              |
      | uk     | default  | th_women_clothing_jeans |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PLP @UnifiedPLP @UnifiedExperience @UnifiedCollectionsPLP @EESK @P2
  @tms:UTR-15322
  Scenario Outline: Unified Collections PLP - Collections and kids PLP item redirects to correct PDP
    Given I am on category <categoryId> page of locale <locale> of langCode <langCode> with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I store the value of Experience.PlpProducts.ProductsPrice with index 1 with key #productPrice
      And I store the value of Experience.PlpProducts.ProductTitles with index 1 with key #productTitle
    When I click on Experience.PlpProducts.ListingItems with index 1 until ProductDetailPage.Pdp.Content is displayed
      And I wait until ProductDetailPage.Pdp.Content is displayed
      And the value of ProductDetailPage.Pdp.ProductName should be equal to the stored value with key #productTitle

    @ExcludeTH
    Examples:
      | locale | langCode | categoryId                   |
      | uk     | default  | women_newin_onlineexclusives |
      | uk     | default  | kids_boys_clothes_t-shirts   |

    @ExcludeCK
    Examples:
      | locale | langCode | categoryId              |
      | uk     | default  | th_women_clothing_jeans |
      | uk     | default  | th_kids_girls_jeans     |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @EESK @BasicFlows @P2
  @tms:UTR-15901
  Scenario Outline: Unified PLP Desktop - Each product has 5 images
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    When I hover over Experience.PlpProducts.ListingItems with index 1
    Then I see Experience.PlpProducts.ProductCarouselNextButton is displayed in 10 seconds
      And I see Experience.PlpProducts.ProductCarouselPrevButton is displayed in 10 seconds
      And I see the count of Experience.PlpProducts.ProductTileDots is the same as the count of Experience.PlpProducts.ProductImages
    When I click on Experience.PlpProducts.ProductCarouselNextButton
    Then I see the attribute class of element Experience.PlpProducts.ProductTileDotByIndex with args 1,2 containing "Current" in 10 seconds
      And I see Experience.PlpProducts.ProductImageByIndex with index 1##1 is existing
      And I see Experience.PlpProducts.ProductImageByIndex with index 1##2 is existing
      And I see Experience.PlpProducts.ProductImageByIndex with index 1##3 is existing
      And I see Experience.PlpProducts.ProductImageByIndex with index 1##4 is existing
      And I see Experience.PlpProducts.ProductImageByIndex with index 1##5 is existing

    # @ExcludeTH
    # Examples:
    #   | locale | langCode | categoryId             |
    #   | uk     |default  | women_clothes_t-shirts |

    @ExcludeCK
    Examples:
      | locale | langCode | categoryId              |
      | uk     | default  | th_women_clothing_jeans |

  @FullRegression
  @Desktop @Mobile
  @OnlyEmulator
  @Chrome @FireFox
  @UnifiedPLP @UnifiedExperience @EESK @BasicFlows @BackButton @P2
  @feature:EESK-3854
  @tms:UTR-15902
  Scenario Outline: Unfiltered Category Unified PLP - When clicking back from PDP ensure that only 1 products call is made
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I wait until page Experience.PlpProducts is loaded
    When I click on Experience.PlpProducts.ListingItems with index 2 until ProductDetailPage.Pdp.Content is displayed
      And I wait until ProductDetailPage.Pdp.Content is displayed
    Then I navigate back in the browser
      And I expect not more than 1 network request named products?filter of type xmlhttprequest to be processed in 10 seconds

    @ExcludeTH
    Examples:
      | locale | langCode | userType  | categoryId             |
      | uk     | default  | logged in | women_clothes_t-shirts |
      | uk     | default  | guest     | women_bestsellers      |

    @ExcludeCK
    Examples:
      | locale | langCode | userType  | categoryId              |
      | uk     | default  | logged in | th_women_clothing_jeans |
      | uk     | default  | logged in | th_women_collections    |

  @FullRegression
  @Desktop
  @OnlyEmulator
  @Chrome @FireFox
  @UnifiedPLP @UnifiedExperience @EESK @BasicFlows @BackButton @P2
  @feature:EESK-3854
  @tms:UTR-15903
  Scenario Outline: Filtered Category Unified PLP - When clicking back from PDP ensure that only 1 products call is made
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
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
      | locale | langCode | userType  | filterType | filterOption | categoryId                   |
      | uk     | default  | guest     | Material   | Wool         | women_newin_onlineexclusives |
      | uk     | default  | logged in | Size       | 8            | kids_boys_clothes_t-shirts   |

    @ExcludeCK
    Examples:
      | locale | langCode | userType  | filterType | filterOption | categoryId              |
      | uk     | default  | guest     | Size       | M            | th_women_clothing_jeans |
      | uk     | default  | logged in | Size       | M            | th_men_collections      |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @EESK @BasicFlows @P2
  @feature:EESK-4874
  @tms:UTR-14890
  Scenario Outline: Unified PLP - Verify redirecting to correct PLP
    Given I am on locale <locale> women glp page of langCode <langCode> with accepted cookies
      And I ensure unified mega menu is interactable
      And In unified Megamenu I navigate to PLP using text with category <category> and sub-category <sub-category>
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpHeader.PageHeader is displayed
      And I see Experience.PlpHeader.ProductCount is displayed
      And the count of elements Experience.PlpProducts.ListingItems is greater than 1
      And the numeric value of Experience.PlpHeader.ProductCount is greater than 1
      And I see the count of Experience.PlpProducts.ProductsPrice is the same as the count of Experience.PlpProducts.ListingItems
      And I see the count of Experience.PlpProducts.ProductTitles is the same as the count of Experience.PlpProducts.ListingItems

    @ExcludeTH
    Examples:
      | locale | langCode | sub-category | category  |
      | uk     | default  | Bras         | Underwear |

    @ExcludeCK
    Examples:
      | locale | langCode | sub-category | category |
      | uk     | default  | T-shirts     | Clothes  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedFooter @UnifiedPLP @UnifiedExperience @P2
  @tms:UTR-15904 @EESK-5099
  Scenario Outline: Unified PLP - Language selector in unified footer is able to navigate to correct locale
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    When I move to the bottom of the page
      And in unified footer I ensure Experience.Footer.CountryDropdown is interactable
      And in dropdown Experience.Footer.CountryDropdown I select the option by text "<countryName>" in 5 seconds
      And I click on Experience.Footer.CountrySwitchButton
    Then URL should contain "<countryCode>" in 5 seconds

    @ExcludeTH
    Examples:
      | locale | langCode | countryName    | countryCode | categoryId             |
      | uk     | default  | United Kingdom | uk          | women_clothes_t-shirts |
      | uk     | default  | Schweiz        | ch          | women_clothes_t-shirts |

    @ExcludeCK
    Examples:
      | locale | langCode | countryName    | countryCode | categoryId              |
      | uk     | default  | United Kingdom | uk          | th_women_clothing_jeans |
      | uk     | default  | France         | fr          | th_women_clothing_jeans |

  @FullRegression
  @Mobile @Desktop
  @Chrome @FireFox
  @UnifiedPLP @UnifiedExperience @EESK @P2
  @feature:EESK-5117
  @tms:UTR-16088
  Scenario Outline: Unified PLP - Verify product description at the bottom and links present in the text redirects to the correct PLP
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I scroll to the element Experience.PlpProducts.ProductDescription
    Then I see Experience.PlpProducts.ProductDescriptionText with text <productDescriptionText> is displayed
    When I click on Experience.PlpProducts.ProductDescriptionTextLinks with args <href>
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpHeader.PageHeader is displayed
      And I see Experience.PlpHeader.PageHeader with text <pageHeader> is displayed
      And URL should contain "<category>" in 5 seconds

    @ExcludeTH
    Examples:
      | locale  | categoryId           | productDescriptionText | href            | category | pageHeader |
      | default | MEN_CLOTHES_T-SHIRTS | T-shirts               | /mens-tank-tops | tank     | Tank       |

    @ExcludeCK
    Examples:
      | locale  | categoryId                   | productDescriptionText | href        | category | pageHeader |
      | default | TH_MEN_CLOTHING_COATSJACKETS | Jackets                | /mens-boots | boots    | BOOTS      |

  @FullRegression
  @Mobile @Desktop
  @Chrome @FireFox
  @UnifiedPLP @UnifiedExperience @EESK @P2
  @feature:EESK-5083
  @tms:UTR-16187
  Scenario Outline: Unified PLP - Verify top banner is displayed on unified PLP for a given category
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpProducts.ProductTopBanner with text <bannerText> is displayed
      And I see Experience.PlpProducts.ProductTopBannerLinks with text <bannerTextLinks> is displayed

    @ExcludeTH
    Examples:
      | locale | categoryId             | bannerText   | bannerTextLinks |
      | uk     | women_clothes_t-shirts | E-GIFT CARDS | Shop Now        |

    @ExcludeCK
    Examples:
      | locale | categoryId                 | bannerText   | bannerTextLinks     |
      | uk     | th_women_clothing_t-shirts | E-GIFT CARDS | SHOP THE Collection |

  @FullRegression
  @Mobile @Lokalise @Translation
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @EESK @BasicFlows @P2
  @feature:EESK-4980 @feature:EESK-4791 @feature:EESK-4667
  @tms:UTR-15346
  Scenario Outline: Unified PLP - Verify each category contains 'Shop All' text and correct translation on Mobile
    Given I am on locale <locale> glp page of langCode <langCode> with accepted cookies
      And I get translation from lokalise for "ShopAllText" and store it with key #ShopAllText
      And I ensure unified mega menu is interactable
    When in unified megamenu I select 1st level item with index 1
    Then in unified megamenu every second level category contains #ShopAllText
      And in unified megamenu I select 1st level item with index 2
    Then in unified megamenu every second level category contains #ShopAllText
      And in unified megamenu I select 1st level item with index 3
    Then in unified megamenu every second level category contains #ShopAllText

    Examples:
      | locale | langCode |
      | fr     | default  |
      | lu     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PLP @UnifiedPLP @UnifiedExperience @UnifiedCollectionsPLP @EESK @P2
  @tms:UTR-15324
  Scenario Outline: Unified Collections PLP - Verify user is able to navigate to Collections PLP via SEO URL
    Given I am on category <categoryId> page of locale <locale> of langCode <langCode> with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpHeader.PageHeader is displayed
      And I see Experience.PlpHeader.ProductCount is displayed
      And the count of elements Experience.PlpProducts.ListingItems is greater than 1
      And the numeric value of Experience.PlpHeader.ProductCount is greater than 1
      And I see the count of Experience.PlpProducts.ProductsPrice is the same as the count of Experience.PlpProducts.ListingItems
      And I see the count of Experience.PlpProducts.ProductTitles is the same as the count of Experience.PlpProducts.ListingItems

    @ExcludeTH
    Examples:
      | locale  | langCode | categoryId      |
      | default | default  | men_bestsellers |

    @ExcludeCK
    Examples:
      | locale  | langCode | categoryId             |
      | default | default  | th_men_clothing_shirts |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @UnifiedCollectionsPLP @PlpNavigation @EESK @P2
  @tms:UTR-14886
  Scenario Outline: Unified Collections PLP - Navigation - Verify user is able to navigate to Collections PLP from megamenu
    Given I am on locale <locale> women glp page of langCode <langCode> with forced accepted cookies
      And I ensure unified mega menu is interactable
      And In unified Megamenu I navigate to PLP using text with category <megamenuCategory> and sub-category <megamenuLink>
      And I wait until page Experience.PlpProducts is loaded
    Then I see Experience.PlpHeader.PageHeader is displayed
      And I see Experience.PlpHeader.ProductCount is displayed
      And the count of elements Experience.PlpProducts.ListingItems is greater than 1
      And the numeric value of Experience.PlpHeader.ProductCount is greater than 1
      And I see the count of Experience.PlpProducts.ProductsPrice is the same as the count of Experience.PlpProducts.ListingItems
      And I see the count of Experience.PlpProducts.ProductTitles is the same as the count of Experience.PlpProducts.ListingItems

    @ExcludeTH
    Examples:
      | locale  | langCode | megamenuCategory | megamenuLink |
      | default | default  | Collections      | Bestsellers  |

    @ExcludeCK
    Examples:
      | locale  | langCode | megamenuCategory | megamenuLink |
      | default | default  | Collections      | Essentials   |

  @FullRegression
  @Mobile @Desktop @Translation
  @Chrome @FireFox @Lokalise
  @UnifiedPLP @UnifiedExperience @EESK @P2
  @feature:EESK-4191
  @tms:UTR-17114
  Scenario Outline: Unified PLP - Verify "More colours" link appears for products having multiple color options
    Given I am on category <categoryId> page of locale <locale> with accepted cookies
      And I get translation from lokalise for "MoreColoursText" and store it with key #moreColoursText
      And I wait until page Experience.PlpProducts is loaded
      And I see Experience.PlpProducts.ProductMoreColorText with text #moreColoursText is displayed
    When I click on Experience.PlpProducts.ProductMoreColorText with index 1
      And I wait until ProductDetailPage.Pdp.Content is displayed
    Then I see ProductDetailPage.Pdp.ColorSwatches is displayed
      And the count of elements ProductDetailPage.Pdp.ColorSwatches is greater than 1

    @ExcludeTH
    Examples:
      | locale  | categoryId                                   |
      | default | women_bags&accessories_newinbags&accessories |
      | default | women_bags&accessories_newinbags&accessories |

    @ExcludeCK
    Examples:
      | locale  | categoryId                    |
      | default | th_women_bagsaccessories_bags |
      | fr      | th_women_bagsaccessories_bags |

  @FullRegression
  @Mobile @Desktop
  @Chrome @FireFox
  @UnifiedPLP @UnifiedExperience @EESK @P2
  @feature:EESK-4395
  @tms:UTR-17456
  Scenario Outline: Unified Kids PLP - Verify minimum price from the different sizes is displayed for Kids plp
    Given I am on category <categoryId> page of locale <locale> with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I store the numeric value of Experience.PlpProducts.ProductsPrice with index 2 with key #ProductPrice
      And I click on Experience.PlpProducts.ListingItems with index 2
      And I wait until the current page is loaded
      And I see ProductDetailPage.Pdp.CurrentPrice with text #ProductPrice is displayed in 2 seconds
    Then in unified PDP I see lowest price of the available sizes are displayed

    @ExcludeCK
    Examples:
      | locale  | categoryId          |
      | default | th_kids_boys_shirts |