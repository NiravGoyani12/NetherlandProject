Feature: Unified PDP - Find in store functionality

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @FindInStore @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-14586 @ExcludeCK
  Scenario Outline: Find in store - I should see find in store button in PDP for the enabled locales
    Given There is 1 normal size product item with find in store option of locale <locale>
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
      And I extract xcomreg XCOMREG_WTS_CLICK_AND_RESERVE_PHASE saved as #findinStoreToggle
    Then I see the stored value with key #findinStoreToggle is equal to "1"
      And I see ProductDetailPage.FindInStorePopup.FindInStoreButton is displayed
    When I click on ProductDetailPage.FindInStorePopup.FindInStoreButton
    Then I see ProductDetailPage.FindInStorePopup.FindInStoreModal is displayed
    When I click on ProductDetailPage.FindInStorePopup.FindInStoreModalCloseButton
    Then I see ProductDetailPage.FindInStorePopup.FindInStoreModal is not displayed in 2 seconds

    Examples:
      | locale |
      | de     |
      | nl     |
      | uk     |
      | ie     |
      | it     |
      | fr     |
      | be     |
      | dk     |
      | at     |
      | lu     |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @FindInStore @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-15333 @ExcludeCK
  Scenario Outline: Find in store - For normal size product with FiS option I should see the store results by searching with location
    Given There is 1 normal size product item with find in store option of locale <locale>
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
      And I extract product item detail by sku part number product1#skuPartNumber
      And I wait until the current page is loaded
      And in unified PDP I select size by sku part number product1#skuPartNumber
      And I click on ProductDetailPage.FindInStorePopup.FindInStoreButton
    Then I see ProductDetailPage.FindInStorePopup.FindInStoreModal is displayed
    When I type "<findStoreLocation>" in the field ProductDetailPage.FindInStorePopup.SearchLocation
      And I wait until ProductDetailPage.FindInStorePopup.GoogleMaps is displayed in 5 seconds
      And I click on ProductDetailPage.FindInStorePopup.SubmitAddress
    Then I see ProductDetailPage.FindInStorePopup.StorePinsOnMap is displayed
      And I see ProductDetailPage.FindInStorePopup.SearchResultsList is displayed
      And I see ProductDetailPage.FindInStorePopup.FindInStoreLocations with index 1 is displayed
      And I see ProductDetailPage.FindInStorePopup.StoreLocationName with index 1 is displayed
      And I see ProductDetailPage.FindInStorePopup.StoreLocationAddress with index 1 is displayed
      And I see ProductDetailPage.FindInStorePopup.StoreOpenHours is displayed
      And I see ProductDetailPage.FindInStorePopup.ShowDirections with index 1 is displayed

    Examples:
      | locale | findStoreLocation |
      | uk     | London            |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari
  @FindInStore @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-16029 @ExcludeCK
  Scenario Outline: Find in store - Mobile - For normal size product with FiS option I should see the store results by searching with location
    Given There is 1 normal size product item with find in store option of locale <locale>
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
      And I extract product item detail by sku part number product1#skuPartNumber
      And I wait until the current page is loaded
      And in unified PDP I select size by sku part number product1#skuPartNumber
      And I click on ProductDetailPage.FindInStorePopup.FindInStoreButton
    Then I see ProductDetailPage.FindInStorePopup.FindInStoreModal is displayed
    When I type "<findStoreLocation>" in the field ProductDetailPage.FindInStorePopup.SearchLocation
      And I click on ProductDetailPage.FindInStorePopup.SubmitAddress until ProductDetailPage.FindInStorePopup.SearchResultsList is displayed
    Then I see ProductDetailPage.FindInStorePopup.FindInStoreLocations with index 1 is displayed
      And I see ProductDetailPage.FindInStorePopup.StoreLocationName with index 1 is displayed
      And I see ProductDetailPage.FindInStorePopup.StoreLocationAddress with index 1 is displayed
      And I see ProductDetailPage.FindInStorePopup.StoreOpenHours is displayed
      And I see ProductDetailPage.FindInStorePopup.ShowDirections with index 1 is displayed

    Examples:
      | locale | findStoreLocation |
      | uk     | London            |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @FindInStore @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-16030 @ExcludeCK
  Scenario Outline: Find in store - With FiS option I should see the store results with use my location option
    Given There are 5 one size product item with find in store option of locale <locale>
    When I am on locale <locale> pdp page for product style product3#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
      And I click on ProductDetailPage.FindInStorePopup.FindInStoreButton
    Then I see ProductDetailPage.FindInStorePopup.FindInStoreModal is displayed
      And I wait until ProductDetailPage.FindInStorePopup.GoogleMaps is displayed
    When I click on ProductDetailPage.FindInStorePopup.UseMyLocationButton until ProductDetailPage.FindInStorePopup.StorePinsOnMap is displayed
    Then I see ProductDetailPage.FindInStorePopup.SearchResultsList is displayed
    When I store the numeric value of ProductDetailPage.FindInStorePopup.SearchResultCount with key #expectedStoreCount
    Then the count of elements ProductDetailPage.FindInStorePopup.StorePinsOnMap is equal to #expectedStoreCount

    Examples:
      | locale |
      | nl     |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @FindInStore @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-16031 @ExcludeCK
  Scenario Outline: Find in store - For normal size product with FiS option I should see the size can be changed while searching for the stock in store
    Given There are 5 normal size product item with find in store option of locale <locale>
    When I am on locale <locale> pdp page for product style product3#styleColourPartNumber with accepted cookies
      And I extract product item detail by sku part number product3#skuPartNumber
      And I wait until the current page is loaded
      And in unified PDP I select size by sku part number product3#skuPartNumber
      And I fetch size name of product item product3#skuPartNumber saved as #sizeName
      And I click on ProductDetailPage.FindInStorePopup.FindInStoreButton
    Then I see ProductDetailPage.FindInStorePopup.FindInStoreModal is displayed
    When I type "<findStoreLocation>" in the field ProductDetailPage.FindInStorePopup.SearchLocation
      And I wait until ProductDetailPage.FindInStorePopup.GoogleMaps is displayed
      And I click on ProductDetailPage.FindInStorePopup.SubmitAddress until ProductDetailPage.FindInStorePopup.StorePinsOnMap is displayed
    Then I see ProductDetailPage.FindInStorePopup.SelectedSize with text #sizeName is displayed
    When I click on ProductDetailPage.FindInStorePopup.ChangeSize
      And I click on ProductDetailPage.FindInStorePopup.PreviouslyNotSelectedSizeButton
      And I type "<findStoreLocation>" in the field ProductDetailPage.FindInStorePopup.SearchLocation
      And I wait until ProductDetailPage.FindInStorePopup.GoogleMaps is displayed in 5 seconds
      And I click on ProductDetailPage.FindInStorePopup.SubmitAddress
    Then I see ProductDetailPage.FindInStorePopup.StorePinsOnMap is displayed

    Examples:
      | locale | findStoreLocation |
      | uk     | London            |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari @Translation @Lokalise
  @FindInStore @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-16032 @ExcludeCK
  Scenario Outline: Find in store - With FiS option I should see the error message when I don't select the location
    Given There are 5 one size product item with find in store option of locale <locale>
    When I am on locale <locale> pdp page for product style product3#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
      And I get translation from lokalise for "StoreSearchInvalidAddress" and store it with key #StoreSearchInvalidAddress
      And I click on ProductDetailPage.FindInStorePopup.FindInStoreButton
    Then I see ProductDetailPage.FindInStorePopup.FindInStoreModal is displayed
    When I wait until ProductDetailPage.FindInStorePopup.GoogleMaps is displayed
      And I click on ProductDetailPage.FindInStorePopup.SubmitAddress
    Then I see ProductDetailPage.FindInStorePopup.StoreSearchError with text #StoreSearchInvalidAddress is displayed

    Examples:
      | locale |
      | nl     |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @FindInStore @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-16667 @ExcludeCK
  Scenario Outline: Find in store - In FiS Modal, I should be able to use the option to filter the stores with stock
    Given There are 5 one size product item with find in store option of locale <locale>
    When I am on locale <locale> pdp page for product style product3#styleColourPartNumber with accepted cookies
      And I wait until the current page is loaded
      And I click on ProductDetailPage.FindInStorePopup.FindInStoreButton
    Then I see ProductDetailPage.FindInStorePopup.FindInStoreModal is displayed
    When I wait until ProductDetailPage.FindInStorePopup.GoogleMaps is displayed
      And I click on ProductDetailPage.FindInStorePopup.UseMyLocationButton until ProductDetailPage.FindInStorePopup.StorePinsOnMap is displayed
    Then I see ProductDetailPage.FindInStorePopup.SearchResultsList is displayed
    When I store the numeric value of ProductDetailPage.FindInStorePopup.SearchResultCount with key #expectedStoreCount
      And I click on ProductDetailPage.FindInStorePopup.StoresWithStockFilter
      And I store the numeric value of ProductDetailPage.FindInStorePopup.SearchResultCount with key #expectedStoreCount1
    Then I see the stored value with key #expectedStoreCount1 is less or equal than the stored value with key #expectedStoreCount

    Examples:
      | locale |
      | nl     |