Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @CET1 @P3
  @tms:UTR-4681
  Scenario Outline: View shopping bag - the event is fired when I click on the empty basket icon
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page <page>
    When I inject utag event listener
      And I click on Experience.Header.<locator>
    Then utag event view_shopping_bag is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "view_shopping_bag"
      And utag event #event should contain attr eventLabel with value "basket_icon"
      And utag event #event should contain attr event_value with value "empty"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | page          | locator           |
      | ee     | default  | store-locator | ShoppingBagButton |
      | fr     | default  | wlp           | ShoppingBagButton |

# TODO: Check for failures only CK
  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @CET1 @P3
  @tms:UTR-4682
  Scenario Outline: View shopping bag - the event is fired when I click on the full basket icon
    Given There is 1 product items with 0% discount of locale <locale> with price between 50 and 500 and inventory between 10 and 9999
      And I am on locale <locale> shopping bag page for product item product1#skuPartNumber with forced accepted cookies
      And I navigate to page <page>
    When I inject utag event listener
      And I click on Experience.Header.<locator>
    Then utag event view_shopping_bag is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "view_shopping_bag"
      And utag event #event should contain attr eventLabel with value "basket_icon"
      And utag event #event should contain attr event_value with value "filled"
      And I execute all datalayer event validation with report key #event


    Examples:
      | locale | langCode | page          | locator           |
      | ee     | default  | store-locator | ShoppingBagButton |
      | fr     | default  | wlp           | ShoppingBagButton |