Feature: Unified Search PLP - Wishlist

  @FullRegression
  @SearchPLP
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedWishlist @UnifiedPLP @UnifiedExperience @EESK @P2
  @tms:UTR-15734
  Scenario Outline: WishList On Unified Search PLP - Verify inactive wishlist icons are present on Search PLP items
    Given I am on locale <locale> home page with forced accepted cookies
      And I am a <userType> user
      And I navigate to page <page>
      And I wait until page Experience.PlpProducts is loaded
      And in unified PLP I click next page button 3 times
    When I hover over Experience.PlpProducts.ListingItems with index <itemIndex>
    Then I see the count of Experience.PlpProducts.WishListIcon is the same as the count of Experience.PlpProducts.ListingItems
      And the count of elements Experience.PlpProducts.ActiveWishListIcon is equal to 0 in 2 seconds

    Examples:
      | locale | page       | itemIndex | userType |
      | uk     | search-plp | last()    | guest    |

  @FullRegression
  @SearchPLP
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedWishlist @UnifiedPLP @UnifiedExperience @EESK @P2
  @tms:UTR-15735
  Scenario Outline: WishList On Unified Search PLP - Verify saved items remain saved on the next visit
    Given I am on locale <locale> home page with forced accepted cookies
      And I am a <userType> user
      And I navigate to page <page>
      And I store the numeric value of Experience.PlpProducts.ListingItems with key #productCount
      And I hover over Experience.PlpProducts.ListingItems with index <itemIndex>
      And I click on Experience.PlpProducts.WishListIcon with index <itemIndex>
      And in header I wait until unified wishlist is active in 10 seconds
    When I open a new browser tab
      And I switch to 2nd browser tab
      And I am on locale <locale> home page with forced accepted cookies
      And I navigate to page <page>
      And I hover over Experience.PlpProducts.ListingItems with index <itemIndex>
    Then the count of elements Experience.PlpProducts.ActiveWishListIcon is equal to 1

    @RCTest
    Examples:
      | locale | page       | itemIndex | userType |
      | uk     | search-plp | last()    | guest    |

  @FullRegression
  @SearchPLP
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedWishlist @UnifiedPLP @UnifiedExperience @EESK @P2
  @tms:UTR-15736
  Scenario Outline: WishList On Unified PLP - Unsaving item from wishlist on Search PLP
    Given I am on search <searchTerm> page of locale <locale> with forced accepted cookies
      And I am a <userType> user
      And I wait until page Experience.PlpProducts is loaded
      And in unified PLP I click next page button
      And I hover over Experience.PlpProducts.ListingItems with index <itemIndex>
      And I click on Experience.PlpProducts.WishListIcon with index <itemIndex>
    Then in header I wait until unified wishlist is active in 10 seconds
      And I click on Experience.PlpProducts.WishListIcon with index <itemIndex>
    Then in header I wait until unified wishlist is not active in 10 seconds

    Examples:
      | locale | searchTerm | itemIndex | userType  |
      | uk     | shirts     | last()    | logged in |
      | uk     | shirts     | last()    | guest     |
