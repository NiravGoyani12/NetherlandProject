Feature: Unified SEO

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Seo @TEX @P2 @UnifiedTEX @UnifiedPLP @UnifiedExperience
  @feature:TEX-14893
  @tms:UTR-14926 @issue:TEX-15331
  Scenario Outline: Unified Meta Tag - Validate robots tag for DE-EN/NL-EN set to no-index on homepage,pdp,wlp,plp,shopping-bag and glp until sitemap issues is resolved.
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    Then I see the attribute content of element BasePage.Metatag with value robots containing "noindex,nofollow"
      And the count of elements BasePage.Metatag with value robots is equal to 1
    When I navigate to page pdp
      And I wait until the current page is loaded
    Then I see the attribute content of element BasePage.Metatag with value robots containing "noindex,nofollow"
      And the count of elements BasePage.Metatag with value robots is equal to 1
    When I navigate to page wlp
      And I wait until the current page is loaded
    Then I see the attribute content of element BasePage.Metatag with value robots containing "noindex,nofollow"
    When I navigate to page plp
      And I wait until the current page is loaded
    Then I see the attribute content of element BasePage.Metatag with value robots containing "noindex,nofollow"
      And the count of elements BasePage.Metatag with value robots is equal to 1
    When I navigate to page shopping-bag
      And I wait until the current page is loaded
    Then I see the attribute content of element BasePage.Metatag with value robots containing "noindex,nofollow"
    When I navigate to page glp
      And I wait until the current page is loaded
    Then I see the attribute content of element BasePage.Metatag with value robots containing "noindex,nofollow"
      And I move to the bottom of the page
      And in unified footer I ensure Experience.Footer.CountryDropdown is interactable
    When in dropdown Experience.Footer.LanguageDropdown I select the option by text "<defaultLang>"
      And I click on Experience.Footer.CountrySwitchButton
      And I wait until the current page is loaded
      And I wait for 2 seconds
    Then I see the attribute content of element BasePage.Metatag with value robots containing "noodp,noydir,index,follow,archive"
      And the count of elements BasePage.Metatag with value robots is equal to 1

    Examples:
      | locale | langCode | defaultLang |
      | de     | EN       | Deutsch     |
      | nl     | EN       | Nederlands  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @UnifiedPLP @UnifiedExperience
  @feature:TEX-14893 @UnifiedTEX
  @Seo @TEX @P2
  @tms:UTR-14927
  Scenario Outline: Unified Meta Tag - Validate robots tag for DE-DE/NL-NL default language is set indexable on homepage,pdp,plp and glp and non-indexable on wlp and shoppingbag.
    Given I am on locale <locale> home page of langCode default with forced accepted cookies
    Then I see the attribute content of element BasePage.Metatag with value robots containing "noodp,noydir,index,follow,archive"
      And the count of elements BasePage.Metatag with value robots is equal to 1
    When I navigate to page pdp
      And I wait until the current page is loaded
    Then I see the attribute content of element BasePage.Metatag with value robots containing "noodp,noydir,index,follow,archive"
      And the count of elements BasePage.Metatag with value robots is equal to 1
    When I navigate to page wlp
      And I wait until the current page is loaded
    Then I see the attribute content of element BasePage.Metatag with value robots containing "noindex,nofollow"
    When I navigate to page plp
      And I wait until the current page is loaded
    Then I see the attribute content of element BasePage.Metatag with value robots containing "noodp,noydir,index,follow,archive"
      And the count of elements BasePage.Metatag with value robots is equal to 1
    When I navigate to page shopping-bag
      And I wait until the current page is loaded
    Then I see the attribute content of element BasePage.Metatag with value robots containing "noindex,nofollow"
    When I navigate to page glp
      And I wait until the current page is loaded
    Then I see the attribute content of element BasePage.Metatag with value robots containing "noodp,noydir,index,follow,archive"

    Examples:
      | locale |
      | de     |
      | nl     |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @feature:TEX-15675 @UnifiedTEX
  @Seo @TEX @P2 @UnifiedPLP @UnifiedExperience
  @tms:UTR-16623
  Scenario Outline: Unified Meta Tag - Verify that the user gets oops page when navigating to non compatable language for the locale and page is not indexed.
    Given I am on locale <locale> of url <url> with accepted cookies
      And I wait until the current page is loaded
    Then I see BasePage.ErrorPage is displayed
      And I see the attribute content of element BasePage.Metatag with value robots containing "noindex,nofollow"

    Examples:
      | locale | url                    |
      | uk     | /PL/mens-pyjamas       |
      | uk     | /DE/mens-coats-jackets |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @feature:TEX-15675 @UnifiedTEX
  @Seo @TEX @P2 @UnifiedPLP @UnifiedExperience
  @tms:UTR-17706
  Scenario Outline: Unified SEO Meta Tag - Verify the canonicals and page are correct when adding trailing slash to the url
    Given I am on locale <locale> of url <url> with accepted cookies
      And I wait until the current page is loaded
    Then I see the current page is <page>
      And I see the attribute href of element BasePage.MetaLink with value canonical not containing "<url>"
      And I see the attribute href of element BasePage.MetaLink with value canonical containing "<expectedUrl>"

    Examples:
      | locale | url                  | expectedUrl         | page |
      | uk     | /women/              | /women              | GLP  |
      | be     | /dames-jassen-jacks/ | /dames-jassen-jacks | PLP  |

    @SecondaryLang @issue:TEX-15820
    Examples:
      | locale | url                | expectedUrl       | page |
      | nl     | /EN/mens-t-shirts/ | /EN/mens-t-shirts | PLP  |

    @issue:EESCK-12742
    Examples:
      | locale | url               | expectedUrl      | page         |
      | de     | /EN/shopping-bag/ | /EN/shopping-bag | shopping-bag |
      | nl     | /EN/wishlist/     | /EN/wishlist     | wlp          |