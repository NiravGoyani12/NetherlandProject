Feature: Unified Header

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending @UnifiedExperience
  @Header @ElementCheck @ContentCheck @TEX @UnifiedTEX @UnifiedMegaMenu
  @tms:UTR-13391
  Scenario Outline: Unified Header - Verify elements of the header are displayed for guest user
    Given I am on locale <locale> home page with accepted cookies
      And I navigate to page <page>
    Then I see Experience.Header.Logo is displayed
      And I see Experience.Header.WishListIcon is displayed
      And I see Experience.Header.ShoppingBasketIcon is displayed
    When I ensure unified mega menu is interactable
    Then I see Experience.Header.SearchField is displayed in 20 seconds
      And I see Experience.Header.SignInButton is displayed in 20 seconds

    @P1
    Examples:
      | locale  | page |
      | default | wlp  |

    @P2
    Examples:
      | locale           | page         |
      | multiLangDefault | shopping-bag |

    @UnifiedPdp @UnifiedExperience @P2
    Examples:
      | locale  | page |
      | default | pdp  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending @UnifiedExperience @P2
  @Header @ElementCheck @ContentCheck @TEX @UnifiedTEX @UnifiedMegaMenu
  @tms:UTR-13391
  Scenario Outline: Unified Header - Verify elements of the header are displayed on giftcard page
    Given I am on locale <locale> home page with accepted cookies
      And I navigate to page <page>
      And I hover over Experience.Header.MainBlock
    Then I see Experience.Header.Logo is displayed
      And I see Experience.Header.WishListIcon is displayed
      And I see Experience.Header.ShoppingBasketIcon is displayed
    When I ensure unified mega menu is interactable
    Then I see Experience.Header.SearchField is displayed in 20 seconds
      And I see Experience.Header.SignInButton is displayed in 20 seconds

    @UnifiedPdp @UnifiedExperience
    Examples:
      | locale  | page         |
      | default | giftcard-pdp |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @SafariPending @UnifiedExperience
  @Header @ElementCheck @ContentCheck @TEX @UnifiedTEX @UnifiedMegaMenu
  @tms:UTR-13392
  Scenario Outline: Unified Header - Verify elements of the header are displayed for logged in user
    Given I am on locale <locale> home page with forced accepted cookies
      And I navigate to page <page>
      And I am a logged in user
      And I wait until the current page is loaded
    Then I see Experience.Header.Logo is displayed
      And I see Experience.Header.WishListIcon is displayed
      And I see Experience.Header.ShoppingBasketIcon is displayed
    When I ensure unified mega menu is interactable
    Then I see Experience.Header.SearchField is displayed
      And I see Experience.Header.MyAccountButton is displayed
      And I see Experience.Header.SignInButton is not displayed in 2 seconds

    @P1
    Examples:
      | locale  | page         |
      | default | shopping-bag |

    @P2
    Examples:
      | locale           | page |
      | multiLangDefault | wlp  |

    @UnifiedPdp @UnifiedExperience @P2
    Examples:
      | locale  | page |
      | default | pdp  |