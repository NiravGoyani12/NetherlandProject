Feature: Unified Search PLP Filters - Basic Flows

	@FullRegression @RCTest
	@Desktop @Mobile
	@Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @UnifiedTEX @UnifiedSearchPLP
	@PLP @Filter @TEX @BasicFilterFlows @P1
	@tms:UTR-16034
	Scenario Outline: Unified Search PLP Filters - Verify checkbox filter can be applied on PLP
		Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
			And I wait until page Experience.PlpProducts is loaded
			And I wait until the current page is loaded
			And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
		Then in unified filter panel I see filter type <filterType> with filter <filterOption> is active
			And I see Experience.PlpHeader.PageHeader is displayed
			And I see Experience.PlpHeader.ProductCount is displayed
			And the count of elements Experience.PlpProducts.ListingItems is greater than 1
			And the numeric value of Experience.PlpHeader.ProductCount is greater than 1
			And I see the count of Experience.PlpProducts.ProductsPrice is the same as the count of Experience.PlpProducts.ListingItems
			And I see the count of Experience.PlpProducts.ProductTitles is the same as the count of Experience.PlpProducts.ListingItems

		Examples:
			| locale  | langCode | filterType | filterOption |
			| default | default  | Colour     | Blue         |

	@FullRegression
	@Desktop @P1
	@Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @UnifiedTEX @UnifiedSearchPLP
	@PLP @Filter @TEX @BasicFilterFlows
	@tms:UTR-16035
	Scenario Outline: Unified Search PLP Filters Desktop - Product counter is updated and shows correct number of results after applying filter on PLP
		Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
			And I wait until page Experience.PlpProducts is loaded
			And I wait until the current page is loaded
			And I store the numeric value of Experience.PlpHeader.ProductCount with key #productCount
			And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
			And in unified filter panel I wait until filter type <filterType> with filter <filterOption> is active
			And I wait for 2 seconds
		Then the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #productCount
			And I store the numeric value of Experience.PlpHeader.ProductCount with key #productCount
		Then the count of elements Experience.PlpProducts.ListingItems is equal to #productCount

		Examples:
			| locale  | langCode | filterType | filterOption |
			| default | default  | Colour     | Red          |

	@FullRegression
	@Mobile
	@Chrome @Safari @UnifiedPLP @UnifiedExperience @UnifiedTEX
	@PLP @Filter @TEX @BasicFilterFlows @P2 @UnifiedSearchPLP
	@tms:UTR-16036
	Scenario Outline: Unified Search PLP Filters Mobile - Product counter is updated in mobile filter panel after applying filter on PLP
		Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
			And I wait until page Experience.PlpProducts is loaded
			And I wait until the current page is loaded
			And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option and panel stays open
			And I wait until Experience.PlpFilters.ApplyFilterButton is displayed in 10 seconds
			And I store the numeric value of Experience.PlpFilters.ApplyFilterButton with key #productCount
			And in unified PLP I ensure filter panel is closed
		Then the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #productCount
			And I store the numeric value of Experience.PlpHeader.ProductCount with key #productCount
		Then the count of elements Experience.PlpProducts.ListingItems is equal to #productCount

		Examples:
			| locale  | langCode | filterType | filterOption |
			| default | default  | Colour     | Red          |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @Safari @UnifiedTEX @UnifiedSearchPLP
	@PLP @Filter @TEX @BasicFilterFlows @P2
	@tms:UTR-16037
	Scenario Outline: Unified Search PLP Filters - Active filter should be retained when navigate back from PDP to PLP
		Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
			And I wait until page Experience.PlpProducts is loaded
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

		Examples:
			| locale  | langCode | filterType | filterOption |
			| default | default  | Colour     | Red          |

	@FullRegression
	@Desktop
	@Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @UnifiedTEX @UnifiedSearchPLP
	@PLP @Filter @TEX @BasicFilterFlows @P3
	@feature:TEX-14721
	@tms:UTR-16315
	Scenario Outline: Unified Search PLP Filters Desktop - Verify that the filter works properly after searching an item with appending special character
		Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
			And I wait until the current page is loaded
			And I click on Experience.Header.UnifiedSearchContainer
		When I type "###Jeans#$%##@#" in the field Experience.Header.UnifiedSearchField
			And I click on Experience.Header.SearchIcon
			And I wait until page Experience.PlpProducts is loaded
			And I store the numeric value of Experience.PlpHeader.ProductCount with key #productCount
			And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
			And in unified filter panel I wait until filter type <filterType> with filter <filterOption> is active
			And I wait for 2 seconds
		Then the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #productCount
			And I store the numeric value of Experience.PlpHeader.ProductCount with key #productCount
			And the count of elements Experience.PlpProducts.ListingItems is equal to #productCount

		Examples:
			| locale  | langCode | filterType | filterOption |
			| default | default  | Colour     | Red          |

	@FullRegression
	@Desktop
	@Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @UnifiedTEX
	@PLP @Filter @TEX @BasicFilterFlows @P2
	@feature:TEX-14672
	@tms:UTR-16998
	Scenario Outline: Unified Search PLP Filters Desktop - Verify that numbered count are displayed next to filter facets and the value is not 0 with or without active filter
		Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
			And I wait until the current page is loaded
		Then the count of elements Experience.PlpFilters.FilterOptionsCount is greater than 1
			And the count of displayed elements Experience.PlpFilters.FilterOptionWithCountZero is equal to 0
		When in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
		Then in unified filter panel I see filter type <filterType> with filter <filterOption> is active
			And the count of elements Experience.PlpFilters.FilterOptionsCount is greater than 1
			And the count of displayed elements Experience.PlpFilters.FilterOptionWithCountZero is equal to 0

		Examples:
			| locale  | langCode | filterType | filterOption |
			| default | default  | Colour     | Red          |

	@FullRegression
	@Mobile
	@Chrome @FireFox @Lokalise @Translation
	@UnifiedPLP @UnifiedExperience @UnifiedTEX @P2
	@feature:TEX-14611 @issue:EESK-5477
	@tms:UTR-18251
	Scenario Outline: Unified Search PLP Mobile - Verify translation of Close/Reset/All Results CTAs
		Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
			And I wait until the current page is loaded
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
			| locale | langCode | filterType | filterOption |
			| de     | EN       | Colour     | Red          |

		@ExcludeTH
		Examples:
			| locale | langCode | filterType | filterOption |
			| nl     | EN       | Colour     | Red          |