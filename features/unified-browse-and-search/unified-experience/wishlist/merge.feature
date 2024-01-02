Feature: Unified wishlist - Merge

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @WLP @UnifiedExperience
  @PDP @TEE @UnifiedPdp @UnifiedExperience @WLP @MergeWishList @P2
  @tms:UTR-13222
  Scenario Outline: Unified wishlist - Guest wish list can be merged into logged in user's wish list when wish list item less then 10
    Given There is 1 account
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I sign up with email user1#email and password user1#password
      And There are 2 normal size product style of locale <locale> and langCode <langCode> with inventory between 100 and 99999
      And I am on locale <locale> wish list page of langCode <langCode> for product style product1#styleColourPartNumber
      And I wait until Experience.Header.ActiveWishListIcon is displayed
      And I navigate to page glp
      And I sign out
      And I wait until the current page is loaded
      And I am on locale <locale> wish list page of langCode <langCode> for product style product2#styleColourPartNumber
      And I wait until Experience.Header.ActiveWishListIcon is displayed
      And I navigate to page glp
      And I wait until the current page is loaded
      And I sign in with email user1#email and password user1#password
      And I wait for 3 seconds
      And I navigate to page wlp
    Then the count of elements Experience.Wishlist.ListingItems is equal to 2 in 10 seconds
      And I see Experience.Wishlist.LoadMoreButton is not displayed in 1 second
      And I see Experience.Wishlist.WishListItemPrice with args product1#styleColourPartNumber is displayed
      And I see Experience.Wishlist.WishListItemPrice with args product2#styleColourPartNumber is displayed

    Examples:
      | locale | langCode |
      | ee     | default  |
