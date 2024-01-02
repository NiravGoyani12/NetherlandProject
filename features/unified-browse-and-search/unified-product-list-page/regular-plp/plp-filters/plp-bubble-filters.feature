Feature: Unified PLP Filters - Bubble filters

	@FullRegression
	@Desktop
	@Chrome @FireFox @UnifiedTEX
	@PlpPagination @UnifiedPLP @UnifiedExperience @TEX @P2
	@feature:TEX-13526
	@tms:UTR-17225
	Scenario Outline: Unified PLP Filter - Verify that the Bubble filters are present and filter can be applied on regular PLP
		Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
		When I am on locale <locale> of url #categoryUrl with forced accepted cookies
			And I wait until the current page is loaded
			And I wait until page Experience.PlpProducts is loaded
		Then I see Experience.PlpFilters.BubbleFilter is displayed
			And I store the numeric value of Experience.PlpHeader.ProductCount with key #OriginalProductCount
			And the count of displayed elements Experience.PlpFilters.BubbleFilter is greater than 0
			And the count of displayed elements Experience.PlpFilters.ActiveFilterLabels is equal to 0
		When I click on Experience.PlpFilters.BubbleFilter with index 1
			And I wait until the current page is loaded
		Then I see Experience.PlpFilters.BubbleFilterSelected with index 1 is displayed in 20 seconds
			And the count of displayed elements Experience.PlpFilters.ActiveFilterLabels is greater than 0
			And the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #OriginalProductCount

		@ExcludeTH
		Examples:
			| locale  | langCode | categoryId                                   |
			| default | default  | women_bags&accessories_newinbags&accessories |
			| default | default  | women_bestsellers                            |

		@ExcludeCK
		Examples:
			| locale  | langCode | categoryId              |
			| default | default  | th_women_shoes          |
			| default | default  | th_women_clothing_jeans |

	@FullRegression
	@Mobile
	@Chrome @FireFox @UnifiedTEX
	@PlpPagination @UnifiedPLP @UnifiedExperience @TEX @P2
	@feature:TEX-13526
	@tms:UTR-18519
	Scenario Outline: Unified PLP Filter - Mobile - Verify that the Bubble filters are present and filter can be applied on regular PLP
		Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
		When I am on locale <locale> of url #categoryUrl with forced accepted cookies
			And I wait until the current page is loaded
			And I wait until page Experience.PlpProducts is loaded
		Then I see Experience.PlpFilters.BubbleFilter is displayed
			And I store the numeric value of Experience.PlpHeader.ProductCount with key #OriginalProductCount
			And the count of displayed elements Experience.PlpFilters.BubbleFilter is greater than 0
			And the count of displayed elements Experience.PlpFilters.ActiveFilterLabels is equal to 0
		When I click on Experience.PlpFilters.BubbleFilter with index 1
			And I wait until the current page is loaded
		Then I see Experience.PlpFilters.BubbleFilterSelected with index 1 is displayed in 20 seconds
			And the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #OriginalProductCount

		@ExcludeTH
		Examples:
			| locale  | langCode | categoryId                                   |
			| default | default  | women_bags&accessories_newinbags&accessories |
			| default | default  | women_bestsellers                            |

		@ExcludeCK
		Examples:
			| locale  | langCode | categoryId              |
			| default | default  | th_women_shoes          |
			| default | default  | th_women_clothing_jeans |