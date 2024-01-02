Feature: Unified Tracking - Events

  @FullRegression
  @Desktop
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedMyAccount @PPL
  @tms:UTR-8013
  @issue:PPL-1069
  Scenario Outline: Desktop - The event is fired when I click on the menu items on the my account modal
    Given I am Charles account on orders page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I wait until Experience.Header.MyAccountButton is displayed
      And I hover over Experience.Header.MyAccountButton
    When I inject utag event listener
      And I wait until MyAccount.AccountFlyout.<menuType> is displayed
      And I click on MyAccount.AccountFlyout.<menuType>
    Then utag event menu_interactions is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "menu_click"
      And utag event #event should contain attr eventLabel with value "<menuValue>"
      And utag event #event should contain attr menu_location with value "my_account_modal"
      And utag event #event should contain non-empty attr user_id
      And utag event #event should contain lower case non-empty attr contact_id
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale           | langCode         | menuType                    | menuValue     |
      | default          | default          | AccountDetailsLink          | details       |
      | multiLangDefault | multiLangDefault | AccountOrdersLink           | orders        |
      | default          | default          | AccountAddressesLink        | addresses     |
      | multiLangDefault | multiLangDefault | AccountEmailPreferencesLink | preferences   |
      | default          | default          | AccountNotificationsLink    | notifications |

  @FullRegression
  @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedMyAccount @PPL
  @tms:UTR-8016
  Scenario Outline: Mobile - The event is fired when I click on the menu items on the my account modal
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page store-locator
      And I ensure unified mega menu is interactable
      And I click on Experience.Header.MegaMenuSecondLevelItemsByIndex with index 1
      And I wait for 2 seconds
      And I smoothly scroll to the element Experience.Header.SignInButton
      And I click on Experience.Header.SignInButton
      And I wait until MyAccount.AccountFlyout.FlyMenu is displayed
      And I type "pvhqatester+4dc7ad77@gmail.com" in the field MyAccount.SignInPopUp.EmailField
      And I type "qwerty1234" in the field MyAccount.SignInPopUp.PasswordField
      And I click on MyAccount.SignInPopUp.SignInButton
      And I wait until Experience.Header.MyAccountButton is displayed
      And I click on Experience.Header.MyAccountButton
    When I inject utag event listener
      And I wait until Experience.Header.MegaMenuThirdLevelItems with args "<menuValue>" is displayed
      And I scroll to and click on Experience.Header.MegaMenuThirdLevelItems with args "<menuValue>"
    Then utag event menu_interactions is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "menu_click"
      And utag event #event should contain attr eventLabel with value "<menuValue>" in lower case
      And utag event #event should contain attr menu_location with value "my_account_modal"
      And utag event #event should contain non-empty attr user_id
      And utag event #event should contain lower case non-empty attr contact_id
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale           | langCode         | menuValue     |
      | multiLangDefault | multiLangDefault | Details       |
      | default          | default          | Orders        |
      | multiLangDefault | multiLangDefault | Addresses     |
      | default          | default          | Preferences   |
      | multiLangDefault | multiLangDefault | Notifications |

  @FullRegression
  @Desktop
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedMyAccount @PPL
  @tms:UTR-8014 @issue:PPL-1069
  Scenario Outline: Menu interactions - The event is fired when I click on the left side menu items on my account on Desktop
    Given I am on locale <locale> home page with forced accepted cookies
      And I navigate to page store-locator
      And I am a logged in user
      And I wait until Experience.Header.MyAccountButton is displayed
      And I hover over Experience.Header.MyAccountButton
      And I wait until MyAccount.AccountFlyout.AccountDetailsLink is displayed
      And I click on MyAccount.AccountFlyout.AccountDetailsLink
    When I inject utag event listener
      And I wait until MyAccount.Overview.<menuType> is displayed
      And I click on MyAccount.Overview.<menuType>
    Then utag event menu_interactions is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "menu_click"
      And utag event #event should contain attr eventLabel with value "<menuValue>"
      And utag event #event should contain attr menu_location with value "my_account_left_menu"
      And utag event #event should contain non-empty attr user_id
      And utag event #event should contain lower case non-empty attr contact_id
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | menuType            | menuValue     |
      | sk     | DetailsButton       | details       |
      | sk     | OrdersButton        | orders        |
      | sk     | AddressesButton     | addresses     |
      | sk     | PreferencesButton   | preferences   |
      | sk     | NotificationsButton | notifications |

  @FullRegression
  @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @Datalayer @UnifiedMyAccount @PPL
  @tms:UTR-8015 @issue:PPL-1069
  Scenario Outline: Menu interactions - The event is fired when I click on the left side menu items on my account on Mobile
    Given I am on locale <locale> home page with forced accepted cookies
      And I navigate to page store-locator
      And I am a logged in user
      And I am on locale <locale> of url <url>
    When I inject utag event listener
      And I wait until MyAccount.Overview.<menuType> is clickable
      And I click on MyAccount.Overview.<menuType>
    Then utag event menu_interactions is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "menu_click"
      And utag event #event should contain attr eventLabel with value "<menuValue>"
      And utag event #event should contain attr menu_location with value "my_account_left_menu"
      And utag event #event should contain non-empty attr user_id
      And utag event #event should contain lower case non-empty attr contact_id
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | url                     | menuType            | menuValue     |
      | sk     | myaccount/orders        | DetailsButton       | details       |
      | sk     | myaccount/details       | OrdersButton        | orders        |
      | sk     | myaccount/orders        | AddressesButton     | addresses     |
      | sk     | myaccount/notifications | PreferencesButton   | preferences   |
      | sk     | myaccount/preferences   | NotificationsButton | notifications |