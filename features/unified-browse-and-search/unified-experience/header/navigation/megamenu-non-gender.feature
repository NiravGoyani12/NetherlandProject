Feature: Unified Header - non gender Megamenu

	@FullRegression
	@Desktop
	@Chrome @FireFox @SafariPending @UnifiedExperience @UnifiedMegaMenu @Translation
	@Header @ElementCheck @ContentCheck @MegaMenu @TEX @UnifiedTEX @UnifiedTEX
	@feature:TEX-14834 @ExcludeUat
	@tms:UTR-14852
	Scenario Outline: Unified non gender Mega Menu - Verify that non gender megamenu is displayed till gender is not set.
		Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
			And I wait until the current page is loaded
			And I get translation for "Women" and store it with key #Women
			And I get translation for "Men" and store it with key #Men
			And I get translation for "Kids" and store it with key #Kids
		Then gender cookies should not be set
			And the count of displayed elements Experience.Header.MegaMenuSecondLevelItemNonGender with args #Women is equal to 1
			And the count of displayed elements Experience.Header.MegaMenuSecondLevelItemNonGender with args #Men is equal to 1
			And the count of displayed elements Experience.Header.MegaMenuSecondLevelItemNonGender with args #Kids is equal to 1
		When I navigate to page wlp
			And I wait until the current page is loaded
		Then gender cookies should not be set
			And the count of displayed elements Experience.Header.MegaMenuSecondLevelItemNonGender with args #Women is equal to 1
			And the count of displayed elements Experience.Header.MegaMenuSecondLevelItemNonGender with args #Men is equal to 1
			And the count of displayed elements Experience.Header.MegaMenuSecondLevelItemNonGender with args #Kids is equal to 1
		When I click on Experience.Header.Logo
			And I wait until the current page is loaded
		Then I see the current page is home-page
			And gender cookies should not be set
			And the count of displayed elements Experience.Header.MegaMenuSecondLevelItemNonGender with args #Women is equal to 1
			And the count of displayed elements Experience.Header.MegaMenuSecondLevelItemNonGender with args #Men is equal to 1
			And the count of displayed elements Experience.Header.MegaMenuSecondLevelItemNonGender with args #Kids is equal to 1
			And the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with text #Women is equal to 0
			And the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with text #Men is equal to 0
			And the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with text #Kids is equal to 0
		When In non gender unified Megamenu I navigate to PLP using text with category Women and sub-category Jeans
			And I wait until the current page is loaded
		Then I see the current page is PLP
			And gender cookies should be set
			And cookie PVH_GLP_GENDER_URL should have parameter secure set to true
			And the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with text #Women is equal to 1
			And the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with text #Men is equal to 1
			And the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with text #Kids is equal to 1
			And the count of displayed elements Experience.Header.MegaMenuSecondLevelItemNonGender with args #Men is equal to 0
			And the count of displayed elements Experience.Header.MegaMenuSecondLevelItemNonGender with args #Kids is equal to 0
		When I click on Experience.Header.Logo
			And I wait until the current page is loaded
		Then I see the current page is GLP
			And gender cookies should be set
			And cookie PVH_GLP_GENDER_URL should have parameter secure set to true
			And the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with text #Women is equal to 1
			And the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with text #Men is equal to 1
			And the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with text #Kids is equal to 1
			And the count of displayed elements Experience.Header.MegaMenuSecondLevelItemNonGender with args #Men is equal to 0
			And the count of displayed elements Experience.Header.MegaMenuSecondLevelItemNonGender with args #Kids is equal to 0
		When I navigate to page wlp
			And I wait until the current page is loaded
		Then gender cookies should be set
			And cookie PVH_GLP_GENDER_URL should have parameter secure set to true

		@P1
		Examples:
			| locale | langCode |
			| ee     | default  |

		@P1 @EngTranslation
		Examples:
			| locale | langCode |
			| de     | EN       |

