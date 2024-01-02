Feature: Unified Newsletter - Pop up

  #@FullRegression
  @RCTest
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedNewsletter @PPL @ExcludeSIT @P2 @ExcludeTH
  Scenario Outline: I can see newsletter pop up on multiple pages and sign up
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And There is 1 accounts
      And I delete all cookies and refresh
      And I click on Experience.CookieNotice.IAgreeButton
      And I navigate to page <page>
      And I get translation from lokalise for "NewsletterTitle" and store it with key #Title
      And I get translation from lokalise for "NewsletterInfo" and store it with key #Info
      And I get translation from lokalise for "NewsletterBenefit15Off" and store it with key #15%Benefit
      And I get translation from lokalise for "NewsletterBenefitEarlyAccess" and store it with key #EarlyAccess
      And I get translation from lokalise for "NewsletterBenefitExclusiveDiscount" and store it with key #ExclusiveDiscount
    Then I see MyAccount.Newsletter.PopUp is displayed in 10 seconds
      And I see MyAccount.Newsletter.PopUpTitle contains text "#Title"
      And I see MyAccount.Newsletter.PopUpInfo contains text "#Info"
      And I see MyAccount.Newsletter.PopUpBenefitsList with index 1 contains text "#15%Benefit"
      And I see MyAccount.Newsletter.PopUpBenefitsList with index 2 contains text "#EarlyAccess"
      And I see MyAccount.Newsletter.PopUpBenefitsList with index 3 contains text "#ExclusiveDiscount"
      And I see MyAccount.Newsletter.PopUpMenCheckbox is not displayed
      And I see MyAccount.Newsletter.PopUpWomenCheckbox is not displayed
      And I see MyAccount.Newsletter.PopUpKidsCheckbox is not displayed
    When I type "user1#email" in the field MyAccount.Newsletter.PopUpEmailField
      And I set the checkbox MyAccount.Newsletter.<box> status to true
      And I set the checkbox MyAccount.Newsletter.PopUpTermsAndConditionsCheckbox status to true
      And I click on MyAccount.Newsletter.PopUpSubscribeButton
      And I get translation from lokalise for "NewsletterSignUpTitle" and store it with key #Title
      And I get translation from lokalise for "NewsletterSignUpSuccessMessage" and store it with key #SuccessMessage
    Then I see MyAccount.Newsletter.PopUpSignedUpTitle contains text "#Title"
      And I see MyAccount.Newsletter.PopUpSignedUpInfo contains text "#SuccessMessage"
    When I click on MyAccount.Newsletter.PopUpCloseButton
    Then I see MyAccount.Newsletter.PopUp is not displayed

    @tms:UTR-13332
    Examples:
      | locale | langCode | page          | box              |
      | es     | default  | store-locator | PopUpMenCheckbox |

    @tms:UTR-14592
    Examples:
      | locale           | langCode         | page         | box                |
      | multiLangDefault | multiLangDefault | shopping-bag | PopUpWomenCheckbox |

    @tms:UTR-14593
    Examples:
      | locale | langCode | page | box               |
      | fi     | default  | wlp  | PopUpKidsCheckbox |

    @tms:UTR-14594
    Examples:
      | locale           | langCode         | page | box              |
      | multiLangDefault | multiLangDefault | pdp  | PopUpMenCheckbox |

  #@FullRegression
  @RCTest
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedNewsletter @PPL @ExcludeSIT @P2 @ExcludeCK
  Scenario Outline: I can see newsletter pop up on multiple pages and sign up
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And There is 1 accounts
      And I delete all cookies and refresh
      And I click on Experience.CookieNotice.IAgreeButton
      And I navigate to page <page>
      And I get translation from lokalise for "NewsletterTitleTH" and store it with key #Title
      And I get translation from lokalise for "NewsletterInfoTH" and store it with key #Info
      And I get translation from lokalise for "NewsletterBenefit15Off" and store it with key #15%Benefit
      And I get translation from lokalise for "NewsletterBenefitEarlyAccess" and store it with key #EarlyAccess
      And I get translation from lokalise for "NewsletterBenefitExclusiveDiscount" and store it with key #ExclusiveDiscount
    Then I see MyAccount.Newsletter.PopUp is displayed in 10 seconds
      And I see MyAccount.Newsletter.PopUpTitle contains text "#Title"
      And I see MyAccount.Newsletter.PopUpInfo contains text "#Info"
      And I see MyAccount.Newsletter.PopUpBenefitsList with index 1 contains text "#15%Benefit"
      # And I see MyAccount.Newsletter.PopUpBenefitsList with index 2 contains text "#EarlyAccess"
      And I see MyAccount.Newsletter.PopUpBenefitsList with index 3 contains text "#ExclusiveDiscount"
      And I see MyAccount.Newsletter.PopUpMenCheckbox is not displayed
      And I see MyAccount.Newsletter.PopUpWomenCheckbox is not displayed
      And I see MyAccount.Newsletter.PopUpKidsCheckbox is not displayed
    When I type "user1#email" in the field MyAccount.Newsletter.PopUpEmailField
      And I set the checkbox MyAccount.Newsletter.<box> status to true
      And I set the checkbox MyAccount.Newsletter.PopUpTermsAndConditionsCheckbox status to true
      And I click on MyAccount.Newsletter.PopUpSubscribeButton
      And I get translation from lokalise for "NewsletterSignUpTitle" and store it with key #Title
      And I get translation from lokalise for "NewsletterSignUpSuccessMessage" and store it with key #SuccessMessage
    Then I see MyAccount.Newsletter.PopUpSignedUpTitle contains text "#Title"
      And I see MyAccount.Newsletter.PopUpSignedUpInfo contains text "#SuccessMessage"
    When I click on MyAccount.Newsletter.PopUpCloseButton
    Then I see MyAccount.Newsletter.PopUp is not displayed

    @tms:UTR-13332
    Examples:
      | locale | langCode | page          | box              |
      | dk     | default  | store-locator | PopUpMenCheckbox |

    @tms:UTR-14592
    Examples:
      | locale           | langCode         | page         | box                |
      | multiLangDefault | multiLangDefault | shopping-bag | PopUpWomenCheckbox |

    @tms:UTR-14593
    Examples:
      | locale | langCode | page | box               |
      | se     | default  | wlp  | PopUpKidsCheckbox |

    @tms:UTR-14594
    Examples:
      | locale           | langCode         | page | box              |
      | multiLangDefault | multiLangDefault | pdp  | PopUpMenCheckbox |

  #@FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedNewsletter @PPL @P3 @ExcludeTH
  @tms:UTR-13333
  Scenario Outline: I can't see newsletter pop up on home page
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I delete all cookies and refresh
      And I click on Experience.CookieNotice.IAgreeButton
    When I navigate to page home-page
    Then I see MyAccount.Newsletter.PopUp is not displayed in 10 seconds

    Examples:
      | locale  | langCode |
      | default | default  |

  #@FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedNewsletter @PPL @P2 @ExcludeTH
  @tms:UTR-13394
  Scenario Outline: User cannot sign up to newsletter without accepting terms and conditions
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And There is 1 accounts
      And I delete all cookies and refresh
      And I click on Experience.CookieNotice.IAgreeButton
      And I navigate to page wishlist
    When I type "user1#email" in the field MyAccount.Newsletter.PopUpEmailField
      And I set the checkbox MyAccount.Newsletter.PopUpMenCheckbox status to true
      And I set the checkbox MyAccount.Newsletter.PopUpTermsAndConditionsCheckbox status to false
      And I click on MyAccount.Newsletter.PopUpSubscribeButton
      And I get translation from lokalise for "NewsletterSignUpTitle" and store it with key #Title
    Then I see MyAccount.Newsletter.PopUpSignedUpTitle does not contain text "#Title"

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  #@FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedNewsletter @PPL @P2 @ExcludeTH
  Scenario Outline: User cannot sign up to newsletter with incorrect email and sees error message
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And There is 1 accounts
      And I delete all cookies and refresh
      And I click on Experience.CookieNotice.IAgreeButton
      And I navigate to page shopping-bag
    When I type "<email>" in the field MyAccount.Newsletter.PopUpEmailField
      And I click on MyAccount.Newsletter.PopUpSubscribeButton
      And I get translation from lokalise for "<error>" and store it with key #Error
      And I get translation from lokalise for "NewsletterSignUpTitle" and store it with key #Title
    Then I see MyAccount.Newsletter.PopUpSignedUpTitle does not contain text "#Title"
      And I see MyAccount.Newsletter.EmailError contains text "#Error"

    @tms:UTR-13395
    Examples:
      | locale | langCode | email     | error      |
      | uk     | default  | asdsfs@dn | EmailError |

    @tms:UTR-14595
    Examples:
      | locale           | langCode         | email | error             |
      | multiLangDefault | multiLangDefault |       | EmailMissingError |

  #@FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedNewsletter @PPL @P2 @ExcludeTH
  @issue:PPL-1467
  Scenario Outline: User is taken to customer support page when he clicks on terms and conditions link on newsletter pop up
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And There is 1 accounts
      And I delete all cookies and refresh
      And I click on Experience.CookieNotice.IAgreeButton
      And I navigate to page shopping-bag
      And I type "testing@tester.com" in the field MyAccount.Newsletter.PopUpEmailField
    When I click on MyAccount.Newsletter.PopUpExpandTermsAndConditions
      And I click on MyAccount.Newsletter.<link>
    Then I see the current page is customer service

    @tms:UTR-14054 @ExcludeCK
    Examples:
      | locale  | langCode | link                        |
      | default | default  | PopUpTermsAndConditionsLink |

    @tms:UTR-14596
    Examples:
      | locale           | langCode         | link             |
      | multiLangDefault | multiLangDefault | PopUpPrivacyLink |

  #@FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedNewsletter @PPL @P2 @ExcludeTH
  @tms:UTR-14463
  Scenario Outline: User can see newsletter pop-up on second visited page
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And There is 1 accounts
      And I delete all cookies and refresh
      And I click on Experience.CookieNotice.IAgreeButton
      And I open sign in panel
    When I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type "user1#email" in the field MyAccount.RegisterPopUp.EmailField
      And I type "user1#password" in the field MyAccount.RegisterPopUp.PasswordField
      And I type "user1#password" in the field MyAccount.RegisterPopUp.RepeatPasswordField
      And I click on MyAccount.RegisterPopUp.TermsAndConditionsCheckbox
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
    Then I see the current page is MyAccount page
      And I see MyAccount.Newsletter.PopUp is displayed in 10 seconds

    Examples:
      | locale  | langCode |
      | default | default  |

  #@FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedNewsletter @PPL @P2 @ExcludeTH
  @tms:UTR-14464
  Scenario Outline: User can see newsletter pop-up on pdp
    Given There is 1 account
      And I am on shopping-bag page with sign in flyout open on locale <locale> of langCode <langCode> with forced accepted cookies
    When I click on MyAccount.RegisterPopUp.RegisterFormButton
      And I type "user1#email" in the field MyAccount.RegisterPopUp.EmailField
      And I type "user1#password" in the field MyAccount.RegisterPopUp.PasswordField
      And I type "user1#password" in the field MyAccount.RegisterPopUp.RepeatPasswordField
      And I click on MyAccount.RegisterPopUp.TermsAndConditionsCheckbox
      And I scroll to and click on MyAccount.RegisterPopUp.RegisterButton
    Then I see the current page is MyAccount page
    When I navigate to page shopping-bag
      And I delete all cookies and refresh
      And I click on Experience.CookieNotice.IAgreeButton
      And I sign in with email user1#email and password user1#password
      And I navigate to page pdp
    Then I see MyAccount.Newsletter.PopUp is displayed in 10 seconds

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |