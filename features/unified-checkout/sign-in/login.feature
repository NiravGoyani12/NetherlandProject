Feature: Unified Checkout - Sign in page

  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @SignIn @Negative
  Scenario Outline: SignIn - Login on SignIn Page with errors
    Given I am on locale <locale> of langCode <langCode> with 1 products on shipping page
      And I log in with user <email> and password <password> on sign in page
    Then I see <errorElement> contains text "<errorMessage>"

    @tms:EESCK-4961
    Examples:
      | locale | langCode | email            | password | errorElement                         | errorMessage                                                        |
      | uk     | default  | invalidEmail@pvh | abc123   | Checkout.SignInPage.EmailSignInError | Sorry, that doesn't look like an email address                      |
      | de     | default  | invalidEmail@pvh | abc123   | Checkout.SignInPage.EmailSignInError | Sorry, leider scheint das keine gültige E-Mail-Adresse zu sein      |
      | be     | FR       | invalidEmail@pvh | abc123   | Checkout.SignInPage.EmailSignInError | Désolé, on dirait bien que cette adresse e-mail n’est pas valide... |

    @tms:EESCK-4959
    Examples:
      | locale | langCode | email              | password | errorElement                            | errorMessage                       |
      | uk     | default  | validEmail@pvh.com |          | Checkout.SignInPage.PasswordSignInError | You need to fill in this field     |
      | de     | default  | validEmail@pvh.com |          | Checkout.SignInPage.PasswordSignInError | Dieses Feld muss ausgefüllt werden |
      | be     | FR       | validEmail@pvh.com |          | Checkout.SignInPage.PasswordSignInError | Ce champ doit être complété        |

    @tms:EESCK-4959
    Examples:
      | locale | langCode | email | password | errorElement                         | errorMessage                            |
      | uk     | default  |       | abc123   | Checkout.SignInPage.EmailSignInError | Please enter an email address           |
      | de     | default  |       | abc123   | Checkout.SignInPage.EmailSignInError | E-Mail ist erforderlich                 |
      | be     | FR       |       | abc123   | Checkout.SignInPage.EmailSignInError | Entrez une adresse mail s'il vous plaît |

    @tms:EESCK-4958
    Examples:
      | locale | langCode | email         | password | errorElement                            | errorMessage                                                |
      | uk     | default  | test@test.com | abc      | Checkout.SignInPage.PasswordSignInError | Your password needs to be between 10 and 25 characters long |
      | de     | default  | test@test.com | abc      | Checkout.SignInPage.PasswordSignInError | Dein Passwort sollte 10 bis 25 Zeichen enthalten            |
      | be     | FR       | test@test.com | abc      | Checkout.SignInPage.PasswordSignInError | Votre mot de passe doit contenir entre 10 et 25 caractères  |

    @tms:EESCK-4960
    Examples:
      | locale | langCode | email                       | password | errorElement                    | errorMessage                                                        |
      | uk     | default  | pvh.qa.automation@gmail.com | abc123   | Checkout.SignInPage.SignInError | Looks like your username and password don't match. Please try again |
      | de     | default  | pvh.qa.automation@gmail.com | abc123   | Checkout.SignInPage.SignInError | Bitte warten Sie ein paar Sekunden, bevor Sie es erneut versuchen.  |
      | be     | FR       | pvh.qa.automation@gmail.com | abc123   | Checkout.SignInPage.SignInError | Attendez quelques secondes avant de vous connecter à nouveau.       |

  # TODO: commenting out test until we add separate accounts to test this functionality
  # @FullRegression
  @Desktop @Mobile
  @Chrome @FireFox @Safari
  @UnifiedCheckout @ResetPassword @SignIn
  Scenario Outline: Sign in - I can reset my account password from Sign-in Page
    Given I am on locale <locale> of langCode <langCode> with 1 products on shipping page
      And I click on Checkout.SignInPage.HiddenSignInButton if displayed
    When I reset my account's password
      And I verify password reset confirmation email with subject as <emailSubject> from outlook

    @tms:UTR-13292
    Examples:
      | locale  | langCode | emailSubject   |
      | default | default  | RESET PASSWORD |

    @tms:UTR-13293
    Examples:
      | locale           | langCode         | emailSubject          |
      | multiLangDefault | multiLangDefault | Passwort zurücksetzen |