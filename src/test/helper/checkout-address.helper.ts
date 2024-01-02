/* eslint-disable dot-notation */
import services from '../../core/services';

export interface AddressDetails {
  Line1: string
  Line2: string
  Line3: string
  Line4: string
  Line5?: string
  Line6?: string
  Line7?: string
}
export interface AddressErrorDetails {
  error0?: string
  error1: string
  error2: string
  error3: string
  error4: string
  error5?: string
  error6?: string
  error7?: string
}

export function getOrderAddress(index?: number, locale?: string) {
  const countryInfo = (locale === undefined)
    ? services.checkoutaddress.getCountryDetails(services.site.locale)
    : services.checkoutaddress.getCountryDetails(locale);
  const currentAddress = (index >= 0 && index !== undefined && index !== null)
    ? services.checkoutaddress.getAddressByIndex(index)
    : services.checkoutaddress.getLatestCheckoutAddress();
  const count = countryInfo['addressLinesCount'];
  const lines = [];
  const addressLines = [];

  for (let i = 1; i < count; i += 1) {
    lines[i] = `line${i}`;
  }

  lines.forEach((l) => {
    const lineFormat = countryInfo[l];
    if (lineFormat.indexOf('+') >= 0) {
      const splitted = lineFormat.split('+');
      const addressLine = `${currentAddress[splitted[0]]} ${currentAddress[splitted[1]]}`;
      addressLines.push(addressLine);
    } else {
      addressLines.push(currentAddress[countryInfo[l]]);
    }
  });

  const orderConfirmationAddress: AddressDetails = {
    Line1: addressLines[0],
    Line2: addressLines[1],
    Line3: addressLines[2],
    Line4: addressLines[3],
    Line5: addressLines[4],
    Line6: addressLines[5],
    Line7: addressLines[6],
  };
  return orderConfirmationAddress;
}

export function getAddressErrors(errorType: string, locale: string, userType: string) {
  locale = locale.toUpperCase();
  const countryErrors = services.checkoutaddress.getCountryErrorDetails(locale, errorType);
  let index = (userType === 'guest') ? 0 : 1;
  let errorCount = services.checkoutaddress.getCountryErrorCount(locale, errorType, userType);
  errorCount = (userType === 'guest') ? 'mandatoryFieldsCount' : 'invalidErrorsCount';
  const errors = [];
  const errorMessages = [];

  for (index; index < errorCount; index += 1) {
    errors[index] = `error${index}`;
  }

  errors.forEach((e) => {
    errorMessages.push(countryErrors[e]);
  });

  const addressErrors: AddressErrorDetails = {
    error0: errorMessages[0],
    error1: errorMessages[1],
    error2: errorMessages[2],
    error3: errorMessages[3],
    error4: errorMessages[4],
    error5: errorMessages[5],
    error6: errorMessages[6],
    error7: errorMessages[7],
  };

  return addressErrors;
}
