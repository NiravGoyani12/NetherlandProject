import { Container } from 'typescript-ioc';
import DBService from '../../../src/core/services/db.service';
import { wrongQuery, correctQuery, hardQuery } from '../../utils/db-query';
import EnvService from '../../../src/core/services/env.service';
import { SetUpSimpleTestLogger } from '../../../src/core/logger/test.logger';
import services from '../../../src/core/services';


const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');

chai.use(chaiAsPromised);
const { expect } = chai;


describe('DB service', () => {
  before(() => {
    SetUpSimpleTestLogger();
    process.env.DatabaseName = 'uat-prod';
  });

  it('should be able to query and connection closed', async () => {
    const dbService = new DBService(new EnvService());
    const result: Array<any> = await dbService.query(correctQuery);
    expect(result).lengthOf(1);
    expect(dbService.isDBClosed).to.be.true;
  });

  it('should raise exception when query failed and connection colsed', async () => {
    const dbService = new DBService(new EnvService());
    await expect(dbService.query(wrongQuery)).to.be.rejectedWith(Error);
    expect(dbService.isDBClosed).to.be.true;
  });

  it('should be able to query with multiple connection of multiple instance', async () => {
    const db1 = new DBService(new EnvService());
    const db2 = new DBService(new EnvService());
    const db3 = new DBService(new EnvService());
    const db4 = new DBService(new EnvService());
    const db5 = new DBService(new EnvService());
    const db6 = new DBService(new EnvService());
    const db7 = new DBService(new EnvService());
    const db8 = new DBService(new EnvService());
    const results = await Promise.all([
      db1.query(hardQuery),
      db2.query(hardQuery),
      db3.query(hardQuery),
      db4.query(hardQuery),
      db5.query(hardQuery),
      db6.query(hardQuery),
      db7.query(hardQuery),
      db8.query(hardQuery),
    ]);
    expect(results).lengthOf(8);
    expect(db1.isDBClosed).to.be.true;
    expect(db2.isDBClosed).to.be.true;
    expect(db3.isDBClosed).to.be.true;
    expect(db4.isDBClosed).to.be.true;
    expect(db5.isDBClosed).to.be.true;
    expect(db6.isDBClosed).to.be.true;
    expect(db7.isDBClosed).to.be.true;
    expect(db8.isDBClosed).to.be.true;
  });

  it('should be able to query with multiple connection of single instance', async () => {
    Container.bind(EnvService).to(EnvService);
    const dbService = new DBService(new EnvService());
    const results = await Promise.all([
      dbService.query(hardQuery),
      dbService.query(hardQuery),
      dbService.query(hardQuery),
      dbService.query(hardQuery),
      dbService.query(hardQuery),
      dbService.query(hardQuery),
      dbService.query(hardQuery),
      dbService.query(hardQuery),
    ]);
    expect(results).lengthOf(8);
    expect(dbService.isDBClosed).to.be.true;
  });

  it('can connect to uat-prod databases', async () => {
    process.env.DatabaseName = 'uat-prod';
    const dbService = new DBService(new EnvService());
    expect(services.env.Database).not.to.be.empty;
    const result: Array<any> = await dbService.query(correctQuery);
    expect(result).lengthOf(1);
    expect(dbService.isDBClosed).to.be.true;
  });

  it('can connect to uat-stag database', async () => {
    process.env.DatabaseName = 'uat-stag';
    const dbService = new DBService(new EnvService());
    expect(services.env.Database).not.to.be.empty;
    const result: Array<any> = await dbService.query(correctQuery);
    expect(result).lengthOf(1);
    expect(dbService.isDBClosed).to.be.true;
  });

  it('can connect to systest-prod database', async () => {
    process.env.DatabaseName = 'systest-prod';
    const dbService = new DBService(new EnvService());
    expect(services.env.Database).not.to.be.empty;
    const result: Array<any> = await dbService.query(correctQuery);
    expect(result).lengthOf(1);
    expect(dbService.isDBClosed).to.be.true;
  });

  it('can connect to systest-stag database', async () => {
    process.env.DatabaseName = 'systest-stag';
    const dbService = new DBService(new EnvService());
    expect(services.env.Database).not.to.be.empty;
    const result: Array<any> = await dbService.query(correctQuery);
    expect(result).lengthOf(1);
    expect(dbService.isDBClosed).to.be.true;
  });

  xit('can connect to db1-live database', async () => {
    process.env.DatabaseName = 'db1-live';
    const dbService = new DBService(new EnvService());
    expect(services.env.Database).not.to.be.empty;
    const result: Array<any> = await dbService.query(correctQuery);
    expect(result).lengthOf(1);
    expect(dbService.isDBClosed).to.be.true;
  });

  xit('can connect to db1-stag database', async () => {
    process.env.DatabaseName = 'db1-stag';
    const dbService = new DBService(new EnvService());
    expect(services.env.Database).not.to.be.empty;
    const result: Array<any> = await dbService.query(correctQuery);
    expect(result).lengthOf(1);
    expect(dbService.isDBClosed).to.be.true;
  });

  it('can connect to db0-live database', async () => {
    process.env.DatabaseName = 'db0-live';
    const dbService = new DBService(new EnvService());
    expect(services.env.Database).not.to.be.empty;
    const result: Array<any> = await dbService.query(correctQuery);
    expect(result).lengthOf(1);
    expect(dbService.isDBClosed).to.be.true;
  });

  it('can connect to db0-stag database', async () => {
    process.env.DatabaseName = 'db0-stag';
    const dbService = new DBService(new EnvService());
    expect(services.env.Database).not.to.be.empty;
    const result: Array<any> = await dbService.query(correctQuery);
    expect(result).lengthOf(1);
    expect(dbService.isDBClosed).to.be.true;
  });

  it('can connect to sit-prod database', async () => {
    process.env.DatabaseName = 'sit-prod';
    const dbService = new DBService(new EnvService());
    expect(services.env.Database).not.to.be.empty;
    const result: Array<any> = await dbService.query(correctQuery);
    expect(result).lengthOf(1);
    expect(dbService.isDBClosed).to.be.true;
  });

  it('can connect to sit-stag database', async () => {
    process.env.DatabaseName = 'sit-stag';
    const dbService = new DBService(new EnvService());
    expect(services.env.Database).not.to.be.empty;
    const result: Array<any> = await dbService.query(correctQuery);
    expect(result).lengthOf(1);
    expect(dbService.isDBClosed).to.be.true;
  });

  xit('can connect to preprod-live database', async () => {
    process.env.DatabaseName = 'preprod-live';
    const dbService = new DBService(new EnvService());
    expect(services.env.Database).not.to.be.empty;
    const result: Array<any> = await dbService.query(correctQuery);
    expect(result).lengthOf(1);
    expect(dbService.isDBClosed).to.be.true;
  });

  xit('can connect to preprod-stag database', async () => {
    process.env.DatabaseName = 'preprod-stag';
    const dbService = new DBService(new EnvService());
    expect(services.env.Database).not.to.be.empty;
    const result: Array<any> = await dbService.query(correctQuery);
    expect(result).lengthOf(1);
    expect(dbService.isDBClosed).to.be.true;
  });

  after(() => {
    process.env.DatabaseName = 'uat-prod';
  });
});
