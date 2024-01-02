Feature: Unified Newsletter - Banner

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedNewsletter @UnifiedExperience @EER @P2 @ExcludeTH
  Scenario Outline: User can see newsletter banner and sign up without unlocking benefits
    Given I am on locale <locale> home page with forced accepted cookies
      And There are 1 accounts
    When I navigate to page <page>
      And I get translation from lokalise for "NewsletterSingUpPopupTitle" and store it with key #Title
      And I get translation from lokalise for "NewsletterInfo" and store it with key #Info
      And I get translation from lokalise for "NewsletterBenefit15Off" and store it with key #BirthdayBenefit
      And I get translation from lokalise for "NewsletterBenefitEarlyAccess" and store it with key #EarlyAccess
      And I get translation from lokalise for "NewsletterBenefitExclusiveDiscount" and store it with key #Discount
      And I get translation from lokalise for "NewsletterSuccess" and store it with key #SuccessMessage
    Then I see MyAccount.Newsletter.BannerTitle contains text "#Title"
      And I see MyAccount.Newsletter.BannerBenefitsList with index 1 contains text "#BirthdayBenefit"
      And I see MyAccount.Newsletter.BannerBenefitsList with index 2 contains text "#EarlyAccess"
      And I see MyAccount.Newsletter.BannerBenefitsList with index 3 contains text "#Discount"
      And I see MyAccount.Newsletter.BannerMenCheckbox is not displayed
      And I see MyAccount.Newsletter.BannerWomenCheckbox is not displayed
      And I see MyAccount.Newsletter.BannerKidsCheckbox is not displayed
      And I see MyAccount.Newsletter.BannerSubscribeButton is displayed
    When I click on MyAccount.Newsletter.BannerSubscribeButton
    Then I see MyAccount.Newsletter.NewsletterSignUpPopup is displayed
    When I type "user1#email" in the field MyAccount.Newsletter.BannerEmailField
      And I set the checkbox MyAccount.Newsletter.<box> status to true
      And I set the checkbox MyAccount.Newsletter.BannerTermsAndConditionsCheckbox status to true
      And I click on MyAccount.Newsletter.PopupSubscribeButton
    Then I see MyAccount.Newsletter.PopupDOBBenefit is displayed
    When I click on MyAccount.Newsletter.<closeButton>
    Then I see MyAccount.Newsletter.PopupSignUpSuccessMessage contains text "#SuccessMessage"

    @tms:UTR-17448
    Examples:
      | locale | langCode         | page | box               | closeButton      |
      | uk     | multiLangDefault | pdp  | BannerMenCheckbox | PopUpCloseButton |

    @tms:UTR-17450
    Examples:
      | locale | langCode | page     | box                | closeButton           |
      | be     | default  | wishlist | BannerKidsCheckbox | OnlyTenPecentDiscount |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedNewsletter @UnifiedExperience @EER @P2 @ExcludeTH
  Scenario Outline: User can see newsletter banner on multiple pages and sign up to newsletter
    Given I am on locale <locale> home page with forced accepted cookies
      And There are 1 accounts
    When I navigate to page <page>
      And I get translation from lokalise for "NewsletterSingUpPopupTitle" and store it with key #Title
      And I get translation from lokalise for "NewsletterInfo" and store it with key #Info
      And I get translation from lokalise for "NewsletterBenefit15Off" and store it with key #BirthdayBenefit
      And I get translation from lokalise for "NewsletterBenefitEarlyAccess" and store it with key #EarlyAccess
      And I get translation from lokalise for "NewsletterBenefitExclusiveDiscount" and store it with key #Discount
      And I get translation from lokalise for "NewsletterSuccess" and store it with key #SuccessMessage
    Then I see MyAccount.Newsletter.BannerTitle contains text "#Title"
      And I see MyAccount.Newsletter.BannerBenefitsList with index 1 contains text "#BirthdayBenefit"
      And I see MyAccount.Newsletter.BannerBenefitsList with index 2 contains text "#EarlyAccess"
      And I see MyAccount.Newsletter.BannerBenefitsList with index 3 contains text "#Discount"
      And I see MyAccount.Newsletter.BannerMenCheckbox is not displayed
      And I see MyAccount.Newsletter.BannerWomenCheckbox is not displayed
      And I see MyAccount.Newsletter.BannerKidsCheckbox is not displayed
      And I see MyAccount.Newsletter.BannerSubscribeButton is displayed
    When I click on MyAccount.Newsletter.BannerSubscribeButton
    Then I see MyAccount.Newsletter.NewsletterSignUpPopup is displayed
    When I type "user1#email" in the field MyAccount.Newsletter.BannerEmailField
      And I set the checkbox MyAccount.Newsletter.<box> status to true
      And I set the checkbox MyAccount.Newsletter.BannerTermsAndConditionsCheckbox status to true
      And I click on MyAccount.Newsletter.PopupSubscribeButton
    Then I see MyAccount.Newsletter.PopupDOBBenefit is displayed
      And I type "01" in the field MyAccount.Newsletter.PopupBenefitDDInput
      And I type "01" in the field MyAccount.Newsletter.PopupBenefitMMInput
      And I type "1990" in the field MyAccount.Newsletter.PopupBenefitYYInput
      And I click on MyAccount.Newsletter.PopupSubscribeButton
      And I see MyAccount.Newsletter.PopupSignUpSuccessMessage contains text "#SuccessMessage"

    @tms:UTR-17457 @issue:EER-12780
    Examples:
      | locale | langCode | page         | box               |
      | pl     | default  | shopping-bag | BannerMenCheckbox |

    @tms:UTR-17458
    Examples:
      | locale | langCode         | page          | box                 |
      | uk     | multiLangDefault | store-locator | BannerWomenCheckbox |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedNewsletter @UnifiedExperience @EER @P2 @ExcludeTH
  @tms:UTR-13389
  Scenario Outline: User cannot sign up to newsletter without accepting terms and conditions
    Given I am on locale <locale> home page with forced accepted cookies
      And There are 1 accounts
      And I navigate to page store-locator
    When I click on MyAccount.Newsletter.BannerSubscribeButton
      And I type "user1#email" in the field MyAccount.Newsletter.BannerEmailField
      And I set the checkbox MyAccount.Newsletter.BannerMenCheckbox status to true
      And I set the checkbox MyAccount.Newsletter.BannerTermsAndConditionsCheckbox status to false
      And I click on MyAccount.Newsletter.PopupSubscribeButton
    Then I see MyAccount.Newsletter.PopupDOBBenefit is not displayed

    Examples:
      | locale | langCode |
      | be     | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedNewsletter @UnifiedExperience @EER @P2 @ExcludeTH
  Scenario Outline: User cannot sign up to newsletter with incorrect email and sees error message
    Given I am on locale <locale> home page with forced accepted cookies
      And There are 1 accounts
      And I navigate to page pdp
    When I click on MyAccount.Newsletter.BannerSubscribeButton
    Then I see MyAccount.Newsletter.NewsletterSignUpPopup is displayed
      And I type "<email>" in the field MyAccount.Newsletter.BannerEmailField
      And I get translation from lokalise for "<error>" and store it with key #Error
    When I click on MyAccount.Newsletter.PopupSubscribeButton
    Then I see MyAccount.Newsletter.EmailError contains text "#Error"

    @tms:UTR-17462
    Examples:
      | locale | langCode | email     | error      |
      | pl     | default  | asdsfs@dn | EmailError |

    @tms:UTR-17464
    Examples:
      | locale | langCode         | email | error             |
      | uk     | multiLangDefault |       | EmailMissingError |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedNewsletter @UnifiedExperience @EER @P2 @ExcludeTH
  Scenario Outline: User can see error when unlocking benefits without DOB
    Given I am on locale <locale> home page with forced accepted cookies
      And There are 1 accounts
    When I navigate to page <page>
      And I click on MyAccount.Newsletter.BannerSubscribeButton
    Then I see MyAccount.Newsletter.NewsletterSignUpPopup is displayed
    When I type "user1#email" in the field MyAccount.Newsletter.BannerEmailField
      And I set the checkbox MyAccount.Newsletter.<box> status to true
      And I set the checkbox MyAccount.Newsletter.BannerTermsAndConditionsCheckbox status to true
      And I click on MyAccount.Newsletter.PopupSubscribeButton
    Then I see MyAccount.Newsletter.PopupDOBBenefit is displayed
      And I type "<dd>" in the field MyAccount.Newsletter.PopupBenefitDDInput
      And I type "<mm>" in the field MyAccount.Newsletter.PopupBenefitMMInput
      And I type "<yyyy>" in the field MyAccount.Newsletter.PopupBenefitYYInput
    When I click on MyAccount.Newsletter.PopupSubscribeButton
    Then I see MyAccount.Newsletter.ErrorDOBInput is displayed

    @tms:UTR-17452
    Examples:
      | locale | langCode | page | box               | dd | mm | yyyy |
      | be     | default  | faqs | BannerMenCheckbox |    |    |      |

    @tms:UTR-17465
    Examples:
      | locale | langCode | page      | box               | dd | mm | yyyy |
      | pl     | default  | contactus | BannerMenCheckbox | 99 | 99 | 9999 |
