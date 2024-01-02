Feature: Unified Tracking - Events
  # TODO: uncomment all test cases once the unified mega menu is enabled on UAT

  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @CET1 @P1
  @Megamenu
  Scenario Outline: Megamenu click - The event is fired when I click on the first gender level in mega menu
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page> with forced accepted cookies
      And I wait until the current page is loaded
    When I inject utag event listener
    # TODO: common step is required
    # And in mega menu I click 1st main menu
    Then utag event header_click is fired saved to key #event
      And utag event #event should contain attr event_name with value "megamenu_click"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "megamenu_click"
      And utag event #event should contain non-empty attr eventLabel
      And utag event #event should contain attr menu_click_position with value "1"
      And utag event #event should contain attr menu_click_depth with value "level 1"
      And utag event #event should contain attr menu_path with in lower case value of digitalData.page.pageInfo.productStructureGroupId
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | page |
      | ee     | default  | wlp  |

  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @CET1 @P1
  @UnifiedComponent @Megamenu
  Scenario Outline: Megamenu click - The event is fired when I click on the second category level in mega menu
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page> with forced accepted cookies
      And I wait until the current page is loaded
    When I inject utag event listener
    # TODO: common step is required
    # And in mega menu I click 2nd main menu
    Then utag event header_click is fired saved to key #event
      And utag event #event should contain attr event_name with value "megamenu_click"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "megamenu_click"
      And utag event #event should contain non-empty attr eventLabel
      And utag event #event should contain attr menu_click_position with value "2"
      And utag event #event should contain attr menu_click_depth with value "level 2"
      And utag event #event should contain attr menu_path with in lower case value of digitalData.page.pageInfo.productStructureGroupId
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | page |
      | ee     | default  | wlp  |

  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @CET1
  @Header
  Scenario Outline: Megamenu click - The event is fired when I click on the third subcategory level in mega menu
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page> with forced accepted cookies
      And I wait until the current page is loaded
    When I inject utag event listener
    # TODO: common step is required
    # And in mega menu I click 3rd main menu
    Then utag event header_click is fired saved to key #event
      And utag event #event should contain attr event_name with value "megamenu_click"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "megamenu_click"
      And utag event #event should contain non-empty attr eventLabel
      And utag event #event should contain attr menu_click_position with value "3"
      And utag event #event should contain attr menu_click_depth with value "level 3"
      And utag event #event should contain attr menu_path with in lower case value of digitalData.page.pageInfo.productStructureGroupId
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | page |
      | ee     | default  | wlp  |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @CET1
  @Header
  @tms:UTR-5509
  Scenario Outline: Mega menu click - The event is fired when I click on the first gender level in mega menu
    Given I am on locale <locale> home page with accepted cookies
      And I navigate to page <page>
    When I inject utag event listener
      And I ensure unified mega menu is interactable
      And in unified megamenu I select 1st level item with <index>
    Then utag event megamenu_click is fired saved to key #event
      And utag event #event should contain attr event_name with value "megamenu_click"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "megamenu_click"
      And utag event #event should contain non-empty attr eventLabel
      And utag event #event should contain attr menu_click_position with <value>
      And utag event #event should contain attr menu_click_depth with value "level 1"
      And utag event #event should contain attr menu_path with one of the <values>
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | page          | index   | value     | values                   |
      | ee     | store-locator | index 1 | value "1" | values "women,th_women"  |
      | ee     | store-locator | index 2 | value "2" | values "men,th_men"      |
      | ee     | store-locator | index 3 | value "3" | values "kids,th_kidsnew" |
