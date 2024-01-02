Feature: Unified XO - PLP

  # XO configuration is done on these particular PLPs to display items
  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @ExcludeUat
  @UnifiedExperience @UnifiedXo @TEX
  @feature:TEX-15523,TEX-15076
  @tms:UTR-17288
  Scenario Outline: Unified XO From Unified PLP - In Recently viewed in PLP, I can open PDP and the items count remain 48 in PLP with Recommendations
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
      And I force the url with a xo-widget-id <xoWidgetId>
    Then I expect at least 1 network request named api.early-birds.fr/widget of type fetch to be processed in 10 seconds
      And the count of elements Experience.PlpProducts.ProductGridItems is equal to 48
    When I scroll to and click on Experience.Recommendations.PlpRecentlyViewedItem with index 1
      And I wait until the current page is loaded
    Then I see the current page is PDP
      And in unified PDP I see product info is matched to product style by style colour number <styleColourPartNumber>

    @ExcludeTH @P2
    Examples:
      | locale  | langCode | categoryId                 | xoWidgetId               | styleColourPartNumber |
      | default | default  | WOMEN_CLOTHES_JACKETSCOATS | 63b6bb75f616cce339184d4f | J20J213178YAF         |

# @ExcludeCK @P2
# Examples:
#   | locale  | langCode | categoryId              | xoWidgetId               | styleColourPartNumber |
#   | default | default  | th_women_clothing_jeans | 63b567c9c466f7573189c3ac | WW0WW11860410         |
