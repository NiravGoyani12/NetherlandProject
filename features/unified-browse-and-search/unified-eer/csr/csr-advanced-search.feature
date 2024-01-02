Feature: CSR - Advanced Search

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  Scenario Outline: Csr user can see results when searching using textbox with valid data
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I click on Csr.SearchPage.AdvancedSearchButton
    When I type "<text>" in the empty field Csr.SearchPage.<inputField>
      And I clear text field of element Csr.SearchPage.DatePickerFromInput
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "08/05/2023"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTableOrderIDColumn is displayed in 10 seconds
    When I click on Csr.SearchPage.SearchResultTableOrderIDColumn
    Then I see Csr.OrderDetailsPage.<orderDetails> contains text "<text>" is displayed

    @tms:UTR-18076
    Examples:
      | inputField     | text | orderDetails |
      | FirstNameInput | John | OrderAddress |

    @tms:UTR-18077
    Examples:
      | inputField   | text       | orderDetails |
      | AddressInput | Teststreet | OrderAddress |

    @tms:UTR-18078
    Examples:
      | inputField | text   | orderDetails |
      | CityInput  | London | OrderAddress |

    @tms:UTR-18079
    Examples:
      | inputField    | text  | orderDetails |
      | PostCodeInput | 10178 | OrderAddress |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  @tms:UTR-11742
  Scenario: Csr user can see results when searching with valid promo code
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I click on Csr.SearchPage.AdvancedSearchButton
      And I get csr search data for "promoCode" and store it with key #PromoCode
      And I wait until Csr.SearchPage.PromocodeInput is clickable
    When I type "#PromoCode" in the empty field Csr.SearchPage.PromocodeInput
      And I clear text field of element Csr.SearchPage.DatePickerFromInput
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "08/05/2023"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTableOrderIDColumn is displayed in 10 seconds
    When I click on Csr.SearchPage.SearchResultTableOrderIDColumn
    Then I see Csr.OrderDetailsPage.OrderPromocodeDetails contains text "#PromoCode" is displayed

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  Scenario Outline: Csr user can see results when searching with valid data in dropdown
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I click on Csr.SearchPage.AdvancedSearchButton
    When in dropdown Csr.SearchPage.<inputField> I select the option by text "<text>"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTableOrderIDColumn is displayed in 10 seconds
      And I see Csr.SearchPage.<orderDetails> contains text "<text>" is displayed

    @tms:UTR-11735
    Examples:
      | inputField      | text | orderDetails                   |
      | CountryDropdown | GB   | SearchResultTableCountryColumn |

    @tms:UTR-11728
    Examples:
      | inputField          | text                 | orderDetails                  |
      | OrderStatusDropdown | Shipped and Captured | SearchResultTableStatusColumn |

    @tms:UTR-11721
    Examples:
      | inputField            | text | orderDetails                         |
      | PaymentMethodDropdown | VISA | SearchResultTablePaymentMethodColumn |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER
  @tms:UTR-11745 @P2 @ExcludeSIT
  Scenario: Csr user can see results when searching with valid dates
    Given I am in csr main of locale default and langCode default with L3 csr account with forced accepted cookies
      And I click on Csr.SearchPage.AdvancedSearchButton
      And I click on Csr.SearchPage.SearchButton
    Then I see the count of displayed elements Csr.SearchPage.SearchResultTableOrderDateColumn is greater than 1 in 10 seconds

  #TODO: This can't be runned on dB0 because we don't have SAP to proccess orders
  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2  @ExcludeSIT
  @tms:UTR-11727
  Scenario: Csr user can see results when searching with ReturnID
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I wait until the current page is loaded
      And I click on Csr.SearchPage.AdvancedSearchButton
      And I get csr search data for "returnId" and store it with key #returnId
      And I wait until Csr.SearchPage.WCSReturnNumberInput is clickable
    When I type "#returnId" in the empty field Csr.SearchPage.WCSReturnNumberInput
      And I clear text field of element Csr.SearchPage.DatePickerFromInput
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "12/09/2023"
      And I click on Csr.SearchPage.SearchButton
    Then I see the count of displayed elements Csr.SearchPage.SearchResultTableReturnIdColumn is equal to 1 in 10 seconds
      And I see Csr.SearchPage.SearchResultTableReturnIdColumn contains text "#returnId"

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-15132
  Scenario: Csr user can see error message when search with invalid parameters
    Given I am in csr main of locale default and langCode default with L3 csr account with forced accepted cookies
      And I click on Csr.SearchPage.AdvancedSearchButton
      And I type to following inputs
      | element                     | value              |
      | Csr.SearchPage.OrderIdInput | abc                |
      | Csr.SearchPage.EmailInput   | pvhecomtest001@Csr @UnifiedExperience |
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "12//1"
      And in datepicker Csr.SearchPage.DatePickerToInput I type date "04/05/2031"
      And I click on Csr.SearchPage.SearchButton
    Then the count of elements Csr.SearchPage.InputError is equal to 4

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-15133
  Scenario: Csr user can use pagination when using advanced search with valid data
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I click on Csr.SearchPage.AdvancedSearchButton
      And I wait for 1 second
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is displayed in 10 seconds
      And the count of displayed elements Csr.SearchPage.SearchResultTableOrderIDColumn is equal to 10
      And I store the value of Csr.SearchPage.SearchResultTableOrderIDColumn with key #orderNumber1
      And I see the count of displayed elements Csr.SearchPage.PageNumber is equal to 5
      And I see Csr.SearchPage.PageNumber with text > is displayed
      And I see Csr.SearchPage.PageNumber with text < is not displayed
    When I click on Csr.SearchPage.PageNumber with text 3
    Then I see Csr.SearchPage.PageNumberInput with text 3 is displayed in 10 seconds
      And the count of displayed elements Csr.SearchPage.SearchResultTableOrderIDColumn is equal to 10
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should not be equal to the stored value with key #orderNumber1
      And I store the value of Csr.SearchPage.SearchResultTableOrderIDColumn with key #orderNumber3
      And I see Csr.SearchPage.PageNumber with text < is displayed
    When I click on Csr.SearchPage.PageNumber with text >
    Then I see Csr.SearchPage.PageNumberInput with text 4 is displayed in 10 seconds
      And the count of displayed elements Csr.SearchPage.SearchResultTableOrderIDColumn is equal to 10
      And I store the value of Csr.SearchPage.SearchResultTableOrderIDColumn with key #orderNumber4
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should not be equal to the stored value with key #orderNumber1
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should not be equal to the stored value with key #orderNumber3
      And I see Csr.SearchPage.PageNumber with text > is displayed
    When I click on Csr.SearchPage.PageNumber with text <
    Then I see Csr.SearchPage.PageNumberInput with text 3 is displayed in 10 seconds
      And the count of displayed elements Csr.SearchPage.SearchResultTableOrderIDColumn is equal to 10
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should be equal to the stored value with key #orderNumber3
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should not be equal to the stored value with key #orderNumber4
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should not be equal to the stored value with key #orderNumber1
      And I see Csr.SearchPage.PageNumber with text > is displayed
      And I see Csr.SearchPage.PageNumber with text < is displayed
      And I see Csr.SearchPage.PageNumber with text 1 is not displayed
      And I see Csr.SearchPage.PageNumber with text 2 is not displayed
    When I click on Csr.SearchPage.PageNumberInput
      And I press key Backspace on the keyboard
      And I type "1" in the empty field Csr.SearchPage.PageNumberInput
      And I click on Csr.SearchPage.GoButton
    Then the count of displayed elements Csr.SearchPage.SearchResultTableOrderIDColumn is equal to 10 in 5 seconds
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should be equal to the stored value with key #orderNumber1
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should not be equal to the stored value with key #orderNumber3
      And I see the value of Csr.SearchPage.SearchResultTableOrderIDColumn should not be equal to the stored value with key #orderNumber4
      And I see Csr.SearchPage.PageNumber with text < is not displayed
      And I see Csr.SearchPage.PageNumber with text > is displayed

  @FullRegression
  @Desktop
  @Chrome @P2
  @Csr @UnifiedExperience @EER
  Scenario Outline: Csr user can see no results when searching with invalid data
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I click on Csr.SearchPage.AdvancedSearchButton
    When I type "<text>" in the empty field Csr.SearchPage.<inputField>
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 10 seconds

      @tms:UTR-11724
    Examples:
      | inputField     | text              |
      | FirstNameInput | 123               |
      | FirstNameInput | $@@               |
      | FirstNameInput | abcdefghijklmnopq |

    @tms:UTR-11747
    Examples:
      | inputField    | text              |
      | LastNameInput | 123               |
      | LastNameInput | $@@               |
      | LastNameInput | abcdefghijklmnopq |

    @tms:UTR-11725
    Examples:
      | inputField   | text       |
      | AddressInput | $          |
      | AddressInput | 1234567890 |

    @tms:UTR-11722
    Examples:
      | inputField | text        |
      | CityInput  | 123         |
      | CityInput  | $@@         |
      | CityInput  | abcdefg1234 |

    @tms:UTR-11726
    Examples:
      | inputField    | text        |
      | PostCodeInput | $@#         |
      | PostCodeInput | 21234575645 |
      | PostCodeInput | abcdvljdvja |

    @tms:UTR-11729
    Examples:
      | inputField           | text         |
      | WCSReturnNumberInput | 123          |
      | WCSReturnNumberInput | @@@          |
      | WCSReturnNumberInput | ahgdsshadgsj |

    @tms:UTR-11730
    Examples:
      | inputField     | text |
      | PromocodeInput | ABC  |
      | PromocodeInput | 123  |
      | PromocodeInput | $    |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-15134
  Scenario Outline: CSR: Close and opening advanced search do not clear the search results
    Given I am in csr main of locale default and langCode default with L3 csr account with forced accepted cookies
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I type "<firstName>" in the empty field Csr.SearchPage.FirstNameInput
      And I store the value of Csr.SearchPage.FirstNameInput with key #firstname
      And I type "<lastName>" in the empty field Csr.SearchPage.LastNameInput
      And I store the value of Csr.SearchPage.LastNameInput with key #lastname
      And I type "<address>" in the empty field Csr.SearchPage.AddressInput
      And I store the value of Csr.SearchPage.AddressInput with key #address
      And I type "<city>" in the empty field Csr.SearchPage.CityInput
      And I store the value of Csr.SearchPage.CityInput with key #city
      And I type "<postCode>" in the empty field Csr.SearchPage.PostCodeInput
      And I store the value of Csr.SearchPage.PostCodeInput with key #pcode
      And in dropdown Csr.SearchPage.CountryDropdown I select the option by text "<country>"
      And I store the value of Csr.SearchPage.CountryDropdownText with key #country
      And I get csr search data for "order_status" and store it with key #OrderStatus
      And in dropdown Csr.SearchPage.OrderStatusDropdown I select the option by text "#OrderStatus"
      And I store the value of Csr.SearchPage.OrderStatusText with key #status
      And in dropdown Csr.SearchPage.PaymentMethodDropdown I select the option by text "<paymentMethod>"
      And I store the value of Csr.SearchPage.PaymentMethodText with key #paymentMethod
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultText is displayed in 10 seconds
      And I store the value of Csr.SearchPage.SearchResultText with key #searchText
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I wait for 2 seconds
      And I click on Csr.SearchPage.AdvancedSearchButton
    Then I see the value of Csr.SearchPage.FirstNameInput should be equal to the stored value with key #firstname
      And I see the value of Csr.SearchPage.LastNameInput should be equal to the stored value with key #lastname
      And I see the value of Csr.SearchPage.AddressInput should be equal to the stored value with key #address
      And I see the value of Csr.SearchPage.CityInput should be equal to the stored value with key #city
      And I see the value of Csr.SearchPage.PostCodeInput should be equal to the stored value with key #pcode
      And I see the value of Csr.SearchPage.CountryDropdownText should be equal to the stored value with key #country
      And I see the value of Csr.SearchPage.OrderStatusText should be equal to the stored value with key #status
      And I see the value of Csr.SearchPage.PaymentMethodText should be equal to the stored value with key #paymentMethod
      And the value of Csr.SearchPage.SearchResultText should be equal to the stored value with key #searchText

    Examples:
      | firstName | lastName | address       | city   | postCode | country | paymentMethod |
      | Johan     | Sap      | Teststreet 15 | London | DE23 3UT | GB      | Master Card   |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-11736
  Scenario Outline: Csr user can see results when searching with emailId, country and Order status
    Given I am in csr main of locale default and langCode default with L3 csr account with forced accepted cookies
    When I type "pvh.qa.automation@gmail.com" in the empty field Csr.SearchPage.EmailInput
      And I store the value of Csr.SearchPage.EmailInput with key #emailid
      And I click on Csr.SearchPage.AdvancedSearchButton
      And in dropdown Csr.SearchPage.CountryDropdown I select the option by text "<country>"
      And I store the value of Csr.SearchPage.CountryDropdownText with key #country
      And in dropdown Csr.SearchPage.OrderStatusDropdown I select the option by text "<status>"
      And I store the value of Csr.SearchPage.OrderStatusText with key #status
      And I clear text field of element Csr.SearchPage.DatePickerFromInput
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "08/05/2023"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTableOrderIDColumn is displayed in 15 seconds
      And I see the value of Csr.SearchPage.SearchResultTableEmailColumn should contain the stored value with key #emailid
      And I see the value of Csr.SearchPage.SearchResultTableCountryColumn should contain the stored value with key #country
      And I see the value of Csr.SearchPage.SearchResultTableStatusColumn should contain the stored value with key #status

    Examples:
      | country | status    |
      | DE      | Cancelled |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-11739
  Scenario: CSR user can see all the available list of countries present in the country dropdown list
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I click on Csr.SearchPage.AdvancedSearchButton
    When I click on Csr.SearchPage.CountryDropdown
      And I get csr search data for "countrylist_count" and store it with key #NumberofCountries
    Then I see the count of elements Csr.SearchPage.CountryDropdownListCount is equal to #NumberofCountries

  @FullRegression
  @Desktop
  @Chrome
  @Csr @EER @P3 @UnifiedExperience
  @tms:UTR-1474 @ExcludeUat
  Scenario Outline: Csr user can see all the search data and the enter data is cleared when clicked on clear button
    Given I am in csr main of locale default and langCode default with L1 csr account with forced accepted cookies
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I type "<firstName>" in the empty field Csr.SearchPage.FirstNameInput
      And I store the value of Csr.SearchPage.FirstNameInput with key #firstname
      And I type "<lastName>" in the empty field Csr.SearchPage.LastNameInput
      And I store the value of Csr.SearchPage.LastNameInput with key #lastname
      And I type "<address>" in the empty field Csr.SearchPage.AddressInput
      And I store the value of Csr.SearchPage.AddressInput with key #address
      And I type "<city>" in the empty field Csr.SearchPage.CityInput
      And I store the value of Csr.SearchPage.CityInput with key #city
      And I type "<postCode>" in the empty field Csr.SearchPage.PostCodeInput
      And I store the value of Csr.SearchPage.PostCodeInput with key #pcode
      And in dropdown Csr.SearchPage.CountryDropdown I select the option by text "<country>"
      And I store the value of Csr.SearchPage.CountryDropdownText with key #country
      And in dropdown Csr.SearchPage.OrderStatusDropdown I select the option by text "<status>"
      And I store the value of Csr.SearchPage.OrderStatusText with key #status
      And in dropdown Csr.SearchPage.PaymentMethodDropdown I select the option by text "<paymentMethod>"
      And I store the value of Csr.SearchPage.PaymentMethodText with key #paymentMethod
      And I clear text field of element Csr.SearchPage.DatePickerFromInput
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "01/06/2023"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultText is displayed in 10 seconds
      And I store the value of Csr.SearchPage.SearchResultText with key #searchText
      And I see Csr.SearchPage.SearchResultTableOrderIDColumn is displayed in 10 seconds
      And I see Csr.SearchPage.SearchResultTableEmailColumn is displayed
      And I see the value of Csr.SearchPage.SearchResultTableCountryColumn should contain the stored value with key #country
      And I see the value of Csr.SearchPage.SearchResultTableStatusColumn should contain the stored value with key #status
      And I see the value of Csr.SearchPage.SearchResultTablePaymentMethodColumn should contain the stored value with key #paymentMethod
    When I click on Csr.SearchPage.ClearButton
    Then I see the attribute value of element Csr.SearchPage.FirstNameInput not containing "#firstname"
      And I see the attribute value of element Csr.SearchPage.LastNameInput not containing "#lastname"
      And I see the attribute value of element Csr.SearchPage.AddressInput not containing "#address"
      And I see the attribute value of element Csr.SearchPage.CityInput not containing "#city"
      And I see the attribute value of element Csr.SearchPage.PostCodeInput not containing "#pcode"
      And I see the attribute value of element Csr.SearchPage.CountryDropdownText not containing "#country"
      And I see the attribute value of element Csr.SearchPage.OrderStatusText not containing "#status"
      And I see the attribute value of element Csr.SearchPage.PaymentMethodText not containing "#paymentMethod"
      And I see the attribute value of element Csr.SearchPage.SearchResultText not containing "#searchText"

    Examples:
      | firstName | lastName | address   | city    | postCode | country | status               | paymentMethod |
      | Boris     | Bear     | Vodkalane | Smirnov | WD19 6RR | GB      | Shipped and Captured | VISA          |

  @FullRegression
  @Desktop
  @Chrome
  @Csr @EER @P3 @UnifiedExperience
  @tms:UTR-1476 @ExcludeUat
  Scenario Outline: Csr user can see only one result when searching with returnId and valid parameters
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I type "<firstName>" in the empty field Csr.SearchPage.FirstNameInput
      And I type "<lastName>" in the empty field Csr.SearchPage.LastNameInput
      And I type "<address>" in the empty field Csr.SearchPage.AddressInput
      And I type "<city>" in the empty field Csr.SearchPage.CityInput
      And I type "<postCode>" in the empty field Csr.SearchPage.PostCodeInput
      And I type "<returnId>" in the empty field Csr.SearchPage.WCSReturnNumberInput
      And in dropdown Csr.SearchPage.CountryDropdown I select the option by text "<country>"
      And in dropdown Csr.SearchPage.OrderStatusDropdown I select the option by text "<status>"
      And I clear text field of element Csr.SearchPage.DatePickerFromInput
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "23/05/2022"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is displayed
      And I see the count of displayed elements Csr.SearchPage.SearchResultTableReturnIdColumn is equal to 1 in 10 seconds
      And I see Csr.SearchPage.SearchResultTableReturnIdColumn contains text "<returnId>"

    @ExcludeTH
    Examples:
      | firstName | lastName   | address      | city   | postCode | country | status    | returnId |
      | Zbykidco  | Ajzrpufock | GokTTKHebFqU | RIscSO | 10178    | DE      | Cancelled | 10104503 |

    @ExcludeCK
    Examples:
      | firstName     | lastName      | address                 | city    | postCode | country | status    | returnId |
      | kumara sankar | balasubramani | 89 Catalonia apartments | watford | 1111 VB  | NL      | Cancelled | 10106022 |

  #TODO: Can't make a return for an order without SAP which dB0 doesn't have
  @FullRegression
  @Desktop
  @Chrome
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-11734
  Scenario: Csr user can see the order status as Shipped and captured in result table when searching with valid returnid
    Given I am in csr main of locale default and langCode default with L3 csr account with forced accepted cookies
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I get csr search data for "returnId" and store it with key #returnId
      And I wait until Csr.SearchPage.WCSReturnNumberInput is clickable
      And I type "#returnId" in the empty field Csr.SearchPage.WCSReturnNumberInput
      And I clear text field of element Csr.SearchPage.DatePickerFromInput
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "23/05/2022"
      And I clear text field of element Csr.SearchPage.DatePickerToInput
      And in datepicker Csr.SearchPage.DatePickerToInput I type date "10/08/2023"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is displayed in 10 seconds
      And I see Csr.SearchPage.SearchResultTableReturnIdColumn contains text "#returnId"
      And I see Csr.SearchPage.SearchResultTableStatusColumn with text Shipped and Captured is displayed

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-11740
  Scenario Outline: Csr user can see results when searching with multiple valid data firstname, lastname, address, city, postcode, country, order status and payment method
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I type "<firstName>" in the empty field Csr.SearchPage.FirstNameInput
      And I store the value of Csr.SearchPage.FirstNameInput with key #firstname
      And I type "<lastName>" in the empty field Csr.SearchPage.LastNameInput
      And I store the value of Csr.SearchPage.LastNameInput with key #lastname
      And I type "<address>" in the empty field Csr.SearchPage.AddressInput
      And I store the value of Csr.SearchPage.AddressInput with key #address
      And I type "<city>" in the empty field Csr.SearchPage.CityInput
      And I store the value of Csr.SearchPage.CityInput with key #city
      And I type "<postCode>" in the empty field Csr.SearchPage.PostCodeInput
      And I store the value of Csr.SearchPage.PostCodeInput with key #pcode
      And in dropdown Csr.SearchPage.CountryDropdown I select the option by text "<country>"
      And I store the value of Csr.SearchPage.CountryDropdownText with key #country
      And in dropdown Csr.SearchPage.OrderStatusDropdown I select the option by text "<status>"
      And I store the value of Csr.SearchPage.OrderStatusText with key #status
      And I get csr search data for "payment_method" and store it with key #PaymentMethod
      And in dropdown Csr.SearchPage.PaymentMethodDropdown I select the option by text "#PaymentMethod"
      And I store the value of Csr.SearchPage.PaymentMethodText with key #paymentMethod
      And I clear text field of element Csr.SearchPage.DatePickerFromInput
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "04/01/2023"
      And I clear text field of element Csr.SearchPage.DatePickerToInput
      And in datepicker Csr.SearchPage.DatePickerToInput I type date "26/06/2023"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultText is displayed in 10 seconds
      And I see Csr.SearchPage.SearchResultTableOrderIDColumn is displayed in 10 seconds
      And I see the value of Csr.SearchPage.SearchResultTableCountryColumn should contain the stored value with key #country
      And I see the value of Csr.SearchPage.SearchResultTableStatusColumn should contain the stored value with key #status
      And I see the value of Csr.SearchPage.SearchResultTablePaymentMethodColumn should contain the stored value with key #paymentMethod
    When I click on Csr.SearchPage.SearchResultTableOrderIDColumn
    Then I see Csr.OrderDetailsPage.OrderNumberHeader with text #OrderId is displayed
      And I see Csr.OrderDetailsPage.OrderAddress with text #firstname is displayed
      And I see Csr.OrderDetailsPage.OrderAddress with text #lastname is displayed
      And I see Csr.OrderDetailsPage.OrderAddress with text #address is displayed
      And I see Csr.OrderDetailsPage.OrderAddress with text #city is displayed
      And I see Csr.OrderDetailsPage.OrderAddress with text #pcode is displayed

    Examples:
      | firstName | lastName | address      | city | postCode | country | status    |
      | John      | Doe        | NIEUWE NIEUWSTRAAT 26 | AMSTERDAM  | 1012 NH  | NL      | Cancelled |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-11750
  Scenario Outline: Csr user can see no results found message when searching with multiple invalid data firstname, lastname, address, city, postcode and promocode
    Given I am in csr main of locale default and langCode default with L1 csr account with forced accepted cookies
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I type "<firstName>" in the empty field Csr.SearchPage.FirstNameInput
      And I type "<lastName>" in the empty field Csr.SearchPage.LastNameInput
      And I type "<address>" in the empty field Csr.SearchPage.AddressInput
      And I type "<city>" in the empty field Csr.SearchPage.CityInput
      And I type "<postCode>" in the empty field Csr.SearchPage.PostCodeInput
      And I type "<promoCode>" in the empty field Csr.SearchPage.PromocodeInput
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 10 seconds

    Examples:
      | firstName | lastName | address    | city | postCode | promoCode   |
      | 1245      | 1@ss     | 1234567890 | C@$t | 1015@@   | INVALIDCODE |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-11749
  Scenario Outline: Csr user can see no results found message when searching with multiple valid data firstname, lastname, address, city, postcode, country, order status, payment method and invalid Promocode
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I type "<firstName>" in the empty field Csr.SearchPage.FirstNameInput
      And I type "<lastName>" in the empty field Csr.SearchPage.LastNameInput
      And I type "<address>" in the empty field Csr.SearchPage.AddressInput
      And I type "<city>" in the empty field Csr.SearchPage.CityInput
      And I type "<postCode>" in the empty field Csr.SearchPage.PostCodeInput
      And in dropdown Csr.SearchPage.CountryDropdown I select the option by text "<country>"
      And in dropdown Csr.SearchPage.OrderStatusDropdown I select the option by text "<status>"
      And in dropdown Csr.SearchPage.PaymentMethodDropdown I select the option by text "<paymentMethod>"
      And I type "<promoCode>" in the empty field Csr.SearchPage.PromocodeInput
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 10 seconds

    Examples:
      | firstName | lastName | address    | city | postCode | country | status               | paymentMethod | promoCode   |
      | Johan     | Sap      | Teststreet | Gent | 1015     | BE      | Shipped and Captured | VISA          | INVALIDCODE |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-11746
  Scenario Outline: Csr user can see no results found message when searching with multiple valid data lastname, address, city, postcode, country, order status, payment method, promocode and invalid firstname
    Given I am in csr main of locale default and langCode default with L3 csr account with forced accepted cookies
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I type "<firstName>" in the empty field Csr.SearchPage.FirstNameInput
      And I type "<lastName>" in the empty field Csr.SearchPage.LastNameInput
      And I type "<address>" in the empty field Csr.SearchPage.AddressInput
      And I type "<city>" in the empty field Csr.SearchPage.CityInput
      And I type "<postCode>" in the empty field Csr.SearchPage.PostCodeInput
      And in dropdown Csr.SearchPage.CountryDropdown I select the option by text "<country>"
      And in dropdown Csr.SearchPage.OrderStatusDropdown I select the option by text "<status>"
      And in dropdown Csr.SearchPage.PaymentMethodDropdown I select the option by text "<paymentMethod>"
      And I get csr search data for "promoCode" and store it with key #PromoCode
      And I type "#PromoCode" in the empty field Csr.SearchPage.PromocodeInput
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 10 seconds

    Examples:
      | firstName | lastName | address    | city | postCode | country | status               | paymentMethod |
      | 123       | Sap      | Teststreet | Gent | 1015     | BE      | Shipped and Captured | VISA          |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-11748
  Scenario Outline: Csr user can see no results found message when searching with multiple valid data firstname, address, city, postcode, country, order status, payment method, promocode and invalid lastname
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I type "<firstName>" in the empty field Csr.SearchPage.FirstNameInput
      And I type "<lastName>" in the empty field Csr.SearchPage.LastNameInput
      And I type "<address>" in the empty field Csr.SearchPage.AddressInput
      And I type "<city>" in the empty field Csr.SearchPage.CityInput
      And I type "<postCode>" in the empty field Csr.SearchPage.PostCodeInput
      And in dropdown Csr.SearchPage.CountryDropdown I select the option by text "<country>"
      And in dropdown Csr.SearchPage.OrderStatusDropdown I select the option by text "<status>"
      And in dropdown Csr.SearchPage.PaymentMethodDropdown I select the option by text "<paymentMethod>"
      And I get csr search data for "promoCode" and store it with key #PromoCode
      And I type "#PromoCode" in the empty field Csr.SearchPage.PromocodeInput
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 10 seconds

    Examples:
      | firstName | lastName | address    | city | postCode | country | status               | paymentMethod |
      | Johan     | $@p      | Teststreet | Gent | 1015     | BE      | Shipped and Captured | VISA          |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-11723
  Scenario Outline: Csr user can see no results found message when searching with multiple valid data firstname, lastname, city, postcode, country, order status, payment method, promocode and invalid address
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I type "<firstName>" in the empty field Csr.SearchPage.FirstNameInput
      And I type "<lastName>" in the empty field Csr.SearchPage.LastNameInput
      And I type "<address>" in the empty field Csr.SearchPage.AddressInput
      And I type "<city>" in the empty field Csr.SearchPage.CityInput
      And I type "<postCode>" in the empty field Csr.SearchPage.PostCodeInput
      And in dropdown Csr.SearchPage.CountryDropdown I select the option by text "<country>"
      And in dropdown Csr.SearchPage.OrderStatusDropdown I select the option by text "<status>"
      And in dropdown Csr.SearchPage.PaymentMethodDropdown I select the option by text "<paymentMethod>"
      And I get csr search data for "promoCode" and store it with key #PromoCode
      And I type "#PromoCode" in the empty field Csr.SearchPage.PromocodeInput
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 10 seconds

    Examples:
      | firstName | lastName | address | city | postCode | country | status               | paymentMethod |
      | Johan     | Sap      | 1234@@  | Gent | 1015     | BE      | Shipped and Captured | VISA          |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-11732
  Scenario Outline: Csr user can see no results found message when searching with multiple valid data firstname, lastname, address, postcode, country, order status, payment method, promocode and invalid city
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I type "<firstName>" in the empty field Csr.SearchPage.FirstNameInput
      And I type "<lastName>" in the empty field Csr.SearchPage.LastNameInput
      And I type "<address>" in the empty field Csr.SearchPage.AddressInput
      And I type "<city>" in the empty field Csr.SearchPage.CityInput
      And I type "<postCode>" in the empty field Csr.SearchPage.PostCodeInput
      And in dropdown Csr.SearchPage.CountryDropdown I select the option by text "<country>"
      And in dropdown Csr.SearchPage.OrderStatusDropdown I select the option by text "<status>"
      And in dropdown Csr.SearchPage.PaymentMethodDropdown I select the option by text "<paymentMethod>"
      And I get csr search data for "promoCode" and store it with key #PromoCode
      And I type "#PromoCode" in the empty field Csr.SearchPage.PromocodeInput
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 10 seconds

    Examples:
      | firstName | lastName | address    | city | postCode | country | status               | paymentMethod |
      | Johan     | Sap      | Teststreet | 123$ | 1015     | BE      | Shipped and Captured | VISA          |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-11741
  Scenario Outline: Csr user can see no results found message when searching with multiple valid data firstname, lastname, address, city, country, order status, payment method, promocode and invalid postcode
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I type "<firstName>" in the empty field Csr.SearchPage.FirstNameInput
      And I type "<lastName>" in the empty field Csr.SearchPage.LastNameInput
      And I type "<address>" in the empty field Csr.SearchPage.AddressInput
      And I type "<city>" in the empty field Csr.SearchPage.CityInput
      And I type "<postCode>" in the empty field Csr.SearchPage.PostCodeInput
      And in dropdown Csr.SearchPage.CountryDropdown I select the option by text "<country>"
      And in dropdown Csr.SearchPage.OrderStatusDropdown I select the option by text "<status>"
      And in dropdown Csr.SearchPage.PaymentMethodDropdown I select the option by text "<paymentMethod>"
      And I get csr search data for "promoCode" and store it with key #PromoCode
      And I type "#PromoCode" in the empty field Csr.SearchPage.PromocodeInput
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 10 seconds

    Examples:
      | firstName | lastName | address    | city  | postCode | country | status               | paymentMethod |
      | Johan     | Sap      | Teststreet | Ghent | abc@12   | BE      | Shipped and Captured | VISA          |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-11733
  Scenario Outline: Csr user can see no results found message when searching with multiple valid data firstname, lastname, address, city, postcode, country, order status, payment method, promocode and invalid returnId
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I type "<firstName>" in the empty field Csr.SearchPage.FirstNameInput
      And I type "<lastName>" in the empty field Csr.SearchPage.LastNameInput
      And I type "<address>" in the empty field Csr.SearchPage.AddressInput
      And I type "<city>" in the empty field Csr.SearchPage.CityInput
      And I type "<postCode>" in the empty field Csr.SearchPage.PostCodeInput
      And in dropdown Csr.SearchPage.CountryDropdown I select the option by text "<country>"
      And in dropdown Csr.SearchPage.OrderStatusDropdown I select the option by text "<status>"
      And in dropdown Csr.SearchPage.PaymentMethodDropdown I select the option by text "<paymentMethod>"
      And I get csr search data for "promoCode" and store it with key #PromoCode
      And I type "#PromoCode" in the empty field Csr.SearchPage.PromocodeInput
      And I type "<returnId>" in the empty field Csr.SearchPage.WCSReturnNumberInput
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTable is not displayed
      And I see Csr.SearchPage.SearchResultText with text Found 0 matching orders is displayed in 10 seconds

    Examples:
      | firstName | lastName | address    | city  | postCode | country | status               | paymentMethod | returnId |
      | Johan     | Sap      | Teststreet | Ghent | 1015     | BE      | Shipped and Captured | VISA          | abcd1234 |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-11737
  Scenario Outline: Csr user can see correct results when searching with any country displayed in the dropdown list
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I click on Csr.SearchPage.AdvancedSearchButton
    When in dropdown Csr.SearchPage.CountryDropdown I select the option by text "<country1>"
      And I store the value of Csr.SearchPage.CountryDropdownText with key #country1
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTableOrderIDColumn is displayed in 10 seconds
      And I see Csr.SearchPage.SearchResultTableCountryColumn contains text "#country1"
      And I see the value of Csr.SearchPage.SearchResultTableCountryColumn should contain the stored value with key #country1
      And I click on Csr.SearchPage.ClearButton
    When in dropdown Csr.SearchPage.CountryDropdown I select the option by text "<country2>"
      And I store the value of Csr.SearchPage.CountryDropdownText with key #country2
      And I clear text field of element Csr.SearchPage.DatePickerFromInput
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "08/05/2023"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTableOrderIDColumn is displayed in 10 seconds
      And I see the value of Csr.SearchPage.SearchResultTableCountryColumn should contain the stored value with key #country2
      And I see the value of Csr.SearchPage.SearchResultTableCountryColumn should not be equal to the stored value with key #country1

    Examples:
      | country1 | country2 |
      | GB       | BE       |
      | NL       | DE       |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-11731
  Scenario Outline: Csr user can see results when searching with any paymentmethod displayed in the dropdown list
    Given I am in csr main of locale default and langCode default with L1 csr account with forced accepted cookies
      And I click on Csr.SearchPage.AdvancedSearchButton
    When in dropdown Csr.SearchPage.PaymentMethodDropdown I select the option by text "<paymentMethod>"
      And I clear text field of element Csr.SearchPage.DatePickerFromInput
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "08/05/2023"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTableOrderIDColumn is displayed in 10 seconds
      And I see Csr.SearchPage.SearchResultTablePaymentMethodColumn contains text "<paymentMethod>" is displayed

    Examples:
      | paymentMethod |
      | VISA          |
      | PayPal        |
      | Bancontact    |
      | RatePay       |
      | Przelewy24    |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2
  @tms:UTR-11744
  Scenario Outline: Csr user can see results when searching with valid orderstatus displayed in the dropdown list
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I click on Csr.SearchPage.AdvancedSearchButton
      And I get csr search data for "order_status" and store it with key #OrderStatus
    When in dropdown Csr.SearchPage.OrderStatusDropdown I select the option by text "<orderStatus>"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTableOrderIDColumn is displayed in 10 seconds
      And I see Csr.SearchPage.SearchResultTableStatusColumn contains text "<orderStatus>" is displayed

    Examples:
      | orderStatus  |
      | #OrderStatus |
      | Cancelled    |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P2 @ExcludeSIT
  @tms:UTR-11743
  Scenario: Csr user can see error message when entering dates above 30days date range
    Given I am in csr main of locale default and langCode default with L3 csr account with forced accepted cookies
      And I click on Csr.SearchPage.AdvancedSearchButton
      And I clear text field of element Csr.SearchPage.DatePickerFromInput
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "20/04/2022"
      And I clear text field of element Csr.SearchPage.DatePickerToInput
      And in datepicker Csr.SearchPage.DatePickerToInput I type date "27/05/2022"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.DateInputError contains text "Please lower the date range to a maximum of 30 days OR narrow your search with at least one other field value"

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-11738
  Scenario: Csr user can see error message when entering invalid date(future date) in TO field
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I click on Csr.SearchPage.AdvancedSearchButton
      And I clear text field of element Csr.SearchPage.DatePickerFromInput
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "20/05/2023"
      And I clear text field of element Csr.SearchPage.DatePickerToInput
      And in datepicker Csr.SearchPage.DatePickerToInput I type date "27/05/2024"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.InputError contains text "Date should not be after maximal date"

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P3
  @tms:UTR-15733
  Scenario: Csr user can see Shipping Link when search for shipped order
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I clear text field of element Csr.SearchPage.DatePickerFromInput
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "20/05/2022"
      And in dropdown Csr.SearchPage.OrderStatusDropdown I select the option by text "Shipped"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTableOrderIDColumn is displayed in 10 seconds
      And I click on Csr.SearchPage.OrderDetailsByTableIndex with index 1
      And I wait until the current page is loaded
    Then I wait until Csr.SearchPage.OrderShippingLink is displayed

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P3 @GiftCard
  @tms:UTR-15733 @ExcludeCK
  Scenario Outline: Csr user can see Gift card details as order item
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I type "<orderID>" in the empty field Csr.SearchPage.OrderIdInput
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I clear text field of element Csr.SearchPage.DatePickerFromInput
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "20/09/2023"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTableOrderIDColumn is displayed in 10 seconds
      And I click on Csr.SearchPage.OrderDetailsByTableIndex with index 1
      And I wait until the current page is loaded
    Then I wait until Csr.SearchPage.GiftCardItemDetailLabel is displayed

    Examples:
      | orderID      |
      | 900001388848 |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P3 @GiftCard
  @tms:UTR-17992 @ExcludeCK
  Scenario Outline: Csr user can not use good will details when Gift card is as order item
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I type "<orderID>" in the empty field Csr.SearchPage.OrderIdInput
    When I click on Csr.SearchPage.AdvancedSearchButton
      And I clear text field of element Csr.SearchPage.DatePickerFromInput
      And in datepicker Csr.SearchPage.DatePickerFromInput I type date "20/09/2023"
      And I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTableOrderIDColumn is displayed in 10 seconds
      And I click on Csr.SearchPage.OrderDetailsByTableIndex with index 1
      And I wait until the current page is loaded
    Then I wait until Csr.SearchPage.GoodWillDivForGiftCardAsItemLevel is displayed with text "No item goodwill"
      And I wait until Csr.SearchPage.GoodWillDivForGiftCardAsOrderLevel is displayed with text "No order goodwill refunded"

    Examples:
      | orderID      |
      | 900001388848 |

    # This will be dynamic once they will add GIFTCARD as payment method in selectbox
  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P3 @GiftCard
  @tms:UTR-15733 @ExcludeUat
  Scenario Outline: Csr user can see Gift card in the multiple payment option
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
      And I type "<orderID>" in the empty field Csr.SearchPage.OrderIdInput
    When I click on Csr.SearchPage.SearchButton
    Then I see Csr.SearchPage.SearchResultTableOrderIDColumn is displayed in 10 seconds
      And I click on Csr.SearchPage.OrderDetailsByTableIndex with index 1
      And I wait until the current page is loaded
    Then I wait until Csr.SearchPage.GiftCardTableAsPaymentItem is displayed
      And I see Csr.SearchPage.GiftCardAsPaymentItem with text GiftCard is displayed
      And I see Csr.SearchPage.GiftCardInPaymentStatus with text GiftCard is displayed

    @ExcludeCK
    Examples:
      | orderID      |
      | 900001569802 |

    @ExcludeTH
    Examples:
      | orderID      |
      | 900001569798 |

  @FullRegression
  @Desktop
  @Chrome @Firefox @Safari
  @Csr @UnifiedExperience @EER @P3 @GiftCard
  @tms:UTR-17991
  Scenario: Csr user can see multiple payment information in order details
    Given I am in csr main of locale default and langCode default with L2 csr account with forced accepted cookies
    When I click on Csr.SearchPage.AdvancedSearchButton
    Then I click on Csr.SearchPage.SearchButton
      And I see Csr.SearchPage.SearchResultTableOrderIDColumn is displayed in 20 seconds
      And I click on Csr.SearchPage.OrderDetailsByTableIndex with index 1
      And I wait until the current page is loaded
    Then I wait until Csr.SearchPage.GiftCardTableAsPaymentItem is displayed
      And I wait until Csr.SearchPage.OrderPaymentInformation is displayed with text "Payment method"
      And I wait until Csr.SearchPage.OrderPaymentInformation is displayed with text "order amount"
