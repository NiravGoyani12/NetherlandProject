Feature: Unified Footer - Elements And Content Validations

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @P2 @UnifiedTEX @Translation
  @Footer @UnifiedFooter @ElementCheck @ContentCheck @TEX @UnifiedExperience
  @tms:UTR-4998
  Scenario Outline: Unified Footer - Verify elements and content of the footer are displayed
    Given I am on locale <locale> home page with accepted cookies
      And I navigate to page store-locator
      And I get translation for "StoreLocatorLink" and store it with key #storeLocatorLinkText
    When I move to the bottom of the page
    Then I see Experience.Footer.ContactUsSection is displayed
      And the count of elements Experience.Footer.ContactUsSectionLinks is greater than 1
      And I see Experience.Footer.ExploreSection is displayed
      And the count of elements Experience.Footer.ExploreSectionLinks is greater than 1
      And I see Experience.Footer.CustomerServiceSection is displayed
      And the count of elements Experience.Footer.CustomerServiceSectionLinks is greater than 1
      And I see Experience.Footer.AboutSection is displayed
      And the count of elements Experience.Footer.AboutSectionLinks is greater than 1
      And in unified footer I ensure Experience.Footer.ContactUsSection is interactable
      And I see following elements are displayed
      | element                         | args |
      | Experience.Footer.MainBlock     |      |
      | Experience.Footer.ContenBlock   |      |
      | Experience.Footer.CopyrightText |      |
    #TODO to be added once social links are available for unified
    # | Footer.ConnectSocialFacebook  |      |
    # | Footer.ConnectSocialPinterest |      |
    # | Footer.ConnectSocialTwitter   |      |
    # | Footer.ConnectSocialInstagram |      |
    # | Footer.ConnectSocialYoutube   |      |
    When in unified footer I ensure Experience.Footer.CountryDropdown is interactable
    Then I see following elements are displayed
      | element                                | args |
      | Experience.Footer.CountrySelectSection |      |
      | Experience.Footer.CountryDropdown      |      |
      | Experience.Footer.CountrySwitchButton  |      |

    Examples:
      | locale  | page          |
      | default | store-locator |
      | default | giftcard-pdp  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @P2 @UnifiedTEX
  @Footer @UnifiedFooter @ElementCheck @ContentCheck @ProductPrices @TEX @UnifiedExperience
  @tms:UTR-4998
  Scenario Outline: Unified Footer - Verify currency in country selector CountryDropDown
    Given I am on locale <locale> home page with accepted cookies
      And I navigate to page <page>
    When I move to the bottom of the page
      And in unified footer I ensure Experience.Footer.CountryDropdown is interactable
      And I click on Experience.Footer.CountryDropdown
    Then in unified footer I see country option België contains text €
      And in unified footer I see country option Danmark contains text KR
      And in unified footer I see country option Deutschland contains text €
      And in unified footer I see country option España contains text €
      And in unified footer I see country option France contains text €
      And in unified footer I see country option Italia contains text €
      And in unified footer I see country option Nederland contains text €
      And in unified footer I see country option Polska contains text zl
      And in unified footer I see country option Schweiz contains text CHF
      And in unified footer I see country option United Kingdom contains text £
      And in unified footer I see country option Česko contains text KČ

    Examples:
      | locale  | page          |
      | default | store-locator |

  #TODO link navigation test scenarios once unified links are available

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending @P2
  @Footer @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedFooter @UnifiedExperience
  @tms:UTR-13508
  Scenario Outline: Unified Footer - Verify footer links navigates to correct page under help&support section
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I see Experience.Footer.HelpAndSupportSection is displayed
    Then I scroll to the element Experience.Footer.HelpAndSupportSectionLinkByIndex
      And the count of elements Experience.Footer.HelpAndSupportSectionLinkByIndex is greater than 1
    When I click on Experience.Footer.HelpAndSupportSectionLinkByIndex with index <index-1>
    Then I wait for 2 seconds
      And URL should contain "<href1>"
      And I navigate back in the browser
      And I wait until Experience.Footer.HelpAndSupportSectionLinkByIndex with index 5 is clickable
    When I click on Experience.Footer.HelpAndSupportSectionLinkByIndex with index <index-2>
    Then I wait for 2 seconds
      And URL should contain "<href2>"

    @ExcludeCK @ExcludeUat
    Examples:
      | locale  | langCode | href1 | href2      | index-1 | index-2 |
      | default | default  | faqs  | size-guide | 1       | 6       |

    @ExcludeTH @ExcludeUat
    Examples:
      | locale  | langCode | href1 | href2      | index-1 | index-2 |
      | default | default  | faqs  | size-guide | 1       | 6       |

    @ExcludeDB0
    Examples:
      | locale  | langCode | href1 | href2      | index-1 | index-2 |
      | default | default  | faqs  | size-guide | 1       | 5       |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending @P2
  @Footer @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedFooter @UnifiedExperience
  @tms:UTR-13511
  Scenario Outline: Unified Footer - Verify footer links navigates to correct page under footer menu section 2
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I see Experience.Footer.FootermenuSection2 is displayed
    Then I scroll to the element Experience.Footer.FootermenuSection2Links
      And the count of elements Experience.Footer.FootermenuSection2Links is greater than 1
      And I wait until Experience.Footer.FootermenuSection2LinkByIndex with index <index1> is clickable
    When I click on Experience.Footer.FootermenuSection2LinkByIndex with index <index1>
    Then URL should contain "<href1>"
      And I navigate back in the browser
      And I scroll to the element Experience.Footer.FootermenuSection2Links
      And I wait until Experience.Footer.FootermenuSection2LinkByIndex with index <index2> is clickable
    When I click on Experience.Footer.FootermenuSection2LinkByIndex with index <index2>
    Then URL should contain "<href2>"
      And I navigate back in the browser
      And I scroll to the element Experience.Footer.FootermenuSection2Links
      And I wait until Experience.Footer.FootermenuSection2LinkByIndex with index <index3> is clickable
    When I click on Experience.Footer.FootermenuSection2LinkByIndex with index <index3>
    Then URL should contain "<href3>"

    @ExcludeTH
    Examples:
      | locale  | langCode | href1     | href2 | href3     | index1 | index2 | index3 |
      | default | default  | mycalvins | sport | swim-shop | 2      | 4      | 6      |
      # | be      | FR       | mycalvins | sport | swim-shop | 2      | 4      | 6      |
      # | ch      | default  | mycalvins | sport | swim-shop | 2      | 4      | 6      |
      # | be      | default  | mycalvins | sport | swim-shop | 2      | 4      | 6      |
   
    @ExcludeCK
    Examples:
      | locale  | langCode | href1                            | href2                                | href3                   | index1 | index2 | index3 |
      | default | default  | terms-and-conditions             | customer-service-company-information | brand-protection        | 4      | 8      | 10     |
    #   # | be      | FR       | conditions-                      | service-client-mentions-legales      | protection-de-la-marque | 4      | 8      | 9      |
    #   # | ch      | default  | allgemeine-geschaeftsbedingungen | kundenservice-impressum              | markenschutz            | 4      | 8      | 9      |
    #   # | be      | default  | algemene-voorwaarden             | klantenservice-bedrijfsinformatie    | merkbescherming         | 4      | 8      | 9      |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending @P2
  @Footer @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedFooter @UnifiedExperience
  @tms:UTR-13524
  Scenario Outline: Unified Footer - Verify footer links navigates to correct page under footer menu section 3
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I see Experience.Footer.FootermenuSection3 is displayed
    Then I scroll to the element Experience.Footer.FootermenuSection3Links
      And the count of elements Experience.Footer.FootermenuSection3Links is greater than 1
      And I wait until Experience.Footer.FootermenuSection3LinkByIndex with index <index1> is clickable
    When I click on Experience.Footer.FootermenuSection3LinkByIndex with index <index1>
    Then URL should contain "<href1>"
      And I navigate back in the browser
      And I scroll to the element Experience.Footer.FootermenuSection3Links
      And I wait until Experience.Footer.FootermenuSection3LinkByIndex with index <index2> is clickable
    When I click on Experience.Footer.FootermenuSection3LinkByIndex with index <index2>
    Then URL should contain "<href2>"

    @ExcludeTH
    Examples:
      | locale  | langCode | href1                | href2                | index1 | index2 |
      | default | default  | types-of-jeans-women | types-of-jeans-men   | 1      | 2      |
      # | be      | FR       | types-de-jeans-femme | types-de-jeans-homme | 1      | 2      |
      # | ch      | default  | jeans-arten-damen    | jeans-arten-herren   | 1      | 2      |
      # | be      | default  | types-jeans-dames    | types-jeans-heren    | 1      | 2      |

    @ExcludeCK
    Examples:
      | locale  | langCode | href1             | href2           | index1 | index2 |
      | default | default  | tommy-together    | careers.pvh.com | 1      | 2      |
      # | be      | FR       | tommy-together    | careers.pvh.com | 1      | 2      |
      # | ch      | default  | the-hilfiger-club | careers.pvh.com | 1      | 2      |
      # | be      | default  | the-hilfiger-club | careers.pvh.com | 1      | 2      |

  @FullRegression
  @Desktop
  @Chrome @FireFox @SafariPending @P2
  @Footer @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedFooter @UnifiedExperience
  @tms:UTR-13556
  Scenario Outline: Unified Footer - Verify footer links navigates to correct page under footer menu section 4
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I see Experience.Footer.FootermenuSection4 is displayed
    Then I scroll to the element Experience.Footer.FootermenuSection4Links
      And the count of elements Experience.Footer.FootermenuSection4Links is greater than 1
      And I wait until Experience.Footer.FootermenuSection4LinkByIndex with index <index1> is clickable
    When I click on Experience.Footer.FootermenuSection4LinkByIndex with index <index1>
    Then URL should contain "<href1>"
      And I navigate back in the browser
      And I scroll to the element Experience.Footer.FootermenuSection4Links
      And I wait until Experience.Footer.FootermenuSection4LinkByIndex with index <index2> is clickable
    When I click on Experience.Footer.FootermenuSection4LinkByIndex with index <index2>
    Then URL should contain "<href2>"
      And I navigate back in the browser
      And I scroll to the element Experience.Footer.FootermenuSection4Links
      And I wait until Experience.Footer.FootermenuSection4LinkByIndex with index <index3> is clickable
    When I click on Experience.Footer.FootermenuSection4LinkByIndex with index <index3>
    Then URL should contain "<href3>"

    @ExcludeTH
    Examples:
      | locale  | langCode | href1                 | href2                                    | href3                            | index1 | index2 | index3 |
      | default | default  | about-calvin-klein    | customer-service-company-information     | terms-and-conditions             | 1      | 2      | 7      |
      # | be      | FR       | a-propos-calvin-klein | service-clientele-information-entreprise | conditions-generales             | 1      | 2      | 7      |
      # | ch      | default  | ueber-calvin-klein    | kundenservice-unternehmensinformationen  | allgemeine-geschaeftsbedingungen | 1      | 2      | 7      |
      # | be      | default  | over-calvin-klein     | klantenservice-bedrijfsinformatie        | algemene-voorwaarden             | 1      | 2      | 7      |

    @ExcludeCK
    Examples:
      | locale  | langCode | href1          | href2          | href3        | index1 | index2 | index3 |
      | default | default  | sustainability | tommy-adaptive | black-friday | 1      | 2      | 4      |
      # | be      | FR       | sustainability | tommy-adaptive | black-friday | 1      | 2      | 4      |
      # | ch      | default  | sustainability | tommy-adaptive | black-friday | 1      | 2      | 4      |
      # | be      | default  | sustainability | tommy-adaptive | black-friday | 1      | 2      | 4      |

  @FullRegression
  @Mobile
  @Chrome @FireFox @SafariPending @P2
  @Footer @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedFooter @UnifiedExperience
  @tms:UTR-13585
  Scenario Outline: Unified Footer - Verify mobile footer links navigates to correct page under help&support section
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I scroll to the element Experience.Footer.HelpAndSupportSection
    Then I see Experience.Footer.HelpAndSupportSection is in viewport
      And I click on Experience.Footer.FooterMobileMenuExpandByIndex with index 1
      And the count of elements Experience.Footer.HelpAndSupportSectionLinkByIndex is greater than 1
    When I click on Experience.Footer.HelpAndSupportSectionLinkByIndex with index 1
    Then I wait for 2 seconds
      And URL should contain "<href1>"
      And I navigate back in the browser
    When I scroll to the element Experience.Footer.HelpAndSupportSection
    Then I see Experience.Footer.HelpAndSupportSection is in viewport
      And I wait until Experience.Footer.FooterMobileMenuExpandByIndex with index 1 is clickable
      And I click on Experience.Footer.FooterMobileMenuExpandByIndex with index 1
      And the count of elements Experience.Footer.HelpAndSupportSectionLinkByIndex is greater than 1
    When I click on Experience.Footer.HelpAndSupportSectionLinkByIndex with index 5
    Then I wait for 2 seconds
      And URL should contain "<href2>"

    @ExcludeDB0
    Examples:
      | locale  | langCode | href1 | href2      |
      | default | default  | faqs  | size-guide |
  # | be      | FR       | faqs  | guide-des-tailles |
  # | ch      | default  | faqs  | groessen-guide    |
  # | be      | default  | faqs  | maattabel         |

  @FullRegression
  @Mobile
  @Chrome @FireFox @SafariPending @P2
  @Footer @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedFooter @UnifiedExperience
  @tms:UTR-13586
  Scenario Outline: Unified Footer - Verify mobile footer links navigates to correct page under footer menu section 2
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I scroll to the element Experience.Footer.FootermenuSection2
    Then I see Experience.Footer.FootermenuSection2 is in viewport
      And I wait until Experience.Footer.FooterMobileMenuExpandByIndex with index 2 is clickable
      And I click on Experience.Footer.FooterMobileMenuExpandByIndex with index 2
      And the count of elements Experience.Footer.FootermenuSection2Links is greater than 1
      And I wait until Experience.Footer.FootermenuSection2LinkByIndex with index <index1> is clickable
    When I click on Experience.Footer.FootermenuSection2LinkByIndex with index <index1>
    Then URL should contain "<href1>"
      And I navigate back in the browser
      And I scroll to the element Experience.Footer.FootermenuSection2
      And I see Experience.Footer.FootermenuSection2 is in viewport
      And I wait until Experience.Footer.FooterMobileMenuExpandByIndex with index 2 is clickable
      And I click on Experience.Footer.FooterMobileMenuExpandByIndex with index 2
      And the count of elements Experience.Footer.FootermenuSection2Links is greater than 1
      And I wait until Experience.Footer.FootermenuSection2LinkByIndex with index <index2> is clickable
    When I click on Experience.Footer.FootermenuSection2LinkByIndex with index <index2>
    Then URL should contain "<href2>"
      And I navigate back in the browser
      And I scroll to the element Experience.Footer.FootermenuSection2
      And I see Experience.Footer.FootermenuSection2 is in viewport
      And I wait until Experience.Footer.FooterMobileMenuExpandByIndex with index 2 is clickable
      And I click on Experience.Footer.FooterMobileMenuExpandByIndex with index 2
      And the count of elements Experience.Footer.FootermenuSection2Links is greater than 1
      And I wait until Experience.Footer.FootermenuSection2LinkByIndex with index <index3> is clickable
    When I click on Experience.Footer.FootermenuSection2LinkByIndex with index <index3>
    Then URL should contain "<href3>"

    @ExcludeTH @ExcludeDB0
    Examples:
      | locale  | langCode | href1     | href2 | href3     | index1 | index2 | index3 |
      | default | default  | mycalvins | sport | swim-shop | 2      | 4      | 6      |
    # | be      | FR       | mycalvins | sport | swim-shop | 2      | 4      | 6      |
    # | ch      | default  | mycalvins | sport | swim-shop | 2      | 4      | 6      |
    # | be      | default  | mycalvins | sport | swim-shop | 2      | 4      | 6      |

    @ExcludeCK @ExcludeDB0
    Examples:
      | locale  | langCode | href1                | href2                                | href3            | index1 | index2 | index3 |
      | default | default  | terms-and-conditions | customer-service-company-information | brand-protection | 4      | 8      | 10     |
  # | be      | FR       | conditions-                      | service-client-mentions-legales      | protection-de-la-marque | 4      | 8      | 9      |
  # | ch      | default  | allgemeine-geschaeftsbedingungen | kundenservice-impressum              | markenschutz            | 4      | 8      | 9      |
  # | be      | default  | algemene-voorwaarden             | klantenservice-bedrijfsinformatie    | merkbescherming         | 4      | 8      | 9      |

  @FullRegression
  @Mobile
  @Chrome @FireFox @SafariPending @P2
  @Footer @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedFooter @UnifiedExperience
  @tms:UTR-13587
  Scenario Outline: Unified Footer - Verify mobile footer links navigates to correct page under footer menu section 3
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I scroll to the element Experience.Footer.FootermenuSection3
    Then I see Experience.Footer.FootermenuSection3 is in viewport
      And I wait until Experience.Footer.FooterMobileMenuExpandByIndex with index 3 is clickable
      And I click on Experience.Footer.FooterMobileMenuExpandByIndex with index 3
      And the count of elements Experience.Footer.FootermenuSection3Links is greater than 1
      And I wait until Experience.Footer.FootermenuSection3LinkByIndex with index <index1> is clickable
    When I click on Experience.Footer.FootermenuSection3LinkByIndex with index <index1>
    Then URL should contain "<href1>"
      And I navigate back in the browser
      And I wait for 2 seconds
      And I scroll to the element Experience.Footer.FootermenuSection3
      And I see Experience.Footer.FootermenuSection3 is in viewport
      And I wait until Experience.Footer.FooterMobileMenuExpandByIndex with index 3 is clickable
      And I click on Experience.Footer.FooterMobileMenuExpandByIndex with index 3
      And the count of elements Experience.Footer.FootermenuSection3Links is greater than 1
      And I wait until Experience.Footer.FootermenuSection3LinkByIndex with index <index2> is clickable
    When I click on Experience.Footer.FootermenuSection3LinkByIndex with index <index2>
    Then URL should contain "<href2>"

    @ExcludeTH @ExcludeDB0
    Examples:
      | locale  | langCode | href1                | href2              | index1 | index2 |
      | default | default  | types-of-jeans-women | types-of-jeans-men | 1      | 2      |
    # | be      | FR       | types-de-jeans-femme | types-de-jeans-homme | 1      | 2      |
    # | ch      | default  | jeans-arten-damen    | jeans-arten-herren   | 1      | 2      |
    # | be      | default  | types-jeans-dames    | types-jeans-heren    | 1      | 2      |

    @ExcludeCK @ExcludeDB0
    Examples:
      | locale  | langCode | href1          | href2           | index1 | index2 |
      | default | default  | tommy-together | careers.pvh.com | 1      | 2      |
  # | be      | FR       | tommy-together    | careers.pvh.com | 1      | 2      |
  # | ch      | default  | the-hilfiger-club | careers.pvh.com | 1      | 2      |
  # | be      | default  | the-hilfiger-club | careers.pvh.com | 1      | 2      |

  @FullRegression
  @Mobile
  @Chrome @FireFox @SafariPending @P2
  @Footer @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedFooter @UnifiedExperience
  @tms:UTR-13588
  Scenario Outline: Unified Footer - Verify mobile footer links navigates to correct page under footer menu section 4
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I scroll to the element Experience.Footer.FootermenuSection4
    Then I see Experience.Footer.FootermenuSection4 is in viewport
      And I wait until Experience.Footer.FooterMobileMenuExpandByIndex with index 4 is clickable
      And I click on Experience.Footer.FooterMobileMenuExpandByIndex with index 4
      And the count of elements Experience.Footer.FootermenuSection4Links is greater than 1
      And I wait until Experience.Footer.FootermenuSection4LinkByIndex with index <index1> is clickable
    When I click on Experience.Footer.FootermenuSection4LinkByIndex with index <index1>
    Then I wait for 2 seconds
      And URL should contain "<href1>"
      And I navigate back in the browser
      And I wait for 2 seconds
      And I scroll to the element Experience.Footer.FootermenuSection4
      And I see Experience.Footer.FootermenuSection3 is in viewport
      And I wait until Experience.Footer.FooterMobileMenuExpandByIndex with index 4 is clickable
      And I click on Experience.Footer.FooterMobileMenuExpandByIndex with index 4
      And the count of elements Experience.Footer.FootermenuSection4Links is greater than 1
      And I wait until Experience.Footer.FootermenuSection4LinkByIndex with index <index2> is clickable
    When I click on Experience.Footer.FootermenuSection4LinkByIndex with index <index2>
    Then I wait for 2 seconds
      And URL should contain "<href2>"
      And I navigate back in the browser
      And I wait for 2 seconds
      And I scroll to the element Experience.Footer.FootermenuSection4
      And I see Experience.Footer.FootermenuSection4 is in viewport
      And I wait until Experience.Footer.FooterMobileMenuExpandByIndex with index 4 is clickable
      And I click on Experience.Footer.FooterMobileMenuExpandByIndex with index 4
      And the count of elements Experience.Footer.FootermenuSection4Links is greater than 1
      And I scroll to the element Experience.Footer.FootermenuSection4LinkByIndex with index <index3>
      And I wait until Experience.Footer.FootermenuSection4LinkByIndex with index <index3> is clickable
    When I click on Experience.Footer.FootermenuSection4LinkByIndex with index <index3>
    Then I wait for 2 seconds
      And URL should contain "<href3>"

    @ExcludeTH @ExcludeDB0
    Examples:
      | locale  | langCode | href1              | href2                                | href3                | index1 | index2 | index3 |
      | default | default  | about-calvin-klein | customer-service-company-information | terms-and-conditions | 1      | 2      | 7      |
    # | be      | FR       | a-propos-calvin-klein | service-clientele-information-entreprise | conditions-generales             | 1      | 2      | 7      |
    # | ch      | default  | ueber-calvin-klein    | kundenservice-unternehmensinformationen  | allgemeine-geschaeftsbedingungen | 1      | 2      | 7      |
    # | be      | default  | over-calvin-klein     | klantenservice-bedrijfsinformatie        | algemene-voorwaarden             | 1      | 2      | 7      |

    @ExcludeCK @ExcludeDB0
    Examples:
      | locale  | langCode | href1          | href2          | href3        | index1 | index2 | index3 |
      | default | default  | sustainability | tommy-adaptive | black-friday | 1      | 2      | 4      |
# | be      | FR       | sustainability | tommy-adaptive | black-friday | 1      | 2      | 4      |
# | ch      | default  | sustainability | tommy-adaptive | black-friday | 1      | 2      | 4      |
# | be      | default  | sustainability | tommy-adaptive | black-friday | 1      | 2      | 4      |

# Excluding Footer validation scenarios from DB0 runs since Footer content is not published in DB0