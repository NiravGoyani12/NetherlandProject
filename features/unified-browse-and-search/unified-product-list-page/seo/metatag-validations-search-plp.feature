Feature: Unified Search PLP - SEO

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @UnifiedTEX
  @Seo @PLP @TEX @UnifiedPLP @UnifiedExperience
  @feature:TEX-15382 @Translation
  @tms:UTR-15850 @ExcludeCK @SearchPLP
  @issue:EESK-5212
  Scenario Outline: Unified Search PLP - TH - Metatag validations - Validate the meta tags on search plp
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page search-plp
      And I wait until page Experience.PlpProducts is loaded
      And I get translation for "htmlLang" and store it with key #<htmlLang>
      And I save current url as key #PlpUrl
      And I store the value of BasePage.TitleTag with key #pageTitle
      And I store the value of attribute content of element BasePage.Metatag with value description with key #pageDescription
    #tags
    Then I see BasePage.Metatag with value description is existing
      And I see the attribute content of element BasePage.MetatagHttpEquiv with value X-UA-Compatible containing "IE=edge"
      And I see the attribute content of element BasePage.MetatagHttpEquiv with value Content-Type containing "text/html; charset=utf-8"
      And I see the attribute content of element BasePage.Metatag with value robots containing "noindex,nofollow"
      And I see the attribute content of element BasePage.Metatag with value viewport containing "width=device-width, initial-scale=1, maximum-scale=1"
      And I see the attribute content of element BasePage.Metatag with value mobile-web-app-capable containing "yes"
      And I see the attribute content of element BasePage.Metatag with value apple-mobile-web-app-capable containing "yes"
      And I see the attribute content of element BasePage.Metatag with value application-name containing "Tommy"
      And I see the attribute content of element BasePage.Metatag with value apple-mobile-web-app-title containing "Tommy"
      And I see the attribute content of element BasePage.Metatag with value theme-color containing "#00174f"
      And I see the attribute content of element BasePage.Metatag with value msapplication-navbutton-color containing "#00174f"
      And I see the attribute content of element BasePage.Metatag with value apple-mobile-web-app-status-bar-style containing "black-translucent"
      And I see the attribute content of element BasePage.Metatag with value msapplication-starturl containing "/"
      #properties
      And I wait for 2 seconds
      And I see the attribute content of element BasePage.MetaProperty with value og:url containing "#PlpUrl"
      And I see the attribute content of element BasePage.MetaProperty with value og:type containing "website"
      And I see the attribute content of element BasePage.MetaProperty with value og:title containing "#pageTitle"
      And I see the attribute content of element BasePage.MetaProperty with value og:description containing "#pageDescription"
      And I see BasePage.MetaProperty with value og:image is existing
      And I see the attribute content of element BasePage.MetaProperty with value og:locale containing "#<htmlLang>"
      #links
      And I see the value of attribute href of element BasePage.MetaLink with value canonical should be equal to the stored value with key #PlpUrl
      And I see the attribute rel of element BasePage.MetaLink with value //logx.optimizely.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //cdn3.optimizely.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //cdn.optimizely.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //tags.tommy.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //tommy-europe.scene7.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value https://eu-images.contentstack.com/ containing "preconnect"
      And I see the attribute href of element BasePage.MetaLink with value manifest containing "manifest.json"
      #scripts
      # redundant as geo-targetting is not used
      # And I see BasePage.Script with value //cdn3.optimizely.com/js/geo4.js is existing
      And I see BasePage.Script with value https://cdn.optimizely.com/js/25972262115.js is existing
      And I see BasePage.Script with value https://cdn.optimizely.com/js/26081140005.js is existing
      And I see BasePage.Script with value //tags.tommy.com/tommyhilfiger-eu/dev/utag.js is existing
      #In search page no breadcrumb is present hence no application/ld+json
      And I see BasePage.Script with value application/ld+json is not existing

    @P1
    Examples:
      | locale  | langCode | categoryId                   |
      | default | default  | TH_MEN_CLOTHING_COATSJACKETS |

    @ExcludeUat
    Examples:
      | locale  | langCode | categoryId                   |
      | default | default  | TH_MEN_CLOTHING_COATSJACKETS |

    @ExcludeDB0
    Examples:
      | locale | langCode | categoryId                   |
      | ch     | IT       | TH_MEN_CLOTHING_COATSJACKETS |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @UnifiedTEX
  @Seo @PLP @TEX @UnifiedPLP @UnifiedExperience @issue:TEX-15555
  @feature:TEX-15382 @Translation
  @tms:UTR-15851 @ExcludeCK @SearchPLP
  Scenario Outline: Unified Search PLP - TH - Metatag validations - Validate the meta tags on search plp pagination on second page
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page search-plp
      And I wait until page Experience.PlpProducts is loaded
    When in unified PLP I click next page button 1 times
    Then I see Experience.PlpPagination.CurrentPageNumber is displayed
      And I see Experience.PlpPagination.CurrentPageNumber contains text "2"
      And I get translation for "htmlLang" and store it with key #<htmlLang>
      And I save current url as key #PlpUrl
      And I store the value of BasePage.TitleTag with key #pageTitle
      And I store the value of attribute content of element BasePage.Metatag with value description with key #pageDescription
    #tags
    Then I see BasePage.Metatag with value description is existing
      And I see the attribute content of element BasePage.MetatagHttpEquiv with value X-UA-Compatible containing "IE=edge"
      And I see the attribute content of element BasePage.MetatagHttpEquiv with value Content-Type containing "text/html; charset=utf-8"
      And I see the attribute content of element BasePage.Metatag with value robots containing "noindex,nofollow"
      And I see the attribute content of element BasePage.Metatag with value viewport containing "width=device-width, initial-scale=1, maximum-scale=1"
      And I see the attribute content of element BasePage.Metatag with value mobile-web-app-capable containing "yes"
      And I see the attribute content of element BasePage.Metatag with value apple-mobile-web-app-capable containing "yes"
      And I see the attribute content of element BasePage.Metatag with value application-name containing "Tommy"
      And I see the attribute content of element BasePage.Metatag with value apple-mobile-web-app-title containing "Tommy"
      And I see the attribute content of element BasePage.Metatag with value theme-color containing "#00174f"
      And I see the attribute content of element BasePage.Metatag with value msapplication-navbutton-color containing "#00174f"
      And I see the attribute content of element BasePage.Metatag with value apple-mobile-web-app-status-bar-style containing "black-translucent"
      And I see the attribute content of element BasePage.Metatag with value msapplication-starturl containing "/"
      #properties
      And I wait for 2 seconds
      And I see the attribute content of element BasePage.MetaProperty with value og:url containing "#PlpUrl"
      And I see the attribute content of element BasePage.MetaProperty with value og:type containing "website"
      And I see the attribute content of element BasePage.MetaProperty with value og:title containing "#pageTitle"
      And I see the attribute content of element BasePage.MetaProperty with value og:description containing "#pageDescription"
      And I see BasePage.MetaProperty with value og:image is existing
      And I see the attribute content of element BasePage.MetaProperty with value og:locale containing "#<htmlLang>"
      #links
      And I see the value of attribute href of element BasePage.MetaLink with value canonical should be equal to the stored value with key #PlpUrl
      And I see the attribute rel of element BasePage.MetaLink with value //logx.optimizely.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //cdn3.optimizely.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //cdn.optimizely.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //tags.tommy.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //tommy-europe.scene7.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value https://eu-images.contentstack.com/ containing "preconnect"
      And I see the attribute href of element BasePage.MetaLink with value manifest containing "manifest.json"
      #scripts
      # redundant as geo-targetting is not used
      # And I see BasePage.Script with value //cdn3.optimizely.com/js/geo4.js is existing
      And I see BasePage.Script with value https://cdn.optimizely.com/js/25972262115.js is existing
      And I see BasePage.Script with value https://cdn.optimizely.com/js/26081140005.js is existing
      And I see BasePage.Script with value //tags.tommy.com/tommyhilfiger-eu/dev/utag.js is existing
      #In search page no breadcrumb is present hence no application/ld+json
      And I see BasePage.Script with value application/ld+json is not existing

    Examples:
      | locale  | langCode | categoryId                   |
      | default | default  | TH_MEN_CLOTHING_COATSJACKETS |

    @ExcludeUat
    Examples:
      | locale | langCode | categoryId                   |
      | lu     | DE       | TH_MEN_CLOTHING_COATSJACKETS |

    @ExcludeDB0
    Examples:
      | locale | langCode | categoryId                   |
      | ch     | default  | TH_MEN_CLOTHING_COATSJACKETS |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @UnifiedTEX
  @Seo @PLP @TEX @UnifiedPLP @UnifiedExperience
  @feature:TEX-15382 @Translation @feature:EESK-5552
  @tms:UTR-15852 @ExcludeTH @SearchPLP
  Scenario Outline: Unified Search PLP - CK - Metatag validations - Validate the meta tags on search plp
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page search-plp
      And I wait until page Experience.PlpProducts is loaded
      And I get translation for "htmlLang" and store it with key #<htmlLang>
      And I save current url as key #PlpUrl
      And I store the value of BasePage.TitleTag with key #pageTitle
      And I store the value of attribute content of element BasePage.Metatag with value description with key #pageDescription
    #tags
    Then I see BasePage.Metatag with value description is existing
      And I see the attribute content of element BasePage.MetatagHttpEquiv with value X-UA-Compatible containing "IE=edge"
      And I see the attribute content of element BasePage.MetatagHttpEquiv with value Content-Type containing "text/html; charset=utf-8"
      And I see the attribute content of element BasePage.Metatag with value robots containing "noindex,nofollow"
      And I see the attribute content of element BasePage.Metatag with value viewport containing "width=device-width, initial-scale=1, maximum-scale=1"
      And I see the attribute content of element BasePage.Metatag with value mobile-web-app-capable containing "yes"
      And I see the attribute content of element BasePage.Metatag with value apple-mobile-web-app-capable containing "yes"
      And I see the attribute content of element BasePage.Metatag with value application-name containing "CK"
      And I see the attribute content of element BasePage.Metatag with value apple-mobile-web-app-title containing "CK"
      And I see the attribute content of element BasePage.Metatag with value theme-color containing "#000000"
      And I see the attribute content of element BasePage.Metatag with value msapplication-navbutton-color containing "#000000"
      And I see the attribute content of element BasePage.Metatag with value apple-mobile-web-app-status-bar-style containing "black-translucent"
      And I see the attribute content of element BasePage.Metatag with value msapplication-starturl containing "/"
      #properties
      And I wait for 2 seconds
      And I see the attribute content of element BasePage.MetaProperty with value og:url containing "#PlpUrl"
      And I see the attribute content of element BasePage.MetaProperty with value og:type containing "website"
      And I see the attribute content of element BasePage.MetaProperty with value og:title containing "#pageTitle"
      And I see the attribute content of element BasePage.MetaProperty with value og:description containing "#pageDescription"
      And I see BasePage.MetaProperty with value og:image is existing
      And I see the attribute content of element BasePage.MetaProperty with value og:locale containing "#<htmlLang>"
      #links
      And I see the value of attribute href of element BasePage.MetaLink with value canonical should be equal to the stored value with key #PlpUrl
      And I see the attribute rel of element BasePage.MetaLink with value //logx.optimizely.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //cdn3.optimizely.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //cdn.optimizely.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value <metalinkTag> containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //calvinklein-eu.scene7.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value https://eu-images.contentstack.com/ containing "preconnect"
      And I see the attribute href of element BasePage.MetaLink with value manifest containing "manifest.json"
      #scripts
      And I see BasePage.Script with value https://cdn.optimizely.com/js/25575180516.js is existing
      And I see BasePage.Script with value https://cdn.optimizely.com/js/26160661174.js is existing
      And I see BasePage.Script with value <metalinkTag>/calvinklein-eu/dev/utag.js is existing
      #In search page no breadcrumb is present hence no application/ld+json
      And I see BasePage.Script with value application/ld+json is not existing

    @P1
    Examples:
      | locale | langCode | categoryId           | metalinkTag           |
      | ee     | default  | MEN_CLOTHES_T-SHIRTS | //tags.calvinklein.ee |

    @ExcludeUat
    Examples:
      | locale | langCode | categoryId           | metalinkTag           |
      | lu     | DE       | MEN_CLOTHES_T-SHIRTS | //tags.calvinklein.lu |

    @ExcludeDB0
    Examples:
      | locale | langCode | categoryId           | metalinkTag           |
      | ch     | default  | MEN_CLOTHES_T-SHIRTS | //tags.calvinklein.ch |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @UnifiedTEX
  @Seo @PLP @TEX @UnifiedPLP @UnifiedExperience @P2 @issue:TEX-15555
  @feature:TEX-15382 @Translation
  @tms:UTR-15853 @ExcludeTH @SearchPLP
  Scenario Outline: Unified Search PLP - CK - Metatag validations - Validate the meta tags on search plp pagination on second page
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page search-plp
      And I wait until page Experience.PlpProducts is loaded
    When in unified PLP I click next page button 1 times
    Then I see Experience.PlpPagination.CurrentPageNumber is displayed
      And I get translation for "htmlLang" and store it with key #<htmlLang>
      And I save current url as key #PlpUrl
      And I store the value of BasePage.TitleTag with key #pageTitle
      And I store the value of attribute content of element BasePage.Metatag with value description with key #pageDescription
    #tags
    Then I see BasePage.Metatag with value description is existing
      And I see the attribute content of element BasePage.MetatagHttpEquiv with value X-UA-Compatible containing "IE=edge"
      And I see the attribute content of element BasePage.MetatagHttpEquiv with value Content-Type containing "text/html; charset=utf-8"
      And I see the attribute content of element BasePage.Metatag with value robots containing "noindex,nofollow"
      And I see the attribute content of element BasePage.Metatag with value viewport containing "width=device-width, initial-scale=1, maximum-scale=1"
      And I see the attribute content of element BasePage.Metatag with value mobile-web-app-capable containing "yes"
      And I see the attribute content of element BasePage.Metatag with value apple-mobile-web-app-capable containing "yes"
      And I see the attribute content of element BasePage.Metatag with value application-name containing "CK"
      And I see the attribute content of element BasePage.Metatag with value apple-mobile-web-app-title containing "CK"
      And I see the attribute content of element BasePage.Metatag with value theme-color containing "#000000"
      And I see the attribute content of element BasePage.Metatag with value msapplication-navbutton-color containing "#000000"
      And I see the attribute content of element BasePage.Metatag with value apple-mobile-web-app-status-bar-style containing "black-translucent"
      And I see the attribute content of element BasePage.Metatag with value msapplication-starturl containing "/"
      #properties
      And I wait for 2 seconds
      And I see the attribute content of element BasePage.MetaProperty with value og:url containing "#PlpUrl"
      And I see the attribute content of element BasePage.MetaProperty with value og:type containing "website"
      And I see the attribute content of element BasePage.MetaProperty with value og:title containing "#pageTitle"
      And I see the attribute content of element BasePage.MetaProperty with value og:description containing "#pageDescription"
      And I see BasePage.MetaProperty with value og:image is existing
      And I see the attribute content of element BasePage.MetaProperty with value og:locale containing "#<htmlLang>"
      #links
      And I see the value of attribute href of element BasePage.MetaLink with value canonical should be equal to the stored value with key #PlpUrl
      And I see the attribute rel of element BasePage.MetaLink with value //logx.optimizely.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //cdn3.optimizely.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //cdn.optimizely.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value <metalinkTag> containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //calvinklein-eu.scene7.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value https://eu-images.contentstack.com/ containing "preconnect"
      And I see the attribute href of element BasePage.MetaLink with value manifest containing "manifest.json"
      #scripts
      And I see BasePage.Script with value https://cdn.optimizely.com/js/25575180516.js is existing
      And I see BasePage.Script with value https://cdn.optimizely.com/js/26160661174.js is existing
      And I see BasePage.Script with value <metalinkTag>/calvinklein-eu/dev/utag.js is existing
      #In search page no breadcrumb is present hence no application/ld+json
      And I see BasePage.Script with value application/ld+json is not existing

    Examples:
      | locale | langCode | categoryId           | metalinkTag           |
      | ee     | default  | MEN_CLOTHES_T-SHIRTS | //tags.calvinklein.ee |

    @ExcludeUat
    Examples:
      | locale | langCode | categoryId           | metalinkTag           |
      | lu     | default  | MEN_CLOTHES_T-SHIRTS | //tags.calvinklein.lu |

    @ExcludeDB0
    Examples:
      | locale | langCode | categoryId           | metalinkTag           |
      | ch     | FR       | MEN_CLOTHES_T-SHIRTS | //tags.calvinklein.ch |


