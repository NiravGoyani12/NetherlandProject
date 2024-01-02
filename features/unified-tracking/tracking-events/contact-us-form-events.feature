Feature: Unified Tracking - Events

  @FullRegression
  @Desktop @Mobile @OnlyEmulator
  @Chrome
  @Analytics @Unification @DataLayerEvent @EER @P3
  @tms:UTR-9783
  Scenario Outline: Contactus first interaction - The event is fired when I interact with contactus form the first time
    Given  I am on locale <locale> of url contactus of langCode default with forced accepted cookies
      And I wait until the current page is loaded
    When I inject utag event listener
      And I click on ContactUsPage.RequestTypeDropdown
    Then utag event contactus_first_interaction is fired saved to key #event
      And utag event #event should contain attr eventCategory with value "general"
      And utag event #event should contain attr eventAction with value "contactus_first_interaction"
      And utag event #event should contain attr eventLabel with value "customerservice|customerservice"
      And I execute all datalayer event validation with report key #event

    Examples:
      | locale |
      | ee     |
