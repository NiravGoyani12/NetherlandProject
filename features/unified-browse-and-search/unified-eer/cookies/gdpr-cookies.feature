Feature: Unified Experience - Cookies

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Cookies @EER @UnifiedExperience
  @tms:UTR-3269 @feature:CET1-2614
  Scenario Outline: GDPR cookies - Cookie message is displayed with cleared browser data
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I delete all cookies and refresh
    Then I see Experience.CookieNotice.MainScreen is displayed
      And I see the attribute data-nosnippet of element Experience.CookieNotice.MainScreen containing "true"

    @SmokeTest @RCTest @P1
    Examples:
      | locale  | langCode | page      |
      | default | default  | home-page |

    Examples:
      | locale           | langCode         | page |
      | multiLangDefault | multiLangDefault | wlp  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @Firefox @Safari @UnifiedExperience
  @Cookies @EER
  @tms:UTR-3272 @feature:CET1-2614
  Scenario Outline: GDPR cookies - Clicking accept button in the cookie message accepts all cookies
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I delete all cookies and refresh
      And I click on Experience.CookieNotice.IAgreeButton
    Then all PVH cookies should be set
      And cookie PVH_COOKIES_GDPR should have parameter secure set to true
      And cookie PVH_COOKIES_GDPR should have parameter sameSite set to Lax
      And cookie PVH_COOKIES_GDPR_ANALYTICS should have parameter secure set to true
      And cookie PVH_COOKIES_GDPR_ANALYTICS should have parameter sameSite set to Lax
      And cookie PVH_COOKIES_GDPR_SOCIALMEDIA should have parameter secure set to true
      And cookie PVH_COOKIES_GDPR_SOCIALMEDIA should have parameter sameSite set to Lax
      And I see Experience.CookieNotice.MainScreen is not displayed
    Then I refresh page
      And I see Experience.CookieNotice.MainScreen is not displayed
    Then I navigate to page glp
      And I wait until the current page is GLP

    @SmokeTest @RCTest
    Examples:
      | locale  | langCode | page      |
      | default | default  | home-page |

    Examples:
      | locale           | langCode         | page |
      | multiLangDefault | multiLangDefault | wlp  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Cookies @EER @UnifiedExperience
  @tms:UTR-3273 @feature:CET1-2614
  Scenario Outline: GDPR cookies - Opting in/out should only be available for analytical and social media / commercial cookies
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I delete all cookies and refresh
    When I click on Experience.CookieNotice.SettingsButton
    Then I see Experience.CookieNotice.FunctionalCheckbox is disabled
      And I see the checkbox Experience.CookieNotice.FunctionalCheckbox is checked
    When I set the checkbox Experience.CookieNotice.FunctionalCheckbox status to false
    Then I see Experience.CookieNotice.FunctionalCheckbox is disabled
      And I see the checkbox Experience.CookieNotice.FunctionalCheckbox is checked
      And I see Experience.CookieNotice.AnalyticalCheckbox is enabled
      And I see the checkbox Experience.CookieNotice.AnalyticalCheckbox is unchecked in 1 second
      And I see Experience.CookieNotice.SocialMediaAndAdvertisingCheckbox is enabled
      And I see the checkbox Experience.CookieNotice.SocialMediaAndAdvertisingCheckbox is unchecked in 1 second
    When I click on Experience.CookieNotice.DoneButton
    Then all PVH cookies should not be set
      And functional PVH cookies should be set

    @P2
    Examples:
      | locale  | langCode | page      |
      | default | default  | home-page |

    Examples:
      | locale           | langCode         | page |
      | multiLangDefault | multiLangDefault | wlp  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Cookies @EER @UnifiedExperience
  @tms:UTR-3274 @feature:CET1-2614
  Scenario Outline: GDPR cookies - Selecting certain cookies should place the opted in cookie
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I delete all cookies and refresh
      And I click on Experience.CookieNotice.SettingsButton
    When I set the checkbox <cookieType> status to true
      And I click on Experience.CookieNotice.DoneButton
    Then cookie <cookieName> should have parameter value set to Accept
      And cookie PVH_COOKIES_GDPR should have parameter value set to Accept
      And all PVH cookies should not be set
      And I see Experience.CookieNotice.MainScreen is not displayed

    @P2
    Examples:
      | locale  | langCode | page         | cookieType                                                | cookieName                   |
      | default | default  | shopping-bag | Experience.CookieNotice.AnalyticalCheckbox                | PVH_COOKIES_GDPR_ANALYTICS   |
      | default | default  | wlp          | Experience.CookieNotice.SocialMediaAndAdvertisingCheckbox | PVH_COOKIES_GDPR_SOCIALMEDIA |

    Examples:
      | locale           | langCode         | page         | cookieType                                                | cookieName                   |
      | multiLangDefault | multiLangDefault | wlp          | Experience.CookieNotice.AnalyticalCheckbox                | PVH_COOKIES_GDPR_ANALYTICS   |
      | multiLangDefault | multiLangDefault | shopping-bag | Experience.CookieNotice.SocialMediaAndAdvertisingCheckbox | PVH_COOKIES_GDPR_SOCIALMEDIA |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Cookies @EER @UnifiedExperience
  @tms:UTR-3275 @feature:CET1-2614
  Scenario Outline: GDPR cookies - Selecting all cookies should place all PVH GDPR cookies
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I delete all cookies and refresh
      And I click on Experience.CookieNotice.SettingsButton
    When I set the checkbox Experience.CookieNotice.AnalyticalCheckbox status to true
      And I set the checkbox Experience.CookieNotice.SocialMediaAndAdvertisingCheckbox status to true
      And I click on Experience.CookieNotice.DoneButton
    Then all PVH cookies should be set
      And cookie PVH_COOKIES_GDPR should have parameter secure set to true
      And cookie PVH_COOKIES_GDPR should have parameter sameSite set to Lax
      And cookie PVH_COOKIES_GDPR_ANALYTICS should have parameter secure set to true
      And cookie PVH_COOKIES_GDPR_ANALYTICS should have parameter sameSite set to Lax
      And cookie PVH_COOKIES_GDPR_SOCIALMEDIA should have parameter secure set to true
      And cookie PVH_COOKIES_GDPR_SOCIALMEDIA should have parameter sameSite set to Lax
      And I see Experience.CookieNotice.MainScreen is not displayed

    @P2
    Examples:
      | locale  | langCode | page      |
      | default | default  | home-page |

    Examples:
      | locale           | langCode         | page |
      | multiLangDefault | multiLangDefault | wlp  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Cookies @EER @UnifiedExperience
  @tms:UTR-3276 @feature:CET1-2614
  Scenario Outline: GDPR cookies - Cookies are accepted per country only
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I delete all cookies and refresh
    When I am on locale <locale> home page
      And I navigate to page <page>
      And I delete all cookies and refresh
      And I click on Experience.CookieNotice.IAgreeButton
      And I am on locale be home page
    Then I see Experience.CookieNotice.MainScreen is displayed

    @P2
    Examples:
      | locale  | langCode | page          |
      | default | default  | store-locator |

    Examples:
      | locale           | langCode         | page |
      | multiLangDefault | multiLangDefault | wlp  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Cookies @EER @UnifiedExperience
  @tms:UTR-3277 @feature:CET1-2614
  Scenario Outline: GDPR cookies - Clearing cookies in a session should re-enable the cookie pop-up
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I delete all cookies and refresh
    When I click on Experience.CookieNotice.IAgreeButton
      And I delete all cookies and refresh
    Then I see Experience.CookieNotice.MainScreen is displayed
      And all PVH cookies should not be set

    @P2
    Examples:
      | locale  | langCode | page         |
      | default | default  | shopping-bag |

    Examples:
      | locale           | langCode         | page |
      | multiLangDefault | multiLangDefault | wlp  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending @P2
  @Cookies @EER @UnifiedExperience
  @tms:UTR-3278 @feature:CET1-2614
  Scenario Outline: GDPR cookies - Closing cookie message doesn't affect page scrolling
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I delete all cookies and refresh
    When I click on Experience.CookieNotice.SettingsButton
      And I click on Experience.CookieNotice.DoneButton
      And I wait until Experience.CookieNotice.MainScreen is not displayed in 2 seconds
      And I move to the bottom of the page
    Then I see Experience.Footer.MainBlock is in viewport in 5 seconds

    Examples:
      | locale           | langCode         | page          |
      | default          | default          | store-locator |
      | multiLangDefault | multiLangDefault | wlp           |

  @FullRegression
  @Desktop @Mobile
  @Chrome @UnifiedExperience
  @Cookies @EER
  @feature:@EER-3179 @tms:UTR-3204 @CookieExpiry
  Scenario Outline: GDPR cookies - Verfiy the expiry date for consent cookies is set to 6 months once accepted
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I delete all cookies and refresh
      And I click on Experience.CookieNotice.IAgreeButton
    Then all PVH cookies should be set
      And cookie PVH_COOKIES_GDPR should have parameter expiryDate set to <months>
      And cookie PVH_COOKIES_GDPR_ANALYTICS should have parameter expiryDate set to <months>
      And cookie PVH_COOKIES_GDPR_SOCIALMEDIA should have parameter expiryDate set to <months>
      And I see Experience.CookieNotice.MainScreen is not displayed

    @SmokeTest @RCTest @P2
    Examples:
      | locale  | langCode | page | months |
      | default | default  | wlp  | 6      |

    Examples:
      | locale           | langCode         | page | months |
      | multiLangDefault | multiLangDefault | wlp  | 6      |


