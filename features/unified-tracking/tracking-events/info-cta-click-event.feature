Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedPdp
  @TEE @PDP
  @tms:UTR-9875
  Scenario Outline: Info cta click - The event is fired when I click on the details and shipping section from PDP
    Given There is 1 normal size product item of locale <locale> with inventory between 50 and 9999
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until page ProductDetailPage.Pdp is loaded
    When I inject utag event listener
      And I click on <contentType>
    Then utag event info_cta_click is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "info cta click"
      And utag event #event should contain attr eventLabel with value "<clickText>"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | contentType                                           | clickText       |
      | ee     | ProductDetailPage.Pdp.ProductDetailsButton            | details         |
      # | ee     | ProductDetailPage.Pdp.ProductShippingAndReturnsButton | shipping_return | # TODO: Check for failures