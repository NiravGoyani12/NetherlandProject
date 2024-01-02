import * as currencyFormatter from 'currency-formatter';
import services from '../../core/services';

/* eslint-disable import/prefer-default-export */
export const formatCurrency = (value: number, currency: string) => {
  switch (currency) {
    case 'GBP':
      return currencyFormatter.format(value, { code: 'GBP' });
    case 'CHF':
      return `${currencyFormatter.format(value, { code: 'CHF', decimal: ',' }).replace(/\s+/g, ' ').replace('CHF ', '')} CHF`;
    case 'EUR':
      if (services.site.locale.toLowerCase() === 'nl') {
        return `€ ${currencyFormatter.format(value, { code: 'EUR' }).replace('€', '').trim().replace(/\s+/g, ' ')}`;
      }
      if (services.site.locale.toLowerCase() === 'sk' || services.site.locale.toLowerCase() === 'ee') {
        return `€${currencyFormatter.format(value, { code: 'EUR', decimal: '.' }).replace('€', '').trim().replace(/\s+/g, '')}`;
      }
      return currencyFormatter.format(value, { code: 'EUR' }).replace('€', '€').replace(/\s+/g, ' ');
    case 'CZK':
      return `${currencyFormatter.format(value, { code: 'CZK', decimal: ',' }).replace(/\s+/g, ' ')}`;
    case 'SEK':
      return `SEK${currencyFormatter.format(value, { code: 'SEK', decimal: '.' }).replace('kr', '').trim().replace(/\s+/g, ' ')}`;
    case 'PLN':
      return currencyFormatter.format(value, { code: 'PLN' }).replace(/\s+/g, ' ').toLocaleUpperCase();
    case 'DKK':
      return `KR${currencyFormatter.format(value, { code: 'DKK', decimal: '.', thousand: ',' }).replace(/.$/g, '').replace('kr', '').replace(/\s+/g, ' ')
        .trim()}`;
    default:
      throw new Error(`Do not support currency ${currency}`);
  }
};

/* returns RegEx with expected price format for each locale */
export const getPriceFormat = (locale: string) => {
  switch (locale) {
    case 'at':
    case 'de':
    case 'be':
    case 'es':
    case 'fr':
    case 'lu':
    case 'it':
      return /\d+,\d{2} €/;
    case 'nl':
      return /€ \d+,\d{2}/;
    case 'ie':
    case 'fi':
    case 'pt':
    case 'sk':
      return /€\d+\.\d{2}/;
    case 'bg':
    case 'hr':
    case 'ee':
    case 'hu':
    case 'lv':
    case 'lt':
    case 'ro':
    case 'si':
      return /€\d+\.\d{2}/;
    case 'dk':
    case 'se':
      return /\d+\.\d{2} [kK][rR]/;
    case 'pl':
      return /\d+,\d{2} [zZ][łŁ]/;
    case 'cz':
      return /\d+ K[čČ]/;
    case 'ch':
      return /\d+,\d{2} CHF/;
    // case 'ru':
    //   return /\d+ \d+ ₽/;
    case 'uk':
      return /£\d+/;
    default:
      throw new Error(`Price format for locale ${locale} is not supported`);
  }
};
