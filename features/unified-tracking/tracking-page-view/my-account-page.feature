Feature: Unified Tracking - Page - View

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DigitalData @UnifiedMyAccount @PPL
  Scenario Outline: Validation of the modules user, site and page
    Given I am on my account <page> page on locale <locale> of langCode <langCode> with forced accepted cookies
      And I wait for 3 seconds
    When I validate digital data site module with report key #report
      And I validate unified digital data registered user module with report key #report
      And I validate unified digital data page module on myaccountpage with following data with report key #report
      """
      {
        "pagePath": "<path>",
        "pageName": "my account|<name>",
        "pageAlias": "myaccountpage",
        "pageGender": "not applicable",
        "primaryCategory": "myaccountpage",
        "primaryCategoryId": "myaccountpage"
      }
      """
      And I validate unified digital data version module with report key #report
    Then I execute all digital data validation with report key #report

    @tms:UTR-5654
    Examples:
      | locale  | langCode | page    | path                       | name                    |
      | default | default  | details | /myaccount/personaldetails | account>personaldetails |

    @tms:UTR-5655
    Examples:
      | locale  | langCode | page   | path              | name           |
      | default | default  | orders | /myaccount/orders | account>orders |

    @tms:UTR-5656
    Examples:
      | locale  | langCode | page      | path                 | name              |
      | default | default  | addresses | /myaccount/addresses | account>addresses |

    @tms:UTR-5657
    Examples:
      | locale  | langCode | page          | path                     | name                  |
      | default | default  | notifications | /myaccount/notifications | account>notifications |

    @tms:UTR-7698
    Examples:
      | locale  | langCode | page        | path                   | name                |
      | default | default  | preferences | /myaccount/preferences | account>preferences |