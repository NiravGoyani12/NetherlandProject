Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1
  @WLP @CET1 @tms:UTR-16602 @FixedEvent
  Scenario Outline: Catalog facet interaction - The event is fired when I close a facet from PLP
      Given I am on category <categoryId> page of locale <locale> of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type Colour
      When I inject utag event listener
      And in unified filter panel I close filter type Colour
      And in unified PLP I ensure filter panel is closed
      Then utag event catalog_facet_interaction is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "catalog_facet_interaction"
      And utag event #event should contain attr eventLabel with value "close_facet"
      And utag event #event should contain non-empty attr facet_label
      And utag event #event should contain attr facet_type with value "close_facet"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    @ExcludeCK
    Examples:
      | locale | langCode | categoryId              |
      | ee     | default  | th_women_clothing_jeans |

    @ExcludeTH
    Examples:
      | locale | langCode | categoryId           |
      | ee     | default  | MEN_CLOTHES_T-SHIRTS |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @DataLayerEvent @Filter @CSR @EESK @P1
  @tms:UTR-16603 @FixedEvent @Unification
  Scenario Outline: Catalog facet interaction - The event is fired when I open a facet from PLP
      Given I am on category <categoryId> page of locale <locale> of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I close filter type Colour
      When I inject utag event listener
      And in unified filter panel I open filter type Colour
      Then utag event catalog_facet_interaction is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "catalog_facet_interaction"
      And utag event #event should contain attr eventLabel with value "open_facet"
      And utag event #event should contain non-empty attr facet_label
      And utag event #event should contain attr facet_type with value "open_facet"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    @ExcludeCK
    Examples:
      | locale | langCode | categoryId              |
      | ee     | default  | th_women_clothing_jeans |

    @ExcludeTH
    Examples:
      | locale | langCode | categoryId           |
      | ee     | default  | MEN_CLOTHES_T-SHIRTS |


  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome @unified
  @Analytics @DataLayerEvent @Filter @CSR @EESK @P1
  @tms:UTR-16604 @FixedEvent @Unification
  Scenario Outline: Catalog facet interaction - The event is fired when a checkbox is applied from PLP
      Given I am on category <categoryId> page of locale <locale> of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      When I inject utag event listener
      And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
      And I wait until the current page is loaded
      And in unified filter panel I see filter type <filterType> with filter <filterOption> is active
      Then utag event catalog_facet_interaction is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "catalog_facet_interaction"
      And utag event #event should contain attr eventLabel with value "check_facet"
      And utag event #event should contain non-empty attr facet_label
      And utag event #event should contain attr facet_type with value "check_facet"
      And utag event #event should contain non-empty attr facet_value
      And utag event #event should contain non-empty attr xoTrackingId
      And I execute all datalayer event validation with report key #event

    @ExcludeCK
    Examples:
      | locale | filterType | filterOption | categoryId              | langCode |
      | ee     | Size       | M            | th_women_clothing_jeans | default  |

    @ExcludeTH
    Examples:
      | locale | filterType | filterOption | categoryId           | langCode |
      | ee     | Size       | M            | MEN_CLOTHES_T-SHIRTS | default  |



  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @DataLayerEvent @Filter @CSR @EESK @P1
  @tms:UTR-16605 @FixedEvent @Unification
  Scenario Outline: Catalog facet interaction - The event is fired when a checkbox is removed from PLP
      Given I am on category <categoryId> page of locale <locale> of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
      When I inject utag event listener
      And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
      Then utag event catalog_facet_interaction is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "catalog_facet_interaction"
      And utag event #event should contain attr eventLabel with value "uncheck_facet"
      And utag event #event should contain non-empty attr facet_label
      And utag event #event should contain attr facet_type with value "uncheck_facet"
      And utag event #event should contain non-empty attr facet_value
      And utag event #event should contain non-empty attr xoTrackingId
      And I execute all datalayer event validation with report key #event

    @ExcludeCK
    Examples:
      | locale | filterType | filterOption | categoryId              | langCode |
      | ee     | Size       | M            | th_women_clothing_jeans | default  |

    @ExcludeTH
    Examples:
      | locale | filterType | filterOption | categoryId           | langCode |
      | ee     | Size       | M            | MEN_CLOTHES_T-SHIRTS | default  |



  @FullRegression
  @Desktop @OnlyEmulator
  @Chrome
  @Analytics @DataLayerEvent @Filter @CSR @EESK @P1
  @tms:UTR-16606 @FixedEvent @Unification
  Scenario Outline: Catalog facet interaction - The event is fired when I removed by clicking on active filter label on PLP
      Given I am on category <categoryId> page of locale <locale> of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
      And in unified filter panel I wait until filter type <filterType> with filter <filterOption> is active
      When I inject utag event listener
      And I scroll to the element Experience.PlpFilters.ActiveFilterRegion
      And I click on Experience.PlpFilters.ActiveFilterLabels
      Then utag event catalog_facet_interaction is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "catalog_facet_interaction"
      And utag event #event should contain attr eventLabel with value "uncheck_bubble"
      And utag event #event should contain non-empty attr facet_label
      And utag event #event should contain attr facet_type with value "uncheck_bubble"
      And utag event #event should contain non-empty attr facet_value
      And I execute all datalayer event validation with report key #event

    @ExcludeCK
    Examples:
      | locale | filterType | filterOption | categoryId              | langCode |
      | ee     | Size       | M            | th_women_clothing_jeans | default  |

    @ExcludeTH
    Examples:
      | locale | filterType | filterOption | categoryId           | langCode |
      | ee     | Size       | M            | MEN_CLOTHES_T-SHIRTS | default  |


  @FullRegression
  @Desktop @OnlyEmulator
  @Chrome
  @Analytics @DataLayerEvent @Filter @CSR @EESK @P1
  @tms:UTR-16607 @FixedEvent @Unification
  Scenario Outline: Catalog facet interaction - The event is fired when I click on reset button on PLP
      Given I am on category <categoryId> page of locale <locale> of langCode <langCode> with forced accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type <filterType> and select <filterOption> as filter option
      And in unified filter panel I wait until filter type <filterType> with filter <filterOption> is active
      When I inject utag event listener
      And I scroll to the element Experience.PlpFilters.ActiveFilterRegion
      And I click on Experience.PlpFilters.FilterResetAll
      Then utag event catalog_facet_interaction is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "catalog_facet_interaction"
      And utag event #event should contain attr eventLabel with value "reset_all"
      And utag event #event should contain attr facet_type with value "reset_all"
      And I execute all datalayer event validation with report key #event
    
    @ExcludeCK
    Examples:
      | locale | filterType | filterOption | categoryId              | langCode |
      | ee     | Size       | M            | th_women_clothing_jeans | default  |

    @ExcludeTH
    Examples:
      | locale | filterType | filterOption | categoryId           | langCode |
      | ee     | Size       | M            | MEN_CLOTHES_T-SHIRTS | default  |


  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1
  @WLP @CET1 @tms:UTR-16668 @FixedEvent
  Scenario Outline: Catalog facet interaction - The event is fired when I close a facet from search PLP
      Given I am on locale <locale> search page with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type Colour
      When I inject utag event listener
      And in unified filter panel I close filter type Colour
      And in unified PLP I ensure filter panel is closed
      Then utag event catalog_facet_interaction is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "catalog_facet_interaction"
      And utag event #event should contain attr eventLabel with value "close_facet"
      And utag event #event should contain non-empty attr facet_label
      And utag event #event should contain attr facet_type with value "close_facet"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode |
      | ee     | default  |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @DataLayerEvent @Filter @P1
  @tms:UTR-16669 @FixedEvent @Unification
  Scenario Outline: Catalog facet interaction - The event is fired when I open a facet from search PLP
      Given I am on locale <locale> search page with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I close filter type Colour
      When I inject utag event listener
      And in unified filter panel I open filter type Colour
      Then utag event catalog_facet_interaction is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "catalog_facet_interaction"
      And utag event #event should contain attr eventLabel with value "open_facet"
      And utag event #event should contain non-empty attr facet_label
      And utag event #event should contain attr facet_type with value "open_facet"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode |
      | ee     | default  |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome @unified
  @Analytics @DataLayerEvent @Filter @CSR @EESK @P1
  @tms:UTR-16670 @FixedEvent @Unification
  Scenario Outline: Catalog facet interaction - The event is fired when a checkbox is applied from search PLP
      Given I am on locale <locale> search page with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type Colour
      When I inject utag event listener
      And in unified filter panel I select <filterOption> as filter option
      And I wait until the current page is loaded
      Then utag event catalog_facet_interaction is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "catalog_facet_interaction"
      And utag event #event should contain attr eventLabel with value "check_facet"
      And utag event #event should contain non-empty attr facet_label
      And utag event #event should contain attr facet_type with value "check_facet"
      And utag event #event should contain non-empty attr facet_value
      And utag event #event should contain non-empty attr xoTrackingId
      And I execute all datalayer event validation with report key #event
    
    Examples:
      | locale | langCode | filterOption |
      | ee     | default  | Black        |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @DataLayerEvent @Filter @CSR @EESK @P1
  @tms:UTR-16671 @FixedEvent @Unification
  Scenario Outline: Catalog facet interaction - The event is fired when a checkbox is removed from search PLP
      Given I am on locale <locale> search page with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type Colour
      And in unified filter panel I select <filterOption> as filter option
      And in unified filter panel I open filter type Colour
      When I inject utag event listener
      And in unified filter panel I select <filterOption> as filter option
      Then utag event catalog_facet_interaction is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "catalog_facet_interaction"
      And utag event #event should contain attr eventLabel with value "uncheck_facet"
      And utag event #event should contain non-empty attr facet_label
      And utag event #event should contain attr facet_type with value "uncheck_facet"
      And utag event #event should contain non-empty attr facet_value
      And utag event #event should contain non-empty attr xoTrackingId
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | filterOption |
      | ee     | default  | Black        |

  @FullRegression
  @Desktop  @OnlyEmulator
  @Chrome
  @Analytics @DataLayerEvent @Filter @CSR @EESK @P1
  @tms:UTR-16672 @FixedEvent @Unification
  Scenario Outline: Catalog facet interaction - The event is fired when I removed by clicking on active filter label on search PLP
      Given I am on locale <locale> search page with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type Colour
      And in unified filter panel I select <filterOption> as filter option
      When I inject utag event listener
      And I scroll to the element Experience.PlpFilters.ActiveFilterRegion
      And I click on Experience.PlpFilters.ActiveFilterLabels
      Then utag event catalog_facet_interaction is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "catalog_facet_interaction"
      And utag event #event should contain attr eventLabel with value "uncheck_bubble"
      And utag event #event should contain attr facet_label with value "maincolour"
      And utag event #event should contain attr facet_type with value "uncheck_bubble"
      And utag event #event should contain non-empty attr facet_value
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | filterOption |
      | ee     | default  | Black        |


  @FullRegression
  @Desktop  @OnlyEmulator
  @Chrome
  @Analytics @DataLayerEvent @Filter @CSR @EESK @P1
  @tms:UTR-16673 @FixedEvent @Unification
  Scenario Outline: Catalog facet interaction - The event is fired when I click on reset button on search PLP
      Given I am on locale <locale> search page with search term "jeans" with accepted cookies
      And I wait until page Experience.PlpProducts is loaded
      And in unified filter panel I open filter type Colour
      And in unified filter panel I select <filterOption> as filter option
      When I inject utag event listener
      And I scroll to the element Experience.PlpFilters.ActiveFilterRegion
      And I click on Experience.PlpFilters.FilterResetAll
      Then utag event catalog_facet_interaction is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "catalog_facet_interaction"
      And utag event #event should contain attr eventLabel with value "reset_all"
      And utag event #event should contain attr facet_type with value "reset_all"
      And I execute all datalayer event validation with report key #event


    Examples:
      | locale | langCode | filterOption |
      | ee     | default  | Black        |






