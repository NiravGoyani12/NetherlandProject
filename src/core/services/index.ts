import { Container } from 'typescript-ioc';
import PageObjectService from './page-object.service';
import EnvService from './env.service';
import DBService from './db.service';
import DriverFactoryService from './driver-factory.service';
import AllureService from './allure.service';
import AccountService from './account.service';
import { CKSiteService, THSiteService, SiteService } from './site.service';
import ProductService from './product.service';
import WorldService from './world.service';
import ChromiumService from './chromium.service';
import OthersDB from '../db/others-db';
import TriggeredEmailsDB from '../db/emails-db';
import ManiPulateCartItemsDB from '../db/manipulate-cart-items-db';
import TranslationService from './translation.service';
import PageObjectStrategyService from './page-object-strategy.service';
import CsrAccountService from './csr-account.service';
import CsrSearchDataService from './csr-search-data.service';
import XoWidgetService from './xo-widget.service';
import TransformersService from './transformers.service';
import BrowserstackService from './browserstack.service';
import SlackService from './slack.service';
import CheckoutDataService from './checkout-data.service';
import CheckoutAddressService from './checkout-address.service';
import TranslationLokaliseService from './translation-lokalise.service';
import EmailMsOutLookService from './email-ms-outlook.service';

const env = Container.get(EnvService);
const pageObjectStragety = Container.get(PageObjectStrategyService);
const db = Container.get(DBService);
if (process.env.Brand === 'ck') {
  Container.bind(SiteService).to(CKSiteService);
} else {
  Container.bind(SiteService).to(THSiteService);
}
const site = Container.get(SiteService);
const pageObject = Container.get(PageObjectService);
const product = Container.get(ProductService);
const othersDB = Container.get(OthersDB);
const triggeredEmailsDB = Container.get(TriggeredEmailsDB);
const maniPulateCartItemsDB = Container.get(ManiPulateCartItemsDB);
const account = new AccountService();
const drivers = new DriverFactoryService();
const allure = new AllureService();
const world = new WorldService();
const chromium = new ChromiumService();
const translation = new TranslationService();
const csraccount = new CsrAccountService();
const csrsearchdata = new CsrSearchDataService();
const xowidget = Container.get(XoWidgetService);
const transformers = Container.get(TransformersService);
const browserstackService = new BrowserstackService();
const slackService = new SlackService();
const checkoutdata = new CheckoutDataService();
const checkoutaddress = new CheckoutAddressService();
const translationLokalise = new TranslationLokaliseService();
const emailMsOutlook = new EmailMsOutLookService();
const services = {
  env,
  pageObject,
  pageObjectStragety,
  db,
  account,
  drivers,
  allure,
  site,
  product,
  world,
  // country,
  chromium,
  othersDB,
  triggeredEmailsDB,
  maniPulateCartItemsDB,
  translation,
  csraccount,
  csrsearchdata,
  xowidget,
  transformers,
  browserstackService,
  slackService,
  checkoutdata,
  checkoutaddress,
  translationLokalise,
  emailMsOutlook,
};

export default services;
