Feature: Unified Search PLP - Price Format

  @FullRegression
  @UnifiedSearchPLP
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @ProductPrices @UnifiedPLP @UnifiedExperience @EESK @P2
  @tms:UTR-15738
  Scenario Outline: Unified Search PLP - Verify price format on Unified Search PLP
    Given I am on locale <locale> <category> glp page of langCode <langCode> with forced accepted cookies
    When I navigate to page <page>
      And I wait until page Experience.PlpProducts is loaded
      And I get price format for current locale and store it with key #priceFormat
    Then the value of Experience.PlpProducts.ProductsPrice with index 1 should match regex pattern "#priceFormat"
      And the value of Experience.PlpProducts.ProductsPrice with index 2 should match regex pattern "#priceFormat"
      And the value of Experience.PlpProducts.ProductsPrice with index 3 should match regex pattern "#priceFormat"
      And in unified PLP I click next page button
    When in unified PLP I scroll down to the 48 listing item
    Then the value of Experience.PlpProducts.ProductsPrice with index 46 should match regex pattern "#priceFormat"
      And the value of Experience.PlpProducts.ProductsPrice with index 47 should match regex pattern "#priceFormat"
      And the value of Experience.PlpProducts.ProductsPrice with index 48 should match regex pattern "#priceFormat"

    @RCTest
    Examples:
      | locale | langCode | page       | category |
      | uk     | default  | search-plp | men      |
      | uk     | default  | search-plp | women    |


  @FullRegression
  @UnifiedSearchPLP
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending
  @ProductPrices @UnifiedPLP @UnifiedExperience @Filter @EESK @P2
  @tms:UTR-15739
  Scenario Outline: Unified Search PLP - Verify price format on price filter
    Given I am on locale <locale> search page with search term "<searchTerm>" with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified PLP I ensure filter panel is opened
    Then the numeric value of Experience.PlpFilters.PriceFilterMin <state> match regex pattern "<priceFormat>"
      And I see Experience.PlpFilters.PriceFilterMin contains text "<currencySymbol>"
      And the numeric value of Experience.PlpFilters.PriceFilterMax <state> match regex pattern "<priceFormat>"
      And I see Experience.PlpFilters.PriceFilterMax contains text "<currencySymbol>"

    Examples:
      | locale | priceFormat   | state  | currencySymbol | searchTerm |
      | uk     | [0-9]+.\d{2}  | should | £              | shirt      |
      | uk     | [0-9]+\.\d{2} | should | £              | shirt      |
# | cz     | [0-9]+\,\d{2} | should | Kč             | shirt      |
# | dk     | [0-9]+\.\d{2} | should | kr             | shirt      |
# | se     | [0-9]+\.\d{2} | should | kr             | shirt      |
# | nl     | [0-9]+\,\d{2} | should | €              | shirt      |