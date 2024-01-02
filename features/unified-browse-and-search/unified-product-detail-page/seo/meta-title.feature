Feature: Unified PDP - SEO

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Seo @PDP @TEE @UnifiedPdp @UnifiedExperience @P2 @ExcludeCK
  @tms:UTR-13358
  Scenario Outline: Meta title - TH - PDP page title contains translated product name and colour and brand
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 50 and 9999
    When I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber
    Then in PDP I see page title contains product name and colour name and brand of product style colour partnumber product1#styleColourPartNumber

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Seo @PDP @TEE @UnifiedPdp @UnifiedExperience @P2 @ExcludeTH
  @tms:UTR-13359
  Scenario Outline: Meta title - CK - PDP page title contains translated product name and colour and brand
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 50 and 9999
    When I am on locale <locale> pdp page of langCode <langCode> for product style product1#styleColourPartNumber
    Then in unified PDP I see page title contains product name and brand name and product number of product style colour partnumber product1#styleColourPartNumber

    Examples:
      | locale  | langCode |
      | default | default  |