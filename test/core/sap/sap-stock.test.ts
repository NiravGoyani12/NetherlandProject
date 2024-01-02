/* eslint-disable max-len */
// /* eslint-disable max-len */
// import 'mocha';
// import { expect } from 'chai';
// import { SetUpSimpleTestLogger } from '../../../src/core/logger/test.logger';
// import { getRandomSapInStockProductItems, getSpecificSapInStockProductItems } from '../../../src/core/sap/product-item-stock';
// import DBService from '../../../src/core/services/db.service';
// import EnvService from '../../../src/core/services/env.service';
// import { thSapQuery, ckSapQuery } from '../../utils/db-query';
// import { Products } from '../../../src/core/db/product-model';

// describe('SAP items with stock', () => {
//   before(() => {
//     SetUpSimpleTestLogger();
//   });

//   it('SAP can return TH random product items with stock', async () => {
//     const eans = await getRandomSapInStockProductItems('th', 10);
//     expect(eans.length).to.eql(250);
//     expect(eans[0]).to.be.a('string');
//   });

//   it('SAP can return CK random product items with stock', async () => {
//     const eans = await getRandomSapInStockProductItems('ck', 10);
//     expect(eans.length).to.eql(250);
//     expect(eans[0]).to.be.a('string');
//   });

//   // TODO uncomment when SAP and WCs stock are in sync
//   it('SAP can return TH specific product items with stock', async () => {
//     const dbService = new DBService(new EnvService());
//     const dbResults: Products = await dbService.query(thSapQuery);
//     // eslint-disable-next-line @typescript-eslint/no-unused-vars
//     const sapEanList = await getSpecificSapInStockProductItems('th', 100, dbResults
//       .map((r) => r.SKU_PARTNUMBER));
//     // expect(sapEanList.length).to.be.greaterThan(1);
//     // expect(dbResults.findIndex((r) => r.SKU_PARTNUMBER === sapEanList[0]) >= 0).to.be.true;
//     // expect(dbResults.findIndex((r) => r.SKU_PARTNUMBER === sapEanList[sapEanList.length - 1]) >= 0)
//     //   .to.be.true;
//     // expect(sapEanList[0]).to.be.a('string');
//   });

//   it('SAP can return CK specific product items with stock', async () => {
//     const dbService = new DBService(new EnvService());
//     const dbResults: Products = await dbService.query(ckSapQuery);
//     // eslint-disable-next-line @typescript-eslint/no-unused-vars
//     const sapEanList = await getSpecificSapInStockProductItems('ck', 100, dbResults
//       .map((r) => r.SKU_PARTNUMBER));
//     // expect(sapEanList.length).to.be.greaterThan(1);
//     // expect(dbResults.findIndex((r) => r.SKU_PARTNUMBER === sapEanList[0]) >= 0).to.be.true;
//     // expect(dbResults.findIndex((r) => r.SKU_PARTNUMBER === sapEanList[sapEanList.length - 1]) >= 0)
//     //   .to.be.true;
//     // expect(sapEanList[0]).to.be.a('string');
//   });
// });
