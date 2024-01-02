Feature: Unified PDP - Product images and videos

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @ProductImages @P2
  @tms:UTR-5125
  Scenario Outline: Product Images - Verify product with one image is rendered correctly and can be zoomed
    When I am on locale <locale> pdp page for product style <productId> with forced accepted cookies
      And I wait until the current page is loaded
    Then the count of displayed elements ProductDetailPage.Pdp.ProductImages is equal to 1
      And I see ProductDetailPage.Pdp.ProductVideoElement is not displayed
    When I hover over ProductDetailPage.Pdp.ProductImages with index 1
    Then I see ProductDetailPage.Pdp.ProductZoomElement is displayed

    Examples:
      | locale  | productId                   |
      | default | MW0MW17770C66/K40K400257436 |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @ProductVideos @P2
  @tms:UTR-5124
  Scenario Outline: Product Images - Desktop - Verify video is available on second carousel for product with more images on PDP
    Given I am on locale <locale> pdp page for product style <productId> with forced accepted cookies
      And I wait until the current page is loaded
      And the count of displayed elements ProductDetailPage.Pdp.ProductImages is greater than 1
      And I see ProductDetailPage.Pdp.ProductVideoElement is displayed
    When I click on ProductDetailPage.Pdp.ProductImages with index 2
    Then I see ProductDetailPage.Pdp.VideoPlayButton is not displayed
    When I click on ProductDetailPage.Pdp.ProductImages with index 2
    Then I see ProductDetailPage.Pdp.VideoPlayButton is displayed
      And I see the attribute src of element ProductDetailPage.Pdp.ProductVideoElement with value metadata containing "video_pdp"

    Examples:
      | locale  | productId                   |
      | default | MW0MW11596DW5/K20K205542BEH |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @ProductVideos @P2
  @tms:UTR-5129
  Scenario Outline: Product Images - Mobile - Verify video is available on second carousel on swiping for product with more images on PDP
    Given I am on locale <locale> pdp page for product style <productId> with forced accepted cookies
      And I wait until the current page is loaded
      And the count of displayed elements ProductDetailPage.Pdp.ProductImages is greater than 1
    Then I see ProductDetailPage.Pdp.ProductImageCarouselBullets is displayed
    When I swipe to left direction on element ProductDetailPage.Pdp.ProductImages
    Then I see ProductDetailPage.Pdp.ProductVideoElement is displayed
      And I see ProductDetailPage.Pdp.VideoPlayButton is displayed
    When I click on ProductDetailPage.Pdp.VideoPlayButton
    Then I see ProductDetailPage.Pdp.VideoPlayButton is not displayed
      And I see the attribute src of element ProductDetailPage.Pdp.ProductVideoElement with value metadata containing "video_pdp"
    When I click on ProductDetailPage.Pdp.ProductVideoElement
    Then I see ProductDetailPage.Pdp.VideoPlayButton is displayed

    Examples:
      | locale  | productId                   |
      | default | MW0MW11596DW5/K20K205542BEH |

  @FullRegression
  @Desktop
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @ImageZoom @P2
  @tms:UTR-13190
  Scenario Outline: Product Image zoom - Desktop - Verify the images can be zoomed for a better view of the product
    Given I am on unified locale <locale> pdp page for product style <productId> with forced accepted cookies
      And I wait until the current page is loaded
      And the count of displayed elements ProductDetailPage.Pdp.ProductImages is greater than 1
    When I hover over ProductDetailPage.Pdp.ProductImages with index 1
    Then I see ProductDetailPage.Pdp.ProductZoomElement with index 1 is displayed
      And I see ProductDetailPage.Pdp.ProductZoomElement with index 2 is not displayed

    Examples:
      | locale  | productId                   |
      | default | DW0DW092191A5/J20J2206671A4 |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @ImageZoom @P2
  @tms:UTR-13191
  Scenario Outline: Product Image zoom - Mobile - Verify the clicked images is zoomed and other images are displayed at bottom as thumbnails
    Given I am on unified locale <locale> pdp page for product style <productId> with forced accepted cookies
      And I wait until the current page is loaded
      And the count of displayed elements ProductDetailPage.Pdp.ProductImages is greater than 1
    When I click on ProductDetailPage.Pdp.ProductImages with index 1
    Then I see ProductDetailPage.Pdp.ProductZoomElement is displayed
      And I see ProductDetailPage.Pdp.MobileZoomThumbNails is displayed
    When I wait until ProductDetailPage.Pdp.ProductZoomCloseButton is displayed
      And I click on ProductDetailPage.Pdp.ProductZoomCloseButton
    Then I see ProductDetailPage.Pdp.ProductZoomElement is not displayed in 3 seconds

    Examples:
      | locale  | productId                   |
      | default | DW0DW092191A5/J20J2206671A4 |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @UnifiedExperience @ImageZoom @P2
  @tms:UTR-13192
  Scenario Outline: Product Image zoom - Mobile - Verify other images can be selected from the thumbnails when zoom is open
    Given I am on unified locale <locale> pdp page for product style <productId> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.Pdp.ProductImages with index 1
    Then I see ProductDetailPage.Pdp.ProductZoomElement is displayed
      And I see the attribute class of element ProductDetailPage.Pdp.MobileZoomThumbSlider with index 1 containing "selected"
    When I click on ProductDetailPage.Pdp.MobileZoomThumbSlider with index 2
    Then I see the attribute class of element ProductDetailPage.Pdp.MobileZoomThumbSlider with index 2 containing "selected"
      And I see ProductDetailPage.Pdp.ProductZoomElement is displayed

    Examples:
      | locale  | productId                   |
      | default | DW0DW092191A5/J20J2206671A4 |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @ProductImageThumbnails @P2
  @tms:UTR-18259
  Scenario Outline: Product Images Thumbnails - Mobile - Verify thumbnails are displayed below main image
    Given There is 1 normal size product style of locale <locale> and langCode <langCode> with inventory between 200 and 99999 filtered by FH
    When I am on locale <locale> pdp page for product style product1#styleColourPartNumber with forced accepted cookies
      And I wait until the current page is loaded
    Then I see ProductDetailPage.Pdp.MobileImageThumbNails is displayed
      And I see the attribute class of element ProductDetailPage.Pdp.MobileImageThumbNailImage with index 1 containing "Selected"
    When I click on ProductDetailPage.Pdp.MobileImageThumbNailImage with index 2
    Then I see the attribute class of element ProductDetailPage.Pdp.MobileImageThumbNailImage with index 1 not containing "Selected"
      And I see the attribute class of element ProductDetailPage.Pdp.MobileImageThumbNailImage with index 2 containing "Selected"

    Examples:
      | locale  | langCode |
      | default | default  |

  @FullRegression
  @Mobile
  @Chrome @FireFox @Safari
  @PDP @TEE @UnifiedPdp @ProductImageThumbnails @P2
  @tms:UTR-18260
  Scenario Outline: Product Images Thumbnails - Mobile - Verify video is available on clicking second thumbnail for product with more images on PDP
    Given I am on locale <locale> pdp page for product style <productId> with forced accepted cookies
      And I wait until the current page is loaded
    When I click on ProductDetailPage.Pdp.MobileImageThumbNailImage with index 2
    Then I see ProductDetailPage.Pdp.ProductVideoElement is displayed
      And I see ProductDetailPage.Pdp.VideoPlayButton is displayed
    When I click on ProductDetailPage.Pdp.VideoPlayButton
    Then I see ProductDetailPage.Pdp.VideoPlayButton is not displayed

    Examples:
      | locale  | productId                   |
      | default | MW0MW11596DW5/K20K205542BEH |
