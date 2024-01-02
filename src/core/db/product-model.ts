export interface Product {
  STYLE_ID: number // Product
  STYLE_PARTNUMBER: string // Product
  STYLECOLOUR_ID: number // Color
  STYLECOLOUR_PARTNUMBER: string // Color
  SKU_ID: number // Size
  SKU_PARTNUMBER: string // Size
}

export type Products = Array<Product>;
export type PlusSizeIdentifiers = Array<PlusSizeIdentifier>;
export type SkuPartNumber = string;
export type StyleColourPartNumber = string;
export type StylePartNumber = string;

export interface ProductItemDetail {
  STYLE_PARTNUMBER: string
  STYLECOLOUR_PARTNUMBER: string
  SKU_PARTNUMBER: string
  QUANTITY: number
  CURRENCY: string
  CURRENTPRICE: number
  WASPRICE: number
  SIZE_NAME?: string
  LENGTH_NAME?: string
  WIDTH_NAME?: string
  COLOUR_NAME?: string
}

export interface ProductListAttribute {
  SKU_PARTNUMBER: string
  NAME: string
  CURRENT_PRICE: number
  WASPRICE: number
  MAIN_COLOUR: string
  SIZE: string
}

export interface ProductStyleDetail {
  STYLE_PARTNUMBER: string
  STYLECOLOUR_PARTNUMBER: string
  QUANTITY: number
  NAME: string
  ANALYTICS_NAME: string
  DIVISION: string
  LIST: string
  GBPC: string
  ANALYTICS_MAIN_COLOUR: string,
  MAIN_COLOUR: string,
  COLOUR_NAME: string
  PRODUCT_ITEM_DICT: Map<SkuPartNumber, ProductItemDetail>
}

export interface ProductDetail {
  STYLE_PARTNUMBER: string
  QUANTITY: number
  PRODUCT_STYLE_DICT: Map<StyleColourPartNumber, ProductStyleDetail>
}

export interface DetailTemp {
  STYLE_PARTNUMBER: string
  STYLECOLOUR_PARTNUMBER: string
  SKU_PARTNUMBER: string
  QUANTITY: number
  NAME: string
  ANALYTICS_NAME: string
  DIVISION: string,
  LIST_PRIMARY: string,
  LIST_ALTERNATE: string,
  GBPC: string,
  ANALYTICS_MAIN_COLOUR: string,
  MAIN_COLOUR: string,
  CURRENCY: string
  CURRENTPRICE: number
  WASPRICE: number
  IDENTIFIER: string
  STRINGVALUE: string
  LOCAL_VALUE: string
  DEFAULT_LOCAL_VALUE: string
}

export interface XCOMREG {
  NAME: string
  VALUE: string
  OVERRIDE_VALUE: string|null
}

export interface CTXMGMT {
  CALLER_ID: string
  STATUS: string
  LASTACCESSTIME: Date
}

export interface ShippingPromoThreshold {
  THRESHOLD: number
}

export interface SEOUrl {
  URL: string
  ADMINNAME: string
}

export interface RedirectSEOUrl {
  PRODUCTURL: string,
  PRIMARYCATEGORYURL: string,
}

export interface PlusSizeIdentifier {
  IDENTIFIER: string,
}
