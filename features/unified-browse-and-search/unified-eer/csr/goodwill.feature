Feature: CSR - Goodwill
  #TODO: This is not applicable for dB0, because we do not have SAP on this dB

  @FullRegression
  @Desktop @P2
  @Chrome @FireFox @Safari
  @Csr @UnifiedExperience @EER @Goodwill @ExcludeProdStag
  @tms:UTR-12006
  Scenario Outline: Csr user can apply NEW goodwill on item level
    Given I get csr search data for "goodwill_orderid" and store it with key #Goodwill_Order
      And I am in csr orders with order id #Goodwill_Order of locale default and langCode default with L2 csr account with forced accepted cookies
    When I click on Csr.OrderDetailsPage.ItemGoodwillButton is displayed in 10 seconds
      And I see Csr.OrderDetailsPage.GoodwillPopup is displayed
      And I store the number of displayed elements Csr.OrderDetailsPage.CreditNoteButton with key #CreditNoteNumberOfLinksBefore
      And I store the numeric value of Csr.OrderDetailsPage.GoodwillRefundItemTextValue with key #GoodwillRefundBefore if displayed
      And I store the numeric value of Csr.OrderDetailsPage.GoodwillRefundTotalTextValue with key #TotalRefundBefore if displayed
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I select the option by text "<goodwillReason>"
      And I type "<goodwillAmount>" in the field Csr.OrderDetailsPage.GoodwillAmountField
      And I wait until Csr.OrderDetailsPage.GoodwillPopupConfirmButton is enabled
      And I click on Csr.OrderDetailsPage.GoodwillPopupConfirmButton
    Then I see Csr.OrderDetailsPage.GoodwillPopup with text Success is displayed in 15 seconds
      And I see Csr.OrderDetailsPage.GoodwillPopup with text <goodwillAmount> is displayed
      And I click on Csr.OrderDetailsPage.GoodwillPopupClose
      And the numeric value of Csr.OrderDetailsPage.GoodwillRefundItemTextValue is greater or equal than #GoodwillRefundBefore
      And the numeric value of Csr.OrderDetailsPage.GoodwillRefundTotalTextValue is greater or equal than #TotalRefundBefore
      And I wait for 5 seconds
      And the values of displayed elements Csr.OrderDetailsPage.CreditNoteButton should not be equal to the stored values with key #CreditNoteNumberOfLinksBefore

    Examples:
      | goodwillAmount | goodwillReason |
      | 0.01           | Price match    |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @Csr @UnifiedExperience @EER @Goodwill @P1 @ExcludeProdStag
  @tms:UTR-12005
  Scenario Outline: Csr user can apply NEW goodwill on order level
    Given I get csr search data for "goodwill_orderid" and store it with key #Goodwill_Order
      And I am in csr orders with order id #Goodwill_Order of locale default and langCode default with L4 csr account with forced accepted cookies
    When I click on Csr.OrderDetailsPage.OrderGoodwillButton is displayed in 10 seconds
      And I see Csr.OrderDetailsPage.GoodwillPopup is displayed
      And I store the number of displayed elements Csr.OrderDetailsPage.CreditNoteButton with key #CreditNoteNumberOfLinksBefore
      And I store the numeric value of Csr.OrderDetailsPage.GoodwillRefundOrderLevelTextValue with key #GoodwillRefundBefore if displayed
      And I store the numeric value of Csr.OrderDetailsPage.GoodwillRefundTotalTextValue with key #TotalRefundBefore if displayed
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I select the option by text "<goodwillReason>"
      And I type "<goodwillAmount>" in the field Csr.OrderDetailsPage.GoodwillAmountField
      And I wait until Csr.OrderDetailsPage.GoodwillPopupConfirmButton is enabled
      And I click on Csr.OrderDetailsPage.GoodwillPopupConfirmButton
    Then I see Csr.OrderDetailsPage.GoodwillPopup with text Success is displayed in 15 seconds
      And I see Csr.OrderDetailsPage.GoodwillPopup with text <goodwillAmount> is displayed
      And I click on Csr.OrderDetailsPage.GoodwillPopupClose
      And the numeric value of Csr.OrderDetailsPage.GoodwillRefundOrderLevelTextValue is greater than #GoodwillRefundBefore
      And the numeric value of Csr.OrderDetailsPage.GoodwillRefundTotalTextValue is greater than #TotalRefundBefore
      And the values of displayed elements Csr.OrderDetailsPage.CreditNoteButton should not be equal to the stored values with key #CreditNoteNumberOfLinksBefore

    Examples:
      | goodwillAmount | goodwillReason |
      | 0.01           | Promotion      |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-10802 @Goodwill @ExcludeProdStag
  Scenario: CSR user can see all the available Order Level goodwill reasons present in the dropdown list
    Given I get csr search data for "goodwill_orderid" and store it with key #Goodwill_Order
      And I am in csr orders with order id #Goodwill_Order of locale default and langCode default with L2 csr account with forced accepted cookies
    When I click on Csr.OrderDetailsPage.OrderGoodwillButton
      And I see Csr.OrderDetailsPage.GoodwillPopup is displayed
      And I click on Csr.OrderDetailsPage.GoodwillReasonSelectField
    Then in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Delivery - Lost parcel" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Return - Lost parcel" exists
