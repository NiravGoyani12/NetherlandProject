import { Inject } from 'typescript-ioc';
import EnvService from './env.service';
import DBService from './db.service';
import { SiteService } from './site.service';
import ProductItem from '../db/product-item';
import ProductStyle from '../db/product-style';
import ProductParser from '../db/product-parser';
import Product from '../db/product';

export default class ProductService {
  private _parser:ProductParser = new ProductParser();

  private _product: Product;

  private _productItem : ProductItem;

  private _productStyle : ProductStyle;

  constructor(
    @Inject private env: EnvService,
    @Inject private db: DBService,
    @Inject private site: SiteService,
  ) {
    this._productItem = new ProductItem(this.env, this.db, this.site, this._parser);
    this._productStyle = new ProductStyle(this.env, this.db, this.site, this._parser);
    this._product = new Product(this.env, this.db, this.site, this._parser);
  }

  get productItem() {
    return this._productItem;
  }

  get productStyle() {
    return this._productStyle;
  }

  get product() {
    return this._product;
  }

  public parse(text: string) {
    return this._parser.parse(text);
  }

  get productCount() {
    return this._parser.productCount;
  }

  get lastAddedProduct() {
    return this._parser.productList[this._parser.productList.length - 1];
  }

  public cleanUp() {
    this.productItem.details.clear();
    this.productStyle.details.clear();
    this.product.details.clear();
    this._parser.clean();
  }
}
