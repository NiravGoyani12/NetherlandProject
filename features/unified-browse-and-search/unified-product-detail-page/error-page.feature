Feature: Unified PDP - Error page

  @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @ErrorPage @PDP @TEE @UnifiedPdp @UnifiedExperience @P2
  @tms:UTR-13360
  Scenario Outline: Error page - Verify the page redirects to oops page when launching invalid pdp url
    Given There is 1 normal size product item of locale <locale> with inventory between 10 and 99999
      And I am on locale <locale> pdp page for product style product1#styleColourPartNumber with accepted cookies
    When I navigate to current url appended with some random text
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.ErrorPage is displayed

    Examples:
      | locale  |
      | default |