#  Todo : Enable this scenario once the optimizely test is completed and new cookie changes are Live in all environments.
#  @FullRegression
#  @Desktop @Mobile
#  @Chrome @UnifiedExperience
#  @Cookies @EER
#  @feature:CET1-4563
#  @tms:UTR-13264
#  Scenario Outline: GDPR cookies - Reject all button rejects all PVH cookies except for the mandatory functional cookies.
#    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
#    And I navigate to page <page>
#    And I delete all cookies and refresh
#    When I click on Experience.CookieNotice.RejectAllNonEssentialButton
#    Then all PVH cookies should not be set
#    And functional PVH cookies should be set
#    And cookie PVH_COOKIES_GDPR should have parameter value set to Accept
#    And cookie PVH_COOKIES_GDPR_ANALYTICS should have parameter value set to Reject
#    And cookie PVH_COOKIES_GDPR_SOCIALMEDIA should have parameter value set to Reject
#    And I see Experience.CookieNotice.MainScreen is not displayed
#
#    Examples:
#      | locale  | langCode | page |
#      | default | default  | wlp  |
#
#    Examples:
#      | locale           | langCode         | page         |
#      | multiLangDefault | multiLangDefault | shopping-bag |

#  Todo : Enable below four scenarios once the optimizely test is completed and new cookie changes are Live in all environments.
#  Todo : Also refactor page object and remove old scenarios and updat the UTR for the same.
#  @FullRegression
#  @Desktop @Mobile
#  @Chrome @FireFox @Safari
#  @Cookies @EER @UnifiedExperience
#  @tms:UTR-3273 @feature:CET1-2614
#  Scenario Outline: GDPR cookies - Opting in/out should only be available for analytical and social media / commercial cookies
#    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
#    And I navigate to page <page>
#    And I delete all cookies and refresh
#    When I click on Experience.CookieNotice.ManageCookiePreferencesButton
#    Then I see Experience.CookieNotice.FunctionalCheckbox is disabled
#    And I see the checkbox Experience.CookieNotice.FunctionalCheckbox is checked
#    When I set the checkbox Experience.CookieNotice.FunctionalCheckbox status to false
#    Then I see Experience.CookieNotice.FunctionalCheckbox is disabled
#    And I see the checkbox Experience.CookieNotice.FunctionalCheckbox is checked
#    And I see Experience.CookieNotice.AnalyticalCheckbox is enabled
#    And I see the checkbox Experience.CookieNotice.AnalyticalCheckbox is unchecked in 1 second
#    And I see Experience.CookieNotice.SocialMediaAndAdvertisingCheckbox is enabled
#    And I see the checkbox Experience.CookieNotice.SocialMediaAndAdvertisingCheckbox is unchecked in 1 second
#    When I click on Experience.CookieNotice.DoneButton
#    Then all PVH cookies should not be set
#    And functional PVH cookies should be set
#
#    @P2
#    Examples:
#      | locale  | langCode | page      |
#      | default | default  | home-page |
#
#    Examples:
#      | locale           | langCode         | page |
#      | multiLangDefault | multiLangDefault | wlp  |
#
#
#  @FullRegression
#  @Desktop @Mobile
#  @Chrome @FireFox @Safari
#  @Cookies @EER @UnifiedExperience
#  @tms:UTR-3274 @feature:CET1-2614
#  Scenario Outline: GDPR cookies - Selecting certain cookies should place the opted in cookie
#    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
#    And I navigate to page <page>
#    And I delete all cookies and refresh
#    And I click on Experience.CookieNotice.ManageCookiePreferencesButton
#    When I set the checkbox <cookieType> status to true
#    And I click on Experience.CookieNotice.DoneButton
#    Then cookie <cookieName> should have parameter value set to Accept
#    And cookie PVH_COOKIES_GDPR should have parameter value set to Accept
#    And all PVH cookies should not be set
#    And I see Experience.CookieNotice.MainScreen is not displayed
#
#    @P2
#    Examples:
#      | locale  | langCode | page         | cookieType                                                | cookieName                   |
#      | default | default  | shopping-bag | Experience.CookieNotice.AnalyticalCheckbox                | PVH_COOKIES_GDPR_ANALYTICS   |
#      | default | default  | wlp          | Experience.CookieNotice.SocialMediaAndAdvertisingCheckbox | PVH_COOKIES_GDPR_SOCIALMEDIA |
#
#    Examples:
#      | locale           | langCode         | page         | cookieType                                                | cookieName                   |
#      | multiLangDefault | multiLangDefault | wlp          | Experience.CookieNotice.AnalyticalCheckbox                | PVH_COOKIES_GDPR_ANALYTICS   |
#      | multiLangDefault | multiLangDefault | shopping-bag | Experience.CookieNotice.SocialMediaAndAdvertisingCheckbox | PVH_COOKIES_GDPR_SOCIALMEDIA |
#
#
#  @FullRegression
#  @Desktop @Mobile
#  @Chrome @FireFox @Safari
#  @Cookies @EER @UnifiedExperience
#  @tms:UTR-3275 @feature:CET1-2614
#  Scenario Outline: GDPR cookies - Selecting all cookies should place all PVH GDPR cookies
#    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
#    And I navigate to page <page>
#    And I delete all cookies and refresh
#    And I click on Experience.CookieNotice.ManageCookiePreferencesButton
#    When I set the checkbox Experience.CookieNotice.AnalyticalCheckbox status to true
#    And I set the checkbox Experience.CookieNotice.SocialMediaAndAdvertisingCheckbox status to true
#    And I click on Experience.CookieNotice.DoneButton
#    Then all PVH cookies should be set
#    And cookie PVH_COOKIES_GDPR should have parameter secure set to true
#    And cookie PVH_COOKIES_GDPR should have parameter sameSite set to Lax
#    And cookie PVH_COOKIES_GDPR_ANALYTICS should have parameter secure set to true
#    And cookie PVH_COOKIES_GDPR_ANALYTICS should have parameter sameSite set to Lax
#    And cookie PVH_COOKIES_GDPR_SOCIALMEDIA should have parameter secure set to true
#    And cookie PVH_COOKIES_GDPR_SOCIALMEDIA should have parameter sameSite set to Lax
#    And I see Experience.CookieNotice.MainScreen is not displayed
#
#    @P2
#    Examples:
#      | locale  | langCode | page      |
#      | default | default  | home-page |
#
#    Examples:
#      | locale           | langCode         | page |
#      | multiLangDefault | multiLangDefault | wlp  |
#
#
#  @FullRegression
#  @Desktop @Mobile
#  @Chrome @FireFox @SafariPending @P2
#  @Cookies @EER @UnifiedExperience
#  @tms:UTR-3278 @feature:CET1-2614
#  Scenario Outline: GDPR cookies - Closing cookie message doesn't affect page scrolling
#    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
#    And I navigate to page <page>
#    And I delete all cookies and refresh
#    When I click on Experience.CookieNotice.ManageCookiePreferencesButton
#    And I click on Experience.CookieNotice.DoneButton
#    And I wait until Experience.CookieNotice.MainScreen is not displayed in 2 seconds
#    And I move to the bottom of the page
#    Then I see Experience.Footer.MainBlock is in viewport in 5 seconds
#
#    Examples:
#      | locale           | langCode         | page          |
#      | default          | default          | store-locator |
#      | multiLangDefault | multiLangDefault | wlp           |
#
