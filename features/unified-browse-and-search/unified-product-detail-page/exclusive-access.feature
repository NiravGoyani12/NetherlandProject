Feature: Unified PDP - Exclusive access Product

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @ExclusiveAccess @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13352
  Scenario Outline: Verify as a guest user the CRM exclusive access product can be accesses only when subscribed to newsletter
    Given There is 1 exclusive access product of type CRM of locale <locale> with inventory between 50 and 999999
      And There is 1 account
      And I am on locale <locale> pdp page of langCode default for product style product1#styleColourPartNumber with accepted cookies
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
      And I am a guest user
      And I wait until the current page is loaded
      And I get translation from lokalise for "SignUpToBuyText" and store it with key #SignUpToBuy
      And I get translation from lokalise for "MembersOnlyText" and store it with key #MembersOnly
    Then I see ProductDetailPage.Pdp.SignUpToBuyButton with text #SignUpToBuy is displayed
      And I see ProductDetailPage.Pdp.ProductMembersOnlyHeader with text #MembersOnly is displayed
    When I click on ProductDetailPage.Pdp.SignUpToBuyButton
      And I type "user1#email" in the field ProductDetailPage.Pdp.NewsletterPopUpEmailInputField
      And I set the checkbox ProductDetailPage.Pdp.TermsAndConditionsCheckbox status to true
      And I click on ProductDetailPage.Pdp.NewsletterPopUpSubmitButton
      And I click on ProductDetailPage.Pdp.NewsletterPopUpCloseButton
    Then I see ProductDetailPage.Pdp.AddToBagButton is displayed
    When in unified PDP I select size by sku part number #skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I see ProductDetailPage.Pdp.WishListIcon is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @ExclusiveAccess @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13352
  Scenario Outline: Verify as a guest user the CRM exclusive access product can be accesses only when subscribed to newsletter
    Given There is 1 exclusive access product of type CRM of locale <locale> with inventory between 50 and 999999
      And There is 1 account
      And I am on locale <locale> pdp page of langCode default for product style product1#styleColourPartNumber with accepted cookies
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
      And I am a guest user
      And I wait until the current page is loaded
      And I get translation from lokalise for "SignUpToBuyText" and store it with key #SignUpToBuy
      And I get translation from lokalise for "MembersOnlyText" and store it with key #MembersOnly
    Then I see ProductDetailPage.Pdp.SignUpToBuyButton with text #SignUpToBuy is displayed
      And I see ProductDetailPage.Pdp.ProductMembersOnlyHeader with text #MembersOnly is displayed
      And I see ProductDetailPage.Pdp.ProductImagePadlock is displayed
    When I click on ProductDetailPage.Pdp.ProductImagePadlock
      And I type "user1#email" in the field ProductDetailPage.Pdp.NewsletterPopUpEmailInputField
      And I set the checkbox ProductDetailPage.Pdp.TermsAndConditionsCheckbox status to true
      And I click on ProductDetailPage.Pdp.NewsletterPopUpSubmitButton
      And I click on ProductDetailPage.Pdp.NewsletterPopUpCloseButton
    Then I see ProductDetailPage.Pdp.AddToBagButton is displayed
    When in unified PDP I select size by sku part number #skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I see ProductDetailPage.Pdp.WishListIcon is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @ExclusiveAccess @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13353
  Scenario Outline: Verify as a registered user the CRM exclusive access product can be accesses only when subscribed to newsletter
    Given There is 1 exclusive access product of type CRM of locale <locale> with inventory between 50 and 999999
      And I am on locale <locale> pdp page of langCode default for product style product1#styleColourPartNumber with accepted cookies
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
      And I am a logged in user
      And I wait until the current page is loaded
      And I get translation from lokalise for "SignUpToBuyText" and store it with key #SignUpToBuy
      And I get translation from lokalise for "MembersOnlyText" and store it with key #MembersOnly
    Then I see ProductDetailPage.Pdp.SignUpToBuyButton with text #SignUpToBuy is displayed
      And I see ProductDetailPage.Pdp.ProductMembersOnlyHeader with text #MembersOnly is displayed
    When I click on ProductDetailPage.Pdp.SignUpToBuyButton
      And I type "user1#email" in the field ProductDetailPage.Pdp.NewsletterPopUpEmailInputField
      And I set the checkbox ProductDetailPage.Pdp.TermsAndConditionsCheckbox status to true
      And I click on ProductDetailPage.Pdp.NewsletterPopUpSubmitButton
      And I click on ProductDetailPage.Pdp.NewsletterPopUpCloseButton
    Then I see ProductDetailPage.Pdp.AddToBagButton is displayed
    When in unified PDP I select size by sku part number #skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I see ProductDetailPage.Pdp.WishListIcon is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @ExclusiveAccess @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13354
  Scenario Outline: Verify as a guest user the ML exclusive access product shows signin button to buy
    Given There is 1 exclusive access product of type ML of locale <locale> with inventory between 50 and 999999
      And I am on locale <locale> pdp page of langCode default for product style product1#styleColourPartNumber with accepted cookies
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
      And I am a guest user
      And I wait until the current page is loaded
      And I get translation from lokalise for "SignInToBuyText" and store it with key #SignUpToBuy
      And I get translation from lokalise for "MembersOnlyText" and store it with key #MembersOnly
    Then I see ProductDetailPage.Pdp.SignInToBuyButton with text #SignUpToBuy is displayed
      And I see ProductDetailPage.Pdp.ProductMembersOnlyHeader with text #MembersOnly is displayed
    When I click on ProductDetailPage.Pdp.SignInToBuyButton
    Then I see ProductDetailPage.Pdp.SignInModal is displayed
    When I type "nkkjkrere@replyloop.com" in the field ProductDetailPage.Pdp.EmailField
      And I type "Test@123456" in the field ProductDetailPage.Pdp.PasswordField
      And I click on ProductDetailPage.Pdp.SubmitButton
    Then I see ProductDetailPage.Pdp.AddToBagButton is displayed
    When in unified PDP I select size by sku part number #skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter is displayed
      And I see ProductDetailPage.Pdp.WishListIcon is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @ExclusiveAccess @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13354
  Scenario Outline: Mobile - Verify as a guest user the ML exclusive access product shows signin button to buy
    Given There is 1 exclusive access product of type ML of locale <locale> with inventory between 50 and 999999
      And I am on locale <locale> pdp page of langCode default for product style product1#styleColourPartNumber with accepted cookies
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
      And I am a guest user
      And I wait until the current page is loaded
      And I get translation from lokalise for "SignInToBuyText" and store it with key #SignUpToBuy
      And I get translation from lokalise for "MembersOnlyText" and store it with key #MembersOnly
    Then I see ProductDetailPage.Pdp.SignInToBuyButton with text #SignUpToBuy is displayed
      And I see ProductDetailPage.Pdp.ProductMembersOnlyHeader with text #MembersOnly is displayed
      And I see ProductDetailPage.Pdp.ProductImagePadlock is displayed
    When I click on ProductDetailPage.Pdp.ProductImagePadlock
    Then I see ProductDetailPage.Pdp.SignInModal is displayed
    When I type "nkkjkrere@replyloop.com" in the field ProductDetailPage.Pdp.EmailField
      And I type "Test@123456" in the field ProductDetailPage.Pdp.PasswordField
      And I click on ProductDetailPage.Pdp.SubmitButton
    Then I see ProductDetailPage.Pdp.AddToBagButton is displayed
    When in unified PDP I select size by sku part number #skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I see ProductDetailPage.Header.ShoppingBagCounter is displayed
      And I see ProductDetailPage.Pdp.WishListIcon is displayed

    Examples:
      | locale  |
      | default |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @ExclusiveAccess @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13355
  Scenario Outline: Verify as a registered user the ML exclusive access product can be added to bag
    Given There is 1 exclusive access product of type ML of locale <locale> with inventory between 50 and 999999
      And I am on locale <locale> pdp page of langCode default for product style product1#styleColourPartNumber with accepted cookies
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
      And I am a logged in user
      And I wait until the current page is loaded
      And I get translation from lokalise for "MembersOnlyText" and store it with key #MembersOnly
    Then I see ProductDetailPage.Pdp.ProductMembersOnlyHeader with text #MembersOnly is displayed
      And I see ProductDetailPage.Pdp.AddToBagButton is displayed
    When in unified PDP I select size by sku part number #skuPartNumber
      And I click on ProductDetailPage.Pdp.AddToBagButton
    Then I wait until ProductDetailPage.Header.ShoppingBagCounter is displayed
      And I see ProductDetailPage.Pdp.WishListIcon is displayed

    Examples:
      | locale  |
      | default |