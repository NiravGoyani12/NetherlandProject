Feature: Unified Content - HomePage SEO
 
  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @Seo @UnifiedContent @UnifiedExperience @P1
  @tms:UTR-15229
  Scenario Outline: Mega Tag - Validate meta tag with value google-site-verfication exists on the home page
    Given I am on locale <locale> home page of langCode <langCode> with forced accepted cookies
    When I see the attribute name of element BasePage.Metatag with value google-site-verification containing "google-site-verification"
    Then the count of elements BasePage.Metatag with value google-site-verification is equal to <meta tag count>

    @ExcludeCK
    Examples:
      | locale  | langCode | meta tag count |
      | default | default  | 2              |

    @ExcludeTH
    Examples:
      | locale  | langCode | meta tag count |
      | default | default  | 3              |