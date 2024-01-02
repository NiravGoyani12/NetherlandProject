Feature: Unified wishlist - Filled wishlist page price format

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Filled
  @ProductPrices@WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  # @tms:UTR-3851
  Scenario Outline: Unifed wishlist - Verify price format with decimals on unified wislist page
    Given There is 1 any product item of locale <locale> with inventory between 50 and 9999 
    When I am on locale <locale> wish list page for product style product1#styleColourPartNumber with forced accepted cookies
      And I fetch current price of product item product1#skuPartNumber saved as #currentPrice
      And I wait until the count of elements Experience.Wishlist.ProductCurrentPrice is equal to 1
      And I get price format for current locale and store it with key #priceFormat
      And I get currency code for current locale and store it with key #expectedCurrency
    Then the value of Experience.Wishlist.ProductCurrentPrice should match regex pattern "#priceFormat"

    @P2
    Examples:
      | locale  |
      | default |

    Examples:
      | locale           |
      | multiLangDefault |
      | cz               |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Filled
  @ProductPrices @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  # @tms:UTR-3853
  Scenario Outline: Unifed wishlist - Verify markdown price format with decimals on WLP and Add to bag popup
    Given There is 1 discounted product style with same current price of locale <locale> 
    When I am on locale <locale> wish list page for product style product1#styleColourPartNumber with accepted cookies
      And I wait until the count of elements Experience.Wishlist.ProductCurrentPrice is equal to 1
      And I get price format for current locale and store it with key #priceFormat
      And I get currency code for current locale and store it with key #expectedCurrency
    Then the value of Experience.Wishlist.ProductCurrentPrice should match regex pattern "#priceFormat"
      And the value of Experience.Wishlist.ProductWasPrice should match regex pattern "#priceFormat"
    When I fetch currency of product style product1#styleColourPartNumber saved as #currency
    Then I see the stored value with key #currency is equal to "#expectedCurrency"

    @RCTest @P2
    Examples:
      | locale |
      | ee     |
      | uk     |

    @ExcludeDB0
    Examples:
      | locale |
      | fr     |
      | es     |
      | pl     |
