Feature: Unified Shopping bag Toast Notification

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @SBToast @UnifiedCheckout @P2
  Scenario Outline: Unified Shopping bag Toast Notification - Returning User should see Toast Notification in all pages except shopping bag
    Given There are 3 product items with 0% discount of locale <locale> with price between 10 and 500 and inventory between 2 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I open a new browser tab
      And I clear session storage item miniBagNotificationSeen and switch to 2nd browser tab
      And I navigate to page <page>
      And I open a new browser tab
      And I clear session storage item miniBagNotificationSeen and switch to 3rd browser tab
      And I navigate to page <page>
    Then I see Experience.ShoppingBagToast.MainBlock is displayed in 10 seconds

    @tms:UTR-13346
    Examples:
      | locale  | langCode | page |
      | default | default  | wlp  |

    @tms:UTR-16548
    Examples:
      | locale           | langCode         | page |
      | multiLangDefault | multiLangDefault | pdp  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @SBToast @UnifiedCheckout @P2
  Scenario Outline: Unified Shopping bag Toast Notification - Returning User should not see toast if returning to shopping bag page
    Given There are 3 product items with 0% discount of locale <locale> with price between 10 and 500 and inventory between 2 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I open a new browser tab
      And I clear session storage item miniBagNotificationSeen and switch to 2nd browser tab
      And I navigate to page <page>
    Then I see Experience.ShoppingBagToast.MainBlock is not displayed in 10 seconds

    @tms:UTR-13347
    Examples:
      | locale  | page         | langCode |
      | default | shopping-bag | default  |

    @tms:UTR-16549
    Examples:
      | locale           | page         | langCode         |
      | multiLangDefault | shopping-bag | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @SBToast @UnifiedCheckout @P2
  Scenario Outline: Unified Shopping bag Toast Notification - Returning User should navigate to shopping bag page when clicking the link
    Given There are 3 product items with 0% discount of locale <locale> with price between 10 and 500 and inventory between 2 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I open a new browser tab
      And I clear session storage item miniBagNotificationSeen and switch to 2nd browser tab
      And I navigate to page <page>
    Then I see Experience.ShoppingBagToast.MainBlock is displayed in 10 seconds
      And I click on Experience.ShoppingBagToast.ShoppingBagLink
      And I wait until the current page is loaded
      And URL should contain "/shopping-bag"

    @tms:UTR-13348
    Examples:
      | locale  | langCode | page |
      | default | default  | pdp  |

    @tms:UTR-16550
    Examples:
      | locale           | langCode         | page |
      | multiLangDefault | multiLangDefault | wlp  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @SBToast @UnifiedCheckout @P2
  Scenario Outline: Unified Shopping bag Toast Notification - Returning User can close the Toast Notification successfully and should not reappear on next visit
    Given There are 3 product items with 0% discount of locale <locale> with price between 10 and 500 and inventory between 2 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I open a new browser tab
      And I clear session storage item miniBagNotificationSeen and switch to 2nd browser tab
      And I navigate to page <page>
    Then I see Experience.ShoppingBagToast.MainBlock is displayed in 10 seconds
      And I click on Experience.ShoppingBagToast.ShoppingBagToastCloseBtn
      And I see Experience.ShoppingBagToast.MainBlock is not displayed in 10 seconds
    When I open a new browser tab
      And I switch to 2nd browser tab
      And I navigate to page <page>
    Then I see Experience.ShoppingBagToast.MainBlock is not displayed in 10 seconds

    @tms:UTR-13349
    Examples:
      | locale  | langCode | page |
      | default | default  | pdp  |

    @tms:UTR-16551
    Examples:
      | locale           | langCode         | page |
      | multiLangDefault | multiLangDefault | wlp  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ShoppingBag @SBToast @UnifiedCheckout @P2
  Scenario Outline: Unified Shopping bag Toast Notification - Returning User can see the Toast Notification only on first page and not on further navigation.
    Given There are 3 product items with 0% discount of locale <locale> with price between 10 and 500 and inventory between 2 and 9999
    When I am on locale <locale> shopping bag page for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I open a new browser tab
      And I clear session storage item miniBagNotificationSeen and switch to 2nd browser tab
      And I navigate to page pdp
    Then I see Experience.ShoppingBagToast.MainBlock is displayed in 10 seconds
    When I navigate to page wlp
      And I wait until the current page is loaded
    Then I see Experience.ShoppingBagToast.MainBlock is not displayed in 10 seconds
    When I navigate to page search-plp
      And I wait until the current page is loaded
    Then I see Experience.ShoppingBagToast.MainBlock is not displayed in 10 seconds

    @tms:UTR-13350
    Examples:
      | locale  | langCode |
      | default | default  |

    @tms:UTR-16552
    Examples:
      | locale           | langCode         |
      | multiLangDefault | multiLangDefault |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @P2 @Translation @Lokalise
  @ShoppingBag @SBToast @UnifiedCheckout
  Scenario Outline: Unified Shopping bag Toast Notification - Returning User should see Toast Notification in all locales
    Given There are 3 product items with 0% discount of locale <locale> with price between 10 and 500 and inventory between 2 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I get translation from lokalise for "ShoppingBagToastText" and store it with key #ToastText
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I open a new browser tab
      And I clear session storage item miniBagNotificationSeen and switch to 2nd browser tab
      And I navigate to page <page>
    Then I see Experience.ShoppingBagToast.ShoppingBagToastText contains text "#ToastText"

    @tms:UTR-13351
    Examples:
      | locale  | langCode | page |
      | default | default  | pdp  |

    @tms:UTR-16554
    Examples:
      | locale           | langCode         | page |
      | multiLangDefault | multiLangDefault | wlp  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @P2
  @ShoppingBag @SBToast @UnifiedCheckout @UnifedTEX
  @feature:TEX-16240
  @tms:UTR-18734
  Scenario Outline: Unified Shopping bag Toast Notification - Returning User should navigate to PDP page when clicking the image on toast notification
    Given There are 3 product items with 0% discount of locale <locale> with price between 10 and 500 and inventory between 2 and 9999
    When I am on locale <locale> shopping bag page of langCode <langCode> for product item product1#skuPartNumber with forced accepted cookies
      And I wait until the count of displayed elements Experience.ShoppingBag.Item is equal to 1
      And I open a new browser tab
      And I clear session storage item miniBagNotificationSeen and switch to 2nd browser tab
      And I navigate to page <page>
    Then I see Experience.ShoppingBagToast.MainBlock is displayed in 10 seconds
    When I click on Experience.ShoppingBagToast.ShoppingBagToastImage
      And I wait until the current page is loaded
    Then I see the current page is PDP
      And in unified PDP I see product info is matched to product style by style colour number product1#styleColourPartNumber

    Examples:
      | locale  | langCode | page |
      | default | default  | glp  |