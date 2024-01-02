Feature: Unified PLP - Price Format

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @ProductPrices @PLP @UnifiedPLP @UnifiedExperience @EESK @P2
  @tms:UTR-15334
  Scenario Outline: Unified PLP - Verify price format on unified PLP
    Given I am on category <categoryId> page of locale <locale> of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
    When I get price format for current locale and store it with key #priceFormat
    Then the value of Experience.PlpProducts.ProductsPrice with index 1 should match regex pattern "#priceFormat"
      And the value of Experience.PlpProducts.ProductsPrice with index 2 should match regex pattern "#priceFormat"
      And the value of Experience.PlpProducts.ProductsPrice with index 3 should match regex pattern "#priceFormat"
    When in unified PLP I click next page button 1 times
    Then the value of Experience.PlpProducts.ProductsPrice with index 1 should match regex pattern "#priceFormat"
      And the value of Experience.PlpProducts.ProductsPrice with index 2 should match regex pattern "#priceFormat"
      And the value of Experience.PlpProducts.ProductsPrice with index 3 should match regex pattern "#priceFormat"

    @ExcludeTH
    Examples:
      | locale | langCode | categoryId             |
      | uk     | default  | women_clothes_t-shirts |

    @ExcludeCK
    Examples:
      | locale | langCode | categoryId              |
      | uk     | default  | th_women_clothing_jeans |