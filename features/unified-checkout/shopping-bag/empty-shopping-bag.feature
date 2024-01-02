Feature: Unified Shopping Bag - Empty page

  # @issue:CET1-3311 discarded
  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @UnifiedCheckout
  @feature:CET1-3287 @P2
  Scenario Outline: Shopping bag - verify that the user is navigated to unified shopping bag page by clicking shopping bag icon
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I wait for 2 seconds
    When I navigate to page <page>
    Then I click on Experience.Header.<locator>
      And I wait for 3 seconds
    Then URL should contain "/shopping-bag"
      And I see Experience.ShoppingBag.EmptyShoppingBagTitle is displayed

    @tms:UTR-4281
    Examples:
      | locale  | langCode | page          | userType | locator           |
      | default | default  | store-locator | guest    | ShoppingBagButton |

    @tms:UTR-16442
    Examples:
      | locale           | langCode         | page | userType  | locator           |
      | multiLangDefault | multiLangDefault | pdp  | logged in | ShoppingBagButton |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @P2
  @ShoppingBag @UnifiedCheckout
  @feature:CET1-3287
  Scenario Outline: Shopping bag - Validate unified shopping bag page elements
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I am a <user> user
    Then URL should contain "/shopping-bag"
      And I see Experience.ShoppingBag.EmptyShoppingBagTitle with text <titleText> is displayed
      And I see Experience.ShoppingBag.EmptyShoppingBagCopy with text <copyText> is displayed
      And I see Experience.ShoppingBag.EmptyShoppingBagButton with text <buttonText> is displayed
      And I see Experience.Header.ActiveWishListIcon is not displayed in 1 second

    @tms:UTR-4283
    Examples:
      | locale  | langCode | page         | user  | titleText                  | copyText                            | buttonText        |
      | default | default  | shopping-bag | guest | Your shopping bag is empty | and add items to your shopping bag! | Continue Shopping |

    @tms:UTR-16443
    Examples:
      | locale           | langCode         | page         | user      | titleText                  | copyText                            | buttonText        |
      | multiLangDefault | multiLangDefault | shopping-bag | logged in | Your shopping bag is empty | and add items to your shopping bag! | Continue Shopping |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @ShoppingBag @UnifiedCheckout @P2
  @feature:CET1-3287 @issue:EESCK-11811
  Scenario Outline: Shopping bag - As a guest user I want to verfiy that the unified empty shopping bag page button redirects to home page
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a guest user
      And I wait until the current page is loaded
    When I navigate to page <page>
    Then I click on Experience.Header.ShoppingBagButton
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.EmptyShoppingBagButton with text "Continue Shopping"
    Then I see the current page is <expectedPage>

    @tms:UTR-4282
    Examples:
      | locale  | langCode | page | expectedPage | user      |
      | default | default  | wlp  | Homepage     | logged in |

    @tms:UTR-16447
    Examples:
      | locale           | langCode         | page | expectedPage | user  |
      | multiLangDefault | multiLangDefault | pdp  | Homepage     | guest |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @ShoppingBag @UnifiedCheckout @P2
  @feature:CET1-3287
  Scenario Outline: Shopping bag - Verfiy that the unified empty shopping bag page button redirects to GLP with gender cookies
    Given I am on locale <locale> glp page of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
      And I am a <user> user
    When I navigate to page <page>
    Then I click on Experience.Header.<locator>
      And I wait for 3 seconds
      And I click on Experience.ShoppingBag.EmptyShoppingBagButton
    Then I see the current page is <expectedPage>

    @tms:UTR-16448
    Examples:
      | locale  | langCode | page          | expectedPage | user      | locator           |
      | default | default  | store-locator | GLP          | logged in | ShoppingBagButton |

    @tms:UTR-16449
    Examples:
      | locale           | langCode         | page | expectedPage | user  | locator           |
      | multiLangDefault | multiLangDefault | wlp  | GLP          | guest | ShoppingBagButton |