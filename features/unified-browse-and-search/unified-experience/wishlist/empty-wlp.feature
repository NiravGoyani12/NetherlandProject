Feature: Unified Wishlist - Empty wishlist page

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @tms:UTR-3443 @feature:CET1-3074
  Scenario Outline: WLP - Validate navigation to unified empty wishlist page
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I wait until the current page is loaded
      And I navigate to page <page>
    When I click on Experience.Header.<locator>
      And I wait for 3 seconds
    Then URL should contain "/wishlist"
      And I see Experience.Wishlist.EmptyWishlistTitle is displayed

    @P2
    Examples:
      | locale  | langCode | page | userType  | locator      |
      | default | default  | pdp  | logged in | WishListIcon |

    Examples:
      | locale           | langCode | page       | userType  | locator      |
      | default          | default  | wlp        | logged in | WishListIcon |
      | default          | default  | glp        | guest     | WishListIcon |
      | multiLangDefault | default  | glp        | logged in | WishListIcon |
      | multiLangDefault | default  | search-plp | guest     | WishListIcon |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @tms:UTR-3446 @feature:CET1-3074
  Scenario Outline: Unified Wishlist - Validate unified empty wishlist page elements
    Given I am on locale <locale> home page with forced accepted cookies
      And I navigate to page <page>
      And I am a <user> user
    Then URL should contain "/wishlist"
      And I see Experience.Wishlist.EmptyWishlistTitle with text <titleText> is displayed
      And I see Experience.Wishlist.EmptyWishlistCopy with text <copyText> is displayed
      And I see Experience.Wishlist.EmptyWishlistButton with text <buttonText> is displayed
      And I see Experience.Header.ActiveWishListIcon is not displayed in 1 second

    @P2
    Examples:
      | locale  | page | user      | titleText                         | copyText                                                      | buttonText         |
      | default | wlp  | guest     | Looks like your wishlist is empty | Sign in to see your saved items                               | Sign In / Register |
      | ee      | wlp  | logged in | Looks like your wishlist is empty | Make your wishlist by clicking the heart icon on each product | Continue Shopping  |

    Examples:
      | locale | page | user      | titleText                                                     | copyText                                                                                 | buttonText              |
      | be     | wlp  | guest     | Je wishlist is nog leeg                                       | Log in om je bewaarde artikelen te bekijken                                              | Aanmelden / Registreren |
      | fr     | wlp  | logged in | On dirait que votre liste de favoris est vide                 | Créez votre liste de favoris en cliquant sur l'icône en forme de cœur sur chaque produit | Continuer les achats    |
      | pl     | wlp  | guest     | Wygląda na to, że Twoja lista ulubionych produktów jest pusta | Zaloguj się, by zobaczyć zapisane produkty                                               | Logowanie / Rejestracja |
      | uk     | wlp  | logged in | Looks like your wishlist is empty                             | Make your wishlist by clicking the heart icon on each product                            | Continue Shopping       |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @feature:CET1-3074
  @tms:UTR-3445 @issue:CET1-3311
  Scenario Outline: Unified Wishlist - Unified Empty wishlist page button opens authentication drawer when its guest user
    Given I am on locale <locale> home page with forced accepted cookies
      And I am a <user> user
    When I click on Experience.Header.<locator>
      And I wait for 3 seconds
      And I click on Experience.Wishlist.EmptyWishlistButton with text <buttonText>
    Then I see MyAccount.SignInPopUp.EmailField is displayed

    @P2
    Examples:
      | locale | page | expectedPage | user  | buttonText         | locator      |
      | ee     | glp  | GLP          | guest | Sign In / Register | WishListIcon |

    Examples:
      | locale | page | expectedPage | user  | buttonText                | locator      |
      | pl     | glp  | GLP          | guest | Logowanie / Rejestracja   | WishListIcon |
      | fr     | glp  | GLP          | guest | Se connecter / S’inscrire | WishListIcon |
      | uk     | glp  | GLP          | guest | Sign In / Register        | WishListIcon |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @P2
  @WLP @PDP @TEE @UnifiedPdp @UnifiedExperience @UnifiedExperience
  @feature:CET1-3074
  @tms:UTR-3444 @issue:CET1-3311
  Scenario Outline: Unified Wishlist - Unified Empty wishlist page button redirects to home page when its logged in user
    Given I am on locale <locale> home page with forced accepted cookies
      And I am a <user> user
    When I click on Experience.Header.<locator>
      And I wait for 3 seconds
      And I click on Experience.Wishlist.EmptyWishlistButton with text <buttonText>
    Then I see the current page is Homepage

    Examples:
      | locale | page | expectedPage | user      | buttonText           | locator      |
      | ee     | glp  | GLP          | logged in | Continue Shopping    | WishListIcon |
      | pl     | glp  | GLP          | logged in | Kontynuuj zakupy     | WishListIcon |
      | fr     | glp  | GLP          | logged in | Continuer les achats | WishListIcon |
      | uk     | glp  | GLP          | logged in | Continue Shopping    | WishListIcon |
