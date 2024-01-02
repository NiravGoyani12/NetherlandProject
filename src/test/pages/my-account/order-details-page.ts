import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class OrdersDetailsPage extends Page {
  public readonly BackToOrdersPageLink = () => this.derived({
    Desktop: '//a[@class="Link_Link__H_TIr OrderDetails_backLink__SG5dR"]',
  });

  public readonly OrderDetailsMessage = () => this.derived({
    Desktop: '//p[@data-testid="page-subtitle"]',
  });

  public readonly OrderEstimatedDelivery = () => this.derived({
    Desktop: '//span[@data-testid="expectedDeliveryDate"]',
  });

  public readonly OrderNumber = () => this.derived({
    Desktop: '//div[contains(@id,"order-number")]',
  });

  // #region Progress stepper
  public readonly OrderPlacedStep = () => this.derived({
    Desktop: '//li[@data-testid="progress-stepper-step-ot_order_placed-0"]//button',
  });

  public readonly SubStatus = () => this.derived({
    Desktop: '//li[@data-testid="transition"]',
  });

  public readonly OrderStatus = () => this.derived({
    Desktop: '//div[@data-testid="pvh-order-header"]//div[@data-testid="StatusText"]',
  });

  public readonly ShippedStep = () => this.derived({
    Desktop: '//li[@data-testid="progress-stepper-step-ot_order_shipped-1"]',
  });

  public readonly TrackingId = () => this.derived({
    Desktop: '//span[contains(@class, "copy_to_clipboard_copy_to_clipboard")]',
  });

  public readonly TrackingIdCopyButton = () => this.derived({
    Desktop: '//*[@data-testid="order-tracking-id-copy-to-clipboard-copy-icon"]',
  });

  public readonly TrackingIdCopyedMessage = () => this.derived({
    Desktop: '//span[@id="copy-success-alert-content"]',
  });

  public readonly OutForDeliveryStep = () => this.derived({
    Desktop: '//li[@data-testid="progress-stepper-step-ot_order_scheduleddelivery-2"]',
  });

  public readonly OrderDelayedSubStatus = () => this.derived({
    Desktop: '//li[@data-testid="progress-stepper-step-ot_order_delayeddeliverytobedeliveredsoon-3"]//div[contains(@class, "ProgressStepper_description")]',
  });

  public readonly WeMissedYouSubStatus = () => this.derived({
    Desktop: '//li[@data-testid="progress-stepper-step-ot_order_faileddeliveryfutureattempt-3"]//div[contains(@class, "ProgressStepper_description")]',
  });

  public readonly ReadyForPickUpStep = () => this.derived({
    Desktop: '//li[@data-testid="progress-stepper-step-ot_order_deliveredatpickuppoint-3"]',
  });

  public readonly OrderRefusedStep = () => this.derived({
    Desktop: '//li[@data-testid="progress-stepper-step-ot_order_refuseddeliveryfuturereturntosender-3"]',
  });

  public readonly DeliveredStep = () => this.derived({
    Desktop: '//li[@data-testid="progress-stepper-step-ot_order_successfuldelivery-3"] | //li[@data-testid="progress-stepper-step-ot_order_successfuldelivery-4"]',
  });

  public readonly CollectedStep = () => this.derived({
    Desktop: '//li[@data-testid="progress-stepper-step-ot_order_successfuldeliveryatpickuppoint-4"]',
  });

  public readonly OrderCancelationHeader = () => this.derived({
    Desktop: '//section[@data-testid="OrderInfoView-cancelOrder"]/*[@id="order-orderdetails-title"]',
  });

  public readonly OrderCancelationSubtitle = () => this.derived({
    Desktop: '//section[@data-testid="OrderInfoView-cancelOrder"]/*[@data-testid="typography-p"]',
  });

  public readonly CancelOrderButton = () => this.derived({
    Desktop: '//button[@data-testid="cancel-order-pvh-button"]',
  });

  public readonly KeepButton = () => this.derived({
    Desktop: '//div[contains(@class,"Modal_Children")]//button[@data-testid="pvh-button"]',
  });

  public readonly CancelButton = () => this.derived({
    Desktop: '//div[contains(@class,"Modal_Children")]//button[@data-testid="pvh-button"][2]',
  });

  public readonly OrderCancelationWarning = () => this.derived({
    Desktop: '//span[@data-testid="cancel-order-pvh-dialog-subtitle"]',
  });

  public readonly OrderNotCollectedStep = () => this.derived({
    Desktop: '//li[@data-testid="progress-stepper-step-ot_order_failedpickupfuturereturntosender-4"]',
  });

  public readonly StepChevron = () => this.derived({
    Desktop: '//section[@data-testid="OrderTracking-component"]//*[@data-testid="icon-utility-chevron-down-svg"]',
  });
  // #endregion

  public readonly TrackParcelButton = () => this.derived({
    Desktop: '//a[contains(@class, "OrderTracking_button")]',
  });

  public readonly OrderDetails = (text?: string) => this.derived({
    Desktop: `//section[@data-testid="OrderInfoView-orderAttributes"]//span${text ? `[text()="${text}"]` : ''}`,
  });

  public readonly OrderProductName = () => this.derived({
    Desktop: '//section[@data-testid="pvh-order-basket-items"]//span[contains(@class,"BasketItem_basketTitle")]',
  });

  public readonly OrderOverview = (text?: string) => this.derived({
    Desktop: `//section[@data-testid="pvh-order-basket-items"]//span${text ? `[text()="${text}"]` : ''}`,
  });

  public readonly PriceInfoSection = (text?: string) => this.derived({
    Desktop: `//section[@data-testid="OrderInfoView-pricingOverview"]//span${text ? `[text()="${text}"]` : ''}`,
  });

  public readonly ShippingAddress = () => this.derived({
    Desktop: '//section[@data-testid="OrderInfoView-addresses"]//div[@class="OrderInfo_address__yUv5E"][1]',
  });

  public readonly BillingAddress = () => this.derived({
    Desktop: '//section[@data-testid="OrderInfoView-addresses"]//div[@class="OrderInfo_address__yUv5E"][2]',
  });

  public readonly DownloadInvoiceButton = () => this.derived({
    Desktop: '//a[contains(@class, "OrderInfo_button__Mv5")]',
  });

  public readonly CreditNoteLink = () => this.derived({
    Desktop: '//section[@data-testid="OrderInfoView-creditNotes"]//div[@class="OrderInfo_creditNoteLinks__W0zX7"]',
  });

  public readonly ReturnItemButton = () => this.derived({
    Desktop: '//a[@data-testid="pvh-button"]',
  });

  public readonly ReturnText = () => this.derived({
    Desktop: '//div[@data-testid="pvh-card"]//p[@data-testid="typography-p"]',
  });

  public readonly FAQButton = () => this.derived({
    Desktop: '//a[@data-testid="order-details-read-more-pvh-button"]',
  });

  // #region Guest order tracking
  public readonly OrderInput = () => this.derived({
    Desktop: '//input[@data-testid="orderId-inputField"]',
  });

  public readonly PostCodeInput = () => this.derived({
    Desktop: '//input[@data-testid="postCode-inputField"]',
  });

  public readonly ViewOrderButton = () => this.derived({
    Desktop: '//button[@data-testid="guest-order-form-submit-pvh-button"]',
  });

  public readonly PostCodeError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-postCode"]',
  });

  public readonly OrderError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error-orderId"]',
  });

  public readonly SearchOrderError = () => this.derived({
    Desktop: '//div[@data-testid="alert-error"]',
  });

  public readonly SignIn = () => this.derived({
    Desktop: '//span[contains(@class, "GuestOrder_signIn")]',
  });

  // #endregion
}
