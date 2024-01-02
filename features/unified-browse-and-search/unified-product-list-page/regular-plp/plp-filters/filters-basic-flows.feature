Feature: Unified PLP Filters - Basic Flows

	@FullRegression @RCTest
	@Desktop @Mobile
	@Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @UnifiedTEX
	@PLP @Filter @TEX @BasicFilterFlows @P1
	@tms:UTR-15587
	Scenario Outline: Unified PLP Filters - Verify checkbox filter can be applied on PLP
		Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
		When I am on locale <locale> of url #categoryUrl with forced accepted cookies
			And I wait until the current page is loaded
			And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
		Then in unified filter panel I see filter type <filterType> with filter <filterOption> is active
			And I see Experience.PlpHeader.PageHeader is displayed
			And I see Experience.PlpHeader.ProductCount is displayed
			And the count of elements Experience.PlpProducts.ListingItems is greater than 1
			And the numeric value of Experience.PlpHeader.ProductCount is greater than 1
			And I see the count of Experience.PlpProducts.ProductsPrice is the same as the count of Experience.PlpProducts.ListingItems
			And I see the count of Experience.PlpProducts.ProductTitles is the same as the count of Experience.PlpProducts.ListingItems

		@ExcludeTH
		Examples:
			| locale | categoryId             | filterType | filterOption |
			| uk     | women_clothes_t-shirts | Colour     | Red          |

		@ExcludeCK
		Examples:
			| locale | categoryId                   | filterType | filterOption |
			| uk     | TH_MEN_CLOTHING_COATSJACKETS | Colour     | Blue         |

	@FullRegression @RCTest
	@Desktop @Mobile
	@Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @UnifiedTEX
	@PLP @Filter @TEX @BasicFilterFlows @P2
	@tms:UTR-15587
	Scenario Outline: Unified PLP Filters - Verify checkbox filter can be applied on PLP
		Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
		When I am on locale <locale> of url #categoryUrl with forced accepted cookies
			And I wait until the current page is loaded
			And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
		Then in unified filter panel I see filter type <filterType> with filter <filterOption> is active
			And I see Experience.PlpHeader.PageHeader is displayed
			And I see Experience.PlpHeader.ProductCount is displayed
			And the count of elements Experience.PlpProducts.ListingItems is greater than 1
			And the numeric value of Experience.PlpHeader.ProductCount is greater than 1
			And I see the count of Experience.PlpProducts.ProductsPrice is the same as the count of Experience.PlpProducts.ListingItems
			And I see the count of Experience.PlpProducts.ProductTitles is the same as the count of Experience.PlpProducts.ListingItems

		@ExcludeTH
		Examples:
			| locale | categoryId                 | filterType | filterOption |
			| uk     | men_clothes_jeans          | Size       | W30          |
			| uk     | kids_boys_clothes_t-shirts | Colour     | Blue         |
			| uk     | men_bestsellers            | Colour     | Black        |

		@ExcludeCK
		Examples:
			| locale | categoryId                       | filterType | filterOption |
			| uk     | th_women_clothing_jeans          | Size       | W30          |
			| uk     | th_kids_boys_sweatshirts&hoodies | Size       | M            |
			| uk     | th_women_collections             | Colour     | Blue         |

	@FullRegression
	@Desktop
	@Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @UnifiedTEX
	@PLP @Filter @TEX @BasicFilterFlows
	@tms:UTR-15588 @P1
	Scenario Outline: Unified PLP Filters Desktop - Product counter is updated and shows correct number of results after applying filter on PLP
		Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
		When I am on locale <locale> of url #categoryUrl with forced accepted cookies
			And I wait until the current page is loaded
			And I store the numeric value of Experience.PlpHeader.ProductCount with key #productCount
			And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
			And in unified filter panel I wait until filter type <filterType> with filter <filterOption> is active
			And I wait for 2 seconds
		Then the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #productCount
			And I store the numeric value of Experience.PlpHeader.ProductCount with key #productCount
		Then the count of elements Experience.PlpProducts.ListingItems is equal to #productCount

		@ExcludeTH
		Examples:
			| locale  | categoryId             | filterType | filterOption |
			| default | women_clothes_t-shirts | Colour     | Red          |

		@ExcludeCK
		Examples:
			| locale  | categoryId                   | filterType | filterOption |
			| default | TH_MEN_CLOTHING_COATSJACKETS | Colour     | Red          |

	@FullRegression
	@Mobile
	@Chrome @Safari @UnifiedPLP @UnifiedExperience @UnifiedTEX
	@PLP @Filter @TEX @BasicFilterFlows @P1
	@tms:UTR-15589
	Scenario Outline: Unified PLP Filters Mobile - Product counter is updated in mobile filter panel after applying filter on PLP
		Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
		When I am on locale <locale> of url #categoryUrl with forced accepted cookies
			And I wait until the current page is loaded
			And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option and panel stays open
			And I wait until Experience.PlpFilters.ApplyFilterButton is displayed in 10 seconds
			And I store the numeric value of Experience.PlpFilters.ApplyFilterButton with key #productCount
			And in unified PLP I ensure filter panel is closed
		Then the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #productCount
			And I store the numeric value of Experience.PlpHeader.ProductCount with key #productCount
		Then the count of elements Experience.PlpProducts.ListingItems is equal to #productCount

		@ExcludeTH
		Examples:
			| locale  | categoryId             | filterType | filterOption |
			| default | women_clothes_t-shirts | Colour     | Red          |

		@ExcludeCK
		Examples:
			| locale  | categoryId              | filterType | filterOption |
			| default | th_women_clothing_jeans | Size       | M            |

	@FullRegression
	@Desktop @Mobile @UnifiedPLP @UnifiedExperience
	@Chrome @FireFox @Safari @UnifiedTEX
	@PLP @Filter @TEX @BasicFilterFlows @P2
	@tms:UTR-15590
	Scenario Outline: Unified PLP Filters - Active filter should be retained when navigate back from PDP to PLP
		Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
		When I am on locale <locale> of url #categoryUrl with forced accepted cookies
			And I wait until the current page is loaded
			And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
			And I click on Experience.PlpProducts.ListingItems with index 1
			And I wait for 10 seconds
			And I wait until the current page is loaded
			And I see the current page is PDP
			And I wait for 10 seconds
			And I navigate back in the browser
			And I wait until the current page is loaded
		Then in unified filter panel I see filter type <filterType> with filter <filterOption> is active

		@ExcludeTH
		Examples:
			| locale | categoryId                 | filterType | filterOption |
			| uk     | women_clothes_t-shirts     | Colour     | Red          |
			| uk     | kids_boys_clothes_t-shirts | Size       | 8            |

		@ExcludeCK
		Examples:
			| locale | categoryId              | filterType | filterOption |
			| uk     | th_women_clothing_jeans | Size       | M            |
			| uk     | th_men_collections      | Size       | M            |

	@FullRegression
	@Desktop
	@Chrome @FireFox @Safari @UnifiedFilter
	@UnifiedPLP @UnifiedExperience @Filter @EESK @BasicFilterFlows @P2
	@tms:UTR-16593
	Scenario Outline: Unified PLP Filters - Active filter should be in the viewport while scrolling down PLP or unified filter panel
		Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
		When I am on locale <locale> of url #categoryUrl with forced accepted cookies
			And I wait until the current page is loaded
			And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
		Then in unified filter panel I see filter type <filterType> with filter <filterOption> is active
		When in unified PLP I scroll down to the <itemIndex> listing item
			And I see Experience.PlpFilters.ActiveFilterLabels is in viewport
		Then I scroll to the element Experience.PlpFilters.OpenedFilterPanel with index last()
			And I see Experience.PlpFilters.ActiveFilterLabels is in viewport

		@ExcludeTH
		Examples:
			| locale | categoryId          | filterType | filterOption | itemIndex |
			| uk     | women_clothes_jeans | FIT        | Skinny       | 40        |

		@ExcludeCK
		Examples:
			| locale | categoryId              | filterType | filterOption | itemIndex |
			| uk     | th_women_clothing_jeans | Size       | W30          | 40        |

	@FullRegression
	@Desktop
	@Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @UnifiedTEX
	@PLP @Filter @TEX @BasicFilterFlows @P2
	@feature:TEX-14672
	@tms:UTR-16997
	Scenario Outline: Unified PLP Filters Desktop - Verify that numbered count are displayed next to filter facets and the value is not 0 with or without active filter
		Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
		When I am on locale <locale> of url #categoryUrl with forced accepted cookies
			And I wait until the current page is loaded
		Then the count of elements Experience.PlpFilters.FilterOptionsCount is greater than 1
			And the count of displayed elements Experience.PlpFilters.FilterOptionWithCountZero is equal to 0
		When in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
		Then in unified filter panel I see filter type <filterType> with filter <filterOption> is active
			And the count of elements Experience.PlpFilters.FilterOptionsCount is greater than 1
			And the count of displayed elements Experience.PlpFilters.FilterOptionWithCountZero is equal to 0

		@ExcludeCK
		Examples:
			| locale | categoryId                   | filterType | filterOption |
			| uk     | TH_MEN_CLOTHING_COATSJACKETS | Colour     | Red          |

		@ExcludeTH
		Examples:
			| locale | categoryId             | filterType | filterOption |
			| uk     | women_clothes_t-shirts | Colour     | Red          |

	@FullRegression
	@Desktop
	@Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @EESK
	@PLP @Filter @BasicFilterFlows @P2
	@feature:EESK-5030
	@tms:UTR-17455
	Scenario Outline: Unified PLP Filters - Verify 'On Sale' filterand the old price label is displayed with correct translation
		Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
		When I am on locale <locale> of url #categoryUrl with forced accepted cookies
			And I wait until the current page is loaded
		When in unified filter panel I open filter type <filterType>
			And I click on Experience.PlpFilters.OnSalePriceFilter
		Then I see Experience.PlpFilters.ActiveFilterLabels with text <text> is displayed
			And I hover over Experience.PlpProducts.ListingItems with index 1
			And I see Experience.PlpProducts.ProductOldPrice with index 1 is displayed
		Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
			And I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
			And I wait until page Experience.PlpProducts is loaded
		When in unified filter panel I open filter type <filterType>
			And I click on Experience.PlpFilters.OnSalePriceFilter
		Then I see Experience.PlpFilters.ActiveFilterLabels with text <text> is displayed
			And I hover over Experience.PlpProducts.ListingItems with index 1
			And I see Experience.PlpProducts.ProductOldPrice with index 1 is displayed

		@ExcludeTH
		Examples:
			| locale | langCode | categoryId                        | filterType | text    |
			| de     | EN       | kids_boys_clothes_trousers&shorts | Price      | ON SALE |
			| nl     | EN       | kids_boys_clothes_trousers&shorts | Price      | ON SALE |

		@ExcludeCK
		Examples:
			| locale | langCode | categoryId               | filterType | text    |
			| fr     | default  | th_men_clothing_t-shirts | Price      | ON SALE |

	@FullRegression
	@Mobile
	@Chrome @FireFox @Lokalise @Translation
	@UnifiedPLP @UnifiedExperience @UnifiedTEX @P2
	@feature:TEX-14611 @issue:EESK-5477
	@tms:UTR-18243
	Scenario Outline: Unified PLP Mobile - Verify translation of Close/Reset/All Results CTAs
		Given I am on category <categoryId> page of locale <locale> of langCode <langCode> with accepted cookies
			And I get translation from lokalise for "PLPFilterResetAll" and store it with key #PLPFilterResetAllText
			And I get translation from lokalise for "PLPFilterSeeAll" and store it with key #PLPFilterSeeAllText
			And I get translation from lokalise for "PLPFilterClose" and store it with key #PLPFilterCloseText
			And I wait until page Experience.PlpProducts is loaded
			And in unified filter panel I open filter type <filterType> and panel stays open
		Then I see Experience.PlpFilters.FilterCloseButtonText with text #PLPFilterCloseText is displayed
		When  I click on Experience.PlpFilters.FilterCloseButton
			And I wait for 2 seconds
			And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option and panel stays open
		Then I see Experience.PlpFilters.FilterResetAllText with text #PLPFilterResetAllText is displayed
			And I see Experience.PlpFilters.ApplyFilterButtonText with text #PLPFilterSeeAllText is displayed

		@ExcludeCK
		Examples:
			| locale           | langCode         | categoryId               | filterType | filterOption |
			| multiLangDefault | multiLangDefault | th_men_clothing_t-shirts | Colour     | Red          |

		@ExcludeTH
		Examples:
			| locale | langCode | categoryId             | filterType | filterOption |
			| nl     | EN       | women_clothes_t-shirts | Colour     | Red          |
