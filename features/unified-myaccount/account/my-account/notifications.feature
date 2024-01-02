Feature: Unified My Account - Email notifications

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @UnifiedMyAccount @PPL @Notifications @P2
  @tms:UTR-13051
  Scenario Outline: User can register out of stock email and see my email notifications
    Given There is 1 account
      And There is 1 normal size product style of locale <locale> and langCode <langCode> where 1 size is out of stock with inventory between 5 and 9999
      And I am in url / of locale <locale> with new account email user1#email and password user1#password with forced accepted cookies
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber
    When in unified PDP I select the oos size and subscribe to notification
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed in 5 seconds
      And I click on ProductDetailPage.NotifyMePopup.ContinueShoppingButton
    When I navigate to notifications page
    Then I see MyAccount.NotificationsPage.NotificationProduct is displayed
      And I see MyAccount.NotificationsPage.CancelNotificationsButton is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @UnifiedMyAccount @PPL @Notifications @P2
  @tms:UTR-13052
  Scenario Outline: User can cancel out of stock email notifications
    Given There is 1 account
      And There are 2 normal size product style of locale <locale> and langCode <langCode> where 1 size is out of stock with inventory between 5 and 9999
    When I am in url / of locale <locale> with new account email user1#email and password user1#password with forced accepted cookies
      And I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber
      And in unified PDP I select the oos size and subscribe to notification
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed in 5 seconds
      And I click on ProductDetailPage.NotifyMePopup.ContinueShoppingButton
    When I am on locale <locale> pdp page of langCode <langCode> for product style product2#styleColourPartNumber
      And in unified PDP I select the oos size and subscribe to notification
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed in 5 seconds
      And I click on ProductDetailPage.NotifyMePopup.ContinueShoppingButton
    When I navigate to notifications page
    Then the count of displayed elements MyAccount.NotificationsPage.NotificationProduct is equal to 2
      And the count of displayed elements MyAccount.NotificationsPage.CancelNotificationsButton is equal to 2
    When I click on MyAccount.NotificationsPage.CancelNotificationsButton
    Then the count of displayed elements MyAccount.NotificationsPage.NotificationProduct is equal to 1

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari
  @UnifiedMyAccount @PPL @Notifications @P3
  @tms:UTR-13053
  Scenario Outline: User can add and cancel multiple out of stock items email notifications
    Given There is 1 account
      And There are 4 normal size product style of locale <locale> and langCode <langCode> where 1 size is out of stock with inventory between 5 and 9999
    When I am in url / of locale <locale> with new account email user1#email and password user1#password with forced accepted cookies
      And I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber
      And in unified PDP I select the oos size and subscribe to notification
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed in 5 seconds
      And I click on ProductDetailPage.NotifyMePopup.ContinueShoppingButton
    When I am on locale <locale> pdp page of langCode <langCode> for product style product2#styleColourPartNumber
      And in unified PDP I select the oos size and subscribe to notification
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed in 5 seconds
      And I click on ProductDetailPage.NotifyMePopup.ContinueShoppingButton
    When I am on locale <locale> pdp page of langCode <langCode> for product style product3#styleColourPartNumber
      And in unified PDP I select the oos size and subscribe to notification
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed in 5 seconds
      And I click on ProductDetailPage.NotifyMePopup.ContinueShoppingButton
    # When I am on locale <locale> pdp page of langCode <langCode> for product style product4#styleColourPartNumber
    #   And in unified PDP I select the oos size and subscribe to notification
    # Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed in 5 seconds
    #   And I click on ProductDetailPage.NotifyMePopup.ContinueShoppingButton
    When I navigate to notifications page
    Then the count of displayed elements MyAccount.NotificationsPage.NotificationProduct is equal to 3
      And the count of displayed elements MyAccount.NotificationsPage.CancelNotificationsButton is equal to 3
    When I click on MyAccount.NotificationsPage.CancelNotificationsButton
    # Then the count of displayed elements MyAccount.NotificationsPage.NotificationProduct is equal to 3
    # When I click on MyAccount.NotificationsPage.CancelNotificationsButton
    Then the count of displayed elements MyAccount.NotificationsPage.NotificationProduct is equal to 2
    When I click on MyAccount.NotificationsPage.CancelNotificationsButton
    Then the count of displayed elements MyAccount.NotificationsPage.NotificationProduct is equal to 1
    When I click on MyAccount.NotificationsPage.CancelNotificationsButton
    Then I see MyAccount.NotificationsPage.NotificationProduct is not displayed

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |