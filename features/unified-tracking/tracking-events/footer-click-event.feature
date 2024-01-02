Feature: Unified Tracking - Events

  # TODO: add correct unified locators, related pages and correct eventLabel values

  # TODO: uncomment once this functionality is implemented
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @CET1 @P3
  @Footer
  Scenario Outline: Footer click - The event is fired when I click on a button in the footer
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I wait until the current page is loaded
      And I navigate to page <page> with forced accepted cookies
      And I wait until the current page is loaded
    When I inject utag event listener
      And I click on tbd
    Then utag event footer_click is fired saved to key #event
      And utag event #event should contain attr event_name with value "footer_click"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "footer_click"
      And utag event #event should contain attr eventLabel with value "tbd"

    Examples:
      | locale | langCode | page |
      | ee     | default  | glp  |


  # TODO: uncomment once this functionality is implemented
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @CET1 @P3
  @Footer
  Scenario Outline: Footer click - The event is fired when I select a different country in the footer
    Given I am on locale <locale> home page with accepted cookies
      And I navigate to page <page>
      And in unified footer I ensure Experience.Footer.CountryDropdown is interactable
      And I move to the bottom of the page
      And in dropdown Experience.Footer.CountryDropdown I select the option by js by text "<country>"
      And in dropdown Experience.Footer.LanguageDropdown I select the option by js by text "<language>"
    When I inject utag event listener
      And I click on Experience.Footer.CountrySwitchButton
    Then utag event footer_click is fired saved to key #event
      And utag event #event should contain attr event_name with value "footer_click"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "footer_click"
      And utag event #event should contain attr eventLabel with value "country_selection"
      And utag event #event should contain attr country_selection with value "be_fr"

    Examples:
      | locale | page          | country | language |
      | ee     | store-locator | België  | Français |

  # TODO: uncomment once this functionality is implemented
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @CET1 @P3
  @Footer
  Scenario Outline: Footer click - The event is fired when I click on the Facebook icon in the footer
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I wait until the current page is loaded
      And I navigate to page <page> with forced accepted cookies
      And I wait until the current page is loaded
    When I inject utag event listener
      And I click on Footer.FacebookIcon
    Then utag event footer_click is fired saved to key #event
      And utag event #event should contain attr event_name with value "footer_click"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "footer_click"
      And utag event #event should contain attr eventLabel with value "facebook"

    Examples:
      | locale | langCode | page |
      | ee     | default  | glp  |

  # TODO: uncomment once this functionality is implemented
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @CET1 @P3
  @Footer
  Scenario Outline: Footer click - The event is fired when I click on the Instagram icon in the footer
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I wait until the current page is loaded
      And I navigate to page <page> with forced accepted cookies
      And I wait until the current page is loaded
    When I inject utag event listener
      And I click on Footer.InstagramIcon
    Then utag event footer_click is fired saved to key #event
      And utag event #event should contain attr event_name with value "footer_click"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "footer_click"
      And utag event #event should contain attr eventLabel with value "instagram"

    Examples:
      | locale | langCode | page |
      | ee     | default  | glp  |

  # TODO: uncomment once this functionality is implemented
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @CET1 @P3
  @Footer
  Scenario Outline: Footer click - The event is fired when I click on the YouTube icon in the footer
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I wait until the current page is loaded
      And I navigate to page <page> with forced accepted cookies
      And I wait until the current page is loaded
    When I inject utag event listener
      And I click on Footer.YoutubeIcon
    Then utag event footer_click is fired saved to key #event
      And utag event #event should contain attr event_name with value "footer_click"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "footer_click"
      And utag event #event should contain attr eventLabel with value "youtube"

    Examples:
      | locale | langCode | page |
      | ee     | default  | glp  |

  # TODO: uncomment once this functionality is implemented
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @CET1 @P3
  @Footer
  Scenario Outline: Footer click - The event is fired when I click on the Pinterest icon in the footer
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I wait until the current page is loaded
      And I navigate to page <page> with forced accepted cookies
      And I wait until the current page is loaded
    When I inject utag event listener
      And I click on Footer.PinterestIcon
    Then utag event footer_click is fired saved to key #event
      And utag event #event should contain attr event_name with value "footer_click"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "footer_click"
      And utag event #event should contain attr eventLabel with value "pinterest"

    Examples:
      | locale | langCode | page |
      | ee     | default  | glp  |

  # TODO: uncomment once this functionality is implemented
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @CET1 @P3
  @Footer
  Scenario Outline: Footer click - The event is fired when I click on the Twitter icon in the footer
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I wait until the current page is loaded
      And I navigate to page <page> with forced accepted cookies
      And I wait until the current page is loaded
    When I inject utag event listener
      And I click on Footer.TwitterIcon
    Then utag event footer_click is fired saved to key #event
      And utag event #event should contain attr event_name with value "footer_click"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "footer_click"
      And utag event #event should contain attr eventLabel with value "twitter"

    Examples:
      | locale | langCode | page |
      | ee     | default  | glp  |