Feature: Unified PDP - Notify me

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PDP @TEE @UnifiedPdp @UnifiedExperience @NotifyMe @P2
  @tms:UTR-12332
  Scenario Outline: NotifyMe - Verify notify me button is displayed for one size OOS product
    Given There is 1 one size product style of locale <locale> and langCode <langCode> with inventory between 0 and 0 filtered by FH
    When I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I get translation from lokalise for "SoldOutText" and store it with key #SoldOut
      And I get translation from lokalise for "NotifyMeButtonText" and store it with key #NotifyMe
    Then I see ProductDetailPage.Pdp.SoldOutMessage contains text "#SoldOut"
    Then I see ProductDetailPage.Pdp.NotifyMeButton with text #NotifyMe is displayed
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.Pdp.NotifyMePopup is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PDP @TEE @UnifiedPdp @UnifiedExperience @NotifyMe @P2
  @tms:UTR-12333
  Scenario Outline: NotifyMe - Verify notify me button is displayed for multisize size OOS product
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> where 1 size is out of stock with inventory between 10 and 99999
    When I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I click on ProductDetailPage.Pdp.SizeSoldOutButton
      And I get translation from lokalise for "SizeOutOfStockText" and store it with key #SizeOutOfStock
      And I get translation from lokalise for "NotifyMeButtonText" and store it with key #NotifyMe
    Then I see ProductDetailPage.Pdp.SoldOutMessage contains text "#SizeOutOfStock" in 3 seconds
    Then I see ProductDetailPage.Pdp.NotifyMeButton with text #NotifyMe is displayed
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.Pdp.NotifyMePopup is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PDP @TEE @UnifiedPdp @UnifiedExperience @NotifyMe @P2
  @tms:UTR-12289
  Scenario Outline: NotifyMe - Verify error message is thrown when clicked on notify me button without selecting the sizes for oos product
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 0 and 0 filtered by FH
      And I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
      And I get translation from lokalise for "SelectSizeError" and store it with key #SelectSizeError
    When I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.Pdp.SelectSizeErrorMessage with text #SelectSizeError is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari @Translation @Lokalise
  @PDP @TEE @UnifiedPdp @UnifiedExperience @NotifyMe @P2
  @tms:UTR-12521
  Scenario Outline: NotifyMe - Verify notify me button is displayed for coming soon product
    When I am on locale <locale> pdp page for product style WW0WW401600G9/J20J221345BEH with accepted cookies
      And I wait until the current page is loaded
      And I get translation from lokalise for "ComingSoonText" and store it with key #<ComingSoonText>
      And I get translation from lokalise for "NotifyMeButtonText" and store it with key #NotifyMe
    Then I see ProductDetailPage.Pdp.SoldOutMessage is not displayed
      And I see ProductDetailPage.Pdp.NotifyMeButton with text #NotifyMe is displayed
    When in unified PDP I select the oos size and save as #SizeName
      And I click on ProductDetailPage.Pdp.NotifyMeButton
    Then I see ProductDetailPage.Pdp.NotifyMePopup is displayed
      And I see ProductDetailPage.NotifyMePopup.Title with text #<ComingSoonText> is displayed

    Examples:
      | locale  | langCode |
      | default | default  |

    Examples:
      | locale           | langCode |
      | multiLangDefault | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @P2 @Translation @Lokalise
  @tms:UTR-13210 @ExcludeCK
  Scenario Outline: Sold Out - For all sizes soldout product I should see the out of stock button in PDP for some products
    Given There is 2 sold out product item of locale <locale>
    When I am on locale <locale> pdp page for product style product2#styleColourPartNumber with forced accepted cookies
      And I get translation from lokalise for "SoldOutText" and store it with key #SoldOut
      And I wait until the current page is loaded
      And I get translation from lokalise for "SizeOutOfStockButtonText" and store it with key #OutOfStock
    Then I see ProductDetailPage.Pdp.ProductLabel with text #SoldOut is displayed
      And I see ProductDetailPage.Pdp.OutOfStockButton with text #OutOfStock is displayed

    Examples:
      | locale  |
      | default |