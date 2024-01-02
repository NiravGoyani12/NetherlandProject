Feature: Unified Search PLP Filters - Bubble filters

	@FullRegression
	@Desktop
	@Chrome @FireFox @UnifiedTEX
	@PlpPagination @Viewport @UnifiedPLP @UnifiedExperience @TEX @P2
	@feature:TEX-13526
	@tms:UTR-13553
	Scenario Outline: Unified Search PLP Filter - Verify that the Bubble filters are present and filter can be applied on search PLP
		When I am on locale <locale> search page of langCode <langCode> with search term "<searchTerm>" with forced accepted cookies
			And I wait until page Experience.PlpProducts is loaded
		Then I see Experience.PlpFilters.BubbleFilter is displayed
			And I store the numeric value of Experience.PlpHeader.ProductCount with key #OriginalProductCount
			And the count of displayed elements Experience.PlpFilters.BubbleFilter is greater than 0
			And the count of displayed elements Experience.PlpFilters.ActiveFilterLabels is equal to 0
		When I click on Experience.PlpFilters.BubbleFilter with index 1
			And I wait until the current page is loaded
		Then I see Experience.PlpFilters.BubbleFilterSelected with index 1 is displayed in 20 seconds
			And the count of displayed elements Experience.PlpFilters.ActiveFilterLabels is greater than 0
		Then the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #OriginalProductCount

		Examples:
			| locale           | langCode | searchTerm |
			| default          | default  | Jeans      |
			| multiLangDefault | default  | Bag        |

	@FullRegression
	@Mobile
	@Chrome @FireFox @UnifiedTEX
	@PlpPagination @Viewport @UnifiedPLP @UnifiedExperience @TEX @P2
	@feature:TEX-13526
	@tms:UTR-18710
	Scenario Outline: Unified Search PLP Filter - Mobile - Verify that the Bubble filters are present and filter can be applied on search PLP
		When I am on locale <locale> search page of langCode <langCode> with search term "<searchTerm>" with forced accepted cookies
			And I wait until page Experience.PlpProducts is loaded
		Then I see Experience.PlpFilters.BubbleFilter is displayed
			And I store the numeric value of Experience.PlpHeader.ProductCount with key #OriginalProductCount
			And the count of displayed elements Experience.PlpFilters.BubbleFilter is greater than 0
			And the count of displayed elements Experience.PlpFilters.ActiveFilterLabels is equal to 0
		When I click on Experience.PlpFilters.BubbleFilter with index 1
			And I wait until the current page is loaded
		Then I see Experience.PlpFilters.BubbleFilterSelected with index 1 is displayed in 20 seconds
			And the numeric value of Experience.PlpHeader.ProductCount should not be equal to the stored value with key #OriginalProductCount

		Examples:
			| locale           | langCode | searchTerm |
			| default          | default  | Jeans      |
			| multiLangDefault | default  | Bag        |
