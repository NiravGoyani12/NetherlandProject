Feature: Unified Header - Megamenu Espot Basic

	@FullRegression
	@Desktop @UnifiedMegaMenu
	@Chrome @FireFox @Safari
	@Header @Cookies @MegaMenu @TEX @UnifiedTEX
	@feature:TEX-12859,CONTEMP-830
	@tms:UTR-15131
	#Espots are configured in WOMEN 1st category according to CONTEMP-830
	Scenario Outline: Unified Mega Menu Espot - Verify user is able to see 3 content e-spots in megamenu and ensure lazy loading attribute for image
		Given I am on locale <locale> women glp page of langCode default with accepted cookies
			And I ensure unified mega menu is interactable
		Then the count of displayed elements Experience.Header.MegaMenuFirstLevelItems is equal to 3
			And I wait for 2 seconds
		When In unified Megamenu I hover on category using index 3
		Then the count of displayed elements Experience.Header.EspotImage is equal to 3
			And the count of displayed elements Experience.Header.EspotTitle is equal to 3
			And I see the attribute loading of element Experience.Header.EspotImage containing "lazy"

		Examples:
			| locale  |
			| default |