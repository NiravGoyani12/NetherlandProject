Feature: Unified - Store locator

#  As of now Helpapp Development is in progress. These scenarios should be uncommented once Dev is completed and scenarios are in running state.
#  @FullRegression
#  @Desktop @Mobile
#  @Chrome @Firefox @Safari
#  @UnifiedStoreLocator @UnifiedExperience @EER @HelpApp @P2 @ExcludeUat
#  Scenario Outline: Store locator - If I use browser geo location then I get closest store
#    Given I am on locale <locale> of url help/store-locator of langCode <langCode> with accepted cookies
#    When I set the browser geo location to <newGeoLat> and <newGeoLong>
#      And I click on Experience.StoreLocator.UseMyLocationButton
#    Then I see Experience.StoreLocator.AvailableStores with index 1 contains text "<location>"
#      And I see Experience.StoreLocator.AvailableStores with index 2 contains text "<location>"
#      And I see Experience.StoreLocator.AvailableStores with index 3 contains text "<location>"
#    When I store the numeric value of Experience.StoreLocator.StoreCount with key #expectedStoreCount
#    Then the count of displayed elements Experience.StoreLocator.AvailableStores is equal to #expectedStoreCount
#      And the count of elements Experience.StoreLocator.StoresOnMap is equal to #expectedStoreCount
#
#    @tms:UTR-12710
#    Examples:
#      | locale  | langCode | newGeoLat | newGeoLong | location |
#      | default | default  | 51.5074   | -0.12      | London   |

