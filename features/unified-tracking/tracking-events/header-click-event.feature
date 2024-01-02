Feature: Unified Tracking - Events

  # TODO: add correct unified locators, related pages and correct eventLabel values

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @CET1 @P3
  @Header
  @tms:UTR-5878
  Scenario Outline: Header click - The event is fired when I click on the sign in button in the header
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
    When I inject utag event listener
      And I ensure unified mega menu is interactable
      And I wait until Experience.Header.SignInButton is displayed
      And I click on Experience.Header.SignInButton
    Then utag event header_click is fired saved to key #event
      And utag event #event should contain attr event_name with value "header_click"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "header_click"
      And utag event #event should contain attr eventLabel with value "signin_register"

    Examples:
      | locale | langCode | page          |
      | be     | default  | store-locator |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @CET1 @P3
  @Header
  @tms:UTR-6042
  Scenario Outline: Header click - The event is fired when I click on the logo icon in the header
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I navigate to page <page>
      And I wait until the current page is loaded
    When I inject utag event listener
      And I click on Experience.Header.Logo
    Then utag event header_click is fired saved to key #event
      And utag event #event should contain attr event_name with value "header_click"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "header_click"
      And utag event #event should contain attr eventLabel with value "logo"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | page          | userType  |
      | si     | default  | store-locator | guest     |
      | si     | default  | store-locator | logged in |

  #TODO: uncomment once this functionality is implemented
  # @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @CET1 @P3
  @Header
  Scenario Outline: Header click - The event is fired when I click on the USP banner in the footer
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a logged in user
      And I wait until the current page is loaded
      And I navigate to page <page> with forced accepted cookies
      And I wait until the current page is loaded
    When I inject utag event listener
      And I click on Header.SignInButton
    Then utag event header_click is fired saved to key #event
      And utag event #event should contain attr event_name with value "header_click"
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "header_click"
      # TODO: find correct value
      And utag event #event should contain attr eventLabel with value "tbd"

    Examples:
      | locale | langCode | page |
      | ee     | default  | glp  |