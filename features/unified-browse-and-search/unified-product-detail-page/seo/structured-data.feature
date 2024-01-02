Feature: Unified PDP - SEO

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Seo @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-5110
  Scenario Outline: Structured Data - in PDP I see Product Structured Data rendered from server
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 200 and 99999 filtered by FH
    When I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    Then the PDP structured data of style colour part number product1#styleColourPartNumber is correct

    Examples:
      | locale  | langCode |
      | default | default  |