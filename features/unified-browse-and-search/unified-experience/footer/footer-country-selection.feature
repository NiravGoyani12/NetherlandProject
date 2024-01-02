Feature: Unified Footer - Country Selection

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @UnifiedTEX
  @Footer @CountrySelection @TEX @UnifiedExperience @UnifiedFooter
  @feature:TEX-15333 @P2
  @tms:UTR-5189
  Scenario Outline: Unified Footer - Verify user can switch coutry and language and lands on correct page
    Given I am on locale <locale> home page with accepted cookies
      And I navigate to page <page>
      And I move to the bottom of the page
      And in unified footer I ensure Experience.Footer.CountryDropdown is interactable
    When in dropdown Experience.Footer.CountryDropdown I select the option by text "<country>"
      And in dropdown Experience.Footer.LanguageDropdown I select the option by text "<language>"
      And I click on Experience.Footer.CountrySwitchButton
    Then URL should contain "<languagePrefix>" in 10 seconds
      And URL should contain "<localePrefix>" in 1 seconds
      And I wait until the current page is loaded
      And I see the current page is <SwitchedPage>

    Examples:
      | locale  | page      | country | language | languagePrefix | localePrefix | SwitchedPage |
      | default | home-page | België  | Français | /FR            | be           | home-page    |
      | default | glp       | België  | Français | /FR            | be           | glp          |

    #wlp, shopping-bag and pdp currently navigate to home/glp
    Examples:
      | locale           | page         | country    | language | languagePrefix | localePrefix | SwitchedPage |
      | multiLangDefault | wlp          | Luxembourg | Deutsch  | /DE            | lu           | home-page    |
      | multiLangDefault | shopping-bag | België     | Français | /FR            | be           | home-page    |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @P2 @UnifiedTEX
  @Footer @CountrySelection @TEX @UnifiedExperience @UnifiedFooter
  @tms:UTR-4996
  Scenario Outline: Unified Footer - Verify country dropdown options are sorted alphabetically
    Given I am on locale <locale> home page with accepted cookies
      And I navigate to page <page>
      And in unified footer I ensure Experience.Footer.CountryDropdown is interactable
    When I move to the bottom of the page
      And I click on Experience.Footer.CountryDropdown
    Then in unified footer I see country option list is ordered alphabetically

    Examples:
      | locale  | page          |
      | default | store-locator |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @P2 @UnifiedTEX
  @Footer @CountrySelection @TEX @UnifiedExperience @UnifiedFooter
  @tms:UTR-4997
  Scenario Outline: Unified Footer - Verify country dropdown options are sorted alphabetically after changing locale
    Given I am on locale <locale> home page with accepted cookies
      And I navigate to page <page>
      And in unified footer I ensure Experience.Footer.CountryDropdown is interactable
      And I move to the bottom of the page
    When in dropdown Experience.Footer.CountryDropdown I select the option by text "<country>"
      And I click on Experience.Footer.CountrySwitchButton
      And I click on Experience.CookieNotice.IAgreeButton in 5 seconds if displayed
      And I navigate to page <page>
      And in unified footer I ensure Experience.Footer.CountryDropdown is interactable
      And I move to the bottom of the page
      And I click on Experience.Footer.CountryDropdown
    Then in unified footer I see country option list is ordered alphabetically

    Examples:
      | locale  | country   | page          |
      | default | Slovensko | store-locator |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @P2 @UnifiedExperience
  @Footer @CountrySelection @Cookies @TEX @UnifiedTEX
  @tms:UTR-13216
  Scenario Outline: Unified Footer - Verify user can switch back to default language
    Given I am on locale <locale> glp page of langCode <langCode> with accepted cookies
      And I wait until the count of cookies PVH_GLP_GENDER is equal to 1
      And I navigate to page <page>
      And I wait until the current page is loaded
      And I move to the bottom of the page
      And in unified footer I ensure Experience.Footer.CountryDropdown is interactable
    When in dropdown Experience.Footer.LanguageDropdown I select the option by text "<language>"
      And I click on Experience.Footer.CountrySwitchButton
      And I wait until the current page is loaded
    Then URL should not contain "<languagePrefix>" in 2 seconds
      And URL should contain "<localePrefix>" in 1 second

    Examples:
      | locale | langCode | language | languagePrefix | localePrefix | page          |
      | ch     | IT       | Deutsch  | /IT            | ch           | wlp           |
      | be     | FR       | Vlaams   | /FR            | be           | store-locator |
      | lu     | DE       | Français | /DE            | lu           | pdp           |