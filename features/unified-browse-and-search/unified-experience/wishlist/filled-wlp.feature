Feature: Unified wishlist - Filled wishlist page

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Filled @P2
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @tms:UTR-4614
  Scenario Outline:  Unified wishlist - Validate navigation to filled wishlist page and page elements for guest user
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I am on locale <locale> wish list page of langCode <langCode> with 1 product
      And I wait until Experience.Header.ActiveWishListIcon is displayed
      And I navigate to page <page>
    When I click on Experience.Header.ActiveWishListIcon
    Then I see Experience.Wishlist.FilledWishlistTitle with text <titleText> is displayed
      And I see Experience.Wishlist.FilledWishlistCopy with text <copyText> is displayed
      And I see Experience.Wishlist.FilledWishlistSignInButton is displayed
      And I see Experience.Wishlist.ProductTileComponent is displayed

    Examples:
      | locale  | langCode | page          | userType | titleText | copyText                                                     |
      | default | default  | store-locator | guest    | Wishlist  | Sign in or create an account to save your wishlist for later |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Filled @P2
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @tms:UTR-4937
  Scenario Outline:  Unified wishlist - Validate navigation to filled wishlist page and page elements for logged in user
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I am on locale <locale> wish list page of langCode <langCode> with 1 product
      And I wait until Experience.Header.ActiveWishListIcon is displayed
      And I navigate to page <page>
    When I click on Experience.Header.ActiveWishListIcon
    Then I see Experience.Wishlist.FilledWishlistTitle with text <titleText> is displayed
      And I see Experience.Wishlist.FilledWishlistCopy with text <copyText> is not displayed
      And I see Experience.Wishlist.FilledWishlistSignInButton is not displayed
      And I see Experience.Wishlist.ProductTileComponent is displayed

    Examples:
      | locale  | langCode | page          | userType  | titleText | copyText                                                     |
      | default | default  | store-locator | logged in | Wishlist  | Sign in or create an account to save your wishlist for later |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Filled
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @tms:UTR-4935
  Scenario Outline:  Unified wishlist - Removing last item from the wishlist
    Given There is 1 account
      And I am on locale <locale> home page of langCode default with forced accepted cookies
      And I sign in with email user1#email and password user1#password
      And I wait until the current page is loaded
      And I am on locale <locale> wish list page of langCode default with 1 product
    When I click on Experience.Header.ActiveWishListIcon
      And I wait until Experience.Wishlist.ProductTileComponent with index 1 is displayed
      And I click on Experience.Wishlist.ProductTileDeleteButton with index 1 until Experience.Wishlist.ProductTileComponent with index 1 is not displayed
    Then I see Experience.Header.ActiveWishListIcon is not displayed in 10 seconds

    @P1
    Examples:
      | locale  |
      | default |

  Examples:
    | locale           |
    | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Filled @P2
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @tms:UTR-4763
  Scenario Outline: Unified wishlist - Removing not last item from the wishlist
    Given I am on locale <locale> home page of langCode default with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I am on locale <locale> wish list page of langCode default with 2 product
      And I wait until Experience.Header.ActiveWishListIcon is displayed
      And I am on locale <locale> wish list page of langCode default for product styles product1#styleColourPartNumber,product2#styleColourPartNumber with forced accepted cookies
      And I click on Experience.Wishlist.ProductTileDeleteButton with index 1
      And I wait for 2 seconds
    Then I see Experience.Wishlist.EmptyWishlistTitle is not displayed
      And I see Experience.Header.ActiveWishListIcon is displayed

    Examples:
      | locale           | userType  |
      | default          | logged in |
      | multiLangDefault | guest     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Filled
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @tms:UTR-4932
  Scenario Outline: Unified wishlist - Verift that clicking on product image or title redirects to unified PDP
    Given There is 1 normal size product style of locale <locale> and langCode default with inventory between 10 and 99999
      And I am on locale <locale> wish list page of langCode default for product styles product1#styleColourPartNumber with forced accepted cookies
      And I store the value of Experience.Wishlist.ItemTitle with index 1 with key #productName
    When I click on <itemToClick> with index 1
      And I wait until the current page is PDP
    Then in unified PDP I see product name is matched to product style colour part number product1#styleColourPartNumber

    @P2
    Examples:
      | locale  | itemToClick                      |
      | default | Experience.Wishlist.ItemTitle    |
      | default | Experience.Wishlist.ProductImage |

    Examples:
      | locale           | itemToClick                      |
      | multiLangDefault | Experience.Wishlist.ItemTitle    |
      | multiLangDefault | Experience.Wishlist.ProductImage |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Filled
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @tms:UTR-4934
  Scenario Outline: Unified wishlist - Verfiy that the user is able to select available size from dropdown and able to add to bag
    Given There is 2 normal size product style of locale <locale> and langCode <langCode> with inventory between 10 and 99999 filtered by FH
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I am on locale <locale> wish list page of langCode <langCode> for product styles product2#styleColourPartNumber
      And I extract a product item from product style product2#styleColourPartNumber which has inventory saved as #skuPartNumber
    When I fetch size name of product item #skuPartNumber saved as #sizeName
    Then I see Experience.Wishlist.DisabledAddToBagButton is displayed
      And in unified wishlist page I select size based on product item #skuPartNumber
    Then I click on Experience.Wishlist.EnabledAddToBagButton
      And I wait for 5 seconds
      And I wait until Experience.Wishlist.EmptyWishlistTitle is not displayed

    @P1
    Examples:
      | locale  | langCode | userType  |
      | default | default  | logged in |
      | default | default  | guest     |

    Examples:
      | locale           | langCode | userType  |
      | multiLangDefault | default  | logged in |
      | multiLangDefault | default  | guest     |
      | fr               | default  | guest     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Filled @P2
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @tms:UTR-4938
  Scenario Outline: Unified wishlist - Verify that the user is able to click disabled add to bag button and dropdown is displayed
    Given There is 1 <sizeType> size product style of locale <locale> and langCode <langCode> with inventory between 10 and 99999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I am on locale <locale> wish list page of langCode <langCode> for product styles product1#styleColourPartNumber
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
    When I fetch size name of product item #skuPartNumber saved as #sizeName
    Then I see Experience.Wishlist.DisabledAddToBagButton is displayed
      And I click on Experience.Wishlist.DisabledAddToBagButton
      And I wait until Experience.Wishlist.EditSizeDropdown with text #sizeName is displayed

    Examples:
      | locale           | langCode | sizeType | userType  |
      | default          | default  | normal   | logged in |
      | default          | default  | normal   | guest     |
      | multiLangDefault | default  | normal   | logged in |
      | multiLangDefault | default  | normal   | guest     |
      | de               | default  | normal   | logged in |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Filled @P2
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @tms:UTR-4933
  Scenario Outline: Unified wishlist - Verfiy that one size product has that size selected by default and user is able to add to bag
    Given There is 1 one size product style of locale <locale> and langCode <langCode> with inventory between 10 and 99999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
    When I am on locale <locale> wish list page of langCode <langCode> for product styles product1#styleColourPartNumber
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
      And I see Experience.Wishlist.DisabledAddToBagButton is not displayed
    Then I scroll to the element Experience.Wishlist.EnabledAddToBagButton
      And I click on Experience.Wishlist.EnabledAddToBagButton
      And I wait for 5 seconds
      And I wait until Experience.Wishlist.EmptyWishlistTitle is not displayed

    Examples:
      | locale           | langCode | userType  |
      | default          | default  | logged in |
      | default          | default  | guest     |
      | multiLangDefault | default  | logged in |
      | multiLangDefault | default  | guest     |
      | nl               | default  | logged in |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Filled @P2
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @tms:UTR-4616
  Scenario Outline: Unified wishlist - Verfiy that one size out of stock product has add to bag button disabled
    Given There is 1 one size product style of locale <locale> and langCode <langCode> with inventory between 0 and 0
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
    When I am on locale <locale> wish list page of langCode <langCode> for product styles product1#styleColourPartNumber
      And I see Experience.Wishlist.DisabledAddToBagButton is displayed
    Then I click on Experience.Wishlist.DisabledAddToBagButton
      And I see Experience.Wishlist.EmptyWishlistTitle is not displayed

    Examples:
      | locale           | langCode | userType  |
      | default          | default  | logged in |
      | default          | default  | guest     |
      | multiLangDefault | default  | logged in |
      | multiLangDefault | default  | guest     |
      | es               | default  | logged in |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Filled @P2
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @tms:UTR-4936
  Scenario Outline: Unified wishlist - Verfiy that multi size out of stock product has add to bag button disabled.
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 0 and 0
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
    When I am on locale <locale> wish list page of langCode <langCode> for product styles product1#styleColourPartNumber
    Then I see Experience.Wishlist.DisabledAddToBagButton is displayed
      And I click on Experience.Wishlist.DisabledAddToBagButton
      And I see Experience.Wishlist.EmptyWishlistTitle is not displayed

    Examples:
      | locale           | langCode | userType  |
      | default          | default  | logged in |
      | default          | default  | guest     |
      | multiLangDefault | default  | logged in |
      | multiLangDefault | default  | guest     |
      | be               | default  | logged in |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Filled @P2
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @tms:UTR-5190
  Scenario Outline: Unified wishlist - Verfiy that all not added multisize products should show disabled add to bag button if one product is added to bag previously
    Given There is 2 normal size product style of locale <locale> and langCode <langCode> with inventory between 100 and 99999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I am on locale <locale> wish list page of langCode <langCode> for product styles product1#styleColourPartNumber,product2#styleColourPartNumber
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
    When I fetch size name of product item #skuPartNumber saved as #sizeName
    Then I see Experience.Wishlist.DisabledAddToBagButton is displayed
      And in unified wishlist page I select size based on product item #skuPartNumber
    Then I click on Experience.Wishlist.EnabledAddToBagButton
      And I wait for 5 seconds
    Then I see Experience.Wishlist.EmptyWishlistTitle is not displayed
      And I see Experience.Wishlist.EnabledAddToBagButton with index 1 is displayed
      And I see Experience.Wishlist.DisabledAddToBagButton with index 1 is displayed

    Examples:
      | locale           | langCode | userType  |
      | default          | default  | logged in |
      | default          | default  | guest     |
      | multiLangDefault | default  | logged in |
      | multiLangDefault | default  | guest     |
      | fr               | default  | logged in |