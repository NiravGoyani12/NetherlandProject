import { p$ } from '../../general';
import FindInStorePopup from './find-in-store-popup';
import GiftCardsPage from './gift-cards-page';
import Header from './header';
import NotifyMePopup from './notify-me-popup';
import Pdp from './pdp';

const ProductDetailPage = {
  Pdp: p$(Pdp),
  Header: p$(Header),
  NotifyMePopup: p$(NotifyMePopup),
  FindInStorePopup: p$(FindInStorePopup),
  GiftCardsPage: p$(GiftCardsPage),
};
export default ProductDetailPage;
