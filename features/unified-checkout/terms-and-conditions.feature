Feature: Unified Checkout - Terms & Conditions

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @ShoppingBagPage @P3
  Scenario Outline: T&C - As a user I want to check all PPX T&C and privacy links from shopping bag page
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product with forced accepted cookies
      And I get translation for "TermsAndConditionsText" and store it with key #termsAndConditionsText
      And I get translation for "TermsAndConditionsURL" and store it with key #termsAndConditionsURL
      And I get translation from lokalise for "PrivacyNotice" and store it with key #privacyNoticeText
      And I get translation for "PrivacyNoticeURL" and store it with key #privacyNoticeURL
    When I wait until Payments.PaypalExpressPage.PaypalExpressButton is displayed in 10 seconds
    Then I see Payments.PaypalExpressPage.ShoppingBagPPXTermsLink with index 1 contains text "#termsAndConditionsText"
      And I see Payments.PaypalExpressPage.ShoppingBagPPXTermsLink with index 2 contains text "#privacyNoticeText"
    When I click on Payments.PaypalExpressPage.ShoppingBagPPXTermsLink with index 1
    When I click on Payments.PaypalExpressPage.ShoppingBagPPXTermsLink with index 2
      And I switch to 2nd browser tab
    Then I see URL should contain "#termsAndConditionsURL"
      And I wait until Checkout.FooterPage.CustomerServiceText is displayed
      And I see the count of elements Checkout.FooterPage.CustomerServiceText is greater than 1
      And I switch to 2nd browser tab
    Then I see URL should contain "#privacyNoticeURL"
      And I see the count of elements Checkout.FooterPage.CustomerServiceText is greater than 1

    @tms:UTR-16796 @issue:EESCK-11824
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @T&C @MiniShoppingBag @P3
  Scenario Outline: T&C - As a user I want to check all PPX T&C and privacy links from mini shopping bag page
    Given I am on locale <locale> shopping bag page of langCode <langCode> with 1 unit of any product with forced accepted cookies
      And I get translation for "TermsAndConditionsText" and store it with key #termsAndConditionsText
      And I get translation for "TermsAndConditionsURL" and store it with key #termsAndConditionsURL
      And I get translation from lokalise for "PrivacyNotice" and store it with key #privacyNoticeText
      And I get translation for "PrivacyNoticeURL" and store it with key #privacyNoticeURL
      And I wait until Payments.PaypalExpressPage.PaypalExpressButton is displayed in 10 seconds
    When I hover over Experience.Header.ShoppingBagButton
    Then I see Payments.PaypalExpressPage.MiniShoppingBagPPXTermsLink with index 1 contains text "#termsAndConditionsText"
      And I see Payments.PaypalExpressPage.MiniShoppingBagPPXTermsLink with index 2 contains text "#privacyNoticeText"
    When I click on Payments.PaypalExpressPage.MiniShoppingBagPPXTermsLink with index 1
      And I click on Payments.PaypalExpressPage.MiniShoppingBagPPXTermsLink with index 2
      And I switch to 2nd browser tab
    Then I see URL should contain "#termsAndConditionsURL"
      And I switch to 2nd browser tab
      And I switch to 2nd browser tab
    Then I see URL should contain "#privacyNoticeURL"

    @tms:UTR-16798 @issue:EESCK-11824
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation
  @UnifiedCheckout @T&C @Newsletter @ShippingPage @P2 @ExcludeTH
  Scenario Outline: T&C - As a guest or user I can sign-up for the Newsletter on Shipping page and check T&C
    Given I am <userType> on locale <locale> of langCode <langCode> on the shipping page
      And I get translation for "NewsletterTermsAndConditions" and store it with key #NewsLetterText
      And I get translation for "PrivacyNoticeURL" and store it with key #privacyNoticeURL
    When I click on Checkout.ShippingPage.NewsletterExpandButton
      And I wait until Checkout.ShippingPage.ExpandedNewsletterSection is displayed
    Then I see Checkout.ShippingPage.ExpandedNewsletterSection contains text "#NewsLetterText"
    When I click on Checkout.ShippingPage.NewsletterTandClink with index 1
      And I switch to 2nd browser tab
      And I wait until the current page is loaded
    Then I see URL should contain "#privacyNoticeURL"

    @tms:UTR-11251 @Mobile @issue:EESCK-12699
    Examples:
      | locale  | userType | langCode |
      | default | guest    | default  |

    @tms:UTR-11254 @issue:EESCK-12699
    Examples:
      | locale           | userType  | langCode         |
      | multiLangDefault | logged in | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @T&C @Newsletter @ShippingPage @P2 @ExcludeCK
  Scenario Outline: T&C - As a TH guest I cannot sign-up for the Newsletter on Shipping page and check both T&C links
    Given I am guest on locale <locale> of langCode <langCode> on the shipping page
    When I see the current page is shipping page
    Then I see Checkout.ShippingPage.NewsletterExpandButton is not displayed
      And I see Checkout.ShippingPage.NewsletterCheckbox is not displayed

    @tms:UTR-14293 @Mobile @issue:EESCK-11824
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-14294 @issue:EESCK-11824
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @T&C @ShippingPage @P3
  Scenario Outline: T&C - As a user I can see both T&C links on Checkout footer
    Given I am guest on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is clickable
      And I get translation for "TermsAndConditionsText" and store it with key #termsAndConditionsText
      And I get translation for "TermsAndConditionsURL" and store it with key #termsAndConditionsURL
      And I get translation from lokalise for "PrivacyNotice" and store it with key #privacyNoticeText
      And I get translation for "PrivacyNoticeURL" and store it with key #privacyNoticeURL
    When I click on Checkout.FooterPage.FooterLink with index 2
    When I click on Checkout.FooterPage.FooterLink with index 3
      And I switch to 2nd browser tab
    Then I see URL should contain "#termsAndConditionsURL"
      And I switch to 2nd browser tab
      And I switch to 2nd browser tab
    Then I see URL should contain "#privacyNoticeURL"

    @tms:UTR-16799 @issue:EESCK-11824
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16800 @issue:EESCK-11824
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @T&C @ShippingPage @P3
  Scenario Outline: T&C - As a user I can see both T&C links on Checkout PPX shipping page
    Given I am guest on locale <locale> of langCode <langCode> on the shipping page
      And I get translation for "TermsAndConditionsText" and store it with key #termsAndConditionsText
      And I get translation for "TermsAndConditionsURL" and store it with key #termsAndConditionsURL
      And I get translation from lokalise for "PrivacyNotice" and store it with key #privacyNoticeText
      And I get translation for "PrivacyNoticeURL" and store it with key #privacyNoticeURL
      And I wait until Payments.PaypalExpressPage.ShippingPagePPXTermsLink is displayed
      And I wait for 7 seconds
    When I click on Payments.PaypalExpressPage.ShippingPagePPXTermsLink with index 1
      And I switch to 2nd browser tab
    Then I see URL should contain "#termsAndConditionsURL"
      And I close current browser tab
      And I switch to 1st browser tab
    When I click on Payments.PaypalExpressPage.ShippingPagePPXTermsLink with index 2
      And I switch to 2nd browser tab
    Then I see URL should contain "#privacyNoticeURL"

    @tms:UTR-16802 @issue:EESCK-11824
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @T&C @PaymentPage @P3
  Scenario Outline: T&C - As a user I can see both T&C links on Checkout Payment Page
    Given I am <userType> on locale <locale> of langCode <langCode> on the payment page
      And I get translation for "TermsAndConditionsText" and store it with key #termsAndConditionsText
      And I get translation for "TermsAndConditionsURL" and store it with key #termsAndConditionsURL
      And I get translation from lokalise for "PrivacyNotice" and store it with key #privacyNoticeText
      And I get translation for "PrivacyNoticeURL" and store it with key #privacyNoticeURL
    When I click on Checkout.PaymentPage.TermsAndConditionsLinks with index 1
    When I click on Checkout.PaymentPage.TermsAndConditionsLinks with index 2
      And I switch to 2nd browser tab
    Then I see URL should contain "#termsAndConditionsURL"
      And I switch to 2nd browser tab
    Then I see URL should contain "#privacyNoticeURL"

    @tms:UTR-16803 @issue:EESCK-11824
    Examples:
      | locale  | langCode | userType |
      | default | default  | guest    |

    @tms:UTR-16804 @issue:EESCK-11824
    Examples:
      | locale | langCode | userType  |
      | de     | EN       | logged in |
