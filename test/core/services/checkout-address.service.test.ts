import { expect } from 'chai';
import fs from 'fs';
import 'mocha';
import { SetUpTestlogger } from '../../../src/core/logger/test.logger';
import CheckoutAddressService from '../../../src/core/services/checkout-address.service';

describe('Checkout Address Service Tests', () => {
  let shippingAdressService: CheckoutAddressService;

  before(async () => {
    await fs.promises.mkdir('./output/test', { recursive: true });
    SetUpTestlogger('./output/test/test.log', 'info');
    shippingAdressService = new CheckoutAddressService();
  });

  beforeEach(async () => {
    shippingAdressService.cleanUp();
  });

  it('can create new shipping address', () => {
    expect(() => shippingAdressService.provideNewAddress('UK')).to.not.throw();
  });

  it('raise error when country is null for new shipping address', () => {
    expect(() => shippingAdressService.provideNewAddress('')).to.throw('The locale cannot be null!');
  });

  it('can create default shipping address', () => {
    expect(() => shippingAdressService.provideDefaultAddress('NL')).to.not.throw();
  });

  it('raise error when country is null for default shipping address', () => {
    expect(() => shippingAdressService.provideDefaultAddress('')).to.throw('The locale cannot be null!');
  });

  it('can add multiple new shipping addresses', () => {
    expect(() => shippingAdressService.provideNewAddress('PL')).to.not.throw();
    expect(() => shippingAdressService.provideNewAddress('SI')).to.not.throw();
    expect(() => shippingAdressService.provideNewAddress('SK')).to.not.throw();
    expect(() => shippingAdressService.provideNewAddress('CH')).to.not.throw();
  });

  it('can add multiple default shipping addresses', () => {
    expect(() => shippingAdressService.provideNewAddress('IT')).to.not.throw();
    expect(() => shippingAdressService.provideNewAddress('AT')).to.not.throw();
    expect(() => shippingAdressService.provideNewAddress('EE')).to.not.throw();
    expect(() => shippingAdressService.provideNewAddress('LU')).to.not.throw();
  });

  it('can clean up shipping addresses', () => {
    shippingAdressService.provideDefaultAddress('BE');
    shippingAdressService.provideDefaultAddress('DE');
    const shippingAdress = shippingAdressService.getLatestCheckoutAddress();
    expect(shippingAdress).to.not.be.empty;
    expect(shippingAdress.email).to.equal('pvh.qa.automation@gmail.com');
    shippingAdressService.cleanUp();
    expect(() => shippingAdressService.getLatestCheckoutAddress()).to.throw('No addresses have been generated');
  });

  it('can get first shipping address when index is not provided', () => {
    shippingAdressService.provideNewAddress('IE');
    const shippingAdress = shippingAdressService.getLatestCheckoutAddress();
    expect(shippingAdress).to.not.be.empty;
    expect(shippingAdress.email).to.be.length(36);
    expect(shippingAdress.email).to.contain('pvh.qa.automation+');
    expect(shippingAdress.firstname).to.be.length(8);
    expect(shippingAdress.lastname).to.be.length(10);
    expect(shippingAdress.address).to.be.length(12);
    expect(shippingAdress.addition).to.be.length(3);
    expect(shippingAdress.city).to.be.length(6);
    expect(shippingAdress.province).to.equal('Guiness');
    expect(shippingAdress.postcode).to.equal('K67 C3V1');
    expect(shippingAdress.phone).to.be.undefined;
  });

  it('can get shipping address when index is provided', () => {
    shippingAdressService.provideDefaultAddress('FR');
    shippingAdressService.provideDefaultAddress('LT');
    const shippingAdress = shippingAdressService.getAddressByIndex(1);
    expect(shippingAdress).to.not.be.empty;
    expect(shippingAdress.email).to.equal('pvh.qa.automation@gmail.com');
    expect(shippingAdress.firstname).to.equal('Boris');
    expect(shippingAdress.lastname).to.equal('Bear');
    expect(shippingAdress.address).to.equal('Vodkalane');
    expect(shippingAdress.addition).to.equal('14 A');
    expect(shippingAdress.city).to.equal('Smirnov');
    expect(shippingAdress.province).to.equal('Kauno');
    expect(shippingAdress.postcode).to.equal('08200');
    expect(shippingAdress.phone).to.be.undefined;
  });

  it('raise error when index does not exist for shipping address', () => {
    shippingAdressService.provideNewAddress('ES');
    shippingAdressService.provideNewAddress('SE');
    shippingAdressService.provideNewAddress('CZ');
    expect(() => shippingAdressService.getAddressByIndex(4)).to.throw('The index cannot be bigger than the size of the list!');
  });

  it('can get country info', () => {
    const checkoutDataRetrieved = shippingAdressService.getCountryDetails('FI');
    expect(checkoutDataRetrieved.line1).to.equal('firstname+lastname');
    expect(checkoutDataRetrieved.line2).to.equal('address');
    expect(checkoutDataRetrieved.line3).to.equal('addition');
    expect(checkoutDataRetrieved.line4).to.equal('postcode');
    expect(checkoutDataRetrieved.line5).to.equal('city+province');
    expect(checkoutDataRetrieved.line6).to.equal('country');
    expect(checkoutDataRetrieved.line7).to.equal('phone');
    expect(checkoutDataRetrieved.province).to.equal('Oulu');
    expect(checkoutDataRetrieved.postcode).to.equal('00100');
    expect(checkoutDataRetrieved.newpostcode).to.equal('14680');
    expect(checkoutDataRetrieved.phone).to.equal('0401234567');
    expect(checkoutDataRetrieved.country).to.equal('Finland');
  });

  it('can get multiple country info', () => {
    const checkoutDataRetrieved1 = shippingAdressService.getCountryDetails('DE');
    const checkoutDataRetrieved2 = shippingAdressService.getCountryDetails('HR');
    const checkoutDataRetrieved3 = shippingAdressService.getCountryDetails('DK');
    const checkoutDataRetrieved4 = shippingAdressService.getCountryDetails('PT');
    expect(checkoutDataRetrieved1.province).to.be.undefined;
    expect(checkoutDataRetrieved1.postcode).to.equal('10178');
    expect(checkoutDataRetrieved1.line2).to.equal('address+addition');
    expect(checkoutDataRetrieved1.phone).to.be.undefined;
    expect(checkoutDataRetrieved2.province).to.equal('Istria');
    expect(checkoutDataRetrieved2.line5).to.equal('city+province');
    expect(checkoutDataRetrieved2.newpostcode).to.equal('21000');
    expect(checkoutDataRetrieved2.phone).to.be.undefined;
    expect(checkoutDataRetrieved3.province).to.equal('Østsjælland');
    expect(checkoutDataRetrieved3.postcode).to.equal('2450');
    expect(checkoutDataRetrieved3.line4).to.equal('postcode');
    expect(checkoutDataRetrieved3.phone).to.equal('+45 33 23 29 29');
    expect(checkoutDataRetrieved4.province).to.equal('Azores');
    expect(checkoutDataRetrieved4.postcode).to.equal('1069-081');
    expect(checkoutDataRetrieved4.line4).to.equal('city+province');
    expect(checkoutDataRetrieved4.phone).to.be.undefined;
  });

  it('can get country error info', () => {
    const mandatoryErrorDataRetrieved = shippingAdressService.getCountryErrorDetails('PL', 'mandatory');
    const invalidErrorDataRetrieved = shippingAdressService.getCountryErrorDetails('PL', 'invalid');
    expect(mandatoryErrorDataRetrieved.error0).to.equal('E-mail jest wymagany.');
    expect(mandatoryErrorDataRetrieved.error1).to.equal('Imię jest wymagane.');
    expect(mandatoryErrorDataRetrieved.error2).to.equal('Nazwisko jest wymagane.');
    expect(mandatoryErrorDataRetrieved.error3).to.equal('Adres 1 jest wymagany.');
    expect(mandatoryErrorDataRetrieved.error4).to.equal('Miejscowość jest wymagana.');
    expect(mandatoryErrorDataRetrieved.error5).to.equal('Kod pocztowy jest wymagany.');
    expect(invalidErrorDataRetrieved.error0).to.equal('Przepraszamy, to nie wygląda jak adres e-mail');
    expect(invalidErrorDataRetrieved.error1).to.equal('Podaj swoje imię');
    expect(invalidErrorDataRetrieved.error2).to.equal('Podaj swoje nazwisko');
    expect(invalidErrorDataRetrieved.error3).to.equal('Podaj nazwę miejscowości/miasta');
    expect(invalidErrorDataRetrieved.error4).to.equal('Nieprawidłowe województwo – musi spełniać zasady potwierdzenia');
    expect(invalidErrorDataRetrieved.error5).to.equal('Wpisz prawidłowy kod pocztowy (np. 12-123)');
  });

  it('can get multiple country error info', () => {
    const mandatoryErrorDataRetrieved = shippingAdressService.getCountryErrorDetails('NL', 'mandatory');
    const invalidErrorDataRetrieved = shippingAdressService.getCountryErrorDetails('LV', 'invalid');
    expect(mandatoryErrorDataRetrieved.error0).to.equal('E-mail is verplicht.');
    expect(mandatoryErrorDataRetrieved.error1).to.equal('Voornaam is verplicht.');
    expect(mandatoryErrorDataRetrieved.error2).to.equal('Achternaam is verplicht.');
    expect(mandatoryErrorDataRetrieved.error3).to.equal('Straat is verplicht.');
    expect(mandatoryErrorDataRetrieved.error4).to.equal('Huisnummer is verplicht.');
    expect(mandatoryErrorDataRetrieved.error5).to.equal('Plaats is verplicht.');
    expect(mandatoryErrorDataRetrieved.error6).to.equal('Postcode is verplicht.');
    expect(invalidErrorDataRetrieved.error0).to.equal('Sorry, that doesn\'t look like an email address');
    expect(invalidErrorDataRetrieved.error1).to.equal('Please fill in your first name');
    expect(invalidErrorDataRetrieved.error2).to.equal('Please fill in your last name');
    expect(invalidErrorDataRetrieved.error3).to.equal('Please fill in your town/city');
    expect(invalidErrorDataRetrieved.error4).to.equal('Invalid Province / County / (Region / Area) - must be within validation rules');
    expect(invalidErrorDataRetrieved.error5).to.equal('Please enter a valid postcode (e.g. 1234)');
  });

  it('raise error when country is null when retrieving country info', () => {
    expect(() => shippingAdressService.getCountryDetails('')).to.throw('The locale cannot be null!');
  });

  it('raise error when key does not exists when retrieving country info', () => {
    expect(() => shippingAdressService.getCountryDetails('KJ')).to.throw('Cannot get Country info with key KJ');
  });

  it('can get country info when parameter is in lower case', () => {
    const checkoutDataRetrieved = shippingAdressService.getCountryDetails('it');
    expect(checkoutDataRetrieved.country).to.equal('Italy');
    expect(checkoutDataRetrieved.postcode).to.equal('20151');
    expect(checkoutDataRetrieved.newpostcode).to.equal('20019');
    expect(checkoutDataRetrieved.line3).to.equal('addition');
  });

  it('can get address size 0 when no address has been added', () => {
    expect(() => shippingAdressService.getAddressSize()).to.not.throw();
    expect(shippingAdressService.getAddressSize()).to.equal(0);
  });

  it('can get address size', () => {
    shippingAdressService.provideDefaultAddress('FR');
    shippingAdressService.provideDefaultAddress('LT');
    expect(shippingAdressService.getAddressSize()).to.equal(2);
  });

  it('can get count for country specific errors as a guest', () => {
    const mandatoryCheckoutErrorCount = shippingAdressService.getCountryErrorCount('BE', 'mandatory', 'guest');
    const invalidCheckoutErrorCount = shippingAdressService.getCountryErrorCount('SE', 'invalid', 'guest');
    expect(mandatoryCheckoutErrorCount).to.equal(6);
    expect(invalidCheckoutErrorCount).to.equal(7);
  });

  it('can get count for country specific errors as a logged in user', () => {
    const mandatoryCheckoutErrorCount = shippingAdressService.getCountryErrorCount('PL', 'mandatory', 'logged in');
    const invalidCheckoutErrorCount = shippingAdressService.getCountryErrorCount('AT', 'invalid', 'logged in');
    expect(mandatoryCheckoutErrorCount).to.equal(5);
    expect(invalidCheckoutErrorCount).to.equal(4);
  });

  it('cannot get count for country specific errors for inexisting locale', () => {
    expect(() => shippingAdressService.getCountryErrorCount('BEE', 'invalid', 'logged in')).to.throw('Cannot get Country info with key BEE');
  });

  it('cannot get count for country specific errors for empty locale', () => {
    expect(() => shippingAdressService.getCountryErrorCount('', 'invalid', 'user')).to.throw('The locale cannot be null!');
  });
});
