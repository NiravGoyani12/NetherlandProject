Feature: Unified PDP - SEO

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Seo @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13193
  Scenario Outline: Img Alt text - Alt text is present on PDP images
    Given There are 2 normal size product style of locale <locale> with inventory between 10 and 99999
    When I am on locale <locale> pdp page for product style product2#styleColourPartNumber with accepted cookies
    Then I see the count of elements ProductDetailPage.Pdp.ProductImagesWithAltText is greater than 0

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Seo @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13194
  Scenario Outline: Img Alt text - Verify alt text changes when selecting a different combi on PDP
    Given There is 1 multi colour product with at least 2 colours of locale <locale> with inventory between 10 and 99999
      And I extract product style from product product1#stylePartNumber with index 0 saved as #styleColourPartNumber1
    When I am on locale <locale> pdp page for product style #styleColourPartNumber1 with accepted cookies
      And I store the value of attribute alt of element ProductDetailPage.Pdp.ProductImagesWithAltText with key #altText
      And I scroll to and click on ProductDetailPage.Pdp.ColorSwatchButton with index 2
    Then the value of attribute alt of element ProductDetailPage.Pdp.ProductImagesWithAltText should not be equal to the stored value with key #altText

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Seo @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13195
  Scenario Outline: Img Alt text - Verify the content of alternate text
    Given There are 2 normal size product items of locale <locale> with inventory between 10 and 99999
      And I am on locale <locale> pdp page for product style product2#styleColourPartNumber with accepted cookies
      And I fetch colour name of product item product2#skuPartNumber saved as #productColor
      And I store the value of ProductDetailPage.Pdp.ProductName with key #productName
    Then the value of attribute alt of element ProductDetailPage.Pdp.ProductImagesWithAltText should contain the stored value with key #productColor
      And the value of attribute alt of element ProductDetailPage.Pdp.ProductImagesWithAltText should contain the stored value with key #productName

    Examples:
      | locale  |
      | default |