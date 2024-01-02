Feature: Unified XO - Add to Wishlist

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedExperience @UnifiedXo @TEX @XO @P2
  @feature:TEX-14873
  @tms:UTR-18013
  Scenario Outline: Unified XO Wishlist - From No search - Verify that user is able to add and remove Recommedations to wishlist using Wishlist icon
    Given I am on locale <locale> search page of langCode <langCode> with search term "nosearchresult" with forced accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I scroll to and click on Experience.Recommendations.XoWishlistIcon with index 1
      And I see Experience.Header.ActiveWishListIcon is displayed
    When I navigate to page wlp
      And I wait until the current page is loaded
    Then I see Experience.Wishlist.ProductTileComponent is displayed
      And I see Experience.Wishlist.EmptyWishlistTitle is not displayed
    When I navigate back in the browser
      And I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I scroll to and click on Experience.Recommendations.XoWishlistIcon with index 1
    Then I see Experience.Header.ActiveWishListIcon is not displayed
    When I navigate to page wlp
      And I wait until the current page is loaded
    Then I see Experience.Wishlist.ProductTileComponent is not displayed
      And I see Experience.Wishlist.EmptyWishlistTitle is displayed

    @ExcludeTH
    Examples:
      | locale  | langCode | xoWidgetId               |
      | default | default  | 63f6063ed8e91ecc2e348bb1 |

    @ExcludeCK
    Examples:
      | locale  | langCode | xoWidgetId               |
      | default | default  | 63b567c9c466f7573189c3ac |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @UnifiedExperience @UnifiedXo @TEX @XO @P2
  @feature:TEX-14873
  @tms:UTR-18014
  Scenario Outline: Unified XO Wishlist - From Shopping Bag - Verify that user is able to add and remove Recommedations to wishlist using Wishlist icon
    Given I am on locale <locale> of url shopping-bag of langCode <langCode> with accepted cookies
      And I force the url with a xo-widget-id <xoWidgetId>
      And I smoothly scroll to the element Experience.Footer.MainBlock
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I scroll to and click on Experience.Recommendations.XoWishlistIcon with index 1
      And I see Experience.Header.ActiveWishListIcon is displayed
    When I navigate to page wlp
      And I wait until the current page is loaded
    Then I see Experience.Wishlist.ProductTileComponent is displayed
      And I see Experience.Wishlist.EmptyWishlistTitle is not displayed
    When I navigate back in the browser
      And I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And I scroll to and click on Experience.Recommendations.XoWishlistIcon with index 1
    Then I see Experience.Header.ActiveWishListIcon is not displayed
    When I navigate to page wlp
      And I wait until the current page is loaded
    Then I see Experience.Wishlist.ProductTileComponent is not displayed
      And I see Experience.Wishlist.EmptyWishlistTitle is displayed

    @ExcludeTH
    Examples:
      | locale  | langCode | xoWidgetId               |
      | default | default  | 63f6063ed8e91ecc2e348bb1 |

    @ExcludeCK
    Examples:
      | locale  | langCode | xoWidgetId               |
      | default | default  | 63b567c9c466f7573189c3ac |