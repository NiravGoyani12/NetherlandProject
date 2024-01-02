Feature: Unified SEO - Facetted filters

  # Facetted urls are enabled for the given categories in DB0
  @FullRegression
  @Desktop @Translation
  @Chrome @FireFox @Safari @SEOFacettedFilter
  @Seo @UnifiedTEX
  @feature:TEX-12892,TEX-12897
  @tms:UTR-17678
  Scenario Outline: Unified PLP SEO facetted filters - Verify canonical url when seo colour facetted filters are applied and should consist translated colours
    Given I extract seo url of <categoryId> for locale <locale> of langCode <langCode> saved as #categoryUrl
    When I am on locale <locale> of url #categoryUrl of langCode <langCode> with forced accepted cookies
      And I wait until the current page is loaded
      And I store the value of Experience.PlpHeader.PageHeader with key #initialHeaderText
      And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option faceted
      And I wait until the current page is loaded
      And I get translation for "Black" and store it with key #Colour
      And I get translation for "htmlLang" and store it with key #<htmlLang>
    Then I see URL should contain "#Colour"
    When I refresh page
      And I wait until the current page is loaded
      And I save current url as key #PlpUrl
      And I store the value of BasePage.TitleTag with key #pageTitle
      And I store the value of attribute content of element BasePage.Metatag with value description with key #pageDescription
      #properties
      And I wait for 2 seconds
    Then I see the attribute content of element BasePage.Metatag with value robots containing "noodp,noydir,index,follow,archive"
      And I see the attribute content of element BasePage.MetaProperty with value og:url containing "#PlpUrl"
      And I see the attribute content of element BasePage.MetaProperty with value og:type containing "website"
      And I see the attribute content of element BasePage.MetaProperty with value og:title containing "#pageTitle"
      And I see the attribute content of element BasePage.MetaProperty with value og:description containing "#pageDescription"
      And I see BasePage.MetaProperty with value og:image is existing
      And I see the attribute content of element BasePage.MetaProperty with value og:locale containing "#<htmlLang>"
      #links
      And I see the value of attribute href of element BasePage.MetaLink with value canonical should be equal to the stored value with key #PlpUrl

    @ExcludeCK @P1
    Examples:
      | locale | langCode | categoryId              | gender | translationKey | filterType | filterOption |
      | nl     | default  | th_women_clothing_jeans | women  | WomenGLP       | Colour     | Black        |

    @ExcludeCK @P2
    Examples:
      | locale | langCode | categoryId              | gender | translationKey | filterType | filterOption |
      | nl     | EN       | th_women_clothing_jeans | women  | WomenGLP       | Colour     | Black        |

    @ExcludeTH @P1
    Examples:
      | locale | langCode | categoryId             | gender | translationKey | filterType | filterOption |
      | uk     | default  | women_clothes_t-shirts | women  | WomenGLP       | Colour     | Black        |

    @ExcludeTH @P2
    Examples:
      | locale | langCode | categoryId             | gender | translationKey | filterType | filterOption |
      | be     | FR       | women_clothes_t-shirts | women  | WomenGLP       | Colour     | Black        |
