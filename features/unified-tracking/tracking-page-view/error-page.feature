Feature: Unified Tracking - Page - View

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @CET1 @P1 @tms:UTR-18544
  Scenario Outline: Errorpage - Guest or registered user with error page validation of module page attributes
      Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
      And I navigate to page error-page
      And I am a <userType> user
      And I wait until the current page is loaded
      When I validate digital data site module with report key #report
      And I validate unified digital data <type> user module with allowed unknown attributes with report key #report
      And I validate unified digital data page module on errorpage with following data with report key #report
      """
      {
        "pageType": "errorpage",
        "pagePath": "/error-page",
        "pageName": "errorpage|>",
        "pageAlias": "errorpage",
        "pageGender": "not applicable",
        "primaryCategory": "errorpage",
        "primaryCategoryId": "errorpage"
      }
      """
      And I validate unified digital data version module with report key #report
      Then I execute all digital data validation with report key #report

      Examples:
      | locale | langCode | userType  | type       |
      | ee     | default  | guest     | guest      |
      | ee     | default  | logged in | registered |

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @CET1 @P1 @tms:UTR-18544
  Scenario Outline: Errorpage - Guest or registered user with cart filled - validation of the modules user, site, page and cart
      Given I am on locale <locale> home page with forced accepted cookies
      And I am a <userType> user
      And I am on locale <locale> shopping bag page with 1 unit of any product
      And I wait until Experience.Header.ShoppingBagCounter contains text "1"
      And I wait until the current page is loaded
      And I navigate to page error-page
      And I wait until the current page is loaded
      When I validate digital data site module with report key #report
      And I validate unified digital data <type> user module with allowed unknown attributes with report key #report
      And I validate unified digital data page module on errorpage with following data with report key #report
      """
      {
        "pageType": "errorpage",
        "pagePath": "/error-page",
        "pageName": "errorpage|>",
        "pageAlias": "errorpage",
        "pageGender": "not applicable",
        "primaryCategory": "errorpage",
        "primaryCategoryId": "errorpage"
      }
      """
      And I validate digital data 1st cart item module of style colour partnumber product1#styleColourPartNumber with following data with report key #report
      And I validate unified digital data version module with report key #report
      Then I execute all digital data validation with report key #report
      
      Examples:
      | locale | langCode | userType  | type       |
      | ee     | default  | guest     | guest      |
      | ee     | default  | logged in | registered |
    

