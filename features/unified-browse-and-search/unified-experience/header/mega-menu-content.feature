Feature: Unified Header - Megamenu

	@FullRegression
	@Desktop
	@Chrome @FireFox @Safari @UnifiedExperience @UnifiedMegaMenu @Translation
	@Header @ElementCheck @ContentCheck @MegaMenu @TEX @UnifiedTEX @issue:CET1-4885
	@tms:UTR-13365
	Scenario Outline: Unified Mega Menu - Validate each Desktop Megamenu top category has 2nd level categories with links
		Given I am on locale <locale> women glp page of langCode default with accepted cookies
			And I navigate to page <page>
			And I wait until the current page is loaded
			And I get translation for "Women" and store it with key #Women
			And I get translation for "Men" and store it with key #Men
			And I get translation for "Kids" and store it with key #Kids
		Then the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with args #Women is greater than 0
			And in unified megamenu every second level category has content
		When in unified megamenu I select 1st level item with index 2
			And I navigate to page <page>
			And I wait until the current page is loaded
		Then the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with args #Men is greater than 0
			And in unified megamenu every second level category has content
		When in unified megamenu I select 1st level item with index 3
			And I navigate to page <page>
			And I wait until the current page is loaded
		Then the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with args #Kids is greater than 0
			And in unified megamenu every second level category has content

		@P2
		Examples:
			| locale  | page         |
			| default | shopping-bag |

		@issue:TEX-16256
		Examples:
			| locale           | page |
			| multiLangDefault | wlp  |

		@UnifiedPdp @UnifiedExperience @issue:TEX-16256
		Examples:
			| locale  | page |
			| default | pdp  |

	@FullRegression
	@Mobile
	@Chrome @FireFox @Safari @UnifiedExperience @UnifiedMegaMenu
	@Header @ElementCheck @ContentCheck @MegaMenu @TEX @Translation
	@tms:UTR-13366
	Scenario Outline: Unified Mega Menu - Validate each Mobile Megamenu top category has 2nd level categories with links
		Given I am on locale <locale> women glp page of langCode default with accepted cookies
			And I navigate to page <page>
			And I get translation for "Women" and store it with key #Women
			And I get translation for "Men" and store it with key #Men
			And I get translation for "Kids" and store it with key #Kids
		When I ensure unified mega menu is interactable
		Then the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with args #Women is greater than 0
			And in unified megamenu every second level category has content
		When in unified megamenu I select 1st level item with index 2
			And I wait for 2 seconds
		Then the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with args #Men is greater than 0
			And in unified megamenu every second level category has content
		When in unified megamenu I select 1st level item with index 3
			And I wait for 2 seconds
		Then the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with args #Kids is greater than 0
			And in unified megamenu every second level category has content

		@P2
		Examples:
			| locale  | page |
			| default | wlp  |

		Examples:
			| locale           | page          |
			| multiLangDefault | pdp           |
			| default          | store-locator |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @Safari @UnifiedExperience
	@Header @Cookies @MegaMenu @TEX @UnifiedTEX @UnifiedMegaMenu
	@tms:UTR-13367 @issue:TEX-16256
	Scenario Outline: Unified Mega Menu - Validate Megamenu includes 3 top categories across pages
		Given I am on locale <locale> glp page with accepted cookies
			And I navigate to page <page>
		When I ensure unified mega menu is interactable
		Then the count of displayed elements Experience.Header.MegaMenuFirstLevelItems is equal to 3
			And I navigate to page pdp
		When I ensure unified mega menu is interactable
			And I wait until Experience.Header.MegaMenuFirstLevelItems with index 1 is in viewport
		Then the count of displayed elements Experience.Header.MegaMenuFirstLevelItems is equal to 3
			And I navigate to page shopping-bag
		When I ensure unified mega menu is interactable
			And I wait until Experience.Header.MegaMenuFirstLevelItems with index 1 is in viewport
		Then the count of displayed elements Experience.Header.MegaMenuFirstLevelItems is equal to 3

		@P2
		Examples:
			| locale  | page         |
			| default | shopping-bag |

		Examples:
			| locale           | page |
			| multiLangDefault | wlp  |

		Examples:
			| locale           | page |
			| multiLangDefault | pdp  |

	@FullRegression
	@Mobile
	@Chrome @FireFox @Safari @UnifiedExperience
	@Header @MegaMenu @TEX @UnifiedTEX @UnifiedMegaMenu
	@tms:UTR-13368
	Scenario Outline: Unified Mega Menu - Ensure that the overlay and logo is displayed
		Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
			And I navigate to page <page>
			And I ensure unified mega menu is interactable
		Then I see Experience.Header.MegaMenuOverlay is displayed
			And I see Experience.Header.MegaMenuOverlayLogo is displayed
			And in unified megamenu I select 1st level item with index 2
		When I ensure unified mega menu is interactable
		Then I see Experience.Header.MegaMenuOverlay is displayed
			And I see Experience.Header.MegaMenuOverlayLogo is displayed
			And in unified megamenu I select 1st level item with index 3
			And I ensure unified mega menu is interactable
		Then I see Experience.Header.MegaMenuOverlay is displayed
			And I see Experience.Header.Logo is displayed

		@P2
		Examples:
			| locale  | langCode | page         |
			| default | default  | shopping-bag |

		Examples:
			| locale           | langCode | page |
			| multiLangDefault | default  | wlp  |

		Examples:
			| locale           | langCode | page |
			| multiLangDefault | default  | pdp  |

	@FullRegression
	@Desktop
	@Chrome @FireFox @Safari @UnifiedExperience @UnifiedMegaMenu @UnifiedPdp @UnifiedExperience @Translation
	@Header @ElementCheck @ContentCheck @MegaMenu @TEX @UnifiedTEX @ExcludeCK @P2 @feature:TEX-14881
	@tms:UTR-13393
	Scenario Outline: Unified Mega Menu - Validate Desktop Megamenu top category has top 3 categories and 2nd level categories with links when navigating from PLP to PDP
		Given I am on locale <locale> women glp page with forced accepted cookies
			And I navigate to page <page>
			And I get translation for "Women" and store it with key #Women
			And I get translation for "Men" and store it with key #Men
			And I get translation for "Kids" and store it with key #Kids
			And I wait until the current page is loaded
		When I click on Experience.PlpProducts.ListingItems with index 3
			And I wait until the current page is loaded
			And I ensure unified mega menu is interactable
		Then the count of displayed elements Experience.Header.MegaMenuFirstLevelItems is equal to 3
			And the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with args #Women is greater than 0
			And in unified megamenu every second level category has content
		When in unified megamenu I select 1st level item with index 2
			And I navigate to page <page>
			And I wait until the current page is loaded
			And I click on Experience.PlpProducts.ListingItems with index 3
			And I wait until the current page is loaded
			And I ensure unified mega menu is interactable
		Then the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with args #Men is greater than 0
			And in unified megamenu every second level category has content
		When in unified megamenu I select 1st level item with index 3
			And I navigate to page <page>
			And I wait for 2 seconds
		Then the count of displayed elements Experience.Header.MegaMenuFirstLevelItemsByText with args #Kids is greater than 0
			And in unified megamenu every second level category has content

		@issue:TEX-16256
		Examples:
			| locale  | page       |
			| default | search-plp |

		Examples:
			| locale           | page |
			| multiLangDefault | plp  |

	@FullRegression
	@Desktop @Mobile @UnifiedMegaMenu
	@Chrome @FireFox @SafariPending @UnifiedExperience
	@Header @Cookies @MegaMenu @TEX @UnifiedTEX
	@tms:UTR-13505
	Scenario Outline: Unified Mega Menu - Verify user is able to navigate to PLP via megamenu second and third level categories
		Given I am on locale <locale> women glp page of langCode <langCode> with forced accepted cookies
		When I navigate to page <page>
			And I wait until the current page is loaded
			And I ensure unified mega menu is interactable
		Then the count of displayed elements Experience.Header.MegaMenuFirstLevelItems is equal to 3
		When In unified Megamenu I navigate to PLP using index with category 4 and sub-category 2
			And I wait until the current page is loaded
		Then I see the current page is PLP
			And the count of elements Experience.PlpProducts.ListingItems is greater than 1
			And the numeric value of Experience.PlpHeader.ProductCount is greater than 1
			And I see the count of Experience.PlpProducts.ProductsPrice is the same as the count of Experience.PlpProducts.ListingItems
			And I see the count of Experience.PlpProducts.ProductTitles is the same as the count of Experience.PlpProducts.ListingItems

		@P1
		Examples:
			| locale  | langCode | page |
			| default | default  | glp  |

		@P2
		Examples:
			| locale           | langCode         | page         |
			| multiLangDefault | default          | plp          |
			| multiLangDefault | multiLangDefault | shopping-bag |