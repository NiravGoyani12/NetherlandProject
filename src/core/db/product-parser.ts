import { Products, Product } from './product-model';

export default class ProductParser {
  private products : Array<Product>;

  get productCount() {
    return this.products.length;
  }

  get productList() {
    return this.products;
  }

  constructor() {
    this.products = [];
  }

  public save(products: Products) {
    this.products.push(...products);
  }

  public clean() {
    this.products = [];
  }

  public parse(text: string): string {
    const items = text.split(',');
    return items.map((item) => {
      if (item.startsWith('product') && item.indexOf('#') > 0) {
        const parts = item.split('#');
        if (parts.length !== 2) {
          return item;
        }
        const index = Number(parts[0].replace('product', ''));
        if (Number.isNaN(index)) {
          return item;
        }
        if (index > this.products.length) {
          throw new Error(`The product index is out side of range, the stored products length is ${this.products.length}, but you asked ${index}`);
        }
        const product = this.products[index - 1];
        switch (parts[1]) {
          case 'styleId':
            return product.STYLE_ID;
          case 'stylePartNumber':
            return product.STYLE_PARTNUMBER;
          case 'styleColourId':
            return product.STYLECOLOUR_ID;
          case 'styleColourPartNumber':
            return product.STYLECOLOUR_PARTNUMBER;
          case 'skuId':
            return product.SKU_ID;
          case 'skuPartNumber':
            return product.SKU_PARTNUMBER;
          default:
            throw new Error(`Cannot parse the key ${parts[1]}`);
        }
      } else {
        return item;
      }
    }).join(',');
  }
}
