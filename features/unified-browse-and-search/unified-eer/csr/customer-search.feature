Feature: CSR - Customer Search

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Csr @UnifiedExperience @EER @P3 @ExcludeSIT
  @tms:UTR-12406
  Scenario Outline: Search customer by phone and email with valid query
    Given I am in csr customer search of locale default and langCode default with L1 csr account with forced accepted cookies
      And I get csr search data for "new_email" and store it with key #Email
      And I type "<email>" in the field Csr.CustomerSearchPage.EmailInput
#      And I type "<phoneNumber>" in the field Csr.CustomerSearchPage.PhoneInput
      And I click on Csr.CustomerSearchPage.SearchButton
#    Then I see Csr.CustomerSearchPage.SearchResultTablePhoneColumn with text <phoneNumber> is displayed in 10 seconds
      And I see Csr.CustomerSearchPage.SearchResultTableEmailColumn with text <email> is displayed

    Examples:
      | phoneNumber | email  |
      | 0401234567  | #Email |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  Scenario Outline: Search customer with valid data
    Given I am in csr customer search of locale default and langCode default with L2 csr account with forced accepted cookies
    When I type "<text>" in the field Csr.CustomerSearchPage.<inputField>
      And I click on Csr.CustomerSearchPage.SearchButton
    Then I see Csr.CustomerSearchPage.SearchResultTable is displayed in 20 seconds
      And I see Csr.CustomerSearchPage.<searchResultColumn> with text <text> is displayed

    @tms:UTR-11757
    Examples:
      | inputField | text               | searchResultColumn           |
      | EmailInput | joy@getairmail.com | SearchResultTableEmailColumn |

    @tms:UTR-11756
    Examples:
      | inputField     | text | searchResultColumn          |
      | FirstNameInput | Joy  | SearchResultTableNameColumn |

    @tms:UTR-11758
    Examples:
      | inputField    | text | searchResultColumn          |
      | LastNameInput | Toy  | SearchResultTableNameColumn |

    @tms:UTR-11755
    Examples:
      | inputField   | text   | searchResultColumn             |
      | AddressInput | Cambridge | SearchResultTableAddressColumn |

    @tms:UTR-11759
    Examples:
      | inputField | text   | searchResultColumn             |
      | CityInput  | London | SearchResultTableAddressColumn |

    @tms:UTR-11754
    Examples:
      | inputField    | text     | searchResultColumn             |
      | PostcodeInput | DD10 6TY | SearchResultTableAddressColumn |

#    As phone number can not be updated so removing this scenario
#    @tms:UTR-11753
#    Examples:
#      | inputField | text       | searchResultColumn           |
#      | PhoneInput | 7987955900 | SearchResultTablePhoneColumn |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  @tms:UTR-11751
  Scenario: Search customer with no input data displays an error message
    Given I am in csr customer search of locale default and langCode default with L3 csr account with forced accepted cookies
      And I click on Csr.CustomerSearchPage.SearchButton
    Then I see Csr.CustomerSearchPage.NodataErrorMessage is displayed

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-12407
  Scenario: Csr user can use pagination when search customer with valid parameters
    Given I am in csr customer search of locale default and langCode default with L3 csr account with forced accepted cookies
      And I type "a" in the field Csr.CustomerSearchPage.FirstNameInput
      And I type "a" in the field Csr.CustomerSearchPage.LastNameInput
      And I click on Csr.CustomerSearchPage.SearchButton
    Then I see Csr.CustomerSearchPage.SearchResultTable is displayed in 10 seconds
      And the count of displayed elements Csr.CustomerSearchPage.SearchResultTableEmailColumn is equal to 10
      And I store the value of Csr.CustomerSearchPage.SearchResultTableEmailColumn with key #emailid1
      And I see the count of displayed elements Csr.CustomerSearchPage.PageNumber is equal to 5
      And I see Csr.CustomerSearchPage.PageNumber with text > is displayed
      And I see Csr.CustomerSearchPage.PageNumber with text < is not displayed
    When I click on Csr.CustomerSearchPage.PageNumber with text 4
    Then I see Csr.CustomerSearchPage.PageNumberInput with text 4 is displayed in 10 seconds
      And the count of displayed elements Csr.CustomerSearchPage.SearchResultTableEmailColumn is equal to 10
      And I see the value of Csr.CustomerSearchPage.SearchResultTableEmailColumn should not be equal to the stored value with key #emailid1
      And I store the value of Csr.CustomerSearchPage.SearchResultTableEmailColumn with key #emailid4
      And I see Csr.CustomerSearchPage.PageNumber with text < is displayed
    When I click on Csr.CustomerSearchPage.PageNumber with text >
    Then I see Csr.CustomerSearchPage.PageNumberInput with text 5 is displayed in 10 seconds
      And the count of displayed elements Csr.CustomerSearchPage.SearchResultTableEmailColumn is equal to 10
      And I store the value of Csr.CustomerSearchPage.SearchResultTableEmailColumn with key #emailid5
      And I see the value of Csr.CustomerSearchPage.SearchResultTableEmailColumn should not be equal to the stored value with key #emailid1
      And I see the value of Csr.CustomerSearchPage.SearchResultTableEmailColumn should not be equal to the stored value with key #emailid4
      And I see Csr.CustomerSearchPage.PageNumber with text > is displayed
    When I click on Csr.CustomerSearchPage.PageNumber with text <
    Then I see Csr.CustomerSearchPage.PageNumberInput with text 4 is displayed in 10 seconds
      And the count of displayed elements Csr.CustomerSearchPage.SearchResultTableEmailColumn is equal to 10
      And I see the value of Csr.CustomerSearchPage.SearchResultTableEmailColumn should be equal to the stored value with key #emailid4
      And I see the value of Csr.CustomerSearchPage.SearchResultTableEmailColumn should not be equal to the stored value with key #emailid5
      And I see the value of Csr.CustomerSearchPage.SearchResultTableEmailColumn should not be equal to the stored value with key #emailid1
      And I see Csr.CustomerSearchPage.PageNumber with text > is displayed
      And I see Csr.CustomerSearchPage.PageNumber with text < is displayed
      And I see Csr.CustomerSearchPage.PageNumber with text 1 is not displayed
      And I see Csr.CustomerSearchPage.PageNumber with text 2 is not displayed
      And I see Csr.CustomerSearchPage.PageNumber with text 3 is not displayed
    When I click on Csr.CustomerSearchPage.PageNumberInput
      And I press key Backspace on the keyboard
      And I type "1" in the empty field Csr.CustomerSearchPage.PageNumberInput
      And I click on Csr.CustomerSearchPage.GoButton
    Then the count of displayed elements Csr.CustomerSearchPage.SearchResultTableEmailColumn is equal to 10
      And I see the value of Csr.CustomerSearchPage.SearchResultTableEmailColumn should be equal to the stored value with key #emailid1
      And I see the value of Csr.CustomerSearchPage.SearchResultTableEmailColumn should not be equal to the stored value with key #emailid4
      And I see the value of Csr.CustomerSearchPage.SearchResultTableEmailColumn should not be equal to the stored value with key #emailid5
      And I see Csr.CustomerSearchPage.PageNumber with text < is not displayed
      And I see Csr.CustomerSearchPage.PageNumber with text > is displayed

  @FullRegression
  @Desktop
  @Chrome @P2
  @Csr @UnifiedExperience @EER
  Scenario Outline: Search customers with invalid data
    Given I am in csr customer search of locale default and langCode default with L2 csr account with forced accepted cookies
    When I type "<text>" in the empty field Csr.CustomerSearchPage.<inputField>
      And I click on Csr.CustomerSearchPage.SearchButton
    Then I see Csr.CustomerSearchPage.SearchResultTable is not displayed
      And I see Csr.CustomerSearchPage.SearchResultText contains text "Found 0 matching account" in 15 seconds

    @tms:UTR-12408
    Examples:
      | inputField | text        |
      | EmailInput | ABC@123.com |

    @tms:UTR-11760
    Examples:
      | inputField     | text              |
      | FirstNameInput | 123               |
      | FirstNameInput | $@@               |
      | FirstNameInput | abcdefghijklmnopq |

    @tms:UTR-11762
    Examples:
      | inputField    | text              |
      | LastNameInput | 123               |
      | LastNameInput | $@@               |
      | LastNameInput | abcdefghijklmnopq |

    @tms:UTR-11761
    Examples:
      | inputField   | text       |
      | AddressInput | afsafafasf |
      | AddressInput | $          |
      | AddressInput | 1234@##    |

    @tms:UTR-11763
    Examples:
      | inputField | text        |
      | CityInput  | 123         |
      | CityInput  | $@@         |
      | CityInput  | abcdefg1234 |

    @tms:UTR-11764
    Examples:
      | inputField    | text        |
      | PostcodeInput | $@#         |
      | PostcodeInput | 21234575645 |
      | PostcodeInput | abcdvljdvja |

    @tms:UTR-11752
    Examples:
      | inputField | text        |
      | PhoneInput | $@#         |
      | PhoneInput | 2123adsa$   |
      | PhoneInput | abcdvljdvja |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-12409
  Scenario Outline: Search customer by email with invalid input data displays an error message
    Given I am in csr customer search of locale default and langCode default with L1 csr account with forced accepted cookies
    When I type "<emailInput>" in the field Csr.CustomerSearchPage.EmailInput
      And I click on Csr.CustomerSearchPage.SearchButton
    Then I see Csr.CustomerSearchPage.SearchResultTable is not displayed
      And I see Csr.CustomerSearchPage.EmailInputError contains text "Please enter a valid email"

    Examples:
      | emailInput |
      | abc        |
      | 123        |
      | abc@.com   |
      | @a.com     |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-13294
  Scenario Outline: User should be able to navigate back and forth from CSR home to My account page
    Given I am in csr customer search of locale default and langCode default with L4 csr account with forced accepted cookies
      And I get csr search data for "new_email" and store it with key #Email
    When I type "<email>" in the field Csr.CustomerSearchPage.EmailInput
      And  I click on Csr.CustomerSearchPage.SearchButton
    Then I see Csr.CustomerSearchPage.SearchResultTableEmailColumn with text <email> is displayed
    When I click on Csr.CustomerSearchPage.SearchResultTableEmailColumn with text <email>
    And I wait until the current page is loaded
    And I click on BasePage.AcceptAllCookies
    Then URL should contain "/myaccount" in 2 seconds
      And I see Csr.CustomerSearchPage.ReturnToCsr with text "Return to CSR Home" is displayed in 2 seconds
      And I store translated value of "OnBehalfOf" with key #OnBehalfOf
      And I see Csr.CustomerSearchPage.OnBehalfText contains text "#OnBehalfOf"
    When I click on Csr.CustomerSearchPage.ReturnToCsr
    Then URL should contain "/csr/customers" in 2 seconds

    Examples:
      | email  |
      | #Email |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-13319
  Scenario Outline: User should be able to access email preferences and order info when logged in to CSR accounts
    Given I am in csr customer search of locale default and langCode default with L2 csr account with forced accepted cookies
      And I get csr search data for "new_email" and store it with key #Email
    When I type "<email>" in the field Csr.CustomerSearchPage.EmailInput
      And  I click on Csr.CustomerSearchPage.SearchButton
    Then I see Csr.CustomerSearchPage.SearchResultTableEmailColumn with text <email> is displayed
    When I click on Csr.CustomerSearchPage.SearchResultTableEmailColumn with text <email>
      And I wait until the current page is loaded
      And I click on BasePage.AcceptAllCookies
    Then URL should contain "/myaccount" in 2 seconds
    When I click on Csr.CustomerSearchPage.MyAccountPreferences
    Then I see Csr.CustomerSearchPage.MyAccountNewsletterComponent is displayed in 2 seconds
    When I click on Csr.CustomerSearchPage.MyAccountOrders
    Then I see Csr.CustomerSearchPage.MyAccountOrderPage is displayed in 2 seconds

    Examples:
      | email  |
      | #Email |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  @feature:EER-8822
  @feature:EER-7308
  @tms:UTR-13357
  Scenario Outline: CSR user should be able to checkout on behalf of the customer through unified checkout
    Given I am in csr customer search of locale default and langCode default with L1 csr account with forced accepted cookies
      And I get csr search data for "new_email" and store it with key #Email
    When I type "<email>" in the field Csr.CustomerSearchPage.EmailInput
      And  I click on Csr.CustomerSearchPage.SearchButton
    Then I see Csr.CustomerSearchPage.SearchResultTableEmailColumn with text <email> is displayed
    When I click on Csr.CustomerSearchPage.SearchResultTableEmailColumn with text <email>
    Then URL should contain "/myaccount" in 2 seconds
      And I store translated value of "Return to CSR Home" with key #ReturnCSRText
      And I see Csr.CustomerSearchPage.ReturnToCsr with text #ReturnCSRText is displayed in 2 seconds
      And I store translated value of "OnBehalfOf" with key #OnBehalfText
      And I see Csr.CustomerSearchPage.OnBehalfText contains text "#OnBehalfText"
    Given There are 5 normal size product items of locale default with inventory between 1 and 1
      And I am on locale default pdp page for product style product1#styleColourPartNumber
      And I wait for 2 seconds
      And I click on BasePage.AcceptAllCookies
    When in unified PDP I select size by sku part number product1#skuPartNumber
      And I wait for 5 seconds
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait for 5 seconds
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
    Then I see ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I scroll to the element ProductDetailPage.Pdp.CheckoutButton
      And I click on ProductDetailPage.Pdp.CheckoutButton
    Then URL should contain "<targetUrl>" in 10 seconds
      And I wait for 8 seconds
      And I am on locale default pdp page for product style product1#styleColourPartNumber
      And I click on ProductDetailPage.Header.ShoppingBagButton
      And I wait for 5 seconds
      And I click on ProductDetailPage.Pdp.NewsletterPopUpCloseButton in 5 seconds if displayed
      And I scroll to the element Experience.ShoppingBag.CheckoutWithPaypalButton
      And I wait until Experience.ShoppingBag.CheckoutWithPaypalButton is clickable
      And I click on Experience.ShoppingBag.CheckoutWithPaypalButton
      And I wait for 5 seconds
      And in paypal I complete payment
    Then I see Checkout.OrderConfirmationPage.ConfirmationDetails is displayed in 35 seconds
      And I click on Checkout.OrderConfirmationPage.ContinueShoppingButton
      And I wait for 5 seconds
      And I store translated value of "Return to CSR Home" with key #ReturnCSRText
      And I see Csr.CustomerSearchPage.ReturnToCsr with text #ReturnCSRText is displayed in 2 seconds
      And I store translated value of "OnBehalfOf" with key #OnBehalfText
      And I see Csr.CustomerSearchPage.OnBehalfText contains text "#OnBehalfText"

    Examples:
      | email  | targetUrl         |
      | #Email | checkout/shipping |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  @feature:EER-7442
  @tms:UTR-13398
  Scenario Outline: CSR user should be able to and and remove item in shopping bag on behalf of the customer through unified checkout
    Given I am in csr customer search of locale default and langCode default with L1 csr account with forced accepted cookies
      And I get csr search data for "new_email" and store it with key #Email
    When I type "<email>" in the field Csr.CustomerSearchPage.EmailInput
      And  I click on Csr.CustomerSearchPage.SearchButton
    Then I see Csr.CustomerSearchPage.SearchResultTableEmailColumn with text <email> is displayed
    When I click on Csr.CustomerSearchPage.SearchResultTableEmailColumn with text <email>
    Then URL should contain "/myaccount" in 2 seconds
      And I store translated value of "Return to CSR Home" with key #ReturnCSRText
      And I see Csr.CustomerSearchPage.ReturnToCsr with text #ReturnCSRText is displayed in 2 seconds
      And I store translated value of "OnBehalfOf" with key #OnBehalfText
      And I see Csr.CustomerSearchPage.OnBehalfText contains text "#OnBehalfText"
      And There are 5 normal size product items of locale default with inventory between 1 and 1
    When I am on locale default pdp page for product style product1#styleColourPartNumber
      And I click on BasePage.AcceptAllCookies
      And I click on ProductDetailPage.Pdp.NewsletterPopUpCloseButton in 5 seconds if displayed
      And I wait for 5 seconds
      And in unified PDP I select size by sku part number product1#skuPartNumber
      And I wait for 5 seconds
      And I click on ProductDetailPage.Pdp.AddToBagButton
      And I wait for 5 seconds
      And I wait until ProductDetailPage.Header.ShoppingBagCounter with text 1 is displayed
      And I click on ProductDetailPage.Header.ShoppingBagButton
      And I click on ProductDetailPage.Pdp.NewsletterPopUpCloseButton in 5 seconds if displayed
      And I click on Experience.ShoppingBag.RemoveButton
      And I click on Experience.ShoppingBag.RemoveConfirmButton
    Then I see Experience.ShoppingBag.EmptyShoppingBagTitle is displayed
      And the count of elements Experience.ShoppingBag.Item is equal to 0 in 2 seconds
      And I see Experience.ShoppingBag.EmptyShoppingBagButton is displayed

    Examples:
      | email  |
      | #Email |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  @feature:EER-7508
  @tms:UTR-13437
  Scenario Outline: CSR user via customer search should be landed to My account page and not displayed the account flyout menu
    Given I am in csr customer search of locale default and langCode default with L1 csr account with forced accepted cookies
      And I get csr search data for "new_email" and store it with key #Email
    When I type "<email>" in the field Csr.CustomerSearchPage.EmailInput
      And  I click on Csr.CustomerSearchPage.SearchButton
    Then I see Csr.CustomerSearchPage.SearchResultTableEmailColumn with text <email> is displayed
    When I click on Csr.CustomerSearchPage.SearchResultTableEmailColumn with text <email>
    Then URL should contain "/myaccount" in 2 seconds
      And I see Csr.CustomerSearchPage.MyAccountFlyout is not displayed
      And I see Csr.CustomerSearchPage.MyAccountPreferences is displayed

    Examples:
      | email  |
      | #Email |

  #FullRegression
  @Desktop @MultipleTabs
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P3 @GiftCard
  @tms:UTR-15733 @ExcludeCK
  Scenario Outline: CSR user via customer search should be landed to PLP page when click on Gift card image
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I type "<orderID>" in the empty field Csr.SearchPage.OrderIdInput
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I clear text field of element Csr.SearchPage.DatePickerFromInput
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "20/09/2023"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTableOrderIDColumn is displayed in 10 seconds
      And I click on Csr.SearchPage.OrderDetailsByTableIndex with index 1
      And I wait until the current page is loaded
      And I wait until Csr.SearchPage.GiftCardItemDetailImg is displayed
    When I click on Csr.SearchPage.GiftCardItemDetailImg
      And I switch to 2nd browser tab
    Then URL should contain "gift-card-egiftcard"

    Examples:
      | orderID      |
      | 900001388848 |
