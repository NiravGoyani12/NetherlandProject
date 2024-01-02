Feature: Unified PDP - Low on Stock/No Stock messages

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @LowOnStock @P2
  @tms:UTR-11071
  Scenario Outline: Low on stock message - message is displayed on PDP for normal size product with stock less then 10 for at least 1 size
    Given There is 1 normal size product item of locale <locale> and langCode <langCode> with inventory between <inventory> and <inventory>
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I extract a product item from product style product1#styleColourPartNumber which has stock equals <inventory> saved as #skuPartNumber
      And I wait until the current page is loaded
    When in unified PDP I select size by sku part number #skuPartNumber
    Then I see ProductDetailPage.Pdp.LowStockMessage is displayed
      And I see ProductDetailPage.Pdp.LowStockDot is displayed
      And I see ProductDetailPage.Pdp.LowStockMessage contains text "<inventory>"

    Examples:
      | locale           | langCode | inventory |
      | default          | default  | 2         |
      | multiLangDefault | default  | 4         |
      | de               | EN       | 4         |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @LowOnStock @P2
  @tms:UTR-11073
  Scenario Outline: Low on stock message - message is displayed on PDP for one size product with inventory less than 10
    Given There is 1 one size product item of locale <locale> with inventory between <inventory> and <inventory> filtered by FH
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.LowStockMessage is displayed
      And I see ProductDetailPage.Pdp.LowStockDot is displayed
      And I see ProductDetailPage.Pdp.LowStockMessage contains text "<inventory>"

    Examples:
      | locale  | inventory |
      | default | 1         |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @LowOnStock @P2
  @tms:UTR-11074
  Scenario Outline: Low on stock message - message disappeares on PDP when I unselect the size that has stock less than 10
    Given There is 1 normal size product item of locale <locale> with inventory between 1 and 2 filtered by FH
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I extract a product item from product style product1#styleColourPartNumber which has stock less than 10 saved as #skuPartNumber
      And I wait until the current page is loaded
      And in unified PDP I select size by sku part number #skuPartNumber
    Then I see ProductDetailPage.Pdp.LowStockMessage is displayed
    When I click on ProductDetailPage.Pdp.SelectedSize
    Then I see ProductDetailPage.Pdp.LowStockMessage is not displayed in 2 seconds
      And I see ProductDetailPage.Pdp.LowStockDot is not displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PDP @TEE @UnifiedPdp @UnifiedExperience @NoStock @P2
  @tms:UTR-11099
  Scenario Outline: No stock message - message is displayed on PDP for normal size product with no stock for at least 1 size
    Given There is 1 normal size product style of locale <locale> where 1 size is out of stock with inventory between 5 and 9999
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
      And I get translation from lokalise for "SizeOutOfStockText" and store it with key #NoStockMessage
      And I wait until the current page is loaded
    When I click on ProductDetailPage.Pdp.SizeSoldOutButton
    Then I see ProductDetailPage.Pdp.NoStockMessage is displayed
      And I see ProductDetailPage.Pdp.NoStockMessage contains text "#NoStockMessage"
      And I see ProductDetailPage.Pdp.NoStockDot is displayed
    When in unified PDP I select size by sku part number #skuPartNumber
    Then I see ProductDetailPage.Pdp.NoStockMessage is not displayed
      And I see ProductDetailPage.Pdp.NoStockDot is not displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PDP @TEE @UnifiedPdp @UnifiedExperience @NoStock @P2
  @tms:UTR-11100
  Scenario Outline: No stock message - message is displayed on PDP for normal size product with all sizes out of stock
    Given There is 1 normal size product style of locale <locale> with inventory between 0 and 0
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I get translation from lokalise for "SoldOutText" and store it with key #NoStockMessage
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.NoStockMessage is displayed
      And I see ProductDetailPage.Pdp.NoStockMessage contains text "#NoStockMessage"
      And I see ProductDetailPage.Pdp.NoStockDot is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PDP @TEE @UnifiedPdp @UnifiedExperience @NoStock @P2
  @tms:UTR-11101
  Scenario Outline: No stock message - message is displayed on PDP for out of stock one size product
    Given There is 1 one size product style of locale <locale> with inventory between 0 and 0
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I get translation from lokalise for "SoldOutText" and store it with key #NoStockMessage
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.NoStockMessage is displayed
      And I see ProductDetailPage.Pdp.NoStockMessage contains text "#NoStockMessage"
      And I see ProductDetailPage.Pdp.NoStockDot is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @LowOnStock @P2
  @tms:UTR-11073
  Scenario Outline: Low on stock message - Low on stock quantity should update when the users adds the product to bag
    Given There is 1 normal size product item of locale <locale> with inventory between <inventory> and <inventory>
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I extract a product item from product style product1#styleColourPartNumber which has stock equals <inventory> saved as #skuPartNumber
      And I wait until the current page is loaded
    When in unified PDP I select size by sku part number #skuPartNumber
    Then I see ProductDetailPage.Pdp.LowStockMessage contains text "<inventory>"
    When I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see ProductDetailPage.Pdp.LowStockMessage contains text "<reducedInventory>"

    Examples:
      | locale  | inventory | reducedInventory |
      | default | 2         | 1                |