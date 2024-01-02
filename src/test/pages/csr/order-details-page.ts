import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';

@Singleton
export default class OrderDetailsPage extends Page {
  public readonly OrderNumberHeader = () => this.derived({
    Desktop: '//h1',
  });

  public readonly OrderDetails = (text?: string) => this.derived({
    Desktop: `//div[contains(@class, "details-box")]//div[contains(@class, "lineItem ") and contains(., "${text ?? ''}")]`,
  });

  public readonly OrderAddress = () => this.derived({
    Desktop: '//div[contains(@class, "addresses")]',
  });

  public readonly OrderItem = () => this.derived({
    Desktop: '//div[contains(@class, "OrderItem")]',
  });

  public readonly OrderPromocodeDetails = () => this.derived({
    Desktop: '//table[contains(@class, "Summary_paymentTable")]//b',
  });

  public readonly OrderItemDetails = (text?: string) => this.derived({
    Desktop: `//div[contains(@class, "OrderItem")]//div[contains(., "${text ?? ''}")]`,
  });

  public readonly ShippingGoodwillBtn = () => this.derived({
    Desktop: '(//div[contains(@class, "payment")]//div[contains(@class, "lineItem lineItem--withCTA")])[1]',
  });

  public readonly OrderGoodwillButton = () => this.derived({
    Desktop: '//div[contains(@class, "MuiPaper-root details-box MuiPaper-elevation1 MuiPaper-rounded")][1]//button',
  });

  public readonly ItemGoodwillButton = () => this.derived({
    Desktop: '//div[contains(@class, "goodwillHeader")]//button[contains(@class, "lineItem__CTA MuiButton-containedPrimary")]',
  });

  public readonly GoodwillRefundTotalTextValue = () => this.derived({
    Desktop: '//table[contains(@class, "goodwillTable")]//tr[1]//td[2]',
  });

  public readonly GoodwillRefundOrderLevelTextValue = () => this.derived({
    Desktop: '//table[contains(@class, "goodwillTable")]//tr[2]//td[2]',
  });

  public readonly GoodwillRefundItemTextValue = (index?: number) => this.derived({
    Desktop: `//div[contains(@class, "OrderItem")]${index ? `[${index}]` : ''}//table[contains(@class, "OrderItem_itemDataTable")]//tr[contains(@class, "lineItem")][8]//td[2]`,
  });

  public readonly MaxItemGoodwillAllowedValue = (index?: number) => this.derived({
    Desktop: `//div[contains(@class, "OrderItem_item")]${index ? `[${index}]` : ''}//table[contains(@class, "OrderItem_itemDataTable")]//tr[contains(@class, "lineItem")][9]//td[2]`,
  });

  public readonly CreditNoteButton = () => this.derived({
    Desktop: '//div[contains(@class, "flex-row")]//a[contains(@href, "/PDFProviderView?type=CreditMemo")]',
  });

  public readonly PPOrderGoodwillButton = () => this.derived({
    Desktop: '//div[contains(@class, "details-box")]//button',
  });

  // #region goodwill
  public readonly GoodwillPopup = (optionText?: string) => this.derived({
    Desktop: `//div[contains(@class, "Goodwill_goodwill") and contains(., "${optionText ?? ''}")]`,
  });

  public readonly GoodwillReasonSelectDropdown = (optionText?: string) => this.derived({
    Desktop: {
      dropdownSelector: '//div[@id="demo-simple-select-outlined"]',
      optionSelector: `//ul//li[contains(., "${optionText || ''}")]`,
    },
  });

  public readonly GoodwillReasonSelectField = () => this.derived({
    Desktop: '//div[@id="demo-simple-select-outlined"]',
  });

  public readonly GoodwillAmountField = () => this.derived({
    Desktop: '//div[contains(@class, "Goodwill_amount")]//input',
  });

  public readonly GoodwillMaxAmountLabel = () => this.derived({
    Desktop: '//div[contains(@class, "Goodwill_amount")]//input',
  });

  public readonly GoodwillPopupConfirmButton = () => this.derived({
    Desktop: '//div[contains(@class, "Goodwill_goodwill")]//button[contains(@class, "confirm")]',
  });

  public readonly GoodwillPopupClose = () => this.derived({
    Desktop: '//div[contains(@class, "Modal_modal")]/*[contains(@class, "closeIcon")]',
  });
  // #endregion
}