#  As of now Helpapp Development is in progress. These scenarios should be uncommented once Dev is completed and scenarios are in running state.
#  @FullRegression
#  @Desktop @Mobile
#  @Chrome @Firefox @Safari
#  @UnifiedStoreLocator @UnifiedExperience @EER @HelpApp @P2 @ExcludeSIT @ExcludeUat
#  Scenario Outline: Store locator - I can get results when searching with valid location
#    Given I am on locale <locale> of url help/store-locator of langCode <langCode> with accepted cookies
#    When I type "<location>" in the field Experience.StoreLocator.SearchField
#      And I click on Experience.StoreLocator.SearchButton
#    Then I see Experience.StoreLocator.AvailableStores with index 1 contains text "<city>"
#      And I store the numeric value of Experience.StoreLocator.StoreCount with key #expectedStoreCount
#      And the count of displayed elements Experience.StoreLocator.AvailableStores is equal to #expectedStoreCount
#      And the count of elements Experience.StoreLocator.StoresOnMap is equal to #expectedStoreCount
#
#    @tms:UTR-12711
#    Examples:
#      | locale           | langCode         | location | city   |
#      | multiLangDefault | multiLangDefault | W1B 5SG  | London |
#
#    @tms:UTR-12712
#    Examples:
#      | locale  | langCode | location | city   |
#      | default | default  | Berlin   | Berlin |
#
#    @tms:UTR-12713
#    Examples:
#      | locale           | langCode         | location | city     |
#      | multiLangDefault | multiLangDefault | Almere   | Lelystad |

  @FullRegression
    @Desktop @Mobile
    @Chrome @Firefox @Safari @Translation @Lokalise
    @UnifiedStoreLocator @UnifiedExperience @EER @HelpApp @P2 @ExcludeSIT @ExcludeUat
  Scenario Outline: Store locator - I get an error when searching with invalid location
    Given I am on locale <locale> of url help/store-locator of langCode <langCode> with accepted cookies
    When I type "<location>" in the field Experience.StoreLocator.SearchField
    And I click on Experience.StoreLocator.SearchButton
    Then I see Experience.StoreLocator.InputError is displayed
    And I get translation from lokalise for "<expectedError>" and store it with key #ExpectedError
    And I see Experience.StoreLocator.InputError contains text "#ExpectedError"

    @tms:UTR-12714
    Examples:
      | locale  | langCode | location | expectedError         |
      | default | default  | 12345    | InvalidPostcodeOrCity |

    @tms:UTR-12715
    Examples:
      | locale           | langCode         | location     | expectedError         |
      | multiLangDefault | multiLangDefault | fdsfsdfdsfds | InvalidPostcodeOrCity |

    @tms:UTR-12716
    Examples:
      | locale  | langCode | location | expectedError         |
      | default | default  | @#@$     | InvalidPostcodeOrCity |

    @tms:UTR-12717
    Examples:
      | locale           | langCode         | location | expectedError         |
      | multiLangDefault | multiLangDefault | a        | InvalidPostcodeOrCity |

    @tms:UTR-12718
    Examples:
      | locale  | langCode | location | expectedError         |
      | default | default  |          | InvalidPostcodeOrCity |

  @FullRegression
    @Desktop @Mobile
    @Chrome @Firefox @Safari
    @UnifiedStoreLocator @UnifiedExperience @EER @HelpApp @P2 @ExcludeUat
  Scenario Outline: Store locator - I see store details (address, opening hours, products and phone number) are displayed without searching
    Given I am on locale <locale> of url help/store-locator of langCode <langCode> with accepted cookies
    Then I see Experience.StoreLocator.StoreTitle is displayed
    And I see Experience.StoreLocator.StoreDistance is not displayed
    And I see Experience.StoreLocator.StoreAddress is displayed
    And I see Experience.StoreLocator.StoreContactNumber is displayed
    And I see Experience.StoreLocator.StoreOpeningHoursList is displayed
    And I see Experience.StoreLocator.StoreProducts is displayed
    And I get translation from lokalise for "StoreLocatorLessInfo" and store it with key #StoreLocatorLessInfoLink
    And I see Experience.StoreLocator.ViewLessInfoLink with text #StoreLocatorLessInfoLink is displayed
    And I see Experience.StoreLocator.ViewDirectionsLink is displayed
    And I see the count of Experience.StoreLocator.StoreTitle is the same as the count of Experience.StoreLocator.AvailableStores
    And I see the count of Experience.StoreLocator.StoreDistance is the same as the count of Experience.StoreLocator.AvailableStores
    And I see the count of Experience.StoreLocator.StoreAddress is the same as the count of Experience.StoreLocator.AvailableStores
    And I see the count of Experience.StoreLocator.ViewDirectionsLink is the same as the count of Experience.StoreLocator.AvailableStores

    @tms:UTR-12719
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
    @Desktop @Mobile
    @Chrome @Firefox @Safari
    @UnifiedStoreLocator @UnifiedExperience @EER @HelpApp @P2 @ExcludeUat
  Scenario Outline: Store locator - I see store details (address, distance, opening hours, services, products and phone number) are displayed if I search
    Given I am on locale <locale> of url help/store-locator of langCode <langCode> with accepted cookies
    And I type "London" in the field Experience.StoreLocator.SearchField
    And I click on Experience.StoreLocator.SearchButton
    Then I see Experience.StoreLocator.StoreTitle is displayed in 10 seconds
    And I see Experience.StoreLocator.StoreDistance is displayed
    And I see Experience.StoreLocator.StoreDistance contains text "km"
    And I see Experience.StoreLocator.StoreAddress is displayed
    And I see Experience.StoreLocator.StoreContactNumber is displayed
    And I see Experience.StoreLocator.StoreOpeningHoursList is displayed
    And I see Experience.StoreLocator.StoreServices is displayed
    And I see Experience.StoreLocator.StoreProducts is displayed
    And I get translation from lokalise for "StoreLocatorLessInfo" and store it with key #StoreLocatorLessInfoLink
    And I see Experience.StoreLocator.ViewLessInfoLink with text #StoreLocatorLessInfoLink is displayed
    And I see Experience.StoreLocator.ViewDirectionsLink is displayed
    And I see the count of Experience.StoreLocator.StoreTitle is the same as the count of Experience.StoreLocator.AvailableStores
    And I see the count of Experience.StoreLocator.StoreDistance is the same as the count of Experience.StoreLocator.AvailableStores
    And I see the count of Experience.StoreLocator.StoreAddress is the same as the count of Experience.StoreLocator.AvailableStores
    And I see the count of Experience.StoreLocator.ViewDirectionsLink is the same as the count of Experience.StoreLocator.AvailableStores

    @tms:UTR-12720
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
    @Desktop @OnlyEmulator
    @Chrome @Firefox @Safari
    @UnifiedStoreLocator @UnifiedExperience @EER @HelpApp @P2 @ExcludeUat
  Scenario Outline: Store locator - I can see route to the store on google maps
    Given I am on locale <locale> of url help/store-locator of langCode <langCode> with accepted cookies
    When I click on Experience.StoreLocator.ViewDirectionsLink with index 1
    And I switch to 2nd browser tab
    Then I see URL should contain "google.com/maps"

    @tms:UTR-12721
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
    @Desktop @OnlyEmulator
    @Chrome @Firefox @Safari
    @UnifiedStoreLocator @UnifiedExperience @EER @HelpApp @P2 @ExcludeUat
  Scenario Outline: Store locator - I can scroll through the list of stores
    Given I am on locale <locale> of url help/store-locator of langCode <langCode> with accepted cookies
    And I type "<location>" in the field Experience.StoreLocator.SearchField
    And I click on Experience.StoreLocator.SearchButton
    Then I see Experience.StoreLocator.AvailableStores with index 1 is in viewport in 5 seconds
    And I see Experience.StoreLocator.AvailableStores with index last() is not in viewport
    When I smoothly scroll to the element Experience.StoreLocator.AvailableStores with index last()
    Then I see Experience.StoreLocator.AvailableStores with index last() is in viewport in 5 seconds
    And I see Experience.StoreLocator.AvailableStores with index 1 is not in viewport
    When I smoothly scroll to the element Experience.StoreLocator.AvailableStores with index 1
    Then I see Experience.StoreLocator.AvailableStores with index 1 is in viewport in 5 seconds
    And I see Experience.StoreLocator.AvailableStores with index last() is not in viewport

    @tms:UTR-12722
    Examples:
      | locale           | langCode         | location |
      | multiLangDefault | multiLangDefault | Rome     |

  @FullRegression
    @Desktop
    @Chrome @Firefox @Safari
    @UnifiedStoreLocator @UnifiedExperience @EER @HelpApp @P3 @ExcludeUat
    @tms:UTR-13288
  Scenario Outline: Store locator - I can see Opening hours for stores for full working day
    Given I am on locale <locale> of url help/store-locator of langCode <langCode> with accepted cookies
    When I type "<location>" in the field Experience.StoreLocator.SearchField
    And I click on Experience.StoreLocator.SearchButton
    Then I see Experience.StoreLocator.StoreOpeningHours contains text "10:00"
    And the count of displayed elements Experience.StoreLocator.StoreOpeningHours is equal to 7

    Examples:
      | locale  | langCode | location    |
      | default | default  | montpellier |

  @FullRegression
    @Desktop @Mobile
    @Chrome @Firefox @Safari
    @UnifiedStoreLocator @UnifiedExperience @EER @HelpApp @ExcludeUat
    @UTR-16186
  Scenario Outline: Store locator - I see store service are displayed with green dots when I search
    Given I am on locale <locale> of url help/store-locator of langCode <langCode> with accepted cookies
    When I type "London" in the field Experience.StoreLocator.SearchField
    And I click on Experience.StoreLocator.SearchButton
    Then I see Experience.StoreLocator.StoreTitle is displayed
#      And I click on Experience.StoreLocator.MoreInfoLinkForStoreDetails with id "<storeId>"
    And I see Experience.StoreLocator.StoreServiceAvailableUsingStoreID with id <storeId> is displayed

    @ExcludeCK
    Examples:
      | locale  | langCode | storeId  |
      | default | default  | THGB0007 |

    @ExcludeTH
    Examples:
      | locale  | langCode | storeId  |
      | default | default  | CKGB0014 |
