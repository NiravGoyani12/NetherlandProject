Feature: Unified Shopping Bag - merge
# TODO: Fix merge scenarios for Shopping bag
  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @UnifiedCheckout @P2
  @feature:CET1-3305
  Scenario Outline: Unified Shopping Bag - Added products retained for registered user
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I wait for 2 seconds
      And I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product
      And I wait until Experience.Header.ShoppingBagCounter is displayed
    When I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I sign in with email user1#email and password user1#password
    Then I see Experience.Header.ShoppingBagCounter is displayed
      And I navigate to page shopping-bag
      And the count of elements Experience.ShoppingBag.Item is equal to 1

    @tms:UTR-2300
    Examples:
      | locale  | langCode | page |
      | default | default  | glp  |

    @tms:UTR-16536
    Examples:
      | locale           | langCode         | page |
      | multiLangDefault | multiLangDefault | plp  |

  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @UnifiedCheckout @P2
  @feature:CET1-3305
  Scenario Outline: Unified Shopping Bag - Shopping bag merge from header sign in
    Given There is 2 product items with 0% discount of locale <locale> with price between 10 and 500 and inventory between 2 and 99999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1 in 10 seconds
      And I store the numeric value of Experience.ShoppingBag.TotalPriceInfo with key #productPrice
      And I am on locale <locale> home page with forced accepted cookies
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product2#skuPartNumber
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1 in 10 seconds
      And I navigate to page home-page
      And I sign in with email user1#email and password user1#password
      And I wait for 3 seconds
      And I navigate to page shopping-bag
    Then the count of displayed elements Experience.ShoppingBag.Item is equal to 2
      And the numeric value of Experience.ShoppingBag.TotalPriceInfo is greater than #productPrice

    @tms:UTR-2301
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16538
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @UnifiedCheckout @P2
  Scenario Outline: Unified Shopping Bag - Shopping bag merge from checkout sign in
    Given There is 2 product items with 0% discount of locale <locale> with price between 10 and 500 and inventory between 2 and 9999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I wait for 2 seconds
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1 in 10 seconds
      And I store the numeric value of Experience.ShoppingBag.TotalPriceInfo with key #productPrice
      And I am on locale <locale> home page with forced accepted cookies
      And I am on locale <locale> shopping bag page of langCode <langCode> for product item product2#skuPartNumber
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1 in 10 seconds
      And I click on Experience.ShoppingBag.StartCheckoutButton
      And I continue as logged in to shipping page
    Then the count of displayed elements Checkout.ShippingPage.PLDItem is equal to 2
      And the numeric value of Checkout.OverviewPanel.TotalPriceInfo is greater than #productPrice

    @tms:UTR-2302
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16539
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |
