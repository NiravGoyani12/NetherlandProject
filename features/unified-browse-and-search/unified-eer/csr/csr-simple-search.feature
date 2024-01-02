Feature: CSR - Simple Search

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  Scenario Outline: Csr user can see results when searching with valid orderid/email
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I get csr search data for "orderid" and store it with key #OrderId
      And I type "<text>" in the empty field Csr.SearchPage.<inputField>
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is displayed in 20 seconds
      And I see Csr.SearchPage.<searchTableColumn> contains text "<text>"

    @tms:UTR-10705
    Examples:
      | inputField   | text     | searchTableColumn              |
      | OrderIdInput | #OrderId | SearchResultTableOrderIDColumn |

    @tms:UTR-10698
    Examples:
      | inputField | text               | searchTableColumn            |
      | EmailInput | joy@getairmail.com | SearchResultTableEmailColumn |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  @tms:UTR-12007
  Scenario Outline: Csr user can see results when searching with valid orderid and email
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I get csr search data for "orderid" and store it with key #OrderId
      And I type "#OrderId" in the empty field Csr.SearchPage.OrderIdInput
      And I type "<email>" in the empty field Csr.SearchPage.EmailInput
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is displayed in 20 seconds
      And I see Csr.SearchPage.SearchResultTableOrderIDColumn with text #OrderId is displayed
      And I see Csr.SearchPage.SearchResultTableEmailColumn with text <email> is displayed
      And I see Csr.SearchPage.SearchResultTableCountryColumn is displayed
      And I see Csr.SearchPage.SearchResultTablePaymentMethodColumn is displayed
      And I see Csr.SearchPage.SearchResultTableTotalValueColumn is displayed
      And I see Csr.SearchPage.SearchResultTableOrderDateColumn with text /20 is displayed
      And I see Csr.SearchPage.SearchResultTableStatusColumn is displayed
      And I see Csr.SearchPage.SearchResultTableSAPOrderNoColumn is displayed

    Examples:
      | email              |
      | joy@getairmail.com |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  Scenario Outline: Csr user can see no results found when searching with invalid orderid/email
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
    When I type "<text>" in the empty field Csr.SearchPage.<inputField>
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 20 seconds

    @tms:UTR-12010
    Examples:
      | inputField   | text |
      | OrderIdInput | 123  |

    @tms:UTR-10697
    Examples:
      | inputField | text        |
      | EmailInput | ABC@123.com |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  @tms:UTR-10702
  Scenario: Csr user can see no results found when searching with invalid orderid and valid email
    Given I am in csr main of locale default and langCode default with L3 csr account with forced accepted cookies
    When I type to following inputs
      | element                     | value                         |
      | Csr.SearchPage.OrderIdInput | 123                           |
      | Csr.SearchPage.EmailInput   | wts.test.automation@gmail.com |
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 20 seconds

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  @tms:UTR-1380
  Scenario: Csr user can see no results found when searching with valid orderid and invalid email
    Given I am in csr main of locale default and langCode default with L1 csr account with forced accepted cookies
      And I get csr search data for "orderid" and store it with key #OrderId
      And I type "#OrderId" in the empty field Csr.SearchPage.OrderIdInput
      And I type "ABC@123.com" in the empty field Csr.SearchPage.EmailInput
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 20 seconds

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  @tms:UTR-1381
  Scenario: Csr user can see no results found meesage when searching with invalid orderid and invalid email
    Given I am in csr main of locale default and langCode default with L1 csr account with forced accepted cookies
    When I type to following inputs
      | element                     | value       |
      | Csr.SearchPage.OrderIdInput | 123         |
      | Csr.SearchPage.EmailInput   | ABC@123.com |
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 20 seconds

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  Scenario Outline: Csr user can see error message when entering invalid orderid/email
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
    When I type "<invalidInput>" in the field Csr.SearchPage.<inputField>
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.InputError with text <errorMessage> is displayed

    @tms:UTR-570
    Examples:
      | inputField   | invalidInput | errorMessage                  |
      | OrderIdInput | abc          | Please enter a valid order id |
      | OrderIdInput | abc@123      | Please enter a valid order id |
      | OrderIdInput | @$           | Please enter a valid order id |

    @tms:UTR-10700
    Examples:
      | inputField | invalidInput | errorMessage               |
      | EmailInput | abc          | Please enter a valid email |
      | EmailInput | 123          | Please enter a valid email |
      | EmailInput | abc@.com     | Please enter a valid email |
      | EmailInput | @a.com       | Please enter a valid email |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  @tms:UTR-1382
  Scenario: Csr user can see error message when entering invalid orderid and invalid email
    Given I am in csr main of locale default and langCode default with L3 csr account with forced accepted cookies
    When I type to following inputs
      | element                     | value              |
      | Csr.SearchPage.OrderIdInput | abc                |
      | Csr.SearchPage.EmailInput   | pvhecomtest001@Csr @UnifiedExperience |
      And I click on Csr.SearchPage.SearchButton
    Then the count of elements Csr.SearchPage.InputError is equal to 2

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-12011
  Scenario: Csr user can see results when searching with multiple valid orderids
    Given I am in csr main of locale default and langCode default with L1 csr account with forced accepted cookies
      And I get csr search data for "multiple_orders" and store it with key #MultipleOrders
      And I type "#MultipleOrders" in the empty field Csr.SearchPage.OrderIdInput
      And I click on Csr.SearchPage.SearchButton
    Then I see the count of displayed elements Csr.SearchPage.SearchResultTableOrderIDColumn is equal to 3 in 20 seconds
      And I check the displayed order ids "#MultipleOrders" are in the same order as in the search field
      And I store the number of displayed elements Csr.SearchPage.SearchResultCustomerTypeColumn with text R with key #amountofR
      And I store the number of displayed elements Csr.SearchPage.SearchResultCustomerTypeColumn with text G with key #amountofG
      And I add #amountofG to #amountofR and save to #amountofcustomers
      And I see the count of displayed elements Csr.SearchPage.SearchResultTableOrderIDColumn is equal to #amountofcustomers

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  @tms:UTR-1383
  Scenario: Csr user can see results when searching with multiple valid emails
    Given I am in csr main of locale default and langCode default with L3 csr account with forced accepted cookies
      And I get csr search data for "multiple_emails" and store it with key #MultipleEmails
      And I type "#MultipleEmails" in the empty field Csr.SearchPage.EmailInput
      And I click on Csr.SearchPage.SearchButton
    Then I see the count of displayed elements Csr.SearchPage.SearchResultTableEmailColumn is greater than 2 in 20 seconds
      And I check the displayed emails "#MultipleEmails" are in the same order as in the search field

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-1384
  Scenario: Csr user can see results when searching with multiple valid orderids and email
    Given I am in csr main of locale default and langCode default with L1 csr account with forced accepted cookies
      And I get csr search data for "multiple_orders" and store it with key #MultipleOrders
      And I type "#MultipleOrders" in the empty field Csr.SearchPage.OrderIdInput
      And I type "joy@getairmail.com" in the empty field Csr.SearchPage.EmailInput
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is displayed in 20 seconds
      And I see the count of displayed elements Csr.SearchPage.SearchResultTableOrderIDColumn is equal to 1
      And I see Csr.SearchPage.SearchResultTableEmailColumn with text joy@getairmail.com is displayed

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-1385
  Scenario: Csr user can see results when searching with multiple valid orderids and multiple valid emails
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I get csr search data for "multiple_orders_linked_with_email" and store it with key #MultipleOrders
      And I get csr search data for "multiple_emails" and store it with key #MultipleEmails
      And I type "#MultipleOrders" in the empty field Csr.SearchPage.OrderIdInput
      And I type "#MultipleEmails" in the empty field Csr.SearchPage.EmailInput
      And I click on Csr.SearchPage.SearchButton
    Then I see the count of displayed elements Csr.SearchPage.SearchResultTableOrderIDColumn is equal to 3 in 20 seconds
      And I see the count of displayed elements Csr.SearchPage.SearchResultTableEmailColumn is equal to 3
      And I check the displayed order ids "#MultipleOrders" are in the same order as in the search field

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-1386
  Scenario: Csr user can see no results found meesage when searching with multiple valid orderids and invalid email
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I get csr search data for "multiple_orders" and store it with key #MultipleOrders
      And I type "#MultipleOrders" in the empty field Csr.SearchPage.OrderIdInput
      And I type "ABC@123.com" in the empty field Csr.SearchPage.EmailInput
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 20 seconds

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-1387
  Scenario: Csr user can see no results found meesage when searching with multiple invalid orderids and invalid emails
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
    When I type to following inputs
      | element                     | value                                  |
      | Csr.SearchPage.OrderIdInput | 123, 09786545, 789654123               |
      | Csr.SearchPage.EmailInput   | ABC@123.com, Bo@123.com, xyz12@ooo.com |
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 20 seconds

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-10701
  Scenario: Csr user can see no results found meesage when searching with multiple invalid orderids and valid emails
    Given I am in csr main of locale default and langCode default with L3 csr account with forced accepted cookies
      And I get csr search data for "multiple_emails" and store it with key #MultipleEmails
      And I type "123, 09786545, 789654123" in the empty field Csr.SearchPage.OrderIdInput
      And I type "#MultipleEmails" in the empty field Csr.SearchPage.EmailInput
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 20 seconds

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-12012
  Scenario: Csr user can see results when searching with valid data after clearing fields
    Given I am in csr main of locale default and langCode default with L1 csr account with forced accepted cookies
      And I get csr search data for "orderid" and store it with key #OrderId
      And I type "#OrderId" in the empty field Csr.SearchPage.OrderIdInput
      And I type "pvh.qa.automation@gmail.com" in the empty field Csr.SearchPage.EmailInput
      And I store the value of Csr.SearchPage.EmailInput with key #emailID
      And I click on Csr.SearchPage.ClearButton
    Then I see the attribute value of element Csr.SearchPage.OrderIdInput not containing "#OrderId"
      And I see the attribute value of element Csr.SearchPage.EmailInput not containing "#emailID"
    When I type "#OrderId" in the field Csr.SearchPage.OrderIdInput
      And I type "#emailID" in the field Csr.SearchPage.EmailInput
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTableOrderIDColumn with text #OrderId is displayed in 20 seconds
    When I click on Csr.SearchPage.SearchResultTableOrderIDColumn
    Then I see Csr.OrderDetailsPage.OrderNumberHeader with text #OrderId is displayed
      And I see Csr.OrderDetailsPage.OrderAddress with text #emailID is displayed

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-10704
  Scenario: Csr user can see error message when searching with no data
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
    When I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.EmptyInputError with text You must supply an Order id or Email is displayed

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-10699
  Scenario: Csr user can use pagination when using simple search with valid data
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I type "pvh.qa.automation@gmail.com" in the empty field Csr.SearchPage.EmailInput
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is displayed in 20 seconds
      And the count of displayed elements Csr.SearchPage.SearchResultTableOrderIDColumn is equal to 10
      And I store the value of Csr.SearchPage.SearchResultTableOrderIDColumn with key #orderNumber1
      And I see the count of displayed elements Csr.SearchPage.PageNumber is equal to 5
      And I see Csr.SearchPage.PageNumber with text > is displayed
      And I see Csr.SearchPage.PageNumber with text < is not displayed
    When I click on Csr.SearchPage.PageNumber with text 2
    Then I see Csr.SearchPage.PageNumberInput with text 2 is displayed in 20 seconds
      And the count of displayed elements Csr.SearchPage.SearchResultTableOrderIDColumn is equal to 10
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should not be equal to the stored value with key #orderNumber1
      And I store the value of Csr.SearchPage.SearchResultTableOrderIDColumn with key #orderNumber2
      And I see Csr.SearchPage.PageNumber with text < is displayed
    When I click on Csr.SearchPage.PageNumber with text >
    Then I see Csr.SearchPage.PageNumberInput with text 3 is displayed in 20 seconds
      And the count of displayed elements Csr.SearchPage.SearchResultTableOrderIDColumn is equal to 10
      And I store the value of Csr.SearchPage.SearchResultTableOrderIDColumn with key #orderNumber3
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should not be equal to the stored value with key #orderNumber1
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should not be equal to the stored value with key #orderNumber2
      And I see Csr.SearchPage.PageNumber with text > is displayed
    When I click on Csr.SearchPage.PageNumber with text <
    Then I see Csr.SearchPage.PageNumberInput with text 2 is displayed in 20 seconds
      And the count of displayed elements Csr.SearchPage.SearchResultTableOrderIDColumn is equal to 10
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should be equal to the stored value with key #orderNumber2
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should not be equal to the stored value with key #orderNumber3
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should not be equal to the stored value with key #orderNumber1
      And I see Csr.SearchPage.PageNumber with text > is displayed
      And I see Csr.SearchPage.PageNumber with text < is displayed
      And I see Csr.SearchPage.PageNumber with text 1 is not displayed
    When I click on Csr.SearchPage.PageNumberInput
      And I press key Backspace on the keyboard
      And I type "1" in the empty field Csr.SearchPage.PageNumberInput
      And I click on Csr.SearchPage.GoButton
    Then the count of displayed elements Csr.SearchPage.SearchResultTableOrderIDColumn is equal to 10 in 20 seconds
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should be equal to the stored value with key #orderNumber1
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should not be equal to the stored value with key #orderNumber2
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should not be equal to the stored value with key #orderNumber3
      And I see Csr.SearchPage.PageNumber with text < is not displayed
      And I see Csr.SearchPage.PageNumber with text > is displayed

  #TODO: This test will be moved to Order Details feature file.
  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  @tms:UTR-12013
  Scenario: Csr user can open order details from order search
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I type "wts.test.automation@gmail.com" in the empty field Csr.SearchPage.EmailInput
      And I store the value of Csr.SearchPage.EmailInput with key #emailid
      And I click on Csr.SearchPage.SearchButton
      And I see Csr.SearchPage.SearchResultTableEmailColumn with text #emailid is displayed in 20 seconds
      And I store the value of Csr.SearchPage.SearchResultTableOrderIDColumn with key #orderNumber
      And I click on Csr.SearchPage.SearchResultTableOrderIDColumn
    Then I see Csr.OrderDetailsPage.OrderNumberHeader with text #orderNumber is displayed
      And I see Csr.OrderDetailsPage.OrderAddress with text #emailID is displayed

  #FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Csr @UnifiedExperience @EER @P3 @ExcludeSIT
  @tms:UTR-10703
  Scenario: Csr user can see storeid and SFS details in order details page for SFS orders
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I get csr search data for "sfs_orderid" and store it with key #SFSOrderId
      And I type "#SFSOrderId" in the empty field Csr.SearchPage.OrderIdInput
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is displayed in 20 seconds
      And I see Csr.SearchPage.SearchResultTableOrderIDColumn with text #SFSOrderId is displayed
      And I click on Csr.SearchPage.SearchResultTableOrderIDColumn
    Then I see Csr.OrderDetailsPage.OrderNumberHeader with text #SFSOrderId is displayed
      And I see Csr.OrderDetailsPage.OrderAddress with text "Ship from store Address" is displayed
      And I see Csr.OrderDetailsPage.OrderAddress contains text "Store Id : "

  @FullRegression
  @Desktop @EER
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @P3
  @tms:UTR-18318
  Scenario Outline: Csr user can see results when searching for DC orders
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I type "<orderId>" in the empty field Csr.SearchPage.OrderIdInput
    When I click on Csr.SearchPage.SearchButton
    Then I see the count of displayed elements Csr.SearchPage.SearchResultTableOrderIDColumn is equal to 1 in 20 seconds
      And I see Csr.SearchPage.SearchResultTableOrderIDColumn with text <orderId> is displayed with upper case

    Examples:
      | orderId |
      | DC1899  |
      | Dc1899  |
      | dc1899  |
      | dC1899  |
      | 1899    |
