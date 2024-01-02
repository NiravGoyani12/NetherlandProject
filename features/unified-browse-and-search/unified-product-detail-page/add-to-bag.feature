Feature: Unified PDP - Add to bag

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @AddToBag @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-10797
  Scenario Outline: Unified add to bag - As a guest user I can add any product to shopping bag
    Given There is 1 <sizeType> size product item of locale <locale> and langCode <langCode> with inventory between 10 and 99999 filtered by FH
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I am a guest user
      And I get translation from lokalise for "AddToBagText" and store it with key #AddToBag
      And I get translation from lokalise for "ItemAddedText" and store it with key #ItemAdded
    When I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.AddToBagButton with text #AddToBag is displayed
    When in unified PDP I select size by sku part number product1#skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see ProductDetailPage.Pdp.ItemAddedButton with text #ItemAdded is displayed
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
    When I click on ProductDetailPage.Header.ShoppingBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And the count of elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.Item with args product1#skuPartNumber is displayed

    @P1
    Examples:
      | locale  | langCode | sizeType |
      | default | default  | normal   |
      | default | default  | one      |

    Examples:
      | locale  | langCode | sizeType     |
      | default | default  | width-length |

    Examples:
      | locale           | langCode | sizeType |
      | multiLangDefault | default  | normal   |
      | multiLangDefault | default  | one      |

    @ExcludeCK
    Examples:
      | locale  | langCode | sizeType   |
      | default | default  | width only |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @AddToBag @PDP @TEE @UnifiedPdp @UnifiedExperience @P1
  @tms:UTR-13374
  Scenario Outline: Unified add to bag - As a logged in user I can add any product to shopping bag
    Given There are 5 normal size product item of locale <locale> and langCode <langCode> with inventory between 200 and 99999 filtered by FH
      And I am on locale <locale> pdp page for product style product3#styleColourPartNumber with forced accepted cookies
      And I am a logged in user
      And I get translation from lokalise for "AddToBagText" and store it with key #AddToBag
      And I get translation from lokalise for "ItemAddedText" and store it with key #ItemAdded
    When I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.AddToBagButton with text #AddToBag is displayed
    When in unified PDP I select size by sku part number product3#skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see ProductDetailPage.Pdp.ItemAddedButton with text #ItemAdded is displayed
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
    When I click on ProductDetailPage.Header.ShoppingBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And the count of elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.Item with args product3#skuPartNumber is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @AddToBag @PDP @TEE @UnifiedPdp @UnifiedExperience @P1
  @tms:UTR-10798
  Scenario Outline: Unified add to bag - I can add discounted product to shopping bag
    Given There is 1 discounted product items of locale <locale> with inventory between 1 and 99999 filtered by FH
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
    When in unified PDP I select size by sku part number product1#skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
    When I click on ProductDetailPage.Header.ShoppingBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And the count of elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.Item with args product1#skuPartNumber is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @AddToBag @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-10799
  Scenario Outline: Unified add to bag - I can add product with inventory equals to 1 to shopping bag
    Given There is 1 normal size product items of locale <locale> with inventory between 1 and 1 filtered by FH
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
    When in unified PDP I select size by sku part number product1#skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
    When I click on ProductDetailPage.Header.ShoppingBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And the count of elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.Item with args product1#skuPartNumber is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @AddToBag @PDP @TEE @UnifiedPdp @UnifiedExperience @P1
  @tms:UTR-10800
  Scenario Outline: Unified add to bag - I can add same product to shopping bag more than once
    Given There are 5 normal size product item of locale <locale> with inventory between 200 and 99999 filterd by FH
      And I am on locale <locale> pdp page for product style product3#styleColourPartNumber with forced accepted cookies
    When in unified PDP I select size by sku part number product3#skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 2 is displayed
    When I click on ProductDetailPage.Header.ShoppingBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 2 is displayed
      And the count of elements Experience.ShoppingBag.Item is equal to 1
      And I see Experience.ShoppingBag.Item with args product3#skuPartNumber is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @AddToBag @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-10801
  Scenario Outline: Unified add to bag - Verify clicking on shopping bag button redirects to shopping bag page
    Given There are 5 normal size product item of locale <locale> with inventory between 200 and 99999 filterd by FH
      And I am on locale <locale> pdp page for product style product3#styleColourPartNumber with forced accepted cookies
    When in unified PDP I select size by sku part number product3#skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton until ProductDetailPage.Pdp.AddedtoBagPopup is displayed
      And I click on <CtaButton>
    Then URL should contain "<targetUrl>" in 10 seconds
    Then the count of displayed elements Experience.ShoppingBag.Item is equal to 1

    @P1
    Examples:
      | locale  | CtaButton                                  | targetUrl    |
      | default | ProductDetailPage.Header.ShoppingBagButton | shopping-bag |

    Examples:
      | locale | CtaButton                                  | targetUrl    |
      | de     | ProductDetailPage.Header.ShoppingBagButton | shopping-bag |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @AddToBag @PDP @TEE @UnifiedPdp @UnifiedExperience @P1
  @tms:UTR-13396
  Scenario Outline: Unified add to bag - Verify clicking on checkout button redirects to shipping page
    Given There are 5 normal size product item of locale <locale> with inventory between 200 and 99999 filtered by FH
      And I am on locale <locale> pdp page for product style product3#styleColourPartNumber with forced accepted cookies
    When in unified PDP I select size by sku part number product3#skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton until ProductDetailPage.Pdp.AddedtoBagPopup is displayed
      And I click on <CtaButton>
    Then URL should contain "<targetUrl>" in 10 seconds

    @P1
    Examples:
      | locale  | langCode | CtaButton                            | targetUrl         |
      | default | default  | ProductDetailPage.Pdp.CheckoutButton | checkout/shipping |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @AddToBag @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-18069
  Scenario Outline: Unified add to bag - Verify clicking on add to bag returns error when no sizes selected
    Given There is 1 normal size product item of locale <locale> with inventory between 50 and 9999
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I get translation from lokalise for "SelectSizeError" and store it with key #SelectSizeError
      And I see the attribute class of element ProductDetailPage.Pdp.SizeSelectorButtons not containing "SizeSelected"
    When I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see ProductDetailPage.Pdp.SelectSizeErrorMessage with text #SelectSizeError is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @AddToBag @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-18070
  Scenario Outline: Unified add to bag - Verify clicking on add to bag returns error when only length or width sizes selected
    Given There is 1 width-length size product item of locale <locale> with inventory between 200 and 99999 filtered by FH
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I get translation from lokalise for "SelectSizeError" and store it with key #SelectSizeError
      And I see the attribute class of element ProductDetailPage.Pdp.SizeSelectorButtons not containing "SizeSelected"
    When I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see ProductDetailPage.Pdp.SelectSizeErrorMessage with text #SelectSizeError is displayed
    When I click on ProductDetailPage.Pdp.WidthSizeButton
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see ProductDetailPage.Pdp.SelectSizeErrorMessage with text #SelectSizeError is displayed
    When I click on ProductDetailPage.Pdp.SelectedSize
      And I see the attribute class of element ProductDetailPage.Pdp.SizeSelectorButtons not containing "SizeSelected"
      And I click on ProductDetailPage.Pdp.LengthSizeButton
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see ProductDetailPage.Pdp.SelectSizeErrorMessage with text #SelectSizeError is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @NotifyMe @P2
  @tms:UTR-12334
  Scenario Outline: Add to bag - Add to bag button is disabled after the last item is added to the cart
    Given There is 1 one size product item of locale <locale> with inventory between 1 and 1
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I see ProductDetailPage.Pdp.LowStockMessage contains text "1"
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see ProductDetailPage.Pdp.DisabledAddToBagButton is displayed

    Examples:
      | locale  |
      | default |