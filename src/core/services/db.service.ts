import * as db2 from 'ibm_db';
import { Options } from 'ibm_db';
import { Inject } from 'typescript-ioc';
import EnvService from './env.service';
import { GetTestLogger } from '../logger/test.logger';

export default class DBService {
  constructor(@Inject private env: EnvService) {
    // Set charset to UTF-8
    process.env.DB2CODEPAGE = '1208';
  }

  public isDBClosed :boolean;

  public dbConnectionOptions: Options = {
    connectTimeout: 20, // connect db timeout is 5 seconds
  };

  public async query(sql: string): Promise<any> {
    this.isDBClosed = false;
    let database: db2.Database;
    let result: any;
    let err : any;
    try {
      database = await db2.open(this.env.Database, this.dbConnectionOptions);
      this.logger.info('DB Client opened session');
      result = await database.query(sql);
    } catch (e) {
      err = e;
      this.logger.error(`DB query failed because ${e}`);
    }
    if (database) {
      database.closeSync();
      this.logger.info('DB Client has been closed successfully');
      this.isDBClosed = true;
    }
    if (err) {
      throw err;
    }
    return result;
  }

  private get logger() { return GetTestLogger(); }
}
