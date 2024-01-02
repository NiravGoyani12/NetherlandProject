import randomstring from 'randomstring';
import addressData from '../json/checkout-address-format.json';
import addressErrorData from '../json/checkout-address-errors.json';
import { GetTestLogger } from '../logger/test.logger';

export interface CheckoutAddress {
  email: string
  firstname: string
  lastname: string
  address: string
  addition?: string
  city: string
  province?: string
  postcode: string
  phone?: string
  country: string
}

export interface AddressFormat {
  addressLinesCount: number
  line1: string
  line2: string
  line3: string
  line4: string
  line5?: string
  line6?: string
  line7?: string
  province?: string
  phone?: string
  postcode: string
  newpostcode: string
  country: string
}

export interface AddressErrorFormat {
  error0: string
  error1: string
  error2: string
  error3: string
  error4: string
  error5?: string
  error6?: string
  error7?: string
}

const defaultEmail = 'pvh.qa.automation@gmail.com';
const defaultFirstname = 'Boris';
const defaultLastname = 'Bear';
const defaultAddress = 'Vodkalane';
const defaultAddition = '14 A';
const defaultCity = 'Smirnov';

export default class CheckoutAddressService {
  private addresses: Array<CheckoutAddress>;

  private countryInfo;

  private countryErrorInfo;

  constructor() {
    this.addresses = [];
    this.countryInfo = addressData;
    this.countryErrorInfo = addressErrorData;
  }

  public cleanUp() {
    this.addresses = [];
  }

  public provideNewAddress(locale: string) {
    if (!locale) {
      throw new Error('The locale cannot be null!');
    }
    const email = randomstring.generate(8);
    const country = this.getCountryDetails(locale);
    const firstName = randomstring.generate({ length: 8, charset: 'alphabetic', capitalization: 'lowercase' });
    const lastName = randomstring.generate({ length: 10, charset: 'alphabetic', capitalization: 'lowercase' });
    const address: CheckoutAddress = {
      email: `pvh.qa.automation+${email}@gmail.com`.toLowerCase(),
      firstname: firstName.charAt(0).toUpperCase() + firstName.slice(1),
      lastname: lastName.charAt(0).toUpperCase() + lastName.slice(1),
      address: randomstring.generate({ length: 12 }),
      addition: randomstring.generate(3),
      city: randomstring.generate({ length: 6, charset: 'alphabetic' }),
      province: country.province,
      postcode: country.postcode,
      phone: country.phone,
      country: country.country,
    };
    this.addresses.push(address);
  }

  public provideDefaultAddress(locale: string) {
    if (!locale) {
      throw new Error('The locale cannot be null!');
    }
    const country = this.getCountryDetails(locale);
    const address: CheckoutAddress = {
      email: defaultEmail,
      firstname: defaultFirstname,
      lastname: defaultLastname,
      address: defaultAddress,
      addition: defaultAddition,
      city: defaultCity,
      province: country.province,
      postcode: country.postcode,
      phone: country.phone,
      country: country.country,
    };
    this.addresses.push(address);
  }

  public getLatestCheckoutAddress() {
    if (!this.getAddressSize()) {
      throw new Error('No addresses have been generated');
    }
    const index = this.getAddressSize();
    return this.addresses[index - 1];
  }

  public getAddressSize() {
    return this.addresses.length;
  }

  public getAddressByIndex(index: number) {
    const addressesLength = this.getAddressSize();
    if (!addressesLength) {
      throw new Error('No addresses have been generated');
    } else if (index > addressesLength) {
      throw new Error('The index cannot be bigger than the size of the list!');
    }
    return this.addresses[index];
  }

  public getCountryDetails(locale: string) {
    if (!locale) {
      throw new Error('The locale cannot be null!');
    }

    const key = `${locale.toLocaleUpperCase()}`;
    if (!this.countryInfo[key]) {
      throw new Error(`Cannot get Country info with key ${key}`);
    }

    const countryFormat: AddressFormat = {
      addressLinesCount: this.countryInfo[key].addressLinesCount,
      line1: this.countryInfo[key].line1,
      line2: this.countryInfo[key].line2,
      line3: this.countryInfo[key].line3,
      line4: this.countryInfo[key].line4,
      line5: this.countryInfo[key].line5,
      line6: this.countryInfo[key].line6,
      line7: this.countryInfo[key].line7,
      province: this.countryInfo[key].province,
      phone: this.countryInfo[key].phone,
      postcode: this.countryInfo[key].postcode,
      newpostcode: this.countryInfo[key].newpostcode,
      country: this.countryInfo[key].country,
    };

    GetTestLogger().info(`Country info: ${key} - Value: ${this.countryInfo[key]}`);
    return countryFormat;
  }

  public getCountryErrorCount(locale: string, errorType: string, userType: string) {
    let errorCategory: string;

    if (!locale) {
      throw new Error('The locale cannot be null!');
    }

    const key = `${locale.toLocaleUpperCase()}`;
    if (!this.countryErrorInfo[key]) {
      throw new Error(`Cannot get Country info with key ${key}`);
    }

    switch (errorType) {
      case 'mandatory':
        errorCategory = 'mandatoryFieldsCount';
        break;
      case 'invalid':
        errorCategory = 'invalidErrorsCount';
        break;
      default:
        throw Error('No such error type exists for checkout address!');
    }

    let errorCount = this.countryErrorInfo[key][errorCategory];

    if (userType === 'guest') {
      errorCount += 1;
    }

    return errorCount;
  }

  public getCountryErrorDetails(locale: string, errorType: string) {
    let errorCategory: string;

    if (!locale) {
      throw new Error('The locale cannot be null!');
    }

    const key = `${locale.toLocaleUpperCase()}`;
    if (!this.countryErrorInfo[key]) {
      throw new Error(`Cannot get Country info with key ${key}`);
    }

    switch (errorType) {
      case 'mandatory':
        errorCategory = 'mandatoryErrors';
        break;
      case 'invalid':
        errorCategory = 'invalidErrors';
        break;
      default:
        throw Error('No such error type exists for checkout address!');
    }

    const countryErrorFormat: AddressErrorFormat = {
      error0: this.countryErrorInfo[key][errorCategory].error0,
      error1: this.countryErrorInfo[key][errorCategory].error1,
      error2: this.countryErrorInfo[key][errorCategory].error2,
      error3: this.countryErrorInfo[key][errorCategory].error3,
      error4: this.countryErrorInfo[key][errorCategory].error4,
      error5: this.countryErrorInfo[key][errorCategory].error5,
      error6: this.countryErrorInfo[key][errorCategory].error6,
      error7: this.countryErrorInfo[key][errorCategory].error7,
    };

    return countryErrorFormat;
  }
}
