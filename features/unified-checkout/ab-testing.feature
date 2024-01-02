Feature: Sap Products Orders

  # @FullRegression
  # This tests is the reference sceanrios for future AB test tickets
  @Desktop @Mobile
  @Chrome @FireFox
  @UnifiedCheckout @PaymentPage @PaymentMethod @tms:UTR-13507
  Scenario Outline: AB Tests - Verify the variations of experiment on payment page
    Given I am guest on locale <locale> of langCode <langCode> on the payment page
    When I set cookie with name pvh_cv_qa and value true
    When I simulate optimizley experiment id <experimentId> by updating local storage key with variation id <variantId>
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
    Then I see Checkout.PaymentPage.PaymentMethodByIndex with index 1 contains text "<First>"
    Then I see Checkout.PaymentPage.PaymentMethodByIndex with index 2 contains text "<Second>"
    Then I see Checkout.PaymentPage.PaymentMethodByIndex with index 3 contains text "<Third>"
      And I wait until Checkout.PaymentPage.PaypalButton is clickable
      And I click on Checkout.PaymentPage.PaypalButton
      And I see Checkout.PaymentPage.PayWithPayPal is in viewport

    @ExcludeTH
    Examples:
      | locale | langCode | First      | Second | Third  | experimentId | variantId   |
      | uk     | default  | Bancontact | Credit | PayPal | 22537900497  | 24231940326 |

    @ExcludeCK
    Examples:
      | locale | langCode | First      | Second | Third  | experimentId | variantId   |
      | uk     | default  | Bancontact | Credit | PayPal | 24207480080  | 24194850083 |