import { p$ } from '../../general';
import CreditCardPage from './credit-card-page';
import Przelewy24Page from './Przelewy24-page';
import IdealPage from './ideal-page';
import KlarnaPage from './klarna-page';
import PayPalPage from './paypal-page';
import PayPalExpressPage from './paypal-express-page';
import GiftCardPage from './gift-card-page';


const Payment = {
  CreditCard: p$(CreditCardPage),
  Ideal: p$(IdealPage),
  Paypal: p$(PayPalPage),
  Klarna: p$(KlarnaPage),
  Przelewy24: p$(Przelewy24Page),
  PaypalExpress: p$(PayPalExpressPage),
  GiftCard: p$(GiftCardPage),
};
export default Payment;
