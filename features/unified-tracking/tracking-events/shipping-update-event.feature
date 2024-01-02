Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @ShippingPage @DeliveryMethods @UnifiedCheckout @P2
  @tms:UTR-811
  Scenario Outline: Shipping update - The event is fired when I choose delivery method UPS Standard
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 products with value below shipping threshold on shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is displayed
      And I click on Checkout.ShippingPage.ExpressRadioButton
    When I inject utag event listener
      And I click on Checkout.ShippingPage.StandardRadioButton
    Then utag event shipping_update is fired saved to key #event
      And utag event #event should contain attr event_name with value "shipping_update"
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "shipping_update"
      And utag event #event should contain attr eventLabel with value "UPS"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | userType  |
      | hr     | default  | guest     |
      | hr     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @ShippingPage @DeliveryMethods @UnifiedCheckout @P2
  @tms:UTR-5876 @issue:EESCK-8964
  Scenario Outline: Shipping update - The event is fired when I choose delivery method UPS Standard
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 products with value below shipping threshold on shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is displayed
      And I click on Checkout.ShippingPage.ExpressRadioButton
    When I inject utag event listener
      And I click on Checkout.ShippingPage.StandardRadioButton
    Then utag event shipping_update is fired saved to key #event
      And utag event #event should contain attr event_name with value "shipping_update"
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "shipping_update"
      And utag event #event should contain attr eventLabel with value "BPOST"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | userType  |
      | be     | default  | guest     |
      | be     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @ShippingPage @DeliveryMethods @UnifiedCheckout @P2
  @tms:UTR-802
  Scenario Outline: Shipping update - The event is fired when I choose delivery method UPS Express
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 products with value below shipping threshold on shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is displayed
    When I inject utag event listener
      And I click on Checkout.ShippingPage.ExpressRadioButton
    Then utag event shipping_update is fired saved to key #event
      And utag event #event should contain attr event_name with value "shipping_update"
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "shipping_update"
      And utag event #event should contain attr eventLabel with value "UPS_Express"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | userType  |
      | hr     | default  | guest     |
      | hr     | default  | logged in |

# TODO: Check for failures only CK
  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @ShippingPage @DeliveryMethods @UnifiedCheckout @P2
  @tms:UTR-5834
  Scenario Outline: Shipping update - The event is fired when I choose delivery method UPS Access Point
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 products with value above shipping threshold on shipping page
      And I wait until Checkout.ShippingPage.ToPickup is displayed
    When I inject utag event listener
      And I click on Checkout.ShippingPage.ToPickup
      And I click on Checkout.ShippingPage.UPSAccesPointRadioButton
    Then utag event shipping_update is fired saved to key #event
      And utag event #event should contain attr event_name with value "shipping_update"
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "shipping_update"
      And utag event #event should contain attr eventLabel with value "UPS_Access_Point"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | userType  |
      | pl     | default  | guest     |
      | pl     | default  | logged in |

# TODO: Check for failures only CK
  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @ShippingPage @DeliveryMethods @UnifiedCheckout @P2
  @tms:UTR-5832
  Scenario Outline: Shipping update - The event is fired when I choose delivery method Collect in Store
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 products with value below shipping threshold on shipping page
      And I wait until Checkout.ShippingPage.ToPickup is displayed
    When I inject utag event listener
      And I click on Checkout.ShippingPage.ToPickup
      And I click on Checkout.ShippingPage.CollectInStoreRadioButton
    Then utag event shipping_update is fired saved to key #event
      And utag event #event should contain attr event_name with value "shipping_update"
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "shipping_update"
      And utag event #event should contain attr eventLabel with value "Click_And_Collect"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | userType  |
      | uk     | default  | guest     |
      | uk     | default  | logged in |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @ShippingPage @DeliveryMethods @UnifiedCheckout @P2
  @tms:UTR-5833
  Scenario Outline: Shipping update - The event is fired when I choose delivery method DHL Standard
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 products with value above shipping threshold on shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is displayed
      And I click on Checkout.ShippingPage.ExpressRadioButton
    When I inject utag event listener
      And I click on Checkout.ShippingPage.StandardRadioButton
    Then utag event shipping_update is fired saved to key #event
      And utag event #event should contain attr event_name with value "shipping_update"
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "shipping_update"
      And utag event #event should contain attr eventLabel with value "DHL_Standard"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | userType  |
      | pl     | default  | guest     |
      | pl     | default  | logged in |

# TODO: Check for failures only CK
  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @DataLayerEvent @DeliveryMethods @UnifiedCheckout @P2
  @tms:UTR-6782
  Scenario Outline: Shipping update - The event is fired when I choose delivery method DHL Packstation
    Given I am <userType> on locale <locale> of langCode <langCode> with 1 products with value above shipping threshold on shipping page
      And I wait until Checkout.ShippingPage.StandardRadioButton is displayed
    When I inject utag event listener
      And I click on Checkout.ShippingPage.DHLPackstationRadioButton
    Then utag event shipping_update is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "shipping_update"
      And utag event #event should contain attr eventLabel with value "DHL_Pack_St"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode | userType  |
      | de     | default  | guest     |
      | de     | default  | logged in |

# TODO: Check for failures only CK
  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @DataLayerEvent @DeliveryMethods @UnifiedCheckout @P2
  @tms:UTR-6783
  Scenario Outline: Shipping update - The event is fired when I choose delivery method PostNL Pick Up Point
    Given I am logged in on locale <locale> of langCode <langCode> with 1 products with value above shipping threshold on shipping page
        And I wait until Checkout.ShippingPage.ToPickup is displayed
    When I inject utag event listener
      And I click on Checkout.ShippingPage.ToPickup
      And I click on Checkout.ShippingPage.PostNLRadioButton
    Then utag event shipping_update is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "shipping_update"
      And utag event #event should contain attr eventLabel with value "Post_Nl_Pup"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale | langCode |
      | nl     | default  |
