Feature: Unified Wishlist page - Order and pagination

  # yet to be implemented
  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @LoadMore @P2
  @feature:CET1-3232 @UnifiedExperience
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-5471
  Scenario Outline: Unified Wishlist - Validate items order on unified wishlist page
    Given There are 8 normal size product style of locale <locale> with inventory between 10 and 99999
      And I am on locale <locale> home page with forced accepted cookies
      And I am a logged in user
      And I wait until the current page is loaded
    When I am on locale <locale> wish list page for product style product1#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product2#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product3#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product4#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product5#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product6#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product7#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product8#styleColourPartNumber
    Then I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 1 containing "product8#styleColourPartNumber"
      And I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 2 containing "product7#styleColourPartNumber"
      And I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 3 containing "product6#styleColourPartNumber"
      And I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 4 containing "product5#styleColourPartNumber"
      And I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 5 containing "product4#styleColourPartNumber"
      And I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 6 containing "product3#styleColourPartNumber"
      And I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 7 containing "product2#styleColourPartNumber"
      And I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 8 containing "product1#styleColourPartNumber"

    Examples:
      | locale |
      | ee     |
      | se     |
      | fr     |
      | uk     |
      | es     |
      | pl     |

  # yet to be implemented
  #@FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @UnifiedExperience @P2
  @feature:CET1-3232 @LoadMore
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-5469
  Scenario Outline: Unified Wishlist - Validate items order on unified wishlist after removing a product from the wishlist
    Given There are 4 normal size product style of locale <locale> with inventory between 100 and 9999
      And I am on locale <locale> home page with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
    When I am on locale <locale> wish list page for product style product1#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product2#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product3#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product4#styleColourPartNumber
      And I click on Experience.Wishlist.ProductTileDeleteButton with index <itemToRemove>
      And I wait until the count of displayed elements Experience.Wishlist.ListingItems is equal to 3
    Then I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 1 containing "<product1>#styleColourPartNumber"
      And I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 2 containing "<product2>#styleColourPartNumber"
      And I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 3 containing "<product3>#styleColourPartNumber"

    Examples:
      | locale | userType  | itemToRemove | product1 | product2 | product3 |
      | ee     | logged in | 1            | product3 | product2 | product1 |
      | ee     | guest     | 2            | product4 | product2 | product1 |

  # yet to be implemented
  #@FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @feature:CET1-3232 @LoadMore
  @WLP @AddToBag @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience @P2
  @tms:UTR-5475
  Scenario Outline: Unified Wishlist - Validate items order on wishlist after adding product to shopping bag
    Given There are 8 normal size product style of locale <locale> with inventory between 100 and 9999
      And I am on locale <locale> home page with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
    When I am on locale <locale> wish list page for product style product1#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product2#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product3#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product4#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product5#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product6#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product7#styleColourPartNumber
      And I am on locale <locale> wish list page for product style product8#styleColourPartNumber
      And I extract a product item from product style product<itemToRemove>#styleColourPartNumber which has inventory saved as #skuPartNumber
    When I fetch size name of product item #skuPartNumber saved as #sizeName
    Then I see Experience.Wishlist.DisabledAddToBagButton is displayed
      And in unified wishlist page I select size based on product item #skuPartNumber
    Then I click on Experience.Wishlist.EnabledAddToBagButton
      And I wait until the count of displayed elements Experience.Wishlist.ListingItems is equal to 8
    Then I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 1 containing "<product1>#styleColourPartNumber"
      And I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 2 containing "<product2>#styleColourPartNumber"
      And I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 3 containing "<product3>#styleColourPartNumber"
      And I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 4 containing "<product4>#styleColourPartNumber"
      And I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 5 containing "<product5>#styleColourPartNumber"
      And I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 6 containing "<product6>#styleColourPartNumber"
      And I see the attribute data-partnumber of element Experience.Wishlist.ListingItems with index 7 containing "<product7>#styleColourPartNumber"

    Examples:
      | locale | userType  | itemToRemove | product1 | product2 | product3 | product4 | product5 | product6 | product7 |
      | ee     | logged in | 5            | product8 | product7 | product6 | product5 | product4 | product3 | product2 |
      | ee     | guest     | 8            | product8 | product7 | product6 | product5 | product4 | product3 | product2 |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @LoadMore
  @feature:CET1-3232 @UnifiedExperience @P2
  @tms:UTR-5472
  Scenario Outline: Unified Wishlist - Load more button is displayed on wishlist page with more than 12 products
    Given I am on locale <locale> wish list page with <productNumber> products with forced accepted cookies
    Then I see Experience.Wishlist.LoadMoreButton is <displayState>

    Examples:
      | locale | productNumber | displayState  |
      | ee     | 12            | not displayed |
      | ee     | 13            | displayed     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @LoadMore
  @feature:CET1-3232 @UnifiedExperience @P2
  @tms:UTR-5474
  Scenario Outline: Unified Wishlist - Clicking Load more button loads next page
    Given I am on locale <locale> wish list page with <productNumber> products with forced accepted cookies
      And in header I wait until unified wishlist is active
      And I wait until the count of displayed elements Experience.Wishlist.ListingItems is equal to 12
    When I click on Experience.Wishlist.LoadMoreButton
      And I wait for 5 seconds
    Then I wait until the count of displayed elements Experience.Wishlist.ListingItems is equal to <loadedProducts>
      And I see Experience.Wishlist.LoadMoreButton is <displayState>

    Examples:
      | locale | productNumber | loadedProducts | displayState  |
      | ee     | 13            | 13             | not displayed |
      | ee     | 25            | 24             | displayed     |
      | uk     | 13            | 13             | not displayed |
      | uk     | 25            | 24             | displayed     |
      | pl     | 13            | 13             | not displayed |
      | pl     | 25            | 24             | displayed     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @LoadMore
  @feature:CET1-3232 @UnifiedExperience @P2
  @tms:UTR-5473
  Scenario Outline: Unified Wishlist - Clicking Load more disappears when only 12 products left on unified wishlist page
    Given I am on locale <locale> wish list page with 13 products with forced accepted cookies
      And in header I wait until unified wishlist is active
      And I wait until Experience.Wishlist.LoadMoreButton is displayed
    When I click on Experience.Wishlist.ProductTileDeleteButton with index 1
      And in header I wait until unified wishlist is active
      And I refresh page
    Then I see Experience.Wishlist.LoadMoreButton is not displayed in 3 seconds
      And I wait until the count of displayed elements Experience.Wishlist.ListingItems is equal to 12

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @LoadMore
  @feature:CET1-3232 @UnifiedExperience @P2
  @tms:UTR-5470
  Scenario Outline: Unified Wishlist - Verify that load more button doesnt appear after deleting the last few items
    Given I am on locale <locale> wish list page with 22 products with forced accepted cookies
      And in header I wait until unified wishlist is active
      And I wait until Experience.Wishlist.LoadMoreButton is displayed
    When I click on Experience.Wishlist.LoadMoreButton
    Then I wait until the count of displayed elements Experience.Wishlist.ListingItems is equal to 22
      And I wait until Experience.Wishlist.LoadMoreButton is not displayed
    When I click on Experience.Wishlist.ProductTileDeleteButton with index 22
    Then I wait until the count of displayed elements Experience.Wishlist.ListingItems is equal to 21
      And I wait until Experience.Wishlist.LoadMoreButton is not displayed
    When I click on Experience.Wishlist.ProductTileDeleteButton with index 21
    Then I wait until the count of displayed elements Experience.Wishlist.ListingItems is equal to 20
      And I wait until Experience.Wishlist.LoadMoreButton is not displayed
    When I click on Experience.Wishlist.ProductTileDeleteButton with index 20
    Then I wait until the count of displayed elements Experience.Wishlist.ListingItems is equal to 19
      And I wait until Experience.Wishlist.LoadMoreButton is not displayed

    Examples:
      | locale           |
      | default          |
      | multiLangDefault |
