Feature: Unified Header - Country Selection Flyout

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @UnifiedTEX  @P2
  @Header @CountrySelection @CountrySelectionFlyout @TEX @UnifiedExperience @UnifiedHeader
  @tms:UTR-17645
  Scenario Outline: Unified Header Country Switch Flyout Desktop - Verify user can switch coutry and language
    Given I am on locale <locale> home page with forced accepted cookies
      And I navigate to page <page>
    When I click on Experience.Header.CountrySwitchIcon
    Then I see Experience.CountrySwitchFlyout.MainBlock is displayed in 10 seconds
    When in dropdown Experience.CountrySwitchFlyout.CountryDropdown I select the option by text "<country>"
      And in dropdown Experience.CountrySwitchFlyout.LanguageDropdown I select the option by text "<language>"
      And I click on Experience.CountrySwitchFlyout.CountrySwitchButton
      And I wait until the current page is loaded
    Then URL should contain "<languagePrefix>" in 10 seconds
      And URL should contain "<localePrefix>" in 1 seconds


    Examples:
      | locale           | page      | country    | language | languagePrefix | localePrefix |
      | default          | home-page | België     | Français | /FR            | be           |
      | default          | glp       | Nederland  | English  | /EN            | nl           |
      | multiLangDefault | wlp       | Luxembourg | Deutsch  | /DE            | lu           |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @P2 @UnifiedTEX
  @Header @CountrySelection @CountrySelectionFlyout @TEX @UnifiedExperience @UnifiedHeader
  @tms:UTR-17646
  Scenario Outline: Unified Header Country Switch Flyout Desktop - Verify country dropdown options are sorted alphabetically
    Given I am on locale <locale> home page with accepted cookies
      And I navigate to page <page>
    When I click on Experience.Header.CountrySwitchIcon
    Then I see Experience.CountrySwitchFlyout.MainBlock is displayed in 10 seconds
      And I click on Experience.CountrySwitchFlyout.CountryDropdown
      And in country switch flyout I see country option list is ordered alphabetically

    Examples:
      | locale           | page      |
      | default          | home-page |
      | multiLangDefault | glp       |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @P2 @UnifiedTEX
  @Header @CountrySelection @CountrySelectionFlyout @TEX @UnifiedExperience @UnifiedHeader
  @tms:UTR-17647
  Scenario Outline: Unified Header Country Switch Flyout Desktop - Verify country dropdown options are sorted alphabetically after changing locale
    Given I am on locale <locale> home page with accepted cookies
      And I navigate to page <page>
      And I wait until the current page is loaded
    When I click on Experience.Header.CountrySwitchIcon
      And in country switch flyout I ensure Experience.CountrySwitchFlyout.CountryDropdown is interactable
      And in dropdown Experience.CountrySwitchFlyout.CountryDropdown I select the option by text "<country>"
      And I click on Experience.CountrySwitchFlyout.CountrySwitchButton
      And I click on Experience.CookieNotice.IAgreeButton in 5 seconds if displayed
      And I navigate to page <page>
      And I wait until the current page is loaded
    When I click on Experience.Header.CountrySwitchIcon
      And in country switch flyout I ensure Experience.CountrySwitchFlyout.CountryDropdown is interactable
      And I click on Experience.CountrySwitchFlyout.CountryDropdown
    Then in country switch flyout I see country option list is ordered alphabetically

    Examples:
      | locale  | country   | page |
      | default | Slovensko | plp  |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @P2 @UnifiedExperience
  @Header @CountrySelection @CountrySelectionFlyout @TEX @UnifiedTEX
  @tms:UTR-17648
  Scenario Outline: Unified Header Country Switch Flyout Desktop - Verify user can switch back to default language
    Given I am on locale <locale> glp page of langCode <langCode> with accepted cookies
      And I wait until the count of cookies PVH_GLP_GENDER is equal to 1
      And I navigate to page <page>
      And I wait until the current page is loaded
    When I click on Experience.Header.CountrySwitchIcon
      And in dropdown Experience.CountrySwitchFlyout.LanguageDropdown I select the option by text "<language>"
      And I click on Experience.CountrySwitchFlyout.CountrySwitchButton
      And I wait until the current page is loaded
    Then URL should not contain "<languagePrefix>" in 2 seconds
      And URL should contain "<localePrefix>" in 1 second

    Examples:
      | locale | langCode | language | languagePrefix | localePrefix | page |
      | ch     | IT       | Deutsch  | /IT            | ch           | glp  |
      | be     | FR       | Vlaams   | /FR            | be           | plp  |
      | lu     | DE       | Français | /DE            | lu           | pdp  |