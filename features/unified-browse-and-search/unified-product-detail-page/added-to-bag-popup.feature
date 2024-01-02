Feature: Unified PDP - Mini shopping bag

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @AddedToBag @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13432
  Scenario Outline: Added to bag - I see added to bag popup when product is added to cart
    Given There is 1 normal size product item of locale <locale> with inventory between 100 and 9999
      And I am on locale <locale> pdp page of langCode default for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
    When in unified PDP I select size by sku part number product1#skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see Experience.AddToBagPopUp.MainBlock is displayed in 5 seconds
      And I see Experience.AddToBagPopUp.ImageContainer is displayed in
      And I wait for 6 seconds
    Then I see Experience.AddToBagPopUp.MainBlock is not displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @AddedToBag @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13433
  Scenario Outline: Added to bag - I see product info when I add Normal Size product in Added to bag panel from PDP
    Given There are 1 normal size product item of locale <locale> and langCode <langCode> with inventory between 200 and 99999
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I extract product item detail by sku part number product1#skuPartNumber
      And I wait until the current page is loaded
    When in unified PDP I select size by sku part number product1#skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see Experience.AddToBagPopUp.MainBlock is displayed in 5 seconds
      And in unified added to bag panel I see content is matched to product item by sku part number product1#skuPartNumber

    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @AddedToBag @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13434
  Scenario Outline: Added to bag - I see product info when I add disounted product in Added to bag panel from PDP
    Given There is 1 discounted product items of locale <locale> with inventory between 1 and 9999
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
    When in unified PDP I select size by sku part number product1#skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see Experience.AddToBagPopUp.MainBlock is displayed in 5 seconds
      And in unified added to bag panel I see content is matched to product item by sku part number product1#skuPartNumber

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @AddedToBag @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13485 @ExcludeCK
  Scenario Outline: Added to bag - I see product info when I add width-length product in Added to bag panel from PDP
    Given There is 1 width-length size product item of locale <locale> with inventory between 10 and 99999 filtered by FH
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
    When in unified PDP I select size by sku part number product1#skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see Experience.AddToBagPopUp.MainBlock is displayed in 5 seconds
      And in unified added to bag panel I see content is matched to product item by sku part number product1#skuPartNumber

    Examples:
      | locale  |
      | default |