Feature: Unified Add to Bag PopUp

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @P2
  @AddToBagPopUp @UnifiedCheckout @Wishlist @AddToBagPopUp
  Scenario Outline: Unified Add to Bag - Verfiy that the user is able to see added to bag popup and its component from wishlist page
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 10 and 99999 filtered by FH
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> wish list page of langCode <langCode> for product styles product1#styleColourPartNumber
      And I wait for 2 seconds
      And I see the current page is wlp
      And I get translation from lokalise for "Color" and store it with key #Color
      And I get translation from lokalise for "Size" and store it with key #Size
      And I get translation from lokalise for "Quantity" and store it with key #Quantity
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
    When I fetch size name of product item #skuPartNumber saved as #sizeName
    Then I see Experience.Wishlist.DisabledAddToBagButton is displayed
    When in unified wishlist page I select size based on product item #skuPartNumber
    Then I click on Experience.Wishlist.EnabledAddToBagButton
      And I wait until Experience.AddToBagPopUp.MainBlock is displayed
      And I see Experience.AddToBagPopUp.ItemAtrribute with text #Color is displayed
      And I see Experience.AddToBagPopUp.ItemAtrribute with text #Size is displayed
      And I see Experience.AddToBagPopUp.ItemAtrribute with text #Quantity is displayed
      And I see following elements are displayed
      | element                                 | args |
      | Experience.AddToBagPopUp.ImageContainer |      |
      | Experience.AddToBagPopUp.PriceSelling   |      |
      | Experience.AddToBagPopUp.ItemTitle      |      |
      | Experience.AddToBagPopUp.CloseButton    |      |

    @tms:UTR-7777
    Examples:
      | locale  | langCode | userType  |
      | default | default  | logged in |

    @tms:UTR-15729
    Examples:
      | locale           | langCode         | userType |
      | multiLangDefault | multiLangDefault | guest    |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @AddToBagPopUp @UnifiedCheckout
  Scenario Outline: Unified Add to Bag - Verfiy that the user is able to close the add to bag popup using cross icon
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 10 and 99999 filtered by FH
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> wish list page of langCode <langCode> for product styles product1#styleColourPartNumber
      And I wait for 2 seconds
      And I see the current page is wlp
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
    When I fetch size name of product item #skuPartNumber saved as #sizeName
    Then I see Experience.Wishlist.DisabledAddToBagButton is displayed
    When in unified wishlist page I select size based on product item #skuPartNumber
      And I click on Experience.Wishlist.EnabledAddToBagButton
      And I wait until Experience.AddToBagPopUp.MainBlock is displayed
      And I click on Experience.AddToBagPopUp.CloseButton
      And I see Experience.AddToBagPopUp.MainBlock is not displayed in 1 second

    @tms:UTR-7776
    Examples:
      | locale  | langCode | userType  |
      | default | default  | logged in |

    @tms:UTR-16422
    Examples:
      | locale           | langCode         | userType |
      | multiLangdefault | multiLangDefault | guest    |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @AddToBagPopUp @UnifiedCheckout
  Scenario Outline: Unified Add to Bag - Verfiy that the user is able to striked down price in the add to bag popup
    Given There is 1 discounted product item of locale <locale> and langCode <langCode> with inventory between 20 and 99999
      And I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> wish list page of langCode <langCode> for product styles product1#styleColourPartNumber with forced accepted cookies
      And I navigate to page wlp
      And I wait for 2 seconds
      And I see the current page is wlp
      And I extract a product item from product style product1#styleColourPartNumber which has inventory saved as #skuPartNumber
    When I fetch size name of product item #skuPartNumber saved as #sizeName
    Then I see Experience.Wishlist.DisabledAddToBagButton is displayed
    When in unified wishlist page I select size based on product item #skuPartNumber
    Then I click on Experience.Wishlist.EnabledAddToBagButton
      And I wait until Experience.AddToBagPopUp.MainBlock is displayed
      And I wait until Experience.AddToBagPopUp.PriceWas is displayed

    @tms:UTR-7778
    Examples:
      | locale  | langCode | userType  |
      | default | default  | logged in |

    @tms:UTR-16423
    Examples:
      | locale           | langCode         | userType |
      | multiLangDefault | multiLangDefault | guest    |
