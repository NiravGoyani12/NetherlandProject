Feature: Unified Mini Shopping Bag - Basic

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Header @MiniShoppingBag @UnifiedCheckout @P2
  @feature:CET1-2613
  Scenario Outline: Unified Mini Shopping Bag - Verify no mini shopping bag is displayed with empty bag
    Given I am on locale <locale> home page with forced accepted cookies
      And I navigate to page <page>
    When I hover over Experience.Header.ShoppingBagButton
    Then I see Experience.MiniShoppingBag.MainPanel is not in viewport in 3 seconds

    @tms:UTR-11861
    Examples:
      | locale  | page |
      | default | wlp  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Header @MiniShoppingBag @UnifiedCheckout @P2
  @feature:CET1-2613
  Scenario Outline: Unified Mini Shopping Bag - Verify mini shopping bag is displayed with filled bag
    Given I am on locale <locale> shopping bag page with 1 unit of any product with accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I navigate to page <page>
      And I wait until Experience.Header.ShoppingBagCounter is displayed
    When I hover over Experience.Header.ShoppingBagButton
    Then I see Experience.MiniShoppingBag.MainPanel is in viewport

    @tms:UTR-11872
    Examples:
      | locale  | page |
      | default | wlp  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Header @MiniShoppingBag @UnifiedCheckout
  @feature:CET1-2613
  Scenario Outline: Unified Mini Shopping Bag - Verify elements of mini shopping bag
    Given There is 1 normal size product items of locale <locale> with inventory between 5 and 99999
    When I am on locale <locale> shopping bag page for product item product1#skuPartNumber with forced accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I see Experience.Header.ShoppingBagCounter contains text "1"
    When I hover over Experience.Header.ShoppingBagButton
    Then I check if product item details for part number product1#skuPartNumber are correctly displayed from DB

    @tms:UTR-11871 @P1
    Examples:
      | locale  | langCode | page | userType |
      | default | default  | wlp  | guest    |

    @tms:UTR-16418
    Examples:
      | locale           | langCode         | page | userType  |
      | multiLangDefault | multiLangDefault | pdp  | logged in |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Header @MiniShoppingBag @UnifiedCheckout @P2
  @feature:CET1-2613
  Scenario Outline:Unified Mini Shopping Bag - Verify the quantity is reflected correctly when there are multiple units of same products
    Given I am on locale <locale> shopping bag page of langCode <langCode> with <number> units of any product with forced accepted cookies
      And I navigate to page <page>
      And I wait until Experience.Header.ShoppingBagCounter is displayed
    When I hover over Experience.Header.ShoppingBagButton
      And I see Experience.MiniShoppingBag.Products is displayed
      And I see Experience.Header.ShoppingBagCounter contains text "<number>"
    Then I see Experience.MiniShoppingBag.ItemAtrributeValue with text <number> is displayed
      And the count of elements Experience.MiniShoppingBag.Buttons is greater than 1

    @tms:UTR-11860
    Examples:
      | locale  | langCode | page | number |
      | default | default  | wlp  | 1      |

    @tms:UTR-14512
    Examples:
      | locale           | langCode         | page | number |
      | multiLangDefault | multiLangDefault | pdp  | 10     |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Header @MiniShoppingBag @UnifiedCheckout @P2
  @feature:CET1-2613
  Scenario Outline: Unified Mini Shopping Bag - Verify Paypal button on mini shopping bag
    Given I am on locale <locale> shopping bag page with 1 unit of any product with accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I navigate to page <page>
      And I wait until Experience.Header.ShoppingBagCounter is displayed
    When I hover over Experience.Header.ShoppingBagButton
      And I wait until Experience.MiniShoppingBag.MainPanel is in viewport
    Then the count of elements Experience.MiniShoppingBag.Buttons is equal to <numberButtons>
      And I see Experience.MiniShoppingBag.PaypalButton is <displayState> in 2 seconds

    @tms:UTR-11870
    Examples:
      | locale  | numberButtons | displayState | page |
      | default | 3             | displayed    | wlp  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Header @MiniShoppingBag @UnifiedCheckout @P2
  @feature:CET1-2613
  Scenario Outline: Unified Mini Shopping Bag - Verify mini shopping bag with and without discount
    Given There is 1 product item with 0% discount of locale <locale> with price between 10 and 500 and inventory between 100 and 9999
      And There is 1 discounted product item of locale <locale> with inventory between 10 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber,product2#skuPartNumber with forced accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I navigate to page <page>
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I hover over Experience.Header.ShoppingBagButton
    Then the count of elements Experience.MiniShoppingBag.ProductPriceSelling is equal to 2
      And the count of elements Experience.MiniShoppingBag.ProductPriceWas is equal to 1

    @tms:UTR-11866
    Examples:
      | locale  | langCode | page |
      | default | default  | wlp  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending @P2
  @Header @MiniShoppingBag @UnifiedCheckout
  @feature:CET1-2613
  Scenario Outline: Unified Mini Shopping Bag - Registered user can access delivery page from mini shopping bag
    Given I am on locale <locale> home page with forced accepted cookies
      And I wait until the current page is loaded
      And I clear shopping bag for the registered user of this locale
      And I am cross site user on locale <locale> of langCode <langCode> on the shopping bag page
      And I wait until the current page is shopping-bag
      And I wait until the current page is loaded
      And I wait until Experience.Header.ShoppingBagCounter with text "1" is displayed
      And I hover over Experience.Header.ShoppingBagButton
      And I click on Experience.MiniShoppingBag.CheckOutButton
    Then URL should contain "checkout/shipping" in 15 seconds

    @tms:UTR-11862
    Examples:
      | locale  | langCode | page |
      | default | default  | wlp  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending
  @Header @MiniShoppingBag @UnifiedCheckout @P2
  @feature:CET1-2613
  Scenario Outline: Unified Mini Shopping Bag - Verify CTA buttons on mini shopping bag
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product with forced accepted cookies
      And I wait until Experience.Header.ShoppingBagCounter is displayed
    When I navigate to page wlp
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I hover over Experience.Header.ShoppingBagButton
      And I click on <buttonToClick>
    Then URL should contain "<targetUrl>" in 10 seconds

    @tms:UTR-11863
    Examples:
      | locale  | langCode | buttonToClick                                | targetUrl    |
      | default | default  | Experience.MiniShoppingBag.ShoppingBagButton | shopping-bag |

    @tms:UTR-14511
    Examples:
      | locale           | langCode         | buttonToClick                             | targetUrl         |
      | multiLangDefault | multiLangDefault | Experience.MiniShoppingBag.CheckOutButton | checkout/shipping |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending @P2
  @Header @MiniShoppingBag @Paypal @IFrame @UnifiedCheckout
  @feature:CET1-2613
  Scenario Outline: Unified Mini Shopping Bag - Guest user is able to complete paypal express payment from mini shopping bag
    Given I am on locale <locale> shopping bag page with 1 unit of any product with forced accepted cookies
      And I navigate to page <page>
      And I wait until Experience.Header.ShoppingBagCounter is displayed
    When I hover over Experience.Header.ShoppingBagButton
      And I click on Experience.MiniShoppingBag.PaypalButton
      And I set the checkbox Experience.ShoppingBag.PaypalTermsAndConditionCheckBox status to true if exist
      And I click on Experience.ShoppingBag.PaypalTermsAndConditionCheckoutButton if displayed
    Then URL should contain "paypal.com" in 15 seconds

    @tms:UTR-11869
    Examples:
      | locale  | page |
      | default | wlp  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending @P2
  @Header @MiniShoppingBag @Paypal @UnifiedCheckout
  @feature:CET1-2613
  Scenario Outline: Unified Mini Shopping Bag - Starting PayPal Express from the mini bag and using the back functionality sends user back to the shopping bag page
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product with forced accepted cookies
      And I navigate to page <page>
      And I wait until Experience.Header.ShoppingBagCounter is displayed
    When I hover over Experience.Header.ShoppingBagButton
      And I click on Experience.MiniShoppingBag.PaypalButton
      And I set the checkbox Experience.ShoppingBag.PaypalTermsAndConditionCheckBox status to true if exist
      And I click on Experience.ShoppingBag.PaypalTermsAndConditionCheckoutButton if displayed
      And URL should contain "paypal.com" in 15 seconds
      And I navigate back in the browser
      And I wait until Experience.ShoppingBag.Item is displayed in 15 seconds
    Then the count of elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.OverviewSection is displayed

    @tms:UTR-11867
    Examples:
      | locale  | langCode | page |
      | default | default  | wlp  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending @P2
  @Header @MiniShoppingBag @UnifiedCheckout
  @feature:CET1-2613
  Scenario Outline: Unified Mini Shopping Bag - Verify CTA buttons on mini shopping bag after adding item from wishlist page
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 10 and 99999
      And I am on locale <locale> home page of langCode default with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I am on locale <locale> wish list page of langCode default for product styles product1#styleColourPartNumber
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
    When I fetch size name of product item #skuPartNumber saved as #sizeName
    Then I see Experience.Wishlist.DisabledAddToBagButton is displayed
      And in unified wishlist page I select size based on product item #skuPartNumber
    Then I click on Experience.Wishlist.EnabledAddToBagButton
      And I wait for 5 seconds
      And I wait until Experience.Wishlist.EmptyWishlistTitle is not displayed
      And I wait until Experience.Header.ShoppingBagCounter is displayed
      And I see Experience.Header.ShoppingBagCounter contains text "1"
      And I hover over Experience.Header.ShoppingBagButton
      And I click on <buttonToClick>
    Then URL should contain "<targetUrl>" in 10 seconds

    @tms:UTR-13306
    Examples:
      | locale           | langCode         | userType | buttonToClick                                | targetUrl    |
      | multiLangDefault | multiLangDefault | guest    | Experience.MiniShoppingBag.ShoppingBagButton | shopping-bag |

    @tms:UTR-16420
    Examples:
      | locale  | langCode | userType | buttonToClick                             | targetUrl         |
      | default | default  | guest    | Experience.MiniShoppingBag.CheckOutButton | checkout/shipping |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @P2
  @UnifiedCheckout @MiniShoppingBag @AddToBag @PDP @UnifiedPdp
  @Lokalise @Translation
  Scenario Outline: Unified Mini Shopping Bag - Verify CTA buttons on mini shopping bag after adding item from PDP page
    Given There is 1 <sizeType> size product item of locale <locale> and langCode <langCode> with inventory between 10 and 9999
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I am a <userType> user
      And I get translation from lokalise for "AddToBagText" and store it with key #AddToBag
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.AddToBagButton with text #AddToBag is displayed
    When in unified PDP I select size by sku part number product1#skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I see Experience.Header.ShoppingBagCounter contains text "1"
      And I hover over Experience.Header.ShoppingBagButton
      And I click on <buttonToClick>
    Then URL should contain "<targetUrl>" in 10 seconds

    @tms:UTR-13307
    Examples:
      | locale           | langCode         | userType  | sizeType | buttonToClick                                | targetUrl    |
      | multiLangDefault | multiLangDefault | logged in | one      | Experience.MiniShoppingBag.ShoppingBagButton | shopping-bag |

    @tns:UTR-16421
    Examples:
      | locale  | langCode | userType | sizeType | buttonToClick                             | targetUrl         |
      | default | default  | guest    | normal   | Experience.MiniShoppingBag.CheckOutButton | checkout/shipping |


  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @P2
  @PayPal @Payment @MiniShoppingBag @UnifiedCheckout @feature:EED-15286
  Scenario Outline: Unified Mini Shopping Bag - Verify paypal pay later message on mini shopping bag
    Given There is 1 <sizeType> size product item of locale <locale> and langCode <langCode> with inventory between 10 and 9999
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
    When in unified PDP I select size by sku part number product1#skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I see Experience.Header.ShoppingBagCounter contains text "1"
      And I hover over Experience.Header.ShoppingBagButton
      And I wait for 2 seconds
      And I wait until Experience.MiniShoppingBag.PaypalPayLaterLink is clickable
      And I wait until Experience.MiniShoppingBag.PaypalPayLaterLink is in viewport
      And I wait for 2 seconds
    When I click on Experience.MiniShoppingBag.PaypalPayLaterLink if displayed
    Then I switch to iframe Experience.MiniShoppingBag.IframePaypalPayLaterModal
      And I wait until Experience.MiniShoppingBag.PaypalPayLaterModalCloseIcon is clickable

    @tms:UTR-16684
    Examples:
      | locale | langCode | userType | sizeType |
      | uk     | default  | guest    | one      |

    # @tms:UTR-16685
    # Examples:
    #   | locale | langCode | userType | sizeType |
    #   | fr     | default  | guest    | normal   |

    # @tms:UTR-16686
    # Examples:
    #   | locale | langCode | userType | sizeType |
    #   | it     | default  | guest    | normal   |

    @tms:UTR-16687
    Examples:
      | locale | langCode | userType  | sizeType |
      | es     | default  | logged in | normal   |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @P2 @MiniShoppingBag
  @PayPal @Payment @UnifiedCheckout @feature:EED-15286
  Scenario Outline: Unified Mini Shopping Bag - Verify paypal pay later message is not shown when total is more than the limit
    Given There is 1 product item with 0% discount of locale <locale> and langCode <langCode> with price between 150 and 560 and inventory between 1 and 9999
      And I am on locale <locale> home page of langCode default with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> shopping bag page of langCode default with 11 units for product items product1#skuPartNumber
      And I hover over Experience.Header.ShoppingBagButton
      And I see Experience.MiniShoppingBag.PaypalPayLaterLink is not displayed

    # @tms:UTR-16688
    # Examples:
    #   | locale | langCode | userType  | sizeType |
    #   | uk     | default  | logged in | one      |

    @tms:UTR-16689
    Examples:
      | locale | langCode | userType | sizeType |
      | fr     | default  | guest    | normal   |

    # @tms:UTR-UTR-16690
    # Examples:
    #   | locale | langCode | userType | sizeType |
    #   | it     | default  | guest    | normal   |

    @tms:UTR-16691
    Examples:
      | locale | langCode | userType  | sizeType |
      | be     | FR       | logged in | normal   |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @P2 @MiniShoppingBag
  @PayPal @Payment @UnifiedCheckout @feature:EED-15286
  Scenario Outline: Unified Mini Shopping Bag - Verify paypal pay later message before and after applying the discount
    Given I am on locale <locale> shopping bag page of langCode <langCode> with <qty> units for product item <EanNumber> with forced accepted cookies
      And I am a <userType> user
      And I hover over Experience.Header.ShoppingBagButton
      And I see Experience.MiniShoppingBag.PaypalPayLaterLink is not displayed
      And I click on Experience.Header.ShoppingBagCounter
      And I type "<promoCode>" in the field Checkout.OverviewPanel.PromoCodeField
      And I click on Checkout.OverviewPanel.PromoCodeApplyButton
      And I see Checkout.OverviewPanel.PromoCodeRemoveButton is displayed in 5 seconds
    Then I wait until the current page is loaded
      And I hover over Experience.Header.ShoppingBagButton
      And I wait for 2 seconds
      And I wait until Experience.MiniShoppingBag.PaypalPayLaterLink is clickable
      And I wait until Experience.MiniShoppingBag.PaypalPayLaterLink is in viewport
      And I wait for 2 seconds
    When I click on Experience.MiniShoppingBag.PaypalPayLaterLink if displayed
    Then I switch to iframe Experience.MiniShoppingBag.IframePaypalPayLaterModal
      And I wait until Experience.MiniShoppingBag.PaypalPayLaterModalCloseIcon is clickable

    @tms:UTR-16692 @ExcludeTH
    Examples:
      | locale | langCode | userType  | promoCode    | EanNumber     | qty |
      | uk     | default  | logged in | CKAUTOMATION | 8719852242217 | 17  |

    @tms:UTR-16693 @ExcludeCK 
    Examples:
      | locale | langCode | userType  | promoCode    | EanNumber     | qty |
      | uk     | default  | logged in | THAUTOMATION | 8719256689724 | 14  |
