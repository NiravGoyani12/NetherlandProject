/* eslint-disable no-else-return */
/* eslint-disable no-console */
import { Singleton, Inject } from 'typescript-ioc';
import DBService from '../services/db.service';
import { SiteService } from '../services/site.service';
import { GetTestLogger } from '../logger/test.logger';
import TestCache from '../test-cache';

@Singleton
export default class ManiPulateCartItemsDB extends TestCache {
  constructor(
    @Inject private db: DBService,
    @Inject private site: SiteService,
  ) {
    super();
  }

  public async checkIfUserHasItemsInCart(): Promise<boolean> {
    const locale = this.site.locale.toLowerCase();
    const email = `pvh.${locale}.automation@outlook.com`;

    // query that checks if a registered automation user's cart has any items
    const checkIfCartIsEmptyQuery = `SELECT * FROM B2CEUSWC.ORDERS
                     WHERE MEMBER_ID IN
                     (SELECT USERS_ID FROM B2CEUSWC.USERS
                     WHERE DN LIKE '%${email}%') 
                     AND B2CEUSWC.ORDERS.STATUS='P';`;

    const result: Array<any> = await this.db.query(checkIfCartIsEmptyQuery);

    if (result && result.length > 0) {
      GetTestLogger().info(`User ${result.length} has items in his shopping bag`);
      return true;
    }
    GetTestLogger().info(`User ${email} has no items in his shopping bag`);
    return false;
  }

  // query that removes a registered automation user's items from the cart, if they has any
  public async clearItemsFromSB(email: string): Promise<any> {
    const checkBasketForItems = await this.checkIfUserHasItemsInCart();

    const updateShoppingBagQuery = `UPDATE B2CEUSWC.ORDERS 
                         SET STATUS = 'X'
                         WHERE MEMBER_ID IN (
                         SELECT USERS_ID FROM B2CEUSWC.USERS
                         WHERE DN LIKE '%${email}%') 
                         AND B2CEUSWC.ORDERS.STATUS='P';`;

    if (checkBasketForItems) {
      try {
        await this.db.query(updateShoppingBagQuery);
        GetTestLogger().info(`Remove items from cart Query was executed successfully for user ${email}`);
        const checkAgain = await this.checkIfUserHasItemsInCart();
        if (!checkAgain) {
          GetTestLogger().info(`Update query for user ${email} was done successfully!`);
        } else {
          GetTestLogger().info(`Update query for user ${email} was NOT done successfully!`);
        }
      } catch (error) {
        throw new Error(error);
      }
    }
    GetTestLogger().info(`User ${email} has no items in his shopping bag`);
  }

  public async getItemInventory(skuPartNumber: string): Promise<number> {
    const getSkuInventory = `SELECT QUANTITY FROM B2CEUSWC.INVENTORY
                             WHERE CATENTRY_ID in (SELECT CATENTRY_ID FROM
                             B2CEUSWC.CATENTRY WHERE PARTNUMBER='${skuPartNumber}')`;

    const result: Array<any> = await this.db.query(getSkuInventory);
    return Number(result[0].QUANTITY);
  }

  // this method is to modify the quantity of an item for testing
  public async setItemInventory(skuPartNumber: string, qty: number): Promise<any> {
    const currentQty = await this.getItemInventory(skuPartNumber);
    const setSkuInventory = `UPDATE B2CEUSWC.INVENTORY SET QUANTITY=${qty}
                             WHERE CATENTRY_ID in (SELECT CATENTRY_ID FROM
                             B2CEUSWC.CATENTRY WHERE PARTNUMBER='${skuPartNumber}')`;
    if (qty === currentQty) {
      GetTestLogger().info('The quantiy you are trying to update is the same as the current one!');
      return;
    } else {
      await this.db.query(setSkuInventory);
      GetTestLogger().info(`Update inventory query for item ${skuPartNumber} executed successfully!`);
    }
    const newQty = await this.getItemInventory(skuPartNumber);

    GetTestLogger().info(`Item ${skuPartNumber} now has inventory ${newQty}`);
  }

  public async getPromoCodeStatus(promocode: string): Promise<number> {
    const getPromoStatusQuery = `SELECT STATUS FROM B2CEUSWC.PX_PROMOTION
                                 WHERE CODE = '${promocode}'`;

    const result: Array<any> = await this.db.query(getPromoStatusQuery);
    return Number(result[0].STATUS);
  }

  public async setPromoCodeStatus(promocode: string, status: number): Promise<any> {
    const currentStatus = await this.getPromoCodeStatus(promocode);
    const changePromoStatus = `UPDATE B2CEUSWC.PX_PROMOTION SET STATUS = ${status} WHERE CODE = '${promocode}'`;

    if (currentStatus === status) {
      switch (status) {
        case 0:
          GetTestLogger().info('Code is already deactivated!');
          break;
        case 1:
        default:
          GetTestLogger().info('Code is already activated!');
      }
    } else {
      await this.db.query(changePromoStatus);

      const updatedStatus = await this.getPromoCodeStatus(promocode);

      if (updatedStatus === status) {
        GetTestLogger().info('Successfully updated promocode!');
      } else {
        throw new Error(`Promocode status was not updated correctly. Current status is ${updatedStatus}`);
      }
    }
  }
}
