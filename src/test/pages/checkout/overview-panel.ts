import { Singleton } from 'typescript-ioc';
import { Page } from '../../page';
import services from '../../../core/services';
import { exist$ } from '../../general';

@Singleton
export default class OverviewPanel extends Page {
  // #region Promocodes
  public readonly EnterPromoCodeButton = () => this.derived({
    Desktop: '//button[@data-testid="add-promo-link"]',
  });

  public readonly PromoCodeField = () => this.derived({
    Desktop: '//input[@data-testid="promocode-apply-inputField"]',
  });

  public readonly PromoCodeApplyButton = () => this.derived({
    Desktop: '//button[@data-testid="promocode-apply-pvh-button"]',
  });

  public readonly PromoCodeRemoveButton = () => this.derived({
    Desktop: '//button[@data-testid="promocode-removeButton"]',
  });

  public readonly PromoCodePriceInfo = () => this.derived({
    Desktop: '//span[@data-testid="BasketOverview-Discount-PriceText"]',
  });

  public readonly PromoCodeText = () => this.derived({
    Desktop: '//span[@data-testid="BasketOverview-PromoCodeText"]',
  });

  public readonly DiscountLabel = () => this.derived({
    Desktop: '//span[@data-testid="BasketOverview-DiscountLabel"]',
  });

  public readonly DiscountBanner = () => this.derived({
    Desktop: '//div[contains(@data-testid, "single-line-form")]',
  });

  public readonly DiscountBannerText = () => this.derived({
    Desktop: '//div[contains(@data-testid, "single-line-form")]/span/p',
  });

  public readonly DiscountBannerLink = () => this.derived({
    Desktop: '//div[contains(@data-testid, "single-line-form")]/span/p/strong',
  });
  // #endregion

  // #region Order Overview
  public readonly SubTotalPriceInfo = () => this.derived({
    Desktop: '//span[@data-testid="BasketOverview-SubTotal-PriceText"]',
  });

  public readonly ShippingMethod = () => this.derived({
    Desktop: '//div[@data-testid="BasketOverview-DeliveryMethodText"]',
  });

  public readonly ShippingTime = () => this.derived({
    Desktop: '//span[@data-testid="BasketOverview-DeliveryTimeText"]',
  });

  public readonly ShippingPrice = () => this.derived({
    Desktop: '//span[@data-testid="BasketOverview-Shipping-PriceText"]',
  });

  public readonly TotalPriceInfo = () => this.derived({
    Desktop: '//span[@data-testid="BasketOverview-GrandTotal-PriceText"]',
  });
  // #endregion

  public async ApplyPromoCode(promoCode: string, key: string, skipButton: boolean) {
    if (!skipButton) {
      await (await exist$(this.EnterPromoCodeButton())).safeClick();
    }
    await (await exist$(this.PromoCodeField())).safeType(promoCode);
    await (await exist$(this.PromoCodeApplyButton())).safeClick();
    const removePromo = await exist$(this.PromoCodeRemoveButton() as string);
    const isClickAble = await removePromo.waitForClickable({
      timeout: 12000,
      interval: 500,
    }).catch(() => false);

    if (isClickAble) {
      try {
        await exist$(this.PromoCodePriceInfo());
        let discountPrice = await (await exist$(this.PromoCodePriceInfo())).getText();
        discountPrice = discountPrice.replace(/[^0-9.,]/g, '').replace(',', '.'); // leave only digits and .,
        discountPrice = discountPrice.replace(/\D+$/g, ''); // remove all characters after last digit - can be .,
        services.world.store(key, discountPrice);
      } catch (error) {
        throw new Error(`Promo code was not applied because: ${error}`);
      }
    } else {
      throw new Error('Remove promo code button was not clickable');
    }
  }
}
