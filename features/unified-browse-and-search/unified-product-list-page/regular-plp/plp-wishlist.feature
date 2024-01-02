Feature:  Unified PLP - Wishlist

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedWishlist @UnifiedPLP @UnifiedExperience @EESK @P2
  @tms:UTR-15895
  Scenario Outline: WishList On Unified PLP - Verify inactive wishlist icons are present on PLP items
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I am a <userType> user
      And I store the number of elements Experience.PlpProducts.ListingItems with key #itemCount
      And I wait until page Experience.PlpProducts is loaded
      And I hover over Experience.PlpProducts.ListingItems with index <itemIndex>
    When the count of elements Experience.PlpProducts.WishListIcon is equal to #itemCount
      And the count of elements Experience.PlpProducts.ActiveWishListIcon is equal to 0 in 2 seconds

    @ExcludeTH
    Examples:
      | locale | itemIndex | userType  | categoryId             |
      | uk     | 1         | logged in | women_clothes_t-shirts |

    @ExcludeCK
    Examples:
      | locale | itemIndex | userType  | categoryId              |
      | uk     | 1         | logged in | th_women_clothing_jeans |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedWishlist @UnifiedPLP @UnifiedExperience @PlpPagination @EESK @P2
  @tms:UTR-15896
  Scenario Outline: WishList On Unified PLP - Verify saved items remain saved on the next visit
    Given I am on category <categoryId> page of locale <locale> with forced accepted cookies
      And I am a <userType> user
      And I wait until page Experience.PlpProducts is loaded
      And in unified PLP I click next page button 2 times
    When I hover over Experience.PlpProducts.ListingItems with index <itemIndex>
      And I click on Experience.PlpProducts.WishListIcon with index <itemIndex>
      And in header I wait until unified wishlist is active
      And I click on Experience.PlpProducts.ListingItems with index <itemIndex>
      And I wait until ProductDetailPage.Pdp.Content is displayed
      And I see ProductDetailPage.Pdp.ActiveWishListIcon is displayed in 10 seconds
      And I open a new browser tab
      And I switch to 2nd browser tab
      And I am on locale <locale> home page
    When I am on category <categoryId> page of locale <locale>
      And I wait until page Experience.PlpProducts is loaded
      And in unified PLP I click next page button 2 times
    When I hover over Experience.PlpProducts.ListingItems with index <itemIndex>
      And the count of elements Experience.PlpProducts.ActiveWishListIcon is equal to 1 in 5 seconds

    @ExcludeTH
    Examples:
      | locale | itemIndex | userType  | categoryId             |
      | uk     | 1         | logged in | women_clothes_t-shirts |

    @ExcludeCK
    Examples:
      | locale | itemIndex | userType  | categoryId              |
      | uk     | 1         | logged in | th_women_clothing_jeans |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedWishlist @UnifiedPLP @UnifiedExperience @PlpPagination @EESK @P2
  @tms:UTR-15897
  Scenario Outline: WishList On Unified PLP - Unsaving item from wishlist on PLP
    Given I am on category <categoryId> page of locale <locale> with forced accepted cookies
      And I am a <userType> user
      And I wait until page Experience.PlpProducts is loaded
    When in unified PLP I click next page button 2 times
      And I hover over Experience.PlpProducts.ListingItems with index <itemIndex>
      And I click on Experience.PlpProducts.WishListIcon with index <itemIndex>
    Then in header I wait until unified wishlist is active in 10 seconds
      And I click on Experience.PlpProducts.WishListIcon with index <itemIndex>
      And in header I wait until unified wishlist is not active in 10 seconds
      And the count of elements Experience.PlpProducts.ActiveWishListIcon is equal to 0 in 5 seconds

    @ExcludeTH
    Examples:
      | locale | itemIndex | userType | categoryId             |
      | uk     | last()    | guest    | women_clothes_t-shirts |

    @ExcludeCK
    Examples:
      | locale | itemIndex | userType | categoryId              |
      | uk     | last()    | guest    | th_women_clothing_jeans |