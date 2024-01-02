import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class MyOrdersPage extends Page {
  public readonly NoOrdersMessage = () => this.derived({
    Desktop: '//div[@data-testid="pvh-IconWithText"]//span',
  });

  public readonly OrdersPeriodDropdown = (text: string) => this.derived({
    Desktop: {
      dropdownSelector: '//input[@data-testid="selectOrderFilterInput-inputField"]',
      optionSelector: `//ul[@data-testid="select-component-options-list"]//li[text()="${text}"]`,
    },
    Mobile: {
      dropdownSelector: '//select[@data-testid="selectOrderFilter-native-select"] | //input[@data-testid="selectOrderFilterInput-inputField"]',
      optionSelector: `//select[@data-testid="selectOrderFilter-native-select"]//option[text()="${text}"]`,
    },
  });

  public readonly TableViewToggle = () => this.derived({
    Desktop: '//button[@data-testid="pvh-ToggleButton" and @aria-label="card"]',
  });

  public readonly ListViewToggle = () => this.derived({
    Desktop: '//button[@data-testid="pvh-ToggleButton" and @aria-label="list"]',
  });

  // #region Table view
  public readonly OrderCard = (index?: number) => this.derived({
    Desktop: `(//section[@data-testid="online-order-list"]//article[@data-testid="pvh-order-item"])${index ? `[${index}]` : ''}`,
  });

  public readonly OrderStatus = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="pvh-order-header"])${index ? `[${index}]` : ''}//div[@data-testid="StatusText"]`,
  });

  public readonly OrderNumber = (index?: number) => this.derived({
    Desktop: `(//section[@data-testid="online-order-list"]//div[@class="OrderHeader_orderNumber__Rx0bd"])${index ? `[${index}]` : ''}`,
  });

  public readonly OrderDeliveryStatus = (id: number) => this.derived({
    Desktop: `//div[@id="${id}"]//div[@data-testid="StatusText"]`,
  });

  public readonly OrderEstimatedDelivery = (id: number) => this.derived({
    Desktop: `//div[@id="${id}"]//span[@data-testid="expectedDeliveryDate"]`,
  });

  public readonly OrderDate = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="pvh-order-header"]//span[2])${index ? `[${index}]` : ''}`,
  });

  public readonly TotalPrice = (index?: number) => this.derived({
    Desktop: `(//section[@data-testid="online-order-list"]//span[@data-testid="OrderTotal-PriceDisplay"])${index ? `[${index}]` : ''}`,
  });

  public readonly ProductName = (index?: number) => this.derived({
    Desktop: `(//div[@class="BasketItem_basketTitleWrapper__f3UOh"])${index ? `[${index}]` : ''}`,
  });

  public readonly ProductImage = (index?: number) => this.derived({
    Desktop: `(//div[@class="BasketItem_image__Ikj_6"]//img)${index ? `[${index}]` : ''}`,
  });

  public readonly ProductPrice = (index?: number) => this.derived({
    Desktop: `(//span[@data-testid="OrderListItem-PriceDisplay"])${index ? `[${index}]` : ''}`,
  });

  public readonly ItemDetails = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="basketItem-attribute"])${index ? `[${index}]` : ''}`,
  });

  public readonly ViewOrderButton = (index?: number) => this.derived({
    Desktop: `(//div[@data-testid="order-action"]//a[@data-testid="pvh-button"])${index ? `[${index}]` : ''}`,
  });

  public readonly ViewOrderButtonById = (id: number) => this.derived({
    Desktop: `//a[@data-testid="pvh-button" and contains(@href, "${id}")]`,
  });

  public readonly ViewOrderWithShippedStatus = (index?: number) => this.derived({
    Desktop: `//div[contains(@data-testid,"StatusText") and contains (text(),"shipped")]/../../../../..//a[@data-testid="pvh-button"]${index ? `[${index}]` : ''}`,
  });
  // #endregion

  // #region List view
  public readonly OrderRow = (index?: number) => this.derived({
    Desktop: `//table[@data-testid="pvh-responsive-table"]//tbody//tr${index ? `[${index}]` : ''}`,
  });

  public readonly OrderTableHeader = (index?: number) => this.derived({
    Desktop: `//section[@data-testid="online-order-table"]//table[@data-testid="pvh-responsive-table"]//th${index ? `[${index}]` : ''}`,
  });

  public readonly OrderNumberLink = (index?: number) => this.derived({
    Desktop: `(//section[@data-testid="online-order-table"]//table[@data-testid="pvh-responsive-table"]//td[2])${index ? `[${index}]` : ''}`,
  });

  public readonly OrderPrice = () => this.derived({
    Desktop: '//span[contains(@data-testid, "-PriceDisplay")]',
  });

  public readonly ListOrderStatus = (index: number) => this.derived({
    Desktop: `(//section[@data-testid="online-order-table"]//table[@data-testid="pvh-responsive-table"]//td[4])${index ? `[${index}]` : ''}`,
  });

  public readonly ViewInvoiceLink = () => this.derived({
    Desktop: '//a[contains(@href,"PDFProviderView?type=Invoice")]',
  });

  public readonly ViewCreditNoteLink = () => this.derived({
    Desktop: '//a[contains(@href,"PDFProviderView?type=Credit")]',
  });
  // #endregion

  public readonly LoadMoreButton = (index?: number) => this.derived({
    Desktop: `(//button[@data-testid="pvh-button" and contains(@class,"LoadMore")])${index ? `[${index}]` : ''}`,
  });

  public readonly StartShoppingButton = () => this.derived({
    Desktop: '//button[@data-testid="empty-orders-pvh-button"]',
  });
}
