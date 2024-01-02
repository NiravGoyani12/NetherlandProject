import { Singleton, Inject } from 'typescript-ioc';
import TestCache from '../test-cache';
import DBService from '../services/db.service';

@Singleton
export default class TriggeredEmailsDB extends TestCache {
  constructor(
    @Inject private db: DBService,
  ) {
    super();
  }

  public async getForgotPasswordTriggeredEmails(
    dateToSearchFrom: string, brand: string,
  ): Promise<any> {
    const forgotPasswordEmailIsTriggeredQuery = `select * from B2CEUSWC.XEMAILSTATUS 
    where BRAND = '${brand}'
    and (request_sent_time) >= '${dateToSearchFrom}'
    and xemailtype_id = 
    (select DISTINCT xemailtype_id 
      from B2CEUSWC.XEMAILTYPE 
      where DESCRIPTION = 'SALESFORCE_RESET_PASSWORD_EMAILTYPE') WITH UR`;

    const result = await this.db.query(forgotPasswordEmailIsTriggeredQuery);
    return result;
  }

  public async getOrderConfirmationTriggeredEmails(
    dateToSearchFrom: string, orderId:string, brand: string,
  ): Promise<any> {
    const orderConfirmationEmailIsTriggeredQuery = `select * from B2CEUSWC.XEMAILSTATUS 
    where BRAND = '${brand}'
    and (request_sent_time) >= '${dateToSearchFrom}'
    and ORDERS_ID = ${orderId}
    and xemailtype_id = 
    (select DISTINCT xemailtype_id 
      from B2CEUSWC.XEMAILTYPE 
      where DESCRIPTION = 'SALESFORCE_ORDER_CONFIRMATION_EMAILTYPE') WITH UR`;

    const result = await this.db.query(orderConfirmationEmailIsTriggeredQuery);
    return result;
  }

  public async getRegistrationTriggeredEmails(
    dateToSearchFrom: string, brand: string,
  ): Promise<any> {
    const registrationEmailIsTriggeredQuery = `select * from B2CEUSWC.XEMAILSTATUS 
    where BRAND = '${brand}'
    and (request_sent_time) >= '${dateToSearchFrom}'
    and xemailtype_id = 
    (select DISTINCT xemailtype_id 
      from B2CEUSWC.XEMAILTYPE 
      where DESCRIPTION = 'SALESFORCE_MY_ACCOUNT_EMAILTYPE') WITH UR`;

    const result = await this.db.query(registrationEmailIsTriggeredQuery);
    return result;
  }
}
