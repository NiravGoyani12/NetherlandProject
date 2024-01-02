Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @UnifiedPdp @P2
  @TEE @PDP
  @tms:UTR-12968
  Scenario Outline: Coming soon subscription - The event is fired when clicking on notify me inside the pop up
    Given I am on unified locale <locale> pdp page for product style <productStyleColourPartNumber> with forced accepted cookies
      And I wait until page ProductDetailPage.Pdp is loaded
    When I inject utag event listener
      And I click on ProductDetailPage.Pdp.SizeSoldOutButton by js
      And I click on ProductDetailPage.Pdp.NotifyMeButton
      And I type "notify@me.com" in the field ProductDetailPage.NotifyMePopup.EmailInput
      And I click on ProductDetailPage.NotifyMePopup.NotifyMeButton
      And I wait until ProductDetailPage.NotifyMePopup.NotifyMeSuccessMessage is displayed
    Then utag event coming_soon_subscription is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "engagement"
      And utag event #event should contain attr eventAction with value "coming soon subscription"
      And utag event #event should contain attr eventLabel with value "<productStyleColourPartNumber>" in lower case
      And utag event #event should contain attr event_value with value "<productStyleColourPartNumber>" in lower case
      And utag event #event should contain attr product_combi with value "<productStyleColourPartNumber>" in lower case
      And utag event #event should contain attr product_combi_uppercase with value "<productStyleColourPartNumber>" in upper case
      And utag event #event should contain attr product_list with value of digitalData.page.category.productStructureGroupId
      And utag event #event should contain non-empty attr product_low_price with value of product low price of product style <productStyleColourPartNumber>
      And utag event #event should contain attr product_name with value of name of product style <productStyleColourPartNumber>
      And utag event #event should contain attr product_colour with value of colour of product style <productStyleColourPartNumber>
      And utag event #event should contain attr product_style with value "<productStyle>"
      And utag event #event should contain non-empty attr product_price with value of product price of product style <productStyleColourPartNumber>
      And utag event #event should contain non-empty attr product_base_price with value of product base price of product style <productStyleColourPartNumber>
      And utag event #event should contain non-empty attr product_sku
      And utag event #event should contain non-empty attr product_tax
      And utag event #event should contain non-empty attr product_size
      And utag event #event should contain non-empty attr product_ean
      And utag event #event should optionally contain non-empty attr product_category
      And utag event #event should optionally contain non-empty attr product_category_alias
      And utag event #event should contain attr product_id with value "<productStyleColourPartNumber>" in lower case
      And utag event #event should contain attr product_gender with value of gender of product style <productStyleColourPartNumber>
      And utag event #event should contain attr product_discount_status with value of discount status of product style <productStyleColourPartNumber>
      And utag event #event should contain attr product_discount with value of discount of product style <productStyleColourPartNumber>
      And utag event #event should contain attr product_division with value of division of product style <productStyleColourPartNumber>
      And utag event #event should contain non-empty attr user_email_encrypted
      And utag event #event should contain non-empty attr product_brand
      And I execute all datalayer event validation with report key #event

    @ExcludeCK
    Examples:
      | locale | productStyleColourPartNumber | productStyle |
      | ee     | KB0KB06879PMI                | kb0kb06879   |

    @ExcludeTH
    Examples:
      | locale | productStyleColourPartNumber | productStyle |
      | ee     | J20J218347ACF                | j20j218347   |
