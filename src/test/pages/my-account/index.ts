import { p$ } from '../../general';
import UMASignInPopUp from './sign-in-pop-up';
import UMARegisterPopUp from './register-pop-up';
import UMAMyDetailsPage from './my-details-page';
import UMAMyOrdersPage from './my-orders-page';
import UMANotificationsPage from './notifications-page';
import UMAOrdersDetailsPage from './order-details-page';
import UMAAddressPage from './address-page';
import UMANewsletterSubscription from './newsletter-subscription';

const MyAccount = {
  SignInPopUp: p$(UMASignInPopUp),
  RegisterPopUp: p$(UMARegisterPopUp),
  MyDetailsPage: p$(UMAMyDetailsPage),
  MyOrdersPage: p$(UMAMyOrdersPage),
  NotificationsPage: p$(UMANotificationsPage),
  OrdersDetailsPage: p$(UMAOrdersDetailsPage),
  AddressPage: p$(UMAAddressPage),
  NewsletterSubscription: p$(UMANewsletterSubscription),
};
export default MyAccount;
