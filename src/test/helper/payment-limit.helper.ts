/* eslint-disable consistent-return */
/* eslint-disable-next-line import/prefer-default-export */
import services from '../../core/services';

export const getCreditCardPaymentLimit = (locale: string) => {
  if (services.env.Brand === 'ck') {
    if (!services.site.langCode) {
      switch (locale) {
        case 'at':
        case 'de':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 7.500 €, der für diese Zahlungsart gilt.Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        case 'es':
          return 'La cantidad total de su pedido supera nuestro límite por pedido de 7500 € para este método de pago.Elimine uno o más artículos para continuar o utilice otro método de pago diferente';
        case 'ie':
        case 'fi':
        case 'pt':
        case 'sk':
        case 'hr':
        case 'ee':
        case 'hu':
        case 'bg':
        case 'ro':
        case 'lv':
        case 'lt':
        case 'si':
          return 'The total amount of your order exceeds our order limit of €7,500.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'nl':
          return 'het totale bedrag van uw bestelling overschrijdt onze bestellimiet van € 7.500,00 voor deze betaalmethode. verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode.';
        case 'be':
          return 'Het totale bedrag van uw bestelling overschrijdt onze bestellimiet van € 7.500,00 voor deze betaalmethode. Verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode.';
        case 'it':
          return 'L’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di € 7.500 per questo metodo di pagamento.Rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo';
        case 'dk':
          return 'The total amount of your order exceeds our order limit of 55,800 KR for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'se':
          return 'The total amount of your order exceeds our order limit of 75,000 KR for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'pl':
          return 'Łączna kwota Twojego zamówienia przekracza limit 31 000 zł dla tej metody płatności.Aby kontynuować, usuń co najmniej jeden produkt albo skorzystaj z innej metody płatności';
        case 'cz':
          return 'The total amount of your order exceeds our order limit of 200 000 Kč for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'ch':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 8.500 CHF, der für diese Zahlungsart gilt.Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        case 'uk':
          return 'The total amount of your order exceeds our order limit of £7,500.00 for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'fr':
        case 'lu':
          return 'Le montant total de votre commande excède notre limite de commande de 7 500 € pour ce moyen de paiement.Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'FR') {
      switch (locale) {
        case 'be':
          return 'Le montant total de votre commande excède notre limite de commande de 7 500,00 € pour ce moyen de paiement. Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        case 'ch':
          return 'le montant total de votre commande excède notre limite de commande de 8 500,00 chf pour ce moyen de paiement. merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'DE') {
      switch (locale) {
        case 'lu':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 7.500 €, der für diese Zahlungsart gilt.Bitte entfernen Sie mindestens einen posten, um fortfahren zu können, oder verwenden sie eine andere Zahlungsart.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'IT') {
      switch (locale) {
        case 'ch':
          return 'l’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di 8.500,00 chf per questo metodo di pagamento. rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'EN') {
      switch (locale) {
        case 'de':
          return 'The total amount of your order exceeds our order limit of €7,500.00 for this payment method. please remove one or more items to continue or use an alternative payment method.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    }
  } else if (services.env.Brand === 'th') {
    if (!services.site.langCode) {
      switch (locale) {
        case 'at':
        case 'de':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 7.500,00 €, der für diese Zahlungsart gilt. Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        case 'es':
          return 'La cantidad total de su pedido supera nuestro límite por pedido de 7500,00 € para este método de pago. Elimine uno o más artículos para continuar o utilice otro método de pago diferente';
        case 'ie':
        case 'fi':
        case 'pt':
        case 'sk':
        case 'hr':
        case 'ee':
        case 'hu':
        case 'lv':
        case 'lt':
        case 'si':
          return 'The total amount of your order exceeds our order limit of €7,500.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'nl':
          return 'Het totale bedrag van uw bestelling overschrijdt onze bestellimiet van € 7.500,00 voor deze betaalmethode. Verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode';
        case 'be':
          return 'Het totale bedrag van uw bestelling overschrijdt onze bestellimiet van € 7.500,00 voor deze betaalmethode.Verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode.';
        case 'it':
          return 'L’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di € 7.500,00 per questo metodo di pagamento. Rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo';
        case 'dk':
          return 'The total amount of your order exceeds our order limit of KR55,800.00 for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'se':
          return 'The total amount of your order exceeds our order limit of SEK75,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'pl':
          return 'łączna kwota twojego zamówienia przekracza limit 31 000,00 zł dla tej metody płatności.aby kontynuować, usuń co najmniej jeden produkt albo skorzystaj z innej metody płatności.';
        case 'cz':
          return 'The total amount of your order exceeds our order limit of 200 000,00 Kč for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'ch':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 8.500,00 CHF, der für diese Zahlungsart gilt. Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        case 'uk':
          return 'The total amount of your order exceeds our order limit of £7,500.00 for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'fr':
        case 'lu':
          return 'Le montant total de votre commande excède notre limite de commande de 7500,00 € pour ce moyen de paiement. Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'FR') {
      switch (locale) {
        case 'be':
          return 'Le montant total de votre commande excède notre limite de commande de 7 500,00 € pour ce moyen de paiement.Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        case 'ch':
          return 'Le montant total de votre commande excède notre limite de commande de 8 500,00 CHF pour ce moyen de paiement.Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'DE') {
      switch (locale) {
        case 'lu':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 7.500,00 €, der für diese Zahlungsart gilt. Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'IT') {
      switch (locale) {
        case 'ch':
          return 'L’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di 8.500,00 CHF per questo metodo di pagamento.Rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'EN') {
      switch (locale) {
        case 'de':
          return 'The total amount of your order exceeds our order limit of €7,500.00 for this payment method. please remove one or more items to continue or use an alternative payment method.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    }
  }
};

export const getPaypalPaymentLimit = (locale: string) => {
  if (services.env.Brand === 'ck') {
    if (!services.site.langCode) {
      switch (locale) {
        case 'at':
        case 'de':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 1.550 €, der für diese Zahlungsart gilt.Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        case 'es':
          return 'La cantidad total de su pedido supera nuestro límite por pedido de 1550 € para este método de pago.Elimine uno o más artículos para continuar o utilice otro método de pago diferente';
        case 'ie':
        case 'fi':
        case 'pt':
        case 'sk':
        case 'hr':
        case 'hu':
        case 'bg':
        case 'ro':
        case 'lv':
        case 'lt':
        case 'si':
        case 'ee':
          return 'The total amount of your order exceeds our order limit of €1,150.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'nl':
          return 'het totale bedrag van uw bestelling overschrijdt onze bestellimiet van € 1.550,00 voor deze betaalmethode. verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode.';
        case 'be':
          return 'Het totale bedrag van uw bestelling overschrijdt onze bestellimiet van 1.550 € voor deze betaalmethode.Verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode';
        case 'it':
          return 'L’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di € 1.150 per questo metodo di pagamento.Rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo';
        case 'dk':
          return 'The total amount of your order exceeds our order limit of 8,000 KR for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'se':
          return 'The total amount of your order exceeds our order limit of 15,000 KR for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'pl':
          return 'łączna kwota twojego zamówienia przekracza limit 4700,00 zł dla tej metody płatności. Aby kontynuować, usuń co najmniej jeden produkt albo skorzystaj z innej metody płatności.';
        case 'cz':
          return 'The total amount of your order exceeds our order limit of 31 000 Kč for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'ch':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 1.800 CHF, der für diese Zahlungsart gilt.Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        case 'uk':
          return 'The total amount of your order exceeds our order limit of £1,350.00 for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'fr':
        case 'lu':
          return 'Le montant total de votre commande excède notre limite de commande de 1 550 € pour ce moyen de paiement.Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'FR') {
      switch (locale) {
        case 'be':
          return 'Le montant total de votre commande excède notre limite de commande de 1 550 € pour ce moyen de paiement.Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement';
        case 'ch':
          return 'le montant total de votre commande excède notre limite de commande de 1 800,00 chf pour ce moyen de paiement. merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'DE') {
      switch (locale) {
        case 'lu':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 1.150 €, der für diese Zahlungsart gilt.Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'IT') {
      switch (locale) {
        case 'ch':
          return 'L’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di 1.800,00 CHF per questo metodo di pagamento. Rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'EN') {
      switch (locale) {
        case 'de':
          return 'The total amount of your order exceeds our order limit of €1,550.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    }
  } else if (services.env.Brand === 'th') {
    if (!services.site.langCode) {
      switch (locale) {
        case 'at':
        case 'de':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 1.550,00 €, der für diese Zahlungsart gilt. Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        case 'es':
          return 'La cantidad total de su pedido supera nuestro límite por pedido de 1550,00 € para este método de pago. Elimine uno o más artículos para continuar o utilice otro método de pago diferente';
        case 'ie':
        case 'fi':
        case 'pt':
        case 'sk':
        case 'hr':
        case 'hu':
        case 'lv':
        case 'lt':
        case 'si':
        case 'ee':
          return 'The total amount of your order exceeds our order limit of €1,150.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'be':
          return 'Het totale bedrag van uw bestelling overschrijdt onze bestellimiet van 1.550,00 € voor deze betaalmethode. Verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode';
        case 'nl':
          return 'Het totale bedrag van uw bestelling overschrijdt onze bestellimiet van € 1.550,00 voor deze betaalmethode. Verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode';
        case 'it':
          return 'L’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di € 1.150,00 per questo metodo di pagamento. Rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo';
        case 'dk':
          return 'The total amount of your order exceeds our order limit of KR8,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'se':
          return 'The total amount of your order exceeds our order limit of SEK15,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'pl':
          return 'łączna kwota twojego zamówienia przekracza limit 4700,00 zł dla tej metody płatności.Aby kontynuować, usuń co najmniej jeden produkt albo skorzystaj z innej metody płatności.';
        case 'cz':
          return 'The total amount of your order exceeds our order limit of 31 000,00 Kč for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'ch':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 1.800,00 CHF, der für diese Zahlungsart gilt. Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        case 'uk':
          return 'The total amount of your order exceeds our order limit of £1,350.00 for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'fr':
        case 'lu':
          return 'Le montant total de votre commande excède notre limite de commande de 1550,00 € pour ce moyen de paiement. Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'FR') {
      switch (locale) {
        case 'be':
          return 'le montant total de votre commande excède notre limite de commande de 1 550,00 € pour ce moyen de paiement.merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        case 'ch':
          return 'Le montant total de votre commande excède notre limite de commande de 1 800,00 CHF pour ce moyen de paiement.Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'DE') {
      switch (locale) {
        case 'lu':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 1.150,00 €, der für diese Zahlungsart gilt. Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'IT') {
      switch (locale) {
        case 'ch':
          return 'l’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di 1.800,00 chf per questo metodo di pagamento.rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'EN') {
      switch (locale) {
        case 'de':
          return 'The total amount of your order exceeds our order limit of €1,550.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    }
  }
};

export const getKlarnaPaymentLimit = (locale: string) => {
  if (services.env.Brand === 'ck') {
    if (!services.site.langCode) {
      switch (locale) {
        case 'it':
          return 'L’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di € 1.000 per questo metodo di pagamento.Rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo.';
        case 'fr':
          return 'Le montant total de votre commande excède notre limite de commande de 1 500 € pour ce moyen de paiement.Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        case 'es':
          return 'La cantidad total de su pedido supera nuestro límite por pedido de 1000 € para este método de pago.Elimine uno o más artículos para continuar o utilice otro método de pago diferente.';
        case 'nl':
          return 'het totale bedrag van uw bestelling overschrijdt onze bestellimiet van € 5.000,00 voor deze betaalmethode. verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode.';
        case 'be':
          return 'het totale bedrag van uw bestelling overschrijdt onze bestellimiet van € 1.500,00 voor deze betaalmethode. verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode.';
        case 'dk':
          return 'The total amount of your order exceeds our order limit of 50,000 kr for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'se':
          return 'The total amount of your order exceeds our order limit of 100,000 kr for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'uk':
          return 'The total amount of your order exceeds our order limit of £600 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'fi':
          return 'The total amount of your order exceeds our order limit of €5,000 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'at':
          return 'der gesamtbetrag ihrer bestellung übersteigt den bestellhöchstwert von 5.000,00 €, der für diese zahlungsart gilt. bitte entfernen sie mindestens einen posten, um fortfahren zu können, oder verwenden sie eine andere zahlungsart.';
        case 'ch':
          return 'der gesamtbetrag ihrer bestellung übersteigt den bestellhöchstwert von 1.000,00 chf, der für diese zahlungsart gilt. bitte entfernen sie mindestens einen posten, um fortfahren zu können, oder verwenden sie eine andere zahlungsart.';
        case 'de':
          return 'der gesamtbetrag ihrer bestellung übersteigt den bestellhöchstwert von 5.000,00 €, der für diese zahlungsart gilt. bitte entfernen sie mindestens einen posten, um fortfahren zu können, oder verwenden sie eine andere zahlungsart.';
        case 'pl':
          return 'Łączna kwota Twojego zamówienia przekracza limit 7000,00 zł dla tej metody płatności. Aby kontynuować, usuń co najmniej jeden produkt albo skorzystaj z innej metody płatności.';
        default:
          throw new Error(`Klarna payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'FR') {
      switch (locale) {
        case 'be':
          return 'le montant total de votre commande excède notre limite de commande de 1 500,00 € pour ce moyen de paiement. merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        case 'ch':
          return 'Le montant total de votre commande excède notre limite de commande de 3 000 chf pour ce moyen de paiement.merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'DE') {
      switch (locale) {
        case 'lu':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 1.150 €, der für diese Zahlungsart gilt.Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'IT') {
      switch (locale) {
        case 'ch':
          return 'L’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di 3.000 CHF per questo metodo di pagamento.Rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'EN') {
      switch (locale) {
        case 'de':
          return 'The total amount of your order exceeds our order limit of €5,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    }
  } else if (services.env.Brand === 'th') {
    if (!services.site.langCode) {
      switch (locale) {
        case 'at':
          return 'der gesamtbetrag ihrer bestellung übersteigt den bestellhöchstwert von 5.000,00 €, der für diese zahlungsart gilt.bitte entfernen sie mindestens einen posten, um fortfahren zu können, oder verwenden sie eine andere zahlungsart.';
        case 'de':
          return 'der gesamtbetrag ihrer bestellung übersteigt den bestellhöchstwert von 5.000,00 €, der für diese zahlungsart gilt.bitte entfernen sie mindestens einen posten, um fortfahren zu können, oder verwenden sie eine andere zahlungsart.';
        case 'es':
          return 'La cantidad total de su pedido supera nuestro límite por pedido de 1550,00 € para este método de pago. Elimine uno o más artículos para continuar o utilice otro método de pago diferente';
        case 'ie':
        case 'fi':
          return 'The total amount of your order exceeds our order limit of € 5,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'pt':
        case 'sk':
        case 'hr':
        case 'ee':
        case 'hu':
        case 'lv':
        case 'lt':
        case 'si':
          return 'The total amount of your order exceeds our order limit of € 2.500,00 for this payment method. please remove one or more items to continue or use an alternative payment method';
        case 'nl':
          return 'Het totale bedrag van uw bestelling overschrijdt onze bestellimiet van € 5.000,00 voor deze betaalmethode.Verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode.';
        case 'be':
          return 'het totale bedrag van uw bestelling overschrijdt onze bestellimiet van € 1.500,00 voor deze betaalmethode.verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode.';
        case 'it':
          return 'L’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di € 1.150,00 per questo metodo di pagamento. Rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo';
        case 'dk':
          return 'The total amount of your order exceeds our order limit of kr50,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'se':
          return 'The total amount of your order exceeds our order limit of sek100,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'pl':
          return 'Łączna kwota Twojego zamówienia przekracza limit 7000,00 zł dla tej metody płatności.Aby kontynuować, usuń co najmniej jeden produkt albo skorzystaj z innej metody płatności.';
        case 'cz':
          return 'The total amount of your order exceeds our order limit of 31 000,00 Kč for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'ch':
          return 'der gesamtbetrag ihrer bestellung übersteigt den bestellhöchstwert von 1.000,00 chf, der für diese zahlungsart gilt.bitte entfernen sie mindestens einen posten, um fortfahren zu können, oder verwenden sie eine andere zahlungsart.';
        case 'uk':
          return 'The total amount of your order exceeds our order limit of £600.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'fr':
        case 'lu':
          return 'Le montant total de votre commande excède notre limite de commande de 1550,00 € pour ce moyen de paiement. Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'FR') {
      switch (locale) {
        case 'be':
          return 'le montant total de votre commande excède notre limite de commande de 1 500,00 € pour ce moyen de paiement.merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        case 'ch':
          return 'Le montant total de votre commande excède notre limite de commande de 3 000 CHF pour ce moyen de paiement.Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'DE') {
      switch (locale) {
        case 'lu':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 1.150,00 €, der für diese Zahlungsart gilt. Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'IT') {
      switch (locale) {
        case 'ch':
          return 'L’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di 3.000,00 CHF per questo metodo di pagamento. Rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'EN') {
      switch (locale) {
        case 'de':
          return 'The total amount of your order exceeds our order limit of €5,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    }
  }
};

export const getKlarnaInstalmentsLimit = (locale: string) => {
  if (services.env.Brand === 'ck') {
    if (!services.site.langCode) {
      switch (locale) {
        case 'it':
          return '’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di € 1.500 per questo metodo di pagamento.rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo.';
        case 'fr':
          return 'Le montant total de votre commande excède notre limite de commande de 2 500 € pour ce moyen de paiement.Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        case 'es':
          return 'La cantidad total de su pedido supera nuestro límite por pedido de 1500 € para este método de pago.Elimine uno o más artículos para continuar o utilice otro método de pago diferente.';
        case 'nl':
          return 'Het totale bedrag van uw bestelling overschrijdt onze bestellimiet van € 4.000,00 voor deze betaalmethode. Verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode.';
        case 'be':
          return 'Het totale bedrag van uw bestelling overschrijdt onze bestellimiet van 2.500 € voor deze betaalmethode.Verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode.';
        case 'dk':
          return 'The total amount of your order exceeds our order limit of 30,000 kr for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'se':
          return 'The total amount of your order exceeds our order limit of 100,000 kr for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'uk':
          return 'The total amount of your order exceeds our order limit of £1,000 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'fi':
          return 'The total amount of your order exceeds our order limit of €3,000 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'ie':
          return 'The total amount of your order exceeds our order limit of €1,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'pt':
          return 'The total amount of your order exceeds our order limit of €1,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'cz':
          return 'The total amount of your order exceeds our order limit of 25 000,00 Kč for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        default:
          throw new Error(`Klarna payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'FR') {
      switch (locale) {
        case 'be':
          return 'Le montant total de votre commande excède notre limite de commande de €2,500 pour ce moyen de paiement.Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        case 'ch':
          return 'Le montant total de votre commande excède notre limite de commande de 1 800 CHF pour ce moyen de paiement.Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'DE') {
      switch (locale) {
        case 'lu':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 1.150 €, der für diese Zahlungsart gilt.Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'IT') {
      switch (locale) {
        case 'ch':
          return 'L’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di 1.800 CHF per questo metodo di pagamento.Rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    }
  } else if (services.env.Brand === 'th') {
    if (!services.site.langCode) {
      switch (locale) {
        case 'at':
        case 'de':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 1.550,00 €, der für diese Zahlungsart gilt. Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        case 'es':
          return 'La cantidad total de su pedido supera nuestro límite por pedido de 1500,00 € para este método de pago. Elimine uno o más artículos para continuar o utilice otro método de pago diferente.';
        case 'ie':
          return 'The total amount of your order exceeds our order limit of €1,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'fi':
          return 'The total amount of your order exceeds our order limit of € 3,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'sk':
        case 'hr':
        case 'ee':
        case 'hu':
        case 'lv':
        case 'lt':
        case 'si':
          return 'The total amount of your order exceeds our order limit of € 2.500,00 for this payment method. please remove one or more items to continue or use an alternative payment method';
        case 'nl':
          return 'Het totale bedrag van uw bestelling overschrijdt onze bestellimiet van € 4.000,00 voor deze betaalmethode.Verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode.';
        case 'be':
          return 'Het totale bedrag van uw bestelling overschrijdt onze bestellimiet van 2.500,00 € voor deze betaalmethode. Verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode.';
        case 'it':
          return 'L’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di € 1.500,00 per questo metodo di pagamento. Rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo.';
        case 'dk':
          return 'The total amount of your order exceeds our order limit of kr30,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'se':
          return 'The total amount of your order exceeds our order limit of sek100,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method';
        case 'pl':
          return 'Łączna kwota Twojego zamówienia przekracza limit 4700,00 zł dla tej metody płatności. Aby kontynuować, usuń co najmniej jeden produkt albo skorzystaj z innej metody płatności';
        case 'ch':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 1.800,00 CHF, der für diese Zahlungsart gilt. Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        case 'uk':
          return 'The total amount of your order exceeds our order limit of £1,000.00 for this payment method. please remove one or more items to continue or use an alternative payment method.';
        case 'fr':
        case 'lu':
          return 'Le montant total de votre commande excède notre limite de commande de 2500,00 € pour ce moyen de paiement. merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        case 'pt':
          return 'The total amount of your order exceeds our order limit of €1,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        case 'cz':
          return 'The total amount of your order exceeds our order limit of 25 000,00 Kč for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'FR') {
      switch (locale) {
        case 'be':
          return 'Le montant total de votre commande excède notre limite de commande de 2500,00 € pour ce moyen de paiement. Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        case 'ch':
          return 'Le montant total de votre commande excède notre limite de commande de 1 800,00 CHF pour ce moyen de paiement. Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'DE') {
      switch (locale) {
        case 'lu':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 1.150,00 €, der für diese Zahlungsart gilt. Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'IT') {
      switch (locale) {
        case 'ch':
          return 'L’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di 1.800,00 CHF per questo metodo di pagamento. Rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    }
  }
};

export const getKlarnaMinimumLimit = (locale: string) => {
  if (services.env.Brand === 'ck') {
    if (!services.site.langCode) {
      switch (locale) {
        case 'nl':
          return 'Voor deze betalingsmethode is een minimumbestelwaarde van € 35,00 vereist.';
        case 'it':
          return 'Ricordiamo che per questa modalità di pagamento l’ordine deve avere un valore minimo di € 35.';
        case 'es':
          return 'Ten en cuenta que este método de pago exige un pedido mínimo por valor de 35 €.';
        case 'fr':
          return 'Veuillez noter qu’un montant minimum de 35 € s’applique pour ce mode de paiement.';
        case 'be':
          return 'Voor deze betalingsmethode is een minimumbestelwaarde van 35 € vereist.';
        case 'dk':
          return 'Please note that there is a minimum order value of 150 kr for this payment method.';
        case 'se':
          return 'Please note that there is a minimum order value of 200 kr for this payment method.';
        case 'uk':
          return 'Please note that there is a minimum order value of £35 for this payment method.';
        case 'fi':
          return 'Please note that there is a minimum order value of €35 for this payment method.';
        case 'ie':
          return 'Please note that there is a minimum order value of €35.00 for this payment method.';
        case 'de':
          return 'Bitte nehmen Sie zur Kenntnis, dass für diese Zahlungsmethode ein Mindestbestellwert von 35 € gilt.';
        case 'at':
          return 'Bitte nehmen Sie zur Kenntnis, dass für diese Zahlungsmethode ein Mindestbestellwert von 35 € gilt.';
        case 'ch':
          return 'Bitte nehmen Sie zur Kenntnis, dass für diese Zahlungsmethode ein Mindestbestellwert von 35 CHF gilt.';
        case 'pt':
          return 'Please note that there is a minimum order value of €35.00 for this payment method.';
        case 'cz':
          return 'Please note that there is a minimum order value of 850,00 Kč for this payment method.';
        default:
          throw new Error(`Klarna payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'FR') {
      switch (locale) {
        case 'be':
          return 'Veuillez noter qu’un montant minimum de 35 € s’applique pour ce mode de paiement';
        case 'ch':
          return 'Veuillez noter qu’un montant minimum de 35 CHF s’applique pour ce mode de paiement';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'DE') {
      switch (locale) {
        case 'lu':
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'IT') {
      switch (locale) {
        case 'ch':
          return 'Ricordiamo che per questa modalità di pagamento l’ordine deve avere un valore minimo di 35 chf.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    }
  } else if (services.env.Brand === 'th') {
    if (!services.site.langCode) {
      switch (locale) {
        case 'at':
        case 'de':
          return 'Bitte nehmen Sie zur Kenntnis, dass für diese Zahlungsmethode ein Mindestbestellwert von 35 gilt.';
        case 'ie':
          return 'Please note that there is a minimum order value of €35.00 for this payment method.';
        case 'fi':
          return 'Please note that there is a minimum order value of 35 for this payment method.';
        case 'sk':
        case 'hr':
        case 'ee':
        case 'hu':
        case 'lv':
        case 'lt':
        case 'fr':
          return 'Veuillez noter qu’un montant minimum de 35 s’applique pour ce mode de paiement.';
        case 'es':
          return 'Ten en cuenta que este método de pago exige un pedido mínimo por valor de 35.';
        case 'nl':
          return 'Voor deze betalingsmethode is een minimumbestelwaarde van € 35,00 vereist.';
        case 'be':
          return 'Voor deze betalingsmethode is een minimumbestelwaarde van 35 vereist.';
        case 'it':
          return 'Ricordiamo che per questa modalità di pagamento l’ordine deve avere un valore minimo di 35.';
        case 'dk':
          return 'Please note that there is a minimum order value of 150 for this payment method.';
        case 'se':
          return 'Please note that there is a minimum order value of 200 for this payment method.';
        case 'pl':
        case 'ch':
          return 'Bitte nehmen Sie zur Kenntnis, dass für diese Zahlungsmethode ein Mindestbestellwert von 35 gilt.';
        case 'uk':
          return 'Please note that there is a minimum order value of 35 for this payment method.';
        case 'lu':
        case 'pt':
          return 'Please note that there is a minimum order value of €35.00 for this payment method.';
        case 'cz':
          return 'Please note that there is a minimum order value of 850,00 Kč for this payment method.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'FR') {
      switch (locale) {
        case 'be':
          return 'Veuillez noter qu’un montant minimum de 35 s’applique pour ce mode de paiement.';
        case 'ch':
          return 'Veuillez noter qu’un montant minimum de 35 s’applique pour ce mode de paiement.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'DE') {
      switch (locale) {
        case 'lu':
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'IT') {
      switch (locale) {
        case 'ch':
          return 'Ricordiamo che per questa modalità di pagamento l’ordine deve avere un valore minimo di 35.';
        default:
          throw new Error(`Credit card payment limit for locale ${locale} is not supported`);
      }
    }
  }
};

export const getDotpayLimit = () => {
  if (services.env.Brand === 'ck') {
    return 'Łączna kwota Twojego zamówienia przekracza limit 9300,00 zł dla tej metody płatności. Aby kontynuować, usuń co najmniej jeden produkt albo skorzystaj z innej metody płatności.';
  }
  if (services.env.Brand === 'th') {
    return 'Łączna kwota Twojego zamówienia przekracza limit 9300,00 zł dla tej metody płatności.Aby kontynuować, usuń co najmniej jeden produkt albo skorzystaj z innej metody płatności.';
  }
};

export const getRatepayLimit = (locale: string) => {
  if (services.env.Brand === 'ck') {
    if (!services.site.langCode) {
      switch (locale) {
        case 'de':
        case 'at':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 2.000,00 €, der für diese Zahlungsart gilt. Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart.';
        case 'ch':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 2.000,00 CHF, der für diese Zahlungsart gilt. Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart.';
        default:
          throw new Error(`Ratepay payment for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'FR') {
      switch (locale) {
        case 'ch':
          return 'Le montant total de votre commande excède notre limite de commande de 2 000,00 CHF pour ce moyen de paiement. Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        default:
          throw new Error(`Ratepay payment for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'IT') {
      switch (locale) {
        case 'ch':
          return 'L’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di 2.000,00 CHF per questo metodo di pagamento. Rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo.';
        default:
          throw new Error(`Ratepay payment for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'EN') {
      switch (locale) {
        case 'de':
          return 'The total amount of your order exceeds our order limit of €2,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        default:
          throw new Error(`Ratepay payment for locale ${locale} is not supported`);
      }
    }
  } else if (services.env.Brand === 'th') {
    if (!services.site.langCode) {
      switch (locale) {
        case 'at':
        case 'de':
          return 'Der Gesamtbetrag Ihrer Bestellung übersteigt den Bestellhöchstwert von 2.000,00 €, der für diese Zahlungsart gilt.Bitte entfernen Sie mindestens einen Posten, um fortfahren zu können, oder verwenden Sie eine andere Zahlungsart.';
        case 'ch':
          return 'der gesamtbetrag ihrer bestellung übersteigt den bestellhöchstwert von 2.000,00 chf, der für diese zahlungsart gilt.bitte entfernen sie mindestens einen posten, um fortfahren zu können, oder verwenden sie eine andere zahlungsart.';
        default:
          throw new Error(`Ratepay payment for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'FR') {
      switch (locale) {
        case 'ch':
          return 'Le montant total de votre commande excède notre limite de commande de 2 000,00 CHF pour ce moyen de paiement.Merci de supprimer un ou plusieurs articles pour poursuivre ou d’utiliser un autre moyen de paiement.';
        default:
          throw new Error(`Ratepay payment for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'IT') {
      switch (locale) {
        case 'ch':
          return 'L’importo totale del tuo ordine supera il nostro valore massimo consentito per ordine di 2.000,00 CHF per questo metodo di pagamento.Rimuovi uno o più articoli per continuare o utilizza un metodo di pagamento alternativo.';
        default:
          throw new Error(`Ratepay payment for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'EN') {
      switch (locale) {
        case 'de':
          return 'The total amount of your order exceeds our order limit of €2,000.00 for this payment method. Please remove one or more items to continue or use an alternative payment method.';
        default:
          throw new Error(`Ratepay payment for locale ${locale} is not supported`);
      }
    }
  }
};
export const getRatepayMinimumLimit = (locale: string) => {
  if (services.env.Brand === 'ck') {
    if (!services.site.langCode) {
      switch (locale) {
        case 'de':
        case 'at':
          return 'Bitte nehmen Sie zur Kenntnis, dass für diese Zahlungsmethode ein Mindestbestellwert von 20,00 € gilt.';
        case 'ch':
          return 'Bitte nehmen Sie zur Kenntnis, dass für diese Zahlungsmethode ein Mindestbestellwert von 20,00 CHF gilt.';
        default:
          throw new Error(`Ratepay payment for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'FR') {
      switch (locale) {
        case 'ch':
          return 'Veuillez noter qu’un montant minimum de 20,00 CHF s’applique pour ce mode de paiement.';
        default:
          throw new Error(`Ratepay payment for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'IT') {
      switch (locale) {
        case 'ch':
          return 'Ricordiamo che per questa modalità di pagamento l’ordine deve avere un valore minimo di 20,00 CHF.';
        default:
          throw new Error(`Ratepay payment for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'EN') {
      switch (locale) {
        case 'de':
          return 'Please note that there is a minimum order value of €20.00 for this payment method.';
        default:
          throw new Error(`Ratepay payment for locale ${locale} is not supported`);
      }
    }
  } else if (services.env.Brand === 'th') {
    if (!services.site.langCode) {
      switch (locale) {
        case 'at':
        case 'de':
          return 'Bitte nehmen Sie zur Kenntnis, dass für diese Zahlungsmethode ein Mindestbestellwert von 20,00 € gilt.';
        case 'ch':
          return 'Bitte nehmen Sie zur Kenntnis, dass für diese Zahlungsmethode ein Mindestbestellwert von 20,00 CHF gilt.';
        default:
          throw new Error(`Ratepay payment for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'FR') {
      switch (locale) {
        case 'ch':
          return 'Veuillez noter qu’un montant minimum de 20,00 CHF s’applique pour ce mode de paiement.';
        default:
          throw new Error(`Ratepay payment for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'IT') {
      switch (locale) {
        case 'ch':
          return 'Ricordiamo che per questa modalità di pagamento l’ordine deve avere un valore minimo di 20,00 CHF.';
        default:
          throw new Error(`Ratepay payment for locale ${locale} is not supported`);
      }
    } else if (services.site.langCode === 'EN') {
      switch (locale) {
        case 'de':
          return 'Please note that there is a minimum order value of €20.00 for this payment method.';
        default:
          throw new Error(`Ratepay payment for locale ${locale} is not supported`);
      }
    }
  }
};

export const getiDealLimit = () => {
  if (services.env.Brand === 'ck') {
    return 'het totale bedrag van uw bestelling overschrijdt onze bestellimiet van € 2.100,00 voor deze betaalmethode. verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode.';
  }
  if (services.env.Brand === 'th') {
    return 'Het totale bedrag van uw bestelling overschrijdt onze bestellimiet van € 2.100,00 voor deze betaalmethode.Verwijder één of meer items om verder te gaan of gebruik een alternatieve betaalmethode.';
  }
};
