Feature: Payment - session expiry

  # @FullRegression Since Management center user is block , for now disabling this tests
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @Payment @iDeal @sessionExpiry @P2 @tms:UTR-17120 @ExcludeDB0 
  Scenario: Ideal payment - Expire guest session using queries to DB and navigate back to payment page
    Given I am <userType> on locale <locale> of langCode default on the payment page
    When I get the callerId from cookie WC_AUTHENTICATION paramater and stored with #callerId key
      And I click on Checkout.PaymentPage.IdealButton
      And I see Checkout.PaymentPage.BankSelectionDropDown is displayed in 10 seconds
      And in dropdown Checkout.PaymentPage.BankSelectionDropDown I select the option by text "Test Issuer Pending"
      And I click on Checkout.PaymentPage.PlaceOrderButton
      And I wait for 1 seconds
    Then In DB there should be 1 entry for #callerId in CTXMGMT table
      And In DB I update the last access time by reducing it by 8 day for #callerId in CTXMGMT table
      And I wait for 5 seconds
      And I open a new browser tab
      And I switch to 2nd browser tab
    When I login in to management centre with username "wcsadmin", password "Welcome01" and run job "ActivityCleanUp" in system admin task "Scheduler"
      And I wait until ManagementCentre.successMessageBar is displayed in 5 seconds
      And I wait for 5 seconds
      And In DB there should be 0 entry for #callerId in CTXMGMT table
      And I switch to 1st browser tab
      And I navigate back in the browser
    Then I wait until Checkout.PaymentPage.CreditCardButton is clickable

    Examples:
      | locale | langCode | userType |
      | nl     | default  | guest    |
