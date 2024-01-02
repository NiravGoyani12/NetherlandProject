Feature: Unified Tracking - Events


 @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P3
  @WLP @CET1
  @tms:UTR-3515 @issue:CET1-3452
  Scenario: Click wishlist icon header - The event is fired when I click on the empty wishlist icon
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
    When I inject utag event listener
      And in js extract digitalData.page.pageInfo.pageName save to #pageName
      And I click on Experience.Header.WishListIcon
    Then utag event click_wishlist_icon_header is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "click_wishlist_icon_header"
      And utag event #event should contain attr eventLabel with value "#pageName" in lowercase
      And utag event #event should contain attr click_text with value "empty_wishlist_icon"
      And utag event #event should contain attr event_value with value "empty_wishlist"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | page          |
      | ee     | default  | store-locator |
      # | ee     | default  | wlp           | # TODO: Check for failures

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P3
  @WLP @CET1
  @tms:UTR-3516 @issue:CET1-3452
  Scenario: Click wishlist icon header - The event is fired when I click on the full wishlist icon
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 51 and 999
      And I am on locale <locale> wish list page of langCode <langCode> for product styles product1#styleColourPartNumber with forced accepted cookies
      And I navigate to page <page>
      And I wait until Experience.Header.WishListIcon is displayed
    When I inject utag event listener
      And in js extract digitalData.page.pageInfo.pageName save to #pageName
      And I click on Experience.Header.WishListIcon
      And I wait until Experience.Header.WishListIcon is displayed
    Then utag event click_wishlist_icon_header is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "click_wishlist_icon_header"
      And utag event #event should contain attr eventLabel with value "#pageName" in lowercase
      And utag event #event should contain attr click_text with value "full_wishlist_icon"
      And utag event #event should contain attr event_value with value "full_wishlist"
      And I execute all datalayer event validation with allowed unknown attribute with report key #event

    Examples:
      | locale | langCode | page          |
      | ee     | default  | store-locator |
      # | ee     | default  | wlp           | # TODO: Check for failures