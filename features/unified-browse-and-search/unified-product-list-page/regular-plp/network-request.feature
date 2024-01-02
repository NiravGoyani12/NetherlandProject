Feature: Unified PLP - network requests

  @FullRegression
  @Desktop
  @Chrome @FireFox @TEX
  @UnifiedPLP @UnifiedExperience @UnifiedTEX
  @feature:TEX-13539
  @tms:UTR-14299
  Scenario Outline: Unified PLP - Verify that product?filter call is not made at client side when landing on plp,search-plp or pdp.
    Given I extract seo url of <categoryId> for locale <locale> saved as #categoryUrl
      And I am on locale <locale> of url #categoryUrl with forced accepted cookies
      And I wait until the current page is loaded
    Then I expect 0 network request named products?filter of type fetch to be processed in 10 seconds
    When I navigate to page search-plp
      And I wait until the current page is loaded
    Then I expect 0 network request named products?filter of type fetch to be processed in 10 seconds
    When I navigate to page pdp
      And I wait until the current page is loaded
    Then I expect 0 network request named products?filter of type fetch to be processed in 10 seconds

    @ExcludeCK
    Examples:
      | locale | langCode | categoryId              |
      | uk     | default  | th_women_clothing_jeans |

    @ExcludeTH
    Examples:
      | locale | itemIndex | categoryId           |
      | uk     | default   | MEN_CLOTHES_T-SHIRTS |

  @FullRegression
  @Desktop
  @Chrome @FireFox @TEX
  @UnifiedPLP @UnifiedExperience @UnifiedTEX
  @feature:TEX-13539
  @tms:UTR-16624
  Scenario Outline: Unified PLP - Verify that product?filter call is not made for elevated PLP
    Given I am on locale <locale> of url <elevatedPlpUrl> of langCode <langCode> with accepted cookies
      And I wait until the current page is loaded
    Then I expect 0 network request named products?filter of type fetch to be processed in 10 seconds

    #Test is specific to UK locale and disney url. CK doesnt have elevated PLP yet
    @ExcludeCK
    Examples:
      | locale | langCode | elevatedPlpUrl     |
      | uk     | default  | disney-x-tommy-men |