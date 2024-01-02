Feature: Unified PDP - Wishlist

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P1
  @tms:UTR-5114
  Scenario Outline: Wishlist On PDP - Verify wishlist icon is present on PDP
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 200 and 99999 filtered by FH
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I am a logged in user
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.WishListIcon is displayed
      And I see ProductDetailPage.Pdp.ActiveWishListIcon is not displayed in 2 seconds
      And I see ProductDetailPage.Header.ActiveWishListIcon is not displayed in 1 second

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5098
  Scenario Outline: Wishlist On PDP - Verify product can be added to/removed from wishlist by clicking on the wishlist icon on PDP
    Given There are 5 normal size product style of locale <locale> and langCode <langCode> with inventory between 10 and 99999
    When I am on locale <locale> pdp page for product style product3#styleColourPartNumber with forced accepted cookies
      And I am a logged in user
    Then I see ProductDetailPage.Pdp.WishListIcon is displayed
    When I click on ProductDetailPage.Pdp.WishListIcon
    Then I see ProductDetailPage.Pdp.ActiveWishListIcon is displayed in 2 seconds
      And I see ProductDetailPage.Header.ActiveWishListIcon is displayed
    When I click on ProductDetailPage.Pdp.WishListIcon
    Then I see ProductDetailPage.Pdp.ActiveWishListIcon is not displayed
      And I see ProductDetailPage.Header.ActiveWishListIcon is not displayed

    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale | langCode |
      | de     | EN       |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5099
  Scenario Outline: Wishlist On PDP - Saving item on PDP with OOS size
    Given There is 1 normal size product style of locale <locale> where 1 size is out of stock with inventory between 5 and 99999
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
    When I click on ProductDetailPage.Pdp.SizeSoldOutButton
      And I click on ProductDetailPage.Pdp.WishListIcon
    Then I see ProductDetailPage.Pdp.ActiveWishListIcon is displayed in 3 secondds

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5100
  Scenario Outline: Wishlist On PDP - Saving item on PDP with one size
    Given There is 1 one size product item of locale <locale> with inventory between 10 and 99999 filtered by FH
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I click on ProductDetailPage.Pdp.WishListIcon
    Then I see ProductDetailPage.Header.ActiveWishListIcon is displayed
      And I see ProductDetailPage.Pdp.ActiveWishListIcon is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5101 @ExcludeCK
  Scenario Outline: Wishlist On PDP - Saving item on PDP with multiple colors
    Given There is 1 multi colour product with at least 2 colours of locale <locale> with inventory between 10 and 99999
      And I extract product style from product product1#stylePartNumber with index 0 saved as #styleColourPartNumber
    When I am on locale <locale> pdp page for product style #styleColourPartNumber with forced accepted cookies
      And I wait until ProductDetailPage.Pdp.Content is displayed
      And I click on ProductDetailPage.Pdp.WishListIcon
    Then I see ProductDetailPage.Pdp.ActiveWishListIcon is displayed in 2 seconds
      And I wait until ProductDetailPage.Header.ActiveWishListCount with text 1 is displayed
    When I click on ProductDetailPage.Pdp.ColorSwatchButton with index 2
    Then I see ProductDetailPage.Header.ActiveWishListIcon with text 1 is displayed
      And I see ProductDetailPage.Pdp.ActiveWishListIcon is not displayed in 2 seconds
    When I click on ProductDetailPage.Pdp.WishListIcon
    Then I see ProductDetailPage.Pdp.ActiveWishListIcon is displayed in 2 seconds
      And I see ProductDetailPage.Header.ActiveWishListIcon with text 2 is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5101 @ExcludeTH
  Scenario Outline: Wishlist On PDP - Saving item on PDP with multiple colors
    Given There is 1 multi colour product with at least 2 colours of locale <locale> with inventory between 10 and 99999
      And I extract product style from product product1#stylePartNumber with index 0 saved as #styleColourPartNumber
    When I am on locale <locale> pdp page for product style #styleColourPartNumber with forced accepted cookies
      And I wait until ProductDetailPage.Pdp.Content is displayed
      And I click on ProductDetailPage.Pdp.WishListIcon
    Then I see ProductDetailPage.Pdp.ActiveWishListIcon is displayed in 2 seconds
      And I wait until ProductDetailPage.Header.ActiveWishListIcon is displayed
    When I click on ProductDetailPage.Pdp.ColorSwatchButton with index 2
    Then I see ProductDetailPage.Header.ActiveWishListIcon is displayed
      And I see ProductDetailPage.Pdp.ActiveWishListIcon is not displayed in 2 seconds
    When I click on ProductDetailPage.Pdp.WishListIcon
    Then I see ProductDetailPage.Pdp.ActiveWishListIcon is displayed in 2 seconds
      And I see ProductDetailPage.Header.ActiveWishListIcon with text 2 is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5102
  Scenario Outline: Wishlist On PDP - Verify saved items remain saved on the next visit
    Given There is 1 normal size product style of locale <locale> with inventory between 10 and 99999 filtered by FH
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until ProductDetailPage.Pdp.Content is displayed
    When I click on ProductDetailPage.Pdp.WishListIcon
    Then I see ProductDetailPage.Header.ActiveWishListIcon is displayed in 2 seconds
      And I close current browser tab
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber
    Then I see ProductDetailPage.Header.ActiveWishListIcon is displayed
      And I see ProductDetailPage.Pdp.ActiveWishListIcon is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5107
  Scenario Outline: Wishlist On PDP - Unsaving item from wishlist on PDP
    Given There are 5 normal size product style of locale <locale> with inventory between 10 and 99999
      And I am on locale <locale> pdp page for product style product3#styleColourPartNumber with forced accepted cookies
      And I am a logged in user
      And I wait until ProductDetailPage.Pdp.Content is displayed
    When I click on ProductDetailPage.Pdp.WishListIcon
      And in header I wait until unified wishlist is active in 5 seconds
      And I click on ProductDetailPage.Pdp.ActiveWishListIcon
    Then in header I see unified wishlist is not active in 15 seconds
      And I see ProductDetailPage.Pdp.ActiveWishListIcon is not displayed
      And I see ProductDetailPage.Pdp.WishListIcon is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @AddToBag @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-5106
  Scenario Outline: Wishlist on PDP - Adding saved item to shopping bag on PDP
    Given There are 5 normal size product item of locale <locale> and langCode <langCode> with inventory between 200 and 99999 filtered by FH
      And I am on locale <locale> pdp page for product style product3#styleColourPartNumber with forced accepted cookies
      And I wait until ProductDetailPage.Pdp.Content is displayed
    When in unified PDP I select size by sku part number product3#skuPartNumber
      And I click on ProductDetailPage.Pdp.WishListIcon
      And in header I wait until unified wishlist is active in 5 seconds
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then in header I see unified wishlist is active
      And I see ProductDetailPage.Pdp.ActiveWishListIcon is displayed

    @P1
    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5105
  Scenario Outline: Wishlist On PDP - Verify user is able to navigate from PDP to wishlist and back
    Given There is 1 normal size product style of locale <locale> where 1 size is out of stock with inventory between 5 and 99999
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I get translation from lokalise for "WishListTitleText" and store it with key #WishListTitleText
    When I store the value of ProductDetailPage.Pdp.ProductName with key #productName
      And I click on ProductDetailPage.Pdp.WishListIcon
    Then I see ProductDetailPage.Pdp.ActiveWishListIcon is displayed 2 seconds
      And I see ProductDetailPage.Header.ActiveWishListIcon is displayed in 2 seconds
    When I click on ProductDetailPage.Header.ActiveWishListIcon
    Then I see Experience.Wishlist.FilledWishlistTitle with text #WishListTitleText is displayed
      And the count of displayed elements Experience.Wishlist.RemoveButton is equal to 1
      And I see Experience.Wishlist.DisabledAddToBagButton with index 1 is displayed
      And the value of Experience.Wishlist.ItemTitle with index 1 should be equal to the stored value with key #productName
    When I navigate back in the browser
    Then I wait until ProductDetailPage.Pdp.Content is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @FromPlpToPdpFlow @P1
  @tms:UTR-12764
  Scenario Outline: Wishlist On PDP - As a guest user saving item on Search PLP and verifying it's saved on PDP
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I wait until page Experience.PlpProducts is loaded
    When I click on Experience.PlpProducts.WishListIcon with index 1
    Then I see Experience.Header.WishListCounter with text 1 is displayed
    When I click on Experience.PlpProducts.ProductListItems with index 1 until ProductDetailPage.Pdp.Content is displayed
      And I wait until the current page is loaded
    Then in header I wait until unified wishlist is active in 5 seconds
      And I see ProductDetailPage.Pdp.ActiveWishListIcon is displayed

    Examples:
      | locale  | langCode | page       |
      | default | default  | search-plp |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @FromPlpToPdpFlow @P1
  @tms:UTR-17736
  Scenario Outline: Wishlist On PDP - As a logged in user saving item on Search PLP and verifying it's saved on PDP
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I navigate to page <page>
      And I wait until page Experience.PlpProducts is loaded
    When I click on Experience.PlpProducts.WishListIcon with index 1
    Then I see Experience.Header.WishListCounter with text 1 is displayed
    When I click on Experience.PlpProducts.ProductListItems with index 1 until ProductDetailPage.Pdp.Content is displayed
      And I wait until the current page is loaded
    Then in header I wait until unified wishlist is active
      And I see ProductDetailPage.Pdp.ActiveWishListIcon is displayed

    Examples:
      | locale  | langCode | page       |
      | default | default  | search-plp |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-12765
  Scenario Outline: Wishlist On PDP - Saving item on PLP and verifying it's saved on PDP
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.PlpProducts.WishListIcon with index 1
      And I see Experience.Header.WishListCounter with text 1 is displayed
      And I click on Experience.PlpProducts.ProductGridItems with index 1 until ProductDetailPage.Pdp.Content is displayed
      And I wait until the current page is loaded
    Then in header I see unified wishlist is active
      And I see ProductDetailPage.Pdp.ActiveWishListIcon is displayed

    @ExcludeCK
    Examples:
      | locale  | langCode | categoryId                 |
      | default | default  | th_women_clothing_t-shirts |

    @ExcludeTH
    Examples:
      | locale  | langCode | categoryId             |
      | default | default  | women_clothes_t-shirts |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-12766
  Scenario Outline: Wishlist On PDP - Saving item on PDP and veryfying it's saved on Search PLP
    Given I am on locale <locale> glp page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I wait until page Experience.PlpProducts is loaded
    When I click on Experience.PlpProducts.ProductGridItems with index 3 until ProductDetailPage.Pdp.Content is displayed
      And I wait until the current page is loaded
      And I click on ProductDetailPage.Pdp.WishListIcon
      And in header I wait until unified wishlist is active in 5 seconds
      And I navigate back in the browser
    Then I see Experience.PlpProducts.ActiveWishListIcon with index 3 is displayed
      And the count of displayed elements Experience.Header.WishListCounter is equal to 1

    Examples:
      | locale  | langCode | page       |
      | default | default  | search-plp |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-12767
  Scenario Outline: Wishlist On PDP - Saving item on PDP and verifying it's saved on PLP
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
      And I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I wait until page Experience.PlpProducts is loaded
    When I click on Experience.PlpProducts.ProductGridItems with index 3 until ProductDetailPage.Pdp.Content is displayed
      And I wait until the current page is loaded
      And I click on ProductDetailPage.Pdp.WishListIcon
      And in header I wait until unified wishlist is active in 10 seconds
      And I navigate back in the browser
    Then I see Experience.PlpProducts.ActiveWishListIcon with index 3 is displayed
      And the count of displayed elements Experience.Header.WishListCounter is equal to 1

    @ExcludeCK
    Examples:
      | locale  | langCode | categoryId                 |
      | default | default  | th_women_clothing_t-shirts |

    @ExcludeTH
    Examples:
      | locale  | langCode | categoryId             |
      | default | default  | women_clothes_t-shirts |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-12768
  Scenario Outline: Wishlist On PDP - As a guest user unsaving item on Search PLP and verifying it's unsaved on PDP
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I wait until page Experience.PlpProducts is loaded
    When I click on Experience.PlpProducts.WishListIcon with index 1
    Then I see Experience.Header.WishListCounter with text 1 is displayed
    When I click on Experience.PlpProducts.WishListIcon with index 1
    Then I see Experience.Header.WishListCounter with text 1 is not displayed in 3 seconds
    When I click on Experience.PlpProducts.ProductGridItems with index 3 until ProductDetailPage.Pdp.Content is displayed
      And I wait until the current page is loaded
    Then in header I see unified wishlist is not active in 2 seconds
      And I see ProductDetailPage.Pdp.ActiveWishListIcon is not displayed in 2 seconds
      And I see ProductDetailPage.Pdp.WishListIcon is displayed

    Examples:
      | locale  | langCode | page       |
      | default | default  | search-plp |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-17737
  Scenario Outline: Wishlist On PDP - As a logged in user unsaving item on Search PLP and verifying it's unsaved on PDP
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I navigate to page <page>
      And I wait until page Experience.PlpProducts is loaded
    When I click on Experience.PlpProducts.WishListIcon with index 1
    Then I see Experience.Header.WishListCounter with text 1 is displayed
    When I click on Experience.PlpProducts.WishListIcon with index 1
    Then I see Experience.Header.WishListCounter with text 1 is not displayed in 3 seconds
    When I click on Experience.PlpProducts.ProductGridItems with index 3 until ProductDetailPage.Pdp.Content is displayed
      And I wait until the current page is loaded
    Then in header I see unified wishlist is not active in 2 seconds
      And I see ProductDetailPage.Pdp.ActiveWishListIcon is not displayed in 2 seconds
      And I see ProductDetailPage.Pdp.WishListIcon is displayed

    Examples:
      | locale  | langCode | page       |
      | default | default  | search-plp |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-12769
  Scenario Outline: Wishlist On PDP - Unsaving item on PLP and verifying it's unsaved on PDP
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.PlpProducts.WishListIcon with index 1
    Then I see Experience.Header.WishListCounter with text 1 is displayed
    When I click on Experience.PlpProducts.WishListIcon with index 1 in 3 seconds
    Then I see Experience.Header.WishListCounter with text 1 is not displayed in 3 seconds
    When I click on Experience.PlpProducts.ProductGridItems with index 1 until ProductDetailPage.Pdp.Content is displayed
      And I wait until the current page is loaded
    Then in header I see unified wishlist is not active in 2 seconds
      And I see ProductDetailPage.Pdp.ActiveWishListIcon is not displayed in 8 seconds
      And I see ProductDetailPage.Pdp.WishListIcon is displayed

    @ExcludeCK
    Examples:
      | locale  | langCode | categoryId                 |
      | default | default  | th_women_clothing_t-shirts |

    @ExcludeTH
    Examples:
      | locale  | langCode | categoryId             |
      | default | default  | women_clothes_t-shirts |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-12770
  Scenario Outline: Wishlist On PDP - Unsaving item on PDP and verifying it's unsaved on Search PLP
    Given I am on locale <locale> glp page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I navigate to page <page>
      And I wait until page Experience.PlpProducts is loaded
    When I click on Experience.PlpProducts.ProductGridItems with index 3 until ProductDetailPage.Pdp.Content is displayed
      And I wait until the current page is loaded
      And I click on ProductDetailPage.Pdp.WishListIcon
      And in header I wait until unified wishlist is active
      And I click on ProductDetailPage.Pdp.ActiveWishListIcon
      And in header I wait until unified wishlist is not active in 3 seconds
      And I navigate back in the browser
      And I wait until page Experience.PlpProducts is loaded
    Then the count of displayed elements Experience.PlpProducts.ActiveWishListIcon is equal to 0 in 2 seconds
      And I see Experience.Header.WishListCounter is not displayed in 2 seconds

    Examples:
      | locale  | langCode | page       |
      | default | default  | search-plp |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-12771
  Scenario Outline: Wishlist On PDP - Unsaving item on PDP and verifying it's unsaved on PLP
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And I click on Experience.PlpProducts.ProductGridItems with index 3 until ProductDetailPage.Pdp.Content is displayed
      And I wait until the current page is loaded
      And I click on ProductDetailPage.Pdp.WishListIcon
      And in header I wait until unified wishlist is active
      And I click on ProductDetailPage.Pdp.ActiveWishListIcon
      And in header I wait until unified wishlist is not active in 3 seconds
      And I navigate back in the browser
      And I wait until page Experience.PlpProducts is loaded
    Then the count of displayed elements Experience.PlpProducts.ActiveWishListIcon is equal to 0 in 2 seconds
      And I see Experience.Header.WishListCounter is not displayed in 2 seconds

    @ExcludeCK
    Examples:
      | locale  | langCode | categoryId                 |
      | default | default  | th_women_clothing_t-shirts |

    @ExcludeTH
    Examples:
      | locale  | langCode | categoryId             |
      | default | default  | women_clothes_t-shirts |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Wishlist @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-18754
  Scenario Outline: Wishlist - Add to bag button on wishlist page is disabled after the last item is added to cart on PDP
    Given There is 1 one size product item of locale <locale> with inventory between 1 and 1
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I see ProductDetailPage.Pdp.LowStockMessage contains text "1"
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I click on ProductDetailPage.Pdp.WishListIcon
      And in header I wait until unified wishlist is active
    When I click on ProductDetailPage.Header.ActiveWishListIcon
    Then I see Experience.Wishlist.DisabledAddToBagButton is displayed

    Examples:
      | locale  |
      | default |