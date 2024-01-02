/* eslint-disable import/prefer-default-export */
import services from '../../core/services';

export function parse(text: string, locale?: string): any {
  if (!locale) {
    locale = services.site.locale.toLowerCase();
  }
  if (text === '#PHONE') {
    switch (locale) {
      case 'nl':
        return '0612345678';
      case 'de':
        return '+4901761428434';
      case 'at':
        return '+4306762600456';
      case 'be':
        return '32 2 505 55 55';
      case 'uk':
        return '+4408082580300';
      case 'pl':
        return '+48795222223';
      default:
        return '';
    }
  } else if (text === '#NATIONALID') {
    switch (locale) {
      case 'dk':
        return '0801363945';
      case 'se':
        return '410321-9202';
      case 'fi':
        return '190122-829F';
      case 'pl':
        return '67050538635';
      default:
        return '';
    }
  } else if (text === '#NEGATIVEPHONE') {
    switch (locale) {
      case 'uk':
        return '44 20 7602 6600';
      case 'de':
        return '+49017610927312';
      case 'ch':
        return '+41 44 829 90 00';
      case 'be':
        return '32 2 505 55 55';
      case 'nl':
        return '+31632167678';
      case 'pl':
        return '+48795223325';
      case 'at':
        return '+4306762600745';
      default:
        return '';
    }
  } else if (text === '#PENDINGPHONEACCEPT') {
    switch (locale) {
      case 'uk':
        return '44 333 321 9282';
      default:
        return '';
    }
  } else if (text === '#PENDINGPHONEREJECT') {
    switch (locale) {
      case 'uk':
        return '44 20 7660 0675';
      default:
        return '';
    }
  } else if (text === '#PHONEINSTALMENTS') {
    switch (locale) {
      case 'uk':
        return '+4408082580300';
      case 'fr':
        return '+33689854321';
      case 'es':
        return '+34910695129';
      case 'it':
        return '+393339741231';
      case 'ie':
        return '+3536789010';
      case 'nl':
        return '+31689124321';
      case 'pt':
        return '+351212162265';
      case 'ro':
        return '+40741209876';
      case 'cz':
        return '+420771613715';
      default:
        return '';
    }
  } else if (text === '#PHONEINSTALMENTSNEGATIVE') {
    switch (locale) {
      case 'uk':
        return '+4408082580300';
      case 'fr':
        return '+33 4 79 72 72 72';
      case 'es':
        return '+34 952 57 94 00';
      case 'it':
        return '+39 010 403 0343';
      case 'nl':
        return '+31632167678';
      case 'ie':
        return '+3536782030';
      default:
        return '';
    }
  }
  return text;
}
