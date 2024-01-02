Feature: Unified Header - Shopping Bag counter

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Header @ShoppingBagCounter @UnifiedCheckout @P2
  @feature:CET1-3305
  Scenario Outline: Shopping Bag Counter - Verify filled basket
    Given I am on locale <locale> shopping bag page of langCode <langCode> with <number> units of any product with forced accepted cookies
    When I navigate to page <page>
    Then I see Experience.Header.ShoppingBagCounter is displayed
      And I see Experience.Header.ShoppingBagCounter contains text "<number>"

    @tms:UTR-11876
    Examples:
      | locale  | langCode | page | number |
      | default | default  | wlp  | 9      |

    @tms:UTR-16468
    Examples:
      | locale           | langCode         | page         | number |
      | multiLangDefault | multiLangDefault | shopping-bag | 200    |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Header @ShoppingBagCounter @UnifiedCheckout @P2
  @feature:CET1-3305
  Scenario Outline: Shopping Bag Counter - Verify items number is updated
    Given I am on locale <locale> shopping bag page of langCode <langCode> with <number> units of any product with accepted cookies
    When I click on Experience.ShoppingBag.RemoveButton
      And I click on Experience.ShoppingBag.RemoveConfirmButton
      And I wait until Experience.ShoppingBag.EmptyShoppingBagTitle is displayed
      And I navigate to page <page>
    Then I see Experience.Header.ShoppingBagCounter is not displayed in 3 seconds

    @tms:UTR-11875
    Examples:
      | locale  | langCode | page | number |
      | default | default  | pdp  | 1      |

    @tms:UTR-16469
    Examples:
      | locale           | langCode         | page | number |
      | multiLangDefault | multiLangDefault | wlp  | 31     |
