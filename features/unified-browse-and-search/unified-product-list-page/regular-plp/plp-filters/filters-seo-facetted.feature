Feature: Unified PLP Filters - SEO facetted filters

	#Test is depedant on SEO team uploading file to WCS for SEO facetted filters. Test might fail after datacopy back in future
	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience @P2
	@PLP @Filter @TEX @SEOFacettedFilter
	@tms:UTR-16238
	@feature:TEX-14987,TEX-15705 @issue:TEX-15732
	Scenario Outline: Unified PLP SEO facetted Filters - Verify that the category title is updated when user selects SEO facetted filter
		Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
		When I am on locale <locale> of url #categoryUrl with forced accepted cookies
			And I wait until the current page is loaded
			And I store the value of Experience.PlpHeader.PageHeader with key #initialHeaderText
			And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option faceted
			And I wait until the current page is loaded
			And I store the value of Experience.PlpHeader.PageHeader with key #FilteredHeaderText
		Then the value of Experience.PlpHeader.PageHeader should not be equal to the stored value with key #initialHeaderText
			And I see Experience.PlpHeader.PageHeader contains text "<filterOption>"
			And URL should contain "<filterOption>"

		@ExcludeCK
		Examples:
			| locale | filterType | filterOption | categoryId              |
			| uk     | Colour     | Black        | th_women_clothing_jeans |

		@ExcludeTH @ExcludeUat
		Examples:
			| locale | filterType | filterOption | categoryId             |
			| uk     | Colour     | Blue         | women_clothes_t-shirts |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience
	@PLP @Filter @TEX @SEOFacettedFilter @P2
	@tms:UTR-16291
	@feature:TEX-14920,TEX-15705
	Scenario Outline: Unified SEO facetted PLP Filters - Verify that the user is redirected to correct filtered page when products are available for valid colour in SEO facetted filter
		Given I am on locale <locale> of url <plpUrl> with forced accepted cookies
			And I wait until the current page is loaded
		Then I see the current page is PLP
		When I am on locale <locale> of url <plpUrl><filterUrl>
			And I wait until the current page is loaded
		Then I see the current page is PLP
			And I see BasePage.ErrorPage is not displayed
			And URL should contain "<plpUrl><filterUrl>"

		@ExcludeCK
		Examples:
			| locale | filterType | filterOption | categoryId              | plpUrl        | filterUrl |
			| uk     | Colour     | Black        | th_women_clothing_jeans | /womens-jeans | /c/black  |

		@ExcludeTH @ExcludeUat
		Examples:
			| locale | filterType | filterOption | categoryId             | plpUrl           | filterUrl |
			| uk     | Colour     | Black        | women_clothes_t-shirts | /womens-t-shirts | /c/black  |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience
	@PLP @Filter @TEX @SEOFacettedFilter @P3
	@tms:UTR-16292
	@feature:TEX-14920,TEX-15705
	Scenario Outline: Unified SEO facetted PLP Filters - Verify that the user is redirected to 404 oops page when there is a typo in the color SEO filter url
		Given I am on locale <locale> of url <plpUrl> with forced accepted cookies
			And I wait until the current page is loaded
		Then I see the current page is PLP
		When I am on locale <locale> of url <plpUrl><filterUrl>
			And I wait until the current page is loaded
		Then I see BasePage.ErrorPage is displayed

		@ExcludeCK
		Examples:
			| locale | filterType | filterOption | categoryId              | plpUrl        | filterUrl |
			| uk     | Colour     | Black        | th_women_clothing_jeans | /womens-jeans | /c/bck    |

		@ExcludeTH @ExcludeUat
		Examples:
			| locale | filterType | filterOption | categoryId             | plpUrl           | filterUrl |
			| uk     | Colour     | Black        | women_clothes_t-shirts | /womens-t-shirts | /c/bck    |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience
	@PLP @Filter @TEX @SEOFacettedFilter @P2
	@tms:UTR-16293
	@feature:TEX-14920,TEX-15705
	Scenario Outline: Unified SEO facetted PLP Filters - Verify that the user is redirected to parent category when no product is available for valid colour in SEO facetted filter
		Given I am on locale <locale> of url <plpUrl> with forced accepted cookies
			And I wait until the current page is loaded
		Then I see the current page is PLP
		When I am on locale <locale> of url <plpUrl><filterUrl>
			And I wait until the current page is loaded
		Then I see the current page is PLP
			And I see BasePage.ErrorPage is not displayed
			And URL should contain "<plpUrl>"
			And URL should not contain "<filterUrl>"

		#Purple colour is valid seo colour but no products available
		@ExcludeCK
		Examples:
			| locale | filterType | filterOption | categoryId              | plpUrl        | filterUrl |
			| uk     | Colour     | Black        | th_women_clothing_jeans | /womens-jeans | /c/purple |

		#Silver colour is valid seo colour but no products available
		@ExcludeTH @ExcludeUat
		Examples:
			| locale | filterType | filterOption | categoryId             | plpUrl           | filterUrl |
			| uk     | Colour     | Black        | women_clothes_t-shirts | /womens-t-shirts | /c/silver |

	@FullRegression
	@Desktop @Mobile
	@Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience
	@PLP @Filter @TEX @SEOFacettedFilter @P2
	@tms:UTR-16294
	@feature:TEX-14920,TEX-15705
	Scenario Outline: Unified SEO facetted PLP Filters - Verify that the user is redirected to parent category when SEO facetted filter is disabled but colour is valid
		Given I am on locale <locale> of url <plpUrl> with forced accepted cookies
			And I wait until the current page is loaded
		Then I see the current page is PLP
		When I am on locale <locale> of url <plpUrl><filterUrl>
			And I wait until the current page is loaded
		Then I see the current page is PLP
			And I see BasePage.ErrorPage is not displayed
			And URL should contain "<plpUrl>"
			And URL should not contain "<filterUrl>"

		#Black is a valid colour but SEO facet is disabled on casual shoes
		@ExcludeCK
		Examples:
			| locale | filterType | filterOption | plpUrl             | filterUrl |
			| uk     | Colour     | Black        | /mens-casual-shoes | /c/black  |

		#Black is a valid colour but SEO facet is disabled on women knitwear
		@ExcludeTH
		Examples:
			| locale | filterType | filterOption | plpUrl           | filterUrl |
			| uk     | Colour     | Black        | /womens-knitwear | /c/black  |