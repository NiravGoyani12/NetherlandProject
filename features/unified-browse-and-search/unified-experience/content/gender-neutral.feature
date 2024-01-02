Feature: Unified Content - Gender-Neutral Page

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedGenderNeutral @UnifiedExperience
  @tms:UTR-14465
  Scenario Outline: Unified Gender-Neutral - Verify Desktop gender-neutral page is shown along with content
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I wait until Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is displayed
      And I see Experience.Content.TemplateButtonLink with data-testid "Splash-module",<href-men> is clickable
      And I see Experience.Content.TemplateButtonLink with data-testid "Splash-module",<href-women> is clickable
    When I see Experience.Content.GlpLink with data-testid "MM-first-level-item"##<href-women> is displayed
    Then I see Experience.Content.GlpLink with data-testid "MM-first-level-item"##<href-men> is displayed
      And I see Experience.Content.GlpLink with data-testid "MM-first-level-item"##<href-kids> is displayed

    @P1
    Examples:
      | locale | langCode | href-women | href-men | href-kids |
      | default| default  | /women     | /men     | /kids     |

    Examples:
      | locale | langCode | href-women | href-men  | href-kids  |
      | ch     | FR       | /FR/femme  | /FR/homme | /FR/enfant |
      | be     | FR       | /FR/femme  | /FR/homme | /FR/enfant | 
      | lu     | DE       | /DE/damen  | /DE/herren| /DE/kinder | 
      | nl     | default  | /dames     | /heren    | /kinderen  | 
      | be     | default  | /dames     | /heren    | /kinderen  | 
      | fr     | default  | /femme     | /homme    | /enfant    | 
      | lu     | default  | /femme     | /homme    | /enfant    | 
      | de     | default  | /damen     | /herren   | /kinder    | 
      | at     | default  | /damen     | /herren   | /kinder    | 
      | ch     | default  | /damen     | /herren   | /kinder    | 
      | pl     | default  | /kobiety   | /mezczyzni| /dzieci    |  
      | hr     | default  | /women     | /men      | /kids      |
      # | dk     | default  | /women     | /men      | /kids      |
      | ee     | default  | /women     | /men      | /kids      |
      | fi     | default  | /women     | /men      | /kids      |
      | hu     | default  | /women     | /men      | /kids      |
      | ie     | default  | /women     | /men      | /kids      |
      | lv     | default  | /women     | /men      | /kids      |
      | lt     | default  | /women     | /men      | /kids      |
      | pt     | default  | /women     | /men      | /kids      |
      | sk     | default  | /women     | /men      | /kids      |
      | si     | default  | /women     | /men      | /kids      |
      | se     | default  | /women     | /men      | /kids      |
      | cz     | default  | /women     | /men      | /kids      |
      
    @ExcludeTH
    Examples:
      | locale | langCode | href-women | href-men  | href-kids                 |
      | es     | default  | /mujeres   | /hombres  | /ropa-infantil            |
      | bg     | default  | /women     | /men      | /kids                     |
      | ch     | IT       | /IT/donna  | /IT/uomo  | /IT/abbigliamento-bambini |
      | it     | default  | /donna     | /uomo     | /abbigliamento-bambini    |
      
    @ExcludeCK
    Examples:
      | locale | langCode | href-women | href-men  | href-kids  |
      | es     | default  | /mujeres   | /hombres  | /ninos     |
      | ch     | IT       | /IT/donne  | /IT/uomini| /IT/bambini|
      | it     | default  | /donne     | /uomini   | /bambini   |

    @ExcludeUat
    Examples:
      | locale | langCode | href-women | href-men  | href-kids  |
      | de     | EN       | /EN/women  | /EN/men   | /EN/kids   |

  @FullRegression
  @Mobile
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedGenderNeutral @UnifiedExperience
  @tms:UTR-14466
  Scenario Outline: Unified Gender-Neutral - Verify Mobile gender-neutral page is shown along with content
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I wait until Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is displayed
      And I see Experience.Content.TemplateButtonLink with data-testid "Splash-module",<href-men> is clickable
      And I see Experience.Content.TemplateButtonLink with data-testid "Splash-module",<href-women> is clickable
      And I ensure unified mega menu is interactable
      And I wait until Experience.Content.MobileGlpLink with data-testid "MM-first-level-item"##<href-women>##MM-first-level-link is in viewport
    When I see Experience.Content.MobileGlpLink with data-testid "MM-first-level-item"##<href-women>##MM-first-level-link is displayed
    Then I see Experience.Content.MobileGlpLink with data-testid "MM-first-level-item"##<href-men>##MM-first-level-link is displayed
      And I see Experience.Content.MobileGlpLink with data-testid "MM-first-level-item"##<href-kids>##MM-first-level-link is displayed

    @P1
    Examples:
      | locale | langCode | href-women | href-men | href-kids |
      | default| default  | /women     | /men     | /kids     |

    # Examples:
    #   | locale | langCode | href-women | href-men  | href-kids  |
    #   | ch     | FR       | /FR/femme  | /FR/homme | /FR/enfant |
    #   | be     | FR       | /FR/femme  | /FR/homme | /FR/enfant | 
    #   | lu     | DE       | /DE/damen  | /DE/herren| /DE/kinder | 
    #   | nl     | default  | /dames     | /heren    | /kinderen  | 
    #   | be     | default  | /dames     | /heren    | /kinderen  | 
    #   | fr     | default  | /femme     | /homme    | /enfant    | 
    #   | lu     | default  | /femme     | /homme    | /enfant    | 
    #   | de     | default  | /damen     | /herren   | /kinder    | 
    #   | at     | default  | /damen     | /herren   | /kinder    | 
    #   | ch     | default  | /damen     | /herren   | /kinder    | 
    #   | pl     | default  | /kobiety   | /mezczyzni| /dzieci    |  
    #   | hr     | default  | /women     | /men      | /kids      |
    #   | dk     | default  | /women     | /men      | /kids      |
    #   | ee     | default  | /women     | /men      | /kids      |
    #   | fi     | default  | /women     | /men      | /kids      |
    #   | hu     | default  | /women     | /men      | /kids      |
    #   | ie     | default  | /women     | /men      | /kids      |
    #   | lv     | default  | /women     | /men      | /kids      |
    #   | lt     | default  | /women     | /men      | /kids      |
    #   | pt     | default  | /women     | /men      | /kids      |
    #   | sk     | default  | /women     | /men      | /kids      |
    #   | si     | default  | /women     | /men      | /kids      |
    #   | se     | default  | /women     | /men      | /kids      |
    #   | cz     | default  | /women     | /men      | /kids      |

    # @ExcludeTH
    # Examples:
    #   | locale | langCode | href-women | href-men  | href-kids                 |
    #   | es     | default  | /mujeres   | /hombres  | /ropa-infantil            |
    #   | bg     | default  | /women     | /men      | /kids                     |
    #   | ch     | IT       | /IT/donna  | /IT/uomo  | /IT/abbigliamento-bambini |
    #   | it     | default  | /donna     | /uomo     | /abbigliamento-bambini    |
      
    # @ExcludeCK
    # Examples:
    #   | locale | langCode | href-women | href-men  | href-kids  |
    #   | es     | default  | /mujeres   | /hombres  | /ninos     |
    #   | ch     | IT       | /IT/donne  | /IT/uomini| /IT/bambini|
    #   | it     | default  | /donne     | /uomini   | /bambini   |

    # @ExcludeUat
    # Examples:
    #   | locale | langCode | href-women | href-men  | href-kids  |
    #   | de     | EN       | /EN/women  | /EN/men   | /EN/kids   |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedGenderNeutral @UnifiedExperience @P1
  @tms:UTR-14467
  Scenario Outline: Unified Gender-Neutral - Verify glp links navigates to correct pages
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
     And I wait until Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is displayed
     And And I ensure unified mega menu is interactable
     And I wait until Experience.Content.GlpLink with data-testid "MM-first-level-item"##<href> is displayed
    When I see Experience.Content.GlpLink with data-testid "MM-first-level-item",<href> is clickable
    Then I click on Experience.Content.GlpLink with data-testid "MM-first-level-item",<href>
     And I wait until the current page is loaded
     And URL should contain "<href>"
     
    @P1
    Examples:
      | locale | langCode | href   |
      | default| default  | /women |
      | default| default  | /men   |
      | default| default  | /kids  |
    
  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedGenderNeutral @UnifiedExperience @P3
  @tms:UTR-14468
  Scenario Outline: Unified Gender-Neutral - Kids MM - Verify third level category links working as expected
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
     And I wait until Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is displayed
    When I see Experience.Content.GlpLink with data-testid "MM-first-level-item"##<href-women> is displayed
    Then I see Experience.Content.GlpLink with data-testid "MM-first-level-item"##<href-men> is displayed
      And I see Experience.Content.GlpLink with data-testid "MM-first-level-item"##<href-kids> is displayed
    When I click on Experience.Content.GlpLink with data-testid "MM-first-level-item",<href-kids>
    Then I wait until Experience.Header.MegaMenuSecondLevelItemsByIndex with index <index> is clickable
      And I hover over Experience.Header.MegaMenuSecondLevelItemsByIndex with index <index>
      And I wait until Experience.Header.MegaMenuThirdLevelHrefByIndex with href <href-1>,1 is clickable
    When I click on Experience.Header.MegaMenuThirdLevelHrefByIndex with href <href-1>,1
    Then I wait for 2 seconds
      And URL should contain "<href-1>"
      And I navigate back in the browser
      And URL should contain "<href-kids>"     

    @ExcludeTH
    Examples:
      | locale  | langCode | href-women | href-men  | href-kids | href-1        | index | 
      | default | default  | /women     | /men      | /kids     | /boys-clothes | 4     |

    @ExcludeCK @ExcludeDB0
      Examples:
      | locale  | langCode | href-women | href-men  | href-kids | href-1     | index | 
      | default | default  | /women     | /men      | /kids     | /baby-boys | 4     |

    @ExcludeCK @ExcludeUat
      Examples:
      | locale  | langCode | href-women | href-men  | href-kids | href-1               | index |  
      | default | default  | /women     | /men      | /kids     | /girls-coats-jackets | 3     |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @ContentCheck @UnifiedContent @UnifiedExperience @UnifiedGenderNeutral @UnifiedExperience @P1
  @tms:UTR-14591
  Scenario Outline: Unified Gender-Neutral - Gender-Active verify gender link is not active on home page
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I wait until Experience.Content.TemplateBlock with data-testid "Splash-module"##1 is displayed
    Then I see Experience.Content.MegaMenuActive is not displayed
      And I see Experience.Content.GlpLink with data-testid "MM-first-level-item"##<href-women> is displayed
      And I see Experience.Content.GlpLink with data-testid "MM-first-level-item"##<href-men> is displayed
      And I see Experience.Content.GlpLink with data-testid "MM-first-level-item"##<href-kids> is displayed

    Examples:
      | locale  | langCode | href-women | href-men | href-kids |
      | default | default  | /women     | /men     | /kids     |