#      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Shipping" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Goodwill" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Promotion" exists

  @FullRegression
  @Desktop
  @Chrome @P2 @ExcludeProdStag
  @Csr @UnifiedExperience @EER @Goodwill
  @tms:UTR-12001
  Scenario: CSR user can see all the available Item Level goodwill reasons present in the dropdown list
    Given I get csr search data for "goodwill_orderid" and store it with key #Goodwill_Order
      And I am in csr orders with order id #Goodwill_Order of locale default and langCode default with L2 csr account with forced accepted cookies
    When I click on Csr.OrderDetailsPage.ItemGoodwillButton
      And I see Csr.OrderDetailsPage.GoodwillPopup is displayed
      And I click on Csr.OrderDetailsPage.GoodwillReasonSelectField
    Then in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Price match" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Delivery - Missing item" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Return - Missing item" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Quality issue" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Goodwill" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Promotion" exists

  #@FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @Goodwill @P2 @ExcludeProdStag @ExcludeDB0
  @tms:EER-3731 @issue:EED-14926
  # TODO adjust when FE for fill in shipping costs will be ready
  Scenario: When CSR user select shipping goodwill - reasons are correct and amount is prefilled
    Given I get csr search data for "goodwill_orderid" and store it with key #Goodwill_Order
      And I am in csr orders with order id #Goodwill_Order of locale default and langCode default with L2 csr account with forced accepted cookies
      And I wait until Csr.OrderDetailsPage.GoodwillRefundItemTextValue is displayed
    # And I store the numeric value of Csr.OrderDetailsPage.ShippingCost with key #shippingcost
    When I click on Csr.OrderDetailsPage.OrderGoodwillButton
      And I see Csr.OrderDetailsPage.GoodwillPopup is displayed
      And I click on Csr.OrderDetailsPage.GoodwillReasonSelectField
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Promotion" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Price Match" exists
      # And in dropdown OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Shipping" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Missing Item" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Goodwill" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Incorrect Refund" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Lost Parcel" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Poor quality" exists
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I see the option with text "Not as expected" exists
  # And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I select the option by text "Shipping"
  #   And I type "<goodwillAmount>" in the field Csr.OrderDetailsPage.GoodwillAmountField
  # Then I see Csr.OrderDetailsPage.GoodwillAmountField contains text "#shippingcost

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @Goodwill @P2 @ExcludeProdStag
  @tms:UTR-12004
  Scenario Outline: Csr user can apply goodwill on order level and can see on item level
    Given I get csr search data for "goodwill_orderid" and store it with key #Goodwill_Order
      And I am in csr orders with order id #Goodwill_Order of locale <locale> and langCode default with L2 csr account with forced accepted cookies
      And I click on Csr.OrderDetailsPage.OrderGoodwillButton is displayed in 10 seconds
      And I wait until Csr.OrderDetailsPage.GoodwillPopup is displayed
      And I store the numeric value of Csr.OrderDetailsPage.MaxItemGoodwillAllowedValue with index 1 with key #MaxItem1GoodwillAllowedBefore
      And I store the numeric value of Csr.OrderDetailsPage.MaxItemGoodwillAllowedValue with index 2 with key #MaxItem2GoodwillAllowedBefore
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I select the option by text "<goodwillReason>"
      And I type "<goodwillAmount>" in the field Csr.OrderDetailsPage.GoodwillAmountField
      And I click on Csr.OrderDetailsPage.GoodwillPopupConfirmButton
    Then I see Csr.OrderDetailsPage.GoodwillPopup with text Success is displayed in 20 seconds
      And I see Csr.OrderDetailsPage.GoodwillPopup with text <goodwillAmount> is displayed
    When I click on Csr.OrderDetailsPage.GoodwillPopupClose
    Then I see the numeric value of Csr.OrderDetailsPage.MaxItemGoodwillAllowedValue with index 1 is less than #MaxItem1GoodwillAllowedBefore
      And I see the numeric value of Csr.OrderDetailsPage.MaxItemGoodwillAllowedValue with index 2 is less than #MaxItem2GoodwillAllowedBefore

    Examples:
      | locale | goodwillAmount | goodwillReason |
      | uk     | 0.10           | Goodwill       |

  @FullRegression
  @Desktop @ExcludeProdStag
  @Chrome @EER @Goodwill @P2
  @Csr @UnifiedExperience
  Scenario Outline: Csr user only see and apply Gift card reason on order and item level when Gift card as item
    Given I get csr search data for "gift_card_orderid" and store it with key #Giftcard_Order
      And I am in csr orders with order id #Giftcard_Order of locale default and langCode default with L2 csr account with forced accepted cookies
    When I click on Csr.OrderDetailsPage.<goodwillButton>
      And I see Csr.OrderDetailsPage.GoodwillPopup is displayed
      And in dropdown Csr.OrderDetailsPage.GoodwillReasonSelectDropdown I select the option by text "<goodwillReason>"
    Then I see Csr.OrderDetailsPage.GoodwillAmountField is displayed

    @tms:UTR-18244
    Examples:
      | goodwillReason | goodwillButton     |
      | Gift Card      | ItemGoodwillButton |

    @tms:UTR-18242
    Examples:
      | goodwillReason | goodwillButton      |
      | Gift Card      | OrderGoodwillButton |
