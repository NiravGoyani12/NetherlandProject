Feature: Unified PLP Filters -  Filters State

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @SafariPending @UnifiedPLP @UnifiedExperience
	@PLP @Filter @TEX @P1 @FilterState
	@tms:UTR-15740
	Scenario Outline: Unified PLP Filters State - Validate expanding and collapsing of a filter works on PLP
		Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
		When I am on locale <locale> of url #categoryUrl with forced accepted cookies
			And I wait until the current page is loaded
			And in unified filter panel I open filter type Colour
			And in unified filter panel I open filter type Size
		Then I see the attribute aria-expanded of element Experience.PlpFilters.FilterContainer with value COLOUR containing "true"
			And I see the attribute aria-expanded of element Experience.PlpFilters.FilterContainer with value SIZE containing "true"
		When in unified filter panel I close filter type Colour
			And in unified filter panel I close filter type Size
			And I wait for 10 seconds
		Then I see the attribute aria-expanded of element Experience.PlpFilters.FilterContainer with value COLOUR containing "false"
			And I see the attribute aria-expanded of element Experience.PlpFilters.FilterContainer with value SIZE containing "false"

		@ExcludeTH
		Examples:
			| locale | categoryId             |
			| uk     | women_clothes_t-shirts |

		@ExcludeCK
		Examples:
			| locale | categoryId              |
			| uk     | th_women_clothing_jeans |

	@FullRegression
	@Desktop
	@Chrome @FireFox @SafariPending @UnifiedPLP @UnifiedExperience
	@PLP @Filter @TEX @P2 @FilterState
	@tms:UTR-15741
	Scenario Outline: Unified PLP Filters State Desktop - Active filter shows multiple selected options in collapsed state on PLP
		Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
		When I am on locale <locale> of url #categoryUrl with forced accepted cookies
			And I wait until the current page is loaded
			And in unified filter panel I open filter type <filterType> and select <filterOption1> as filter option
			And in unified filter panel I wait until filter type <filterType> with filter <filterOption1> is active
			And in unified filter panel I open filter type <filterType> and select <filterOption2> as filter option
			And in unified filter panel I wait until filter type <filterType> with filter <filterOption2> is active
			And in unified filter panel I close filter type <filterType>
		Then in unified filter panel I see filter type <filterType> with collapsed facet <filterOption1> is active
			And in unified filter panel I see filter type <filterType> with collapsed facet <filterOption2> is active

		@ExcludeTH
		Examples:
			| locale | filterType | filterOption1 | filterOption2 | categoryId                        |
			| uk     | Colour     | Red           | Blue          | women_clothes_t-shirts            |
			| uk     | Colour     | Black         | Blue          | kids_boys_clothes_trousers&shorts |

		@ExcludeCK
		Examples:
			| locale | filterType | filterOption1 | filterOption2 | categoryId                   |
			| uk     | Colour     | Blue          | Black         | TH_MEN_CLOTHING_COATSJACKETS |
			| uk     | Colour     | Blue          | Black         | th_kids_girls_jeans          |

	@FullRegression
	@Mobile
	@Chrome @FireFox @SafariPending @UnifiedPLP @UnifiedExperience
	@PLP @Filter @TEX @P2 @FilterState
	@tms:UTR-15742
	Scenario Outline: Unified PLP Filters State Mobile - Active filter shows multiple selected options in collapsed state on PLP
		Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
		When I am on locale <locale> of url #categoryUrl with forced accepted cookies
			And I wait until the current page is loaded
			And in unified filter panel I open filter type <filterType> and select <filterOption1> as filter option
			And in unified filter panel I open filter type <filterType> and select <filterOption2> as filter option
			And in unified filter panel I close filter type <filterType>
		Then in unified filter panel I see filter type <filterType> with collapsed facet <filterOption1> is active
			And in unified filter panel I close filter type <filterType>
			And in unified filter panel I see filter type <filterType> with collapsed facet <filterOption2> is active

		@ExcludeTH
		Examples:
			| locale | filterType | filterOption1 | filterOption2 | categoryId                        |
			| uk     | Colour     | Red           | Black         | women_clothes_t-shirts            |
			| uk     | Colour     | Blue          | Black         | kids_boys_clothes_trousers&shorts |

		@ExcludeCK
		Examples:
			| locale | filterType | filterOption1 | filterOption2 | categoryId                       |
			| uk     | Colour     | Blue          | Black         | TH_MEN_CLOTHING_COATSJACKETS     |
			| uk     | Colour     | Blue          | Black         | th_kids_boys_sweatshirts&hoodies |
