Feature: Unified Newsletter - Banner

  #@FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedNewsletter @PPL @P2 @ExcludeTH
  Scenario Outline: User can see newsletter banner on multiple pages and sign up to newsletter
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And There are 1 accounts
      And I navigate to page <page>
      And I get translation from lokalise for "NewsletterTitle" and store it with key #Title
      And I get translation from lokalise for "NewsletterInfo" and store it with key #Info
      And I get translation from lokalise for "NewsletterBenefit15Off" and store it with key #BirthdayBenefit
      And I get translation from lokalise for "NewsletterBenefitEarlyAccess" and store it with key #EarlyAccess
      And I get translation from lokalise for "NewsletterBenefitExclusiveDiscount" and store it with key #Discount
    Then I see MyAccount.Newsletter.BannerTitle contains text "#Title"
      And I see MyAccount.Newsletter.BannerInfo contains text "#Info"
      And I see MyAccount.Newsletter.BannerBenefitsList with index 1 contains text "#BirthdayBenefit"
      And I see MyAccount.Newsletter.BannerBenefitsList with index 2 contains text "#EarlyAccess"
      And I see MyAccount.Newsletter.BannerBenefitsList with index 3 contains text "#Discount"
      And I see MyAccount.Newsletter.BannerMenCheckbox is not displayed
      And I see MyAccount.Newsletter.BannerWomenCheckbox is not displayed
      And I see MyAccount.Newsletter.BannerKidsCheckbox is not displayed
      And I see MyAccount.Newsletter.BannerImage is displayed
    When I type "user1#email" in the field MyAccount.Newsletter.BannerEmailField
      And I set the checkbox MyAccount.Newsletter.<box> status to true
      And I set the checkbox MyAccount.Newsletter.BannerTermsAndConditionsCheckbox status to true
      And I click on MyAccount.Newsletter.BannerSubscribeButton
      And I get translation from lokalise for "NewsletterSignUpTitle" and store it with key #SignupTitle
      And I get translation from lokalise for "NewsletterSignUpSuccessMessage" and store it with key #SuccessMessage
    Then I see MyAccount.Newsletter.BannerSignUpTitle contains text "#SignupTitle"
      And I see MyAccount.Newsletter.BannerSignUpInfo contains text "#SuccessMessage"

    @tms:UTR-13375
    Examples:
      | locale | langCode | page         | box               |
      | fi     | default  | shopping-bag | BannerMenCheckbox |

    @tms:UTR-14587
    Examples:
      | locale           | langCode         | page          | box                 |
      | multiLangDefault | multiLangDefault | store-locator | BannerWomenCheckbox |

    @tms:UTR-14588
    Examples:
      | locale | langCode | page     | box                |
      | se     | default  | wishlist | BannerKidsCheckbox |

    @tms:UTR-14589
    Examples:
      | locale           | langCode         | page | box               |
      | multiLangDefault | multiLangDefault | pdp  | BannerMenCheckbox |

  #@FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedNewsletter @PPL @P2 @ExcludeCK 
  Scenario Outline: User can see newsletter banner on multiple pages and sign up to newsletter
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And There are 1 accounts
      And I navigate to page <page>
      And I get translation from lokalise for "NewsletterTitleTH" and store it with key #Title
      And I get translation from lokalise for "NewsletterInfoTH" and store it with key #Info
      And I get translation from lokalise for "NewsletterBenefit15Off" and store it with key #BirthdayBenefit
      And I get translation from lokalise for "NewsletterBenefitEarlyAccess" and store it with key #EarlyAccess
      And I get translation from lokalise for "NewsletterBenefitExclusiveDiscount" and store it with key #Discount
    Then I see MyAccount.Newsletter.BannerTitle contains text "#Title"
      And I see MyAccount.Newsletter.BannerInfo contains text "#Info"
      And I see MyAccount.Newsletter.BannerBenefitsList with index 1 contains text "#BirthdayBenefit"
      # And I see MyAccount.Newsletter.BannerBenefitsList with index 2 contains text "#EarlyAccess"
      And I see MyAccount.Newsletter.BannerBenefitsList with index 3 contains text "#Discount"
      And I see MyAccount.Newsletter.BannerMenCheckbox is not displayed
      And I see MyAccount.Newsletter.BannerWomenCheckbox is not displayed
      And I see MyAccount.Newsletter.BannerKidsCheckbox is not displayed
      And I see MyAccount.Newsletter.BannerImage is displayed
    When I type "user1#email" in the field MyAccount.Newsletter.BannerEmailField
      And I set the checkbox MyAccount.Newsletter.<box> status to true
      And I set the checkbox MyAccount.Newsletter.BannerTermsAndConditionsCheckbox status to true
      And I click on MyAccount.Newsletter.BannerSubscribeButton
      And I get translation from lokalise for "NewsletterSignUpTitle" and store it with key #SignupTitle
      And I get translation from lokalise for "NewsletterSignUpSuccessMessage" and store it with key #SuccessMessage
    Then I see MyAccount.Newsletter.BannerSignUpTitle contains text "#SignupTitle"
      And I see MyAccount.Newsletter.BannerSignUpInfo contains text "#SuccessMessage"

    @tms:UTR-13375
    Examples:
      | locale  | langCode | page         | box               |
      | default | default  | shopping-bag | BannerMenCheckbox |

    @tms:UTR-14587
    Examples:
      | locale           | langCode         | page          | box                 |
      | multiLangDefault | multiLangDefault | store-locator | BannerWomenCheckbox |

    @tms:UTR-14588
    Examples:
      | locale  | langCode | page     | box                |
      | default | default  | wishlist | BannerKidsCheckbox |

    @tms:UTR-14589
    Examples:
      | locale           | langCode         | page | box               |
      | multiLangDefault | multiLangDefault | pdp  | BannerMenCheckbox |

  #@FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedNewsletter @PPL @P2 @ExcludeTH
  @tms:UTR-13376
  Scenario Outline: User can sign up to newsletter on multiple pages without refreshing or emptying cookies
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And There are 2 accounts
      And I navigate to page store-locator
    When I type "user1#email" in the field MyAccount.Newsletter.BannerEmailField
      And I set the checkbox MyAccount.Newsletter.BannerMenCheckbox status to true
      And I set the checkbox MyAccount.Newsletter.BannerTermsAndConditionsCheckbox status to true
      And I click on MyAccount.Newsletter.BannerSubscribeButton
      And I get translation from lokalise for "NewsletterSignUpTitle" and store it with key #SignupTitle
      And I get translation from lokalise for "NewsletterSignUpSuccessMessage" and store it with key #SuccessMessage
    Then I see MyAccount.Newsletter.BannerSignUpTitle contains text "#SignupTitle"
      And I see MyAccount.Newsletter.BannerSignUpInfo contains text "#SuccessMessage"
    When I navigate to page wishlist
      And I type "user2#email" in the field MyAccount.Newsletter.BannerEmailField
      And I set the checkbox MyAccount.Newsletter.BannerWomenCheckbox status to true
      And I set the checkbox MyAccount.Newsletter.BannerTermsAndConditionsCheckbox status to true
      And I click on MyAccount.Newsletter.BannerSubscribeButton
      And I get translation from lokalise for "NewsletterSignUpTitle" and store it with key #SignupTitle
      And I get translation from lokalise for "NewsletterSignUpSuccessMessage" and store it with key #SuccessMessage
    Then I see MyAccount.Newsletter.BannerSignUpTitle contains text "#SignupTitle"
      And I see MyAccount.Newsletter.BannerSignUpInfo contains text "#SuccessMessage"
    When I navigate to page shopping-bag
      And I type "user1#email" in the field MyAccount.Newsletter.BannerEmailField
      And I set the checkbox MyAccount.Newsletter.BannerKidsCheckbox status to true
      And I set the checkbox MyAccount.Newsletter.BannerTermsAndConditionsCheckbox status to true
      And I click on MyAccount.Newsletter.BannerSubscribeButton
      And I get translation from lokalise for "NewsletterSignUpTitle" and store it with key #SignupTitle
      And I get translation from lokalise for "NewsletterSignUpSuccessMessage" and store it with key #SuccessMessage
    Then I see MyAccount.Newsletter.BannerSignUpTitle contains text "#SignupTitle"
      And I see MyAccount.Newsletter.BannerSignUpInfo contains text "#SuccessMessage"

    Examples:
      | locale  | langCode |
      | default | default  |

  #@FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedNewsletter @PPL @P2 @ExcludeTH
  @tms:UTR-13389
  Scenario Outline: User cannot sign up to newsletter without accepting terms and conditions
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And There are 1 accounts
      And I navigate to page store-locator
    When I type "user1#email" in the field MyAccount.Newsletter.BannerEmailField
      And I set the checkbox MyAccount.Newsletter.BannerMenCheckbox status to true
      And I set the checkbox MyAccount.Newsletter.BannerTermsAndConditionsCheckbox status to false
      And I click on MyAccount.Newsletter.BannerSubscribeButton
    Then I see MyAccount.Newsletter.BannerSignUpTitle is not displayed

    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  #@FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedNewsletter @PPL @P2 @ExcludeTH
  Scenario Outline: User cannot sign up to newsletter with incorrect email and sees error message
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And There are 1 accounts
      And I navigate to page pdp
    When I type "<email>" in the field MyAccount.Newsletter.BannerEmailField
      And I click on MyAccount.Newsletter.BannerSubscribeButton
      And I get translation from lokalise for "<error>" and store it with key #Error
    Then I see MyAccount.Newsletter.BannerSignUpTitle is not displayed
      And I see MyAccount.Newsletter.EmailError contains text "#Error"

    @tms:UTR-13390
    Examples:
      | locale  | langCode | email     | error      |
      | default | default  | asdsfs@dn | EmailError |

    @tms:UTR-14590
    Examples:
      | locale           | langCode         | email | error             |
      | multiLangDefault | multiLangDefault |       | EmailMissingError |