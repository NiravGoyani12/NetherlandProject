Feature: Unified Experience - Cookies redirections

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Cookies @MultipleTabs @EER
  @feature:CET1-2614 @UnifiedExperience
  @tms:UTR-3270 @issue:EER-12739 @Translation
  Scenario Outline: Pages with disabled cookies - Verify disabled cookies on the cookie popup links
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I navigate to page <page>
      And I delete all cookies and refresh
    When I click on <cookieLink>
      And I switch to 2nd browser tab
    Then I see Experience.CookieNotice.MainScreen is not displayed in 3 seconds
      And I get translation for "<cookieLinkUrl>" and store it with key #cookieLinkUrl
      And URL should contain "#cookieLinkUrl"
      And all PVH cookies should not be set
      And functional PVH cookies should not be set

    @P2
    Examples:
      | locale  | langCode | page | cookieLink                                | cookieLinkUrl    |
      | default | default  | wlp  | Experience.CookieNotice.CookieNoticeLink  | CookieNoticeUrl  |
      | default | default  | pdp  | Experience.CookieNotice.PrivacyNoticeLink | PrivacyNoticeURL |

    Examples:
      | locale           | langCode         | page | cookieLink                                | cookieLinkUrl    |
      | multiLangDefault | multiLangDefault | wlp  | Experience.CookieNotice.CookieNoticeLink  | CookieNoticeUrl  |
      | multiLangDefault | multiLangDefault | pdp  | Experience.CookieNotice.PrivacyNoticeLink | PrivacyNoticeURL |

  @FullRegression
  @Desktop @Mobile @P2 @Translation
  @Chrome @FireFox @Safari @UnifiedExperience
  @Cookies @EER @feature:CET1-2614
  @tms:UTR-3279 @issue:EER-12468
  Scenario Outline: Pages with disabled cookies - Verify disabled cookies when landing on cookie list page
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I get translation for "CookieListUrl" and store it with key #cookieListUrl
      And I am on locale <locale> of url #cookieListUrl
      And I delete all cookies and refresh
    Then I see Experience.CookieNotice.MainScreen is not displayed in 3 seconds
      And all PVH cookies should not be set
      And functional PVH cookies should not be set

    Examples:
      | locale  | langCode |
      | default |default   |

  @FullRegression
  @Desktop @P1
  @Chrome @FireFox @Safari @UnifiedExperience
  @Cookies @MultipleTabs @EER @feature:CET1-2614
  @tms:UTR-3280 @Translation
  Scenario Outline: Pages with disabled cookies - Cookie popup is displayed after going from cookie disabled page to a cookie enabled page
    Given I am on locale <locale> home page of langCode <langCode> with accepted cookies
      And I get translation for "CookieListUrl" and store it with key #cookieListUrl
      And I navigate to page <page>
      And I delete all cookies and refresh
    When I click on Experience.CookieNotice.CookieNoticeLink
      And I switch to 2nd browser tab
      And I click on MyAccount.Newsletter.PopUpCloseButton in 5 seconds if displayed
      And I navigate to page <page>
    Then I see Experience.CookieNotice.MainScreen is displayed
    When I click on Experience.CookieNotice.PrivacyNoticeLink
      And I switch to 3rd browser tab
      And I click on MyAccount.Newsletter.PopUpCloseButton in 5 seconds if displayed
      And I navigate to page <page>
    Then I see Experience.CookieNotice.MainScreen is displayed
    When I am on locale <locale> of url #cookieListUrl
      And I navigate to page <page>
    Then I see Experience.CookieNotice.MainScreen is displayed

    Examples:
      | locale  | langCode | page         |
      | default | default  | shopping-bag |
      | default | default  | home-page    |

