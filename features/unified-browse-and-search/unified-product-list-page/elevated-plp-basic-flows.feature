Feature: Unified Elevated PLP - Basic Flows

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedPLP @UnifiedExperience @EESK @P2
  @ElevatedPLP
  @tms:UTR-16698
  Scenario Outline: Unified Elevated PLP - Verify elevated plp is loaded with product, header and footer
    Given I am on locale <locale> of url <elevatedPlpUrl> of langCode <langCode> with accepted cookies
      And I wait until the current page is loaded
    When I ensure unified mega menu is interactable
    Then I wait until Experience.Content.TemplateBlock with data-testid "hero-template" is displayed
      And I see the count of elements Experience.PlpProducts.ListingItems is greater than 1
      And I see Experience.Header.MegaMenuFirstLevelItems is displayed
      And I see Experience.Header.MegaMenuSecondLevelItemsByIndex is displayed
      And I see Experience.Header.UnifiedSearchContainer is displayed
      And I see Experience.Header.SignInButton is displayed
      And I see Experience.Header.ShoppingBagButton is displayed
      And I see Experience.Header.WishListIcon is displayed
      And I see Experience.PlpFilters.FilterContainer is not displayed
      And I see Experience.PlpProducts.BreadcrumbItems is not displayed
      And I see Experience.PlpHeader.CategoryNavigationBlock is not displayed
    When I move to the bottom of the page
    Then in unified footer I ensure Experience.Footer.CountryDropdown is interactable
      And I see Experience.PlpProducts.BackToTopButton is displayed
      And I see Experience.Footer.ContenBlock is displayed
      And I see Experience.Footer.StoreLocatorLink is displayed
    When I click on Experience.PlpProducts.BackToTopButton
      And I wait until Experience.Content.TemplateBlock with data-testid "hero-template" is in viewport

    @ExcludeCK
    Examples:
      | locale | langCode | elevatedPlpUrl     |
      | uk     | default  | disney-x-tommy-men |
    # | uk     | default  | men-tommy-jeans-capsule-collection   |
    # | uk     | default  | women-tommy-jeans-capsule-collection |

    @ExcludeTH
    Examples:
      | locale | langCode | elevatedPlpUrl   |
      | uk     | default  | ladies-underwear |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedPLP @UnifiedExperience @EESK @P2
  @ElevatedPLP
  @tms:UTR-16785
  Scenario Outline: Unified Elevated PLP - Verify each product tile has price and title
    Given I am on locale <locale> of url <elevatedPlpUrl> of langCode <langCode> with accepted cookies
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
    When I hover over Experience.PlpProducts.ListingItems with index 1
    Then I see Experience.PlpProducts.ProductsPrice is displayed
      And I see Experience.PlpProducts.ProductTitles is displayed
      And I see the count of Experience.PlpProducts.ProductsPrice is the same as the count of Experience.PlpProducts.ListingItems
      And I see the count of Experience.PlpProducts.ProductTitles is the same as the count of Experience.PlpProducts.ListingItems

    @ExcludeCK
    Examples:
      | locale | langCode | elevatedPlpUrl     |
      | uk     | default  | disney-x-tommy-men |

    @ExcludeTH
    Examples:
      | locale | langCode | elevatedPlpUrl   |
      | uk     | default  | ladies-underwear |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedPLP @UnifiedExperience @ElevatedPLP @PDP @EESK @BasicFlows @P2
  @tms:UTR-16786
  Scenario Outline: Unified Elevated PLP - Unified elevated PLP item redirects to correct PDP
    Given I am on locale <locale> of url <elevatedPlpUrl> of langCode <langCode> with accepted cookies
      And I wait until the current page is loaded
      And I store the value of Experience.PlpProducts.ProductTitles with index 1 with key #productTitle
      And I click on Experience.PlpProducts.ProductListItems with index 1 until ProductDetailPage.Pdp.Content is displayed
      And I wait until ProductDetailPage.Pdp.Content is displayed
    Then the value of ProductDetailPage.Pdp.ProductName should be equal to the stored value with key #productTitle

    @ExcludeCK
    Examples:
      | locale | langCode | elevatedPlpUrl     |
      | uk     | default  | disney-x-tommy-men |

    @ExcludeTH
    Examples:
      | locale | langCode | elevatedPlpUrl   |
      | uk     | default  | ladies-underwear |