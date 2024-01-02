/* eslint-disable import/no-cycle */
import { p$ } from '../../general';
import OrderConfirmationPage from './order-confirmation-page';
import OverviewPanel from './overview-panel';
import PaymentPage from './payment-page';
import ShippingPage from './shipping-page';
import SignInPage from './sign-in-page';
import OPCSignInPage from './opc-sign-in-page';

const Checkout = {
  SignIn: p$(SignInPage),
  OPCSignIn: p$(OPCSignInPage),
  Shipping: p$(ShippingPage),
  Payment: p$(PaymentPage),
  OrderConfirmation: p$(OrderConfirmationPage),
  Overview: p$(OverviewPanel),
};
export default Checkout;
