Feature: Unified Shopping Bag - basic

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @UnifiedCheckout
  @feature:CET1-3305 @Translation @Lokalise
  Scenario Outline: Shopping Bag - Verify all filled shopping bag elements are present
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product with forced accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I get translation from lokalise for "Color" and store it with key #Color
      And I get translation from lokalise for "Size" and store it with key #Size
      And I get translation from lokalise for "Quantity" and store it with key #Quantity
    Then the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.ItemAtrribute with text #Color is displayed
      And I see Experience.ShoppingBag.ItemAtrribute with text #Size is displayed
      And I see Experience.ShoppingBag.ItemAtrribute with text #Quantity is displayed
      And I see Experience.ShoppingBag.RemoveButton is displayed
      And I see Experience.ShoppingBag.EditProductButton is displayed
      And I see Experience.ShoppingBag.EmptyShoppingBagButton is not displayed in 2 seconds
      And I see Experience.ShoppingBag.EmptyShoppingBagTitle is not displayed in 2 seconds

    @tms:UTR-16450 @P1
    Examples:
      | locale  | langCode | page         |
      | default | default  | shopping-bag |

    @tms:UTR-16451
    Examples:
      | locale           | langCode         | page         |
      | multiLangDefault | multiLangDefault | shopping-bag |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @ShoppingBag @UnifiedCheckout @P2
  @feature:CET1-3305
  Scenario Outline: Shopping Bag - Verify quantity of an item is correct in filled shopping bag
    Given I am on locale <locale> shopping bag page of langCode <langCode> with <number> unit of any product with forced accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I get translation from lokalise for "Quantity" and store it with key #Quantity
    Then the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.ItemAtrribute with text #Quantity is displayed
      And I see Experience.ShoppingBag.ItemAtrributeValue with text <number> is displayed
      And I see Experience.ShoppingBag.RemoveButton is displayed
      And I see Experience.ShoppingBag.EditProductButton is displayed
      And I see Experience.ShoppingBag.EmptyShoppingBagButton is not displayed in 2 seconds
      And I see Experience.ShoppingBag.EmptyShoppingBagTitle is not displayed in 2 seconds

    @tms:UTR-11874
    Examples:
      | locale  | langCode | page         | number |
      | default | default  | shopping-bag | 100    |

    @tms:UTR-17955
    Examples:
      | locale           | langCode         | page         | number |
      | multiLangDefault | multiLangDefault | shopping-bag | 2      |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @ShoppingBag @UnifiedCheckout @P2
  @feature:CET1-3305
  Scenario Outline: Shopping Bag - Registered/Guest user is able to view filled shopping bag
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I wait for 2 seconds
      And I get translation from lokalise for "Color" and store it with key #Color
      And I get translation from lokalise for "Size" and store it with key #Size
      And I get translation from lokalise for "Quantity" and store it with key #Quantity
    When I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product
    Then the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.ItemAtrribute with text #Color is displayed
      And I see Experience.ShoppingBag.ItemAtrribute with text #Size is displayed
      And I see Experience.ShoppingBag.ItemAtrribute with text #Quantity is displayed
      And I see Experience.ShoppingBag.RemoveButton is displayed
      And I see Experience.ShoppingBag.EditProductButton is displayed
      And I see Experience.ShoppingBag.EmptyShoppingBagButton is not displayed in 2 seconds
      And I see Experience.ShoppingBag.EmptyShoppingBagTitle is not displayed in 2 seconds
      And I see Experience.ShoppingBag.OverviewSection is displayed
      And I see Experience.ShoppingBag.StartCheckoutButton is displayed
      And I see Experience.ShoppingBag.CheckoutWithPaypalButton is displayed in 2 seconds

    @tms:UTR-17121
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-16452
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @ShoppingBag @UnifiedCheckout
  @feature:CET1-3305 @P2
  Scenario Outline: Shopping Bag - Clicking on shopping bag item redirects to PDP
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1 in 10 seconds
      And I store the value of Experience.ShoppingBag.ItemTitle with key #productName
    When I click on <buttonToClick>
    Then I see the current page is PDP
      And in unified PDP I see product name is matched to product style colour part number product1#styleColourPartNumber

    @tms:UTR-2223
    Examples:
      | locale  | langCode | buttonToClick                    |
      | default | default  | Experience.ShoppingBag.ItemTitle |

    @tms:UTR-14513
    Examples:
      | locale           | langCode         | buttonToClick                    |
      | multiLangDefault | multiLangDefault | Experience.ShoppingBag.ItemImage |


  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @EditBasket @LowOnStock @UnifiedCheckout @P2
  @feature:CET1-3305
  Scenario Outline: Shopping Bag - Low on stock message is shown for low on stock products
    Given There is 1 normal size product item of locale <locale> and langCode default with inventory between 1 and 1
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
    Then I see Experience.ShoppingBag.LowOnStockMessage with args product1#skuPartNumber is displayed

    @tms:UTR-2230
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16453
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @ShoppingBag @EditBasket @LowOnStock @UnifiedCheckout @P2
  @feature:CET1-3305
  Scenario Outline: Shopping Bag - Low on stock message is not shown for high stock products
    Given There is 1 normal size product item of locale <locale> and langCode default with inventory between 10 and 1000
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
    Then I see Experience.ShoppingBag.LowOnStockMessage with args product1#skuPartNumber is not displayed in 3 seconds

    @tms:UTR-2231
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16454
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @ShoppingBag @EditBasket @LowOnStock @UnifiedCheckout @P2
  Scenario Outline: Shopping Bag - Low on stock message shows correct stock for added product
    Given There is 1 normal size product item of locale <locale> and langCode <langCode> with inventory between 10 and 9999
      And I fetch from the DB the quantity of product item product1#skuPartNumber and store it with key #originalInventory
      And I update in the DB the quantity of product item product1#skuPartNumber to 2
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
    Then I see Experience.ShoppingBag.LowOnStockMessage with args product1#skuPartNumber contains text "2"
      And I update in the DB the quantity of product item product1#skuPartNumber to #originalInventory

    @tms:UTR-11873
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16455
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @UnifiedCheckout @P2
  @feature:EECK-4923
  Scenario Outline: Unified Shopping Bag - Continue shopping button retains selected lang code
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I store current langCode with key #langCode
      And I navigate to page <page>
      And I wait until the current page is loaded
    When I navigate to page shopping-bag
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.EmptyShoppingBagButton
    Then I see the current page is <expectedPage>
      And URL should contain "#langCode"

    @tms:UTR-2222
    Examples:
      | locale           | langCode         | page | expectedPage |
      | multiLangDefault | multiLangDefault | glp  | GLP          |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @ShoppingBag @UnifiedCheckout
  @feature:CET1-4162 @P2
  Scenario Outline: Unified Shopping bag - Verfiy that the unified filled shopping bag, the top proceed to checkout and overview checkout redirects to checkout process
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 units of any product on shopping bag page
      And I wait until the current page is loaded
    When I click on Experience.ShoppingBag.<button>
    Then URL should contain "<Url>" in 15 seconds

    @tms:UTR-13289
    Examples:
      | locale  | langCode | userType | button                          | Url               |
      | default | default  | guest    | FilledBagStartCheckoutTopButton | checkout/shipping |

    @tms:UTR-16457
    Examples:
      | locale           | langCode         | userType  | button              | Url                  |
      | multiLangDefault | multiLangDefault | logged in | StartCheckoutButton | EN/checkout/shipping |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @ShoppingBag @UnifiedCheckout @P2
  @feature:CET1-4162
  Scenario Outline: Unified Shopping bag - Verfiy that the unified filled shopping bag, the top continue shopping button redirects to respective page according to cookie
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I wait for 2 seconds
    When I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.<button>
    Then I see the current page is <expectedPage>

    @tms:UTR-13290
    Examples:
      | locale  | langCode | page      | expectedPage | userType | button                             |
      | default | default  | home-page | Homepage     | guest    | FilledBagContinueShoppingTopButton |

    @tms:UTR-16458
    Examples:
      | locale           | langCode         | page | expectedPage | userType  | button                             |
      | multiLangDefault | multiLangDefault | glp  | GLP          | logged in | FilledBagContinueShoppingTopButton |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @ShoppingBag @UnifiedCheckout @P2
  @feature:CET1-4162
  Scenario Outline: Unified Shopping bag - Verfiy that logged in User moves back to Shopping bag page from checkout and places a Paypal Express Order.
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I wait for 2 seconds
    When I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.<button>
      And URL should contain "<Url>" in 15 seconds
    Then I navigate back in the browser
      And I wait until the current page is loaded
      And I click on Experience.ShoppingBag.CheckoutWithPaypalButton
      And I set the checkbox Experience.ShoppingBag.PaypalTermsAndConditionCheckBox status to true if exist
      And I click on Experience.ShoppingBag.PaypalTermsAndConditionCheckoutButton if displayed
    Then URL should contain "sandbox.paypal.com" in 15 seconds

    @tms:UTR-13370
    Examples:
      | locale  | langCode | button              | Url               |
      | default | default  | StartCheckoutButton | checkout/shipping |

    @tms:UTR-16626
    Examples:
      | locale           | langCode         | button              | Url               |
      | multiLangDefault | multiLangDefault | StartCheckoutButton | checkout/shipping |

  @FullRegression
  @Desktop
  @Chrome @Safari @Firefox @Translation @Lokalise
  @ShoppingBag @UnifiedCheckout @P3
  Scenario Outline: Unified Shopping bag - Customer can see “Items in the shopping bag are not reserved” banner on the Shopping bag page
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 units of any product on shopping bag page
      And I wait until the current page is loaded
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I get translation from lokalise for "ItemsNotReserved" and store it with key #ItemBanner
    Then I see Experience.ShoppingBag.ReservedBanner contains text "#ItemBanner"
    When I click on Experience.ShoppingBag.RemoveButton with args product1#skuPartNumber
      And I wait for 3 seconds
      And I click on Experience.ShoppingBag.RemoveConfirmButton
    Then I see Experience.ShoppingBag.EmptyShoppingBagTitle is displayed
      And the count of elements Experience.ShoppingBag.Item is equal to 0 in 2 seconds
      And I see Experience.ShoppingBag.EmptyShoppingBagButton is displayed
    Then I see Experience.ShoppingBag.ReservedBanner is not displayed

    @tms:UTR-15328
    Examples:
      | locale           | langCode         | userType  |
      | multiLangDefault | multiLangDefault | logged in |

  @FullRegression
  @Desktop
  @Chrome @Safari @Firefox @Translation @Lokalise
  @ShoppingBag @UnifiedCheckout @P3
  Scenario Outline: Unified Shopping Bag - Customer can see “Accepted Payments” section on the Shopping bag page
    Given I am guest on locale <locale> of langCode <langCode> with 1 units of any product on shopping bag page
      And I wait until the current page is loaded
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I get translation from lokalise for "AcceptedPaymentMethods" and store it with key #PaymentMethods
    Then I see Experience.ShoppingBag.AcceptedPaymentMethods contains text "#PaymentMethods"

    @tms:UTR-15326
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |