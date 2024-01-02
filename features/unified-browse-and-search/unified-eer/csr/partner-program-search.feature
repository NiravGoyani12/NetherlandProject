Feature: CSR - Partner Program Search

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Csr @UnifiedExperience @EER @ExcludeProdStag @P2 @ExcludeSIT
  @tms:UTR-12402
  Scenario Outline: CSR user can see order details when search in Partner Program with valid query
    Given I am in csr partner orders of locale default and langCode default with L2 csr account with forced accepted cookies
      And I type "<OrderId>" in the empty field Csr.SearchPage.OrderIdInput
      And I click on Csr.PartnerOrdersPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is displayed in 10 seconds
      And I see Csr.SearchPage.SearchResultTableOrderIDColumn with text <OrderId> is displayed
    When I click on Csr.SearchPage.SearchResultTableOrderIDColumn
    Then I see Csr.OrderDetailsPage.OrderNumberHeader with text <OrderId> is displayed
      And I see Csr.OrderDetailsPage.OrderDetails with text <OrderId> is displayed
      And I see Csr.OrderDetailsPage.OrderDetails with text <orderDate> is displayed
      And I see Csr.OrderDetailsPage.OrderDetails with text <orderStatus> is displayed
      And I see Csr.OrderDetailsPage.OrderDetails with text <deliveryMethod> is displayed
      And I see Csr.OrderDetailsPage.OrderDetails with text <orderType> is displayed
      And I store the number of elements Csr.OrderDetailsPage.OrderItem with key #numberOfItems
      And the count of displayed elements Csr.OrderDetailsPage.OrderItem is equal to #numberOfItems
      And the count of displayed elements Csr.OrderDetailsPage.OrderItemDetails with text Shipped is equal to #numberOfItems

    Examples:
      | OrderId            | orderDate  | orderStatus | deliveryMethod    | orderType               |
      | ayou-139-110539493 | 03/08/2021 | Shipped     | Standard delivery | ABOUT YOU               |
      | 10101342887140     | 01/08/2021 | Shipped     | Standard delivery | ZALANDO PARTNER PROGRAM |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Csr @UnifiedExperience @EER @P3 @ExcludeProdStag
  @tms:UTR-12403
  Scenario Outline: CSR user can search Partner Program with multiple orders
    Given I am in csr partner orders of locale default and langCode default with L3 csr account with forced accepted cookies
      And I type "<orderNumber1>, <orderNumber2>" in the empty field Csr.SearchPage.OrderIdInput
      And I click on Csr.PartnerOrdersPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTableOrderIDColumn with text <orderNumber1> is displayed in 10 seconds
      And I see Csr.SearchPage.SearchResultTableOrderIDColumn with text <orderNumber2> is displayed

    Examples:
      | orderNumber1   | orderNumber2   |
      | 10101342733242 | 10101342816363 |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-12404
  Scenario Outline: CSR user can see error message when search order in Partner Program with empty/invalid data
    Given I am in csr partner orders of locale default and langCode default with L1 csr account with forced accepted cookies
      And I type "<inputdata>" in the empty field Csr.SearchPage.OrderIdInput
      And I click on Csr.PartnerOrdersPage.SearchButton
    Then I see Csr.PartnerOrdersPage.<inputError> with text <errorMsg> is displayed in 10 seconds

    Examples:
      | inputdata | inputError               | errorMsg                      |
      |           | OrderNumberRequiredError | You must supply an Order id   |
      | @@@@      | InvalidOrderNumberError  | Please enter a valid order id |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-12405
  Scenario Outline: CSR user can see no results displayed when search order in Partner Program with invalid query
    Given I am in csr partner orders of locale default and langCode default with L3 csr account with forced accepted cookies
      And I type "<orderNumber>" in the empty field Csr.SearchPage.OrderIdInput
      And I click on Csr.PartnerOrdersPage.SearchButton
    Then I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 10 seconds

    Examples:
      | orderNumber |
      | abc         |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-12002
  Scenario Outline: CSR user can see all the available goodwill reasons present in the dropdown list for Partner Program Order
    Given I am in csr partner orders of locale default and langCode default with L2 csr account with forced accepted cookies
      And I type "<OrderId>" in the empty field Csr.SearchPage.OrderIdInput
      And I click on Csr.PartnerOrdersPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is displayed in 10 seconds
      And I see Csr.SearchPage.SearchResultTableOrderIDColumn with text <OrderId> is displayed
      And I click on Csr.SearchPage.SearchResultTableOrderIDColumn
    Then I see Csr.OrderDetailsPage.OrderNumberHeader with text <OrderId> is displayed
    When I click on Csr.OrderDetailsPage.PPOrderGoodwillButton
      And I see Csr.OrderDetailsPage.GoodwillPopup is displayed
      And I click on Csr.OrderDetailsPage.GoodwillReasonSelectField
    Then in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Missing item upon delivery" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Incorrect refund upon return" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Lost upon delivery" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Lost upon return" exists

    Examples:
      | OrderId        |
      | 10101342793069 |
