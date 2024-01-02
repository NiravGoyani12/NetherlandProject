import { p$ } from '../../general';
import Header from './header';
import Footer from './footer';
import CookieNotice from './cookie-notice';
import Wishlist from './wishlist';
import ShoppingBag from './shopping-bag';
import ShoppingBagToast from './shopping-bag-toast';
import AddToBagPopUp from './add-to-bag-pop-up';
import MiniShoppingBag from './mini-shopping-bag';
import FaqsPage from './faqs-page';
import PlpFilters from './plp-filters';
import PlpHeader from './plp-header';
import PlpNosearch from './plp-nosearch';
import PlpPagination from './plp-pagination';
import PlpProducts from './plp-products';
import HeaderSearchSuggestion from './search-suggestion-panel';
import Breadcrumbs from './breadcrumbs';
import CountrySwitchFlyout from './country-switch-flyout';

const Experience = {
  Header: p$(Header),
  Footer: p$(Footer),
  Cookie: p$(CookieNotice),
  Wishlist: p$(Wishlist),
  ShoppingBag: p$(ShoppingBag),
  ShoppingBagToast: p$(ShoppingBagToast),
  AddToBagPopUp: p$(AddToBagPopUp),
  MiniShoppingBag: p$(MiniShoppingBag),
  FaqsPage: p$(FaqsPage),
  PlpProducts: p$(PlpProducts),
  PlpFilters: p$(PlpFilters),
  PlpHeader: p$(PlpHeader),
  PlpNosearch: p$(PlpNosearch),
  PlpPagination: p$(PlpPagination),
  SearchSuggestion: p$(HeaderSearchSuggestion),
  Breadcrumbs: p$(Breadcrumbs),
  CountrySwitchFlyout: p$(CountrySwitchFlyout),
};
export default Experience;
