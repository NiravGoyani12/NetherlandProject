Feature: Unified Search PLP Filters -  Filters State

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @SafariPending @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP
	@PLP @Filter @TEX @P1 @FilterState
	@tms:UTR-16041
	Scenario Outline: Unified Search PLP Filters State - Validate expanding and collapsing of a filter works on PLP
		Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
			And I wait until page Experience.PlpProducts is loaded
			And I wait until the current page is loaded
			And in unified filter panel I open filter type Colour
			And in unified filter panel I open filter type Price
		Then I see the attribute aria-expanded of element Experience.PlpFilters.FilterContainer with value COLOUR containing "true"
			And I see the attribute aria-expanded of element Experience.PlpFilters.FilterContainer with value PRICE containing "true"
		When in unified filter panel I close filter type Colour
			And in unified filter panel I close filter type Price
			And I wait for 10 seconds
		Then I see the attribute aria-expanded of element Experience.PlpFilters.FilterContainer with value COLOUR containing "false"
			And I see the attribute aria-expanded of element Experience.PlpFilters.FilterContainer with value PRICE containing "false"

		Examples:
			| locale  | langCode |
			| default | default  |

	@FullRegression
	@Desktop
	@Chrome @FireFox @SafariPending @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP
	@PLP @Filter @TEX @P2 @FilterState
	@tms:UTR-16042
	Scenario Outline: Unified Search PLP Filters State Desktop - Active filter shows multiple selected options in collapsed state on PLP
		Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
			And I wait until page Experience.PlpProducts is loaded
			And I wait until the current page is loaded
			And in unified filter panel I open filter type <filterType> and select <filterOption1> as filter option
			And in unified filter panel I wait until filter type <filterType> with filter <filterOption1> is active
			And in unified filter panel I open filter type <filterType> and select <filterOption2> as filter option
			And in unified filter panel I wait until filter type <filterType> with filter <filterOption2> is active
			And in unified filter panel I close filter type <filterType>
		Then in unified filter panel I see filter type <filterType> with collapsed facet <filterOption1> is active
			And in unified filter panel I see filter type <filterType> with collapsed facet <filterOption2> is active

		Examples:
			| locale  | langCode | filterType | filterOption1 | filterOption2 |
			| default | default  | Colour     | Red           | Blue          |

	@FullRegression
	@Mobile
	@Chrome @FireFox @SafariPending @UnifiedPLP @UnifiedExperience @UnifiedSearchPLP
	@PLP @Filter @TEX @P2 @FilterState
	@tms:UTR-16043
	Scenario Outline: Unified Search PLP Filters State Mobile - Active filter shows multiple selected options in collapsed state on PLP
		Given I am on locale <locale> search page of langCode <langCode> with search term "jeans" with accepted cookies
			And I wait until page Experience.PlpProducts is loaded
			And I wait until the current page is loaded
			And in unified filter panel I open filter type <filterType> and select <filterOption1> as filter option
			And in unified filter panel I open filter type <filterType> and select <filterOption2> as filter option
			And in unified filter panel I close filter type <filterType>
		Then in unified filter panel I see filter type <filterType> with collapsed facet <filterOption1> is active
			And in unified filter panel I close filter type <filterType>
			And in unified filter panel I see filter type <filterType> with collapsed facet <filterOption2> is active

		Examples:
			| locale  | langCode | filterType | filterOption1 | filterOption2 |
			| default | default  | Colour     | Red           | Black         |
