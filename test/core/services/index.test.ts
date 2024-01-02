import 'mocha';
import { expect } from 'chai';
import services from '../../../src/core/services';
import { THSiteService } from '../../../src/core/services/site.service';
import DBService from '../../../src/core/services/db.service';
import EnvService from '../../../src/core/services/env.service';
import PageObjectService from '../../../src/core/services/page-object.service';
import ProductService from '../../../src/core/services/product.service';

describe('index', () => {
  it('can get correct services', () => {
    expect(services.env).to.be.an.instanceof(EnvService);
    expect(services.db).to.be.an.instanceof(DBService);
    expect(services.site).to.be.an.instanceof(THSiteService);
    expect(services.pageObject).to.be.an.instanceof(PageObjectService);
    expect(services.product).to.be.an.instanceof(ProductService);
  });
});
