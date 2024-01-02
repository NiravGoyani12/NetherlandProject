Feature: Unified PDP - SEO

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Seo @PDP @TEE @UnifiedPdp @UnifiedExperience @P1
  @tms:UTR-14597 @ExcludeCK @issue:EESK-5212
  Scenario Outline: Metatag validations - TH - Validate the meta tags on pdp
    Given I am on locale <locale> <gender> glp page of langCode <langCode> with forced accepted cookies
      And I navigate to page pdp
    When I store translated value of "<translationKey>" with key #translatedGender
      And in js extract window.__NEXT_DATA__.props.pageProps.initialState.pdpState.identifier save to #productIdentifier
      And I save current url as key #PdpUrl
      And I store the value of BasePage.TitleTag with key #pageTitle
      And I store the value of attribute content of element BasePage.Metatag with value description with key #pageDescription
    #tags
    Then I see BasePage.TitleTag contains text "Tommy Hilfiger"
      And I see BasePage.TitleTag contains text "|"
      And I see BasePage.Metatag with value description is existing
      And I see the attribute content of element BasePage.MetatagHttpEquiv with value X-UA-Compatible containing "IE=edge"
      And I see the attribute content of element BasePage.MetatagHttpEquiv with value Content-Type containing "text/html; charset=utf-8"
      And I see the attribute content of element BasePage.Metatag with value robots containing "noodp,noydir,index,follow,archive"
      And I see the attribute content of element BasePage.Metatag with value viewport containing "width=device-width, initial-scale=1, maximum-scale=1"
      And I see the attribute content of element BasePage.Metatag with value pageIdentifier containing "#productIdentifier"
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
      And I see the attribute content of element BasePage.MetaProperty with value og:url containing "#PdpUrl"
      And I see the attribute content of element BasePage.MetaProperty with value og:type containing "website"
      And I see the attribute content of element BasePage.MetaProperty with value og:title containing "#pageTitle"
      And I see the attribute content of element BasePage.MetaProperty with value og:description containing "#pageDescription"
      And I see BasePage.MetaProperty with value og:image is existing
      And I see the attribute content of element BasePage.MetaProperty with value og:locale containing "<htmlLang>"
      #links
      And I see the value of attribute href of element BasePage.MetaLink with value canonical should be equal to the stored value with key #PdpUrl
      And I see the value of attribute href of element BasePage.MetaLink with value alternate should be equal to the stored value with key #PdpUrl
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
      # The below script check is failing due to EESK-5212
      And I see BasePage.Script with value https://cdn.optimizely.com/js/25972262115.js is existing
      And I see BasePage.Script with value https://cdn.optimizely.com/js/26081140005.js is existing
      And I see BasePage.Script with value //tags.tommy.com/tommyhilfiger-eu/dev/utag.js is existing
      And I see BasePage.Script with value application/ld+json is existing

    Examples:
      | locale  | langCode | gender | translationKey | htmlLang |
      | Default | default  | men    | MenGLP         | en_GB    |
      | ch      | IT       | men    | MenGLP         | it_CH    |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Seo @PDP @TEE @UnifiedPdp @UnifiedExperience @P1
  @tms:UTR-14597  @ExcludeTH @issue:EESK-5212
  Scenario Outline: Metatag validations - CK - Validate the meta tags on pdp
    Given I am on locale <locale> <gender> glp page of langCode <langCode> with forced accepted cookies
      And I navigate to page pdp
    When I store translated value of "<translationKey>" with key #translatedGender
      And in js extract window.__NEXT_DATA__.props.pageProps.initialState.pdpState.identifier save to #productIdentifier
      And I save current url as key #PdpUrl
      And I store the value of BasePage.TitleTag with key #pageTitle
      And I store the value of attribute content of element BasePage.Metatag with value description with key #pageDescription
    #tags
    Then I see BasePage.TitleTag contains text "Calvin Klein®"
      And I see BasePage.TitleTag contains text "|"
      And I see BasePage.Metatag with value description is existing
      And I see the attribute content of element BasePage.MetatagHttpEquiv with value X-UA-Compatible containing "IE=edge"
      And I see the attribute content of element BasePage.MetatagHttpEquiv with value Content-Type containing "text/html; charset=utf-8"
      And I see the attribute content of element BasePage.Metatag with value robots containing "noodp,noydir,index,follow,archive"
      And I see the attribute content of element BasePage.Metatag with value viewport containing "width=device-width, initial-scale=1, maximum-scale=1"
      And I see the attribute content of element BasePage.Metatag with value pageIdentifier containing "#productIdentifier"
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
      And I see the attribute content of element BasePage.MetaProperty with value og:url containing "#PdpUrl"
      And I see the attribute content of element BasePage.MetaProperty with value og:type containing "website"
      And I see the attribute content of element BasePage.MetaProperty with value og:title containing "#pageTitle"
      And I see the attribute content of element BasePage.MetaProperty with value og:description containing "#pageDescription"
      And I see BasePage.MetaProperty with value og:image is existing
      And I see the attribute content of element BasePage.MetaProperty with value og:locale containing "<htmlLang>"
      #links
      And I see the value of attribute href of element BasePage.MetaLink with value canonical should be equal to the stored value with key #PdpUrl
      And I see the value of attribute href of element BasePage.MetaLink with value alternate should be equal to the stored value with key #PdpUrl
      And I see the attribute rel of element BasePage.MetaLink with value //logx.optimizely.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //cdn3.optimizely.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //cdn.optimizely.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //tags.calvinklein.co.uk containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value //calvinklein-eu.scene7.com containing "preconnect"
      And I see the attribute rel of element BasePage.MetaLink with value https://eu-images.contentstack.com/ containing "preconnect"
      And I see the attribute href of element BasePage.MetaLink with value manifest containing "manifest.json"
      #scripts
      # The below script check is failing due to EESK-5212
      And I see BasePage.Script with value https://cdn.optimizely.com/js/25575180516.js is existing
      And I see BasePage.Script with value https://cdn.optimizely.com/js/26160661174.js is existing
      And I see BasePage.Script with value //tags.calvinklein.co.uk/calvinklein-eu/dev/utag.js is existing
      And I see BasePage.Script with value application/ld+json is existing

    Examples:
      | locale  | langCode | gender | translationKey | htmlLang |
      | Default | default  | women  | WomenGLP       | en_GB    |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @Seo @GiftCards @PDP @TEE @UnifiedPdp @UnifiedExperience
  @tms:UTR-17932 @ExcludeTH
  Scenario Outline: Metatag validations - CK - Verify product title and description are displayed on gift cards page
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I navigate to page giftcard-pdp
      And I wait until the current page is loaded
      And I save current url as key #pdpUrl
      And I get translation from lokalise for "CKGiftCardsSeoTitle" and store it with key #pageTitle
      And I get translation from lokalise for "CKGiftCardsSeoDescription" and store it with key #pageDescription
    Then I see BasePage.TitleTag contains text "#pageTitle"
      And I see the attribute content of element BasePage.Metatag with value description containing "#pageDescription"
      And I see the attribute content of element BasePage.MetaProperty with value og:title containing "#pageTitle"
      And I see the attribute content of element BasePage.MetaProperty with value og:description containing "#pageDescription"
      And I see the attribute content of element BasePage.MetaProperty with value og:url containing "#pdpUrl"
      And I see the value of attribute href of element BasePage.MetaLink with value canonical should be equal to the stored value with key #pdpUrl

    Examples:
      | locale  | langCode |
      | Default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @Seo @GiftCards @PDP @TEE @UnifiedPdp @UnifiedExperience @ExcludeCK
  @tms:UTR-17932 @ExcludeTH
  Scenario Outline: Metatag validations - TH - Verify product title and description are displayed on gift cards page
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I navigate to page giftcard-pdp
      And I wait until the current page is loaded
      And I save current url as key #pdpUrl
      And I get translation from lokalise for "THGiftCardsSeoTitle" and store it with key #pageTitle
      And I get translation from lokalise for "THGiftCardsSeoDescription" and store it with key #pageDescription
    Then I see BasePage.TitleTag contains text "#pageTitle"
      And I see the attribute content of element BasePage.Metatag with value description containing "#pageDescription"
      And I see the attribute content of element BasePage.MetaProperty with value og:title containing "#pageTitle"
      And I see the attribute content of element BasePage.MetaProperty with value og:description containing "#pageDescription"
      And I see the attribute content of element BasePage.MetaProperty with value og:url containing "#pdpUrl"
      And I see the value of attribute href of element BasePage.MetaLink with value canonical should be equal to the stored value with key #pdpUrl

    Examples:
      | locale  | langCode |
      | Default | default  |

