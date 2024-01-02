/* eslint-disable consistent-return */
import services from '../../core/services';

// eslint-disable-next-line import/prefer-default-export
export const getStandardShippingCosts = (locale: string) => {
  if (services.env.Brand === 'ck') {
    switch (locale) {
      case 'at':
      case 'de':
      case 'fi':
      case 'fr':
        return '3.95';
      case 'be':
        return '4,95';
      case 'es':
      case 'lu':
        return '4,95';
      case 'ie':
      case 'pt':
      case 'sk':
      case 'bg':
      case 'hr':
        return '5.95';
      case 'hu':
      case 'lv':
      case 'lt':
      case 'ro':
      case 'si':
        return '3.95';
      case 'nl':
      case 'it':
        return '3,95';
      case 'dk':
        return '29.00';
      case 'se':
        return '39.00';
      case 'pl':
        return '21,50';
      case 'cz':
        return '150';
      case 'ch':
        return '5,90';
      case 'uk':
        return '3.95';
      case 'ee':
        return '5.95';
      default:
        throw new Error(`Shipping costs for locale ${locale} is not supported`);
    }
  } else if (services.env.Brand === 'th') {
    switch (locale) {
      case 'at':
      case 'de':
      case 'es':
        return '5,90';
      case 'fr':
        return '5,90';
      case 'ie':
      case 'fi':
      case 'pt':
      case 'bg':
      case 'hr':
        return '5.90';
      case 'hu':
      case 'lv':
      case 'lt':
      case 'ro':
      case 'si':
      case 'sk':
        return '5.90';
      case 'ee':
        return '5.90';
      case 'be':
        return '5,90';
      case 'lu':
        return '5,90';
      case 'nl':
        return '3,95';
      case 'it':
        return '5,90';
      case 'dk':
        return '44';
      case 'se':
        return '45.00';
      case 'pl':
        return '24,90';
      case 'cz':
        return '150,00';
      case 'ch':
        return '5,90';
      case 'uk':
        return '3.90';
      default:
        throw new Error(`Shipping costs for locale ${locale} is not supported`);
    }
  }
};

export const getExpressShippingCosts = (locale: string) => {
  if (services.env.Brand === 'ck') {
    switch (locale) {
      case 'at':
      case 'de':
      case 'es':
      case 'it':
        return '9,95';
      case 'lu':
      case 'fr':
        return '12,95';
      case 'nl':
        return '9,99';
      case 'fi':
        return '9.95';
      case 'dk':
        return '99,00';
      case 'se':
        return '139.00';
      case 'pl':
        return '66,90';
      case 'cz':
        return '380,00';
      case 'uk':
        return '9.95';
      case 'ee':
      case 'sk':
      case 'bg':
      case 'hr':
      case 'hu':
      case 'lv':
      case 'lt':
      case 'ro':
      case 'si':
        return '14.95';
      case 'be':
        return '12,95';
      case 'ie':
        return '12.95';
      case 'pt':
        return '14.95';
      default:
        throw new Error(`Shipping costs for locale ${locale} is not supported`);
    }
  } else if (services.env.Brand === 'th') {
    switch (locale) {
      case 'at':
      case 'es':
        return '9,95';
      case 'fi':
        return '9.95';
      case 'ee':
      case 'bg':
      case 'hr':
      case 'hu':
      case 'lv':
      case 'lt':
      case 'ro':
      case 'si':
      case 'sk':
        return '14.95';
      case 'pt':
        return '14.95';
      case 'de':
        return '9,95';
      case 'fr':
      case 'be':
      case 'lu':
        return '12,95';
      case 'ie':
        return '12.95';
      case 'nl':
        return '9,99';
      case 'it':
        return '9,95';
      case 'dk':
        return '99,00';
      case 'se':
        return '139.00';
      case 'pl':
        return '66,90';
      case 'cz':
        return '380,00';
      case 'uk':
        return '9.95';
      default:
        throw new Error(`Shipping costs for locale ${locale} is not supported`);
    }
  }
};
