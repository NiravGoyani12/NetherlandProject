/* eslint-disable no-await-in-loop */
import {
  When, TableDefinition, Then,
} from '@pvhqa/cucumber';
import services from '../../../core/services';
import Payment from '../../pages/payments';
import Checkout from '../../pages/checkout';

When(/in payment page I fill in the credit card details/, async (table: TableDefinition) => {
  await Payment.CreditCard.fillInCardDetails(table);
});

When(/in payment page I fill in the Bancontact details/, async (table: TableDefinition) => {
  await Payment.CreditCard.fillInBancontactDetails(table);
});

When(/in payment page I fill in the save card CVV details "(.*)"/, async (text: string) => {
  await Payment.CreditCard.fillInCVV(text);
});

When(/in payment page I fill in the gift card details/, async (table: TableDefinition) => {
  await Payment.GiftCard.fillInGiftCardDetails(table);
});

When(/with user "(.*)" and password "(.*)" I complete 3DS1 payment/, async (user: string, password: string) => {
  await Payment.CreditCard.fillIn3DS1Details(user, password);
});

When(/in 3DS2 pop-up I fill in the Adyen password "(.*)"/, async (text: string) => {
  await Payment.CreditCard.fillIn3DS2Password(text);
});

When(/in (paypal|ideal|Przelewy24|PendingPrzelewy24) I complete payment(?: for locale ([^\s]+))?/, async (paymentType: string, locale?: string) => {
  if (paymentType === 'paypal') {
    const email = `pvh.${locale ? locale.toLowerCase() : services.site.locale}.automation@gmail.com`;
    await Payment.Paypal.Pay(email, 'pvhtesting1');
  } else if (paymentType === 'ideal') {
    await Payment.Ideal.Pay();
  } else if (paymentType === 'PendingPrzelewy24') {
    await Payment.Przelewy24.PendingPay();
  } else if (paymentType === 'Przelewy24') {
    await Payment.Przelewy24.Pay();
  } else {
    throw new Error(`Payment method ${paymentType} not implemented.`);
  }
});

When(/I use paypal payment to compelte payment for SAP orders/, async () => {
  await Payment.Paypal.Pay('pvh.sap_user@outlook.com', 'AutoNation2023');
});

When(/^in klarna I complete payment for scenario (Positive|Negative|Instalments|NoInstalments|[^\s]+)/, async (scenario: string) => {
  if (scenario === 'Positive') {
    await Payment.Klarna.Pay('Positive');
  } else if (scenario === 'Negative') {
    await Payment.Klarna.Pay('Negative');
  } else if (scenario === 'Instalments') {
    await Payment.Klarna.Pay('Instalments');
  } else if (scenario === 'NoInstalments') {
    await Payment.Klarna.Pay('NoInstalments');
  } else {
    throw new Error('Klarna not implemented.');
  }
});

When(/in (paypal|Przelewy24|klarna) I cancel payment/, async (paymentType: string) => {
  if (paymentType === 'paypal') {
    await Payment.Paypal.CancelPay();
  } else if (paymentType === 'Przelewy24') {
    await Payment.Przelewy24.CancelPay();
  } else if (paymentType === 'klarna') {
    await Payment.Klarna.CancelPay();
  } else {
    throw new Error(`Payment method ${paymentType} not implemented.`);
  }
});

When(/I select paypal express and get to paypal login/, async () => {
  await Payment.PaypalExpress.PayWithPaypalExpress();
});

// #region Unified Payment Page
When(/I add (first|new|other|giftCardFirst) billing details(:? for different country "(.*)")?/, async (actionType: string, differentCountry?: string) => {
  await Checkout.Payment.AddBillingAddress(actionType, differentCountry);
});

When(/I select "(.*)" as my billing country$/, async (billingCountry: string) => {
  await Checkout.Payment.SelectBillingCountry(billingCountry);
});

Then(/I check that my billing details(:? with index "(.*)")? have been saved(:? for country "(.*)")?/, async (index?: number, country?: string) => {
  await Checkout.OrderConfirmation.CheckAddressDetails('billing', index, country);
});

When(/I select paypal payment and go to paypal layover/, async () => {
  await Checkout.Payment.PayWithPaypal();
});

When(/I set T&C checkbox to (true|false) if XCOMREG is enabled/, async (value: string) => {
  await Checkout.Payment.SetTermsCheckbox(value);
});
// #endregion
