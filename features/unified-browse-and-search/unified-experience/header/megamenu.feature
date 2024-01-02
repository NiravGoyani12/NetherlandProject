Feature: Unified Header - Megamenu Mobile Links

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari @UnifiedExperience
  @Header @ElementCheck @ContentCheck @UnifiedMegaMenu @TEX
  @feature:CET1-3234 @tms:UTR-3894 @P2
  Scenario Outline: Mega Menu - Verify that the guest user is able to see signIn button and click it to open signIn drawer
    Given I am on locale <locale> home page with accepted cookies
      And I am a guest user
      And I navigate to page <page>
    When I ensure unified mega menu is interactable
    Then in unified megamenu I select 1st level item with index 1
      And I wait for 2 seconds
      And I smoothly scroll to the element Experience.Header.SignInButton
      And I click on Experience.Header.SignInButton
    Then I see MyAccount.AccountFlyout.FlyMenuSignIn is displayed

    Examples:
      | locale  | page         |
      | default | shopping-bag |

    Examples:
      | locale           | page          |
      | multiLangDefault | wlp           |
      | default          | store-locator |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari @UnifiedExperience @P2
  @Header @ElementCheck @ContentCheck @UnifiedMegaMenu @TEX
  @feature:CET1-3234 @tms:UTR-3895
  Scenario Outline: Mega Menu - Verify that the logged in user is able to see MyAccount and click it to expand successfully
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I am a logged in user
      And I wait until the current page is loaded
      And I navigate to page <page>
      And I ensure unified mega menu is interactable
    When in unified megamenu I select 1st level item with index 1
      And I wait for 2 seconds
      And I smoothly scroll to the element Experience.Header.MyAccountButton
    Then I see the attribute aria-expanded of element Experience.Header.MyAccountButton containing "false"
      And I see Experience.Header.SignInButton is not displayed
    When I click on Experience.Header.MyAccountButton with index 1
    Then I see the attribute aria-expanded of element Experience.Header.MyAccountButton containing "true"
      And I see MyAccount.AccountFlyout.FlyMenuSignIn is not displayed
      And I see Experience.Header.SignOutButton is displayed
      And I see Experience.Header.MegaMenuThirdLevelItems with text "Addresses" is displayed
      And I see Experience.Header.MegaMenuThirdLevelItems with text "Orders" is displayed
      And I see Experience.Header.MegaMenuThirdLevelItems with text "Details" is displayed

    Examples:
      | locale  | langCode | page         |
      | default | default  | shopping-bag |

    Examples:
      | locale | langCode | page |
      | nl     | EN       | wlp  |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari @UnifiedExperience @P2
  @Header @ElementCheck @ContentCheck @UnifiedMegaMenu @TEX
  @feature:CET1-3234 @tms:UTR-3896 @issue:EER-10358
  Scenario Outline: Mega Menu - Verify that the user is able to see and click store locator link
    Given I am on locale <locale> home page with forced accepted cookies
      And I navigate to page <page>
      And I am a <user> user
      And I wait until the current page is loaded
      And I ensure unified mega menu is interactable
    When in unified megamenu I select 1st level item with index 1
      And I wait for 2 seconds
      And I smoothly scroll to the element Experience.Header.StoreLocator with index 1
      And I click on Experience.Header.StoreLocator with index 1
      And I wait until the current page is loaded
    Then I see Experience.StoreLocator.StoresOnMap is displayed
      And I see Experience.StoreLocator.StoresOnMap is in viewport
      And URL should contain "store-locator"

    Examples:
      | locale           | page         | user      |
      | default          | glp          | guest     |
      | multiLangDefault | shopping-bag | logged in |
      | multiLangDefault | wlp          | logged in |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari @UnifiedExperience @P2
  @Header @ElementCheck @ContentCheck @UnifiedMegaMenu @TEX
  @feature:CET1-3234 @tms:UTR-3897
  Scenario Outline: Mega Menu - Verify that the user is able to see and click and expand Customer Service link
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
      And I am a <user> user
      And I wait until the current page is loaded
    When I ensure unified mega menu is interactable
    Then in unified megamenu I select 1st level item with index 1
      And I wait for 2 seconds
    Then I smoothly scroll to the element Experience.Header.CustomerService
      And I see the attribute aria-expanded of element Experience.Header.CustomerService containing "false"
      And I click on Experience.Header.CustomerService
    Then I see the attribute aria-expanded of element Experience.Header.CustomerService containing "true"
      And I see Experience.Header.MegaMenuThirdLevelItems with text "Payment" is displayed
      And I see Experience.Header.MegaMenuThirdLevelItems with text "Company Information" is displayed
      And I see Experience.Header.MegaMenuThirdLevelItems with text "Returns & Refund" is displayed
    Then I click on Experience.Header.CustomerService
      And I see the attribute aria-expanded of element Experience.Header.CustomerService containing "false"

    Examples:
      | locale  | langCode | page         | user      |
      | default | default  | shopping-bag | guest     |
      | default | default  | glp          | logged in |
      | nl      | EN       | wlp          | guest     |
      | de      | EN       | plp          | logged in |
