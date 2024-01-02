Feature: Unified Tracking - Events

  #double check with PAN/CND regarding carousel_video variables

  @Desktop
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedPdp 
  @TEE @PDP
  @tms:UTR-10534
  Scenario Outline: Carousel click - The event is fired when I click on the next carousel image from PDP on Desktop
    Given I am on unified locale <locale> pdp page for product style <productId> with forced accepted cookies
      And I wait until page ProductDetailPage.Pdp is loaded
    When I inject utag event listener
      And I click on ProductDetailPage.Pdp.ProductImages with index 2
    Then utag event carousel_click is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "carousel click"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr index_no with value "2" in lower case
      And utag event #event should contain attr carousel_video_visibility with value "not_set"
      And utag event #event should contain attr carousel_video_availability with value "false"
      And utag event #event should contain attr originEntry with value "pdp"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | productId                   |
      | ee     | AM0AM08484GPF/K40K400257436 |

  @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedPdp
  @TEE @PDP
  @tms:UTR-10535
  Scenario Outline: Carousel click - The event is fired when I click on the next carousel image from PDP on Mobile
    Given I am on unified locale <locale> pdp page for product style <productId> with forced accepted cookies
      And I wait until page ProductDetailPage.Pdp is loaded
    When I inject utag event listener
      And I swipe to left direction on element ProductDetailPage.Pdp.ProductImages
      And I wait until ProductDetailPage.Pdp.VideoPlayButton is displayed
    Then utag event carousel_click is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "carousel click"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr index_no with value "2" in lower case
      And utag event #event should contain attr carousel_video_visibility with value "not_set"
      And utag event #event should contain attr carousel_video_availability with value "false"
      And utag event #event should contain attr originEntry with value "pdp"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | productId                   |
      | ee     | AM0AM08484GPF/K40K400257436 |

  @Desktop
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedPdp
  @TEE @PDP
  @tms:UTR-10536
  Scenario Outline: Carousel click - The event is fired when I click on the next carousel image with video from PDP on Desktop
    Given I am on unified locale <locale> pdp page for product style <productId> with forced accepted cookies
      And I wait until page ProductDetailPage.Pdp is loaded
    When I inject utag event listener
      And I click on ProductDetailPage.Pdp.ProductImages with index 2
    Then utag event carousel_click is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "carousel click"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr index_no with value "2" in lower case
      And utag event #event should contain attr carousel_video_visibility with value "visible"
      And utag event #event should contain attr carousel_video_availability with value "true"
      And utag event #event should contain attr originEntry with value "pdp"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | productId                   |
      | ee     | WW0WW31450GW8/J20J2183420GL |

  @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedPdp
  @TEE @PDP
  @tms:UTR-10537
  Scenario Outline: Carousel click - The event is fired when I click on the next carousel image with video from PDP on Mobile
    Given I am on unified locale <locale> pdp page for product style <productId> with forced accepted cookies
      And I wait until page ProductDetailPage.Pdp is loaded
    When I inject utag event listener
      And I swipe to left direction on element ProductDetailPage.Pdp.ProductImages
      And I wait until ProductDetailPage.Pdp.VideoPlayButton is displayed
    Then utag event carousel_click is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "carousel click"
      And utag event #event should contain attr eventLabel with value "product1#styleColourPartNumber" in lower case
      And utag event #event should contain attr index_no with value "2" in lower case
      And utag event #event should contain attr carousel_video_visibility with value "not_set"
      And utag event #event should contain attr carousel_video_availability with value "false"
      And utag event #event should contain attr originEntry with value "pdp"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | productId                   |
      | ee     | WW0WW31450GW8/J20J2183420GL |