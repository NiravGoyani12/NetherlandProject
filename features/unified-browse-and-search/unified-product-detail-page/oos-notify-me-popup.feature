Feature: Unified PDP - Out of Stock notify me popup

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @OutOfStockPopup @P2
  @tms:UTR-12285 @issue:PAN-6024
  Scenario Outline: OutOfStockPopup - As guest user verify registering to OOS email for 1 size OOS product
    Given There is 1 one size product style of locale <locale> and langCode <langCode> with inventory between 0 and 0 filtered by FH
    When I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.Pdp.NotifyMePopup is displayed
    When I type "notify@me.com" in the field ProductDetailPage.NotifyMePopup.EmailInput
      And I click on ProductDetailPage.NotifyMePopup.NotifyMeButton by js
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PDP @TEE @UnifiedPdp @UnifiedExperience @OutOfStockPopup @P2
  @tms:UTR-12286 @issue:PAN-6024
  Scenario Outline: OutOfStockPopup - As a guest user verify registering to OOS email for normal size OOS product
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 0 and 0 filtered by FH
      And I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
      And I get translation from lokalise for "NotifyMeButtonText" and store it with key #NotifyMe
      And I wait until the current page is loaded
    When I click on ProductDetailPage.Pdp.SizeSoldOutButton
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.Pdp.NotifyMePopup is displayed
    When I type "notify@me.com" in the field ProductDetailPage.NotifyMePopup.EmailInput
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeButton with text #NotifyMe is displayed
    When I click on ProductDetailPage.NotifyMePopup.NotifyMeButton by js
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @OutOfStockPopup @P2
  @tms:UTR-12287
  Scenario Outline: OutOfStockPopup - As a logged in user verify email is pre-populated in the notify me popup for OOS product
    Given There is 1 width-length size product item of locale <locale> and langCode <langCode> with inventory between 0 and 0 filtered by FH
    When I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I am a logged in user
      And in unified PDP I select the oos width and length and save as #size
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.Pdp.NotifyMePopup is displayed
      And I see ProductDetailPage.NotifyMePopup.EmailInput with text user1#email is displayed
    When I click on ProductDetailPage.NotifyMePopup.NotifyMeButton by js
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PDP @TEE @UnifiedPdp @UnifiedExperience @OutOfStockPopup @P2
  @tms:UTR-12288
  Scenario Outline: OutOfStockPopup - Verify error message is thrown when invalid email is entered in the notify me popup
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 0 and 0 filtered by FH
      And I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I get translation from lokalise for "EmailError" and store it with key #EmailError
    When I click on ProductDetailPage.Pdp.SizeSoldOutButton
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.Pdp.NotifyMePopup is displayed
    When I type "<emailAddress>" in the field ProductDetailPage.NotifyMePopup.EmailInput
      And I click on ProductDetailPage.NotifyMePopup.NotifyMeButton by js
    Then I see ProductDetailPage.NotifyMePopup.EmailErrorMessage contains text "#EmailError"

    Examples:
      | locale  | langCode | emailAddress | FieldError        |
      | default | default  | abc          | EmailMissingError |
      | default | default  | user.com     | EmailError        |
      | default | default  | user@email   | EmailError        |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @OutOfStockPopup @P2
  @tms:UTR-12631
  Scenario Outline: OutOfStockPopup - For a one size product verify the selected product size and data is correctly displayed on the out of stock popup
    Given There is 1 one size product item of locale <locale> and langCode <langCode> with inventory between 0 and 0 filtered by FH
    When I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
      And I fetch size name of product item product1#skuPartNumber saved as #sizeName
      And I fetch colour name of product item product1#skuPartNumber saved as #colourName
      And I wait until the current page is loaded
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.Pdp.NotifyMePopup is displayed
      And I see ProductDetailPage.NotifyMePopup.OosPopupProductName is displayed
      And I see ProductDetailPage.NotifyMePopup.OosPopupProductPrice is displayed
      And I see ProductDetailPage.NotifyMePopup.OosPopupSize with text #sizeName is displayed
      And I see ProductDetailPage.NotifyMePopup.OosPopupColor with text #colourName is displayed
      And I see ProductDetailPage.NotifyMePopup.OosPopupSoldoutLabel is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @OutOfStockPopup @P2
  @tms:UTR-12632
  Scenario Outline: OutOfStockPopup - For a normal size product verify the selected product size and data is correctly displayed on the out of stock popup
    Given There is 1 one size product item of locale <locale> and langCode <langCode> with inventory between 0 and 0
      And I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I fetch current price of product item product1#skuPartNumber saved as #currentPrice
      And I fetch colour name of product item product1#skuPartNumber saved as #colourName
    When in unified PDP I select the oos size and save as #sizeName
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.Pdp.NotifyMePopup is displayed
      And I see ProductDetailPage.NotifyMePopup.OosPopupProductName is displayed
      And I see ProductDetailPage.NotifyMePopup.OosPopupProductPrice contains text "#currentPrice"
      And I see ProductDetailPage.NotifyMePopup.OosPopupSize with text #sizeName is displayed
      And I see ProductDetailPage.NotifyMePopup.OosPopupColor with text #colourName is displayed
      And I see ProductDetailPage.NotifyMePopup.OosPopupSoldoutLabel is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @OutOfStockPopup @P2
  @tms:UTR-13361
  Scenario Outline: OutOfStockPopup - As a guest user verify email is pre-populated for same size in the notify me popup for an already submitted oos request
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 0 and 0 filtered by FH
      And There is 1 account
    When I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I am a guest user
      And I click on ProductDetailPage.Pdp.SizeSoldOutButton
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.Pdp.NotifyMePopup is displayed
    When I type "user1#email" in the field ProductDetailPage.NotifyMePopup.EmailInput
      And I click on ProductDetailPage.NotifyMePopup.NotifyMeButton by js
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed
    When I click on ProductDetailPage.NotifyMePopup.ContinueShoppingButton
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.NotifyMePopup.EmailInput with text user1#email is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @OutOfStockPopup @P2
  @tms:UTR-13362
  Scenario Outline: OutOfStockPopup - As a guest user verify email is pre-populated for a different size in the notify me popup for an already submitted oos request
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 0 and 0 filtered by FH
      And There is 1 account
    When I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I am a guest user
      And I click on ProductDetailPage.Pdp.SoldOutButton with index 1
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.Pdp.NotifyMePopup is displayed
    When I type "user1#email" in the field ProductDetailPage.NotifyMePopup.EmailInput
      And I click on ProductDetailPage.NotifyMePopup.NotifyMeButton by js
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed
    When I click on ProductDetailPage.NotifyMePopup.ContinueShoppingButton
      And I click on ProductDetailPage.Pdp.SoldOutButton with index 2
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.NotifyMePopup.EmailInput with text user1#email is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @OutOfStockPopup @P2
  @tms:UTR-13363 @issue:PAN-5839
  Scenario Outline: OutOfStockPopup - As a guest user verify email is pre-populated for a different colour in the notify me popup for an already submitted oos request
    Given There is 1 account
    When I am on locale <locale> pdp page of langCode <langCode> for product style MW0MW306070GY/J20J220717XI1 with forced accepted cookies
      And I wait until the current page is loaded
      And I am a guest user
      And I click on ProductDetailPage.Pdp.SizeSoldOutButton
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.Pdp.NotifyMePopup is displayed
    When I type "user1#email" in the field ProductDetailPage.NotifyMePopup.EmailInput
      And I click on ProductDetailPage.NotifyMePopup.NotifyMeButton by js
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed
    When I click on ProductDetailPage.NotifyMePopup.ContinueShoppingButton
      And I click on ProductDetailPage.Pdp.ColorSwatchButton with index 2
      And I click on ProductDetailPage.Pdp.SizeSoldOutButton
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.NotifyMePopup.EmailInput with text user1#email is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @OutOfStockPopup @P2
  @tms:UTR-13364
  Scenario Outline: OutOfStockPopup - As a guest user verify email is not pre-populated in the notify me popup after page refresh for an already submitted oos request
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 0 and 0 filtered by FH
      And There is 1 account
    When I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I am a guest user
      And I click on ProductDetailPage.Pdp.SizeSoldOutButton
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.Pdp.NotifyMePopup is displayed
    When I type "user1#email" in the field ProductDetailPage.NotifyMePopup.EmailInput
      And I click on ProductDetailPage.NotifyMePopup.NotifyMeButton by js
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed
    When I click on ProductDetailPage.NotifyMePopup.ContinueShoppingButton
      And I refresh page
      And I click on ProductDetailPage.Pdp.SizeSoldOutButton
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.NotifyMePopup.EmailInput with text user1#email is not displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PDP @TEE @UnifiedPdp @UnifiedExperience @OutOfStockPopup @P2
  @tms:UTR-13439 @ExcludeCK
  Scenario Outline: OutOfStockPopup - Verify CONSENT_NOTIFY_ME consent text is displayed on the notify me popup when ML toggle is turned on
    Given There is 1 normal size product style of locale <locale> where 2 sizes are out of stock with inventory between 5 and 9999 filtered by FH
    When I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I extract xcomreg ENABLE_ML_MEMBERSHIP_HUB_TOGGLE saved as #mlToggle
    Then I see the stored value with key #mlToggle is equal to "True"
      And I get translation from lokalise for "ConsentNotifyMe" and store it with key #ConsentText
      And I click on ProductDetailPage.Pdp.SizeSoldOutButton
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.NotifyMePopup.ConsentText with text #ConsentText is displayed

    Examples:
      | locale | langCode |
      | it     | default  |

    Examples:
      | locale | langCode |
      | de     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PDP @TEE @UnifiedPdp @UnifiedExperience @OutOfStockPopup @P2
  @tms:UTR-18580 @ExcludeTH
  Scenario Outline: OutOfStockPopup - Verify newsletter subscription checkbox is displayed on CK OOS popup
    Given There is 1 normal size product style of locale <locale> where 2 sizes are out of stock with inventory between 5 and 9999 filtered by FH
      And There is 1 account
    When I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I extract xcomreg IS_SHOWING_SIGNUP_TO_NEWSLETTER_CHECKBOX saved as #newsletterCheckboxToggle
      And I get translation from lokalise for "NewsletterCheckbox" and store it with key #newsletterCheckbox
    Then I see the stored value with key #newsletterCheckboxToggle is equal to "True"
    When I click on ProductDetailPage.Pdp.SizeSoldOutButton
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.Pdp.NotifyMePopup is displayed
      And I see ProductDetailPage.Pdp.NewsletterCheckbox is displayed
      And I see the attribute value of element ProductDetailPage.Pdp.NewsletterCheckboxInput containing "true"
      And I see ProductDetailPage.Pdp.NewsletterCheckboxContent with text #newsletterCheckbox is displayed
    When I type "user1#email" in the field ProductDetailPage.NotifyMePopup.EmailInput
      And I click on ProductDetailPage.Pdp.NewsletterCheckbox
    Then I see the attribute value of element ProductDetailPage.Pdp.NewsletterCheckboxInput containing "false"
    When I click on ProductDetailPage.Pdp.NewsletterCheckbox
      And I click on ProductDetailPage.NotifyMePopup.NotifyMeButton by js
    Then I see ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed

    Examples:
      | locale  | langCode |
      | default | default  |