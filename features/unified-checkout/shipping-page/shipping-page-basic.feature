Feature: Unified Checkout - Shipping Page - Basic checks

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @UnifiedCheckout @ShippingPage @P3
  Scenario Outline: Shipping Page - Guest user should not be able to register on shipping page
    Given I am guest on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.SignInPage.SignInButton is clickable
      And I click on Checkout.SignInPage.SignInButton
    When I see MyAccount.SignInPopUp.EmailField is displayed
    Then I see MyAccount.RegisterPopUp.RegisterFormButton is not displayed

    @tms:UTR-17930
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @Payment @Creditcard @P3
  Scenario Outline: Shipping Page Basic - As guest I can see delivery tab icons
    Given I am guest on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.PuPTabIcon is displayed
    Then I see Checkout.ShippingPage.PuPTabIcon is displayed

    @tms:UTR-14451
    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop
  @Chrome @FireFox
  @UnifiedCheckout @ShippingPage @DeliveryMethods @Negative @P3
  Scenario Outline: Shipping Page Basic - As a guest/reg user I cannot see google network call when landing on Shipping Page
  Given I am guest on locale <locale> of langCode <langCode> on the shipping page
      And I wait until Checkout.ShippingPage.PuPTabIcon is displayed
    Then I expect 0 network request named GeocodeService.Search of type script to be processed in 10 seconds

    @tms:UTR-18783
    Examples:
      | locale  | langCode |
      | default | default  |

