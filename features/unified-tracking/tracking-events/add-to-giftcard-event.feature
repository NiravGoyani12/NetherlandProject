Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @P1 @tms:UTR-17382 @AnalyticsGiftcard
  Scenario Outline: Giftcard - The event is fired when I add a gift card to cart
      Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page giftcard-pdp
      And I wait until the current page is loaded
      And I click on ProductDetailPage.GiftCardsPage.PriceSelectorButton with index 1
      When I inject utag event listener
      And I click on ProductDetailPage.GiftCardsPage.GiftCardAddToBagButton
      Then utag event add_to_cart_giftcard is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "ecommerce"
      And utag event #event should contain attr eventAction with value "add to cart giftcard"
      And utag event #event should contain attr eventLabel with value "giftcard|>giftcard" 
      And I execute all datalayer event validation with report key #event

  Examples:
      | locale | langCode |
      | dk     | default  |